-- Use "normal" sin and cos fns rather than p8's
p8cos = cos function cos(angle) return p8cos(angle/(3.1415*2)) end
p8sin = sin function sin(angle) return -p8sin(angle/(3.1415*2)) end
p8atan2 = atan2 function atan2(x,y) return p8atan2(x,-y) * 6.2818 end
function tan(angle) return sin(angle) / cos(angle) end


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
function copy(t) 
    local t2 = {}
    for v in all(t) do add(t2, v) end
    return t2
end

function pv(v, label)
    printh((label or "") .. v[1] .. "," .. v[2] .. "," .. v[3])
end

function v2p(v)
    return {
        v[1] * -8 + v[3] * 8 + 64,
        v[1] * 4 + v[3] * 4 + v[2] * -8 + 64
    }
end

function p2vi(p)
    local v = p2v(p)
    return {v[1]\1, v[2]\1, v[3]\1}
end

function p2v(p)
    local x, y = p[1] - 64 - scroll[1], p[2] - 64 - scroll[2]
    return {
       (x / -8 + y / 4) / 2,
        0,
       (y / 4 + x / 8) / 2,
    }
end

function sort(a,cmp)
    for i=1,#a do
        local j = i
        while j > 1 and cmp(a[j-1],a[j]) do
            a[j],a[j-1] = a[j-1],a[j]
            j -= 1
        end
    end
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

-- opt: can delete
function tostring(any)
    if (type(any)~="table") return tostr(any)
    local str = "{"
    for k,v in pairs(any) do
      if (str~="{") str=str..","
      str=str..tostring(k).."="..tostring(v)
    end
    return str.."}"
end

--[[
function gprint(t, x, y, c)
    clip(0,0, 127,y + 2)
    print(t, x+1, y, c)
    clip(0,y+2, 127,127)
    print(t, x, y, c)
    clip()
end
]]

function pr(x, y)
    return sin(v_dot({x,y,0}, v_mul({12.9898, 78.233,0}, 20.0437))) % 1
end

function gprint(t, x, y, c, shadow, jitter)
    local xo, yo = 0,0
    local tt = jitter and time \ jitter or 0
    for char in all(t) do
        yo = pr(x, y + tt) * 1.8
        if shadow then
            print(char, x + xo, y + yo + 1, 0)
        end
        x = print(char, x + xo, y + yo, c)
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

function sprint(t, x, y, c)
    print(t, x, y + 1, 0)
    print(t, x, y, c)
end

--[[
function transition()
    palt(14, true)
    palt(0, false)
    pal(split"1,2,3,5,140,15,7,8,9,10,11,12,140,14,134,0",1)
    for i = 0, 63 do
        local t = i / 64
        local function ds(col, c)
            local t = (i - abs(col) * 2 - 2) * 3
            local y1 = col * 8 + 32
            local y = col * 8 + t * 2 + 32
            local x = t * 4
            if t > 0 then
                for j = 0, 7 do
                    line(0, y1 + j, x, y + j, c)
                end
            end
            spr(220, x, y, 4, 3)
        end
        for j = 0, 12 do 
            ds(j, j % 2 == 0 and 5 or 7)
            ds(-j, j % 2 == 0 and 5 or 7)
        end
        flip()
    end
    palt()
end
]]

function transition()
    fillps = {0b0101101001011010.1, 0b1010010110100101.1}
    pal(split"1,2,3,5,140,15,7,8,9,10,11,12,140,14,134,0",1)
    local speed = 0
    for i = 0, 63 do
        local rad = sin(i / 15) * 6 + 14
        function cf(x,y,rad,c)
            fillp(rnd(fillps))
            circfill(x, y, rad, c)
            
        end
        function paint(x,y)
            for i = 0, 5 do
                theta = rnd() * 6.2818
                local ox, oy = cos(theta) * (rad + rnd() * 7 - 1), sin(theta) * (rad + rnd() * 7 - 1)
                cf(x + ox, y + oy, rnd(3), 0)
            end
            cf(x, y, rad, 0)
        end
        for z = 0, 3 do
            local t = i + z / 4
            local x = cos(t / 2) * -64 + 64
            local y = t * 2.5 - x / 4
            paint(x,y)
        end
        flip()
    end
    fillp()
end