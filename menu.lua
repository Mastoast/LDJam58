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
    local back_btn = create(text, badges_menu.x + 110, badges_menu.y + 112)
    back_btn.text = "back"
    back_btn:init()
    back_btn.on_click = move_to_main_menu
end

--

function init_options_menu()
    local x, y = options_menu.x + 0, options_menu.y + 0
    local sound = create(text, x + 64, y + 32)
    sound.text = "sound"
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
end

--

function init_sound_menu()
    local x, y = options_sound_menu.x + 0, options_sound_menu.y + 0
    local general_sound = create(text, x + 64, y + 32)
    general_sound.text = "general sound"
    general_sound.is_centered = true
    general_sound:init()
    local general_sound_checkbox = create(checkbox, general_sound.x  - 16, general_sound.y)

    --general_sound.on_click = 
    local music = create(text, x + 64, y + 40)
    music.text = "music"
    music.is_centered = true
    music:init()
    --music.on_click =
    local sound_effects = create(text, x + 64, y + 48)
    sound_effects.text = "effects"
    sound_effects.is_centered = true
    sound_effects:init()
    -- sound_effects.on_click =
    --
end

function init_time_menu()
    local x, y = options_time_menu.x + 0, options_time_menu.y + 0
    local date = create(text, x + 64, y + 32)
    date.text = "date"
    date.is_centered = true
    date:init()
    --date.on_click = 
    local hour = create(text, x + 64, y + 48)
    hour.text = "hour"
    hour.is_centered = true
    hour:init()
    --hour.on_click =
    --
end

function init_modes_menu()
    local x, y = options_modes_menu.x + 0, options_modes_menu.y + 0
    local normal = create(text, x + 64, y + 40)
    normal.text = "normal mode"
    normal.is_centered = true
    normal:init()
   -- lumberjack.on_click = 
    local lumberjack = create(text, x + 64, y + 40)
    lumberjack.text = "lumberjack mode"
    lumberjack.is_centered = true
    lumberjack:init()
   -- lumberjack.on_click = 
    local boot = create(text, x + 64, y + 48)
    boot.text = "boot mode"
    boot.is_centered = true
    boot:init()
   -- boot.on_click = 
    --
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
    tcam.x, tcam.y = options_menu.x, options_menu.y
end

function move_to_sound_menu(self)
    tcam.x, tcam.y = options_sound_menu.x, options_sound_menu.y
end

function move_to_time_menu(self)
    tcam.x, tcam.y = options_time_menu.x, options_time_menu.y
end

function move_to_accessibility_menu(self)
    tcam.x, tcam.y = options_accessibility_menu.x, options_accessibility_menu.y
end

function move_to_modes_menu(self)
    tcam.x, tcam.y = options_modes_menu.x, options_modes_menu.y
end

function move_to_credits(self)
    tcam.x, tcam.y = credits_screen.x, credits_screen.y
end

function move_to_splash_screen(self)
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