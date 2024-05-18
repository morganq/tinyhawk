--[[
Cuttable mechanics
 X switch
 - 
]]
--[[
    Credits
code, art: @morganqdev
music: 
 - maple ( https://maple.pet/ )
 - Wasiknighit
]]

function set_state(s, arg)
    if s == "game" then
        _update, _draw = game_update, game_draw
        game_init(arg)
    elseif s == "select" then
        _update, _draw = select_update, select_draw
        select_init(arg)
    end
end

function _init()
    poke(0X5F5C, 255)
    time = 0
end

function _draw()
    time += 1
    cls(1)
    print("code, art:\n- @morganqdev\n\nmusic:\n- maple: https://maple.pet/\n- wasiknighit", 6, 32, split("1,1,5,12,7,7,7,7,7,7")[sin(time / 38)*8\1 + 2])
    if time > 120 then
        set_state("select")
    end
    pal(split"1,2,3,4,140,6,7,8,9,10,11,12,13,14,15,0",1)
end
