-- Make sure ALL paths files are in the SND subfolder!!
folder_path = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\paths"

expansion = "shb" -- "shb" only for now

shb_zones = {813, 814, 815, 816, 817, 818}
shb_teleports = {"Fort Jobb", "Stilltide", "Mord Souq", "Lydha Lran", "Fanow", "The Ondo Cups"}

ew_zones = {} -- TODO
ew_teleports = {"Yedlihmad", "Camp Broken Glass", "The Archeion", "Sinus Lacrimarum", "Abode of the Ea", "The Twelve Wonders"}

function FlyTo(x, y, z)
    if GetCharacterCondition(4, false) then
        yield('/gaction "Mount Roulette" <wait.5>')
    end
    if GetCharacterCondition(77, false) then 
        yield("/gaction Jump <wait.0.5>")
        yield("/gaction Jump")
    end
    PathfindAndMoveTo(x, y, z, true)
    while (PathIsRunning() or PathfindInProgress()) do
        yield("/wait 0.5")
    end
end

function ZoneTransition()
    repeat yield("/wait 0.5")
    until not IsPlayerAvailable()
    repeat yield("/wait 0.5")
    until IsPlayerAvailable()
end

-- thank 69 for this uwu
function ExtractCoordinates(line)
    local x, y, z = line:match("(-?%d*%.?%d+),%s*(-?%d*%.?%d+),%s*(-?%d*%.?%d+)")
    return tonumber(x), tonumber(y), tonumber(z)
end

if expansion == "shb" then
    zones = shb_zones
    teleports = shb_teleports
elseif expansion == "ew" then
    yield("Not yet supported.")
    yield("/pcraft stop")
else
    yield("Wrong expansion.")
    yield("/pcraft stop")
end

for i, v in ipairs(zones) do
    file = io.open(folder_path.."\\"..v..".txt", "r")
    if file then
        if not IsInZone(v) then
            yield("/tp "..teleports[i])
            ZoneTransition()
        end
        for line in file:lines() do
            x, y, z = ExtractCoordinates(line)
            FlyTo(x, y, z)
        end
        io.close(file)
    else
        print("Unable to open file "..v..".txt")
        yield("/pcraft stop")
    end
end
