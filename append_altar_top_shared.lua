dofile_once("mods/bountiful_basins/constants.lua")

local function rand_material(x, y)
    SetRandomSeed(x, y)
    if Random() <= BASIN_EMPTY_CHANCE then
        return "air"
    else
        return BASIN_MATERIALS[WEIGHTED:random()]
    end
end

-- partially based on https://github.com/EvaisaDev/noita.fairmod
local old_LoadPixelScene = LoadPixelScene
function LoadPixelScene(materials_filename, colors_filename, x, y, background_file, skip_biome_checks, skip_edge_textures,
                        color_to_material_table, background_z_index, load_even_if_duplicate)
    -- matches altar_top_water/blood/oil/radioactive/lava, but not boss_arena or solid
    if materials_filename:match("^data/biome_impl/temple/altar_top[_.][wborl]?") then
        materials_filename = "data/biome_impl/temple/altar_top_water.png"
        local material = rand_material(x, y)
        color_to_material_table = {
            ["902F554C"] = material,
        }
    end
    old_LoadPixelScene(materials_filename, colors_filename, x, y, background_file, skip_biome_checks, skip_edge_textures,
        color_to_material_table, background_z_index, load_even_if_duplicate)
end
