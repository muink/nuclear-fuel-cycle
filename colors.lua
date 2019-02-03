
--for control.lua runtime
colors = {normal={}, red={}, orangered={}, orange={}, yelloworange={}, yellow={}, yellowgreen={}, green={}, cyan={}, blue={}}
fuel_glow = {uranium_fuel_cell = "normal", mox_fuel_cell = "yellow", breeder_fuel_cell = "orange"}


--for data stage
if data and data.raw then

--entity subgroup
data:extend({
	{
		type = "item-subgroup",
		name = "reactor-mask",
		group = "other",
		order = "b"
	}
})


for key in pairs(colors) do
	colors[key] = {
		subgroup = "reactor-mask",
		order = "b",
		item_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-" .. key .. ".png", size = 32},
		entity_icon = {icon = "__nuclear-fuel-cycle__/graphics/icons/nuclear-reactor-" .. key .. ".png", size = 32},
		entity_light_img = {img = "__nuclear-fuel-cycle__/graphics/entity/reactor-lights-color-" .. key .. ".png", width = 160, height = 160},
		entity_light_hrimg = {img = "__nuclear-fuel-cycle__/graphics/entity/hr-reactor-lights-color-" .. key .. ".png", width = 320, height = 320, scale = 0.5},
		entity_glow = {intensity = 0.6, size = 11, shift = {0.0, 0.0}, color = {r = 1.0, g = 1.0, b = 1.0}}
	}
end


--normal
colors["normal"] = {
	subgroup = "reactor-mask",
	order = "a[normal]",
	item_icon = {icon = data.raw.item["nuclear-reactor"].icon, size = 32},
	entity_icon = {icon = data.raw.item["nuclear-reactor"].icon, size = 32},
	entity_light_img = {img = data.raw.reactor["nuclear-reactor"].working_light_picture.filename, width = 160, height = 160},
	entity_light_hrimg = {img = data.raw.reactor["nuclear-reactor"].working_light_picture.hr_version.filename, width = 320, height = 320, scale = 0.5},
	entity_glow = table.deepcopy(data.raw.reactor["nuclear-reactor"].light)
}

else
--for control.lua runtime
	colors["normal"].order = "a[normal]"
	colors["normal"].entity_glow = {intensity = 0.6, size = 11, shift = {0.0, 0.0}, color = {r = 1.0, g = 1.0, b = 1.0}}
end


--for control.lua runtime

--red
colors["red"].order = "b-a-a[red]"
colors["red"].entity_glow = {intensity = 0.6, size = 11, shift = {0.0, 0.0}, color = {r = 1.0, g = 0.0, b = 0.0}}

--orangered
colors["orangered"].order = "b-a-b[orangered]"
colors["orangered"].entity_glow = {intensity = 0.7, size = 11, shift = {0.0, 0.0}, color = {r = 0.88, g = 0.24, b = 0.0}}

--orange
colors["orange"].order = "b-b-a[orange]"
colors["orange"].entity_glow = {intensity = 0.8, size = 11, shift = {0.0, 0.0}, color = {r = 1.0, g = 0.5, b = 0.0}}

--yelloworange
colors["yelloworange"].order = "b-b-b[yelloworange]"
colors["yelloworange"].entity_glow = {intensity = 0.6, size = 11, shift = {0.0, 0.0}, color = {r = 1.0, g = 0.7, b = 0.0}}

--yellow
colors["yellow"].order = "b-c-a[yellow]"
colors["yellow"].entity_glow = {intensity = 0.6, size = 9.9, shift = {0.0, 0.0}, color = {r = 1.0, g = 0.9, b = 0.0}}

--yellowgreen
colors["yellowgreen"].order = "b-c-b[yellowgreen]"
colors["yellowgreen"].entity_glow = {intensity = 0.6, size = 9.9, shift = {0.0, 0.0}, color = {r = 0.75, g = 1.0, b = 0.0}}

--green
colors["green"].order = "b-d-a[green]"
colors["green"].item_icon = {icon = "__base__/graphics/icons/nuclear-reactor.png", size = 32}
colors["green"].entity_icon = {icon = "__base__/graphics/icons/nuclear-reactor.png", size = 32}
colors["green"].entity_light_img = {img = "__base__/graphics/entity/nuclear-reactor/reactor-lights-color.png", width = 160, height = 160}
colors["green"].entity_light_hrimg = {img = "__base__/graphics/entity/nuclear-reactor/hr-reactor-lights-color.png", width = 320, height = 320, scale = 0.5}
colors["green"].entity_glow = {intensity = 0.6, size = 9.9, shift = {0.0, 0.0}, color = {r = 0.0, g = 1.0, b = 0.0}}

--cyan
colors["cyan"].order = "b-e-a[cyan]"
colors["cyan"].entity_glow = {intensity = 0.6, size = 9.9, shift = {0.0, 0.0}, color = {r = 0.0, g = 1.0, b = 0.94}}

--blue
colors["blue"].order = "b-f-a[blue]"
colors["blue"].entity_glow = {intensity = 0.8, size = 9.9, shift = {0.0, 0.0}, color = {r = 0.0, g = 0.65, b = 0.94}}
