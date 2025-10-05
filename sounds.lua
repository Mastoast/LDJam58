--[[ SFXs
]]

sfxs = {
    transi1 = {n = 8, offset = 0, length = 4},
    transi2 = {n = 8, offset = 8, length = 4},
    notif1 = {n = 9, offset = 0, length = 2},
    notif2 = {n = 9, offset = 2, length = 2},
    error1 = {n = 9, offset = 8, length = 1},
    error2 = {n = 10, offset = 8, length = 1},
    splash = {n = 10, offset = 0, length = 8},
}

function psfx(code)
    if not sfx_on then return end
    local fx = sfxs[code]
    if not fx then printh("NO SFX: "..code) return end
    sfx(fx.n, -1, fx.offset, fx.length)
end

-- play random sfx
function prand_sfx()
    local keys = {}
    for k in pairs(sfxs) do
        add(keys, k)
    end
    local r = flr(rnd(#keys))+1
    psfx(keys[r])
end


--[[ MUSICS
]]

musics = {
    fanfare = {n = 0}
}

function pmusic(code)
    if not music_on then return end
    local msc = musics[code]
    if not msc then printh("NO MUSIC: "..code) return end
    music(msc, 0, 15)
end