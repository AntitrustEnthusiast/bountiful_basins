DEFAULT_WEIGHTS = {
	-- vanilla values, balancing around 200
	["water"] = 200,
	["lava"] = 200,
	["radioactive_liquid"] = 200,
	["oil"] = 200,
	["blood"] = 200,

	-- neutral
	["alcohol"] = 25, -- whiskey
	["beer"] = 25,
	-- ["blood_fungi"] = 0, -- evaporates
	["blood_worm"] = 35,
	["cement"] = 30,
	["juhannussima"] = 25,
	-- ["material_rainbow"] = 0, -- evaporates
	["milk"] = 35,
	["molut"] = 25,
	["pea_soup"] = 20,
	["peat"] = 30,
	["sima"] = 25,
	["slime_green"] = 15,
	["slime_yellow"] = 15,
	["slime"] = 15,
	["slush"] = 35,
	["swamp"] = 35,
	["urine"] = 30,
	["vomit"] = 30,
	["water_salt"] = 35,
	["water_swamp"] = 35,

	-- healing
	["magic_liquid_hp_regeneration"] = 10,
	["porridge"] = 15,

	-- helpful magical liquids
	["magic_liquid_berserk"] = 25,
	["magic_liquid_charm"] = 15,
	["magic_liquid_faster_levitation_and_movement"] = 10,
	["magic_liquid_faster_levitation"] = 15,
	-- ["magic_liquid_hp_regeneration_unstable"] = 0, -- evaporates
	["magic_liquid_invisibility"] = 15,
	["magic_liquid_mana_regeneration"] = 25,
	["magic_liquid_movement_faster"] = 15,
	["magic_liquid_protection_all"] = 10,
	["midas_precursor"] = 30,
	["midas"] = 15,
	["mimic_liquid"] = 15, -- will probably be converted by the time you see it anyway

	-- harmful/neutral magical liquids
	["magic_liquid_worm_attractor"] = 50,
	["magic_liquid_weakness"] = 15,
	["magic_liquid_teleportation"] = 30,
	["magic_liquid_unstable_teleportation"] = 40,
	["magic_liquid_unstable_polymorph"] = 40,
	["magic_liquid_polymorph"] = 30,
	["magic_liquid_random_polymorph"] = 40,
	["material_confusion"] = 50,
	-- ["magic_liquid"] = 0, -- evaporates

	-- harmful non-magical liquids
	["acid"] = 25,    -- can anger gods. no worse than vanilla worms
	["blood_cold"] = 1, -- evaporates into freezing vapor, quite dangerous
	["cursed_liquid"] = 25,
	["just_death"] = 10, -- evaporates...but it would be really funny if someone got there in time
	["liquid_fire_weak"] = 30,
	["liquid_fire"] = 20,
	["material_darkness"] = 25,
	-- ["poison"] = 0, -- evaporates but no tag...
	["pus"] = 25,
	["void_liquid"] = 1, -- extremely low chance because it can anger gods.

	-- molten
	["aluminium_molten"] = 10,
	["aluminium_oxide_molten"] = 10,
	["aluminium_robot_molten"] = 10,
	["brass_molten"] = 15,
	["copper_molten"] = 15,
	["glass_molten"] = 15,
	["gold_molten"] = 25,
	["metal_prop_molten"] = 10,
	["metal_rust_molten"] = 10,
	["metal_sand_molten"] = 10,
	["plastic_red_molten"] = 15,
	["silver_molten"] = 25,
	["steel_static_molten"] = 10,
	["steelmoss_static_molten"] = 10,
	["wax_molten"] = 20,
}

-- these materials are implemented in the base game but never used
UNUSED_MATERIALS = {
	["grass_loose"] = true,
	["brick"] = true,
	["creepy_liquid_emitter"] = true,
	["corruption_static"] = true,
	["rock_eroding"] = true,
	["steel_static_unmeltable"] = true,
	["rock_magic_gate"] = true,
	["rock_magic_bottom"] = true,
	["templebrick_moss_static"] = true,
	["steelmoss_slanted"] = true,
	["steelmoss_slanted_molten"] = true,
	["wood_static_gas"] = true,
	["steelsmoke_static"] = true,
	["steelsmoke_static_molten"] = true,
	["trailer_text"] = true,
	["wood_prop_durable"] = true,
	["gem_box2d_green"] = true,
	["gem_box2d_orange"] = true,
	["gem_box2d_red"] = true,
	["gem_box2d_pink"] = true,
}

-- these materials are pointless duplicates, have errors, or are just weird
IGNORED_MATERIALS = {
	["blood_fading_slow"] = true,   -- seems pointless with regular blood?
	["cloth_box2d"] = true, 	    -- missing name string, spams errors with options menu open
	["gem_box2d_white"] = true,     -- same as above
	["metal_nohit_molten"] = true,  -- basically a duplicate of metal_prop_molten but for light fixtures?
	["metal_molten"] = true,        -- same as above, but unused?
	["plastic_grey_molten"] = true, -- missing generated material_icons for some reason
	["plastic_grey"] = true,        -- same as above
	["plastic_molten"] = true,      -- less interesting version
	["plastic_prop_molten"] = true, -- less interesting version
	["rocket_particles"] = true,    -- liquid smoke?
	["steel_molten"] = true,        -- less interesting version
	["steel_rust_molten"] = true,   -- less interesting version
	["water_fading"] = true,        -- evaporable but no evaporable tag (because it doesn't create anything?)
	["water_temp"] = true,          -- duplicate of water_fading?
	["orb_powder"] = true,          -- burns away
	["creepy_liquid"] = true,       -- just disappears
}
