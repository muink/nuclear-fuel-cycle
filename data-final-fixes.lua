
--For PickerTweaks's Realistic Reactor Glow
if MULTICOLOR_REACTOR then
	--mask-normal
	data.raw.reactor["nuclear-reactor-mask-normal"].working_light_picture.filename = data.raw.reactor["nuclear-reactor"].working_light_picture.filename
	data.raw.reactor["nuclear-reactor-mask-normal"].working_light_picture.hr_version.filename = data.raw.reactor["nuclear-reactor"].working_light_picture.hr_version.filename
	data.raw.reactor["nuclear-reactor-mask-normal"].light = table.deepcopy(data.raw.reactor["nuclear-reactor"].light)
	
	--vanilla reactor
	data.raw.reactor["nuclear-reactor"].working_light_picture = {
		filename = "__nuclear-fuel-cycle__/graphics/black32.png",
		width = 32,
		height = 32,
		blend_mode = "additive"
	}
	data.raw.reactor["nuclear-reactor"].light.color = {}
	data.raw.reactor["nuclear-reactor"].energy_source.light_flicker.color = {}
end
