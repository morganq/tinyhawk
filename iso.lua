map = {}

pal_bl = split"1,5,3,4,5,6,15,13,6,10,11,12,13,14,6,0"
pal_br = split"5,13,3,4,1,13,15,6,15,10,11,12,5,14,6,0"
pal_tl = split"1,5,3,4,5,6,15,13,6,10,11,12,13,14,6,0"
pal_tr = split"5,13,3,4,1,13,15,6,15,10,11,12,5,14,6,0"
isopals = {
    {pal_bl, pal_br},
    {pal_tl, pal_tr}
}

function isospr(s1, s2, v, h, elev, fliph, flipv, draw_elev_left, draw_elev_right, brights)
    elev = elev or 0
    local p = v2p(v)
    local x1, y1, y2 = p[1] - 8, p[2] - h * 8 - elev * 8, p[2] + 4 - elev * 8
    pal(isopals[flipv and 2 or 1][fliph and 2 or 1])
    local s = s1
    if flipv then
        s = s2
    end
    spr(s, x1, y1, 2, h + 1, fliph)
    pal()
    for bright in all(brights) do
        spr(bright, x1, y1, 2, 1)
    end
    if elev > 0 then
        local elev8 = 8 * elev
        if draw_elev_left then
            local px = p[1] - 8
            for ox = 0, 7 do
                local x = px + ox
                local y = y2 + ox \ 2
                line(x, y+1, x, y + elev8, 5)
            end
        end
        if draw_elev_right then
            local px = p[1] - 8
            for ox = 8, 15 do
                local x = px + ox
                local y = y2 + 8 - (ox+2) \ 2
                line(x, y+1, x, y + elev8, 1)
            end        
        end
    end
    
end

function make_cell(tile, x, z, elev, fliph, flipv)
    return {tiletype = tile, x=x, z=z, elev = elev or 0, fliph = fliph or false, flipv = flipv or false}
end

function get_cell(v)
    local x,z = v[1]\1, v[3]\1
    if map[x] and map[x][z] then
        return map[x][z]
    end
end


all_entities = {}

function add_map_tile(x, z, ind, elev, fliph, flipv, special)
    elev = elev or 0
    if map[x] == nil then map[x] = {} end
    if map[x][z] then
        local cell = map[x][z]
        del(all_entities, cell.ent)
        map[x][z] = nil
    end
    if not map[x][z] then
        local tile = tiles[ind]   
        local cell = make_cell(tile, x, z, elev, fliph, flipv)
        cell.special = special and special > 0 and special
        local e = {
            pos = {x,0,z},
            center = {x + 0.5, 0, z + 0.5},
            depth = 0,
            cell = cell,
            height = elev + 0.5 + tile.height,
            brights = {},
            draw = function(self)
                -- memo
                local l = not(map[x + 1] and map[x + 1][z] and map[x + 1][z].elev >= elev)
                local r = not(map[x] and map[x][z + 1] and map[x][z + 1].elev >= elev)
                isospr(
                    tile.s1, tile.s2, {x,0,z},
                    tile.height, cell.elev,
                    cell.fliph, cell.flipv, l, r, self.brights)    
                
                --[[
                -- Draw rails
                for rail in all(self.cell.rails) do
                    local p1, p2 = v2p(rail[1]), v2p(rail[2])
                    line(p1[1], p1[2], p2[1], p2[2], 8)
                end
                
                
                -- Draw planes
                local offset = {x + 0.5, elev, z + 0.5}
                for i = 1, #tile.volumes do
                    local key = tile.name .. "_" .. i .. "_" .. (cell.fliph and 1 or 0) .. (cell.flipv and 1 or 0)
                    local vol = cached_prefabs[key]
                    local n = 0
                    for plane in all(vol) do
                        local p = v_add(plane.pt, offset)
                        local p1 = v2p(p)
                        local p2 = v2p(v_add(p, plane.normal))
                        line(p1[1], p1[2], p2[1], p2[2], 11 + n % 3)
                        n += 1
                    end
                end
                ]]
                
            end
        }
        e.depth = get_depth(e)
        cell.ent = e
        cell.index = ind
        add(all_entities, e)
        map[x][z] = e.cell 
        e.cell.rails = {}
        e.depth = axis
        local rail_offset = {e.center[1], elev, e.center[3]}
        for rail in all(tile.rails) do
            local r1 = rotate(rail[1], cell.fliph, cell.flipv)
            local r2 = rotate(rail[2], cell.fliph, cell.flipv)
            add(e.cell.rails, {v_add(r1, rail_offset), v_add(r2, rail_offset)})
        end
        return cell    
    end
    
end

function get_depth(a)
    if (a.depth_point) return a.depth_point[1] + a.depth_point[2] + a.depth_point[3]
    return a.center[1] + a.center[2] + a.center[3]
end
function axissort(a, b)
    local d = v_sub(a.center, b.center)
    if (abs(d[2]) >= a.height / 2 + b.height / 2) return d[2] > 0
    return get_depth(a) > get_depth(b)
end

function presort_cells()
    for ent in all(all_entities) do
        if ent.cell then
            ent.depth = get_depth(ent)
        else
            ent.depth = 0
        end
    end
    sort(all_entities, function(a,b)
        return a.depth > b.depth
    end)
end

function render_iso_entities(rendersize, use_skater)
    local v = p2vi({64, 64})
    local x1, x2 = v[1] - rendersize \ 2, v[1] + rendersize \ 2
    local z1, z2 = v[3] - rendersize \ 2, v[3] + rendersize \ 2

    -- can opt with deli if needed
    if use_skater then
        del(all_entities, skater)
        del(all_entities, skater.shadow)
        insert_cmp(all_entities, skater, function(a,b) return a.depth > b.depth end)
        insert_cmp(all_entities, skater.shadow, function(a,b) return a.depth > b.depth end)
    end

    for ent in all(all_entities) do
        if not ent.cell or (ent.cell.x >= x1 and ent.cell.z >= z1 and ent.cell.x <= x2 and ent.cell.z <= z2) then
            ent:draw()
        end
    end 
    if use_skater then
        fillp(0b1010010110100101.11)
        skater:draw()
        fillp()
    end
end

function draw_v(v, ox, oy, c)
    local o1 = v2p(v)
    local o2 = v2p({0,0,0})
    local dx, dy = o1[1] - o2[1], o1[2] - o2[2]
    line(ox, oy, ox + dx, oy + dy, c or 8)
end

function fix_brights()
    for x, zs in pairs(map) do
        for z, cell in pairs(zs) do
            cell.ent.brights = {}
            if cell.tiletype.is_block then
                local left = get_cell({x, 0, z - 1})
                local right = get_cell({x - 1, 0, z})
                if not left or left.ent.height <= cell.ent.height - 0.1 then
                    add(cell.ent.brights, 200)
                end
                if not right or right.ent.height <= cell.ent.height - 0.1 then
                    add(cell.ent.brights, 201)
                end            
            end
            if (cell.tiletype.name == "hblock1") add(cell.ent.brights, 203)
            --if (cell.tiletype.name == "hblock2") add(cell.ent.brights, 69)
        end
    end    
end

function fix_grinds()
    for x, zs in pairs(map) do
        for z, cell in pairs(zs) do
            cell.prepared_planes = nil
            volumes = prepare_collision_volumes(get_cells_within({x + 0.5, 0, z + 0.5}, 1))
            add(volumes, ground_volume)
            for rail in all(cell.rails) do
                local center = v_mul(v_add(rail[1], rail[2]), 0.5)
                local delta = v_sub(rail[2], rail[1])
                local rf = v_norm(delta)
                local side = v_mul(v_cross(rf, {0,1,0}), 0.25)
                local test1 = {center[1] + side[1], center[2] + side[2] - 0.125, center[3] + side[3]}
                local test2 = {center[1] - side[1], center[2] - side[2] - 0.125, center[3] - side[3]}
                local res1, res2 = false, false
                for vol in all(volumes) do
                    local volume, offset = unpack(vol)
                    if check_inside(v_sub(test1, offset), volume) then res1 = true; break end
                end
                for vol in all(volumes) do
                    local volume, offset = unpack(vol)
                    if check_inside(v_sub(test2, offset), volume) then res2 = true; break end
                end                
                if (res1 and res2) del(cell.rails, rail)
            end
        end
    end
    presort_cells()
    fix_brights()
end