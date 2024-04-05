STEP = 0.2

function make_skater()
    local e = {
        pos = {0.5, 0, 0.5},
        center = {0.5, 0, 0.5},
        vel = {0, 0, 0},
        fwd = {-1, 0, 0},
        sk_facing = {1, 0, 0},
        jump_charge = 0,
        height = 0.125,
        current_qp = nil,
        floor_normal = {0,1,0},
        draw = function(self)
            local skate_fwd = self.fwd--v_norm({self.sk_facing[1], mid(self.vel[2] * 2, -3.9, 3.9), self.sk_facing[3]})
            --pv(skate_fwd)
            for i = -1, 1, 0.125 do
                local v = v_add(self.pos, v_mul(skate_fwd, i * 0.25))
                if i == 1 or i == -1 then v[2] += 0.1 end
                local p = v2p(v)
                circfill(p[1], p[2] - 1, 1.5, 0)
            end
        end,
        control = function(self, v)
            self.vel = v_add(self.vel, v_mul(v, 0.0085))
            --self.vel = v_add(self.vel, v_mul(self.fwd, 0.0085))
        end,
        update = function(self)
            local flat_vel = {self.vel[1], 0, self.vel[3]}
            local speed_sq = v_mag_sq(flat_vel)
            if speed_sq > 0.01 then
                self.fwd = v_norm(self.vel)
                self.sk_facing = {self.fwd[1], self.fwd[2], self.fwd[3]}
                local speed = v_mag(flat_vel)
                flat_vel = v_mul(v_norm(flat_vel), min(speed - 0.002, 0.25))
                --flat_vel = v_mul(v_norm(flat_vel), min(speed, 0.25))
                self.vel = {flat_vel[1], self.vel[2], flat_vel[3]}
            else
                self.vel = {0,self.vel[2],0}
            end
            --self.vel[2] -= 0.02

            local cells = {}
            local next_pos = v_add(self.pos, self.vel)
            
            for x = next_pos[1] - 0.5, next_pos[1] + 0.5 do
                for z = next_pos[3] - 0.5, next_pos[3] + 0.5 do
                    local cell = get_cell({x,0,z})
                    if cell then -- and next_pos[2] <= cell.elev + cell.tile.height then
                        add(cells, cell)
                    end                    
                end
            end        
            local volumes = prepare_collision_volumes(cells)

            add(volumes, {{pt={next_pos[1], 0, next_pos[3]}, normal={0,1,0}}})
            local p1 = v_copy(self.pos)
            self.pos, self.vel = collide_point_volumes(self.pos, v_add(self.vel, {0, -0.02, 0}), volumes)
            self.vel = v_sub(self.pos, p1)

            local cell = get_cell(self.pos)
            if cell and cell.tiletype.is_qp then
                self.current_qp = cell
            end
            
            self.center = {self.pos[1], self.pos[2] + 0.125, self.pos[3]}

            local h = 0--pos_height_fn(self.pos)
            if self.pos[2] >= h then
               self.shadow.pos = find_ground(self.pos)
               self.shadow.center = self.shadow.pos
            end            

            --printh("vel len = " .. v_mag(self.vel))
            pv(self.pos)
            
        end,
        jump = function(self)
            self.vel = v_add(self.vel, {0, mid(self.jump_charge, 4, 10) / 46, 0})
            self.jump_charge = 0
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