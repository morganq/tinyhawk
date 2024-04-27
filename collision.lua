cached_prefabs = {}

local steps = 4
local stepsize = 1 / (steps + 1) * 3.14159 / 2
for i = 0, steps + 1 do
    local angle = i * stepsize
    local y = cos(angle)
    local x = sin(angle)
    local v = parse_volume("-0.5,0,0,-1,0,0;0,0,-0.5,0,0,-1;0,0,0.5,0,0,1;0,1,0,0,1,0;0,0,0,0,-1,0")
    add(v, {pt = {0.49 - x * 0.97, (1-y) * 0.99, 0}, normal = v_norm({x, y, 0})})
    add(qp_volumes, v)
end

function plane_segment(plane, pt, vel)
    local delta = v_sub(v_add(pt, vel), plane.pt)
    local dot = v_dot(delta, plane.normal)
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
    local nearest_volume, nearest_plane, nt, nearest_cell = nil, nil, 999999, nil
    local eps = 0.001
    for vo in all(volumes) do
        local volume, offset, cell = unpack(vo)
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
                    nearest_cell = cell
                end
            end
        end
    end
    return nearest_volume, nearest_plane, nt, nearest_cell
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
            add(volumes, {v, offset, cell})
        end
        for i = 1, #tt.volumes do
            local offset = {cell.x + 0.5, cell.elev, cell.z + 0.5}
            local v = tt.volumes[i]
            local key = tt.name .. "_" .. i .. "_" .. (cell.fliph and 1 or 0) .. (cell.flipv and 1 or 0)
            local rv = cached_prefabs[key]
            if not rv then
                --printh("caching " .. key)
                rv = prepare_prefab_volume(v, cell.fliph, cell.flipv)
                cached_prefabs[key] = rv
            end
            add(volumes, {rv, offset, cell})
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

    local new_pt, new_vel, done, eps, loops, collision_plane, last_cell = v_copy(pt), v_copy(vel), false, 0.001, 0, nil, nil
    while not done do
        local mag = v_mag(new_vel)
        local start_pt = v_copy(new_pt)
        local nearest_volume, nearest, nt, nearest_cell = find_first_collision(new_pt, new_vel, volumes)
        
        if nearest and loops < 20 then
            last_cell = nearest_cell
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
            new_pt = v_add(new_pt, new_vel), collision_plane, last_cell
        end
    end
    return new_pt, v_sub(new_pt, pt), collision_plane, last_cell
end

function get_rail_t(pt, rail)
    return v_dot(v_sub(pt, rail[1]), rail.fwd)
end

function get_next_rail_pt(pt, fwd, speed, rail)
    local t = get_rail_t(pt, rail)
    local t2 = t + speed
    if v_dot(fwd, rail.fwd) < 0 then
        t2 = t - speed
    end
    return v_add(rail[1], v_mul(rail.fwd, t2)), t, rail.len
end