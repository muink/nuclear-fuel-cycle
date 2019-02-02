
DEBUG_PROTOTYPES = false

require("lualib.functions")

require("config")

require("prototypes.categories.fuel-category")

require("prototypes.items.item-groups")
require("prototypes.items.items")

require("prototypes.recipes.processing")
require("prototypes.recipes.fuel-cell")
require("prototypes.recipes.nuclear-fuel")
require("prototypes.recipes.atomic-bombs")

require("prototypes.technology.technology")

if MULTICOLOR_REACTOR then
	require("colors")


	require("prototypes.items.reactor-mask")

	require("prototypes.entity.reactor-mask")
end
	