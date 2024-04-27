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
    Type = ModConfigMenu.OptionType.NUMBER,
    CurrentSetting = function()
        return getTableIndex(STARTING_ROOMS, settings_IIR.starting_room)
    end,
    Minimum = 1,
    Maximum = #STARTING_ROOMS,
    Display = function()
        if settings_IIR.starting_room == "Boss" then
            displaytag = " (NOT RECOMMENDED)"
        else 
            displaytag = ""
        end

        return "Starting Room: " .. settings_IIR.starting_room .. (settings_IIR.starting_room == "None" and " (Default)" or "") .. (settings_IIR.starting_room == "Joker" and " (Angel/Devil Room)" or "")
    end,
    OnChange = function(n)
        settings_IIR.starting_room = STARTING_ROOMS[n]
    end,
    Info = { 
        "Choose in which room you want isaac to spawn in",
        "The Boss room isn't recommended to use "
    }
});

ModConfigMenu.AddTitle(IIR.MOD_NAME, "IIR", function() return displaytag end)
