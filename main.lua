--Achievement Unlocked!
--by Mastoast and Pandalk

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
    is_on_credits = false
    popup_last_input = 0
    popup_delay = 20
    is_menu_open = false
    catcnt = 0
    --
    mode = "normal"
    mode_list = {
        normal = {tile = 16},
        lumberjack = {tile = 48},
        boot = {tile = 32},
        play = {tile = 16, locked = true},
        patched = {tile = 119}
    }
    tday = {}
    bday = {}
    --
    -- saves
    cartdata("mastoast_achievements_v2")
    -- -- complete save
    -- for index = 1, #all_achievements do
    --     dset(index, 1)
    -- end
    -- load save
    for index = 1, #all_achievements do
        if dget(index) == 1 then
            all_achievements[index].unlocked = true
            badge_count += 1
        end
    end
    if badge_count > 0 then
        check_badges()
        init_main_menu()
        is_menu_open = true
    end
    menuitem(1, "reset progress", function() reset_progress() end)
    --
    init_all_menus()
    mouse = create(cursor, -500, -500)
    printh("END INIT ================")
    pmusic("title")
end

--[[
gstate
1 = Menu
2 = popup
3 = colorblind mode
]]

function reset_progress()
    --reset save
    for index = 1, #all_achievements do
        dset(index, 0)
    end
end

function _update60()
    -- timers
    gtime += 1
    -- screenshake
    shake = max(shake - 1)

    if gstate == 1 then
        update_level()
    elseif gstate == 2 then
        update_popup()
    elseif gstate == 3 then
        update_colorblind_mode()
    end
    update_credits()
    update_inputs()
    update_particles()
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

    for o in all(objects) do
        update_obj(o)
    end
end

function update_obj(o)
    if not o:on_camera() then return end

    if o.freeze > 0 then
        o.freeze -= 1
        return
    end

    if not o.hover and on_cursor(o) then
        o:on_hover()
    end
    o.hover = on_cursor(o)
    o:update()

    if o.hover then
        if btnp(❎) then
            o:on_click()
        elseif btnp(🅾️) then
            o:on_right_click()
        end
    end

    if o.destroyed then
        del(objects, o)
    end
end

function update_particles()
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

    draw_spash_screen()
    draw_game()

    -- draw objects
    for o in all(objects) do
        if o:on_camera() then
            o:draw()
        end
    end

    -- UI
    if gstate == 2 then draw_popup() end

    -- draw particles
    for a in all(particles) do
        a:draw()
    end

    mouse:draw()
    --printable = stat(32).." "..stat(33)
    -- print(printable, cam.x + 80, cam.y, 15)
end

-- UTILS
-- linear interpolation
function lerp(start,finish,t)
    return mid(start,start*(1-t)+finish*t,finish)
end

-- print at center
function print_centered(str, x, y, col, w)
    local size = w and 4 or 2
    local strs = split(str, "//")
    for i=0, #strs-1 do
        local chrcnt = #(strs[i+1]) - (w and 4 or 0)
        local length = chrcnt * size - size/2
        print(strs[i+1], x - length, y + i * size*2, col)
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