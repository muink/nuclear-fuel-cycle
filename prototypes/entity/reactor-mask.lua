
reactor_origin_copy = table.deepcopy(data.raw.reactor["nuclear-reactor"])


--vanilla reactor
data.raw.reactor["nuclear-reactor"].working_light_picture = {
	filename = "__nuclear-fuel-cycle__/graphics/black32.png",
	width = 32,
	height = 32,
	blend_mode = "additive"
}
data.raw.reactor["nuclear-reactor"].light.color = {}
data.raw.reactor["nuclear-reactor"].working_sound = {
	sound = {filename = "__base__/sound/idle1.ogg", volume = 0.6},
	apparent_volume = 1.5
}


reactor_mask_normal = table.deepcopy(reactor_origin_copy)
	reactor_mask_normal.name = "nuclear-reactor-mask-normal"
	reactor_mask_normal.icon = colors["normal"].entity_icon.icon
	reactor_mask_normal.flags = {"placeable-neutral", "player-creation", "placeable-off-grid", "not-blueprintable", "not-deconstructable", "not-on-map", "hide-alt-info"}
	reactor_mask_normal.subgroup = colors["normal"].subgroup
	reactor_mask_normal.order = colors["normal"].order
	--reactor_mask_normal.placeable_by = {item="nuclear-reactor", count = 1}
	reactor_mask_normal.minable = nil
	if DEBUG_PROTOTYPES then reactor_mask_normal.minable = {mining_time = 1.5, result = nil} end
	reactor_mask_normal.consumption = "1W"
	reactor_mask_normal.energy_source.fuel_category = "fake-nuclear"
	reactor_mask_normal.working_sound = {
		sound = {filename = "__nuclear-fuel-cycle__/sound/reactor-active.ogg", volume = 0.6},
		apparent_volume = 1.5,
		audible_distance_modifier = 1
	}
	reactor_mask_normal.lower_layer_picture = nil
	reactor_mask_normal.picture.layers[2] = nil
	reactor_mask_normal.connection_patches_connected.filename = "__nuclear-fuel-cycle__/graphics/transparent32.png"
	reactor_mask_normal.connection_patches_connected.hr_version = nil
	reactor_mask_normal.connection_patches_disconnected.filename = "__nuclear-fuel-cycle__/graphics/transparent32.png"
	reactor_mask_normal.connection_patches_disconnected.hr_version = nil
	reactor_mask_normal.connection_patches = nil
	reactor_mask_normal.heat_buffer.connections = {}
	reactor_mask_normal.collision_box = {util.by_pixel(-10,-10), util.by_pixel(10,10)}
	reactor_mask_normal.selection_box = {{-0.5, -0.5}, {0.5, 0.5}}
	reactor_mask_normal.collision_mask = {"layer-11"}
	reactor_mask_normal.selectable_in_game = DEBUG_PROTOTYPES
	reactor_mask_normal.meltdown_action = nil
	reactor_mask_normal.fast_replaceable_group = "nuclear-reactor-mask"


for key in pairs(colors) do
	mask = table.deepcopy(reactor_mask_normal)
		mask.name = "nuclear-reactor-mask-" .. key
		mask.icon = colors[key].entity_icon.icon
		mask.subgroup = colors[key].subgroup
		mask.order = colors[key].order
		mask.working_light_picture.filename = colors[key].entity_light_img.img
		mask.working_light_picture.hr_version.filename = colors[key].entity_light_hrimg.img
		mask.light = colors[key].entity_glow
	data:extend({mask})
end
