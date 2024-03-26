-- Meant to be used with Hunt Helper
-- Required plogons: vnavmesh, Teleporter

-- Make sure ALL paths files are in the SND subfolder!!
folder_path = os.getenv("appdata").."\\XIVLauncher\\pluginConfigs\\SomethingNeedDoing\\paths"

expansion = "ew" -- "ew", "shb", or "sb"

data = {
    ew = {
        zone = {957, 958, 956, 959, 960, 961},
        tp = {"Yedlihmad", "Camp Broken Glass", "The Archeion", "Sinus Lacrimarum", "Abode of the Ea", "The Twelve Wonders"},
        ranks = {
            {"Sugriva", "Yilan"},   -- Thavnair
            {"Aegeiros", "Minerva"},    -- Garlemald
            {"Storsie", "Hulder"},  -- Labyrinthos
            {"Mousse Princess", "Lunatender Queen"},    -- Mare
            {"Gurangatch", "Petalodus"},    -- Elpis
            {"Arch-Eta", "Fan Ail"},    -- Ultima Thule
        },
    },
    shb = {
        zone = {813, 814, 815, 816, 817, 818},
        tp = {"Fort Jobb", "Stilltide", "Mord Souq", "Lydha Lran", "Fanow", "The Ondo Cups"},
        ranks = {
            {"Nuckelavee", "Nariphon"},   -- Lakeland
            {"Huracan", "Li'l Murderer"},   -- Kholusia
            {"Maliktender", "Sugaar"},   -- Ahm Ahreng
            {"The Mudman", "O Poorest Pauldia"},   -- Il Mheg
            {"Supay", "Grassman"},   -- Raktika
            {"Rusalka", "Baal"},   -- Tempest
        },
    },
    sb = {
        zone = {612, 620, 621, 613, 614, 622},
        tp = {"Castrum Oriens", "Ala Gannha", "Porta Praetoria", "Onokoro", "Namai", "Reunion"},
        ranks = {
            {"Orcus", "Erle"},   -- Fringes
            {"Vochstein", "Aqrabuamelu"},   -- Peaks
            {"Mahisha", "Luminare"},   -- Lochs
            {"Funa Yurei", "Oni Yumemi"},   -- Ruby Sea
            {"Gajasura", "Angada"},   -- Yanxia
            {"Girimekhala", "Sum"},   -- Azim
        },
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

function IsRankNearby(zoneIndex)
    possibleRanks = data[expansion]["ranks"][zoneIndex]
    return DoesObjectExist(possibleRanks[1]) or DoesObjectExist(possibleRanks[2])
end

if (expansion == "ew" or expansion == "shb" or expansion == "sb") then
    expData = data[expansion]
else
    yield("Wrong expansion.")
    yield("/pcraft stop")
end

for zoneIndex, zoneId in ipairs(expData["zone"]) do
    file = io.open(folder_path.."\\"..zoneId..".txt", "r")
    if file then
        if not IsInZone(zoneId) then
            yield("/tp "..expData["tp"][zoneIndex])
            ZoneTransition()
        end
        ranksInZone = 0
        for line in file:lines() do
            x, y, z = ExtractCoordinates(line)
            FlyTo(x, y, z)
            if IsRankNearby(zoneIndex) then
                ranksInZone = ranksInZone + 1
            end
            if ranksInZone == 2 then break end
        end
        io.close(file)
    else
        print("Unable to open file "..zoneId..".txt")
        yield("/pcraft stop")
    end
end
