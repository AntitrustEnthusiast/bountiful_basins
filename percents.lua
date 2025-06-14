-- utility script for getting default material weights as percentages: (weight / total_weight) * 100
-- not actually part of the mod code, can be deleted if not needed
-- outputs as CSV, pipe to something like ConvertFrom-CSV to print as a nice table:
require("materials")

local total_weight = 0
for _, value in pairs(DEFAULT_WEIGHTS) do
    total_weight = total_weight + value
end

print("name,weight,percent")
for key, value in pairs(DEFAULT_WEIGHTS) do
    local escaped = key:gsub('"', '""')
    local percent = (value / total_weight) * 100
    print('"' .. escaped .. '",' .. value .. ',' .. percent)
end
