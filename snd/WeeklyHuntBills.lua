-- Grab all weekly hunt marks

functionsToLoad = loadfile(variable_with_the_file_path) --change this to where you save _functions.lua
functionsToLoad()

function GrabHunt(boardName, stringIndex, huntIndex)
    TargetedInteract(boardName.." Board")
    yield(string.format("/pcall SelectString true %d <wait.1>", stringIndex))
    if not huntIndex then
        yield("/pcall Mobhunt true 0 <wait.1>")
    else
        yield(string.format("/pcall Mobhunt%d true 0 <wait.1>", huntIndex))
    end
end

-- ARR
TeleportToGCTown()
ZoneTransition()
yield("/wait 10")
if GetPlayerGC() == 1 then
    yield("/li The Aftcastle")
    ZoneTransition()
    WalkTo(94, 40, 61)
elseif GetPlayerGC() == 2 then
    WalkTo(-77, -0.5, 2)
elseif GetPlayerGC() == 3 then
    WalkTo(-151.5, 4, -93)
end
GrabHunt("Hunt", 1)

-- HW
yield("/tp Foundation")
ZoneTransition()
yield("/li The Forgotten Knight")
ZoneTransition()
WalkTo(74, 24, 21)
GrabHunt("Clan Hunt", 3, 2)

-- SB
yield("/tp Kugane")
ZoneTransition()
WalkTo(-30.5, 0, -43.5)
GrabHunt("Clan Hunt", 3, 3)

-- ShB
yield("/tp The Crystarium")
ZoneTransition()
WalkTo(-85, 0, -90.5)
GrabHunt("Nuts", 3, 4)

-- EW
yield("/tp Radz-at-Han")
ZoneTransition()
yield("/li Mehryde's Meyhane")
ZoneTransition()
WalkTo(-36, 1.5, -193)
GrabHunt("Guildship Hunt", 3, 5)