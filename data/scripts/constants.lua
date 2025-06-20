local ld = dofile_once("mods/bountiful_basins/lib/loaded_dice.lua")

BASIN_MATERIALS = {}
local basin_weights = {}

local count = 1
for i = 0, ModSettingGetCount() - 1, 1 do
    local name, value = ModSettingGetAtIndex(i)
    if value ~= 0 and tostring(name):find("^bountiful_basins.weight_") ~= nil then
        -- validate material actually exists, in case user removed mods after setting weights
        local material = name:gsub("bountiful_basins.weight_", "")
        if CellFactory_GetType(material) ~= -1 then
            BASIN_MATERIALS[count] = material
            basin_weights[count] = value
            count = count + 1
        end
    end
end

WEIGHTED = ld.new_die(basin_weights)
BASIN_EMPTY_CHANCE = ModSettingGet("bountiful_basins.empty_chance")
