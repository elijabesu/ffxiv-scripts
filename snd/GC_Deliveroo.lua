functionsToLoad = loadfile(variable_with_the_file_path) --change this to where you save _functions.lua
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