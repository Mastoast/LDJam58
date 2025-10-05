function init_popup(achievement)
    ptime = 0
    panim_time = 20
    pratio = 0
    popup_objects = {}
    gstate = 2
    --
    local title = create(text, cam.x + 64, cam.y + 36, 8, 8, popup_objects)
    title.text = achievement.name
    title.is_centered = true
    title.wide = true
    title.color = 9
    local desc = create(text, cam.x + 64, cam.y + 72, 8, 8, popup_objects)
    desc.text = achievement.description
    desc.is_centered = true
    desc.color = 7
    --
    pop_cor = cocreate(popup_animation)
end

function pop_popups()
    local safe_distance = 1
    if #incoming_popups > 0 and abs(cam.x - tcam.x) < safe_distance and abs(cam.x - tcam.x) < safe_distance then
        pmusic("fanfare")
        init_popup(incoming_popups[1])
        del(incoming_popups, incoming_popups[1])
    end
end

function close_popup()
    psfx("notif2")
    gstate = 1
    popup_objects = {}
end

function update_popup()
    ptime += 1
    pratio = min(ptime / panim_time, 1)

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
    local cbtn = create(button, cam.x + 64, cam.y + 90, 8, 8, popup_objects)
    cbtn.text = "ok"
    cbtn.c = 9
    cbtn:init()
    while not (on_cursor(cbtn) and btnp(❎)) do
        cbtn.hover = on_cursor(cbtn)
        yield()
    end
    close_popup()
end

function draw_popup()
    local mx, my = 16, 16
    local sx = lerp(0, 128 - mx*2, pratio)
    local sy = lerp(0, 128 - my*2, pratio)
    local x = lerp(cam.x + 64, cam.x + mx, pratio)
    local y = lerp(cam.y + 64, cam.y + my, pratio)
    -- fillp(0b0100111001000010)
    fillp(0b1000010100100100)
    rrectfill(x, y, sx, sy, 4, 0x21)
    fillp()
    rrect(x, y, sx, sy, 4, 13)

    for o in all(popup_objects) do
        o:draw()
    end
end