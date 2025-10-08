all_achievements = {
    {code = "intro1", name = "\^t\^wa warm welcome", description = "you launched the game", tip = ""},
    {code = "intro2", name = "\^t\^wfirst step", description = "you got your first//achievement", tip = ""},
    {code = "intro3", name = "\^t\^wwow!!", description = "you got your second//achievement", tip = ""},
    {code = "start1", name = "\^t\^wyou are not//\^t\^wprepared", description = "try to//launch the game", tip = "did you try to//launch the game ?"},
    {code = "badge", name = "\^t\^wgreat success", description = "open the achievement page", tip = "why are you here? if you//can read this, you've done it"},
    {code = "birthday", name ="\^t\^wbirthday!", description = "it's your birthday//happy birthday!", tip = "don't forget//to set up//your birthday date!"},
    {code = "birthday_today", name ="\^t\^wyou're born//\^t\^wtoday?!", description = "you look suspiciously//old for your age", tip = "check the year."},
    {code = "merry_christmas", name ="\^t\^wmerry christmas!", description = "only coal for you!", tip = "have you been good this year?"},
    {code = "marty_mcfly", name ="\^t\^w1.21 gigawatts", description = "what the hell//is a gigawatt?", tip = "ask marty."},
    {code = "soundp", name = "\^t\^whello there", description = "lower the general sound", tip = "check the sound options."},
    {code = "soundm", name = "\^t\^wkenobi", description = "up the general sound", tip = "check the sound options,//again."},
    {code = "star_wars", name ="\^t\^wbe with you", description = "I like the phantom menace", tip = "don't sue us disney//please"},
    --{code = "time1", name = "\^t\^wblackest night", description = "no evil shall escape my sight, don't cheat.", tip = "set the time of the//game to midnight." },
    --{code = "time2", name = "\^t\^wthe dark knight", description = "go back in time to the release of the best batman movie", tip = "set the year to when//that movie came out"},
    --{code = "test1", name = "\^t\^wcan i play, daddy?", description = "it's part of the process", tip = "why are you reading this?"},
    {code = "credit1", name = "\^t\^wdon't finish//\^t\^wthe credits", description =":(", tip = "quit the credits//before the end." },
    {code = "credit2", name = "\^t\^wfinish the//\^t\^wcredits", description = ":)", tip = "look at the credits//until the end."},
    {code = "terminator_two", name ="\^t\^wthe judgement//\^t\^wday", description = "hasta la vista baby", tip = "he said he would be back."},
    {code = "connected", name = "\^t\^wconnected", description ="stay up to date", tip = "enable day 1 patch mode."},
    {code = "sad_hector", name ="\^t\^wsad noises", description ="you just made our//sound designer sad", tip = "disable the musics."},
    {code = "konami", name ="\^t\^wkonami code", description = "such an og!", tip = "ask someone old"},
    {code = "do_you_remember", name ="\^t\^wdo you remember?", description = "1978, what a year...", tip = "three quarters of the Avatar//you're just missing water.", msc="september",btn_time=237},
    {code = "kick_the_bucket", name ="\^t\^wkick the bucket", description ="are you proud of yourself?", tip = "it's literal, try the boot mode." },
    --{code = "test9", name ="\^t\^ware you//\^t\^wlying to me?", description = "è_é", tip = "set the month to//something impossible."},
    {code = "blind", name ="\^t\^wsecret mission", description = "you successfully//prevented the heist using//the 8 baboons", tip = "close your eyes,//the solution will come to you"},
    {code = "groundhog_day", name ="\^t\^wtimelooping //\^t\^wwoodchuck", description = "you got out of the loop!", tip = "i'm a god."},
    {code = "paid_attention", name ="\^t\^wpaid attention", description = "we know you read the credits//here is your reward", tip = "did you pay attention?"},
    {code = "parks_and_rec", name ="\^t\^wtreat yo' self //\^t\^wday", description = "i'll take a greasy //lard bomb please!", tip = "i heard pawnee was great //at this time of the year."},
    {code = "die_hard", name ="\^t\^who ho ho,//\^t\^wnow i have//\^t\^wa machine gun", description = "it really is a christmas movie!", tip = "welcome to the party pal!"},
    {code = "tree", name ="\^t\^wwork work", description = "me not that//kind of orc!", tip = "cut the tree."},
    {code = "perfect_murder", name ="\^t\^wperfect murder", description = "nooooo!", tip = "no witnesses//don't forget your shoes."},
    {code = "launchgame", name ="\^t\^wthe end is//\^t\^wnever the end", description = "wow, you did it!", tip ="launch the game."},
    {code = "finish_the_game", name ="\^t\^wfinish the game", description = "you're so good at this!", tip = "it's easy, just try."},
    {code = "our_code", name ="\^t\^wfind the secret//\^t\^wcode", description = "you definitely aren't//a yu-gi-oh player", tip = "did you read the instructions?"},
     --{code = "", name ="", description = "", tip = ""},
}

function unlock_badge(code)
    local badge = all_achievements_index[code]
    if badge == nil then printh("NO BADGE: "..code) return end
    if badge.unlocked == true then return end
    badge.unlocked = true
    local index = find_item_table_index(badge, all_achievements)
    dset(index, 1)
    badge_count += 1
    popup_last_input = gtime
    add(incoming_popups, badge)
    --
    check_badges()
end

function check_badges()
    if badge_count >= 20 then
        mode_list["play"].locked = false
    end
end

function on_konamicd()
    unlock_badge("konami")
end

function on_ourcode()
    unlock_badge("our_code")
end

input_codes = {
    {i=1,code={⬆️,⬆️,⬇️,⬇️,⬅️,➡️,⬅️,➡️,🅾️,❎},callback=on_konamicd },
    {i=1,code={⬅️,⬅️,⬅️,⬆️,⬆️,⬆️,🅾️,🅾️,🅾️,🅾️},callback=on_ourcode }
}

function update_inputs()
    for input in all(input_codes) do
        if btnp(input.code[input.i]) then
            input.i += 1
            if input.i > #input.code then
                input.callback()
                input.i = 1
            end
        elseif btnp(⬆️) or btnp(⬇️) or btnp(⬅️) or btnp(➡️) or btnp(🅾️) or btnp(❎) then
            input.i = 1
        end
    end
end

function index_achievements()
    all_achievements_index = {}
    for a in all(all_achievements) do
        all_achievements_index[a.code] = a
    end
end

index_achievements()