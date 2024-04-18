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
    Type = ModConfigMenu.OptionType.NUMBER,
    CurrentSetting = function()
        return getTableIndex(starting_rooms, settings_IIR.STARTING_ROOM)
    end,
    Minimum = 1,
    Maximum = #starting_rooms,
    Display = function()
        return "Starting Room: " .. settings_IIR.STARTING_ROOM
    end,
    OnChange = function(n)
        settings_IIR.STARTING_ROOM = starting_rooms[n]
    end,
    Info = { 
        "Choose in which room you want isaac to spawn in",
        "The Boss room isn't recommended to use "
    }
});
