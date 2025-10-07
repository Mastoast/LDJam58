function init_popup(achievement, anim_time, btn_time, isnew)
    ptime = 0
    panim_time = anim_time or (achievement.unlocked and 15) or 10
    pbtn_time = btn_time or (achievement.unlocked and 170) or 15
    pratio = 0
    pnew = isnew or false
    popup_objects = {}
    gstate = 2
    --
    local tty = 28
    local tcol = achievement.unlocked and 9 or 13
    local title = create(text, cam.x + 64, cam.y + tty, 8, 8, popup_objects)
    title.text = achievement.name
    title.is_centered = true
    title.wide = true
    title.color = tcol
    if achievement.unlocked then
        local desc = create(text, cam.x + 64, cam.y + 64, 8, 8, popup_objects)
        desc.text = achievement.description
        desc.is_centered = true
        desc.color = 7
        local coin = create(asprite, cam.x + 56, cam.y + 8, 16, 16, popup_objects)
        coin.size = 1
    else
        local tip = create(text, cam.x + 64, cam.y + 64, 8, 8, popup_objects)
        tip.text = achievement.tip
        tip.is_centered = true
        tip.color = 7
    end

    --
    pop_cor = cocreate(popup_animation)
end

function pop_popups()
    local safe_distance = 1
    local delayed = gtime < popup_last_input + popup_delay
    local cam_static = abs(cam.x - tcam.x) < safe_distance and abs(cam.y - tcam.y) < safe_distance
    if #incoming_popups > 0 and cam_static and not delayed then
        pmusic("fanfare")
        init_popup(incoming_popups[1], 15, 170, true)
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

    for o in all(popup_objects) do
        o:update()
    end

    if pop_cor and costatus(pop_cor) != 'dead' then
        coresume(pop_cor)
        return
    else
        pop_cor = nil
    end
end

function popup_animation()
    while ptime < pbtn_time do
        yield()
    end
    local cbtn = create(button, cam.x + 64, cam.y + 90, 8, 8, popup_objects)
    cbtn.text = "ok"
    cbtn.c = 9
    cbtn:init()
    if pnew then
        spawn_particles(5, 3, cbtn.x, cbtn.y, 10)
        spawn_particles(5, 3, cbtn.x + 8, cbtn.y + 8, 10)
        spawn_particles(5, 3, cbtn.x + 8, cbtn.y, 10)
        spawn_particles(5, 3, cbtn.x, cbtn.y + 8, 10)
    end
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

    -- fillp(0b1000010100100100)
    --rrectfill(x, y, sx, sy, 4, 0x21)
    -- fillp()
    -- rrect(x, y, sx, sy, 4, 13)
    
    local mrg = 2
    rrectfill(x - mrg, y - mrg, sx + mrg*2, sy+mrg*2, 4, 13)
    draw_gradient(x, y, sx, sy, 0x21)

    for o in all(popup_objects) do
        o:draw()
    end
end