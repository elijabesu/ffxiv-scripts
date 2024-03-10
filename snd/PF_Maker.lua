-- Make a PF with one word comment
comment = "S" -- edit this for f.e. "train"

function WaitForAddon(addonName)
    if not IsAddonVisible(addonName) then
        yield("/wait 0.5")
    end
end

yield("/maincommand 57") -- open PF
WaitForAddon("LookingForGroup")
yield("/pcall LookingForGroup true 14") -- Recruit Members
WaitForAddon("LookingForGroupCondition")
yield("/pcall LookingForGroupCondition true 30") -- Reset
WaitForAddon(SelectYesno)
yield("/pcall SelectYesno true 0")
yield("/pcall LookingForGroupCondition true 12 11u 0") -- The Hunt

yield("/pcall LookingForGroupCondition true 15 "..comment.." 0") -- comment S 
yield("/pcall LookingForGroupCondition true 0 "..comment.." 0") -- Recruit Members