CLEVEL = 1
CLEVELS = "/1,2,3,5,140,15,7,8,9,10,139,12,140,14,134,0/wAREHOUSE/-1.5,2,-5.5:"
--CLEVELS = "/129,2,3,1,1,12,7,8,9,10,139,12,140,14,5,0/cITY/-7,0,4:"
--CLEVELS = "/130,2,3,5,133,15,7,8,9,10,139,12,133,14,134,0/sCHOOL/-15,2,16:"

--TODO: model data as strings
--TODO: tricks as strings

poke(0x5F2D, 0x1)
poke(0X5F5C, 255)
scroll = {0,0}
debugs = {}
SHOW_DEPTH = false
minx, maxx, minz, maxz = -20, 20, -20, 20
selected_tile = 0
edit_ent = {}

tile_groups = {
    split"block,hblock1,hblock2,stair",
    split"ramp1,ramp2",
    split"rail1,rail2,rail3,rail4,rail6,rail7,stairrail",
    split"qp,barrier2",
    split"taxi1,taxi2,fence,door,cop1,cop2",
    split"floor1,floor2,floor3,floor4,floor5,floor6,floor7,floor8,floor9,floor10,floor11",
    split"module",
}
edit_tile_group = 1
tile_special = 0

function _init()
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

    if btn(0) then
        scroll[1] += 4
    end
    if btn(1) then
        scroll[1] -= 4
    end
    if btn(2) then
        scroll[2] += 4
    end
    if btn(3) then
        scroll[2] -= 4
    end                        

        
    --update_inputs()
    --skater:update()  
    --update_combo()

    local symbol = ""
    if stat(30) then
        symbol = stat(31)    
    end  

    if symbol == "g" then
        fix_grinds()
    end

    if symbol == "l" then
        load(CLEVEL)
        fix_grinds()
    end

    if symbol == "w" then
        SHOW_DEPTH = not SHOW_DEPTH
    end

    if symbol == "y" then
        tile_special = (tile_special + 1) % 10
    end

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

    local t = tiles[selected_tile]
    edit_ent.center = mv
    edit_ent.height = editor_elev + 1
    edit_ent.depth = get_depth(edit_ent) + 1
    edit_ent.draw = function(self)
        isospr(t.s1, t.s2, mv, t.height, editor_elev, editor_fliph, editor_flipv, true, true, {}, t.prefab)
    end
    del(all_entities, edit_ent)
    insert_cmp(all_entities, edit_ent, function(a,b) return a.depth > b.depth end)

    render_iso_entities(24, false)
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

    if time \ 10 % 2 == 0 then
        local cell = get_cell(mv)
        isospr(14,14, mv, 0.5, 0, false, false, false, false)
        if cell then
            isospr(238,238, mv, 1, cell.elev, false, false, false, false)
            local p = v2p(mv)
            --line(p[1], p[2] + 8, p[1], p[2] - (cell.elev) * 8, 8)            
        end
            isospr(14,14, mv, 1, editor_elev, false, false, false, false)
            local p = v2p(mv)
            --line(p[1], p[2] + 8, p[1], p[2] - (editor_elev) * 8, 8)               
        
    end

    camera()
    spr(1, mx, my)
    --print(stat(0), 1, 100, 11)
    --draw_inputs(2, 2)
    --draw_combo()
    print(tile_special, 120, 2, 10)
    --pal(split"1,2,3,5,140,15,7,8,9,10,139,12,140,14,134,0",1)
    --pal(split"129,2,3,1,1,12,7,8,9,10,11,12,140,14,5,0",1)
    pal(split(LEVEL_PALETTE),1)
end

function save()
    local string = ""
    
    local minx, minz, maxx, maxz = 99, 99, -99, -99
    for x, zs in pairs(map) do
        for z, cell in pairs(zs) do
            if cell then
                if x < minx then minx = x end
                if x > maxx then maxx = x end
                if z < minz then minz = z end
                if z > maxz then maxz = z end
            end
        end
    end
    string ..= minx .. "/" .. maxx .. "/" .. minz .. "/" .. maxz .. CLEVELS
    for x = minx, maxx do
        for z = minz, maxz do
            local cell = get_cell({x,0,z})
            if cell then
                string ..= cell.index 
                local cs = cell.special and cell.special > 0
                if cell.elev > 0 or cell.fliph or cell.flipv or cs then
                    string ..= "," .. cell.elev
                end
                if cell.fliph or cell.flipv or cs then
                    string ..= "," .. (cell.fliph and 1 or 0)
                end
                if cell.flipv or cs then
                    string ..= "," .. (cell.flipv and 1 or 0)
                end
                if cs then
                    string ..= "," .. cell.special
                end                
            end
            string ..= ";"
        end
    end
    printh(string, "@clip")
end