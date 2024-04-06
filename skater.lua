STEP = 0.2

function make_skater()
    local e = {
        pos = {0.5, 0, 0.5},
        center = {0.5, 0, 0.5},
        vel = {0, 0, 0},
        fwd = {-1, 0, 0},
        flat_fwd = {1, 0, 0},
        jump_charge = 0,
        height = 0.125,
        airborne = false,
        current_qp = nil,
        floor_normal = {0,1,0},
        grind_line = nil,
        grind_fwd = 0,
        grind_speed = 0,
        char_y = 0,
        char_yv = 0,
        draw = function(self)
            local skate_fwd = self.fwd--v_norm({self.sk_facing[1], mid(self.vel[2] * 2, -3.9, 3.9), self.sk_facing[3]})
            --pv(skate_fwd)
            for i = -1, 1, 0.125 do
                local v = v_add(self.pos, v_mul(skate_fwd, i * 0.25))
                if i == 1 or i == -1 then v[2] += 0.1 end
                local p = v2p(v)
                circfill(p[1], p[2] - 1, 1.5, 0)
            end
            local p = v2p({self.pos[1], self.char_y, self.pos[3]})
            spr(17, p[1] - 4, p[2] - 8, 1, 1, (self.fwd[1] - self.fwd[3]) > 0)
        end,
        control = function(self, v)
            if self.grind_line != nil then
                return
            end
            self.vel = v_add(self.vel, v_mul(v, 0.0055))
            --self.vel = v_add(self.vel, v_mul(self.fwd, 0.0085))
        end,
        update = function(self)
            -- try grind
            if self.grind_line != nil then
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
            if speed_sq > 0.002 then
                self.fwd = v_norm(self.vel)
                self.flat_fwd = v_norm({self.fwd[1], 0, self.fwd[3]})
                local speed = v_mag(flat_vel)
                flat_vel = v_mul(v_norm(flat_vel), min(speed - 0.001, 0.125))
                --flat_vel = v_mul(v_norm(flat_vel), min(speed, 0.25))
                self.vel = {flat_vel[1], self.vel[2], flat_vel[3]}
            else
                self.vel = {0,self.vel[2],0}
            end
            
            self:update_qp()
              
            local volumes = prepare_collision_volumes(get_cells_within(self.pos, 0.5))

            add(volumes, ground_volume)
            local gravity = -0.014
            self.airborne = true
            if self.grind_line != nil then
                gravity = 0
                self.airborne = false
            end
            local p1 = v_copy(self.pos)
            self.pos, self.vel, collision_plane = collide_point_volumes(self.pos, v_add(self.vel, {0, gravity, 0}), volumes)
            self.vel = v_sub(self.pos, p1)
            if collision_plane != nil then
                --self.grind_line = nil
                --pv(collision_plane.normal, "collision: ")
                if collision_plane.normal[2] > 0.5 then
                    self.airborne = false
                end
            end
            
            self.center = {self.pos[1], self.pos[2] + 0.125, self.pos[3]}

            self.shadow.pos = find_ground(self.pos)
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
            
        end,
        update_qp = function(self)
            local cell = get_cell(self.pos)
            self.current_qp = nil
            if cell and cell.tiletype.is_qp then
                self.current_qp = cell
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
        jump = function(self)
            if not self.airborne then
                self.airborne = true
                pv(self.vel, "jump pre vel: ")
                self.vel = v_add(self.vel, {0, mid(self.jump_charge, 6, 10) / 46, 0})
                pv(self.vel, "jump post vel: ")
                self.jump_charge = 0
                self.grind_line = nil
                self.char_yv = self.vel[2] * 1.125
            end
        end,
        trick = function(self)
            if self.airborne then
                self:lock_grind(0.03)
            end
        end,
        lock_grind = function(self, speedup)
            local best_grind, dir = self:get_best_grind()
            self.grind_line = best_grind
            if self.grind_line then
                self.airborne = false
                -- mv calc
                self.grind_fwd = v_mul(v_norm(v_sub(best_grind[2], best_grind[1])), dir)
                self.grind_speed = v_mag({self.vel[1], 0, self.vel[3]}) + speedup
                local flat_fwd = {self.fwd[1], 0, self.fwd[3]}
                local pos = get_next_rail_pt(self.pos, flat_fwd, self.grind_speed, self.grind_line)
                local up = v_cross(v_cross(self.grind_fwd, {0,1,0}), self.grind_fwd)
                up = v_mul(up, 0.125)
                self.pos = v_add(pos, up)
                printh(self.grind_speed)
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
                    if dist < 0.75 and t > 0 and t < len then
                        gs = abs(v_dot(rail_fwd, flat_fwd)) / dist
                        if gs > grind_score then
                            grind_score = gs
                            best = rail
                            dir = sign(v_dot(rail_fwd, flat_fwd))
                            printh(dir)
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
        height = 0,
        draw = function(self)
            local p = v2p(self.pos)
            --circfill(p[1], p[2], 2, 5)
            ovalfill(p[1] - 2.5, p[2] - 1, p[1] + 2.5, p[2] + 1, 5)
        end
    }
    return e
end