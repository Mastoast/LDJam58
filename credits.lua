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

creditheight = #(split(credit_text, "\n")) * 9.2

function make_credits_appear(self)
    x, y = credits_screen.x, credits_screen.y
    local play = create(text, credits_screen.x+64, credits_screen.y+120)
    play.text = credit_text
    play.is_centered = false
    play.selectable = false
    play.color = 10
    play:init()
    play.draw = function (self)
        print_mltxt(self.text, self.x, self.y, self.color)
    end

    --printh(credit_text)
    --printh(play.color)
    local bckbtn = create(text, credits_screen.x, credits_screen.y)
    bckbtn.hit_w = 128
    bckbtn.hit_h = 3000
    bckbtn.on_click = function(self)
        if mode != "patched" then
            local n = create(notif, 0, 0)
            n.text = "patch needed to scroll faster"
            psfx("error1")
        end
    end
    bckbtn.on_right_click = function(self)
        unlock_badge("credit1")
        is_on_credits = false
        move_to_main_menu()
    end
end

function credit_update()
    if is_on_credits == true then
        if cam.y > creditheight + 128 + 32 then
            unlock_badge("credit2")
            return
        end
        local frameskp = (mode == "patched" and btn(❎) and 5) or 1
        local credit_speed = (mode == "patched" and btn(❎) and 1) or 59
        if gtime % 60 >= credit_speed then
            tcam.y = tcam.y+frameskp
        end
    end
end

function print_mltxt(str, x, y, col)
    -- print(str, x, y, col)
    local ymrg = 8
    local strs = split(str, "\n")
    local i = 0
    for lstr in all(strs) do
        local length = #(lstr) * 2
        print(lstr, x - length, y + i * ymrg, col)
        i = i + 1
    end
end
