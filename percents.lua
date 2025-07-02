-- utility script for getting default material weights as percentages: (weight / total_weight) * 100
-- not actually part of the mod code, can be deleted if not needed
-- outputs as CSV, pipe to something like ConvertFrom-CSV to print as a nice table:
require("materials")

-- pass as first arg:
--   lua percents.lua 75
local fill_percent = (arg[1] or 25) / 100

-- number of replaced basins per parallel world
local basin_count = 52
local filled_per_world = basin_count * fill_percent

local total_weight = 0
for _, value in pairs(DEFAULT_WEIGHTS) do
    total_weight = total_weight + value
end

print("name,weight,percent_basin,percent_world")
for key, value in pairs(DEFAULT_WEIGHTS) do
    local escaped = key:gsub('"', '""')
    local probability = (value / total_weight)
    local percent = probability * 100
    local per_world = (1 - ((1 - probability)^filled_per_world)) * 100
    print('"' .. escaped .. '",' .. value .. ',' .. percent .. ',' .. per_world)
end
