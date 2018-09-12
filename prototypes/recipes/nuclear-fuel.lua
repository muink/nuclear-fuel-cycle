local energy = data.raw.recipe["nuclear-fuel"].energy_required


--Tweaks icon for vanilla recipe of nuclear fuel
data.raw.recipe["nuclear-fuel"].icons = {
	{
		icon = "__base__/graphics/icons/nuclear-fuel.png"
	},
	{
		icon = "__base__/graphics/icons/uranium-235.png",
		scale = 0.4,
		shift = {-10, 10}
	}
}
data.raw.recipe["nuclear-fuel"].icon_size = 32


data:extend({
	{
		type = "recipe",
		name = "nuclear-fuel-from-WGPu-239",
		icons = {
			{
				icon = "__base__/graphics/icons/nuclear-fuel.png",
			},
			{
				icon = "__nuclear-fuel-cycle__/graphics/icons/90%-plutonium-239.png",
				scale = 0.4,
				shift = {-10, 10}
			}
		},
		icon_size = 32,
		enabled = false,
		category = "centrifuging",
		energy_required = energy*2,
		ingredients = {{"90%-plutonium-239", 2}, {"rocket-fuel", 3}},
		result = "nuclear-fuel",
		result_count = 3
	}
})