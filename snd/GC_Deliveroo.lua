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

TeleportToGCTown()
yield("/wait 10")

-- walk to gc
if GetPlayerGC() == 1 then
    yield("/li Aftcastle <wait.5>")
    WalkTo(94, 40.5, 74.5)
elseif GetPlayerGC() == 2 then
    WalkTo(-68.5, -0.5, -8.5)
elseif GetPlayerGC() == 3 then
    WalkTo(-142.5, 4, -106.5)
end

-- check seal buff
if not (HasStatus("Seal Sweetener") or HasStatus("Priority Seal Allowance")) then
    -- activate priority seal allowance if in inventory
    if (GetItemCount(14946, false) > 0) then
        yield("/item Priority Seal Allowance <wait.1>")
        yield("/item Priority Seal Allowance <wait.4>")
    end

-- deliveroo
yield("/deliveroo enable")
yield("/wait 1")
while DeliverooIsTurnInRunning() do
    yield("/wait 5")
end