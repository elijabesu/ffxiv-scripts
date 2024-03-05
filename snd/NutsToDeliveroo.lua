functionsToLoad = loadfile(variable_with_the_file_path) --change this to where you save _functions.lua
functionsToLoad()

function BuyMoonwardAccessories()
    TargetedInteract("J'lakshai")
    yield("/pcall SelectIconString false 1")
    yield("/wait 1")
    for i, v in ipairs({38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49}) do
        yield(string.format("/pcall ShopExchangeCurrency false 0 %d 1 0", v))
        yield("/wait 0.5")
    end
    yield("/pcall ShopExchangeCurrency true -1")

    yield("/wait 1")

    TargetedInteract("J'lakshai")
    yield("/pcall SelectIconString false 2")
    yield("/wait 1")
    for i, v in ipairs({17, 18, 19, 20, 21, 22, 23, 24}) do
        yield(string.format("/pcall ShopExchangeCurrency false 0 %d 1 0", v))
        yield("/wait 0.5")
    end
    yield("/pcall ShopExchangeCurrency true -1")
end

yield("/tp Old Sharlayan")
ZoneTransition()
yield("/li Scholar's Harbor")
ZoneTransition()
WalkTo(33.5, -15.5, 102.5)
BuyMoonwardAccessories()
yield("/wait 2.5")

-- GC time
TeleportToGCTown()
ZoneTransition()
WalkToGC()

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