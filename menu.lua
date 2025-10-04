menu = {}
menu.objects = {}

function menu.init(self)
    self.objects = {}
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