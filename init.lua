dofile_once("mods/bountiful_basins/materials.lua")

ModLuaFileAppend("data/scripts/biomes/temple_altar_top_shared.lua", "mods/bountiful_basins/append_altar_top_shared.lua")

local function fill_empty_settings()
    print("all basin weights were empty, filling with defaults")
    for key, value in pairs(DEFAULT_WEIGHTS) do
        ModSettingSet("bountiful_basins." .. key, value)
    end
end

local function no_weights()
    for i = 0, ModSettingGetCount() - 1, 1 do
        local name, _, _ = ModSettingGetAtIndex(i)
        if tostring(name):find("^bountiful_basins.weight_") then
            return false
        end
    end
    return true
end

function OnBiomeConfigLoaded()
    if no_weights() then
        fill_empty_settings()
    end
end
