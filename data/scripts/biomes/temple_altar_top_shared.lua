dofile_once("data/scripts/constants.lua")

---@diagnostic disable-next-line: lowercase-global
function spawn_altar_top(x, y, is_solid)
	SetRandomSeed(x, y)
	local file_visual = "data/biome_impl/temple/altar_top_visual.png"

	LoadBackgroundSprite("data/biome_impl/temple/wall_background.png", x - 1, y - 30, 35)

	if (y > 12000) then
		LoadPixelScene("data/biome_impl/temple/altar_top_boss_arena.png", file_visual, x, y - 40, "", true)
	elseif (Random() <= BASIN_EMPTY_CHANCE) then
		LoadPixelScene("data/biome_impl/temple/altar_top.png", file_visual, x, y - 40, "", true)
	else
		local material = BASIN_MATERIALS[WEIGHTED:random()]
		-- print("basin: " .. material)
		LoadPixelScene("data/biome_impl/temple/altar_top_water.png", file_visual, x, y - 40, "", true, false, {["902F554C"] = material})
	end

	if is_solid then LoadPixelScene("data/biome_impl/temple/solid.png", "", x, y - 40 + 300, "", true) end
end
