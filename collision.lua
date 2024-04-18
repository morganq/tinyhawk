cached_blocks = {}
cached_prefabs = {}

ground_volume = {{{pt={0,0,0}, normal={0,1,0}}}, {0,0,0}}

block_volumes = {
    {
        {pt = {-0.5, 0, 0}, normal = {-1, 0, 0}},
        {pt = {0.5, 0, 0},  normal = {1, 0, 0}},
        {pt = {0, 0, -0.5}, normal = {0, 0, -1}},
        {pt = {0, 0, 0.5},  normal = {0, 0, 1}},
        {pt = {0, 0.5, 0},  normal = {0, 1, 0}},
        --{pt = {0, 0, 0},  normal = {0, -1, 0}},
    }
}

ramp_volumes = {
    {
        {pt = {-0.5, 0, 0}, normal = {-1, 0, 0}},
        {pt = {0, 0, -0.5}, normal = {0, 0, -1}},
        {pt = {0, 0, 0.5},  normal = {0, 0, 1}},
        {pt = {0, 0.25, 0}, normal = v_norm({0.5, 1, 0})},
        --{pt = {0, 0, 0},  normal = {0, -1, 0}},
    }
}   

ramp2_volumes = {
    {
        {pt = {-0.5, 0, 0}, normal = {-1, 0, 0}},
        {pt = {0, 0, -0.5}, normal = {0, 0, -1}},
        {pt = {0, 0, 0.5},  normal = {0, 0, 1}},
        {pt = {0, 0.5, 0}, normal = v_norm({1, 1, 0})},
        --{pt = {0, 0, 0},  normal = {0, -1, 0}},
    }
}   

rail1_volumes = {
    {
        {pt = {-0.5, 0, 0}, normal = {-1, 0, 0}},
        {pt = {0.5, 0, 0},  normal = {1, 0, 0}},
        {pt = {0, 0, -0.1}, normal = {0, 0, -1}},
        {pt = {0, 0, 0.1},  normal = {0, 0, 1}},
        {pt = {0, 0.5, 0},  normal = {0, 1, 0}},
        --{pt = {0, 0, 0},  normal = {0, -1, 0}},
    }
}

qp_volumes = {
    {
        {pt = {-0.5, 0, 0}, normal = {-1, 0, 0}},
        {pt = {-0.49, 0, 0}, normal = {1, 0, 0}},
        {pt = {0, 0, -0.5}, normal = {0, 0, -1}},
        {pt = {0, 0, 0.5},  normal = {0, 0, 1}},
        {pt = {0, 1, 0},  normal = {0, 1, 0}},
        --{pt = {0, 0, 0},  normal = {0, -1, 0}},
    }
}
local steps = 4
local stepsize = 1 / (steps + 1) * 3.14159 / 2
for i = 0, steps + 1 do
    local angle = i * stepsize
    local y = cos(angle)
    local x = sin(angle)
    add(qp_volumes,
        {
            {pt = {0.49 - x * 0.97, (1-y) * 0.99, 0}, normal = v_norm({x, y, 0})},
            {pt = {0, 0, -0.5}, normal = {0, 0, -1}},
            {pt = {0, 0, 0.5},  normal = {0, 0, 1}},      
            {pt = {-0.5, 0, 0}, normal = {-1, 0, 0}},  
            {pt = {0, 0, 0},  normal = {0, -1, 0}},
            {pt = {0, 1, 0},  normal = {0, 1, 0}},
        }
    )
end


for i = 0.5, 15, 0.5 do
    cached_blocks[i] = {}
    for plane in all(block_volumes[1]) do
        add(cached_blocks[i], {pt = v_copy(plane.pt), normal = v_copy(plane.normal)})
    end
    cached_blocks[i][5].pt[2] += i - 0.5
end

function plane_segment(plane, pt, vel)
    local delta = v_sub(v_add(pt, vel), plane.pt)
    local dot = v_dot(delta, plane.normal)
    --printh("dot=" .. dot)
    if dot < 0 then -- normal and delta are facing opposite directions
        local vel_proj = abs(v_dot(vel, plane.normal))
        local overlap_proj = abs(v_dot(delta, plane.normal))
        local t = 1 - (overlap_proj / vel_proj)
        if t >= 0 then
            return t
        end
    end
    return nil
end

function check_inside(pt, volume)
    for plane in all(volume) do
        if v_dot(v_sub(pt, plane.pt), plane.normal) > 0 then
            return false
        end
    end    
    return true
end

function find_first_collision(pt, vel, volumes)
        -- Check each plane in each volume
        -- Get the plane and pt with lowest t value > 0
        -- Check if that point is inside every plane in the volume
        -- If we are that's a candidate volume and we record the closest plane and the t value            
    local nearest_volume, nearest_plane, nt = nil, nil, 999999
    local eps = 0.001
    for vo in all(volumes) do
        local volume, offset = unpack(vo)
        local off_pt = v_sub(pt, offset)
        local still_inside = true
        for plane in all(volume) do
            local t = plane_segment(plane, off_pt, vel)
            if t != nil and t < nt then
                local clipped_pt = v_add(off_pt, v_mul(vel, t + eps))
                if check_inside (clipped_pt, volume) then
                    nt = t
                    nearest_plane = plane
                    nearest_volume = volume
                end
            end
        end
    end
    return nearest_volume, nearest_plane, nt
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

function prepare_prefab_volume(v, fliph, flipv)
    local planes = {}
    for p in all(v) do
        local new_plane = {
            normal = rotate(p.normal, fliph, flipv),
            pt = rotate(p.pt, fliph, flipv),
        }
        add(planes, new_plane)
    end    
    return planes
end

function prepare_collision_volumes(cells)
    local volumes = {}
    for cell in all(cells) do
        local tt = cell.tiletype
        if cell.elev > 0 then
            local offset = {cell.x + 0.5, 0, cell.z + 0.5}
            local v = cached_blocks[cell.elev]
            add(volumes, {v, offset})
        end
        for i = 1, #tt.volumes do
            local offset = {cell.x + 0.5, cell.elev, cell.z + 0.5}
            local v = tt.volumes[i]
            local key = tt.name .. "_" .. i .. "_" .. (cell.fliph and 1 or 0) .. (cell.flipv and 1 or 0)
            local rv = cached_prefabs[key]
            if not rv then
                printh("caching " .. key)
                rv = prepare_prefab_volume(v, cell.fliph, cell.flipv)
                cached_prefabs[key] = rv
            end
            add(volumes, {rv, offset})
        end
    end
    return volumes
end

function find_ground(pt, volumes)
    local cell = get_cell(pt)
    if cell then
        local down = {0, -pt[2], 0}
        volumes = volumes or prepare_collision_volumes({cell})
        local nearest_volume, nearest, nt = find_first_collision(pt, down, volumes)
        if nearest then
            return v_add(pt, v_mul(down, nt))
        end
    end
    return {pt[1], 0, pt[3]}
    
end

function collide_point_volumes(pt, vel, volumes)
    -- Find first collision, then adjust pos and vel,
    -- then repeat until no more collisions

    if #volumes == 0 then
        return v_add(pt, vel), vel
    end

    local new_pt = v_copy(pt)
    local new_vel = v_copy(vel)
    local done = false
    local e = 0.001
    local eps = 0.001
    local loops = 0
    local collision_plane = nil
    while not done do
        local mag = v_mag(new_vel)
        local start_pt = v_copy(new_pt)
        local nearest_volume, nearest, nt = find_first_collision(new_pt, new_vel, volumes)
        
        if nearest and loops < 20 then
            collision_plane = nearest
            local t = nt - eps / mag
            local delta = v_mul(new_vel, t)
            new_pt = v_add(new_pt, delta)
            local vel_rest = v_mul(new_vel, 1 - t)
            local tangent = v_norm( v_cross( v_cross( v_norm(new_vel), nearest.normal ), nearest.normal ) )        
            local tmsq = v_mag( tangent )
            if tmsq < 0.9 or tmsq > 1.1 then
                done = true
            else
                local dist_tan = v_dot(vel_rest, tangent)
                new_vel = v_mul(tangent, dist_tan)
            end
     
            loops += 1
        else
            done = true
            new_pt = v_add(new_pt, new_vel), collision_plane
        end
    end
    return new_pt, v_sub(new_pt, pt), collision_plane
end

function get_rail_t(pt, rail)
    local delta = v_sub(rail[2], rail[1])
    local len = v_mag(delta)
    local rail_fwd = v_norm(delta)
    local pos_delta = v_sub(pt, rail[1])
    return v_dot(pos_delta, rail_fwd), rail_fwd, len
end

function get_next_rail_pt(pt, fwd, speed, rail)
    local t, rail_fwd, len = get_rail_t(pt, rail)
    local t2 = t + speed
    if v_dot(fwd, rail_fwd) < 0 then
        t2 = t - speed
    end
    return v_add(rail[1], v_mul(rail_fwd, t2)), t, len
end