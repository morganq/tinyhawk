poke(0X5F5C, 255)

scroll = {0,0}
debugs = {}
LEVEL_BORDERS = {-16.9, 1.9, -8.9, 19.9}

function _init()
    load(LEVEL1)    
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
        
    update_inputs()
    skater:update()  
    update_combo()
end

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

    render_iso_entities()


    camera()


    draw_inputs(2, 2)
    draw_combo()
    --pal(split"1,2,3,4,5,143,7,8,9,10,11,12,128,14,15,0",1)
    pal(split"1,2,3,4,140,15,7,8,9,10,11,12,140,14,134,0",1)
end
