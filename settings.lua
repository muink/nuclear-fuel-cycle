local prefix = "nuclear-fuel-cycle_"

--startup
data:extend({
	{
		type = "string-setting",
		name = prefix .. "pu-bomb-ingredient",
		setting_type = "startup",
		default_value = 20, --30/15*10 based on critical mass
		allowed_values = {"13", "15", "17", "20", "23", "27", "30"},
		order = "a"
	},
	{
		type = "bool-setting",
		name = prefix .. "exacting-mode",
		setting_type = "startup",
		default_value = true,
		order = "b"
	},
	{
		type = "bool-setting",
		name = prefix .. "multicolor-reactor",
		setting_type = "startup",
		default_value = true,
		order = "c"
	}
})


--runtime-global
data:extend({
---------runing
	{
		type = "bool-setting",
		name = prefix .. "mining-limit",
		setting_type = "runtime-global",
		default_value = true,
		order = "a"
	},
	{
		type = "double-setting",
		name = prefix .. "pollution-multiplier",
		setting_type = "runtime-global",
		default_value = 30,
		minimum_value = 0.0,
		maximum_value = 1.0e+8,
		order = "a-b"
	},
	{
		type = "bool-setting",
		name = prefix .. "destruction-pollution",
		setting_type = "runtime-global",
		default_value = true,
		order = "a-c"
	},
---------critical temperature
	{
		type = "double-setting",
		name = prefix .. "critical-temperature",
		setting_type = "runtime-global",
		default_value = 998.0,
		minimum_value = 900,
		maximum_value = 1000,
		order = "b"
	},
	{
		type = "bool-setting",
		name = prefix .. "critical-pollution",
		setting_type = "runtime-global",
		default_value = true,
		order = "b-a"
	},
	{
		type = "string-setting",
		name = prefix .. "core-meltdown-type",
		setting_type = "runtime-global",
		default_value = "fire",
		allowed_values = {"off", "overheat-damage", "fire"},
		order = "b-b[damagetype]"
	},
	{
		type = "double-setting",
		name = prefix .. "critical-damage",
		setting_type = "runtime-global",
		default_value = 18.0,
		minimum_value = 1,
		order = "b-b[damagetype]-b"
	},
	{
		type = "double-setting",
		name = prefix .. "fire-strength",
		setting_type = "runtime-global",
		default_value = 7.0,
		minimum_value = 1,
		order = "b-b[damagetype]-c"
	},
---------misc
	{
		type = "bool-setting",
		name = prefix .. "debug_mode",
		setting_type = "runtime-global",
		default_value = false,
		order = "c"
	}
})
