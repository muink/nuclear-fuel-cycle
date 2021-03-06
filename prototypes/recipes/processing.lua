local breeder_fuel_reprocessing_ingredient = 10
local pu_amount = PER_CELL_PU_AMOUNT


--Uranium processing
data.raw.recipe["uranium-processing"].subgroup = "nuclear-processing"
data.raw.recipe["uranium-processing"].order = "a[uranium-processing]"


--Kovarex Enrichment Process
data.raw.recipe["kovarex-enrichment-process"].subgroup = "nuclear-reprocessing"
data.raw.recipe["kovarex-enrichment-process"].order = "a[enrichment-process]-a[kovarex-enrichment-process]"


--Nuclear fuel reprocessing
table.insert(
	data.raw.recipe["nuclear-fuel-reprocessing"].results,
	1,
	{name = "uranium-235", probability = 0.1, amount = 1}
)
table.insert(
	data.raw.recipe["nuclear-fuel-reprocessing"].results,
	1,
	{name = "RG-plutonium-239", probability = 0.2, amount = 1}
)
data.raw.recipe["nuclear-fuel-reprocessing"].icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-fuel-reprocessing.png"
data.raw.recipe["nuclear-fuel-reprocessing"].subgroup = "nuclear-reprocessing"
data.raw.recipe["nuclear-fuel-reprocessing"].order = "c[fuel-reprocessing]-a[uranium-fuel-reprocessing]"
data.raw.recipe["nuclear-fuel-reprocessing"].localised_name = {"recipe-name.nuclear-fuel-reprocessing"}


--Nuclear reprocessing
data:extend({
	{
		type = "recipe",
		name = "plutonium-purification-process",
		energy_required = 20*8.5,
		enabled = false,
		category = "centrifuging",
		ingredients = {{"RG-plutonium-239", 20}},
		icon = "__nuclear-fuel-cycle__/graphics/icons/plutonium-purification-process.png",
		icon_size = 32,
		subgroup = "nuclear-reprocessing",
		order = "b[nuclide-process]-a[plutonium-purification-process]",
		main_product = "",
		result = "plutonium-239",
		result_count = 13,
		allow_decomposition = false
	},
	{
		type = "recipe",
		name = "mox-fuel-reprocessing",
		energy_required = 5*7,
		enabled = false,
		category = "centrifuging",
		ingredients = {{"used-up-mox-fuel-cell", 5}},
		icon = "__nuclear-fuel-cycle__/graphics/icons/mox-fuel-reprocessing.png",
		icon_size = 32,
		subgroup = "nuclear-reprocessing",
		order = "c[fuel-reprocessing]-b[mox-fuel-reprocessing]",
		main_product = "",
		results = {{"uranium-238", 2}},
		allow_decomposition = false
	},
	{
		type = "recipe",
		name = "breeder-fuel-reprocessing",
		energy_required = 10*9,
		enabled = false,
		category = "centrifuging",
		ingredients = {{"used-up-breeder-fuel-cell", breeder_fuel_reprocessing_ingredient}},
		icon = "__nuclear-fuel-cycle__/graphics/icons/breeder-fuel-reprocessing.png",
		icon_size = 32,
		subgroup = "nuclear-reprocessing",
		order = "c[fuel-reprocessing]-c[breeder-fuel-reprocessing]",
		main_product = "",
		results = {
			{
				name = "plutonium-239",
				amount = breeder_fuel_reprocessing_ingredient*pu_amount
			}
		},
		allow_decomposition = false
	}
})