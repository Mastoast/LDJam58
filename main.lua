function _init()
    printh("NEW RUN ===================")
    -- enable mouse
    poke(0x5f2d, 3)
    -- disable key repeat
    poke(0x5f5c, -1)
    --
    gtime = 0
    gstate = 1
    ndeath = 0
    freeze_time = 0
    shake = 0
    cam = {x = splash_screen.x, y = splash_screen.y, speed = 0.1}
    tcam = {x = splash_screen.x, y = splash_screen.y}
    printable = 0
    objects = {}
    particles = {}
    incoming_popups = {}
    badge_count = 0
    sfx_on = true
    music_on = true
    --
    mode = "normal"
    mode_list = {
        normal = {tile = 16},
        lumberjack = {tile = 48},
        boot = {tile = 32},
        play = {tile = 16, locked = true}
    }
    tday = {}
    bday = {}
    --
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
    check_badges()
    menuitem(1, "restart progress", function() restart_progress() end)
    --
    init_all_menus()
    mouse = create(cursor, -500, -500)
    printh("END INIT ================")
end

--[[ TODO
- gameplay visuals
- better achievement popup w/ effects
- credit menu
- unlock credits speed
]]

--[[
gstate
1 = Menu
2 = popup
3 = colorblind mode
]]

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
    elseif gstate == 3 then
        update_colorblind_mode()
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

        if not o.hover and on_cursor(o) then
            o:on_hover()
        end
        o.hover = on_cursor(o)
        o:update()
        
        if o.hover then
            if btnp(❎) then
                o:on_click(❎)
            elseif btnp(🅾️) then
                o:on_right_click(🅾️)
            end
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
    if gstate == 3 then return end
    -- camera
    if shake > 0 then
        camera(cam.x - 2 + rnd(5), cam.y - 2 + rnd(5))
    else
        camera(cam.x, cam.y)
    end

    -- draw map
    map(0, 48, splash_screen.x, splash_screen.y, 16, 16)

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
    printable = stat(32).." "..stat(33)
    print(printable, cam.x + 80, cam.y, -4)
end

-- UTILS
-- linear interpolation
function lerp(start,finish,t)
    return mid(start,start*(1-t)+finish*t,finish)
end

-- print at center
function print_centered(str, x, y, col, w, ui)
    local size = w and 3 or 2
    local strs = split(str, "//")
    for i=0, #strs-1 do
        local length = #(strs[i+1]) * size - size/2
        if ui then
            print(strs[i+1], cam.x + 64 - length, cam.y + y + i * size*2, col)
        else
            print(strs[i+1], x - length, y + i * size*2, col)
        end
    end
end

-- \f P0 : foreground color
-- \# P0 : background color
-- \^w : Wide. Doubles the width.
-- \^t : Tall. Doubles the height.
-- \^= : Stripey. When wide or tall, only even pixels are rendered.
-- \^p : Pinball. Equivalent to wide, tall, and dotty.
-- \^i : Inverted. The foreground color is used as the background, and vice versa.
-- \^b : Bordered. Text has left and top padding. (On by default.)
-- \^# : Solid background. The default is a transparent background.
-- \^$ : Wrap. Automatically wraps text when it reaches the right edge of the screen.

-- random range
function rrnd(min, max)
    return flr(min + rnd(max - min))
end

-- random choice from table
function rchoice(table)
    return table[flr(rnd(#table)) + 1]
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