
--items for multicolor reactor mask
if MULTICOLOR_REACTOR and DEBUG_PROTOTYPES then
	origin = data.raw.item["nuclear-reactor"]

	for key in pairs(colors) do
		item = table.deepcopy(origin)
			item.name = "nuclear-reactor-mask-" .. key
			item.icon = colors[key].item_icon.icon
			item.flags = {"goes-to-main-inventory", "hidden"}
			item.subgroup = colors[key].subgroup
			item.order = colors[key].order
			item.place_result = "nuclear-reactor-mask-" .. key
		data:extend({item})
	end
end

data:extend({
	{
		type = "item",
		name = "fake-fuel-cell",
		icon = "__base__/graphics/icons/used-up-uranium-fuel-cell.png",
		icon_size = 32,
		flags = {"goes-to-main-inventory", "hidden"},
		subgroup = "reactor-mask",
		order = "a[fuel-cell]",
		fuel_category = "nuclear",
		burnt_result = nil,
		fuel_value = "10GJ",
		stack_size = 50
	}
})
