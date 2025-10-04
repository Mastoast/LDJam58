main_menu = {x = 0, y = 0}
badges_menu = {x = 128, y = 128}


function init_main_menu()
    --
    local start = create(text, 64, 32)
    start.text = "start"
    start.is_centered = true
    start:init()
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
    local mx, my = 8, 16
    local distance = 23
    local line_size = 1
    for i = 0, #all_achievements - 1 do
        local badge = create(badge, x + mx + (i % line_size) * distance, y + my + flr(i \ line_size) * distance)
        badge.name = all_achievements[i+1].name
        badge.description = all_achievements[i+1].description
        badge.tip = all_achievements[i+1].tip
    end
end

function move_to_main_menu(self)
    tcam.x, tcam.y = main_menu.x, main_menu.y
end

function move_to_achievements(self)
    tcam.x, tcam.y = badges_menu.x, badges_menu.y
end