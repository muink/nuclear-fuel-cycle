
colors = {normal={}, red={}, orangered={}, orange={}, yelloworange={}, yellow={}, yellowgreen={}, green={}, cyan={}, blue={}}

--entity subgroup
data:extend({
	{
		type = "item-subgroup",
		name = "reactor-mask",
		group = "other",
		order = "b"
	}
})


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

--red
colors.red = {
	subgroup = "reactor-mask",
	order = "b-a-a[red]",
	item_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-red.png", size = 32},
	entity_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-red.png", size = 32},
	entity_light_img = {img = "__nuclear-fuel-cycle__/graphics/entity/reactor-lights-color-red.png", width = 160, height = 160},
	entity_light_hrimg = {img = "__nuclear-fuel-cycle__/graphics/entity/hr-reactor-lights-color-red.png", width = 320, height = 320, scale = 0.5},
	entity_glow = {intensity = 0.6, size = 11, shift = {0.0, 0.0}, color = {r = 1.0, g = 0.0, b = 0.0}}
}

--orangered
colors.orangered = {
	subgroup = "reactor-mask",
	order = "b-a-b[orangered]",
	item_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-orangered.png", size = 32},
	entity_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-orangered.png", size = 32},
	entity_light_img = {img = "__nuclear-fuel-cycle__/graphics/entity/reactor-lights-color-orangered.png", width = 160, height = 160},
	entity_light_hrimg = {img = "__nuclear-fuel-cycle__/graphics/entity/hr-reactor-lights-color-orangered.png", width = 320, height = 320, scale = 0.5},
	entity_glow = {intensity = 0.7, size = 11, shift = {0.0, 0.0}, color = {r = 0.88, g = 0.24, b = 0.0}}
}

--orange
colors.orange = {
	subgroup = "reactor-mask",
	order = "b-b-a[orange]",
	item_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-orange.png", size = 32},
	entity_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-orange.png", size = 32},
	entity_light_img = {img = "__nuclear-fuel-cycle__/graphics/entity/reactor-lights-color-orange.png", width = 160, height = 160},
	entity_light_hrimg = {img = "__nuclear-fuel-cycle__/graphics/entity/hr-reactor-lights-color-orange.png", width = 320, height = 320, scale = 0.5},
	entity_glow = {intensity = 0.8, size = 11, shift = {0.0, 0.0}, color = {r = 1.0, g = 0.5, b = 0.0}}
}

--yelloworange
colors.yelloworange = {
	subgroup = "reactor-mask",
	order = "b-b-b[yelloworange]",
	item_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-yelloworange.png", size = 32},
	entity_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-yelloworange.png", size = 32},
	entity_light_img = {img = "__nuclear-fuel-cycle__/graphics/entity/reactor-lights-color-yelloworange.png", width = 160, height = 160},
	entity_light_hrimg = {img = "__nuclear-fuel-cycle__/graphics/entity/hr-reactor-lights-color-yelloworange.png", width = 320, height = 320, scale = 0.5},
	entity_glow = {intensity = 0.6, size = 11, shift = {0.0, 0.0}, color = {r = 1.0, g = 0.65, b = 0.0}}
}

--yellow
colors.yellow = {
	subgroup = "reactor-mask",
	order = "b-c-a[yellow]",
	item_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-yellow.png", size = 32},
	entity_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-yellow.png", size = 32},
	entity_light_img = {img = "__nuclear-fuel-cycle__/graphics/entity/reactor-lights-color-yellow.png", width = 160, height = 160},
	entity_light_hrimg = {img = "__nuclear-fuel-cycle__/graphics/entity/hr-reactor-lights-color-yellow.png", width = 320, height = 320, scale = 0.5},
	entity_glow = {intensity = 0.6, size = 9.9, shift = {0.0, 0.0}, color = {r = 1.0, g = 0.8, b = 0.0}}
}

--yellowgreen
colors.yellowgreen = {
	subgroup = "reactor-mask",
	order = "b-c-b[yellowgreen]",
	item_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-yellowgreen.png", size = 32},
	entity_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-yellowgreen.png", size = 32},
	entity_light_img = {img = "__nuclear-fuel-cycle__/graphics/entity/reactor-lights-color-yellowgreen.png", width = 160, height = 160},
	entity_light_hrimg = {img = "__nuclear-fuel-cycle__/graphics/entity/hr-reactor-lights-color-yellowgreen.png", width = 320, height = 320, scale = 0.5},
	entity_glow = {intensity = 0.6, size = 9.9, shift = {0.0, 0.0}, color = {r = 0.75, g = 1.0, b = 0.0}}
}

--green
colors.green = {
	subgroup = "reactor-mask",
	order = "b-d-a[green]",
	item_icon = {icon = "__base__/graphics/icons/nuclear-reactor.png", size = 32},
	entity_icon = {icon = "__base__/graphics/icons/nuclear-reactor.png", size = 32},
	entity_light_img = {img = "__base__/graphics/entity/nuclear-reactor/reactor-lights-color.png", width = 160, height = 160},
	entity_light_hrimg = {img = "__base__/graphics/entity/nuclear-reactor/hr-reactor-lights-color.png", width = 320, height = 320, scale = 0.5},
	entity_glow = {intensity = 0.6, size = 9.9, shift = {0.0, 0.0}, color = {r = 0.0, g = 1.0, b = 0.0}}
}

--cyan
colors.cyan = {
	subgroup = "reactor-mask",
	order = "b-e-a[cyan]",
	item_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-cyan.png", size = 32},
	entity_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-cyan.png", size = 32},
	entity_light_img = {img = "__nuclear-fuel-cycle__/graphics/entity/reactor-lights-color-cyan.png", width = 160, height = 160},
	entity_light_hrimg = {img = "__nuclear-fuel-cycle__/graphics/entity/hr-reactor-lights-color-cyan.png", width = 320, height = 320, scale = 0.5},
	entity_glow = {intensity = 0.6, size = 9.9, shift = {0.0, 0.0}, color = {r = 0.0, g = 1.0, b = 0.94}}
}

--blue
colors.blue = {
	subgroup = "reactor-mask",
	order = "b-f-a[blue]",
	item_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-blue.png", size = 32},
	entity_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-blue.png", size = 32},
	entity_light_img = {img = "__nuclear-fuel-cycle__/graphics/entity/reactor-lights-color-blue.png", width = 160, height = 160},
	entity_light_hrimg = {img = "__nuclear-fuel-cycle__/graphics/entity/hr-reactor-lights-color-blue.png", width = 320, height = 320, scale = 0.5},
	entity_glow = {intensity = 0.8, size = 9.9, shift = {0.0, 0.0}, color = {r = 0.0, g = 0.65, b = 0.94}}
}
