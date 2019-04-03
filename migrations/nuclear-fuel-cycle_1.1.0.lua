-- Reload recipes and technologies
for _, force in pairs(game.forces) do
	force.reset_recipes()
	force.reset_technologies()

	-- Generate technology and recipe tables
	local tech = force.technologies
	local recipes = force.recipes

	-- Unlock researched recipes
	if tech["atomic-bomb"].researched then
		recipes["atomic-bomb-from-Pu-239"].enabled = true
	end
	if tech["kovarex-enrichment-process"].researched then
		recipes["nuclear-fuel-from-Pu-239"].enabled = true
	end
	if tech["nuclear-fuel-reprocessing"].researched then
		recipes["plutonium-purification-process"].enabled = true
		recipes["mox-fuel-cell-from-RGPu-239"].enabled = true
		recipes["mox-fuel-cell-from-Pu-239"].enabled = true
		recipes["mox-fuel-reprocessing"].enabled = true
	end
	if tech["breeder-reactor"].researched then
		recipes["breeder-fuel-cell-from-Pu-239"].enabled = true
	end
	force.print({"message.head", {"message.tech-migration", "1.1.0"}}, {r=1,g=0.75,b=0,a=1})
end