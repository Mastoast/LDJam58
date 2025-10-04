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
    local x, y = 100, 100
    for a in all(achievements) do
        
    end
end