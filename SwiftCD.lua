--[=====[
[[SND Metadata]]
author: elijabesu
version: 2.0.0
description: Just a simple swiftcast macro without the annoying --:--.

[[End Metadata]]
--]=====]

--[[
********************************************************************************
*            Code: Don't touch this unless you know what you're doing          *
********************************************************************************
--]]
local swift = math.floor(Actions.GetActionInfo(7561).RealSpellCooldown)

if swift == 0 then yield("/p Swiftcast ready!")
else yield("/p Swiftcast ready in "..swift.." seconds!")
end