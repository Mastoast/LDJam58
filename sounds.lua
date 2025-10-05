--[[ SFXs
]]

sfxs = {
    transi1 = {n = 8, offset = 0, length = 4},
    transi2 = {n = 8, offset = 8, length = 4},
    ko1 = {n = 8, offset = 16, length = 1},
    notif1 = {n = 9, offset = 0, length = 2},
    notif2 = {n = 9, offset = 2, length = 2},
    error1 = {n = 9, offset = 8, length = 1},
    error2 = {n = 10, offset = 8, length = 1},
    error3 = {n = 10, offset = 9, length = 1},
    splash = {n = 10, offset = 0, length = 8},
    tok1 = {n = 9, offset = 16, length = 1},
    tok2 = {n = 9, offset = 17, length = 1},
    toktok = {n = 9, offset = 16, length = 2},
    bip1 = {n = 9, offset = 2, length = 1},
    bip2 = {n = 9, offset = 3, length = 1},
    bip3 = {n = 9, offset = 4, length = 1},
    bip4 = {n = 9, offset = 5, length = 1},
    bip5 = {n = 9, offset = 6, length = 1},
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