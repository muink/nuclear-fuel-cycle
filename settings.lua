local prefix = "nuclear-fuel-cycle_"

data:extend({
	{
		type = "string-setting",
		name = prefix .. "pu-bomb-ingredient",
		setting_type = "startup",
		default_value = 20, --30/15*10 based on critical mass
		allowed_values = {"13", "15", "17", "20", "23", "27", "30"},
		order = "a"
	}
})