input_list = {}
trick_inputs = {
    l = "talonflip",
    ll = "late talonflip",
    r = "heelflip",
    u = "shuvit",
    d = "360 flip",
    du = "hardflip",
    ud = "manual",
    --[[du = "impossible",
    lr = "fs 360",
    rl = "bs 360",
    ]]
}

-- yaw pitch roll
tricks = {
    talonflip = {spins = {{0, 0, 360}}, time = 8, score = 100},
    ["late talonflip"] = {spins = {{90, 0, 0}, {0, 0, 0}, {-90, 0, 0}}, time = 16, score = 400},
    heelflip = {spins = {{0, 0, -360}}, time = 13, score = 150},
    shuvit = {spins = {{-180, 0, 0}}, time = 8, score = 100},
    ["360 flip"] = {spins = {{-360, 0, 360}}, time = 15, score = 200},
    hardflip = {spins = {{-180, 0, 360}}, time = 15, score = 200},
    grind = {score = 50, is_grind = true},
    manual = {score = 10, is_manual = true},
}

function add_input(k)
    add(input_list, {key = k, time = time})
end

function update_inputs()
    if btnp(0) then add_input("l") end
    if btnp(1) then add_input("r") end
    if btnp(2) then add_input("u") end
    if btnp(3) then add_input("d") end
    while #input_list > 0 and time > input_list[1].time + 11 do
        deli(input_list, 1)
    end
end

function try_get_trick()
    local key_len = 4
    for kl = min(#input_list, key_len), 1, -1 do
        
        local test_key = ""
        for i = #input_list - kl + 1, #input_list do
            test_key ..= input_list[i].key
        end
        if trick_inputs[test_key] then
            local t = trick_inputs[test_key]
            input_list = {}
            return t
        end
    end
    return nil
end

function draw_inputs(x,y)
    for i in all(input_list) do
        print(i.key, x, y, 12)
        x += 8
    end
end

last_combo = {}
combo = {}
latest_trick_time = 0
combo_end_time = 0
current_combo_score = 0
last_combo_score = 0
function draw_combo()
    if #combo > 0 then
        if #combo > 1 then
            local s1 = "X" .. #combo .. " = " .. current_combo_score
            print(s1, 64 - #s1 * 2, 100, 12)
        end
        local latest_trick = combo[#combo]
        local s2 = latest_trick.trick .. " " .. latest_trick.final_score
        print(s2, 64 - #s2 * 2, 109 - latest_trick_time / 4, 7)
    elseif combo_end_time > 0 then
        local s2
        if #last_combo > 1 then
            s2 = #last_combo .. " trick combo"
        else
            s2 = last_combo[1].trick
        end
        print(s2, 64 - #s2 * 2, 109 + (60 - combo_end_time) / 15, last_trick_fall and 8 or 9)
        local s3 = tostr(last_combo_score)
        print("\^w\^t" .. s3, 64 - #s3 * 4, 92 + (60 - combo_end_time) / 15, last_trick_fall and 8 or 10)
    end
end

function add_combo(trick)
    local score = tricks[trick].score
    add(combo, {trick = trick, score = score, duration = 1, final_score = score})
    latest_trick_time = 10
end
function increment_combo()
    combo[#combo].duration += 1/30
end
function update_combo()
    latest_trick_time = max(latest_trick_time - 1, 0)
    combo_end_time = max(combo_end_time - 1, 0)
    current_combo_score = 0
    for i = 1, #combo do
        if i == #combo then
            local latest_trick = combo[#combo]
            combo[i].final_score = ((latest_trick.score * latest_trick.duration) \ 10) * 10
        end
        current_combo_score += combo[i].final_score * #combo
    end
end
function end_combo(fall)
    fall = fall or false
    if #combo > 0 then
        last_trick_fall = fall
        last_combo = combo
        last_combo_score = current_combo_score
        combo = {}
        combo_end_time = 60
    end
end