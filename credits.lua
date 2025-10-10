credit_text =[[credits




responsible for 90%
of the code that works
MASTOAST

writer Who thought meta
humor was still cool
PANDALK

chief "annoying jingle" operator
MASTOAST

The one who drew that
tree you can cut
PANDALK

the person who thought
900 grams of m&m's was
enough for the week-end
PANDALK

chief of
"add it to the list"
department
MASTOAST

chief officer of
"just one more feature"
PANDALK

the person you can blame
for everything
MASTOAST

the person who forgot
to push their code
PANDALK

that one developer who said
"it works on my machine"
MASTOAST

[redacted for spoilers]
PANDALK

probably asleep right now
MASTOAST

director of Unintended features
PANDALK

the guy who thought
this was funny
PANDALK


special thanks:

SATOSHI KON 
RICHARD GARFIELD
THE DISCO ELYSIUM TEAM
THE GREATER GOOD
MY CAT FLEYA
BOB. MERCI BOB
AND YOU WHO ARE DEFINITELY
READING THIS RIGHT NOW!














did you know you could cut 
the achievement count to 
get an extra one?














ANYWAY, ANYONE ELSE HYPED BY
THE WOW HOUSING FEATURE?
I CAN'T WAIT TO PLAY A WORSE
VERSION OF THE SIMS
IN MY FAVORITE MMO











STILL THERE?
WAIT,
I MUST HAVE SOMETHING MORE







HERE GOES:

SEA ANEMONES ARE RELATIVES OF
THE JELLYFISH. THEY HAVE THESE
TINY HAIRS GROWING ON THEM
THAT THEY USE TO FEED BY
STUNNING FISH, SHRIMP,
ZOOPLANKTON, AND SO ON.

BUT THEY CAN SURVIVE FOR YEARS
WITHOUT FOOD. THEY'RE LIKE
JELLYFISH IN THAT WAY. THERE
ARE EVEN SEA ANEMONES THAT HAVE
LIVED LONGER THAN 70 YEARS WITH
THE PROPER CARE.

THEY'RE FOUND ALL THROUGHOUT
THE WORLD'S OCEANS, AND THEY
CAN SLOWLY MOVE TOO. THERE ARE
ALSO FISH THAT LIVE INSIDE THEM
CALLED ANEMONEFISH. THE SEA
ANEMONES PROTECT THEM FROM
PREDATORS AND SHARE THEIR
FOOD SCRAPS.

IN TROPICAL WATERS, SEA
ANEMONES LATCH ON TO CORAL
REEFS OR ROCKS.

STARFISH ARE ECHINODERMS AND
RELATIVES OF THE SEA URCHIN.
THERE ARE AS MANY AS 2,000
STARFISH SPECIES AROUND THE
WORLD. NOT ALL OF THEM ARE
STAR-SHAPED EITHER. THERE'S
EVEN A SPECIES WITH 30 ARMS.

WHEN THEY GET ATTACKED BY A
PREDATOR, THEY'LL RIP OFF THEIR
OWN ARM TO GET AWAY WHILE THE
PREDATOR EATS IT. THEIR ARMS
CAN REGENERATE, SO I GUESS
THEY REGROW LATER.

STARFISH CAN EAT ALMOST
ANYTHING IN THE OCEAN. THEY
FEED BY PUSHING THEIR STOMACH
OUT OF THEIR MOUTH AND DIRECTLY
DIGESTING THEIR PREY. FUN FACT,
THERE'S AN AREA IN KUMAMOTO
PREFECTURE WHERE THEY EAT
STARFISH. AS YOU'D EXPECT FROM
A RELATIVE OF THE SEA URCHIN,
YOU STRIP THE SKIN TO EAT THE
INSIDES, LIKE WITH SEA URCHINS.








thanks for playing!
]]

creditheight = #(split(credit_text, "\n")) * 9.5
printh("creditheight : "..creditheight)

function init_credits(self)
    x, y = credits_screen.x, credits_screen.y
    local crd = create(text, credits_screen.x+64, credits_screen.y+120)
    crd.text = credit_text
    crd.txts = split(credit_text, "\n")
    crd.is_centered = false
    crd.selectable = false
    crd.color = 10
    crd:init()
    crd.hit_h = creditheight
    crd.draw = function (self)
        if not is_on_credits then return end
        print_txts(self.txts, self.x, self.y, self.color)
    end

    local bckbtn = create(text, credits_screen.x, credits_screen.y)
    bckbtn.hit_w = 128
    bckbtn.hit_h = 3000
    bckbtn.on_click = function(self)
        if mode != "patched" and not preclick then
            local n = create(notif, 0, 0)
            n.text = "patch needed to scroll faster"
            psfx("error1")
        end
    end
end

function launch_credits()
    last_mspeed = 32
    preclick = btn(❎)
    is_on_credits = true
    set_cam(credits_screen, true)
    pmusic("credits")
end

function update_credits()
    if is_on_credits == true then
        if stat(54) == -1 then pmusic("credits") end
        if not btn(❎) then preclick = false end
        local on_bottom = tcam.y > creditheight + 128 + 12
        if btnp(🅾️) then
            if (not on_bottom) unlock_badge("credit1")
            is_on_credits = false
            music(-1)
            move_to_main_menu(nil, true)
        end
        update_credits_music_speed(on_bottom)
        if on_bottom then
            unlock_badge("credit2")
            return
        end
        local frameskp = (mode == "patched" and btn(❎) and not preclick and 5) or 1
        local credit_speed = (mode == "patched" and btn(❎) and not preclick and 1) or 59
        if gtime % 60 >= credit_speed then
            tcam.y = tcam.y+frameskp
        end
    end
end

function update_credits_music_speed(on_bottom)
    local music_speed = (mode == "patched" and btn(❎) and not preclick and 8) or 64
    music_speed = on_bottom and 32 or music_speed
    if music_speed == last_mspeed then return end
    for i in all(musics["credits"].sfxs) do
        local sfxaddr = 0x3200 + i*68 -- speed byte
        poke(sfxaddr+65, music_speed)
    end
    pmusic("credits")
    last_mspeed = music_speed
end

function print_txts(strs, x, y, col)
    local ymrg = 8
    local i = 0
    for lstr in all(strs) do
        local length = #(lstr) * 2
        print(lstr, x - length, y + i * ymrg, col)
        i = i + 1
    end
end
