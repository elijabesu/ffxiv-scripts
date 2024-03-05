swift = math.floor(GetSpellCooldown(7561))

if swift == 0 then
   yield("/p Swiftcast ready!")
else
   yield("/p Swiftcast ready in "..swift.." seconds!")
end