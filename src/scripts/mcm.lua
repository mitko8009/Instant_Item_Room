local function addSpace(tab_name)
    ModConfigMenu.AddSpace(IIR.MOD_NAME, tab_name)
end

local function getTableIndex(tbl, val)
    for i, v in ipairs(tbl) do
        if v == val then
            return i
        end
    end
    return 0
end

local displaytag = ""

ModConfigMenu.UpdateCategory(IIR.MOD_NAME, {
    Info = "View settings for " .. IIR.MOD_NAME .. "."
});

ModConfigMenu.AddTitle(IIR.MOD_NAME, "IIR", IIR.MOD_NAME)
ModConfigMenu.AddText(IIR.MOD_NAME, "IIR", function() return "Version " .. IIR.VERSION end);
addSpace("IIR")
ModConfigMenu.AddTitle(IIR.MOD_NAME, "IIR", "Developer")
ModConfigMenu.AddText(IIR.MOD_NAME, "IIR", function() return IIR.AUTHOR end);
ModConfigMenu.AddText(IIR.MOD_NAME, "IIR", function() return "Follow me on Instagram: " .. IIR.SOCIAL end);

addSpace("IIR")
ModConfigMenu.AddTitle(IIR.MOD_NAME, "IIR", "Mod Settings")

ModConfigMenu.AddSetting(IIR.MOD_NAME, "IIR",
{
    Type = ModConfigMenu.OptionType.BOOLEAN,
    CurrentSetting = function ()
        return settings_IIR.teleport_every_floor
    end,
    Display = function ()
        return "Teleport every floor: " .. (settings_IIR.teleport_every_floor and "ON" or "OFF") .. (settings_IIR.teleport_every_floor == false and " (Default)" or "")
    end,
    OnChange = function (b)
        settings_IIR.teleport_every_floor = b
    end
});

ModConfigMenu.AddSetting(IIR.MOD_NAME, "IIR",
{
    Type = ModConfigMenu.OptionType.NUMBER,
    CurrentSetting = function()
        return getTableIndex(STARTING_ROOMS, settings_IIR.starting_room)
    end,
    Minimum = 1,
    Maximum = #STARTING_ROOMS,
    Display = function()
        if (
            (settings_IIR.starting_room == "Boss") or
            (settings_IIR.starting_room == "Miniboss")
        ) then
            displaytag = " (NOT RECOMMENDED)"
        else 
            displaytag = ""
        end

        return "Starting Room: " .. settings_IIR.starting_room .. (settings_IIR.starting_room == "Treasure" and " (Default)" or "")
    end,
    OnChange = function(n)
        settings_IIR.starting_room = STARTING_ROOMS[n]
    end,
    Info = { 
        "NOTE: That room has to be present on the current floor for the teleportation to work."
    }
});

ModConfigMenu.AddTitle(IIR.MOD_NAME, "IIR", function() return displaytag end)
