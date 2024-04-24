
debugs = {}
LEVEL_BORDERS = {-16.9, 1.9, -8.9, 19.9}
levelnum = 1

function game_init()
    load(LEVEL1)
    fix_grinds()
    skater = make_skater()
    add(all_entities, skater)
    add(all_entities, skater.shadow)
    add(all_entities, edit_ent)
    scroll = {0,0}
    score = 0
    level_specials = {
        ["1>2"] = "halfpipe gap",
        ["3>4"] = "taxi gap",
        ["5>5"] = "halfpipe",
    }
end

time = 0
local mbs = {false, false}
local editor_elev = 0
local editor_fliph = false
local editor_flipv = false
local rotations = {{false, false}, {true, false}, {false, true}, {true, true}}
local rotation = 0
function game_update()

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
    update_goals()
end

local borders = {
    {LEVEL_BORDERS[1], 0, LEVEL_BORDERS[3]},
    {LEVEL_BORDERS[2], 0, LEVEL_BORDERS[3]},
    {LEVEL_BORDERS[2], 0, LEVEL_BORDERS[4]},
    {LEVEL_BORDERS[1], 0, LEVEL_BORDERS[4]},
    {LEVEL_BORDERS[1], 0, LEVEL_BORDERS[3]},
}

function game_draw()
    cls(15)
    camera(-scroll[1], -scroll[2])
    line()
    for i = 1, 5 do
        local v = v2p(borders[i])
        line(v[1], v[2], 7)
    end

    render_iso_entities(26, true)
    camera()


    --draw_inputs(4, 12)
    draw_combo()

    if time < 3600 then
        local st = 120 - (time \ 30)
        local sst = (st \ 60) .. ":" .. (st % 60 < 10 and ("0" .. st%60) or (st % 60))
        sprint(sst, 64 - #sst, 4, time < 2700 and 7 or 8)

        sprint("◆" .. score_str(score), 4, 4, 7)
    end

    draw_goals()
    
    --pal(split"1,2,3,4,5,143,7,8,9,10,11,12,128,14,15,0",1)
    pal(split"1,2,3,5,140,15,7,8,9,10,11,12,140,14,134,0",1)
end
