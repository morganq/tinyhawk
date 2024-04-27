function parse_volume(s)
    local v = {}
    for plane in all(split(s,";")) do
        local p1,p2,p3,n1,n2,n3 = unpack(split(plane,","))
        add(v, {pt = {p1,p2,p3}, normal = {n1,n2,n3}})
    end
    return v
end



empty_volumes = {}
ground_volume = {{{pt={0,0,0}, normal={0,1,0}}}, {0,0,0}}
block_volumes = {parse_volume("-0.5,0,0,-1,0,0;0.5,0,0,1,0,0;0,0,-0.5,0,0,-1;0,0,0.5,0,0,1;0,0.5,0,0,1,0")}
hblock1_volumes = {parse_volume("0,0,0,-.7071,0,-.7071;0.5,0,0,1,0,0;0,0,0.5,0,0,1;0,1,0,0,1,0")}
hblock2_volumes = {parse_volume("0,0,0,.7071,0,-.7071;-0.5,0,0,-1,0,0;0,0,0.5,0,0,1;0,1,0,0,1,0")}
ramp_volumes = {parse_volume("-0.5, 0, 0,-1, 0, 0;0, 0, -0.5,0, 0, -1;0, 0, 0.5,0, 0, 1;0, 0.25, 0,0.4472,0.8944,0")}   
ramp2_volumes = {parse_volume("-0.5, 0, 0,-1, 0, 0;0, 0, -0.5,0, 0, -1;0, 0, 0.5,0, 0, 1;0, 0.5, 0,0.7071,0.7071,0")}
rail1_volumes = {parse_volume("-0.5, 0, 0,-1, 0, 0;0.5, 0, 0,1, 0, 0;0, 0, -0.1,0, 0, -1;0, 0, 0.1,0, 0, 1;0, 0.5, 0,0, 1, 0")}
rail2_volumes = {parse_volume("-0.5, 0, 0,-1, 0, 0;0.5, 0, 0,1, 0, 0;0, 0, 0.4,0, 0, -1;0, 0, 0.5,0, 0, 1;0, 0.5, 0,0, 1, 0")}
rail3_volumes = {parse_volume("-0.5, 0, 0.5,-.7071, 0, .7071;0.5, 0, -0.5,0.7071, 0, -0.7071;-0.1, 0, -0.1,-.7071, 0, -.7071;0.1, 0, 0.1,.7071, 0, .7071;0, 0.5, 0,0, 1, 0")}
rail4_volumes = {parse_volume("-0.1, 0, 0.1,-.7071, 0, .7071;0.1, 0, -0.1,0.7071, 0, -0.7071;-0.5, 0, -0.5,-.7071, 0, -.7071;0.5, 0, 0.5,.7071, 0, .7071;0, 0.5, 0,0, 1, 0")}
rail5_volumes = {parse_volume("-0.1, 0, 0.1,-.7071, 0, .7071;0.1, 0, -0.1,0.7071, 0, -0.7071;-0.5, 0, -0.5,-.7071, 0, -.7071;0.5, 0, 0.5,.7071, 0, .7071;0, 0.5, 0,0, 1, 0")}
qp_volumes = {parse_volume("-0.5, 0, 0,-1, 0, 0;-0.49, 0, 0,1, 0, 0;0, 0, -0.5,0, 0, -1;0, 0, 0.5,0, 0, 1;0, 1, 0,0, 1, 0")}

cached_blocks = {}
for i = 0.5, 15, 0.5 do
    cached_blocks[i] = {}
    for plane in all(block_volumes[1]) do
        add(cached_blocks[i], {pt = v_copy(plane.pt), normal = v_copy(plane.normal)})
    end
    cached_blocks[i][5].pt[2] += i - 0.5
end

block2_volumes = cached_blocks[1]

--name, sprite, height, volumes, is_block, is_qp, rails
function parse_tile(s)
    local name, s1,s2, height, volumes, is_block, is_qp, rails,prefab = unpack(split(s,"/"))
    local t = {name=name,s1=s1,s2=s2,height=height,volumes=_ENV[volumes],is_block=is_block=="t",is_qp=is_qp=="t",rails={}}
    t.prefab = prefab or nil
    if #rails > 0 then
        for rail in all(split(rails,";")) do
            local p1,p2,p3,p4,p5,p6 = unpack(split(rail,","))
            add(t.rails, {{p1,p2,p3}, {p4,p5,p6}})
        end
    end
    return t
end

tiles = {
    parse_tile("block/2/2/0.5/block_volumes/t/f/-0.499, 0.499, -0.499,-0.499, 0.499, 0.499;-0.499, 0.499, 0.499,0.499, 0.499, 0.499;0.499, 0.499, 0.499,0.499, 0.499, -0.499;0.499, 0.499, -0.499,-0.499, 0.499, -0.499"),
    parse_tile("ramp1/6/8/0.5/ramp_volumes/f/f/-0.499, 0.499, -0.499,-0.499, 0.499, 0.499;-0.499, 0.499, 0.499,0.499, 0, 0.499;0.499, 0, 0.499,0.499, 0, -0.499;0.499, 0, -0.499,-0.499, 0.499, -0.499"),
    parse_tile("qp/10/12/1/qp_volumes/f/t/-0.499, 0.999, -0.499,-0.499, 0.999, 0.499"),
    parse_tile("rail1/34/34/0.5/rail1_volumes/f/f/-0.499, 0.499, 0,0.499, 0.499, 0"),
    parse_tile("ramp2/38/40/1/ramp2_volumes/f/f/-0.499,0.999,-0.499,-0.499,0.999,0.499;-0.499,0.999,0.499,0.499,0,0.499;0.499,0,0.499,0.499,0,-0.499;0.499,0,-0.499,-0.499,0.999,-0.499"),
    parse_tile("rail2/42/42/0.5/rail2_volumes/f/f/-0.499, 0.499, 0.499,0.499, 0.499, 0.499"),
    parse_tile("rail3/44/44/0.5/rail3_volumes/f/f/0.499, 0.499, -0.499,-0.499, 0.499, 0.499"),
    parse_tile("rail4/46/46/0.5/rail4_volumes/f/f/0.499, 0.499, 0.499,-0.499, 0.499, -0.499"),
    parse_tile("rail5/64/64/0.5/rail5_volumes/f/f/0, 0.499, -0.499,0.499, 0.499, 0"),
    parse_tile("hblock1/4/4/1/hblock1_volumes/f/f/0.499, 0.999, -0.499,-0.499, 0.999, 0.499;-0.499,0.999,0.499,0.499,0.999,0.499;0.499,0.999,0.499,0.499,0.999,-0.499"),
    parse_tile("hblock2/36/36/1/hblock2_volumes/f/f/0.499, 0.999, 0.499,-0.499, 0.999, -0.499;-0.499,0.999,-0.499,-0.499,0.999,0.499;-0.499,0.999,0.499,0.499,0.999,0.499"),
    parse_tile("taxi1/108/108/1/block_volumes/f/f/-0.499, 0.499, -0.499,-0.499, 0.499, 0.499;-0.499, 0.999, 0.499,0.499, 0.499, 0.499;0.499, 0.499, 0.499,0.499, 0.499, -0.499;0.499, 0.499, -0.499,-0.499, 0.999, -0.499/t"),
    parse_tile("taxi2/110/110/1/block_volumes/f/f/-0.499, 0.499, -0.499,-0.499, 0.499, 0.499;-0.499, 0.499, 0.499,0.499, 0.999, 0.499;0.499, 0.499, 0.499,0.499, 0.499, -0.499;0.499, 0.999, -0.499,-0.499, 0.499, -0.499/t"),
    parse_tile("floor1/114/114/0/empty_volumes/f/f//t"),
    parse_tile("floor2/116/116/0/empty_volumes/f/f//t"),
    parse_tile("floor3/118/118/0/empty_volumes/f/f//t"),
    parse_tile("floor4/98/100/0/empty_volumes/f/f//t"),
    parse_tile("floor5/102/102/0/empty_volumes/f/f//t"),
}