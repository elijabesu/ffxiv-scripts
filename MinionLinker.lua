--[=====[
[[SND Metadata]]
author: elijabesu
version: 1.0.0
description: Sends out macros with map links to SS minions upon detecting event. Works in ShB, EW, and DT zones.

configs:
  Channel:
    description: Which text channel to use (echo = only visible to you, shout = entire instance, yell = area around you).
    is_choice: true
    choices: ["/echo", "/shout", "/yell"]

[[End Metadata]]
--]=====]

--[[
********************************************************************************
*            Code: Don't touch this unless you know what you're doing          *
********************************************************************************
--]]

local MinionsTable = {
    ["813"] = {                    --Lakeland
        {x = 33.0, y = 12.0},
        {x = 29.9, y = 36.1},
        {x = 11.1, y = 24.9},
        {x = 12.4, y = 10.5}
    },
    ["814"] = {                    --Kholusia
        {x = 12.2, y = 15.1},
        {x = 24.0, y = 15.3},
        {x = 8.8, y = 28.9},
        {x = 33.8, y = 32.4}
    },
    ["815"] = {                    --Amh Araeng
        {x = 30.4, y = 9.8},
        {x = 30.1, y = 24.7},
        {x = 14.1, y = 31.9},
        {x = 13.6, y = 11.8}
    },
    ["816"] = {                    --Il Mheg
        {x = 5.7, y = 29.6},
        {x = 23.5, y = 35.6},
        {x = 25.0, y = 22.1},
        {x = 32.1, y = 11.2}
    },
    ["817"] = {                    --The Rak'tika Greatwood
        {x = 29.8, y = 13.0},
        {x = 18.9, y = 22.3},
        {x = 7.4, y = 22.8},
        {x = 14.5, y = 36.6}
    },
    ["818"] = {                    --The Tempest
        {x = 8.4, y = 7.2},
        {x = 25.8, y = 9.6},
        {x = 37.7, y = 14.0},
        {x = 33.6, y = 29.9}
    },
    ["956"] = {                    --Labyrinthos
        {x = 25.1, y = 8.5},
        {x = 35.0, y = 17.9},
        {x = 26.3, y = 32.8},
        {x = 9.3, y = 22.1}
    },
    ["957"] = {                    --Thavnair
        {x = 22.9, y = 10.4},
        {x = 12.1, y = 16.3},
        {x = 33.2, y = 25.0},
        {x = 16.5, y = 29.4}
    },
    ["958"] = {                    --Garlemald
        {x = 17.8, y = 10.0},
        {x = 32.1, y = 9.0},
        {x = 33.4, y = 28.7},
        {x = 22.5, y = 32.6}
    },
    ["959"] = {                    --Mare Lamentorum
        {x = 11.9, y = 20.6},
        {x = 33.0, y = 23.4},
        {x = 11.7, y = 35.9},
        {x = 29.2, y = 35.4}
    },
    ["961"] = {                    --Elpis
        {x = 16.8, y = 7.0},
        {x = 29.0, y = 7.3},
        {x = 37.7, y = 13.4},
        {x = 7.9, y = 35.8}
    },
    ["960"] = {                    --Ultima Thule
        {x = 32.2, y = 10.0},
        {x = 16.1, y = 16.8},
        {x = 10.7, y = 31.6},
        {x = 23.4, y = 33.1}
    },
    ["1187"] = {                    --Urqopacha
        {x = 25.7, y = 13.9},
        {x = 18.3, y = 17.9},
        {x = 15.6, y = 28.5},
        {x = 34.6, y = 28.2}
    },
    ["1188"] = {                    --Kozama'uka
        {x = 16.7, y = 7.5},
        {x = 33.1, y = 8.2},
        {x = 29.6, y = 24.6},
        {x = 15.8, y = 32.7}
    },
    ["1189"] = {                    --Yak T'el
        {x = 17.1, y = 14.0},
        {x = 35.4, y = 22.4},
        {x = 27.9, y = 24.7},
        {x = 12.7, y = 35.7}
    },
    ["1190"] = {                    --Shaaloani
        {x = 11.5, y = 8.4},
        {x = 23.3, y = 13.3},
        {x = 14.9, y = 30.9},
        {x = 34.3, y = 31.6}
    },
    ["1191"] = {                    --Heritage Found
        {x = 30.1, y = 9.7},
        {x = 14.1, y = 17.8},
        {x = 32.3, y = 22.7},
        {x = 15.0, y = 34.7}
    },
    ["1192"] = {                    --Living Memory
        {x = 27.3, y = 7.1},
        {x = 11.5, y = 18.1},
        {x = 19.7, y = 30.7},
        {x = 28.5, y = 36.5}
    }
}

local function ConvertMapCoordToWorldCoord(mapCoord, scale, offset)
    local scaleOffset = 2048 / scale
    local offsetAdjustment = 0.02 * offset
    return (mapCoord - 1.0 - scaleOffset - offsetAdjustment) * 50.0
end

local function ConvertMapCoordsToWorldCoords(mapCoords, mapRow)
    local worldX = ConvertMapCoordToWorldCoord(mapCoords.x, mapRow.SizeFactor, mapRow.OffsetX)
    local worldY = ConvertMapCoordToWorldCoord(mapCoords.y, mapRow.SizeFactor, mapRow.OffsetY)
    return {x = worldX, y = worldY}
end

local zoneId = Svc.ClientState.TerritoryType
local zoneFlags = MinionsTable[tostring(zoneId)]

if zoneFlags then
    local mapRow = Excel.GetRow("TerritoryType", zoneId):GetProperty("Map")

    local channelToUse = Config.Get("Channel")

    yield(channelToUse.."  MINIONS!!  Stay in your party! ")
    yield("/wait 2")
    yield(channelToUse.."  Do not engage the minions alone and do not let them reset!")
    yield("/wait 2")

    -- flag 1
    local flag = ConvertMapCoordsToWorldCoords(MinionsTable[tostring(zoneId)][1], mapRow)
    Instances.Map.Flag:SetFlagMapMarker(zoneId, flag.x, flag.y)
    yield(channelToUse.."  minion  <flag>")
    yield("/wait 2")

    -- flag 2
    local flag = ConvertMapCoordsToWorldCoords(MinionsTable[tostring(zoneId)][2], mapRow)
    Instances.Map.Flag:SetFlagMapMarker(zoneId, flag.x, flag.y)
    yield(channelToUse.."  minion  <flag>")
    yield("/wait 2")

-- flag 3
    local flag = ConvertMapCoordsToWorldCoords(MinionsTable[tostring(zoneId)][3], mapRow)
    Instances.Map.Flag:SetFlagMapMarker(zoneId, flag.x, flag.y)
    yield(channelToUse.."  minion  <flag>")
    yield("/wait 2")

    -- flag 4
    local flag = ConvertMapCoordsToWorldCoords(MinionsTable[tostring(zoneId)][4], mapRow)
    Instances.Map.Flag:SetFlagMapMarker(zoneId, flag.x, flag.y)
    yield(channelToUse.."  minion  <flag>")
else
    yield("/echo Wrong zone, bud.")
end