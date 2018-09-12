local breeder_fuel_reprocessing_ingredient = 10
local pu_amount = PER_CELL_PU_AMOUNT


--Uranium processing
data.raw.recipe["uranium-processing"].subgroup = "nuclear-processing"
data.raw.recipe["uranium-processing"].order = "a[enrichment-process]-a[uranium-processing]"


--Nuclear fuel reprocessing
table.insert(
	data.raw.recipe["nuclear-fuel-reprocessing"].results,
	1,
	{name = "uranium-235", probability = 0.1, amount = 1}
)
table.insert(
	data.raw.recipe["nuclear-fuel-reprocessing"].results,
	1,
	{name = "65%-plutonium-239", probability = 0.2, amount = 1}
)
data.raw.recipe["nuclear-fuel-reprocessing"].icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-fuel-reprocessing.png"
data.raw.recipe["nuclear-fuel-reprocessing"].subgroup = "nuclear-processing"
data.raw.recipe["nuclear-fuel-reprocessing"].order = "b[fuel-reprocessing]-a[uranium-fuel-reprocessing]"
data.raw.recipe["nuclear-fuel-reprocessing"].localised_name = {"recipe-name.nuclear-fuel-reprocessing"}


--Kovarex Enrichment Process
data.raw.recipe["kovarex-enrichment-process"].subgroup = "nuclear-processing"
data.raw.recipe["kovarex-enrichment-process"].order = "a[enrichment-process]-b[kovarex-enrichment-process]"


--Nuclear reprocessing
data:extend({
	{
		type = "recipe",
		name = "plutonium-purification-process",
		energy_required = 150,
		enabled = false,
		category = "centrifuging",
		ingredients = {{"65%-plutonium-239", 20}},
		icon = "__nuclear-fuel-cycle__/graphics/icons/plutonium-purification-process.png",
		icon_size = 32,
		subgroup = "nuclear-processing",
		order = "a[nuclide-process]-a[plutonium-purification-process]",
		main_product = "",
		result = "90%-plutonium-239",
		result_count = 13,
		allow_decomposition = false
	},
	{
		type = "recipe",
		name = "mox-fuel-reprocessing",
		energy_required = 30,
		enabled = false,
		category = "centrifuging",
		ingredients = {{"used-up-mox-fuel-cell", 5}},
		icon = "__nuclear-fuel-cycle__/graphics/icons/mox-fuel-reprocessing.png",
		icon_size = 32,
		subgroup = "nuclear-processing",
		order = "b[fuel-reprocessing]-b[mox-fuel-reprocessing]",
		main_product = "",
		results = {{"uranium-238", 2}},
		allow_decomposition = false
	},
	{
		type = "recipe",
		name = "breeder-fuel-reprocessing",
		energy_required = 80,
		enabled = false,
		category = "centrifuging",
		ingredients = {{"used-up-breeder-fuel-cell", breeder_fuel_reprocessing_ingredient}},
		icon = "__nuclear-fuel-cycle__/graphics/icons/breeder-fuel-reprocessing.png",
		icon_size = 32,
		subgroup = "nuclear-processing",
		order = "b[fuel-reprocessing]-c[breeder-fuel-reprocessing]",
		main_product = "",
		results = {
			{
				name = "90%-plutonium-239",
				amount = breeder_fuel_reprocessing_ingredient*pu_amount
			}
		},
		allow_decomposition = false
	}
})