local energy = data.raw.recipe["atomic-bomb"].energy_required
local atomic_bomb_ingredient = PU_BOMB_INGREDIENT


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


data:extend({
	{
		type = "recipe",
		name = "atomic-bomb-from-Pu-239",
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
			{"rocket-control-unit", 10},
			{"explosives", 10},
			{"plutonium-239", atomic_bomb_ingredient}
		},
		result = "atomic-bomb"
	}
})