objects = {}
types = {}
lookup = {}
function lookup.__index(self, i) return self.base[i] end

object = {}
object.speed_x = 0;
object.speed_y = 0;
object.remainder_x = 0;
object.remainder_y = 0;
object.hit_x = 0
object.hit_y = 0
object.hit_w = 8
object.hit_h = 8
object.facing = 1
object.solid = true
object.freeze = 0

function object.init(self) end
function object.update(self) end
function object.draw(self)
    spr(self.spr, self.x, self.y, self.hit_w/8, self.hit_h/8, self.flip_x, self.flip_y)
end
function object.on_click(self) end
function object.on_right_click(self) end
function object.on_hover(self) end

function object.overlaps(self, b, ox, oy)
    if self == b then return false end
    ox = ox or 0
    oy = oy or 0
    return
        ox + self.x + self.hit_x + self.hit_w > b.x + b.hit_x and
        oy + self.y + self.hit_y + self.hit_h > b.y + b.hit_y and
        ox + self.x + self.hit_x < b.x + b.hit_x + b.hit_w and
        oy + self.y + self.hit_y < b.y + b.hit_y + b.hit_h
end

function object.contains(self, px, py)
    return
        px >= self.x + self.hit_x and
        px < self.x + self.hit_x + self.hit_w and
        py >= self.y + self.hit_y and
        py < self.y + self.hit_y + self.hit_h
end

function object.on_camera(self)
    return not (
        self.x + self.hit_x + self.hit_w < cam.x or
        self.x + self.hit_x > cam.x + 127 or
        self.y + self.hit_y + self.hit_h < cam.y or
        self.y + self.hit_y > cam.y + 127
    )
end

function create(type, x, y, hit_w, hit_h, object_list)
    local obj = {}
    obj.base = type
    obj.x = x
    obj.y = y
    obj.hit_w = hit_w or type.hit_w or 8
    obj.hit_h = hit_h or type.hit_h or 8
    setmetatable(obj, lookup)
    add(object_list or objects, obj)
    obj:init()
    return obj
end

function new_type(spr, base)
    local base = base or object
    local obj = {}
    obj.spr = spr
    obj.base = base
    setmetatable(obj, lookup)
    types[spr] = obj
    return obj
end

function clone_table(tbl)
  return {unpack(tbl)}
end