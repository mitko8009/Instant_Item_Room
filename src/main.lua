IIR = RegisterMod("Instant Item Rooms", 1);
local mod = IIR;
IIR.MOD_NAME = "Instant Item Rooms"
IIR.VERSION = "1.4"
IIR.AUTHOR = "mitko8009"
IIR.SOCIAL = "@mitko8009_"


local json = require("json");

STARTING_ROOMS = {"None", "Treasure", "Shop", "Secret", "Super Secret", "Boss", "Miniboss", "Sacrifice", "Curse", "Planetarium"}

settings_IIR = { 
	starting_room = "Treasure",
    teleport_every_floor = false,
}

local roomTypes = {
    ["Treasure"] = RoomType.ROOM_TREASURE,
    ["Shop"] = RoomType.ROOM_SHOP,
    ["Secret"] = RoomType.ROOM_SECRET,
    ["Super Secret"] = RoomType.ROOM_SUPERSECRET,
    ["Boss"] = RoomType.ROOM_BOSS,
    ["Miniboss"] = RoomType.ROOM_MINIBOSS,
    ["Sacrifice"] = RoomType.ROOM_SACRIFICE,
    ["Curse"] = RoomType.ROOM_CURSE,
    ["Planetarium"] = RoomType.ROOM_PLANETARIUM,
}

local function save()
    Isaac.SaveModData(mod, json.encode(settings_IIR, "settings"))
end

local function init()
    if Isaac.HasModData(mod) then
        local data = Isaac.LoadModData(mod)
        data = json.decode(data)
        for k,v in pairs(data) do settings_IIR[k] = v end
        settings_IIR.version = IIR.VERSION
    end

    if not Isaac.HasModData(mod) then
        save()
    end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_END, save)
mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, save)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, init)

function TeleportToRoom(RoomType)
    local level = Game():GetLevel()

    local targetIdx = -1
    for i = 0, 169 do -- Iterate through all possible room indices (0-169) to find the first matching room type
        local roomDesc = level:GetRoomByIdx(i)

        if roomDesc and roomDesc.Data and roomDesc.Data.Type == RoomType then
            if roomDesc.GridIndex ~= -1 then
                targetIdx = i
                break
            end
        end
    end

    if targetIdx ~= -1 then
        Isaac.GetPlayer(0):AnimateTeleport()

        Game():ChangeRoom(targetIdx)
    else
        print("IIR: No item room found to teleport to.")
    end
end

if ModConfigMenu then -- Check if Mod Config Menu is available before requiring it
    require("scripts.mcm");
end

function mod:onLevelStart()
    local startingRoom = settings_IIR.starting_room or "Treasure"
    local roomType = roomTypes[startingRoom] or RoomType.ROOM_TREASURE
    if (
        (startingRoom ~= "None") and
        (Game():IsGreedMode() == false) and
        (settings_IIR.teleport_every_floor == true or Game():GetLevel():GetStage() == 1)
    ) then
        TeleportToRoom(roomType)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.onLevelStart)
