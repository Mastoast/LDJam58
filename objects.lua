rectangle = new_type(0)
rectangle.color = 7

function rectangle.draw(self)
    rectfill(self.x, self.y, self.x + self.hit_w - 1, self.y + self.hit_h - 1, self.color)
end

text = new_type(0)
text.spr = nil
text.solid = false
text.text = ""
text.is_centered = false
text.color = 7
text.hover = false
text.wide = false
text.selectable = true

function text.init(self)
    self.hit_h = 8
    self.hit_w = #self.text*4
    if self.is_centered then
        self.hit_x = - (#self.text)*2
    end
    self.hit_y = -2
end

function text.draw(self)
    if self.text == "" then return end
    if self.is_centered then
        print_centered(self.text, self.x + 1, self.y + 1, 0, self.wide)
        print_centered(self.text, self.x, self.y, self.color, self.wide)
        if self.hover and self.selectable then
            print("◆", 64 - 10 - (#self.text * 2), self.y)
            -- print("◆", 64 + 2 + (#self.text * 2), self.y)
        end
    else
        print(self.text, self.x + 1, self.y + 1, 0)
        print(self.text, self.x, self.y, self.color)
        if self.hover and self.selectable then
            print("◆", self.x - 10, self.y)
        end
    end
end

button = new_type(0)
button.spr = nil
button.text = ""
button.is_centered = false
button.c = 5
button.sc = 13
button.ctxt = 7
button.margin = 2
button.hover = false

function button.init(self)
    self.hit_h = 8 + self.margin*2
    self.hit_w = #self.text*4 + self.margin*2
    if self.is_centered then
        self.hit_x = - (#self.text)*2
    end
    self.hit_y = -2
end

function button.draw(self)
    local color = self.hover and self.sc or self.c
    rrectfill(self.x - self.margin + 1, self.y - self.margin + 1, self.hit_w, self.hit_h, 3, 0)
    rrectfill(self.x - self.margin, self.y - self.margin, self.hit_w, self.hit_h, 3, color)
    print(self.text, self.x + 1, self.y + 1, 0)
    print(self.text, self.x, self.y, self.ctxt)
end

checkbox = new_type(64)
checkbox.checked = false
checkbox.color = 7

function checkbox.draw(self)
    rect(self.x, self.y, self.x + self.hit_w-1, self.y + self.hit_h-1, self.color)
    if self.checked then
        spr(self.spr, self.x, self.y)
        -- print("❎", self.x + 1, self.y + 1, self.color)
    end
end

function checkbox.on_click(self)
    self.checked = not self.checked

end


checkbox_mode = new_type(64)
checkbox_mode.color = 7
function checkbox_mode.draw(self)
    rect(self.x, self.y, self.x + self.hit_w-1, self.y + self.hit_h-1, self.color)
    if self.mode == mode then
        spr(self.spr, self.x, self.y)
    end
end


-- mouse cursor
cursor = new_type(16)

function cursor.draw(self)
    spr(mode_list[mode].tile, cam.x + stat(32), cam.y + stat(33))

end

-- achievement badge
badge = new_type(0)
badge.hit_w = 6
badge.hit_h = 6

function badge.draw(self)
    local achievement = all_achievements[self.achievement_index]
    color = achievement.unlocked and 9 or 1
    rectfill(self.x, self.y, self.x + self.hit_w - 1, self.y + self.hit_h - 1, color)
    if self.hover then
        if achievement.unlocked then
            -- print(achievement.name, self.x, self.y + 10)
            -- print(achievement.description, self.x, self.y + 18)
        else
            print(achievement.tip, self.x, self.y + 10)
        end
    end
end

function badge.on_click(self)
    local achievement = all_achievements[self.achievement_index]
    if achievement.unlocked then
        add(incoming_popups, achievement)
    end
end

-- animated sprite

asprite = new_type(0)
asprite.sprs = {
    {spr = 66, fx = false, fy = false},
    {spr = 68, fx = false, fy = false},
    {spr = 70, fx = false, fy = false},
    {spr = 72, fx = false, fy = false},
    {spr = 70, fx = true, fy = false},
    {spr = 68, fx = true, fy = false}
}
asprite.fx = false
asprite.fy = false
asprite.spd = 12
asprite.hit_h = 16
asprite.hit_w = 16
asprite.size = 1

function asprite.init(self)
    self.frame = 1
    self.t = 0
end

function asprite.update(self)
    self.t += 1
    if self.t % self.spd == 0 then
        self.frame = (self.frame+1) % (#self.sprs + 1)
        if self.frame == 0 then self.frame = 1 end
    end
end

function asprite.draw(self)
    local f = self.sprs[self.frame]
    sspr((f.spr % 16) * 8, flr(f.spr \ 16) * 8, self.hit_w, self.hit_h, self.x, self.y, self.hit_w * self.size, self.hit_h * self.size, f.fx, f.fy)
end

-- PARTICLES
particles = {}

-- number
-- size
-- x / y
-- color
function spawn_particles(nb,s,x,y,c)
    for i=1,flr(nb) do
        add(particles, make_particle(s,x,y,c))
    end
end

function make_particle(s,x,y,c)
    local p={
        s=s or 1,
        c=c or 7,
        x=x,y=y,k=k,
        t=0, t_max=16+flr(rnd(4)),
        dx=rnd(2)-1,dy=-rnd(3),
        ddy=0.05,
        update=update_particle,
        draw=draw_particle
    }
    return p
end

function draw_particle(a)
    circfill(a.x,a.y,a.s,a.c)
end

function update_particle(a)
    if a.s>=1 and a.t%4==0 then a.s-=1 end
    if a.t%2==0 then
        a.dy+=a.ddy
        a.x+=a.dx
        a.y+=a.dy
    end
    a.t+=1
    if (a.t==a.t_max) del(particles, a)
end