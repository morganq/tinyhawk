scroll = {0,0}

function select_init()
    time = 0
    music(39)
end

function select_update()
    time += 1
    local oi = level_index
    if btnp(0) then
        level_index -= 1
    elseif btnp(1) then
        level_index += 1
    end
    level_index = mid(level_index, 1, 3)
    if level_index != oi or time == 1 then
        skatesnd(57)
        load(level_index)
        presort_cells()
        fix_brights()        
        level_time = 0
    end       
    if btn(5) and level_time > 4 then
        transition()
        set_state("game")
    end       
    local v = v2p({minx + 7, 0, minz + (sin(time / 90) + 2.5) * (maxz - minz) * 0.2})
    
    scroll[1] = 64 - v[1] \2 * 2
    scroll[2] = 64 - v[2]    
    level_time += 1
end

function draw_goal_list(x, y, t)
    local num_complete = 0
    t = t or 999
    
    local goals = level_goals[level_index]
    for i = 1, min(#goals, t \ 2) do
        local complete = is_goal_complete(i)
        local xo = gprint(goals[i].name, x, i * 7 + y - 1, complete and 15 or 7)
        if complete then
            line(x + 1, i * 7 + y + 1 + pr(i,0) * 3, x + xo, i * 7 + y + pr(i,1) * 3, 6)
            num_complete += 1
        end
    end
    gprint(num_complete .. "/" .. #goals, x, y - 3, 6)
end

function select_draw()
    cls(1)
    rectfill(0,0,127,64,15)
    --line(-1,32,62,1,7)
    --line(128,33,63,1,7)
    camera(-scroll[1], -scroll[2] + 32)
    render_iso_entities(20, false)
    
    camera()    
    pal(2,1)
    for i = -1,8 do
        for j = 8,12 do
            spr(32, i * 8 + j * 8, j * 4 - i * 4 + 25, 2, 2)
        end
    end
    for i = -6,-1 do
        for j = -1,12 do
            spr(32, i * 8 + j * 8, j * 4 - i * 4 + 25, 2, 2)
        end
    end    
    rectfill(0,64,127,127,1)
    pal()    
    line(63,64,-1,32,7)
    line(64,64,129,32,7)

    draw_goal_list(1, 63, level_time)

    grungebutton("❎ play", 64, 20, 7, 11)

    local t = "\^w\^t" .. level_name
    local x = print(t, 0, -20)
    print(t, 65 - x \ 2, 4, 0)
    print(t, 64 - x \ 2, 3, 7)
    local cc = time \ 10 % 2 == 0 and 7 or 11
    if level_index > 1 then
        sprint("◀", 8, 6, cc)
    end
    if level_index < 3 then
        sprint("▶", 112, 6, cc)
    end    

    pal(split(LEVEL_PALETTE),1)  
end