main_menu = { x = 0, y = 0 }
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
    init_main_menu()
    init_achievements_menu()
    init_options_menu()
    init_sound_menu()
    init_time_menu()
    init_modes_menu()
    init_accessibility_menu()
    init_gameplay()
    make_credits_appear()
end

function init_splash_screen_menu()
    local x, y = splash_screen.x + 0, splash_screen.y + 0
    local title = create(text, x + 64, y + 32)
    title.text = "\^t\^wshadow sword       //// \^t\^    iv"
    title.is_centered = true
    title.color = 10
    title:init()
    local startbtn = create(button, x + 45, y + 72)
    startbtn.text = "start game"
    startbtn.is_centered = true
    startbtn:init()
    startbtn.on_click = move_to_main_menu
    local tree = create(object, x + 2, y + 60, 16, 32)
    tree.spr = 1
    tree.life = 3
    tree.on_click = function(self)
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
end

function init_main_menu()
    local x, y = main_menu.x + 0, main_menu.y + 0
    local start = create(text, 64, 40)
    start.text = "new game"
    start.is_centered = true
    start:init()
    start.on_click = start_game
    local options = create(text, x + 64, y + 50)
    options.text = "options"
    options.is_centered = true
    options:init()
    options.on_click = move_to_option_menu
    local credits = create(text, x + 64, y + 60)
    credits.text = "credits"
    credits.is_centered = true
    credits:init()
    credits.on_click = move_to_credits
    local achievements = create(text, x + 64, y + 70)
    achievements.text = "achievements"
    achievements.is_centered = true
    achievements:init()
    achievements.on_click = move_to_achievements
    local badgecnt = create(text, x + 64, 80)
    badgecnt.is_centered = false
    badgecnt.selectable = false
    badgecnt.update = function(self)
        self.text = "(" .. badge_count .. "|" .. tostring(#all_achievements) .. ")"
        self:init()
    end
    local bckbtn = create(text, x, y)
    bckbtn.hit_w = 128
    bckbtn.hit_h = 128
    bckbtn.on_right_click = move_to_splash_screen
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
    --
    local bckbtn = create(text, x, y)
    bckbtn.hit_w = 128
    bckbtn.hit_h = 128
    bckbtn.on_right_click = move_to_main_menu
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
end

function init_sound_menu()
    local x, y = options_sound_menu.x + 0, options_sound_menu.y + 0

    --general_sound.on_click = 
    local music = create(text, x + 64, y + 42)
    music.text = "music"
    music.is_centered = true
    music:init()
    music.selectable = false

    local music_cb = create(checkbox, music.x  - 40, music.y-1)
    music_cb.checked = true
    music_cb.on_click = function(self)
        checkbox.on_click(self)
        music_on = self.checked
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
    end

    local bckbtn = create(text, x, y)
    bckbtn.hit_w = 128
    bckbtn.hit_h = 128
    bckbtn.on_right_click = move_to_option_menu
end

function init_time_menu()
    local x, y = options_time_menu.x + 0, options_time_menu.y + 0
    local date = create(text, x + 64, y + 10)
    date.text = "date"
    date.is_centered = true
    date:init()
    date.selectable = false
    --
    local year = create(modnumber, x + 35, y + 30)
    year.value = 1993
    year.min = 1900
    year.max = 2050
    year:init()
    local month = create(modnumber, x + 60, y + 30)
    month.value = 10
    month.min = 1
    month.max = 12
    month:init()
    local day = create(modnumber, x + 80, y + 30)
    day.value = 23
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
end

function init_modes_menu()
    local x, y = options_modes_menu.x + 0, options_modes_menu.y + 0
    local ystrt = 32
    local yspace = 15
    local i = 0
    for k, v in pairs(mode_list) do
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
    --
    local bckbtn = create(text, x, y)
    bckbtn.hit_w = 128
    bckbtn.hit_h = 128
    bckbtn.on_right_click = move_to_option_menu
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
        psfx("error2")
        unlock_badge("blind")
        gstate = 3
        blind_cor = cocreate(colorblind_seq)
    end
    --
    local bckbtn = create(text, x, y)
    bckbtn.hit_w = 128
    bckbtn.hit_h = 128
    bckbtn.on_right_click = move_to_option_menu
end

function init_gameplay()
    local ply = create(player, game.x + 64, game.y + 64)
    local plyt = create(text, game.x + 8, game.y + 112)
    ply.target = plyt
end

-- stuff

function update_colorblind_mode()
    if blind_cor and costatus(blind_cor) != 'dead' then
        coresume(blind_cor)
        return
    else
        blind_cor = nil
    end
end

function colorblind_seq()
    local clickcnt = 0
    while clickcnt < 12 do
        if btnp(❎) then
            prand_sfx()
            clickcnt += 1
        end
        yield()
    end
    psfx("error2")
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
        end
    end
end

function on_date_change()
    if tday.day == bday.day and tday.month == bday.month then
        birthday()
        if tday.year.value == bday.year.value then
            birthday_is_today()
        end
    end
    if tday.day == 25 and tday.month == 12 then
        merry_christmas()
    end 
    if tday.year == 1955 and tday.day == 5 and tday.month == 11 then
        marty_mcfly()
    end 
    if tday.day == 4 and tday.month == 5 then
        star_wars()
    end 
    if tday.day == 13 and tday.month == 10 then
        parks_and_rec()
    end 
    if tday.day == 2 and tday.month == 2 then
        groundhog_day()
    end 
    if tday.day == 21 and tday.month == 9 then
        do_you_remember()
    end 
    if tday.year == 1997 and tday.day == 29 and tday.month == 8 then
        terminator_two()
    end
    if tday.year == 1988 and tday.day == 24 and tday.month == 12 then
        die_hard()
    end
end

function click_error()
    psfx("error1")
    spawn_particles(5, 3, cam.x + stat(32), cam.y + stat(33), 2)
    shake = 3
end

function click_valid()
    psfx("tok1")
    spawn_particles(6, 3, cam.x + stat(32), cam.y + stat(33), 11)
end

-- access menus

function move_to_main_menu(self)
    psfx("transi2")
    set_cam(main_menu)
    start_intro(self)
end

function move_to_achievements(self)
    psfx("transi1")
    set_cam(badges_menu)
    achievement_achievement(self)
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

function move_to_credits(self)
    psfx("transi1")
    is_on_credits = true
    set_cam(credits_screen)
end

function move_to_splash_screen(self)
    psfx("transi1")
    set_cam(splash_screen)
end

function set_cam(coords, tp)
    tp = tp or false
    tcam.x, tcam.y = coords.x, coords.y
    if tp then
        cam.x, cam.y = coords.x, coords.y
    end
end

-- unlock achievements

function start_intro(self)
    unlock_badge("intro1")
    unlock_badge("intro2")
    unlock_badge("intro3")
end

function achievement_achievement(self)
    unlock_badge("badge")
end

function start_game(self)
    if mode == "play" then
        set_cam(game, true)
    else
        local txt = create(notif, cam.x + stat(32) + 5, cam.y + stat(33) - 5)
        txt.text = "switch to play mode to start"
        click_error()
        unlock_badge("start1")
    end
end

function sound_down(self)
    unlock_badge("soundp")
end

function sound_up(self)
    unlock_badge("soundm")
end

function hour_midnight(self)
    unlock_badge("time1")
end

function date_movie(self)
    unlock_badge("time2")
end

function easy_mode(self)
    unlock_badge("test1")
end

function full_credit(self)
    unlock_badge("test2")
end

function not_full_credit(self)
    unlock_badge("test3")
end

function birthday(self)
    unlock_badge("birthday")
end

function birthday_is_today(self)
    unlock_badge("birthday_today")
end

function merry_christmas(self)
    unlock_badge("christmas")
end

function marty_mcfly(self)
    unlock_badge("marty_mcfly")
end

function star_wars(self)
    unlock_badge("star_wars")
end

function parks_and_rec(self)
    unlock_badge("parks_and_rec")
end

function groundhog_day(self)
    unlock_badge("groundhog_day")
end

function do_you_remember(self)
    unlock_badge("do_you_remember")
end

function terminator_two(self)
    unlock_badge("terminator_two")
end

function die_hard(self)
    unlock_badge("die_hard")
end

function konami(self)
    konami("die_hard")
end

-- specific draws

function draw_spash_screen()
    local sline = 96
    local gh = 42
    rectfill(splash_screen.x, splash_screen.y, splash_screen.x + 128, splash_screen.y + sline, 12)
    rectfill(splash_screen.x, splash_screen.y + sline, splash_screen.x + 128, splash_screen.y + 128 + sline, 1)
    draw_gradient(splash_screen.x, splash_screen.y + sline - gh/2, 128, gh, 0x1c)
    -- draw map
    map(0, 48, splash_screen.x, splash_screen.y, 16, 16)
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