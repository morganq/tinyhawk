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
    set_state("game")
end
