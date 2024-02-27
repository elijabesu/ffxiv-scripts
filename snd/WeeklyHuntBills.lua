-- Grab all weekly hunt marks

function GrabHunt(boardName, stringIndex, huntIndex)
    yield(string.format("/target %s Board <wait.0.5>", boardName))
    yield("/pinteract <wait.1>")
    yield(string.format("/pcall SelectString true %d <wait.1>", stringIndex))
    if not huntIndex then
        yield("/pcall Mobhunt true 0 <wait.1>")
    else
        yield(string.format("/pcall Mobhunt%d true 0 <wait.1>", huntIndex))
    end
end

function WalkTo(x, y, z)
    PathMoveTo(x, y, z)
    while PathIsRunning() do
        yield("/wait 1")
    end
end

-- check for navmesh
if not NavIsReady() then
    yield("Navmesh not ready!")
    yield("/pcraft stop")
end

-- ARR
TeleportToGCTown()
yield("/wait 10")
if GetPlayerGC() == 1 then
    yield("/li Aftcastle <wait.5>")
    WalkTo(94, 40, 61)
elseif GetPlayerGC() == 2 then
    WalkTo(-77, -0.5, 2)
elseif GetPlayerGC() == 3 then
    WalkTo(-151.5, 4, -93)
end
GrabHunt("Hunt", 1)

-- HW
yield("/tp Foundation <wait.10>")
yield("/li The Forgotten Knight <wait.5>")
WalkTo(74, 24, 21)
GrabHunt("Clan Hunt", 3, 2)

-- SB
yield("/tp Kugane <wait.10>")
WalkTo(-30.5, 0, -43.5)
GrabHunt("Clan Hunt", 3, 3)

-- ShB
yield("/tp The Crystarium <wait.10>")
WalkTo(-85, 0, -90.5)
GrabHunt("Nuts", 3, 4)

-- EW
yield("/tp Radz-at-Han <wait.10>")
yield("/li Mehryde's Meyhane <wait.5>")
WalkTo(-36, 1.5, -193)
GrabHunt("Guildship Hunt", 3, 5)