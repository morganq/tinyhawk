function get_cell(v)
    local x,z = v[1]\1, v[3]\1
    if map[x] and map[x][z] then
        return map[x][z]
    end
end

block_aabb = {0, 1, 0, 1, 0, 1}
tall_aabb = {0, 1, 0, 2, 0, 1}

block_planes = {
    {pt = {-0.5, 0, 0}, normal = {-1, 0, 0}},
    {pt = {0.5, 0, 0},  normal = {1, 0, 0}},
    {pt = {0, 0, -0.5}, normal = {0, 0, -1}},
    {pt = {0, 0, 0.5},  normal = {0, 0, 1}},
    {pt = {0, 1, 0},    normal = {0, 1, 0}},
}

ramp_planes = {
    {pt = {-0.5, 0, 0}, normal = {-1, 0, 0}},
    {pt = {0, 0.245, 0}, normal = v_norm({1, 1, 0})},
}    

qp_planes = {
    {pt = {-0.5, 0, 0}, normal = {-1, 0, 0}},
    --{pt = {0, 0, -0.5}, normal = {0, 0, -1}},
    --{pt = {0, 0, 0.5},  normal = {0, 0, 1}},        
}
local steps = 8
local stepsize = 1 / (steps + 1) * 3.14159 / 2
for i = 0, steps + 1 do
    local angle = i * stepsize
    local y = cos(angle)
    local x = sin(angle)
    add(qp_planes, {pt = {0.49 - x * 0.97, (1-y) * 1.99, 0}, normal = v_norm({x, y, 0})})
end


function in_aabb(pt, aabb)
    local x, y, z = unpack(pt)
    local px1, px2, py1, py2, pz1, pz2 = unpack(aabb)
    return x >= px1 and x <= px2 and y >= py1 and y <= py2 and z >= pz1 and z <= pz2
end

function find_first_collision(pt, vel, planes)
    local nearest, nt = nil, 999999
    local next_pt = v_add(pt, vel)
    for plane in all(planes) do
        local delta = v_sub(next_pt, plane.pt)
        local dot = v_dot(delta, plane.normal)
        if dot < 0 then -- normal and delta are facing opposite directions
            
            local vel_proj = abs(v_dot(vel, plane.normal))
            local overlap_proj = abs(v_dot(delta, plane.normal))
            local t = 1 - (overlap_proj / vel_proj)
            if t >= 0 and t < 1 and t < nt then
                local new_pt = v_add(pt, v_mul(vel, t))
                if in_aabb(new_pt, plane.aabb) then
                    nearest = plane
                    nt = t
                end
            end
        end
    end
    return nearest, nt
end

function rotate(v, fliph, flipv)
    if fliph then
        return {v[3], v[2], v[1]}
    end
    return v
end

function prepare_collision_planes(cells)
    local planes = {}
    for cell in all(cells) do
        local tt = cell.tiletype
        for p in all(tt.planes) do
            local offset = {cell.x + 0.5, cell.elev, cell.z + 0.5}
            local x1,x2,y1,y2,z1,z2 = unpack(tt.aabb)
            -- todo: rotation
            local new_plane = {
                normal = rotate(p.normal, cell.fliph, cell.flipv),
                pt = v_add(rotate(p.pt, cell.fliph, cell.flipv), offset),
                aabb = {x1 + cell.x, x2 + cell.x, y1, y2 + cell.elev, y1 + cell.z, y2 + cell.z},
            }
            add(planes, new_plane)
        end
    end
    return planes
end

function find_ground(pt)
    --for y = h, 0, -1 do
    --    local cell = map
    --end
    local cell = get_cell(pt)
    if cell then
        local down = {0, -pt[2], 0}
        local nearest, nt = find_first_collision(pt, down, prepare_collision_planes({cell}))
        if nearest then
            return v_add(pt, v_mul(down, nt))
        end
    end
    return {pt[1], 0, pt[3]}
    
end

function collide_point_planes(pt, vel, planes)
    -- Find first collision, then adjust pos and vel,
    -- then repeat until no more collisions

    if #planes == 0 then
        return v_add(pt, vel), vel
    end

    local new_pt = v_copy(pt)
    local new_vel = v_copy(vel)
    local done = false
    local e = 0.1
    local eps = 0.1
    while not done do
        local nearest, nt = find_first_collision(new_pt, new_vel, planes)
        if nearest then
            new_pt = v_add(new_pt, v_mul(new_vel, nt - eps))
            local d = v_dot(new_vel, nearest.normal)
            local j = max((1 + e) * -d, 0);
            new_vel = v_add(new_vel, v_mul(nearest.normal, j))
        else
            done = true
            new_pt = v_add(new_pt, new_vel)
        end
    end
    
    return new_pt, new_vel
end