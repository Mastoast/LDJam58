main_menu = {x = 0, y = 0}
badges_menu = {x = 128, y = 128}


function init_main_menu()
    --
    local start = create(text, 64, 32)
    start.text = "start"
    start.is_centered = true
    start:init()
    start.on_click = start_game
    local options = create(text, 64, 40)
    options.text = "options"
    options.is_centered = true
    options:init()
    local credits = create(text, 64, 48)
    credits.text = "credits"
    credits.is_centered = true
    credits:init()
    local achievements = create(text, 64, 56)
    achievements.text = "achievements"
    achievements.is_centered = true
    achievements:init()
    achievements.on_click = move_to_achievements
end

function init_achievements_menu()
    local x, y = badges_menu.x + 0, badges_menu.y + 0
    local mx, my = 12, 20
    local distance = 23
    local line_size = 5
    for i = 0, #all_achievements - 1 do
        local badge = create(badge, x + mx + (i % line_size) * distance, y + my + flr(i \ line_size) * distance)
        badge.achievement_index = i+1
    end
    --
    local back_btn = create(text, badges_menu.x + 110, badges_menu.y + 112)
    back_btn.text = "back"
    back_btn:init()
    back_btn.on_click = move_to_main_menu
end

--

function unlock_badge(badge)
    if badge.unlocked == true then return end
    init_popup(badge)
    badge.unlocked = true
end

--

function move_to_main_menu(self)
    tcam.x, tcam.y = main_menu.x, main_menu.y
end

function move_to_achievements(self)
    tcam.x, tcam.y = badges_menu.x, badges_menu.y
end

function start_game(self)
    unlock_badge(all_achievements[4])
end