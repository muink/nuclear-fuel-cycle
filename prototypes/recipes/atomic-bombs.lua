--Tweaks icon for vanilla recipe of atomic bomb
data.raw.recipe["atomic-bomb"].icons = {
	{
		icon = "__base__/graphics/icons/atomic-bomb.png"
	},
	{
		icon = "__base__/graphics/icons/uranium-235.png",
		scale = 0.4,
		shift = {-10, 10}
	}
}
data.raw.recipe["atomic-bomb"].icon_size = 32


local energy = data.raw.recipe["atomic-bomb"].energy_required

data:extend({
	{
		type = "recipe",
		name = "atomic-bomb-from-WGPu-239",
		icons = {
			{
				icon = "__base__/graphics/icons/atomic-bomb.png",
			},
			{
				icon = "__nuclear-fuel-cycle__/graphics/icons/90%-plutonium-239.png",
				scale = 0.4,
				shift = {-10, 10}
			}
		},
		icon_size = 32,
		enabled = false,
		energy_required = energy,
		ingredients = {
			{"processing-unit", 20},
			{"explosives", 10},
			{"90%-plutonium-239", 20}
		},
		result = "atomic-bomb"
	}
})