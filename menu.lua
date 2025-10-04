menu = {}
menu.objects = {}

function menu.init(self)
    self.objects = {}
    local start = create(text, 64, 32)
    start.text = "start"
    start.is_centered = true
    local options = create(text, 64, 40)
    options.text = "options"
    options.is_centered = true
    local credits = create(text, 64, 48)
    credits.text = "credits"
    credits.is_centered = true
    local achievements = create(text, 64, 56)
    achievements.text = "achievements"
    achievements.is_centered = true
end
function menu.update(self) end
function menu.draw(self) end