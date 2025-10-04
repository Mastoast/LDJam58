all_achievements = {
    {code = "intro1", name = "a warm welcome", description = "you launched the game.", tip = ""},
    {code = "intro2", name = "first step", description = "you got your first achievement.", tip = ""},
    {code = "intro3", name = "wow!!", description = "you got your second achievement.", tip = ""},
    {code = "start1", name = "you are not prepared", description = "try to launch the game.", tip = "did you try to launch the game ?"},
    {code = "badge", name = "great success", description = "open the achievement page", tip = "why are you here? if you can read this, you've done it"},
    {code = "soundp", name = "hello there", description = "lower the general sound", tip = "check the sound options."},
    {code = "soundm", name = "kenobi", description = "up the general sound", tip = "check the sound options, again."},
    {code = "time1", name = "blackest night", description = "no evil shall escape my sight, don't cheat.", tip = "set the time of the game to midnight." },
    {code = "time2", name = "the dark knight", description = "go back in time to the release of the best batman movie", tip = "set the year to when that movie came out"},
    {code = "test1", name = "can i play, daddy?", description = "it's part of the process", tip = "why are you reading this?"},
    {code = "test2", name = "respect", description = "as you can see, we are very skilled", tip = "look at the credits until the end."},
    {code = "test3", name = "disrespect", description ="i'm disappointed in you", tip = "quit the credits before the end." },
    {code = "test4", name = "connected", description ="stay up to date", tip = "enable patch-notes."},
    {code = "test5", name = "quick fix", description ="the credit speed is fixed!", tip = "read the patch-note."},
    {code = "test6", name ="sad noises", description ="you just made our sound designer sad", tip = "disable the musics."},
    {code = "test7", name ="the end is never the end", description = "wow, you did it!", tip ="launch the game."},
    {code = "test8", name ="kick the bucket", description ="are you proud of yourself?", tip = "it's literal, try the foot mode." },
    {code = "test9", name ="are you lying to me?", description = "è_é", tip = "the the hour to something impossible."},
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
end

function index_achievements()
    all_achievements_index = {}
    for a in all(all_achievements) do
        all_achievements_index[a.code] = a
    end
end

index_achievements()