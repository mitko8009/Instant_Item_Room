IIR = RegisterMod("Instant Item Rooms", 1);
local mod = IIR;
IIR.MOD_NAME = "Instant Item Rooms"
IIR.VERSION = "1.1"
IIR.AUTHOR = "mitko8009"
IIR.SOCIAL = "@mitko8009_"


local json = require("json");

starting_rooms = {"None" , "Treasure", "Shop", "Secret", "Boss"} 
settings_IIR = { 
	STARTING_ROOM = "Treasure"
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

if ModConfigMenu then
    require("scripts.mcm");
end

function mod:onLevelStart()
	local player = Isaac.GetPlayer(0);
	if ((Game():GetLevel():GetStage() == 1) and (Game():IsGreedMode() == false)) then
		if (settings_IIR.STARTING_ROOM == "Treasure") then
			player:UseCard(Card.CARD_STARS, 259) -- 100000011 UseFlag Value in Bits => 259 (USE_NOANIM, USE_NOCOSTUME, USE_NOANNOUNCER)
		elseif (settings_IIR.STARTING_ROOM == "Shop") then
			player:UseCard(Card.CARD_HERMIT, 259)
		elseif (settings_IIR.STARTING_ROOM == "Secret") then
			player:UseCard(Card.CARD_MOON, 259)
        elseif (settings_IIR.STARTING_ROOM == "Boss") then
            player:UseCard(Card.CARD_EMPEROR, 259)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.onLevelStart)
