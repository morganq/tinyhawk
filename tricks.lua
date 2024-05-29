input_list = {}
trick_inputs = {}
tricks = {}

-- name / input / time / score / ?grind / ?manual / *spins / holdspin / anim
-- ⬅️➡️⬆️⬇️🅾️❎
tricks_str = split([[
chickflip/⬅️🅾️/8/100/f/f/0,0,360//
hospital flip/⬅️⬇️🅾️/12/300/f/f/0,0,180;0,180,0//
underflip/➡️⬇️🅾️/12/300/f/f/90,0,0;270,0,360//
heelflap/➡️🅾️/12/150/f/f/0,0,-360//
shuvit/⬆️🅾️/6/100/f/f/-180,0,0//
360 shuv/⬆️⬇️🅾️/11/250/f/f/-360,0,0//
tre flip/⬇️🅾️/13/200/f/f/-360,0,360//
beak grab/⬆️⬆️🅾️/15/330/f/f//0,45,0/209
rocket air/⬆️⬆️⬆️🅾️/25/650/f/f//0,15,0/199
tail grab/⬇️⬇️🅾️/15/310/f/f//0,-45,0/210
crossbone/➡️➡️🅾️/13/300/f/f//45,0,0/225
judo air/⬅️⬅️🅾️/16/400/f/f//-45,0,0/224
chickflip cancel/⬅️➡️🅾️/20/500/f/f/0,0,270;0,0,-270//
ufo bird/⬅️⬆️➡️🅾️/31/1200/f/f/720,0,0//228
egg/⬅️⬇️➡️⬆️🅾️/35/1200/f/f/0,0,0//229
grind///100/t/f//90,0,0/208
manual/⬆️⬇️//40/f/t//0,30,0/208
headstand/⬆️⬆️⬇️//70/f/t//0,30,0/228
casper slide/⬇️⬇️⬆️//60/f/t//0,30,180/208
nose manual/⬇️⬆️//50/f/t//0,-30,0/208
taxi gap///200/f/f////
halfpipe gap///200/f/f////
halfpipe///0/f/f////
module gap 1///400/f/f////
module gap 2///400/f/f////
eight stair///200/f/f////
central rail///150/f/f////
curb stair///300/f/f////
pipe transfer///200/f/f////
caution tape to taxi///300/f/f////
180///180/f/f////
360///360/f/f////
540///540/f/f////
720///720/f/f////
900///900/f/f////
1080///1080/f/f////
]],"\n")

function draw_trick_list()
    local trick_strings = split([[
ᶜb❎ ᶜ6ollie
ᶜ8🅾️ ᶜ6grind
manuals-
⬆️⬇️ ᶜ6manual
⬇️⬆️ ᶜ6nose manual
flip trix-
⬆️ᶜ8🅾️ ᶜ6shuv it
⬅️ᶜ8🅾️ ᶜ6chickflip
➡️ᶜ8🅾️ ᶜ6heelflap
⬇️ᶜ8🅾️ ᶜ6tre flip
grabs-
⬆️⬆️ᶜ8🅾️ ᶜ6beak grab
⬇️⬇️ᶜ8🅾️ ᶜ6tail grab
magic-
⬅️⬆️➡️ᶜ8🅾️ ᶜ6ufo bird
... and many more??
]],"\n")
    
    rectfill(0,0,127,127, 0)
    --camera(0,sin(time/32)*24)
    for i,ts in ipairs(trick_strings) do
        gprint(ts, 2, i * 8 - 8, 7)
        --print(ts, 2, i * 8 - 8, 7)
    end
    --camera()
    grungebutton("🅾️ back", 95, 8, 7, 8)
end

function parse_trick(s)
    local name, input, time, score, grind, manual, _spins, holdspin, anim = unpack(split(s, "/"))
    name = tostr(name)
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
    if #input>0 then
        trick_inputs[input] = name
    end
    tricks[name] = {spins=spins, holdspin=holdspin, anim=tonum(anim), time=time, score=score * 0x.0001, is_manual=manual, is_grind=grind}
end


for i = 1, #tricks_str - 1 do
    parse_trick(tricks_str[i])
end

function add_input(k)
    add(input_list, {key = k, time = time})
end

function update_inputs()
    for i,b in ipairs(split"⬅️,➡️,⬆️,⬇️,🅾️,❎") do
        if btnp(i-1) then add_input(b) end
    end
    while #input_list > 0 and time > input_list[1].time + 11 do
        deli(input_list, 1)
    end
end

function try_get_trick()
    local key_len = 5
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

function score_str(s)
    return tostr(s, 0x2)
end

function draw_combo()
    if #combo > 0 then
        if #combo > 1 then
            local s1 = "X" .. #combo .. " = " .. score_str(current_combo_score)
            sprint(s1, 64 - #s1 * 2, 100, 12)
        end
        local latest_trick = combo[#combo]
        local s2 = latest_trick.trick .. " " .. score_str(latest_trick.final_score)
        sprint(s2, 64 - #s2 * 2, 109 - latest_trick_time / 4, 7)
    elseif combo_end_time > 0 then
        local s2
        if #last_combo > 1 then
            s2 = (#last_combo - 1) .. " trick combo + " .. last_combo[#last_combo].trick
        else
            s2 = last_combo[1].trick
        end
        sprint(s2, 64 - #s2 * 2, 109 + (60 - combo_end_time) / 15, last_trick_fall and 8 or 9)
        local s3 = score_str(last_combo_score)
        sprint("\^w\^t" .. s3, 64 - #s3 * 4, 92 + (60 - combo_end_time) / 15, last_trick_fall and 8 or 10)
    end
end

function add_combo(trick)
    local score = tricks[trick].score
    add(combo, {trick = trick, score = score, duration = 1, final_score = score})
    latest_trick_time = 10
    skatesnd(52)
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
            combo[i].final_score = (latest_trick.score * latest_trick.duration)
        end
        current_combo_score += combo[i].final_score * #combo
    end
end
function end_combo(fall)
    fall = fall or false
    if #combo > 0 then
        if not fall then
            score += current_combo_score
        end
        last_trick_fall = fall
        last_combo = combo
        last_combo_score = current_combo_score
        combo = {}
        combo_end_time = 60
    end
end