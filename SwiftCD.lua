swift = math.floor(Actions.GetActionInfo(7561).RealSpellCooldown)

if swift == 0 then
	yield("/p Swiftcast ready!")
else
	yield("/p Swiftcast ready in "..swift.." seconds!")
end