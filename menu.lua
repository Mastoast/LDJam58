menu = {}
menu.objects = {}

function init_main_menu()
    create(cursor, -120, -120)
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
end



function init_achievements_menu()
    printable = all_achievements[1].name
    local x, y = 0, 0
    local mx, my = 96, 16
    local distance = 23
    local line_size = 1
    for i = 0, #all_achievements - 1 do
        local badge = create(badge, x + mx + (i % line_size) * distance, y + my + flr(i \ line_size) * distance)
        badge.name = all_achievements[i+1].name
        badge.description = all_achievements[i+1].description
        badge.tip = all_achievements[i+1].tip
    end
end