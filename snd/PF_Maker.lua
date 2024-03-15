-- Make a PF with a comment
comment = "S rank" -- edit this for f.e. "EW train"

function WaitForAddon(addonName)
    if not IsAddonVisible(addonName) then
        yield("/wait 0.5")
    end
end

yield("/partyfinder") -- open PF
WaitForAddon("LookingForGroup")
yield("/pcall LookingForGroup true 14") -- Recruit Members
WaitForAddon("LookingForGroupCondition")
yield("/pcall LookingForGroupCondition true 30") -- Reset
WaitForAddon(SelectYesno)
yield("/pcall SelectYesno true 0")
yield("/pcall LookingForGroupCondition true 12 11u 0") -- The Hunt
yield("/pcall LookingForGroupCondition true 15 \""..comment.."\"") -- comment
yield("/pcall LookingForGroupCondition true 0 \""..comment.."\"") -- Recruit Members
yield("/partyfinder") -- close PF