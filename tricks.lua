input_list = {}
trick_inputs = {
    l = "kickflip",
    r = "heelflip",
    u = "shuvit",
    d = "360 flip",
    ud = "hardflip",
    du = "impossible",
    lr = "fs 360",
    rl = "bs 360",
}

function add_input(k)
    add(input_list, {key = k, time = time})
end

function update_inputs()
    if btnp(0) then add_input("l") end
    if btnp(1) then add_input("r") end
    if btnp(2) then add_input("u") end
    if btnp(3) then add_input("d") end
    while #input_list > 0 and time > input_list[1].time + 15 do
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
function draw_combo()
    if #combo > 0 then
        if #combo > 1 then
            local s1 = "X" .. #combo
            print(s1, 64 - #s1 * 2, 100, 12)
        end
        local s2 = combo[#combo].trick
        print(s2, 64 - #s2 * 2, 109 - latest_trick_time / 4, 8)
    elseif combo_end_time > 0 then
        local s2 = #last_combo .. " trick combo"--last_combo[#last_combo].trick
        print(s2, 64 - #s2 * 2, 109 + (60 - combo_end_time) / 15, 0)
    end
end

function add_combo(trick)
    add(combo, {trick = trick})
    latest_trick_time = 10
end
function update_combo()
    latest_trick_time = max(latest_trick_time - 1, 0)
    combo_end_time = max(combo_end_time - 1, 0)
end
function end_combo()
    if #combo > 0 then
        last_combo = combo
        combo = {}
        combo_end_time = 60
    end
end