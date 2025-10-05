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

end

function init_splash_screen_menu()
    local x, y = splash_screen.x + 0, splash_screen.y + 0
    local title = create(text, x + 64, y + 32)
    title.text = "\^t\^wnom style"
    title.is_centered = true
    title.color = 12
    title:init()
    local startbtn = create(button, x + 48, y + 72)
    startbtn.text = "start game"
    startbtn.is_centered = false
    startbtn:init()
    startbtn.on_click = move_to_main_menu
end

function init_main_menu()
    local x, y = main_menu.x + 0, main_menu.y + 0
    local start = create(text, 64, 32)
    start.text = "start"
    start.is_centered = true
    start:init()
    start.on_click = start_game
    local options = create(text, x + 64, y + 40)
    options.text = "options"
    options.is_centered = true
    options:init()
    options.on_click = move_to_option_menu
    local credits = create(text, x + 64, y + 48)
    credits.text = "credits"
    credits.is_centered = true
    credits:init()
    local achievements = create(text, x + 64, y + 56)
    achievements.text = "achievements"
    achievements.is_centered = true
    achievements:init()
    achievements.on_click = move_to_achievements
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

--

function init_options_menu()
    local x, y = options_menu.x + 0, options_menu.y + 0
    local sound = create(text, x + 64, y + 32)
    sound.text = "audio"
    sound.is_centered = true
    sound:init()
    sound.on_click = move_to_sound_menu
    local time = create(text, x + 64, y + 40)
    time.text = "time"
    time.is_centered = true
    time:init()
    time.on_click = move_to_time_menu
    local accessibility = create(text, x + 64, y + 48)
    accessibility.text = "accessibility"
    accessibility.is_centered = true
    accessibility:init()
    accessibility.on_click = move_to_accessibility_menu
    local modes = create(text, x + 64, y + 56)
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

--

function init_sound_menu()
    local x, y = options_sound_menu.x + 0, options_sound_menu.y + 0
    -- local general_sound = create(text, x + 64, y + 32)
    -- general_sound.text = "general sound"
    -- general_sound.is_centered = true
    -- general_sound:init()
    -- general_sound.selectable = false
    -- local general_sound_checkbox = create(checkbox, general_sound.x  - 40, general_sound.y-1)

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
    --
    local bckbtn = create(text, x, y)
    bckbtn.hit_w = 128
    bckbtn.hit_h = 128
    bckbtn.on_right_click = move_to_option_menu
end

function init_modes_menu()
    local x, y = options_modes_menu.x + 0, options_modes_menu.y + 0
    local normal = create(text, x + 64, y + 32)
    normal.text = "normal mode"
    normal.is_centered = true
    normal:init()
    normal.selectable = false
    local normal_checkbox = create(checkbox_mode, normal.x  - 40, normal.y-1)
    normal_checkbox.on_click = switch_mode
    normal_checkbox.mode = "normal"

   -- lumberjack.on_click = 
    local lumberjack = create(text, x + 64, y + 42)
    lumberjack.text = "lumberjack mode"
    lumberjack.is_centered = true
    lumberjack:init()
    lumberjack.selectable = false
    local lumberjack_checkbox = create(checkbox_mode, lumberjack.x  - 40, lumberjack.y-1)
    lumberjack_checkbox.on_click = switch_mode
    lumberjack_checkbox.mode = "lumberjack"

    local boot = create(text, x + 64, y + 52)
    boot.text = "boot mode"
    boot.is_centered = true
    boot:init()
    boot.selectable = false
    local boot_checkbox = create(checkbox_mode, boot.x  - 40, boot.y-1)
    boot_checkbox.on_click = switch_mode
    boot_checkbox.mode = "boot"
   -- boot.on_click = 
    --
    local bckbtn = create(text, x, y)
    bckbtn.hit_w = 128
    bckbtn.hit_h = 128
    bckbtn.on_right_click = move_to_option_menu
end

-- stuff

function switch_mode(self)
    mode = self.mode
end
-- access menus

function move_to_main_menu(self)
    psfx("transi2")
    tcam.x, tcam.y = main_menu.x, main_menu.y
    start_intro(self)
end

function move_to_achievements(self)
    psfx("transi1")
    tcam.x, tcam.y = badges_menu.x, badges_menu.y
    achievement_achievement(self)
end

function move_to_option_menu(self)
    psfx("transi1")
    tcam.x, tcam.y = options_menu.x, options_menu.y
end

function move_to_sound_menu(self)
    psfx("transi1")
    tcam.x, tcam.y = options_sound_menu.x, options_sound_menu.y
end

function move_to_time_menu(self)
    psfx("transi1")
    tcam.x, tcam.y = options_time_menu.x, options_time_menu.y
end

function move_to_accessibility_menu(self)
    psfx("transi1")
    tcam.x, tcam.y = options_accessibility_menu.x, options_accessibility_menu.y
end

function move_to_modes_menu(self)
    psfx("transi1")
    tcam.x, tcam.y = options_modes_menu.x, options_modes_menu.y
end

function move_to_credits(self)
    psfx("transi1")
    tcam.x, tcam.y = credits_screen.x, credits_screen.y
end

function move_to_splash_screen(self)
    psfx("transi1")
    tcam.x, tcam.y = splash_screen.x, splash_screen.y
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
    psfx("error1")
    spawn_particles(5, 3, cam.x + stat(32), cam.y + stat(33), 2)
    shake = 3
    unlock_badge("start1")
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