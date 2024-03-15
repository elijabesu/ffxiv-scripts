-- Make sure the _functions.lua file is in the SND folder!!
functionsToLoad = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\_functions.lua"
functionsToLoad()

TargetedInteract("Hunt Billmaster")
yield("/wait 1")
yield("/pcall SelectIconString true 4")
yield("/wait 1")

seals = tonumber(GetNodeText("ShopExchangeCurrency", 18))
tickets = seals / 5
if tickets >= 1 then
    tickets = math.floor(tickets)
    while tickets > 0 do
        if tickets > 99 then
            toBuy = 99
        else
            toBuy = tickets
        end
        yield("/pcall ShopExchangeCurrency false 0 1 "..toBuy)
        yield("/wait 0.5")
        if IsAddonVisible("SelectYesno") then
            yield("/pcall SelectYesno true 0")
        end
        tickets = tickets - toBuy
    end
end
yield("/pcall ShopExchangeCurrency true -1")