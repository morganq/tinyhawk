pal_flip =   split"5,2,3,4,13,6,15,8,9,10,11,6,13,14,15"
pal_noflip = split"13,2,3,4,5,6,15,8,9,10,11,6,13,14,15"
--pal_noflip = split"6,2,3,4,5,6,7,8,9,10,11,15,13,14,15"

function isospr(s, v, h, elev, fliph, flipv)
    elev = elev or 0
    local p = v2p(v)
    local x1, y1, y2 = p[1] - 8, p[2] - h * 8 - elev * 8, p[2] + 4 - elev * 8
    if fliph then
        pal(pal_flip)
    else
        pal(pal_noflip)
    end
    if flipv then
        s += 2
    end
    spr(s, x1, y1, 2, h + 1, fliph)
    if elev > 0 then
        for ox = 0, 7 do
            local x = p[1] - 8 + ox
            local y = y2 + ox \ 2
            line(x, y, x, y + 8 * elev, 13)
        end
        for ox = 8, 15 do
            local x = p[1] - 8 + ox
            local y = y2 + 8 - (ox+1) \ 2
            line(x, y, x, y + 8 * elev, 5)
        end        
    end
    
end

------

tiles = {
    {sprite = 2, height = 0.5, planes = block_planes, aabb = block_aabb},
    {sprite = 6, height = 0.5, planes = ramp_planes, aabb = block_aabb},
    {sprite = 10, height = 1, planes = qp_planes, aabb = tall_aabb, is_qp = true},
}

function make_cell(tile, x, z, elev, fliph, flipv)
    return {tiletype = tile, x=x, z=z, elev = elev or 0, fliph = fliph or false, flipv = flipv or false}
end

map = {}

local rendersize = 24

--[[
cell:
    x
    z
    elev
    hflip
    vflip
    tiletype *
]]

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

function add_map_tile(x, z, ind, elev, fliph, flipv)
    elev = elev or 0
    if map[x] == nil then map[x] = {} end
    if not map[x][z] then
        local tile = tiles[ind]   
        local e = {
            pos = {x,0,z},
            center = {x + 0.5, 0, z + 0.5},
            cell = make_cell(tile, x, z, elev, fliph, flipv),
            height = elev + 1,
            draw = function(self)
                isospr(
                    self.cell.tiletype.sprite, {x,0,z},
                    self.cell.tiletype.height, self.cell.elev,
                    self.cell.fliph, self.cell.flipv)
            end
        }
        e.cell.planes = planes
        e.cell.ent = e
        add(all_entities, e)
        map[x][z] = e.cell 
    end
end

function render_iso_entities(entities)
    local v = p2vi({64, 64})
    local x1 = v[1]
    local z1 = v[3]
    render_grid(x1 - rendersize \ 2, z1 - rendersize \ 2)
    function normalize(a)
        return a.center[1]\1 + a.center[2]\1 + a.center[3] \ 1
    end
    local axissort = function(a, b)
        local dy = a.center[2] - b.center[2]
        if abs(dy) >= a.height / 2 + b.height / 2 then
            -- separated by y
            return dy > 0
        end
        return normalize(a) > normalize(b)
    end
    sort(all_entities, axissort)
    for ent in all(all_entities) do
        ent:draw()
    end 
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