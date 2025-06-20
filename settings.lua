dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/lib/mod_settings.lua")

local mod_id = "bountiful_basins"

local prefix = "weight_"
local setting_prefix = mod_id .. "." .. prefix
local find_pattern = "^" .. setting_prefix
local filled = false

local show_sands = ModSettingGet(mod_id .. ".show_sands")
local show_solids = ModSettingGet(mod_id .. ".show_solids")
local show_gases = ModSettingGet(mod_id .. ".show_gases")
local show_evaporable = ModSettingGet(mod_id .. ".show_evaporable")
local show_unused = ModSettingGet(mod_id .. ".show_unused")

mod_settings_version = 1
mod_settings = {
	{
		id = "empty_chance",
		ui_name = "Empty basin chance",
		ui_description =
		[[Chance a basin will be empty. Independent of material weights.
Mod default is 75%, vanilla is 90% chance to be empty.
Setting too low might make some seeds very difficult.]],
		value_default = 0.75,
		value_min = 0,
		value_max = 1,
		value_display_multiplier = 100,
		value_display_formatting = " $0%",
		scope = MOD_SETTING_SCOPE_NEW_GAME,
	},
	{
		category_id = "materials",
		ui_name = "Material weights... (may contain spoilers)",
		ui_description =
		"How likely each material is to show up in a basin if filled.\nNote: these are weights, not percentages.",
		foldable = true,
		_folded = true,
		hidden = true,
		settings = {} -- filled dynamically once game is loaded enough to run CellFactory_* methods
	},
	{
		id = "explain_empty",
		not_setting = true,
		hidden = true,
		ui_name = "Material weights are only available in game due to mod API limits!",
		ui_description =
		"Specifically, CellFactory_* methods crash to desktop if called before OnBiomeConfigLoaded()",
	},
	{
		category_id = "show_more",
		ui_name = "Show more materials...",
		ui_description =
		[[Show sliders for additional material categories. Off by default to avoid bogging down the menu.
Note: hidden materials default to 0 weight, you will need to increase them manually.
Note: weights still apply if these settings are hidden.
Manually set to 0 before hiding or use [reset] button above if not desired.]],
		foldable = true,
		_folded = true,
		settings = {
			{
				id = "show_sands",
				ui_name = "Show sliders for sands (powers)",
				ui_description =
				"Off by default.\nSands can be annoying to dig through.",
				value_default = false,
				scope = MOD_SETTING_SCOPE_RUNTIME_RESTART
			},
			{
				id = "show_solids",
				ui_name = "Show sliders for solids",
				ui_description =
				"Off by default.\nIf sands are annoying, this sounds miserable. Don't blame me.",
				value_default = false,
				scope = MOD_SETTING_SCOPE_RUNTIME_RESTART
			},
			{
				id = "show_gases",
				ui_name = "Show sliders for gases",
				ui_description =
				"Off by default.\nNot really annoying, just pointless. Most gases will dissipate before the player arrives.",
				value_default = false,
				scope = MOD_SETTING_SCOPE_RUNTIME_RESTART
			},
			{
				id = "show_evaporable",
				ui_name = "Show sliders for evaporable liquids",
				ui_description = "Off by default.\nSame as gases, players will rarely see them.",
				value_default = false,
				scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
			},
			{
				id = "show_unused",
				ui_name =
				"Show sliders for unused materials",
				ui_description =
				"Off by default.\nMaterials defined in game files but not used anywhere.\nNot responsible for broken runs.",
				value_default = false,
				scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
			}
		}
	},
}

local function show_elem_name(id, name)
	if not name then return false end
	if IGNORED_MATERIALS[name] then return false end
	if not show_unused and UNUSED_MATERIALS[name] then return false end

	-- hardcoded cloud_blood/etc.
	if not show_evaporable and name:find("^cloud_") ~= nil then return false end
	if not show_evaporable and (CellFactory_HasTag(id, "evaporable") or CellFactory_HasTag(id, "evaporable_fast")) then
		return false
	end

	return true
end

local function reset_to_default()
	ModSettingSetNextValue(mod_id .. ".empty_chance", mod_settings[1].value_default, false)
	-- we need to iterate all instead of just mod_settings to account for missing settings (hidden, removed mods, etc.)
	for i = 0, ModSettingGetCount() - 1, 1 do
		local name, _, _ = ModSettingGetAtIndex(i)
		if tostring(name):find(find_pattern) ~= nil then
			local material = string.sub(name, #setting_prefix + 1)
			local default = DEFAULT_WEIGHTS[material] or 0
			ModSettingSetNextValue(name, default, false)
		end
	end
	for _, v in pairs(mod_settings[4].settings) do
		ModSettingSetNextValue(mod_id .. "." .. v.id, v.value_default, false)
	end
end

-- TODO: make the name/slider on the same line as the image.
-- will probably have to manually reimplement the functions while messing with mod_setting_group_x_offset
local function multi_track_drifting(id, gui, in_main_menu, im_id, setting)
	mod_setting_image(id, gui, in_main_menu, im_id, setting)
	mod_setting_number(id, gui, in_main_menu, im_id, setting)
end

-- checks if a material name should be added to the options list, then does it
local function add_material(name)
	local id = CellFactory_GetType(name)
	if not show_elem_name(id, name) then return end
	local ui_name = CellFactory_GetUIName(id)
	if ui_name == "" then ui_name = name end
	table.insert(mod_settings[2].settings, {
		id = "weight_" .. name,
		ui_name = ui_name,
		ui_description = name,
		value_default = DEFAULT_WEIGHTS[name] or 0,
		value_min = 0,
		value_max = 500,
		image_filename = "data/generated/material_icons/" .. name .. ".png",
		ui_fn = multi_track_drifting,
		scope = MOD_SETTING_SCOPE_NEW_GAME
	})
end

-- appends all valid materials as dynamic settings
-- crashes if called in main menu, materials must be loaded to call CellFactory_* methods
local function fill_settings()
	if filled then return end
	-- load default weights, unused materials, and ignored materials
	dofile_once("mods/" .. mod_id .. "/materials.lua")
	filled = true
	for _, name in pairs(CellFactory_GetAllLiquids(false, false)) do
		add_material(name)
	end
	if show_sands then
		for _, name in pairs(CellFactory_GetAllSands(false, false)) do
			add_material(name)
		end
	end
	if show_solids then
		for _, name in pairs(CellFactory_GetAllSolids(false, false)) do
			add_material(name)
		end
	end
	if show_gases then
		for _, name in pairs(CellFactory_GetAllGases(false, false)) do
			add_material(name)
		end
	end
end

function ModSettingsUpdate(init_scope)
	local old_version = mod_settings_get_version(mod_id)
	-- manual apply because builtin function won't do it for dynamic settings
	if (init_scope == MOD_SETTING_SCOPE_NEW_GAME) then
		for i = 0, ModSettingGetCount() - 1, 1 do
			local name, value, value_next = ModSettingGetAtIndex(i)
			if value_next and (value_next ~= value) and (tostring(name):find(find_pattern) ~= nil) then
				ModSettingSet(name, value_next)
			end
		end
	end
	mod_settings_update(mod_id, mod_settings, init_scope)
end

function ModSettingsGuiCount()
	return mod_settings_gui_count(mod_id, mod_settings)
end

function ModSettingsGui(gui, in_main_menu)
	-- show note if not loaded, otherwise fill settings
	if not in_main_menu then
		mod_settings[3]["hidden"] = true
		fill_settings()
		if GuiButton(gui, 1891292, mod_setting_group_x_offset, 0, "[Reset to defaults]") then
			reset_to_default()
		end
	else
		mod_settings[3]["hidden"] = false
	end
	mod_settings_gui(mod_id, mod_settings, gui, in_main_menu)
end
