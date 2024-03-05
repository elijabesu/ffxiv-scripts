function WalkTo(x, y, z)
    new_x = math.random((x - 2) * 1000, (x + 2) * 1000) / 1000
    new_z = math.random((z - 2) * 1000, (z + 2) * 1000) / 1000
    PathfindAndMoveTo(new_x, y, new_z, false)
    while (PathIsRunning() or PathfindInProgress()) do
        yield("/wait 0.5")
    end
end

function ZoneTransition()
    repeat 
        yield("/wait 0.5")
    until not IsPlayerAvailable()
    repeat 
        yield("/wait 0.5")
    until IsPlayerAvailable()
end

function WalkToGC()
    if GetPlayerGC() == 1 then
        yield("/li The Aftcastle")
        ZoneTransition()
        WalkTo(94, 40.5, 74.5)
    elseif GetPlayerGC() == 2 then
        WalkTo(-68.5, -0.5, -8.5)
    elseif GetPlayerGC() == 3 then
        WalkTo(-142.5, 4, -106.5)
    end
end

function TargetedInteract(target)
    yield("/target "..target.." <wait.0.5>")
    yield("/pinteract <wait.1>")
end