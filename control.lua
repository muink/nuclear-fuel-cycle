--[[Init Block]]--
--------------------------------

--startup
local EXACTING_MODE = settings.startup["nuclear-fuel-cycle_exacting-mode"].value

--runing
local MINING_LIMIT
local POLLUTION_MULTIPLIER
local DESTRUCTION_POLLUTION
local CRITICAL_TEMPERATURE
--------
local DEBUG_INFO = false
local FULL_UPDATE_INTERVAL = 40 --full update cycle, lowering this value increases performance overhead
local PER_TICK_REACTOR_CONSUMPTION = 40*1e+6/60

--events
local e=defines.events
local built_events = {e.on_built_entity, e.on_robot_built_entity}
local mining_events = {e.on_pre_player_mined_item, e.on_robot_pre_mined} --after finishes mining an entity before results are collected
local mined_events = {e.on_player_mined_entity, e.on_robot_mined_entity} --after results are collected before entity is destroyed
local mineditem_events = {e.on_player_mined_item, e.on_robot_mined} --at result items given to the player/robot
local died_events = {e.on_entity_died}
local surface_del_events = {e.on_pre_surface_deleted} --before surface is deleted



--[[Sub function Block]]--
--------------------------------

local math_floor = math.floor
local math_ceil = math.ceil
local math_modf = math.modf

local function load_settings()
	MINING_LIMIT = settings.global["nuclear-fuel-cycle_mining-limit"].value
	POLLUTION_MULTIPLIER = settings.global["nuclear-fuel-cycle_pollution-multiplier"].value
	DESTRUCTION_POLLUTION = settings.global["nuclear-fuel-cycle_destruction-pollution"].value
	CRITICAL_TEMPERATURE = settings.global["nuclear-fuel-cycle_critical-temperature"].value
	DEBUG_INFO = settings.global["nuclear-fuel-cycle_debug_mode"].value
end

local function debug_log(...)
	if DEBUG_INFO then game.print(...) end
end

--reactor running? and remaining burning fuel value?
local function reactor_runing_status(reactor)
	--return NOT running or BURNED fuel value
	return reactor.burner.remaining_burning_fuel > 0 and reactor.burner.currently_burning.fuel_value - reactor.burner.remaining_burning_fuel, reactor.burner.remaining_burning_fuel > 0 and reactor.burner.currently_burning.fuel_value
end

local function table_length(tab)
	if tab == nil then
		return 0
	else
		local count = 0
		for _ in pairs(tab) do count = count + 1 end
		return count	
	end
end

local function table_status_refresh()
	--refresh reactor count
	local reactors = global.reactors
	global.count = table_length(reactors)

	--refresh update parameter
	local reactor_count = global.count
	global.update_interval = math_ceil(FULL_UPDATE_INTERVAL/reactor_count)
	local a = math_floor(reactor_count/FULL_UPDATE_INTERVAL + 0.5)
	if a == 0 then a=1 end
	global.update_intensity = a
end



--[[Main Events function Block]]--
--------------------------------

--called when an reactor entity is destruction
local function died(event)
	local entity = event.entity
	if entity.type == "reactor" then
		debug_log("Find a reactor has been died.")
		local id = entity.unit_number
		if reactor_runing_status(entity) then
			debug_log("Find an active reactor has been died.")
			--[[
			game.print(entity.surface.create_entity{
				name = "logistic-chest-requester",
				position = entity.position,
				force = entity.force,
				request_filters = {
					{index = 1, name = "iron-plate", count = reactor_runing_status(entity)}
				}
			}.unit_number)
			--]]

			--create destruction pollution
			if DESTRUCTION_POLLUTION then
				debug_log("Destroyed pollution has released.")
				--the value of fuel has been burned
				local burned_fuel=math_modf(reactor_runing_status(entity)/1e+6)
				entity.surface.pollute(entity.position, burned_fuel * POLLUTION_MULTIPLIER)
				debug_log("destroyed pollution: " .. burned_fuel * POLLUTION_MULTIPLIER, {r=1,g=0.25,b=0,a=1})
			end
		end
		global.reactors[id] = nil
		table_status_refresh()
	end
end

--[[
--called when mines entity
local function mineditem(event)
	local item = event.item_stack
	debug_log{"", game.item_prototypes[item.name].localised_name, " given to the player/robot."}
end
--]]

--called when an reactor entity is mined
local function mined(event)
	local entity = event.entity
	if entity.type == "reactor" then
		debug_log("Remove reactor from table")
		local id = entity.unit_number
		--if entity.die() then debug_log "kill the entity before destroyed." end --result items will be collect, corpse will generate
		global.reactors[id] = nil
		table_status_refresh()
	end
end

--[[
--called when mining an reactor entity
local function mining(event)
	local entity = event.entity
	if entity.type == "reactor" then
		local id = entity.unit_number
		if MINING_LIMIT and reactor_runing_status(entity) then
			--to limit mining
			entity.minable = false
			return
		end
		--if entity.die() then debug_log "kill the entity before results are collected." end --result items will not be collect, corpse will generate
		global.reactors[id] = nil
	end
end
--]]

--called when an reactor entity is build
local function built(event)
	local entity = event.created_entity
	if entity.type == "reactor" then
		debug_log("Add reactor to table")
		local id = entity.unit_number
		global.reactors[id] = {reactor = entity, last_burned = false}
		table_status_refresh()
	end
end

local function surface_del(event)
	local index = event.surface_index
	local surface = game.surfaces[index]
	local reactors = surface.find_entities_filtered{type="reactor"}
	for i=1, #reactors do
		local id = reactors[i].unit_number
		global.reactors[id] = nil
	end
	debug_log("The surface #" .. index .. ": \"" .. surface.name .. "\" is deleted")
	debug_log("Remove " ..  #reactors .. " reactors of this surface from table")
	table_status_refresh()
end

local function setup_global()
	game.print({"message.exacting-mode-enabled"}, {r=1,g=1,b=0,a=1})
	--setup the global reactors table to store reactor entity data
	global = {reactors = {}, index = nil, count = 0, update_interval = 40, update_intensity = 1, tab_refresh_interval = 0}

	--traverse all surface on map to find all nuclear reactors
	--[[
	for _, surface in pairs(game.surfaces) do
		for _, reactor in pairs(surface.find_entities_filtered{type="reactor"}) do
			built({created_entity = reactor})
		end
	end
	--]]
	--a version that enhances performance
	local surfaces = game.surfaces
	for i=1, #surfaces do
		local reactors = surfaces[i].find_entities_filtered{type="reactor"}
		for i=1, #reactors do
			local reactor = reactors[i]
			built({created_entity = reactor})
		end
	end
	table_status_refresh()
end

local function on_tick(event)
	local tick = event.tick
	local reactors = global.reactors
	--table status
	local reactor_count = global.count
	local update_interval = global.update_interval
	local update_intensity = global.update_intensity
	local tab_refresh_interval = global.tab_refresh_interval

	if reactor_count > 0 and tick % update_interval == 0 then
		--debug_log("update_interval: " .. update_interval)

		local next = _G.next --https://springrts.com/wiki/Lua_Performance
		local index, data = global.index, nil

		--debug_log("update_intensity: " .. update_intensity)
		repeat
			::redo::
			if index and reactors[index] then
				data = reactors[index]
			else
				index, data = next(reactors, index)
				if not data then break end
			end
			local reactor = data.reactor

			if reactor.valid then
				--mining limit
				if MINING_LIMIT and reactor_runing_status(reactor) then
					--cancel deconstruction when reactor is running and MINING_LIMIT = true
					if reactor.to_be_deconstructed(reactor.force) then
						reactor.cancel_deconstruction(reactor.force)
						debug_log("Cancel deconstruction")
					end
					reactor.minable = false
				else
					reactor.minable = true
				end
			else
				--for entity destroyed by destroy()
				reactors[index] = nil
				debug_log("Removed an invalid reactor entity")
				goto redo
			end
			index = next(reactors, index)
			update_intensity = update_intensity - 1
		until(update_intensity <= 0)

		global.index = index

		--refresh table status on every FULL_UPDATE_INTERVAL
		tab_refresh_interval = tab_refresh_interval + update_interval
		if tab_refresh_interval >= FULL_UPDATE_INTERVAL*3 then
			debug_log("reactor count: " .. reactor_count, {r=1,g=1,b=0,a=1})
			table_status_refresh()
			global.tab_refresh_interval = 0 --reset tab_refresh_interval
		else
			global.tab_refresh_interval = tab_refresh_interval
		end
	end
end



--[[Main Block]]--
--------------------------------

load_settings()

if EXACTING_MODE then

--setup event handler
script.on_init(setup_global)
script.on_configuration_changed(setup_global)
script.on_event(e.on_runtime_mod_setting_changed, load_settings)

--main
script.on_event(defines.events.on_tick, on_tick)

--all game build/remove events handler
script.on_event(built_events, built)
--script.on_event(mining_events, mining)
script.on_event(mined_events, mined)
--script.on_event(mineditem_events, mineditem)
script.on_event(died_events, died)
script.on_event(surface_del_events, surface_del)

end