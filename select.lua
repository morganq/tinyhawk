scroll = {0,0}

function select_init()
    time = 0
    load(LEVEL1)
    presort_cells()
    fix_brights()
end

function select_update()
    time += 1
    local v = v2p({2, 0, cos(time / 90) * 9.9 - 15})
    
    scroll[1] = v[1] \2 * 2
    scroll[2] = v[2]

    if btnp(5) then
        transition()
        set_state("game")
    end
end

local function draw_goals()
    local num_complete = 0
    
    local goals = level_goals[1]
    for i = 1, #goals do
        local complete = is_goal_complete(1, i)
        local x = gprint(goals[i].name, 3, i * 7 + 62, complete and 15 or 7)
        if complete then
            line(1, i * 7 + 64 + pr(i,0) * 3, x, i * 7 + 63 + pr(i,1) * 3, 6)
            num_complete += 1
        end
    end
    gprint(num_complete .. "/" .. #goals, 3, 60, 6)
end

function select_draw()
    cls(1)
    rectfill(0,0,127,64,15)
    --line(-1,32,62,1,7)
    --line(128,33,63,1,7)
    camera(-scroll[1], -scroll[2] + 32)
    render_iso_entities(14, false)
    
    camera()    
    pal(2,1)
    for i = -1,8 do
        for j = 8,14 do
            spr(32, i * 8 + j * 8, j * 4 - i * 4 + 25, 2, 2)
        end
    end
    for i = -6,-1 do
        for j = -1,14 do
            spr(32, i * 8 + j * 8, j * 4 - i * 4 + 25, 2, 2)
        end
    end    
    pal()    
    line(63,64,-1,32,7)
    line(64,64,129,32,7)

    draw_goals()

    grungeline(40, 88, 18, 27, 11)
    print("❎ play", 52, 20, (time \ 6 % 2 == 0) and 7 or 7)

    local t = "\^w\^twAREHOUSE"
    local x = print(t, 0, -20)
    print(t, 65 - x \ 2, 4, 0)
    print(t, 64 - x \ 2, 3, 7)

    pal(split"1,2,3,4,140,15,7,8,9,10,139,12,140,14,134,0",1)
end