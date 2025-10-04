function init_popup(achievement)
    popup_objects = {}
    gstate = 2
    local title = create(text, cam.x + 64, cam.y + 48, 8, 8, popup_objects)
    title.text = achievement.name
    title.is_centered = true
    title.color = 9
    local desc = create(text, cam.x + 64, cam.y + 72, 8, 8, popup_objects)
    desc.text = achievement.description
    desc.is_centered = true
    desc.color = 7
end

function pop_popups()
    if #incoming_popups > 0 then
        init_popup(incoming_popups[1])
        del(incoming_popups, incoming_popups[1])
    end
end

function close_popup()
    popup_objects = {}
    gstate = 1
end

function update_popup()
    for o in all(popup_objects) do

        o.hover = on_cursor(o)
        o:update()
        
        if btnp(❎) and o.hover then
            o:on_click()
        end

        if o.destroyed then
            del(popup_objects, o)
        end
    end
    if btnp(❎) then
        close_popup()
    end
end

function draw_popup()
    mx, my = 16, 16
    -- fillp(0b0100111001000010)
    fillp(0b1000010000100100)
    rrectfill(cam.x + mx, cam.y + my, 128 - mx*2, 128 - my*2, 4, 0x21)
    fillp()
    rrect(cam.x + mx, cam.y + my, 128 - mx*2, 128 - my*2, 4, 9)

    for o in all(popup_objects) do
        o:draw()
    end
end