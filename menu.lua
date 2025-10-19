main_menu = { x = 0, y = 0 }
irl_menu = { x = 0, y = -128 }
badges_menu = { x = 128, y = 128 }
options_menu = { x = 0, y = 128 }
options_sound_menu = { x = 0, y = 256}
options_time_menu = { x = 0, y = 384}
options_accessibility_menu = { x = 0, y = 512}
options_modes_menu = { x = 0, y = 640}
credits_screen = { x = 384, y = 384}
splash_screen = {x = -256, y = 0}
game = { x = 512, y = 512}

function init_all_menus()
    init_splash_screen_menu()
    init_main_menu_new_game()
    init_achievements_menu()
    init_options_menu()
    init_sound_menu()
    init_time_menu()
    init_modes_menu()
    init_accessibility_menu()
    init_credits()
    init_gameplay()
    init_irl_menu()
end

function init_splash_screen_menu()
    local x, y = splash_screen.x + 0, splash_screen.y + 0
    local tree = create(object, x + 2, y + 60, 16, 32)
    tree.spr = 1
    tree.life = 3
    tree.on_click = tree_on_click
    local tree2 = create(object, x + 12, y + 10, 16, 32)
    tree2.spr = 1
    tree2.life = 3
    tree2.on_click = tree_on_click
    local title = create(text, x + 64, y + 32)
        local x, y = splash_screen.x + 0, splash_screen.y + 0
    local tree3 = create(object, x + 22, y + 50, 16, 32)
    tree3.spr = 1
    tree3.life = 3
    tree3.on_click = tree_on_click
    local title = create(text, x + 64, y + 32)
    title.text = "\^t\^wshadow sword       //// \^t\^    iv"
    title.is_centered = true
    title.color = 10
    title:init()
    title.dir = -1
    title.update = function(self)
        if gtime % 60 == 0 then
            self.y += self.dir
        end
        if gtime % 120 == 0 then
            self.dir *= -1
        end
    end

    local bckbtn = create(text, x, y)
    bckbtn.hit_w = 128
    bckbtn.hit_h = 128
    bckbtn.on_right_click = move_to_irl_screen

    local startbtn = create(button, x + 45, y + 72)
    startbtn.text = "start game"
    startbtn.is_centered = true
    startbtn:init()
    startbtn.on_click = function ()
        music(-1)
        move_to_main_menu()
    end

    local bucket = create(object, x + 98, y + 79, 8, 8)
    bucket.spr = 19
    bucket.life = 1
    bucket.on_click = function(self)
        if mode == "boot" then
            if self.life > 1 then
                psfx("ko1")
                self.life -= 1
            else
                psfx("metal")
                spawn_particles(5, 3, cam.x + stat(32), cam.y + stat(33), 6)
                del(objects, self)
                unlock_badge("kick_the_bucket")
            end
            spawn_particles(5, 3, cam.x + stat(32), cam.y + stat(33), 6)
            shake = 3
        end
    end

    local man = create(object, x + 103, y + 56, 8, 16)
    man.spr = 20
    man.on_click = function(self)
        if mode == "boot" then
            psfx("splash")
            for i=1,10 do
                local col = (i%2)==0 and 1 or 6
                spawn_particles(3, 7, splash_screen.x+113, splash_screen.y+120, col, 32+flr(rnd(4)))
            end
            del(objects, self)
            unlock_badge("perfect_murder")
        end
    end

    local cat = create(cat,x+63,y+102)
    cat.i = 1
    cat.c1 = 5
    cat.c2 = 4
end

function init_irl_menu()
    local x, y = irl_menu.x + 0, irl_menu.y + 0
    --local sprite_screen = 
    --local table = create(object, x + 2, y + 60, 102, 118)
    --local tower = create(object, x + 12, y + 10, 16, 32)
    --tower.on_click = tower_on_click
    screen_string_sprite = {
    74, 93, 93, 75, 76, 
    93, 106, 107, 106, 75, 
    93, 92, 91, 108, 75, 
    74, 93, 93, 75, 76, 
    0, 0, 123, 0, 0}

    screen_string_turn_x_axis = {
    false, false, false, false, false, 
    false, false, false, false, false, 
    false, false, false, false, false, 
    false, false, false, false, false, 
    false, false, false, false, false, 
    }

    screen_string_turn_y_axis = {
    false, false, false, false, false, 
    true, false, false, false, true, 
    true, false, false, false, true, 
    true, false, false, false, true,
    false, false, false, false, false, 
    }
    local screen = create(object, x + 22, y + 50, 24, 16) 
    screen.draw = function(self)
        for i=1, 25 do
            spr(screen_string_sprite[i],
            self.x + ((i%5)*8),
            self.y + ((i\5)*8), 
            1, 1, 
            screen_string_turn_x_axis[i], 
            screen_string_turn_y_axis[i]) 
        end 
    end
    screen.on_click = screen_on_click
    --screen.spr = 90
    --local cd = create(object, x + 22, y + 50, 16, 32)
    --cd.on_click = cd_on_click
    
end
function init_main_menu_new_game()
    local x, y = main_menu.x + 0, main_menu.y + 0
    local start = create(text, 64, 40)
    start.text = "new game"
    start.is_centered = true
    start:init()
    start.on_click = start_game
end

function init_main_menu()
    local x, y = main_menu.x + 0, main_menu.y + 0
    local options = create(text, x + 64, y + 50)
    options.text = "options"
    options.is_centered = true
    options:init()
    options.on_click = move_to_option_menu
    spawn_particles(5, 3, options.x, options.y, 7)
    local credits = create(text, x + 64, y + 60)
    credits.text = "credits"
    credits.is_centered = true
    credits:init()
    credits.on_click = function()
        psfx("transi2")
        launch_credits()
    end
    spawn_particles(5, 3, credits.x, credits.y, 7)
    local achievements = create(text, x + 64, y + 70)
    achievements.text = "achievements"
    achievements.is_centered = true
    achievements:init()
    achievements.on_click = move_to_achievements
    spawn_particles(5, 3, achievements.x, achievements.y, 7)
    local badgecnt = create(object, x + 64, 80, 24, 8)
    badgecnt.update = function(self)
        self.text = "(" .. badge_count .. "/" .. tostring(#all_achievements) .. ")"
        self.draw = function(self)
            print(self.text, self.x+1, self.y+1, 0)
            print(self.text, self.x, self.y, 7)
        end
    end
    badgecnt.on_click = function(self)
        if mode == "lumberjack" then
            spawn_particles(5, 3, cam.x + stat(32), cam.y + stat(33), 10)
            psfx("kokoko")
            unlock_badge("paid_attention")
        end
    end
    spawn_particles(5, 3, badgecnt.x, badgecnt.y, 7)

    local bckbtn = create(text, x, y)
    bckbtn.hit_w = 128
    bckbtn.hit_h = 128
    bckbtn.on_right_click = move_to_splash_screen
    local bcktxt = create(text, x + 120-46, y+120)
    bcktxt.text = "🅾️ to go back"
end

function init_achievements_menu()
    local x, y = badges_menu.x + 0, badges_menu.y + 0
    local mx, my = 10, 20
    local distance = 14
    local line_size = 8
    for i = 0, #all_achievements - 1 do
        local badge = create(badge, x + mx + (i % line_size) * distance, y + my + flr(i \ line_size) * distance)
        badge.achievement_index = i + 1
    end

    local cat = create(cat, x+20, y+108)
    cat.i = 4
    cat.c1 = 0
    cat.c2 = 1
    --
    local bckbtn = create(text, x, y)
    bckbtn.hit_w = 128
    bckbtn.hit_h = 128
    bckbtn.on_right_click = move_to_main_menu
    local bcktxt = create(text, x + 120-46, y+120)
    bcktxt.text = "🅾️ to go back"
    local tiptxt = create(text, x, y+120)
    tiptxt.text = "❎ to get a hint"
end

function init_options_menu()
    local x, y = options_menu.x + 0, options_menu.y + 0
    local sound = create(text, x + 64, y + 50)
    sound.text = "audio"
    sound.is_centered = true
    sound:init()
    sound.on_click = move_to_sound_menu
    local time = create(text, x + 64, y + 60)
    time.text = "time"
    time.is_centered = true
    time:init()
    time.on_click = move_to_time_menu
    local accessibility = create(text, x + 64, y + 70)
    accessibility.text = "accessibility"
    accessibility.is_centered = true
    accessibility:init()
    accessibility.on_click = move_to_accessibility_menu
    local modes = create(text, x + 64, y + 80)
    modes.text = "modes"
    modes.is_centered = true
    modes:init()
    modes.on_click = move_to_modes_menu
    --
    local bckbtn = create(text, x, y)
    bckbtn.hit_w = 128
    bckbtn.hit_h = 128
    bckbtn.on_right_click = move_to_main_menu
    local bcktxt = create(text, x + 120-46, y+120)
    bcktxt.text = "🅾️ to go back"
end

function init_sound_menu()
    local x, y = options_sound_menu.x + 0, options_sound_menu.y + 0

    local general_sound = create(text, x + 64, y + 32)
    general_sound.text = "general sound"
    general_sound.is_centered = true
    general_sound:init()
    general_sound.selectable = false

    local general_sound_cb = create(checkbox, general_sound.x  - 40, general_sound.y-1)
    general_sound_cb.checked = true
    general_sound_cb.on_click = function(self)
        checkbox.on_click(self)
        music_on = self.checked
        sfx_on = self.checked
        if music_on == false and sfx_on == false then
            unlock_badge("soundp")
        end
        if music_on == true and sfx_on == true then
            unlock_badge("soundm")
        end
        click_valid()
    end

    local music = create(text, x + 64, y + 42)
    music.text = "music"
    music.is_centered = true
    music:init()
    music.selectable = false

    local music_cb = create(checkbox, music.x - 40, music.y - 1)
    music_cb.checked = true
    music_cb.on_click = function(self)
        checkbox.on_click(self)
        music_on = self.checked
        if music_on == false then
            unlock_badge("sad_hector")
        end
        click_valid()
    end

    local sound_effects = create(text, x + 64, y + 52)
    sound_effects.text = "sound effects"
    sound_effects.is_centered = true
    sound_effects:init()
    sound_effects.selectable = false

    local sound_effects_cb = create(checkbox, sound_effects.x  - 40, sound_effects.y-1)
    sound_effects_cb.checked = true
    sound_effects_cb.on_click = function(self)
        checkbox.on_click(self)
        sfx_on = self.checked
        click_valid()
    end

    local bckbtn = create(text, x, y)
    bckbtn.hit_w = 128
    bckbtn.hit_h = 128
    bckbtn.on_right_click = move_to_option_menu
    local bcktxt = create(text, x + 120-46, y+120)
    bcktxt.text = "🅾️ to go back"
end

function init_time_menu()
    local x, y = options_time_menu.x + 0, options_time_menu.y + 0
    local date = create(text, x + 64, y + 10)
    date.text = "current date"
    date.is_centered = true
    date:init()
    date.selectable = false
    --
    local year = create(modnumber, x + 35, y + 30)
    year.value = stat(90)
    year.min = 1900
    year.max = 2050
    year:init()
    local month = create(modnumber, x + 60, y + 30)
    month.value = stat(91)
    month.min = 1
    month.max = 12
    month:init()
    local day = create(modnumber, x + 80, y + 30)
    day.value = stat(92)
    day.min = 1
    day.max = 31
    day:init()
    tday.year = year
    tday.month = month
    tday.day = day
    --
    local birthday = create(text, x + 64, y + 64)
    birthday.text = "your birthday"
    birthday.is_centered = true
    birthday:init()
    birthday.selectable = false
    local year = create(modnumber, x + 35, y + 84)
    year.value = 1989
    year.min = 1900
    year.max = 2050
    year:init()
    local month = create(modnumber, x + 60, y + 84)
    month.value = 12
    month.min = 1
    month.max = 12
    month:init()
    local day = create(modnumber, x + 80, y + 84)
    day.value = 31
    day.min = 1
    day.max = 31
    day:init()
    bday.year = year
    bday.month = month
    bday.day = day
    --
    local bckbtn = create(text, x, y)
    bckbtn.hit_w = 128
    bckbtn.hit_h = 128
    bckbtn.on_right_click = move_to_option_menu
    local bcktxt = create(text, x + 120-46, y+120)
    bcktxt.text = "🅾️ to go back"
end

function init_modes_menu()
    local x, y = options_modes_menu.x + 0, options_modes_menu.y + 0
    local ystrt = 32
    local yspace = 15
    local i = 0

    for k, v in pairs(mode_list) do
        if v.showed then
            local modetxt = create(text, x + 64, y + ystrt + i * yspace)
            modetxt.text = k.." mode"
            modetxt.is_centered = true
            modetxt:init()
            modetxt.selectable = false
            local mode_cb = create(checkbox_mode, modetxt.x  - 40, modetxt.y-1)
            mode_cb.on_click = switch_mode
            mode_cb.mode = k
            i += 1
        end
    end
    --
    local bckbtn = create(text, x, y)
    bckbtn.hit_w = 128
    bckbtn.hit_h = 128
    bckbtn.on_right_click = move_to_option_menu
    local bcktxt = create(text, x + 120-46, y+120)
    bcktxt.text = "🅾️ to go back"
end

function init_accessibility_menu()
    local x, y = options_accessibility_menu.x, options_accessibility_menu.y

    local blindtxt = create(text, x + 64, y + 56)
    blindtxt.text = "colorblind mode"
    blindtxt.is_centered = true
    blindtxt:init()
    blindtxt.selectable = false
    local blind_cb = create(checkbox, blindtxt.x  - 40, blindtxt.y-1)
    blind_cb.checked = false
    blind_cb.on_click = function(self)
        psfx("tchak")
        unlock_badge("blind")
        gstate = 3
        blind_cor = cocreate(colorblind_seq)
        while (stat(30)) do
            stat(31)
        end
    end
    --
    local bckbtn = create(text, x, y)
    bckbtn.hit_w = 128
    bckbtn.hit_h = 128
    bckbtn.on_right_click = move_to_option_menu
    local bcktxt = create(text, x + 120-46, y+120)
    bcktxt.text = "🅾️ to go back"
end

function init_gameplay()
    ply = create(player, game.x + 64, game.y + 64)
    local plyt = create(text, game.x + 88, game.y + 44)
    ply.target = plyt

    local cat = create(cat,game.x+85,game.y+37)
    cat.i = 5
    cat.c1 = 12
    cat.c2 = 7
end

-- events functions

function update_colorblind_mode()
    if blind_cor and costatus(blind_cor) != 'dead' then
        coresume(blind_cor)
        return
    else
        blind_cor = nil
    end
end

function colorblind_seq()
    local inputcnt = 9
    local clickcnt = 0
    while clickcnt < inputcnt do
        if stat(30) or btnp(❎) or btnp(🅾️) then
            prand_sfx()
            clickcnt += 1
            stat(31)
        end
        yield()
    end
    psfx("tchak")
    gstate = 1
end

function switch_mode(self)
    if mode_list[self.mode].locked then
        local n = create(notif, 0, 0)
        n.text = "get 20 achievements to unlock"
        click_error()
    else
        if mode != self.mode then
            mode = self.mode
            click_valid()
            if mode == "patched" then
                unlock_badge("connected")
            end
        end
    end
end

function on_date_change()
    if tday.day.value == bday.day.value and tday.month.value == bday.month.value then
        unlock_badge("birthday")
        if tday.year.value == bday.year.value then
            unlock_badge("birthday_today")
        end
    end
    if tday.day.value == 25 and tday.month.value == 12 then
        unlock_badge("merry_christmas")
    end
    if tday.year.value == 1955 and tday.day.value == 5 and tday.month.value == 11 then
        unlock_badge("marty_mcfly")
    end
    if tday.day.value == 2 and tday.month.value == 2 then
        unlock_badge("groundhog_day")
    end
    if tday.day.value == 21 and tday.month.value == 9 then
        unlock_badge("do_you_remember")
    end
    if tday.year.value == 1997 and tday.day.value == 29 and tday.month.value == 8 then
        unlock_badge("terminator_two")
    end
end

function click_error()
    psfx("error1")
    spawn_particles(5, 3, cam.x + stat(32), cam.y + stat(33), 2)
    shake = 3
end

function click_valid(c)
    c = c or 11
    psfx("tok1")
    spawn_particles(6, 3, cam.x + stat(32), cam.y + stat(33), c)
end

function tree_on_click(self)
    if mode == "lumberjack" then
        if self.life > 1 then
            psfx("ko1")
            self.life -= 1
        else
            psfx("kokoko")
            spawn_particles(5, 3, cam.x + stat(32), cam.y + stat(33), 6)
            del(objects, self)
            unlock_badge("tree")
        end
        spawn_particles(5, 3, cam.x + stat(32), cam.y + stat(33), 4)
        shake = 3
    end
end


function tower_on_click(self)
    if mode == "cd" then 
    unlock_badge("CD")
    mode = "hand"
    end
end 

function screen_on_click(self) 
    mode = "normal"
    move_to_splash_screen()
end 

function cd_on_click(self)
    if mode == "hand" then
        mode = "cd"
    end
end 

-- access menus

function move_to_main_menu(self, tp)
    tp = tp or false
    psfx("transi2")
    set_cam(main_menu, tp)
    unlock_badge("intro1")
    unlock_badge("intro2")
    unlock_badge("intro3")
end

function move_to_achievements(self)
    psfx("transi1")
    set_cam(badges_menu)
    unlock_badge("badge")
end

function move_to_option_menu(self)
    psfx("transi1")
    set_cam(options_menu)
end

function move_to_sound_menu(self)
    psfx("transi1")
    set_cam(options_sound_menu)
end

function move_to_time_menu(self)
    psfx("transi1")
    set_cam(options_time_menu)
end

function move_to_accessibility_menu(self)
    psfx("transi1")
    set_cam(options_accessibility_menu)
end

function move_to_modes_menu(self)
    psfx("transi1")
    set_cam(options_modes_menu)
end

function move_to_splash_screen(self)
    pmusic("title")
    psfx("transi1")
    set_cam(splash_screen)
end

function move_to_irl_screen(self)
    mode = "hand"
    psfx("transi1")
    set_cam(irl_menu)
end

function set_cam(coords, tp)
    tp = tp or false
    tcam.x, tcam.y = coords.x, coords.y
    if tp then
        cam.x, cam.y = coords.x, coords.y
    end
end

function start_game(self)
    unlock_badge("start1")
    if mode == "play" then
        set_cam(game, true)
        ply.active = true
        unlock_badge("launchgame")
    else
        local txt = create(notif, cam.x + stat(32) + 5, cam.y + stat(33) - 5)
        txt.text = "switch to play mode to start"
        click_error()
    end
    if not is_menu_open then
        init_main_menu()
        is_menu_open = true
    end
end

-- specific draws

function draw_spash_screen()
    local sline = 96
    local gh = 42
    rectfill(splash_screen.x, splash_screen.y, splash_screen.x + 128, splash_screen.y + sline, 12)
    rectfill(splash_screen.x, splash_screen.y + sline, splash_screen.x + 128, splash_screen.y + 128 + sline, 1)
    draw_gradient(splash_screen.x, splash_screen.y + sline - gh/2, 128, gh, 0x1c)
    -- draw map
    map(0, 48, splash_screen.x, splash_screen.y, 14, 16)
end

function draw_game()
    local s = 7
    map(15, 58, game.x+64-s*4, game.y + 64-s*4, s, s)
end

function draw_gradient(x, y, w, h, c)
    local fpat={
        0b0000100000000000, 0b1000000000100000, 0b0010000010100000, 0b1010000010100000, 0b1010010010100000, 0b1010010010100001,
        0b1010010110100101,
        0b0101111001011010, 0b0101111101011011, 0b0101111101011111, 0b0101111111011111, 0b0111111111011111, 0b1111011111111111
    }
    for i=1, #fpat do
        local ly = y + (h * (i-1)) / #fpat
        fillp(fpat[(i)])
        rectfill(x,ly,x+w-1,ly+h/#fpat,c)
    end
    fillp()
end