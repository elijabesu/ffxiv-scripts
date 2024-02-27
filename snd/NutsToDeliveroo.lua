function NutInteract()
    yield("/target J'lakshai <wait.0.5>")
    yield("/pinteract <wait.1>")
end

function BuyMoonwardAccessories()
    NutInteract()
    yield("/pcall SelectIconString false 1")
    yield("/wait 1")
    for i, v in ipairs({38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49}) do
        yield(string.format("/pcall ShopExchangeCurrency false 0 %d 1 0", v))
        yield("/wait 0.5")
    end
    yield("/pcall ShopExchangeCurrency true -1")

    yield("/wait 1")

    NutInteract()
    yield("/pcall SelectIconString false 2")
    yield("/wait 1")
    for i, v in ipairs({17, 18, 19, 20, 21, 22, 23, 24}) do
        yield(string.format("/pcall ShopExchangeCurrency false 0 %d 1 0", v))
        yield("/wait 0.5")
    end
    yield("/pcall ShopExchangeCurrency true -1")
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

yield("/tp Old Sharlayan <wait.10>")
yield("/li Scholar's Harbor <wait.5>")
WalkTo(33.5, -15.5, 102.5)
BuyMoonwardAccessories()
yield("/wait 5")

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
end

-- deliveroo
yield("/deliveroo enable")
yield("/wait 1")
while DeliverooIsTurnInRunning() do
    yield("/wait 5")
end