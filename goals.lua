level_goals = {{},{},{}}
--8129
goals_str = [[1/score 3,000◆/score/.0458
1/ollie the taxi gap/gap/taxi gap
1/score 10,000◆/score/0.1526
1/chickflip the halfpipe gap/gap/halfpipe gap/chickflip
1/score 1,000◆ <= 10-combo/combo/.0153/10
1/land a 360゜ on the halfpipe/gap/halfpipe/360
1/score 3,000◆ <= 10-combo/combo/.0458/10
1/score 3,000◆ <= 5-combo/combo/.0458/5
2/score 10,000◆/score/.1526
2/score 20,000◆/score/.3052
2/score 2,000◆ <= 10-combo/combo/.0305/10
2/score 5,000◆ <= 10-combo/combo/.0763/10
2/beak grab the curb stair/gap/curb stair/beak grab
2/tail grab the pipe transfer/gap/pipe transfer/tail grab
2/score 5,000◆ <= 5-combo/combo/.1373/5
2/score 3,000◆ <= 2-combo/combo/.0458/2
3/score 15,000◆/score/.2289
3/tre flip the eight stair/gap/eight stair/tre flip
3/score 30,000◆/score/.4578
3/score 7,500◆ <= 5-combo/combo/.1144/5
3/combo both module gaps/gap/module gap 2/module gap 1
3/ufo chicken the pipe transfer/gap/pipe transfer/ufo chicken
3/score 12,500◆ <= 5-combo/combo/.1907/5
3/score 75,000◆/score/1.1444
]]
for row in all(split(goals_str,"\n")) do
    v = split(row, "/")
    add(level_goals[v[1]], {
        name=v[2],
        type=v[3],
        param=v[4],
        param2=v[5]
    })
end

-- RESET SAVE DATA

for i = 0,63 do
    dset(i, 0)
end


function is_goal_complete(levelnum, index)
    return dget((levelnum - 1) * 10 + (index-1)) != 0
end

function update_goals()
    for i = 1, #level_goals[level_index] do
        local goal = level_goals[level_index][i]
        if not is_goal_complete(level_index, i) then
            complete = false
            if goal.type == "score" then
                complete = score >= goal.param
            end
            if #last_combo > 0 and not last_trick_fall then
                if goal.type == "combo" then
                    complete = (#last_combo <= goal.param2 and last_combo_score > goal.param)
                elseif goal.type == "gap" and #last_combo > 0 then
                    local has_trick = goal.param2 == nil
                    for trick in all(last_combo) do
                        if trick.trick == tostr(goal.param2) then
                            has_trick = true
                        end
                        if trick.trick == tostr(goal.param) then
                            complete = true
                        end
                    end
                    if not has_trick then complete = false end
                end
            end
            if complete then
                dset((level_index-1) * 10 + (i - 1), 1)
                goal_complete_timer = 90
                goal_completed = goal.name
                skatesnd(15)
            end

        end
    end
end

goal_complete_timer = 0
function draw_goals()
    if goal_complete_timer > 0 then
        goal_complete_timer -= 1
        local x1, x2 = 64 - #goal_completed * 2,64 + #goal_completed * 2
        grungeline(x1 - 4, x2, 14, 21, 10)
        gprint(goal_completed, 64 - #goal_completed * 2, 16, 0, false, 15)
        local t = mid((125 - goal_complete_timer * 2) / 45, 0, 1)
        line(x1 - 3, 17 + pr(x1,0), x1 - 3 + (x2 - x1) * t, 17 + pr(x2,1) * 3 * t, 0)
    end
end