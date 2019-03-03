-- Reload recipes and technologies
for index, force in pairs(game.forces) do
	force.reset_recipes()
	force.reset_technologies()

	-- Generate technology and recipe tables
	local tech = force.technologies
	local recipes = force.recipes

	-- Unlock researched recipes
	if tech["atomic-bomb"].researched then
		recipes["atomic-bomb-from-WGPu-239"].enabled = true
	end
	if tech["kovarex-enrichment-process"].researched then
		recipes["nuclear-fuel-from-WGPu-239"].enabled = true
	end
	if tech["nuclear-fuel-reprocessing"].researched then
		recipes["plutonium-purification-process"].enabled = true
		recipes["mox-fuel-cell-from-RGPu-239"].enabled = true
		recipes["mox-fuel-cell-from-WGPu-239"].enabled = true
		recipes["mox-fuel-reprocessing"].enabled = true
	end
	force.print({"message.head", {"message.tech-migration", "0.1.0"}}, {r=1,g=0.75,b=0,a=1})
end