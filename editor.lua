poke(0x5F2D, 0x1)
scroll = {0,0}
debugs = {}
local started = true
function do_test()
    local volumes = {
        --{ pt = {-5, 0, 0}, normal = v_norm({1, 1, 0}), aabb = {-10, 10, -10, 10, -10, 10} },
        --{ pt = {-4, 0, 0}, normal = v_norm({1, 1, 0}), aabb = {-10, 10, -10, 10, -10, 10} },
        {{pt = {-2, 0, -2}, normal = v_norm({1, 0, 0})}},
    }
    printh("----- TEST 1 ------")
    local pt, vel = collide_point_volumes({0,0,0}, {-10, 0, -10}, volumes)
    printh("RESULT pt")
    pv(pt)
    printh("RESULT vel")
    pv(vel)
end

function _init()
    for i = 0, 30 do
        local x = ((rnd(2) - 1) * 8) \ 1
        local z = ((rnd(2) - 1) * 8) \ 1
        if not map[x] then map[x] = {} end
        local s = rnd(3)\1 * 2 + 2
        --map[x][z] = make_tile(s, s == 6 and 2 or 1, rnd(4) \ 1, rnd(1) > 0.5 )
    end
    skater = make_skater()
    add(all_entities, skater)
    add(all_entities, skater.shadow)

    do_test()
end

time = 0
local mbs = {false, false}
local editor_elev = 0
local editor_fliph = false
local editor_flipv = false
local rotations = {{false, false}, {true, false}, {false, true}, {true, true}}
local rotation = 0
function _update()

    time += 1
    mx, my, mb = stat(32), stat(33), stat(34)
    mv = p2vi({mx, my})
    local symbol = ""
	if stat(30) then
		symbol = stat(31)    
    end    

    if symbol == "q" then
        rotation = (rotation + 1) % 4
        editor_fliph = rotations[rotation + 1][1]
        editor_flipv = rotations[rotation + 1][2]
    end

    if symbol == "g" then
        fix_grinds()
    end

    if symbol == "s" then
        save()
    end
    if symbol == "l" then
        load()
    end

    if btn(0) then 
        skater:control({1,0,-1})
    end
    if btn(1) then
        skater:control({-1,0,1})
    end
    if btn(2) then
        skater:control({-1,0,-1})
    end
    if btn(3) then
        skater:control({1,0,1})
    end    
    if btn(5) then
        skater.jump_charge += 1
    end
    if not btn(5) and skater.jump_charge > 0 then
        skater:jump()
    end
    if btnp(4) then
        skater:trick()
    end

    if (mb & 0b01) != 0 then
        add_map_tile(mv[1], mv[3], editor_sel, editor_elev, editor_fliph, editor_flipv)
    end
    if (mb & 0b10) != 0 and not mbs[2] then
        editor_sel = (editor_sel % 3) + 1
    end
    editor_elev = max(editor_elev + stat(36) / 2, 0)

    local sp = v2p(skater.pos)
    if abs(sp[1] - 64) > 6 then
        scroll[1] = (64 - sp[1]) * 0.1 + scroll[1] * 0.9
    end
    if abs(sp[2] - 64) > 6 then
        scroll[2] = (64 - sp[2]) * 0.1 + scroll[2] * 0.9
    end    
    

    if not started then
        if btnp(4) then started = true end
        return
    end
    skater:update()
    mbs[1] = (mb & 0b01) != 0
    mbs[2] = (mb & 0b10) != 0    
end
editor_sel = 1

function _draw()
    cls(7)
    if not started then
        return
    end        
    local pts = {{0,0,0}, {1,0,0}, {1,0,1}, {0,0,1}, {0,0,0}}
    camera(-scroll[1], -scroll[2])

    --render_isomap(map)
    render_iso_entities()

    local p = v2p(mv)
    
    pset(p[1], p[2], 8)
    local t = tiles[editor_sel]
    isospr(t.sprite, mv, t.height, editor_elev, editor_fliph, editor_flipv)

    for op in all(debugs) do
        op()
    end
    debugs = {}

    camera()
    --print(mv[1] .. "," .. mv[2] .. "," .. mv[3], 1, 1, 8)
    --draw_v(v_mul(skater.fwd, 1), 20, 20)
    spr(1, mx, my)
    --print(stat(0), 1, 100, 11)
    if skater.grind_line != nil then
        print("~grind~", 40, 100, 8)
    end
end

function save()
    local string = ""
    for x, zs in pairs(map) do
        for z, cell in pairs(zs) do
            string ..= x .. "," .. z .. "," .. cell.elev .. "," .. cell.index .. "," .. (cell.fliph and 1 or 0) .. "," .. (cell.flipv and 1 or 0) .. ";"
        end
    end    
    printh(string)
end

local LEVEL = "-4,0,0,3,0,0;-1,0,0,2,0,0;-5,1,0,3,1,0;-5,-1,0,3,1,1;-5,0,0.5,1,1,1;-2,1,0,2,1,0;-2,0,0,1,0,0;-2,-1,0,1,0,0;-2,-2,0,1,0,0;-2,-3,0,1,0,0;-6,0,0,3,0,1;-3,-3,0,1,0,0"
function load()
    local s = LEVEL
    for t in all(split(s, ";")) do
        local parts = split(t, ",")
        if parts then
            add_map_tile(parts[1], parts[2], parts[4], parts[3], parts[5] == 1, parts[6] == 1)
        end
    end
    fix_grinds()
end