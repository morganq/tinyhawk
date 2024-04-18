input_list = {}
trick_inputs = {}
tricks = {}

-- name / input / time / score / ?grind / ?manual / *spins / holdspin / anim
tricks_str = split([[
talonflip/lz/8/100/f/f/0,0,360//
heelflip/rz/12/150/f/f/0,0,-360//
shuvit/uz/8/100/f/f/-180,0,0//
360 flip/dz/15/200/f/f/-360,0,360//
late talonflip/luz/16/400/f/f/90,0,0;0,0,0;-90,0,0//
grind///50/t/f//90,0,0/208
manual/ud//10/f/t//0,30,0/208
]],"\n")


function parse_trick(s)
    local name, input, time, score, grind, manual, _spins, holdspin, anim = unpack(split(s, "/"))
    holdspin = split(holdspin, ",")
    _spins = split(_spins, ";")
    spins = {}
    for spin in all(_spins) do
        if #spin > 0 then
            add(spins, split(spin, ","))
        end
    end
    if #spins == 0 then spins = nil end
    if #holdspin != 3 then holdspin = nil end
    grind = grind == "t"
    manual = manual == "t"
    if input then
        trick_inputs[input] = name
    end
    tricks[name] = {spins=spins, holdspin=holdspin, anim=tonum(anim), time=time, score=score, is_manual=manual, is_grind=grind}
end

for i = 1, #tricks_str - 1 do
    parse_trick(tricks_str[i])
end

function add_input(k)
    add(input_list, {key = k, time = time})
end

function update_inputs()
    if btnp(0) then add_input("l") end
    if btnp(1) then add_input("r") end
    if btnp(2) then add_input("u") end
    if btnp(3) then add_input("d") end
    if btnp(4) then add_input("z") end
    if btnp(5) then add_input("x") end
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