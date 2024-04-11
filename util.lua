-- Use "normal" sin and cos fns rather than p8's
p8cos = cos function cos(angle) return p8cos(angle/(3.1415*2)) end
p8sin = sin function sin(angle) return -p8sin(angle/(3.1415*2)) end


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