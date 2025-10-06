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















ANYWAY, ANYONE ELSE HYPED BY
THE WOW HOUSING FEATURE?
I CAN'T WAIT TO PLAY A WORSE
VERSION OF THE SIMS
IN MY FAVORITE MMO











STILL THERE?
WAIT,
I MUST HAVE SOMETHING MORE







here goes:

sea anemones are relatives of the jellyfish. they have these tiny hairs growing on them that they use to feed by stunning fish, shrimp, zooplankton, and so on.

but they can survive for years without food. they're like jellyfish in that way. there are even sea anemones that have lived longer than 70 years with the proper care.

they're found all throughout the world's oceans, and they can slowly move too. there are also fish that live inside them called anemonefish. the sea anemones protect them from predators and share their food scraps.

in tropical waters, sea anemones latch on to coral reefs or rocks.

starfish are echinoderms and relatives of the sea urchin. there are as many as 2,000 starfish species around the world. not all of them are star-shaped either. there's even a species with 30 arms.

when they get attacked by a predator, they'll rip off their own arm to get away while the predator eats it. their arms can regenerate, so I guess they regrow later.

starfish can eat almost anything in the ocean. they feed by pushing their stomach out of their mouth and directly digesting their prey. fun fact, there's an area in Kumamoto Prefecture where they eat starfish. As you'd expect from a relative of the sea urchin, you strip the skin to eat the insides, like with sea urchins.







thanks for playing!
]]

creditheight = #(split(credit_text, "\n")) * 10

function make_credits_appear(self)
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
