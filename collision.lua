function get_cell(v)
    local x,z = v[1]\1, v[3]\1
    if map[x] and map[x][z] then
        return map[x][z]
    end
end

block_aabb = {0, 1, 0, 0.5, 0, 1}
tall_aabb = {0, 1, 0, 1, 0, 1}

block_planes = {
    {pt = {-0.5, 0, 0}, normal = {-1, 0, 0}, aabb = {-0.5, 1, 0, 0.5, 0, 1}},
    {pt = {0.5, 0, 0},  normal = {1, 0, 0}, aabb = {0, 1.5, 0, 0.5, 0, 1}},
    {pt = {0, 0, -0.5}, normal = {0, 0, -1}, aabb = {0, 1, 0, 0.5, -0.5, 1}},
    {pt = {0, 0, 0.5},  normal = {0, 0, 1}, aabb = {0, 1, 0, 0.5, 0, 1.5}},
    {pt = {0, 0.5, 0},  normal = {0, 1, 0}, aabb = {0, 1, 0, 1, 0, 1}},
}

ramp_planes = {
    {pt = {-0.5, 0, 0}, normal = {-1, 0, 0}, aabb = {-0.5, 1, 0, 0.5, 0, 1}},
    {pt = {0, 0.25, 0}, normal = v_norm({0.5, 1, 0}), aabb = {0, 1.5, 0, 0.5, 0, 1}},
}    

qp_planes = {
    {pt = {-0.5, 0, 0}, normal = {-1, 0, 0}, aabb = {-0.5, 1, 0, 1, 0, 1}},
    --{pt = {0, 0, -0.5}, normal = {0, 0, -1}},
    --{pt = {0, 0, 0.5},  normal = {0, 0, 1}},        
}
local steps = 8
local stepsize = 1 / (steps + 1) * 3.14159 / 2
for i = 0, steps + 1 do
    local angle = i * stepsize
    local y = cos(angle)
    local x = sin(angle)
    add(qp_planes,
        {pt = {0.49 - x * 0.97, (1-y) * 0.99, 0}, normal = v_norm({x, y, 0}), aabb = {0, 1, 0, 1.1, 0, 1}}
    )
end


function in_aabb(pt, aabb)
    local x, y, z = unpack(pt)
    local px1, px2, py1, py2, pz1, pz2 = unpack(aabb)
    --printh("aabb:")
    --
    if not (x >= px1 and x <= px2 and y >= py1 and y <= py2 and z >= pz1 and z <= pz2) then
        --pv(pt)
        --printh(px1 .. ", " .. px2 .. ", " .. py1 .. ", " .. py2 .. ", " .. pz1 .. ", " .. pz2)
    end
    return x >= px1 and x <= px2 and y >= py1 and y <= py2 and z >= pz1 and z <= pz2
end

function find_first_collision(pt, vel, planes)
    local eps = 0.00
    local nearest, nt = nil, 999999
    local next_pt = v_add(pt, vel)
    for plane in all(planes) do
        local delta = v_sub(next_pt, plane.pt)
        local dot = v_dot(delta, plane.normal)
        if dot < 0 then -- normal and delta are facing opposite directions
            local vel_proj = abs(v_dot(vel, plane.normal))
            local overlap_proj = abs(v_dot(delta, plane.normal))
            local t = 1 - (overlap_proj / vel_proj)
            if t >= 0 and t <= 1 and t < nt then
                local new_pt = v_add(pt, v_mul(vel, t + eps))
                if in_aabb(new_pt, plane.aabb) then
                    nearest = plane
                    nt = t
                else
                    --printh("aabb fail")
                end
            end
        end
    end
    return nearest, nt
end

function rotate(v, fliph, flipv)
    if flipv then
        v = {-v[1], v[2], v[3]}
    end    
    if fliph then
        v = {v[3], v[2], v[1]}
    end
    return v
end
function rotate_aabb(v, fliph, flipv)
    if flipv then
        v = {0.5 - (v[2] - 0.5), 0.5 - (v[1] - 0.5), v[3], v[4], v[5], v[6]}
    end    
    if fliph then
        v = {v[5], v[6], v[3], v[4], v[1], v[2]}
    end    
    return v
end

function prepare_collision_planes(cells)
    local planes = {}
    for cell in all(cells) do
        local tt = cell.tiletype
        for p in all(tt.planes) do
            local offset = {cell.x + 0.5, cell.elev, cell.z + 0.5}
            local x1,x2,y1,y2,z1,z2 = unpack(rotate_aabb(p.aabb, cell.fliph, cell.flipv))
            -- todo: rotation
            local new_plane = {
                normal = rotate(p.normal, cell.fliph, cell.flipv),
                pt = v_add(rotate(p.pt, cell.fliph, cell.flipv), offset),
                aabb = {
                    x1 + cell.x,
                    x2 + cell.x,
                    y1,
                    y2 + cell.elev,
                    z1 + cell.z,
                    z2 + cell.z
                },
            }
            --[[
            add(debugs, function()
                local x1,x2,y1,y2,z1,z2 = unpack(new_plane.aabb)
                local points = {{x1,y1,z1}, {x2,y1,z1}, {x2,y1,z2}, {x1,y1,z2}, {x1,y1,z1}}
                line()
                for point3 in all(points) do
                    local point2 = v2p(point3)
                    line(point2[1], point2[2], 8)
                end
            end)
                ]]   
            add(planes, new_plane)
        end
    end
    return planes
end

function find_ground(pt)
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
    local e = 0.001
    local eps = 0.001
    local loops = 0
    --printh("--")
    --printh("TOTAL VEL LEN = " .. v_mag(new_vel))
    while not done do
        local mag = v_mag(new_vel)
        --printh("loop vel len = " .. mag)
        local start_pt = v_copy(new_pt)
        local nearest, nt = find_first_collision(new_pt, new_vel, planes)
        if nearest and loops < 20 then
            --printh("collision, nt = " .. nt)
            --pv(nearest.normal)
            local t = nt - eps / mag
            local delta = v_mul(new_vel, t)
            
            new_pt = v_add(new_pt, delta)
            --printh("new point = ")
            --pv(new_pt)
            local vel_rest = v_mul(new_vel, 1 - t)
            --local tangent = {nearest.normal[2], -nearest.normal[1], nearest.normal[3]}
            --local tangent = {0,0,1}
            local tangent = v_norm( v_cross( v_cross( v_norm(new_vel), nearest.normal ), nearest.normal ) )
            --printh("tangent")
            --pv(tangent)            
            local tmsq = v_mag( tangent )
            if tmsq < 0.9 or tmsq > 1.1 then
                done = true
            else
                local dist_tan = v_dot(vel_rest, tangent)
                --printh(dist_tan .. " / " .. v_mag(vel_rest))
                --new_vel = v_mul(tangent, v_mag(vel_rest) * sign(dist_tan))
                new_vel = v_mul(tangent, dist_tan)
                --pv(new_vel)
            end
            
            --new_vel = v_sub(new_vel, delta)
            --local d = v_dot(new_vel, nearest.normal)
            --local j = max((1 + e) * -d, 0);
            --printh("old vel: " .. v_mag(new_vel))
            
            --new_vel = v_add(new_vel, v_mul(nearest.normal, j))
            --local tangent = {nearest.normal.y, -nearest.normal.x, nearest.normal.z}
            --local vel2 = v_sub(new_pt, start_pt)
            --local projection = v_dot(vel2, tangent)
            --new_vel = 
            loops += 1
        else
            done = true
            new_pt = v_add(new_pt, new_vel)
        end
    end
    
    return new_pt, v_sub(new_pt, pt)
end