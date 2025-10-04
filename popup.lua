function init_popup(achievement)
    ptime = 0
    panim_time = 25
    popup_objects = {}
    gstate = 2
    local title = create(text, cam.x + 66, cam.y + 36, 8, 8, popup_objects)
    title.text = achievement.name
    title.is_centered = true
    title.color = 9
    local desc = create(text, cam.x + 64, cam.y + 72, 8, 8, popup_objects)
    desc.text = achievement.description
    desc.is_centered = true
    desc.color = 7
    --
    pop_cor = cocreate(popup_animation)
end

function pop_popups()
    if #incoming_popups > 0 then
        init_popup(incoming_popups[1])
        del(incoming_popups, incoming_popups[1])
    end
end

function close_popup()
    gstate = 1
    popup_objects = {}
end

function update_popup()
    ptime += 1
    -- for o in all(popup_objects) do

    --     o.hover = on_cursor(o)
    --     o:update()
        
    --     if btnp(❎) and o.hover then
    --         o:on_click()
    --     end

    --     if o.destroyed then
    --         del(popup_objects, o)
    --     end
    -- end
    if pop_cor and costatus(pop_cor) != 'dead' then
        coresume(pop_cor)
        return
    else
        pop_cor = nil
    end
end

function popup_animation()
    while ptime < panim_time do
        yield()
    end
    while not btnp(❎) do
        yield()
    end
    close_popup()
end

function draw_popup()
    local mx, my = 16, 16
    local sx = lerp(0, 128 - mx*2, min(ptime / panim_time, 1))
    local sy = lerp(0, 128 - my*2, min(ptime / panim_time, 1))
    -- fillp(0b0100111001000010)
    fillp(0b1000010100100100)
    rrectfill(cam.x + mx, cam.y + my, sx, sy, 4, 0x21)
    fillp()
    rrect(cam.x + mx, cam.y + my, sx, sy, 4, 9)

    for o in all(popup_objects) do
        o:draw()
    end
end