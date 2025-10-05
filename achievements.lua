all_achievements = {
    {code = "intro1", name = "\^t\^wa warm welcome", description = "you launched the game.", tip = ""},
    {code = "intro2", name = "\^t\^wfirst step", description = "you got your first//achievement.", tip = ""},
    {code = "intro3", name = "\^t\^wwow!!", description = "you got your second//achievement.", tip = ""},
    {code = "start1", name = "\^t\^wyou are not//\^t\^wprepared", description = "try to//launch the game.", tip = "did you try to launch the game ?"},
    {code = "badge", name = "\^t\^wgreat success", description = "open the achievement page", tip = "why are you here? if you can read this, you've done it"},
    {code = "soundp", name = "\^t\^whello there", description = "lower the general sound", tip = "check the sound options."},
    {code = "soundm", name = "\^t\^wkenobi", description = "up the general sound", tip = "check the sound options, again."},
    {code = "time1", name = "\^t\^wblackest night", description = "no evil shall escape my sight, don't cheat.", tip = "set the time of the game to midnight." },
    {code = "time2", name = "\^t\^wthe dark knight", description = "go back in time to the release of the best batman movie", tip = "set the year to when that movie came out"},
    {code = "test1", name = "\^t\^wcan i play, daddy?", description = "it's part of the process", tip = "why are you reading this?"},
    {code = "test2", name = "\^t\^wrespect", description = "as you can see, we are very skilled", tip = "look at the credits until the end."},
    {code = "test3", name = "\^t\^wdisrespect", description ="i'm disappointed in you", tip = "quit the credits before the end." },
    {code = "test4", name = "\^t\^wconnected", description ="stay up to date", tip = "enable patch-notes."},
    {code = "test5", name = "\^t\^wquick fix", description ="the credit speed is fixed!", tip = "read the patch-note."},
    {code = "test6", name ="\^t\^wsad noises", description ="you just made our sound designer sad", tip = "disable the musics."},
    {code = "test7", name ="\^t\^wthe end is never the end", description = "wow, you did it!", tip ="launch the game."},
    {code = "test8", name ="\^t\^wkick the bucket", description ="are you proud of yourself?", tip = "it's literal, try the foot mode." },
    {code = "test9", name ="\^t\^ware you lying to me?", description = "è_é", tip = "the the hour to something impossible."},
    {code = "blind", name ="\^t\^wsecret mission", description = "you successfully prevented//the heist using//the 8 baboons", tip = ""},
    --{code = "", name ="", description = "", tip = ""},
}

function unlock_badge(code)
    local badge = all_achievements_index[code]
    if badge.unlocked == true then return end
    badge.unlocked = true
    local index = find_item_table_index(badge, all_achievements)
    dset(index, 1)
    badge_count += 1
    add(incoming_popups, badge)
    --
    check_badges()
end

function check_badges()
    if badge_count >= 20 then
        mode_list["play"].locked = false
    end
end

function index_achievements()
    all_achievements_index = {}
    for a in all(all_achievements) do
        all_achievements_index[a.code] = a
    end
end

index_achievements()