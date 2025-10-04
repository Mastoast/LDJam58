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


function init_main_menu()
    local x, y = main_menu.x + 0, main_menu.y + 0
    -- TESTS
    local test_checkbox = create(checkbox, x + 16, y + 16)
    --
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
    --sound.on_click =
    local time = create(text, x + 64, y + 40)
    time.text = "time"
    time.is_centered = true
    time:init()
    --time.on_click =
    local accessibility = create(text, x + 64, y + 48)
    accessibility.text = "accessibility"
    accessibility.is_centered = true
    accessibility:init()
    --accessibility.on_click =
    local modes = create(text, x + 64, y + 56)
    modes.text = "modes"
    modes.is_centered = true
    modes:init()
    --modes.on_click =
    --
end

-- access menus

function move_to_main_menu(self)
    tcam.x, tcam.y = main_menu.x, main_menu.y
    unlock_badge("intro1")
    unlock_badge("intro2")
    unlock_badge("intro3")
end

function move_to_achievements(self)
    tcam.x, tcam.y = badges_menu.x, badges_menu.y
    unlock_badge("badge")
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