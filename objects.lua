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
        --self.hit_x = - (#self.text)*2
    end
    self.hit_y = -2
end

function button.draw(self)
    local color = self.hover and self.sc or self.c
    rrectfill(self.x - self.margin + 1, self.y - self.margin + 1, self.hit_w, self.hit_h, 3, 0)
    rrectfill(self.x - self.margin-1, self.y - self.margin-1, self.hit_w, self.hit_h, 3, color)
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
checkbox_mode.sc = 5
function checkbox_mode.draw(self)
    local color = mode_list[self.mode].locked and self.sc or self.color
    rect(self.x, self.y, self.x + self.hit_w-1, self.y + self.hit_h-1, color)
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
    col = achievement.unlocked and 9 or 1
    rectfill(self.x, self.y, self.x + self.hit_w - 1, self.y + self.hit_h - 1, col)
    if self.hover then
        rectfill(self.x-1, self.y-1, self.x + self.hit_w + 1, self.y + self.hit_h + 1, col)
        print_centered(achievement.name, cam.x + 64, cam.y + 90, col, true, false)
        if achievement.unlocked then
            -- print(achievement.name, self.x, self.y + 10)
            -- print(achievement.description, self.x, self.y + 18)
        else
            --print(achievement.tip, self.x, self.y + 10)
        end
    end
end

function badge.on_click(self)
    local achievement = all_achievements[self.achievement_index]
    init_popup(achievement, 7)
    psfx("ko1")
end

function badge.on_hover(self)
    local fx = {"bip1", "bip2", "bip3", "bip4", "bip5"}
    psfx(rchoice(fx))
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
asprite.t = 0
asprite.frame = 1

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

modnumber = new_type(0)
modnumber.value = 0
modnumber.c = 7
modnumber.sc = 9
modnumber.min = 0
modnumber.max = 100

function modnumber.init(self)
    self.hit_h = 20
    self.hit_y = -8
    self.hit_w = #tostr(self.max)*4-1
end

function modnumber.draw(self)
    local target = (cam.y + stat(33) > self.y) and "down" or "up"
    local upc = (self.hover and target == "up") and self.sc or self.c
    local downc = (self.hover and target == "down") and self.sc or self.c
    local s = tostr(self.value)
    local btnx = self.x + self.hit_w/2 - 2
    print("⬆️", btnx + 1, self.y - 6, 0)
    print("⬆️", btnx, self.y - 7, upc)
    print(s, self.x, self.y, self.c)
    print("⬇️", btnx + 1, self.y + 6+1, 0)
    print("⬇️", btnx, self.y + 6, downc)
end

function modnumber.on_click(self)
    local target = (cam.y + stat(33) > self.y) and -1 or 1
    local new_value = self.value + target
    if new_value < self.min or new_value > self.max then
        click_error()
        return
    end
    self.value = new_value
    local sfx = target == 1 and "ko2" or "ko3"
    psfx(sfx)
    spawn_particles(2, 3, cam.x + stat(32), cam.y + stat(33), 9)
    on_date_change()
end

notif = new_type(0)
notif.text = ""
notif.c = 15
notif.sc = 9
notif.l = 140
notif.dlt = 8
notif.dltsp = 1.5

function notif.update(self)
    if self.dlt > 0 then
        self.dlt = max(0, self.dlt - self.dltsp)
    end
    self.l -= 1
    if self.l <= 0 then
        del(objects, self)
    end
end

function notif.draw(self)
    print("\#8\^#"..self.text, cam.x, cam.y + 122 + self.dlt, self.c)
end

player = new_type(100)
player.speed = 0.8

function player.update(self)
    if btn(0) then self.x -= self.speed end
    if btn(1) then self.x += self.speed end
    if btn(2) then self.y -= self.speed end
    if btn(3) then self.y += self.speed end
    if self:overlaps(self.target) then
        set_cam(main_menu, true)
        self.x, self.y = game.x + 64, game.y + 64
    end
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