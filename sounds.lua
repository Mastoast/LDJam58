--[[ SFXs
]]

sfxs = {
    transi1 = {n = 8, offset = 0, length = 4},
    transi2 = {n = 8, offset = 7, length = 4}
}

function psfx(code)
    local fx = sfxs[code]
    if not fx then printh("NO SFX: "..code) return end
    sfx(fx.n, -1, fx.offset, fx.length)
end