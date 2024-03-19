-- Meant to be used with Hunt Helper
-- Required plogons: vnavmesh, Teleporter

-- Make sure ALL paths files are in the SND subfolder!!
folder_path = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\paths"

expansion = "ew" -- "ew", "shb", or "sb"

data = {
    ew = {
        zone = {957, 958, 956, 959, 960, 961},
        tp = {"Yedlihmad", "Camp Broken Glass", "The Archeion", "Sinus Lacrimarum", "Abode of the Ea", "The Twelve Wonders"},
    },
    shb = {
        zone = {813, 814, 815, 816, 817, 818},
        tp = {"Fort Jobb", "Stilltide", "Mord Souq", "Lydha Lran", "Fanow", "The Ondo Cups"},
    },
    sb = {
        zone = {612, 620, 621, 613, 614, 622},
        tp = {"Castrum Oriens", "Ala Gannha", "Porta Praetoria", "Onokoro", "Namai", "Reunion"},
    },
}

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

function WaitForMesh()
    while not NavIsReady() do
        yield("Waiting for navmesh, currently at "..math.floor(NavBuildProgress()*100).."%")
        yield("/wait 1")
    end
end

-- thanks 69 for this uwu
function ExtractCoordinates(line)
    local x, y, z = line:match("(-?%d*%.?%d+),%s*(-?%d*%.?%d+),%s*(-?%d*%.?%d+)")
    return tonumber(x), tonumber(y), tonumber(z)
end

if (expansion == "ew" or expansion == "shb" or expansion == "sb") then
    expData = data[expansion]
else
    yield("Wrong expansion.")
    yield("/pcraft stop")
end

for i, v in ipairs(expData["zone"]) do
    file = io.open(folder_path.."\\"..v..".txt", "r")
    if file then
        if not IsInZone(v) then
            yield("/tp "..expData["tp"][i])
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
