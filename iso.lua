--[[pal_bl = split"13,2,3,4,5,6,15,8,9,10,11,6,13,14,15"
pal_br = split"5,2,3,4,13,6,15,8,9,10,11,6,13,14,15"
pal_tl = split"13,2,3,4,5,6,15,8,9,10,11,6,13,14,15"
pal_tr = split"5,2,3,4,13,6,15,8,9,10,11,5,13,14,15"
]]
pal_bl = split"1,5,3,4,5,6,15,13,6,15,11,12,13,14,6,0"
pal_br = split"5,13,3,4,1,13,15,6,15,15,11,12,5,14,6,0"
pal_tl = split"1,5,3,4,5,6,15,13,6,15,11,12,13,14,6,0"
pal_tr = split"5,13,3,4,1,13,15,6,15,15,11,12,5,14,6,0"
isopals = {
    {pal_bl, pal_br},
    {pal_tl, pal_tr}
}

function isospr(s, v, h, elev, fliph, flipv, draw_elev_left, draw_elev_right, bright_left, bright_right)
    elev = elev or 0
    local p = v2p(v)
    local x1, y1, y2 = p[1] - 8, p[2] - h * 8 - elev * 8, p[2] + 4 - elev * 8
    pal(isopals[flipv and 2 or 1][fliph and 2 or 1])
    if flipv then
        s += 2
    end
    spr(s, x1, y1, 2, h + 1, fliph)
    pal()
    if bright_left then
        spr(64, x1, y1, 1, 1)
    end
    if bright_right then
        spr(66, x1 + 8, y1, 1, 1)
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

------

tiles = {
    {name="block", sprite = 2, height = 0.5, volumes = block_volumes, is_block = true, rails = {
        {{-0.499, 0.499, -0.499}, {-0.499, 0.499, 0.499}},
        {{-0.499, 0.499, 0.499}, {0.499, 0.499, 0.499}},
        {{0.499, 0.499, 0.499}, {0.499, 0.499, -0.499}},
        {{0.499, 0.499, -0.499}, {-0.499, 0.499, -0.499}},
    }},
    {name="ramp1", sprite = 6, height = 0.5, volumes = ramp_volumes, rails = {
        {{-0.499, 0.499, -0.499}, {-0.499, 0.499, 0.499}},
        {{-0.499, 0.499, 0.499}, {0.499, 0, 0.499}},
        {{0.499, 0, 0.499}, {0.499, 0, -0.499}},
        {{0.499, 0, -0.499}, {-0.499, 0.499, -0.499}},
    }},  
    {name="qp", sprite = 10, height = 1, volumes = qp_volumes, is_qp = true, rails = {
        {{-0.499, 0.999, -0.499}, {-0.499, 0.999, 0.499}},
    }},
    {name="rail1", sprite = 34, height = 0.5, volumes = rail1_volumes, rails = {
        {{-0.499, 0.499, 0}, {0.499, 0.499, 0}},
    }},    
    {name="ramp2", sprite = 38, height = 1, volumes = ramp2_volumes, rails = {
        {{-0.499, 0.999, -0.499}, {-0.499, 0.999, 0.499}},
        {{-0.499, 0.999, 0.499}, {0.499, 0, 0.499}},
        {{0.499, 0, 0.499}, {0.499, 0, -0.499}},
        {{0.499, 0, -0.499}, {-0.499, 0.999, -0.499}},
    }},
}

function make_cell(tile, x, z, elev, fliph, flipv)
    return {tiletype = tile, x=x, z=z, elev = elev or 0, fliph = fliph or false, flipv = flipv or false, prepared_volumes = {}}
end

function get_cell(v)
    local x,z = v[1]\1, v[3]\1
    if map[x] and map[x][z] then
        return map[x][z]
    end
end

map = {}

local rendersize = 24

function render_grid(x, z)
    for i = x, x + rendersize do
        local p1 = v2p({i, 0, z})
        local p2 = v2p({i, 0, z + rendersize})
        line(p1[1], p1[2], p2[1], p2[2], 6)
    end
    for i = z, z + rendersize do
        local p1 = v2p({x, 0, i})
        local p2 = v2p({x + rendersize, 0, i})
        line(p1[1]-1, p1[2], p2[1]-1, p2[2], 6)        
    end    
end

all_entities = {}

--.41
--.55

function add_map_tile(x, z, ind, elev, fliph, flipv)
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
        local e = {
            pos = {x,0,z},
            center = {x + 0.5, 0, z + 0.5},
            depth = 0,
            cell = cell,
            height = elev + 1,
            bright_left = false,
            bright_right = false, 
            draw = function(self)
                -- memo
                local l = not(map[x + 1] and map[x + 1][z] and map[x + 1][z].elev >= elev)
                local r = not(map[x] and map[x][z + 1] and map[x][z + 1].elev >= elev)
                
                isospr(
                    cell.tiletype.sprite, {x,0,z},
                    cell.tiletype.height, cell.elev,
                    cell.fliph, cell.flipv, l, r, self.bright_left, self.bright_right)                    
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
        
    end
end

function get_depth(a)
    if a.depth_point then
        return a.depth_point[1] + a.depth_point[2] + a.depth_point[3]
    else
        return a.center[1] + a.center[2] + a.center[3]
    end
end
function axissort(a, b)
    local d = v_sub(a.center, b.center)
    if abs(d[2]) >= a.height / 2 + b.height / 2 then
        return d[2] > 0
    end
    --[[if abs(d[1]) >= 1 then
        return d[1] > 0
    end
    if abs(d[3]) >= 1 then
        return d[3] > 0
    end ]]   
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

function render_iso_entities(entities)
    local v = p2vi({64, 64})
    local x1, x2 = v[1] - rendersize \ 2, v[1] + rendersize \ 2
    local z1, z2 = v[3] - rendersize \ 2, v[3] + rendersize \ 2
    
    -- can opt with deli if needed
    del(all_entities, skater)
    del(all_entities, skater.shadow)
    insert_cmp(all_entities, skater, function(a,b) return a.depth > b.depth end)
    insert_cmp(all_entities, skater.shadow, function(a,b) return a.depth > b.depth end)

    for ent in all(all_entities) do
        if not ent.cell or (ent.cell.x >= x1 and ent.cell.z >= z1 and ent.cell.x <= x2 and ent.cell.z <= z2) then
            ent:draw()
            if SHOW_DEPTH and ent.depth then
                add(debugs, function()
                    local v = v2p(ent.center)
                    local d = sub(tostr(ent.depth), 0, 3)
                    print(d, v[1] - 4, v[2] - 2, 0)
                end)
            end
        end
    end 
    if skater.grind_line then
        local p1, p2 = v2p(skater.grind_line[1]), v2p(skater.grind_line[2])
        line(p1[1], p1[2], p2[1], p2[2], 10)        
    end
    fillp(0b1010010110100101.11)
    skater:draw()
    fillp()
end

function debug_tile(v, c)
    local p = v2p({v[1]\1,v[2]\1,v[3]\1})
    local x, y = p[1] - 9, p[2] + 4
    add(debugs, function()
        line(x,y,x + 8,y - 4, c or 8)
        line(x + 17,y)
        line(x+8,y+4)
        line(x+1,y)
        line(x,y,x,y + v[2]\1 * 8)
    end)
end

function draw_v(v, ox, oy, c)
    local o1 = v2p(v)
    local o2 = v2p({0,0,0})
    local dx, dy = o1[1] - o2[1], o1[2] - o2[2]
    line(ox, oy, ox + dx, oy + dy, c or 8)
end

function pset3d(v,c)
    local o1 = v2p(v)
    pset(o1[1], o1[2], c)
end

function fix_brights()
    for x, zs in pairs(map) do
        for z, cell in pairs(zs) do
            cell.ent.bright_left = false
            cell.ent.bright_right = false
            if cell.tiletype.is_block then
                local left = get_cell({x, 0, z - 1})
                local right = get_cell({x - 1, 0, z})
                if not left or left.ent.height <= cell.ent.height - 0.5 then
                    cell.ent.bright_left = true
                end
                if not right or right.ent.height <= cell.ent.height - 0.5 then
                    cell.ent.bright_right = true
                end            
            end
        end
    end    
end

function fix_grinds()
    cls(7)
    print("loading", 50, 60, 0)
    flip()
    for x, zs in pairs(map) do
        for z, cell in pairs(zs) do
            cell.prepared_planes = nil
            volumes = prepare_collision_volumes(get_cells_within({x + 0.5, 0, z + 0.5}, 1))
            add(volumes, ground_volume)
            for rail in all(cell.rails) do
                local center = v_mul(v_add(rail[1], rail[2]), 0.5)
                local delta = v_sub(rail[2], rail[1])
                local rf = v_norm(delta)
                local side = v_mul(v_cross(rf, {0,1,0}), 0.125)
                local test1 = v_add(center, side)
                test1[2] += 20
                local test2 = v_sub(center, side)
                test2[2] += 20
                local res1 = find_first_collision(test1, {0, -20.125, 0}, volumes)
                local res2 = find_first_collision(test2, {0, -20.125, 0}, volumes)
                if res1 and res2 then
                    del(cell.rails, rail)
                end
            end
        end
    end
    presort_cells()
    fix_brights()
end