--TODO: remove preparing points, replace with precalc rotations and player pos offset
--TODO: model data as strings
--TODO: tricks as strings

poke(0x5F2D, 0x1)
poke(0X5F5C, 255)
scroll = {0,0}
debugs = {}
local is_editing = true
SHOW_DEPTH = false
LEVEL_BORDERS = {-16.9, 2, -9, 19.9}


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
edit_ent = {}

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
    add(all_entities, edit_ent)
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

    if is_editing then
        if btn(0) then
            scroll[1] += 2
        end
        if btn(1) then
            scroll[1] -= 2
        end
        if btn(2) then
            scroll[2] += 2
        end
        if btn(3) then
            scroll[2] -= 2
        end                        
    else
        local dir = 0
        local fb = 0
        if btn(0) then 
            dir += 1
        end
        if btn(1) then
            dir += -1
        end
        if dir == 0 then
            if btn(2) then
                fb = 1
            elseif btn(3) then
                fb = -1
            end
        end
        skater:control(dir, fb, btn(5))
        if btn(5) then
            skater.jump_charge += 1
        end
        if not btn(5) and skater.jump_charge > 0 then
            skater:jump()
        end
        if btnp(4) then
            skater:trick()
        elseif btn(4) then
            skater:hold_grind()
        end
        local sp = v2p(skater.pos)
        if abs(sp[1] - 64) > 6 then
            scroll[1] = (64 - sp[1]) * 0.1 + scroll[1] * 0.9
        end
        if abs(sp[2] - 64) > 6 then
            scroll[2] = (64 - sp[2]) * 0.1 + scroll[2] * 0.9
        end    
    end
        
    update_inputs()
    skater:update()  
    update_combo()

    local symbol = ""
    if stat(30) then
        symbol = stat(31)    
    end  
    if symbol == "e" then
        is_editing = not is_editing
        if not is_editing then
            del(all_entities, edit_ent)
        else
            add(all_entities, edit_ent)
        end
    end

    if symbol == "g" then
        fix_grinds()
    end

    if symbol == "l" then
        load()
    end

    if symbol == "w" then
        SHOW_DEPTH = not SHOW_DEPTH
    end

    if is_editing then  
    
        if symbol == "q" then
            rotation = (rotation + 1) % 4
            editor_fliph = rotations[rotation + 1][1]
            editor_flipv = rotations[rotation + 1][2]
        end
    
        if symbol == "s" then
            save()
        end

        if symbol == "d" then
            if map[mv[1]] and map[mv[1]][mv[3]] then
                local cell = map[mv[1]][mv[3]]
                del(all_entities, cell.ent)
                map[mv[1]][mv[3]] = nil
            end
        end

        if (mb & 0b01) != 0 then
            add_map_tile(mv[1], mv[3], editor_sel, editor_elev, editor_fliph, editor_flipv)
            presort_cells()
        end
        if (mb & 0b10) != 0 and not mbs[2] then
            editor_sel = (editor_sel % #tiles) + 1
        end
        editor_elev = max(editor_elev + stat(36) / 2, 0)
    end    
    mbs[1] = (mb & 0b01) != 0
    mbs[2] = (mb & 0b10) != 0      
end
editor_sel = 1

local borders = {
    {LEVEL_BORDERS[1], 0, LEVEL_BORDERS[3]},
    {LEVEL_BORDERS[2], 0, LEVEL_BORDERS[3]},
    {LEVEL_BORDERS[2], 0, LEVEL_BORDERS[4]},
    {LEVEL_BORDERS[1], 0, LEVEL_BORDERS[4]},
    {LEVEL_BORDERS[1], 0, LEVEL_BORDERS[3]},
}

function _draw()
    cls(15)
    camera(-scroll[1], -scroll[2])
    line()
    for i = 1, 5 do
        local v = v2p(borders[i])
        line(v[1], v[2], 7)
    end

    if is_editing then
        local t = tiles[editor_sel]
        edit_ent.center = mv
        edit_ent.height = editor_elev + 1
        edit_ent.depth = get_depth(edit_ent)
        edit_ent.draw = function(self)
            isospr(t.sprite, mv, t.height, editor_elev, editor_fliph, editor_flipv, true, true)
        end
        sort(all_entities, axissort)
    end
    render_iso_entities()

    for op in all(debugs) do
        op()
    end
    debugs = {}

    
    --print(mv[1] .. "," .. mv[2] .. "," .. mv[3], 1, 1, 8)
    --draw_v(v_mul(skater.fwd, 1), 20, 20)
    --draw_v(v_norm({-1,-1,-1}), 20, 20)
    if is_editing then
        if map[mv[1]] and map[mv[1]][mv[3]] then
            local cell = map[mv[1]][mv[3]]
            isospr(14, mv, 1, cell.elev, false, false, false, false)
            local p = v2p(mv)
            line(p[1], p[2] + 8, p[1], p[2] - (cell.elev) * 8, 8)
        end

        
    end
    camera()
    if is_editing then
        spr(1, mx, my)
    end
    --print(stat(0), 1, 100, 11)
    draw_inputs(2, 2)
    draw_combo()
    --pal(split"1,2,3,4,5,143,7,8,9,10,11,12,128,14,15,0",1)
    pal(split"1,2,10,4,140,15,7,8,9,10,11,12,140,14,134,0",1)
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

local LEVEL = "1,3,0,2,1,1;1,4,0.5,2,1,1;1,5,0,3,1,0;1,9,0,3,1,1;1,10,0.5,4,1,0;1,11,0.5,4,1,0;1,12,0.5,4,1,0;1,13,0.5,1,0,0;1,14,0.5,1,0,0;1,15,0.5,1,0,0;1,16,0.5,1,0,0;1,-1,0,3,1,0;1,-2,1.5,1,1,1;1,-3,1.5,1,1,1;1,-4,1.5,1,1,1;1,-5,1.5,1,1,0;1,-6,1.5,1,1,0;1,-7,1.5,1,1,0;1,-8,1.5,1,1,0;1,-9,2,3,1,0;1,18,0.5,1,1,1;1,19,0.5,1,1,1;1,17,0.5,1,0,0;0,3,0,2,1,1;0,4,0.5,2,1,1;0,5,0,3,1,0;0,9,0,3,1,1;0,10,0,1,0,0;0,11,0,1,0,0;0,12,0,1,0,0;0,13,0,3,0,1;0,14,0,3,0,1;0,15,0,3,0,1;0,16,0,3,0,1;0,-1,0,3,1,0;0,-2,1.5,1,1,1;0,-3,1.5,1,1,0;0,-4,1.5,1,1,0;0,-5,1.5,1,1,0;0,-6,1.5,1,1,0;0,-7,1.5,1,1,0;0,-8,1.5,1,1,0;0,-9,2,3,1,0;0,19,0.5,1,1,1;0,17,0,3,0,1;-16,18,0,3,1,1;-16,19,0.5,1,1,1;-16,5,4,1,1,0;-16,6,0.5,1,1,1;-16,7,0.5,1,1,1;-16,8,0.5,1,1,1;-16,9,0.5,1,1,1;-16,10,0.5,1,1,1;-16,11,0.5,1,1,1;-16,4,4,1,1,0;-1,-1,0,2,1,0;-1,-2,0.5,2,1,0;-1,18,0,3,1,1;-1,3,0,2,1,1;-1,19,0.5,1,1,1;-1,4,0.5,2,1,1;-1,5,0,3,1,0;-1,-6,1.5,1,1,0;-1,-7,1.5,1,1,0;-1,-8,1.5,1,1,0;-1,9,0,3,1,1;-1,10,0.5,2,1,0;-1,11,0,2,1,0;-1,-9,2,3,1,0;-1,-4,1.5,1,1,0;-1,-3,1,5,1,0;-1,-5,1.5,1,1,0;-17,4,4,1,1,0;-17,5,4,1,1,0;-17,6,4,1,1,0;-17,7,4,1,1,0;-17,8,4,1,1,0;-17,9,4,1,1,0;-17,10,4,1,1,0;-17,11,4,1,1,0;-17,12,4,1,1,0;-17,13,4,1,1,0;-17,14,4,1,1,0;-17,15,4,1,1,0;-17,16,4,1,1,0;-17,18,4,1,1,0;-17,19,4,1,1,0;-17,17,4,1,1,0;-2,-1,0,2,1,0;-2,-2,0.5,2,1,0;-2,18,0,3,1,1;-2,3,0,2,1,1;-2,19,0.5,1,1,1;-2,4,0.5,2,1,1;-2,5,0,3,1,0;-2,-6,1.5,1,1,0;-2,-7,1.5,1,1,0;-2,-8,1.5,1,1,0;-2,9,0,3,1,1;-2,10,0.5,2,1,0;-2,11,0,2,1,0;-2,-9,2,3,1,0;-2,-4,1.5,1,1,0;-2,-3,1,5,1,0;-2,-5,1.5,1,1,0;-3,-1,0,3,1,0;-3,-2,4,1,1,0;-3,18,0,3,1,1;-3,3,0,2,1,1;-3,19,0.5,1,1,1;-3,-4,1.5,1,1,0;-3,-5,1.5,1,1,0;-3,-6,1.5,1,1,0;-3,-7,1.5,1,1,0;-3,-8,1.5,1,1,0;-3,9,0,3,1,1;-3,10,0.5,2,1,0;-3,11,0,2,1,0;-3,-3,4,1,1,0;-3,-9,2,3,1,0;-3,4,0.5,2,1,1;-3,5,0,3,1,0;-4,-1,0,2,1,0;-4,-2,0.5,2,1,0;-4,18,0,3,1,1;-4,3,0,2,1,1;-4,19,0.5,1,1,1;-4,4,0.5,2,1,1;-4,5,0,3,1,0;-4,-6,1.5,1,1,0;-4,-7,1.5,1,1,0;-4,-8,1.5,1,1,0;-4,9,0,3,1,1;-4,10,0.5,2,1,0;-4,11,0,2,1,0;-4,-9,2,3,1,0;-4,-4,1.5,1,1,0;-4,-3,1,5,1,0;-4,-5,1.5,1,1,0;-5,-1,0,2,1,0;-5,-2,0.5,2,1,0;-5,18,0,3,1,1;-5,3,0,2,1,1;-5,19,0.5,1,1,1;-5,4,0.5,2,1,1;-5,5,0,3,1,0;-5,-6,1.5,1,1,0;-5,-7,1.5,1,1,0;-5,-8,1.5,1,1,0;-5,9,0,3,1,1;-5,10,0.5,2,1,0;-5,11,0,2,1,0;-5,-9,2,3,1,0;-5,-4,1.5,1,1,0;-5,-3,1,5,1,0;-5,-5,1.5,1,1,0;-6,-1,0,3,1,0;-6,-2,0.5,1,1,0;-6,-3,0.5,1,1,0;-6,-4,0.5,1,1,0;-6,-5,1,3,1,0;-6,-6,4,1,1,0;-6,-7,4,1,1,0;-6,-8,4,1,1,0;-6,-9,4,1,1,0;-6,19,0.5,1,1,1;-6,18,0,3,1,1;-7,-1,0,3,1,0;-7,-2,0.5,1,1,0;-7,-3,0.5,1,1,0;-7,-4,0.5,1,1,0;-7,-5,1,3,1,0;-7,-6,4,1,1,0;-7,19,0.5,1,1,1;-7,18,0,3,1,1;-8,15,0,3,0,0;-8,16,0,3,0,0;-8,17,0,3,0,0;-8,-3,0.5,1,1,0;-8,-4,0.5,1,1,0;-8,-5,1,3,1,0;-8,-6,4,1,1,0;-8,-2,0.5,1,1,0;-8,-1,0,3,1,0;-8,19,0.5,1,1,1;-8,8,0,2,0,0;-8,7,0,2,0,0;-9,5,0,4,1,1;-9,6,0,4,1,1;-9,7,0,4,1,1;-9,8,0,4,1,1;-9,9,0,4,1,1;-9,10,0,4,1,1;-9,14,0,3,1,1;-9,15,0.5,1,1,1;-9,16,0.5,1,1,1;-9,-1,0,3,1,0;-9,17,0.5,1,1,1;-9,-3,0.5,1,1,0;-9,-4,0.5,1,1,0;-9,-5,1,3,1,0;-9,-6,4,1,1,0;-9,18,0.5,1,1,1;-9,19,0.5,1,1,1;-9,-2,0.5,1,1,0;-10,15,0,3,0,1;-10,-1,0,3,1,0;-10,17,0,3,0,1;-10,-3,0.5,1,1,0;-10,19,0.5,1,1,1;-10,-5,1,3,1,0;-10,-6,4,1,1,0;-10,9,0,2,0,1;-10,-4,0.5,1,1,0;-10,16,0,3,0,1;-10,-2,0.5,1,1,0;-11,19,0.5,1,1,1;-11,-4,0.5,1,1,0;-11,-1,0,3,1,0;-11,-5,1,3,1,0;-11,-2,0.5,1,1,0;-11,-6,4,1,1,0;-11,-3,0.5,1,1,0;-11,18,0,3,1,1;-12,19,0.5,1,1,1;-12,-4,0.5,1,1,0;-12,-1,0,3,1,0;-12,-5,1,3,1,0;-12,-2,0.5,1,1,0;-12,-6,4,1,1,0;-12,-3,0.5,1,1,0;-12,18,0,3,1,1;-13,-1,0,3,1,0;-13,-2,0.5,1,1,0;-13,-3,0.5,1,1,0;-13,19,0.5,1,1,1;-13,-5,1,3,1,0;-13,-6,4,1,1,0;-13,7,0,2,1,1;-13,11,0,2,1,0;-13,-4,0.5,1,1,0;-13,18,0,3,1,1;-14,1,4,1,1,0;-14,0,4,1,1,0;-14,-1,4,1,1,0;-14,-2,4,1,1,0;-14,-3,4,1,1,0;-14,19,0.5,1,1,1;-14,-5,4,1,1,0;-14,-6,4,1,1,0;-14,18,0,3,1,1;-14,-4,4,1,1,0;-15,1,4,1,1,0;-15,2,4,1,1,0;-15,3,4,1,1,0;-15,4,4,1,1,0;-15,5,4,1,1,0;-15,6,0.5,1,1,1;-15,7,0.5,1,1,1;-15,8,0.5,1,1,1;-15,18,0,3,1,1;-15,19,0.5,1,1,1;-15,0,4,1,1,0"
function load()
    local s = LEVEL
    for t in all(split(s, ";")) do
        local parts = split(t, ",")
        if parts then
            add_map_tile(parts[1], parts[2], parts[4], parts[3], parts[5] == 1, parts[6] == 1)
        end
    end
    fix_grinds()
    is_editing = false
    del(all_entities, edit_ent)
    --sort_ents()   
end