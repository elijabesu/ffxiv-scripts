-- Make sure the _functions.lua file is in the SND folder!!
functionsToLoad = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\_functions.lua"
functionsToLoad()

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