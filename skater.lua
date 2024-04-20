STEP = 0.2
FRICTION = 0.0012
DEG2RAD = 3.14159 / 180

function make_skater()
    local e = {
        pos = {0.5, 0, 0.5},
        center = {0.5, 0, 0.5},
        depth = 0,
        vel = {0, 0, 0},
        fwd = v_norm({-1, 0, -1}),
        flat_fwd = v_norm({-1, 0, -1}),
        jump_charge = 0,
        jumped = false,
        airborne_frames = 0,
        height = 0.125,
        airborne = false,
        current_qp = nil,
        floor_normal = {0,1,0},
        grind_line = nil,
        grind_fwd = 0,
        grind_speed = 0,
        char_y = 0,
        char_yv = 0,
        qp_target = nil,
        switch = false,
        current_trick = nil,
        current_trick_t = 0,
        fall_vector = nil,
        fall_timer = 0,
        fall_time = 0,
        in_manual = false,
        rotvel = 0,
        draw = function(self)
            local skate_fwd = v_norm({self.fwd[1], self.fwd[2], self.fwd[3]})
            local spin = {0,0,0}
            local ct = self.current_trick
            if ct then
                if ct.spins then
                    local tt = min(self.current_trick_t / ct.time, 0.999)
                    local tspins = ct.spins
                    local spindex = (tt * #tspins) \ 1 + 1
                    for i = 1, spindex - 1 do
                        spin = v_add(spin, v_mul(tspins[i], DEG2RAD))
                    end
                    local stt = tt * #tspins % 1
                    spin = v_add(spin, v_mul(tspins[spindex], stt * DEG2RAD))
                end
                if ct.holdspin then
                    spin = v_mul(ct.holdspin, DEG2RAD)
                end
                if spin[1] != 0 then --yaw
                    local cyaw = atan2(skate_fwd[1], skate_fwd[3])
                    skate_fwd[1] = cos(cyaw + spin[1])
                    skate_fwd[3] = sin(cyaw + spin[1])
                end
                if spin[2] != 0 then
                    skate_fwd[2] += tan(spin[2])
                    skate_fwd = v_norm(skate_fwd)
                end
            end
            for i = -1, 1, 0.125 do
                local v = v_add(self.pos, v_mul(skate_fwd, i * 0.25))
                if i == 1 or i == -1 then v[2] += 0.125 end
                local p = v2p(v)
                local rad = cos(spin[3] * 2) * 0.5 + 1
                local color = cos(spin[3] + spin[2]) > 0 and 0 or 8
                circfill(p[1], p[2], rad, color)
            end
            local nv = self.flat_fwd
            local sv = {self.flat_fwd[3], 0, -self.flat_fwd[1]}
            local l1, l2 = v_add(self.pos, v_mul(nv, 0.5)), v_add(self.pos, v_mul(nv, 1.5))
            local p1 = v2p(l1)
            local p2 = v2p(l2)
            local p3 = v2p(v_add(v_add(self.pos, v_mul(nv, 1.25)), {nv[3] * 0.25, 0, nv[1] * -0.25}))
            local p4 = v2p(v_add(v_add(self.pos, v_mul(nv, 1.25)), {nv[3] * -0.25, 0, nv[1] * 0.25}))
            line(p1[1], p1[2], p2[1], p2[2], 11)
            line(p2[1], p2[2], p3[1], p3[2], 11)
            line(p2[1], p2[2], p4[1], p4[2], 11)

            local p, flip, frame = nil, false, 192
            if self.fall_timer > 0 then
                local t = (1 - self.fall_timer / self.fall_time)
                local tt = t
                flip = (self.fall_vector[1] - self.fall_vector[3]) > 0
                if t < 0.25 then
                    tt = sin(t * 6.2818)
                    frame = 197 + self.fall_timer\2 % 2
                elseif t < 0.5 then
                    tt = 1
                else
                    tt = 1 - (t - 0.5) * 2
                    flip = not flip
                end
                local v = v_add(self.pos, v_mul(self.fall_vector, tt))
                
                p = v2p(v)
                self.shadow.pos = v
                self.shadow.center = self.shadow.pos                
            else            
                p = v2p({self.pos[1], self.char_y, self.pos[3]})
                flip = (self.fwd[1] - self.fwd[3]) > 0
                if self.switch then flip = not flip end
                if ct and ct.anim then
                    frame = ct.anim
                else
                    frame = 192 + (self.airborne_frames + 3) \ 4
                    if frame >= 197 then
                        frame = 195 + (frame-1) % 2
                    end
                end
            end
            spr(frame, p[1] - 4, p[2] - 8, 1, 1, flip)            
        end,
        control = function(self, turn, fb, hold)
            if self.grind_line != nil then
                self.rotvel = 0
                return
            end
            if self.fall_timer > 0 then
                self.rotvel = 0
                return
            end
            self.rotvel = mid(self.rotvel + turn * 0.02, -.12, .12)
            if turn == 0 then
                self.rotvel *= 0.7
            end
            local fwd_angle = atan2(self.flat_fwd[1], self.flat_fwd[3])
            local new_angle = fwd_angle + self.rotvel
            local flat_vel = {self.vel[1], 0, self.vel[3]}
            local speed = v_mag(flat_vel)         
            self.flat_fwd = {cos(new_angle), 0, sin(new_angle)}            
            if self.airborne then
                if self.current_trick and self.current_trick.is_grind then
                    self.current_trick = nil
                end
                if fb == 1 then
                    local new_vel = {cos(new_angle), self.vel[2], sin(new_angle)}
                    local speed_fwd = v_dot(self.flat_fwd, flat_vel)
                    if speed_fwd < 0.125 then
                        self.vel = v_add(self.vel, v_mul(new_vel, 0.005))
                    end
                end
            else
                if hold then
                    if speed > 0.125 then
                        speed += FRICTION
                    else
                        speed += 0.01
                    end
                end       
                local new_vel = {cos(new_angle) * speed, self.vel[2], sin(new_angle) * speed}
                local dot = v_dot(self.flat_fwd, v_norm(flat_vel))
                if v_mag(self.vel) > 0.05 and abs(dot) < 0.7 then
                    self:fall()
                    self.switch = false
                else
                    if not self.in_manual then
                        local in_trick = self.current_trick != nil and not self.current_trick.is_manual and not self.current_trick.is_grind and self.current_trick_t < self.current_trick.time - 2
                        end_combo(in_trick)
                        if in_trick then
                            self:fall()
                        end
                    end
                    if v_mag(new_vel) > 0.01 then
                        if dot < 0 then
                            self.flat_fwd = v_mul(self.flat_fwd, -1)
                            self.switch = not self.switch
                            new_vel[1] = -new_vel[1]
                            new_vel[3] = -new_vel[3]
                        end
                        self.vel = new_vel
                        
                    else
                        self.vel = new_vel
                    end
                end
            end
            if self.current_qp then
                if self.qp_target == nil then
                    self.qp_target = v_copy(self.pos)
                end
                if fb == 1 then
                    self.qp_target = v_add(self.qp_target, v_mul(self.flat_fwd, 0.08))
                end
            end
        end,
        fall = function(self)
            self.fall_vector = {self.vel[1] * 15, 0, self.vel[3] * 15}
            self.fall_time = v_mag(self.fall_vector) * 20
            self.fall_timer = self.fall_time
            self.vel = {0,0,0}
            self.current_trick = nil
            end_combo(true)
        end,
        update = function(self)
            -- fall?
            if self.fall_timer > 0 then
                self.fall_timer -= 1
                return
            end
            -- try grind
            if self.grind_line != nil then
                increment_combo()
                --self.grind_speed = v_mag({self.vel[1], 0, self.vel[3]})
                self.grind_speed -= self.grind_fwd[2] * 0.01 + 0.002
                local next_pos,t,len = get_next_rail_pt(self.pos, self.grind_fwd, self.grind_speed, self.grind_line)
                
                self.fwd = self.grind_fwd
                self.vel = v_mul(self.fwd, self.grind_speed)
                if self.grind_speed < 0.005 then
                    printh("grind end speed")
                    self.grind_line = nil
                end
                if t > len or t < 0 then
                    self.grind_line = nil
                    self:lock_grind(0)
                    printh("grind end t")
                end
            end

            -- do everything else
            local flat_vel = {self.vel[1], 0, self.vel[3]}
            local speed_sq = v_mag_sq(flat_vel)
            if speed_sq > FRICTION then
                self.fwd = v_norm(self.vel)
                --self.flat_fwd = v_norm({self.fwd[1], 0, self.fwd[3]})
                local speed = v_mag(flat_vel)
                flat_vel = v_mul(v_norm(flat_vel), speed - FRICTION)
                --flat_vel = v_mul(v_norm(flat_vel), min(speed, 0.25))
                self.vel = {flat_vel[1], self.vel[2], flat_vel[3]}
            else
                self.vel = {0,self.vel[2],0}
            end
            
            self:update_qp()
              
            local touching_cells = get_cells_within(self.pos, 0.5)
            local volumes = prepare_collision_volumes(touching_cells)
            
            --volumes = {}
            add(volumes, ground_volume)
            local gravity = -0.014
            self.airborne = true
            if self.grind_line != nil then
                gravity = 0
                self.airborne = false
                self.airborne_frames = 0
                self.jumped = false
            end
            local p1 = v_copy(self.pos)
            self.pos, self.vel, collision_plane = collide_point_volumes(self.pos, v_add(self.vel, {0, gravity, 0}), volumes)
            self.pos[1] = mid(self.pos[1], LEVEL_BORDERS[1], LEVEL_BORDERS[2])
            self.pos[3] = mid(self.pos[3], LEVEL_BORDERS[3], LEVEL_BORDERS[4])
            self.vel = v_sub(self.pos, p1)
            if collision_plane != nil then
                local cell_below = get_cell(self.pos)
                if cell_below and cell_below.tiletype.is_qp then
                    self.current_qp = cell_below
                end
                --self.grind_line = nil
                --pv(collision_plane.normal, "collision: ")
                if collision_plane.normal[2] > 0.5 then
                    if self.in_manual then
                        if self.current_trick and self.current_trick.is_manual then
                            printh("inc")
                            increment_combo()
                        else
                            printh("add")
                            add_combo("manual")
                            self.current_trick = tricks["manual"]
                        end
                    end
                    self.airborne = false
                    self.airborne_frames = 0
                    self.jumped = false
                end
            end
            
            self.center = {self.pos[1], self.pos[2] + 0.5, self.pos[3]}

            self.shadow.pos = find_ground(self.pos, volumes)
            self.shadow.center = self.shadow.pos

            self.char_yv -= 0.02
            self.char_y = self.char_y + self.char_yv
            if self.char_y < self.pos[2] then
                self.char_yv = - self.char_yv * 0.4
                self.char_y = self.pos[2]
            elseif self.char_y > self.pos[2] + 0.5 then
                self.char_y = self.pos[2] + 0.5
                self.char_yv = self.vel[2]
            end
            if self.airborne then self.airborne_frames += 1 end
            if self.airborne_frames > 3 and self.current_trick and self.current_trick.is_manual then
                self.in_manual = false
            end

            self:update_trick()

            local hh = 0
            local cell_below = get_cell(self.pos)
            if cell_below then
                hh = cell_below.ent.center[2] + 0.1
            end
            --[[for cell in all(touching_cells) do
                printh(cell.ent.height)
                if self.pos[2] > cell.ent.height then
                    hh = 0.9
                end
            end]]
            self.depth = self.pos[1]\1 + hh + self.pos[3]\1 + 1
            self.shadow.depth = self.depth - 0.01
        end,
        update_qp = function(self)
            if not self.airborne then
                self.qp_target = nil
            end
            if self.qp_target then
                self.qp_target[2] = self.pos[2]
                if v_mag(v_sub(self.qp_target, self.pos)) > 0.50 then
                    self.current_qp = nil
                end
            end
            local cell = get_cell(self.pos)
            if not cell or not cell.tiletype.is_qp then
                self.current_qp = false
            end          
            if self.current_qp then
                if cell.fliph and cell.flipv then
                    self.vel[3] = min(self.vel[3], (cell.z + 0.95) - self.pos[3])
                elseif cell.fliph and not cell.flipv then
                    self.vel[3] = max(self.vel[3], cell.z + 0.05 - self.pos[3])
                elseif not cell.fliph and cell.flipv then
                    self.vel[1] = min(self.vel[1], (cell.x + 0.95) - self.pos[1])
                else
                    self.vel[1] = max(self.vel[1], cell.x + 0.05 - self.pos[1])
                end                
            end
        end,
        update_trick = function(self)
            if self.current_trick then
                self.current_trick_t += 1
                if self.current_trick.is_manual and not self.in_manual then
                    self.current_trick = nil
                elseif not self.current_trick.is_manual and not self.current_trick.is_grind and self.current_trick_t > self.current_trick.time then
                    self.current_trick = nil
                end
            end
        end,
        jump = function(self)
            
            if not self.airborne or (self.airborne_frames < 6 and not self.jumped) then
                self.airborne = true
                self.jumped = true
                self.vel = v_add(self.vel, {0, mid(self.jump_charge, 6, 10) / 60, 0})
                self.jump_charge = 0
                self.grind_line = nil
                self.char_yv = self.vel[2] * 1.125
            end
            self.jump_charge = 0
        end,
        trick = function(self)
            if self.airborne and self.current_trick == nil then
                if not self.grind_line then
                    local trick = try_get_trick()
                    if trick then
                        if trick == "manual" then
                            self.in_manual = true
                        else
                            self.current_trick = tricks[trick]
                            self.current_trick_t = 0
                            add_combo(trick)
                            self.in_manual = false
                        end
                    end
                end
            end
            if self.current_trick == nil then
            --    self:lock_grind(0.03)
            end
        end,
        hold_grind = function(self)
            if self.airborne and self.current_trick == nil then
                self:lock_grind(0.03)
            end
        end,
        lock_grind = function(self, speedup)
            if self.grind_line then return end
            local best_grind, dir = self:get_best_grind()
            self.grind_line = best_grind
            if self.grind_line then
                self.airborne = false
                -- mv calc
                self.grind_fwd = v_mul(v_norm(v_sub(best_grind[2], best_grind[1])), dir)
                
                self.grind_speed = v_mag({self.vel[1], 0, self.vel[3]}) + speedup
                local flat_fwd = {self.fwd[1], 0, self.fwd[3]}
                self.flat_fwd = self.grind_fwd
                local pos = get_next_rail_pt(self.pos, flat_fwd, self.grind_speed, self.grind_line)
                local up = v_cross(v_cross(self.grind_fwd, {0,1,0}), self.grind_fwd)
                up = v_mul(up, 0.125)
                self.pos = v_add(pos, up)
                if speedup > 0 then
                    add_combo("grind")
                end
                self.current_trick = tricks['grind']
            end            
        end,
        get_best_grind = function(self)
            local best = self.grind_line
            local grind_score = 0.25
            local next_pos = v_add(self.pos, self.vel)
            local dir = 1
            for cell in all(get_cells_within(next_pos, 1)) do
                for rail in all(cell.rails) do
                    local t, rail_fwd, len = get_rail_t(next_pos, rail)
                    local flat_fwd = v_norm({self.fwd[1], 0, self.fwd[3]})
                    local closest_pt
                    if t < 0 then
                        closest_pt = rail[1]
                    elseif t > 1 then
                        closest_pt = rail[2]
                    else
                        closest_pt = v_add(rail[1], v_mul(rail_fwd, t))
                    end
                    local dist = v_mag(v_sub(next_pos, closest_pt))
                    local gs = 0
                    if dist < 0.45 and t > 0 and t < len then
                        gs = abs(v_dot(rail_fwd, flat_fwd)) / dist
                        if gs > grind_score then
                            grind_score = gs
                            best = rail
                            dir = sign(v_dot(rail_fwd, flat_fwd))
                        end
                    end
                end
            end
            return best, dir
        end,        
    }
    e.shadow = {
        pos = {0,0,0},
        center = {0,0,0},
        depth = 0,
        height = 0,
        draw = function(self)
            local p = v2p(self.pos)
            --circfill(p[1], p[2], 2, 5)
            ovalfill(p[1] - 2.5, p[2] - 1, p[1] + 2.5, p[2] + 1, 5)
        end
    }
    return e
end