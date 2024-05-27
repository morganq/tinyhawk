MUSICS = split"0,11,24"

function game_init()
    load(level_index)
    fix_grinds()
    skater = make_skater()
    add(all_entities, skater)
    add(all_entities, skater.shadow)
    scroll = {0,0}
    score = 0
    level_specials = {
        {
            ["1>2"] = "halfpipe gap",
            ["3>4"] = "taxi gap",
            ["5>5"] = "halfpipe",
        },
        {
            ["1>2"] = "curb stair",
            ["3>4"] = "pipe transfer",
            ["5>6"] = "caution tape to taxi"
        },
        {
            ["1>6"] = "module gap 1",
            ["2>3"] = "module gap 2",
            ["4>5"] = "eight stair",
            ["7>8"] = "pipe transfer"
        }
    }
    menuitem(1 | 0x300, "trick list",
        function()
            game_mode = "tricks"
        end)
    menuitem(2 | 0x300, "goals",
    function()
        game_mode = "goals"
    end)    
    menuitem(3 | 0x300, "level select",
    function()
        transition()
        set_state("select")
    end)    
    time = 0
    gametime = 0
    goal_complete_timer = 0
    last_combo = {}
    combo = {}
    latest_trick_time = 0
    combo_end_time = 0
    current_combo_score = 0
    last_combo_score = 0    
    timeup = false
    music(rnd(MUSICS))
end


function game_update()
    time = min(time + 1, 32000)
    if game_mode != nil then
        if btnp(4) then game_mode = nil end        
        return
    end
    if gametime < 3599 or #combo == 0 then
        gametime = min(gametime + 1, 32000)
    end
    

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
    if not timeup then
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
        --scroll[1] = mid(scroll[1], -232, 24)
        --scroll[2] = mid(scroll[2], -232, 24)

        if gametime > 3300 and gametime % 30 == 0 then
            skatesnd(gametime == 3600 and 54 or 56)
        end

    else
        if gametime > 3660 then
            if btnp(4) then
                transition()
                set_state("select")
            end
            if btnp(5) then
                transition()
                set_state("game")
            end
        end        
    end
        
    update_inputs()
    skater:update()  
    update_combo()
    update_goals()
end

function game_draw()
    cls(15)
    camera(-scroll[1], -scroll[2])

    render_iso_entities(26, true)
    local p = v2p(skater.pos)
    if skater.grind_line then
        spr(240, p[1] - 8, p[2] - 16, 2, 1)
        spr(242, p[1] + mid(skater.balance,-6,6) - 1.5, p[2] - 16,1 ,1)
    end
    if skater.in_manual then
        spr(227, p[1] + 6, p[2] - 9, 1, 2)
        spr(226, p[1] + 6, p[2] - 3 + mid(skater.balance, -6, 6), 1, 1)
    end
    skater:draw_arrow(1, 12)
    skater:draw_arrow(0, 7)
    camera()

    if gametime < 3600 then
        draw_combo()

        local st = 120 - (gametime \ 30)
        local sst = (st \ 60) .. ":" .. (st % 60 < 10 and ("0" .. st%60) or (st % 60))
        sprint(sst, 64 - #sst, 4, gametime < 2700 and 7 or 8)

        sprint("◆" .. score_str(score), 4, 4, 7)
    else
        timeup = true
        music(-1)
        camera(0, p8cos(mid((gametime - 3600) / 30,0,0.5)) * 64 + 48)
        print("\^w\^ttime's up!", 24, -11, 0)
        print("\^w\^ttime's up!", 24, -12, 7)
        rectfill(2,2,125, 68, 0)
        draw_goal_list(4, 7)
        local ss = score_str(score)
        sprint("◆" .. ss, 116 - #ss * 4, 4, 7)
        
        camera()

        if gametime > 3660 then
            grungebutton("❎ play again", 64, 100, 7, 11)
            grungebutton("🅾️ level select", 64, 115, 7, 8)
        end
    end

    draw_goals()

    if game_mode == "tricks" then
        draw_trick_list()
    elseif game_mode == "goals" then
        rectfill(2,2,125, 69, 0)
        draw_goal_list(4,7)
        grungebutton("🅾️ back", 64, 80, 7, 8)
    end

    --draw_inputs(1,10)
    
    --pal(split"1,2,3,4,5,143,7,8,9,10,11,12,128,14,15,0",1)
    pal(split(LEVEL_PALETTE),1)
end
