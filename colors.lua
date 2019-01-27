
--entity subgroup
data:extend({
	{
		type = "item-subgroup",
		name = "reactor-mask",
		group = "other",
		order = "b"
	}
})

colors = {normal={}, green={}, yellow={}, orange={}}

--normal
colors.normal = {
	subgroup = "reactor-mask",
	order = "a[normal]",
	item_icon = {icon = data.raw.item["nuclear-reactor"].icon, size = 32},
	entity_icon = {icon = data.raw.item["nuclear-reactor"].icon, size = 32},
	entity_light_img = {img = data.raw.reactor["nuclear-reactor"].working_light_picture.filename, width = 160, height = 160},
	entity_light_hrimg = {img = data.raw.reactor["nuclear-reactor"].working_light_picture.hr_version.filename, width = 320, height = 320, scale = 0.5},
	entity_glow = table.deepcopy(data.raw.reactor["nuclear-reactor"].light)
}

--green
colors.green = {
	subgroup = "reactor-mask",
	order = "b[green]",
	item_icon = {icon = "__base__/graphics/icons/nuclear-reactor.png", size = 32},
	entity_icon = {icon = "__base__/graphics/icons/nuclear-reactor.png", size = 32},
	entity_light_img = {img = "__base__/graphics/entity/nuclear-reactor/reactor-lights-color.png", width = 160, height = 160},
	entity_light_hrimg = {img = "__base__/graphics/entity/nuclear-reactor/hr-reactor-lights-color.png", width = 320, height = 320, scale = 0.5},
	entity_glow = {intensity = 0.6, size = 9.9, shift = {0.0, 0.0}, color = {r = 0.0, g = 1.0, b = 0.0}}
}

--yellow
colors.yellow = {
	subgroup = "reactor-mask",
	order = "b[yellow]",
	item_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-yellow.png", size = 32},
	entity_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-yellow.png", size = 32},
	entity_light_img = {img = "__nuclear-fuel-cycle__/graphics/entity/reactor-lights-color-yellow.png", width = 160, height = 160},
	entity_light_hrimg = {img = "__nuclear-fuel-cycle__/graphics/entity/hr-reactor-lights-color-yellow.png", width = 320, height = 320, scale = 0.5},
	entity_glow = {intensity = 0.6, size = 9.9, shift = {0.0, 0.0}, color = {r = 1.0, g = 0.8, b = 0.0}}
}

--orange
colors.orange = {
	subgroup = "reactor-mask",
	order = "b[orange]",
	item_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-orange.png", size = 32},
	entity_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-orange.png", size = 32},
	entity_light_img = {img = "__nuclear-fuel-cycle__/graphics/entity/reactor-lights-color-orange.png", width = 160, height = 160},
	entity_light_hrimg = {img = "__nuclear-fuel-cycle__/graphics/entity/hr-reactor-lights-color-orange.png", width = 320, height = 320, scale = 0.5},
	entity_glow = {intensity = 0.8, size = 11, shift = {0.0, 0.0}, color = {r = 1.0, g = 0.5, b = 0.0}}
}
