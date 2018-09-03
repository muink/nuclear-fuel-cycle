local energy = data.raw.recipe["uranium-fuel-cell"].energy_required

data:extend({
	{
		type = "recipe",
		name = "mox-fuel-cell-from-WGPu-239",
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
			{"90%-plutonium-239", 1},
			{"uranium-238", 12}
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
			{"65%-plutonium-239", 1},
			{"uranium-238", 17}
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
		energy_required = 12,
		enabled = false,
		ingredients = {
			{"iron-plate", 4},
			{"uranium-235", 1},
			{"uranium-238", 16}
		},
		result = "breeder-fuel-cell",
		result_count = 4
	},
	{
		type = "recipe",
		name = "breeder-fuel-cell-from-WGPu-239",
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
		energy_required = 24,
		enabled = false,
		ingredients = {
			{"iron-plate", 6},
			{"90%-plutonium-239", 1},
			{"uranium-238", 24}
		},
		result = "breeder-fuel-cell",
		result_count = 6
	}
})