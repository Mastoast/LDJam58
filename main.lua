function _init()
    -- enable mouse
    poke(0x5f2d, 3)
    -- disable key repeat
    poke(0x5f5c, -1)
    gtime = 0
    ndeath = 0
    freeze_time = 0
    shake = 0
    cam = {x = 0, y = 0, speed = 0.1}
    tcam = {x = 0, y = 0}
    current_menu = menu
    printable = 0
    --
    init_level()
    init_menu(current_menu)
end

function init_menu(menu)
    menu:init()
    create(cursor, -120, -120)
end

function init_level()
    gtime = 0
    objects = {}
    particles = {}
    -- gen checkpoints
    -- for i=0, 127 do
    --     for y=0, 63 do
    --         if mget(i, y) == 4 then
    --             create(rectangle, i*8 + 4, y*8 + 4)
    --         end
    --     end
    -- end
end

function _update60()
    -- timers
    gtime += 1

    update_level()
end

function update_level()
    -- freeze
    if freeze_time > 0 then
        freeze_time -= 1
        return
    end

    -- camera
    cam.x = lerp(cam.x, tcam.x, cam.speed)
    cam.y = lerp(cam.y, tcam.y, cam.speed)

    -- screenshake
    shake = max(shake - 1)

    for o in all(objects) do
        if o.freeze > 0 then
            o.freeze -= 1
            break
        end

        o.hover = on_cursor(o)
        o:update()

        if o.destroyed then
            del(objects, o)
        end
    end

    for a in all(particles) do
        a:update()
    end
end

function _draw()
    cls(0)
    
    -- camera
    if shake > 0 then
        camera(cam.x - 2 + rnd(5), cam.y - 2 + rnd(5))
    else
        camera(cam.x, cam.y)
    end

    -- draw map
    map(0, 0, 0, 0, 16, 16)

    -- draw objects
    for o in all(objects) do
        o:draw()
    end

    -- draw particles
    for a in all(particles) do
        a:draw()
    end

    -- UI
    print(printable, cam.x + 80, cam.y + 120, -4)
end

-- UTILS
-- linear interpolation
function lerp(start,finish,t)
    return mid(start,start*(1-t)+finish*t,finish)
end

-- print at center
function print_centered(str, x, y, col)
    print(str, x - (#str * 2), y, col)
end

-- random range
function rrnd(min, max)
    return flr(min + rnd(max - min))
end

-- find index for element in table
function find_item_table_index(item, table)
    for k, v in pairs(table) do
        if v == item then return k end
    end
    return 0
end

function on_cursor(object)
    return object:contains(stat(32), stat(33))
end