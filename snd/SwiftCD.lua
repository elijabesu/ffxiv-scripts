swift = math.floor(GetSpellCooldown(7561))

if swift == 0 then
   yield("/p Swiftcast ready!")
else
   yield(string.format("/p Swiftcast ready in %d seconds!", swift))
end