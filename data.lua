
if not nuclear_fuel_cycle then nuclear_fuel_cycle = {} end
if not nuclear_fuel_cycle.lib then nuclear_fuel_cycle.lib = {} end


require("libs.functions")


require("prototypes.items.item-groups")
require("prototypes.items.items")

require("prototypes.recipes.processing")
require("prototypes.recipes.fuel-cell")
require("prototypes.recipes.nuclear-fuel")
require("prototypes.recipes.atomic-bombs")

require("prototypes.technology.technology")