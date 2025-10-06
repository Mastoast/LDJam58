credit_text =[[credits




responsible for 90% of the code that works
mastoast

writer Who thought meta humor was still cool
pandalk

chief "annoying jingle" operator
mastoast

The one who drew that tree you can cut
pandalk

the person who thought 900 grams of m&m's was enough for the week-end
pandalk

chief of “add it to the list” department
mastoast

chief officer of “just one more feature”
pandalk

the person you can blame for everything
mastoast

the person who forgot to push their code
pandalk

that one developer who said “it works on my machine”
mastoast

[redacted for spoilers]
pandalk

probably asleep right now
mastoast

director of Unintended features
Pandalk

the guy who thought this was funny
pandalk


special thanks:

satoshi kon 
richard garfield
the disco elysium team
the greater good
my cat fleya
bob. merci bob
and you who is definitely reading this right now!















anyway, anyone else hyped by the WoW housing feature? i can't wait to play a worse version of the sims in my favorite mmo.











still there? wait, I must have something more.







here goes:

sea anemones are relatives of the jellyfish. they have these tiny hairs growing on them that they use to feed by stunning fish, shrimp, zooplankton, and so on.

but they can survive for years without food. they're like jellyfish in that way. there are even sea anemones that have lived longer than 70 years with the proper care.

they're found all throughout the world's oceans, and they can slowly move too. there are also fish that live inside them called anemonefish. the sea anemones protect them from predators and share their food scraps.

in tropical waters, sea anemones latch on to coral reefs or rocks.

starfish are echinoderms and relatives of the sea urchin. there are as many as 2,000 starfish species around the world. not all of them are star-shaped either. there's even a species with 30 arms.

when they get attacked by a predator, they'll rip off their own arm to get away while the predator eats it. their arms can regenerate, so I guess they regrow later.

starfish can eat almost anything in the ocean. they feed by pushing their stomach out of their mouth and directly digesting their prey. fun fact, there's an area in Kumamoto Prefecture where they eat starfish. As you'd expect from a relative of the sea urchin, you strip the skin to eat the insides, like with sea urchins.

]]

-- TODO center lines
-- TODO stop on max scroll
-- TODO success on max scroll
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
        is_on_credits = false
        move_to_main_menu()
    end
end

function credit_update()
    if is_on_credits == true then
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
    for i=0, #strs-1 do
        local lstr = "\^$" .. strs[i+1]
        local length = #(lstr) * 2
        print(lstr, x - length, y + i * ymrg, col)
    end
end
