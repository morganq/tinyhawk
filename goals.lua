level_goals = {
    {
        {name="heelflip the halfpipe gap", type="gap", gap="halfpipe gap", trick="heelflip"},
        {name="ollie the taxi gap", type="gap", gap="taxi gap"},
        {name="land a 360゜ on the halfpipe", type="gap", gap="halfpipe", trick="360"},
        {name="score 10,000◆", type="score", score=.1526},
        {name="score 50,000◆", type="score", score=0.7629},
        {name="score 2,000◆ <= 10-combo", type="c10", score=.0305},
        {name="score 5,000◆ <= 10-combo", type="c10", score=.0763},
        {name="score 5,000◆ <= 5-combo", type="c5", score=.0763},
    }
}

-- RESET SAVE DATA
for i = 0,63 do
    dset(i, 0)
end

function is_goal_complete(levelnum, index)
    return dget((levelnum - 1) * 10 + (index-1)) != 0
end

function update_goals()
    for i = 1, #level_goals[levelnum] do
        local goal = level_goals[levelnum][i]
        if not is_goal_complete(levelnum, i) then
            complete = false
            if goal.type == "score" then
                complete = score >= goal.score
            end
            if #last_combo > 0 and not last_trick_fall then
                if goal.type == "c10" then
                    complete = (#last_combo <= 10 and last_combo_score > goal.score)
                elseif goal.type == "c5" then
                    complete = (#last_combo <= 5 and last_combo_score > goal.score)                
                elseif goal.type == "gap" and #last_combo > 0 then
                    local has_trick = goal.trick == nil
                    for trick in all(last_combo) do
                        if trick.trick == goal.trick then
                            has_trick = true
                        end
                        if trick.trick == goal.gap then
                            complete = true
                        end
                    end
                    if not has_trick then complete = false end
                end
            end
            if complete then
                dset((levelnum-1) * 10 + (i - 1), 1)
                goal_complete_timer = 90
                goal_completed = goal.name
            end

        end
    end
end

goal_complete_timer = 0
--goal_completed = "ollie the half pipe gap"
function draw_goals()
    if goal_complete_timer > 0 then
        goal_complete_timer -= 1
        local x1, x2 = 64 - #goal_completed * 2,64 + #goal_completed * 2
        grungeline(x1 - 4, x2, 10, 17, 10)
        gprint(goal_completed, 64 - #goal_completed * 2, 12, 0, false, 15)
        local t = mid((125 - goal_complete_timer * 2) / 45, 0, 1)
        line(x1 - 3, 14 + pr(x1,0), x1 - 3 + (x2 - x1) * t, 14 + pr(x2,1) * 3 * t, 0)
    end
end