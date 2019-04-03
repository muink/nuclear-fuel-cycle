local energy = data.raw.recipe["uranium-fuel-cell"].energy_required
local u_breeding_ratio = U_BREEDING_RATIO
local pu_breeding_ratio = PU_BREEDING_RATIO
local pu_amount = PER_CELL_PU_AMOUNT


data:extend({
	{
		type = "recipe",
		name = "mox-fuel-cell-from-Pu-239",
		icons = {
			{
				icon = "__nuclear-fuel-cycle__/graphics/icons/mox-fuel-cell.png",
			},
			{
				icon = "__nuclear-fuel-cycle__/graphics/icons/90%-plutonium-239.png",
				scale = 0.4,
				shift = {-10, 10}
			}
		},
		icon_size = 32,
		energy_required = energy,
		enabled = false,
		ingredients = {
			{"iron-plate", 10},
			{"plutonium-239", 1},
			{"uranium-238", 13}
		},
		result = "mox-fuel-cell",
		result_count = 10
	},
	{
		type = "recipe",
		name = "mox-fuel-cell-from-RGPu-239",
		icons = {
			{
				icon = "__nuclear-fuel-cycle__/graphics/icons/mox-fuel-cell.png",
			},
			{
				icon = "__nuclear-fuel-cycle__/graphics/icons/65%-plutonium-239.png",
				scale = 0.4,
				shift = {-10, 10}
			}
		},
		icon_size = 32,
		energy_required = energy,
		enabled = false,
		ingredients = {
			{"iron-plate", 10},
			{"RG-plutonium-239", 1},
			{"uranium-238", 18}
		},
		result = "mox-fuel-cell",
		result_count = 10
	},
	{
		type = "recipe",
		name = "breeder-fuel-cell-from-U-235",
		icons = {
			{
				icon = "__nuclear-fuel-cycle__/graphics/icons/breeder-fuel-cell.png",
			},
			{
				icon = "__base__/graphics/icons/uranium-235.png",
				scale = 0.4,
				shift = {-10, 10}
			}
		},
		icon_size = 32,
		energy_required = u_breeding_ratio*pu_amount,
		enabled = false,
		ingredients = {
			{"iron-plate", u_breeding_ratio},
			{"uranium-235", 1},
			{"uranium-238", u_breeding_ratio*pu_amount}
		},
		result = "breeder-fuel-cell",
		result_count = u_breeding_ratio
	},
	{
		type = "recipe",
		name = "breeder-fuel-cell-from-Pu-239",
		icons = {
			{
				icon = "__nuclear-fuel-cycle__/graphics/icons/breeder-fuel-cell.png",
			},
			{
				icon = "__nuclear-fuel-cycle__/graphics/icons/90%-plutonium-239.png",
				scale = 0.4,
				shift = {-10, 10}
			}
		},
		icon_size = 32,
		energy_required = pu_breeding_ratio*pu_amount,
		enabled = false,
		ingredients = {
			{"iron-plate", pu_breeding_ratio},
			{"plutonium-239", 1},
			{"uranium-238", pu_breeding_ratio*pu_amount}
		},
		result = "breeder-fuel-cell",
		result_count = pu_breeding_ratio
	}
})