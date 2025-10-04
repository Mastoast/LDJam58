function _init()
    -- enable mouse
    poke(0x5f2d, 3)
    -- disable key repeat
    poke(0x5f5c, -1)
    gtime = 0
    gstate = 1
    ndeath = 0
    freeze_time = 0
    shake = 0
    cam = {x = 0, y = 0, speed = 0.1}
    tcam = {x = 0, y = 0}
    printable = 0
    --
    init_level()
    init_main_menu()
    init_achievements_menu()
    init_options_menu()
    mouse = create(cursor, -120, -120)
    printh("NEW RUN ===================")
end

-- gstate
-- 1 = Menu
-- 2 = popup

function init_level()
    gtime = 0
    objects = {}
    particles = {}
    incoming_popups = {}
    badge_count = 0

    -- saves
    cartdata("mastoast_achievements_v1")
    -- -- complete save
    -- for index = 1, #all_achievements do
    --     dset(index, 1)
    -- end
    -- load save
    for index = 1, #all_achievements do
        if dget(index) == 1 then
            -- all_achievements[index].unlocked = true
            -- badge_count += 1
        end
    end
    menuitem(1, "restart progress", function() restart_progress() end)
end

function restart_progress()
    --reset save
    for index = 1, #all_achievements do
        dset(index, 0)
    end
end

function _update60()
    -- timers
    gtime += 1

    if gstate == 1 then
        update_level()
    elseif gstate == 2 then
        update_popup()
    end
end

function update_level()
    -- freeze
    if freeze_time > 0 then
        freeze_time -= 1
        return
    end

    --
    pop_popups()
    --

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
        
        if btnp(❎) and o.hover then
            o:on_click()
        end

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
    if gstate == 2 then draw_popup() end
    mouse:draw()
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
    return object:contains(cam.x + stat(32), cam.y + stat(33))
end