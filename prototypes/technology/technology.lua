--Atomic bomb technology
table.insert(
	data.raw["technology"]["atomic-bomb"].effects,
	{type = "unlock-recipe", recipe = "atomic-bomb-from-Pu-239"}
)


--Nuclear fuel reprocessing technology
data.raw["technology"]["nuclear-fuel-reprocessing"].localised_name = {"technology-name.nuclear-fuel-reprocessing"}
data.raw["technology"]["nuclear-fuel-reprocessing"].unit.count = 150
table.insert(
	data.raw["technology"]["nuclear-fuel-reprocessing"].effects,
	{type = "unlock-recipe", recipe = "plutonium-purification-process"}
)
table.insert(
	data.raw["technology"]["nuclear-fuel-reprocessing"].effects,
	{type = "unlock-recipe", recipe = "mox-fuel-cell-from-RGPu-239"}
)
table.insert(
	data.raw["technology"]["nuclear-fuel-reprocessing"].effects,
	{type = "unlock-recipe", recipe = "mox-fuel-cell-from-Pu-239"}
)
table.insert(
	data.raw["technology"]["nuclear-fuel-reprocessing"].effects,
	{type = "unlock-recipe", recipe = "mox-fuel-reprocessing"}
)


--Kovarex enrichment process
table.insert(
	data.raw["technology"]["kovarex-enrichment-process"].effects,
	{type = "unlock-recipe", recipe = "nuclear-fuel-from-Pu-239"}
)
--[[
data.raw["technology"]["kovarex-enrichment-process"].icon = "__nuclear-fuel-cycle__/graphics/technology/kovarex-enrichment-process.png"
data.raw["technology"]["kovarex-enrichment-process"].localised_name = {"technology-name.kovarex-enrichment-process"}
--]]


--Atomic bomb
data.raw["technology"]["atomic-bomb"].prerequisites = {"uranium-processing"}


data:extend({
	{
		type = "technology",
		name = "breeder-reactor",
		icon_size = 128,
		icon = "__nuclear-fuel-cycle__/graphics/technology/breeder-reactor.png",
		effects =
		{
			{
				type = "unlock-recipe",
				recipe = "breeder-fuel-cell-from-U-235"
			},
			{
				type = "unlock-recipe",
				recipe = "breeder-fuel-cell-from-Pu-239"
			},
			{
				type = "unlock-recipe",
				recipe = "breeder-fuel-reprocessing"
			}
		},
		prerequisites = {"nuclear-power"},
		unit =
		{
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1}
			},
			time = 30,
			count = 650
		},
		order = "e-p-b-c"
	}
})