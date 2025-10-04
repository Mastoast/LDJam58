rectangle = new_type(0)
rectangle.color = 7

function rectangle.draw(self)
    rectfill(self.x, self.y, self.x + self.hit_w - 1, self.y + self.hit_h - 1, self.color)
end

clickable = new_type(0)
clickable.spr = nil
clickable.solid = false

function clickable.update(self)
    --printable = self.x
end

function clickable.draw(self)
    object.draw(self)
end

function clickable.on_hover(self) end
function clickable.on_click(self) end

text = new_type(0, clickable)
text.spr = nil
text.solid = false
text.text = ""
text.is_centered = false
text.color = 7
text.hover = true

function text.init(self)
    self.hit_h = 8
    self.hit_w = #self.text*4
    if self.is_centered then
        self.hit_x = - (#self.text)*2
    end
    self.hit_y = -2
end

function text.update(self)
    clickable.update(self)
end

function text.draw(self)
    if self.is_centered then
        print_centered(self.text, self.x + 1, self.y + 1, 0)
        print_centered(self.text, self.x, self.y, self.color)
        if self.hover then
            print("🐱", 64 - 10 - (#self.text * 2), self.y)
            -- print("🐱", 64 + 2 + (#self.text * 2), self.y)
        end
    else
        print(self.text, self.x + 1, self.y + 1, 0)
        print(self.text, self.x, self.y, self.color)
        if self.hover then
            print("🐱", self.x - 10, self.y)
        end
    end
end

-- mouse cursor
cursor = new_type(16)

function cursor.update(self)
    self.x = cam.x + stat(32)
    self.y = cam.y + stat(33)
end

-- achievement badge
badge = new_type(0)

function badge.draw(self)
    print(self.name, self.x, self.y)
    if self.hover then
        print(self.description, self.x, self.y + 10)
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