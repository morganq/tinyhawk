--TODO: model data as strings
--TODO: tricks as strings

poke(0x5F2D, 0x1)
poke(0X5F5C, 255)
scroll = {0,0}
debugs = {}
local is_editing = true
SHOW_DEPTH = false
LEVEL_BORDERS = {-16.9, 1.9, -8.9, 19.9}
selected_tile = 0
edit_ent = {}

tile_groups = {
    split"block,hblock1,hblock2",
    split"ramp1,ramp2",
    split"rail1,rail2,rail3,rail4,rail5",
    split"qp",
    split"taxi1,taxi2",
    split"floor1,floor2,floor3,floor4,floor5",
    split"wall1",
}
edit_tile_group = 1
tile_special = 0

function _init()
    score = 0
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
    mv = p2v({mx, my})
    mv[1] = mv[1]\1
    mv[3] = mv[3]\1

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
            
        elseif btn(4) then
            skater:hold_grind()
        end
        skater:trick()
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
            skater.pos[2] += 4
        else
            add(all_entities, edit_ent)
        end
    end

    if symbol == "g" then
        fix_grinds()
    end

    if symbol == "l" then
        load(LEVEL1)
        fix_grinds()
        is_editing = false
        del(all_entities, edit_ent)
    end

    if symbol == "w" then
        SHOW_DEPTH = not SHOW_DEPTH
    end

    if symbol == "y" then
        tile_special = (tile_special + 1) % 10
    end

    if is_editing then  
        if (symbol == "1") edit_tile_group = 1
        if (symbol == "2") edit_tile_group = 2
        if (symbol == "3") edit_tile_group = 3
        if (symbol == "4") edit_tile_group = 4
        if (symbol == "5") edit_tile_group = 5
        if (symbol == "6") edit_tile_group = 6
        if (symbol == "7") edit_tile_group = 7
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

        if (mb & 0b01) != 0 and not mbs[1] then
            local cell = add_map_tile(mv[1], mv[3], selected_tile, editor_elev, editor_fliph, editor_flipv, tile_special)
            tile_special = 0
            presort_cells()
            
        end
        if (mb & 0b10) != 0 and not mbs[2] then
            editor_sel += 1
        end
        editor_sel = (editor_sel - 1) % #tile_groups[edit_tile_group] + 1
        editor_elev = mid(editor_elev + stat(36) / 2, 0, 15)
    end    

    selected_tile = 0
    for ti = 1, #tiles do
        if tiles[ti].name == tile_groups[edit_tile_group][editor_sel] then
            selected_tile = ti
            break
        end
    end    

    mbs[1] = (mb & 0b01) != 0
    mbs[2] = (mb & 0b10) != 0      
end
editor_sel = 1

function _draw()
    cls(15)
    camera(-scroll[1], -scroll[2])

    if is_editing then
        local t = tiles[selected_tile]
        edit_ent.center = mv
        edit_ent.height = editor_elev + 1
        edit_ent.depth = get_depth(edit_ent)
        edit_ent.draw = function(self)
            isospr(t.s1, t.s2, mv, t.height, editor_elev, editor_fliph, editor_flipv, true, true)
        end
        sort(all_entities, axissort)
    end
    render_iso_entities(24, true)
    for ent in all(all_entities) do
        if ent.cell and ent.cell.special then
            local p = v2p(ent.center)
            print(ent.cell.special, p[1] - 1, p[2] - 3, 2, 10)
        end
    end

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
            isospr(14,14, mv, 1, cell.elev, false, false, false, false)
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
    print(tile_special, 120, 2, 10)
    --pal(split"1,2,3,4,5,143,7,8,9,10,11,12,128,14,15,0",1)
    pal(split"1,2,3,5,140,15,7,8,9,10,11,12,140,14,134,0",1)
end

function save()
    local string = ""
    for x, zs in pairs(map) do
        for z, cell in pairs(zs) do
            local extra = ""
            if cell.special and cell.special > 0 then
                extra = "," .. cell.special
            end
            string ..= x .. "," .. z .. "," .. cell.elev .. "," .. cell.index .. "," .. (cell.fliph and 1 or 0) .. "," .. (cell.flipv and 1 or 0) .. extra .. ";"
        end
    end    
    printh(string)
end
