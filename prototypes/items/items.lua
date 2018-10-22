local breeder_fuel_cell_fuel_value = BREEDER_FUEL_VALUE


--uranium-235 uranium-238
data.raw.item["uranium-235"].subgroup = "nuclear-product"
data.raw.item["uranium-238"].subgroup = "nuclear-product"
data.raw.item["uranium-235"].order = "a[material]-a[uranium]-a[235]"
data.raw.item["uranium-238"].order = "a[material]-a[uranium]-b[238]"


--Nuclear fuel cell
data.raw.item["uranium-fuel-cell"].subgroup = "nuclear-product"
data.raw.item["uranium-fuel-cell"].order = "b[fuel-cell]-a[uranium-fuel-cell]"


--Used up nuclear fuel cell
data.raw.item["used-up-uranium-fuel-cell"].subgroup = "nuclear-product"
data.raw.item["used-up-uranium-fuel-cell"].order = "b[fuel-cell]-a[used-up-uranium-fuel-cell]"
data.raw.item["used-up-uranium-fuel-cell"].localised_name = {"item-name.used-up-uranium-fuel-cell"}


data:extend({
	{
		type = "item",
		name = "90%-plutonium-239",
		icon = "__nuclear-fuel-cycle__/graphics/icons/90%-plutonium-239.png",
		icon_size = 32,
		flags = {"goes-to-main-inventory"},
		subgroup = "nuclear-product",
		order = "a[material]-b[plutonium]-b[239]-a",
		stack_size = 100
	},
	{
		type = "item",
		name = "65%-plutonium-239",
		icon = "__nuclear-fuel-cycle__/graphics/icons/65%-plutonium-239.png",
		icon_size = 32,
		flags = {"goes-to-main-inventory"},
		subgroup = "nuclear-product",
		order = "a[material]-b[plutonium]-b[239]-b",
		stack_size = 100
	},
	{
		type = "item",
		name = "mox-fuel-cell",
		icon = "__nuclear-fuel-cycle__/graphics/icons/mox-fuel-cell.png",
		icon_size = 32,
		flags = {"goes-to-main-inventory"},
		subgroup = "nuclear-product",
		order = "b[fuel-cell]-b[mox-fuel-cell]",
		fuel_category = "nuclear",
		burnt_result = "used-up-mox-fuel-cell",
		fuel_value = "8GJ",
		stack_size = 50
	},
	{
		type = "item",
		name = "used-up-mox-fuel-cell",
		icon = "__nuclear-fuel-cycle__/graphics/icons/used-up-mox-fuel-cell.png",
		icon_size = 32,
		flags = {"goes-to-main-inventory"},
		subgroup = "nuclear-product",
		order = "b[fuel-cell]-b[used-up-mox-fuel-cell]",
		stack_size = 50
	},
	{
		type = "item",
		name = "breeder-fuel-cell",
		icon = "__nuclear-fuel-cycle__/graphics/icons/breeder-fuel-cell.png",
		icon_size = 32,
		flags = {"goes-to-main-inventory"},
		subgroup = "nuclear-product",
		order = "b[fuel-cell]-c[breeder-fuel-cell]",
		fuel_category = "nuclear",
		burnt_result = "used-up-breeder-fuel-cell",
		fuel_value = breeder_fuel_cell_fuel_value,
		stack_size = 50
	},
	{
		type = "item",
		name = "used-up-breeder-fuel-cell",
		icon = "__nuclear-fuel-cycle__/graphics/icons/used-up-breeder-fuel-cell.png",
		icon_size = 32,
		flags = {"goes-to-main-inventory"},
		subgroup = "nuclear-product",
		order = "b[fuel-cell]-c[used-up-breeder-fuel-cell]",
		stack_size = 50
	}
})