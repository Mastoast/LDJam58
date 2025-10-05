--[[ SFXs
]]

sfxs = {
    transi1 = {n = 8, offset = 0, length = 4},
    transi2 = {n = 8, offset = 8, length = 4},
    notif1 = {n = 9, offset = 0, length = 2},
    notif2 = {n = 9, offset = 2, length = 2},
    error1 = {n = 9, offset = 8, length = 1},
}

function psfx(code)
    local fx = sfxs[code]
    if not fx then printh("NO SFX: "..code) return end
    sfx(fx.n, -1, fx.offset, fx.length)
end


--[[ MUSICS
]]

musics = {
    fanfare = {n = 0}
}

function pmusic(code)
    local msc = musics[code]
    if not msc then printh("NO MUSIC: "..code) return end
    music(msc, 0, 15)
end