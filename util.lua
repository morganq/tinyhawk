-- Use "normal" sin and cos fns rather than p8's
p8cos = cos function cos(angle) return p8cos(angle/(3.1415*2)) end
p8sin = sin function sin(angle) return -p8sin(angle/(3.1415*2)) end
p8atan2 = atan2 function atan2(x,y) return p8atan2(x,-y) * 6.2818 end


----- VECTORS -----
function v_add(a,b) return {a[1] + b[1], a[2] + b[2], a[3] + b[3]} end
function v_sub(a,b) return {a[1] - b[1], a[2] - b[2], a[3] - b[3]} end
function v_mul(a,s) return {a[1] * s, a[2] * s, a[3] * s} end

-- Special vector mag function which does not easily overflow on big distances
function v_mag(v)
    local d=max(max(abs(v[1]),abs(v[2])),abs(v[3]))
    local x,y,z=v[1]/d,v[2]/d,v[3]/d
    return (x*x+y*y+z*z)^0.5*d
end
function v_mag_sq(v)
    local d=max(max(abs(v[1]),abs(v[2])),abs(v[3]))
    local x,y,z=v[1]/d,v[2]/d,v[3]/d
    return (x*x+y*y+z*z)*d    
end
function v_norm(v)
	local d = v_mag(v)
	return {v[1] / d, v[2] / d, v[3] / d}
end
function v_cross(a,b)
	return {a[2] * b[3] - b[2] * a[3], a[3] * b[1] - b[3] * a[1], a[1] * b[2] - b[1] * a[2]}
end
function v_dot(a,b) return a[1]*b[1] + a[2] * b[2] + a[3] * b[3] end

function v_zero() return {0,0,0} end
function v_copy(v) return {v[1], v[2], v[3]} end

function v_fwd_lateral(point, forward, forward_len, side_len, flatten)
    local fwd_norm = v_norm({forward[1], flatten and 0 or forward[2], forward[3]})
    local side_norm = {fwd_norm[3], fwd_norm[2], -fwd_norm[1]}
    return v_add(point, v_add(
        v_mul(fwd_norm, forward_len),
        v_mul(side_norm, side_len)
    ))
end

function v_flat(v) return {v[1], 0, v[3]} end


function v2p(v)
    return {
        v[1] * -8 + v[3] * 8 + 64,
        v[1] * 4 + v[3] * 4 + v[2] * -8 + 64
    }
end

function p2v(p)
    local x, y = p[1] - 64 - scroll[1], p[2] - 64 - scroll[2]
    return {
       (x / -8 + y / 4) / 2,
        0,
       (y / 4 + x / 8) / 2,
    }
end
function insert_cmp(a, v, cmp)
    for i=1,#a do
        if cmp(a[i],v) then
            add(a, v, i)
            return
        end
    end
    add(a,v,i)
end

function sign(x) return x > 0 and 1 or -1 end

function get_cells_within(pt, range)
    local cells = {}
    for x = pt[1] - range, pt[1] + range do
        for z = pt[3] - range, pt[3] + range do
            local cell = get_cell({x,0,z})
            if cell then
                add(cells, cell)
            end
        end
    end
    return cells
end

function pr(x, y)
    return sin(v_dot({x,y,0}, v_mul({12.9898, 78.233,0}, 20.0437))) % 1
end

function gprint(t, x, y, c, jitter)
    local xo, yo, i = 0,0,1
    local tt = jitter and time \ jitter or 0
    while i <= #t do
        local char = t[i]
        if char == "ᶜ" then
            c = tonum(t[i + 1],0x1)
            i += 1
        else
            yo = pr(x, y + tt) * 1.8
            x = print(char, x + xo, y + yo, c)
        end
        i += 1
    end
    return x
end

function grungeline(x1, x2, y1, y2, c)
    tt = time \ 12 * 10
    for y = y1, y2, 0.5 do
        local dx1 = x1 + pr(x1,y + tt) * 4
        local dx2 = x2 + pr(x2,y + tt) * 4
        local dy1 = y + pr(y1,y + tt) * 3 - pr(tt+1,tt) * 3
        local dy2 = y + pr(y2,y + tt) * 3 - pr(tt,tt+1) * 3
        line(dx1, dy1, dx2, dy2, c)
        line(dx1+1, dy1+1, dx2+1, dy2+1, c)
    end    
end

function grungebutton(text, x, y, fg, bg)
    local w = print(text, 0, -10)
    local x = x - w / 2
    grungeline(x - 7, x + w + 7, y - 2, y + 7, bg)
    sprint(text, x, y, fg)    
end

function sprint(t, x, y, c)
    print(t, x, y + 1, 0)
    print(t, x, y, c)
end

function transition()
    skatesnd(49)
    fillps = split"0b0101101001011010.1, 0b1010010110100101.1, 0b1011111010111110.1, 0b1111101011111010.1"
    --fillps = {0b1011111010111110.1, 0b0111110101111101.1, 0b1111101011111010.1, 0b1111010111110101.1}
    --pal(split"1,2,3,5,140,15,7,8,9,10,11,12,140,14,134,0",1)
    local speed = 0
    local drips = {}
    for i = 0, 47 do
        
        local rad = sin(i / 15) * 6 + 15
        function cf(x,y,rad,c)
            fillp(rnd(fillps))
            circfill(x, y, rad, c)
            if rnd() < 0.02 then
                add(drips, {x, y, min(rad,4), rnd()})
            end
        end
        function paint(x,y)
            for i = 0, 5 do
                theta = rnd() * 6.2818
                local ox, oy = cos(theta) * (rad + rnd() * 7 - 1), sin(theta) * (rad + rnd() * 7 - 1)
                cf(x + ox, y + oy, rnd(3) + 3, 0)
            end
            cf(x, y, rad, 0)
        end
        for z = 0, 6 do
            local t = i + z / 7
            local x = cos(t / 2) * -64 + 64
            local y = t * 3.5 - x / 4
            paint(x,y)
        end
        fillp()
        for drip in all(drips) do
            for i = 1, 6 do
                circfill(drip[1], drip[2], drip[3], 0)
                drip[2] += drip[4]
                drip[4] -= 0.004
            end
        end
        flip()
        
    end
    fillp()
end

function skatesnd(ind, r)
    -- sounds are in order of priority
    if ind >= stat(46) and time != last_sound_time then
        sfx(ind, 0, rnd(r)\1, r and 2 or -1)
        last_sound_time = time
    end
end