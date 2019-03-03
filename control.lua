--[[Init Block]]--
--------------------------------
require("lualib.mathbit")
require("colors")

--startup
local EXACTING_MODE = settings.startup["nuclear-fuel-cycle_exacting-mode"].value
local MULTICOLOR_REACTOR = settings.startup["nuclear-fuel-cycle_multicolor-reactor"].value

--runing
local MINING_LIMIT
local POLLUTION_MULTIPLIER
local DESTRUCTION_POLLUTION
local CRITICAL_TEMPERATURE
local CORE_MELTDOWN_TYPE
	local CRITICAL_DAMAGE
	local FIRE_STRENGTH
local CRITICAL_POLLUTION
--------
local DEBUG = false
local DEBUG_INFO = false
local FULL_UPDATE_INTERVAL = 40 --full update cycle, lowering this value increases performance overhead
local SAFE_FULL_UPDATE_INTERVAL = FULL_UPDATE_INTERVAL*3
local PER_TICK_REACTOR_CONSUMPTION = 40*1e+6/60
local FIRE_RADIUS_MIN = 1.5 --4.5
local FIRE_RADIUS_MAX = 6

--events
local e=defines.events
local built_events = {e.on_built_entity, e.on_robot_built_entity}
local mining_events = {e.on_pre_player_mined_item, e.on_robot_pre_mined} --after finishes mining an entity before results are collected
local mined_events = {e.on_player_mined_entity, e.on_robot_mined_entity} --after results are collected before entity is destroyed
local mineditem_events = {e.on_player_mined_item, e.on_robot_mined} --at result items given to the player/robot
local died_events = {e.on_entity_died}
local surface_del_events = {e.on_pre_surface_deleted} --before surface is deleted
local player_created_events = {e.on_player_created}



--[[Sub function Block]]--
--------------------------------

local math_floor = math.floor
local math_ceil = math.ceil
local math_modf = math.modf
local math_pi = math.pi
local math_randomseed = math.randomseed
local math_random = math.random
local math_cos = math.cos
local math_sin = math.sin

local function reset_reactor_control()
	global.reload_phase = SAFE_FULL_UPDATE_INTERVAL
end

local function load_settings()
	MINING_LIMIT = settings.global["nuclear-fuel-cycle_mining-limit"].value
	POLLUTION_MULTIPLIER = settings.global["nuclear-fuel-cycle_pollution-multiplier"].value
	DESTRUCTION_POLLUTION = settings.global["nuclear-fuel-cycle_destruction-pollution"].value
	CRITICAL_TEMPERATURE = settings.global["nuclear-fuel-cycle_critical-temperature"].value
	CORE_MELTDOWN_TYPE = function()
		local type = settings.global["nuclear-fuel-cycle_core-meltdown-type"].value
		if type == "off" then return 0 end
		if type == "overheat-damage" then return 1 end
		if type == "fire" then return 2 end
		if type == "both" then return 3 end
	end
	CRITICAL_DAMAGE = settings.global["nuclear-fuel-cycle_critical-damage"].value/60*FULL_UPDATE_INTERVAL
	FIRE_STRENGTH = settings.global["nuclear-fuel-cycle_fire-strength"].value
	CRITICAL_POLLUTION = settings.global["nuclear-fuel-cycle_critical-pollution"].value
	DEBUG_INFO = settings.global["nuclear-fuel-cycle_debug_mode"].value
	reset_reactor_control()
end

local function debug_log(...)
	if DEBUG_INFO then game.print(...) end
end

local function setting_changed_notification(caller)
	if EXACTING_MODE then caller.print({"message.head", {"message.exacting-mode-enabled"}}, {r=1,g=1,b=0,a=1}) end
	if MULTICOLOR_REACTOR then caller.print({"message.head", {"message.multicolor-reactor-enabled"}}, {r=1,g=1,b=0,a=1}) end
end

--reactor running? and remaining burning fuel value?
local function reactor_runing_status(reactor)
	--return NOT running or BURNED fuel value and fuel_value of current fuel cell and name of current fuel cell
	return reactor.burner.remaining_burning_fuel > 0 and reactor.burner.currently_burning.fuel_value - reactor.burner.remaining_burning_fuel, reactor.burner.remaining_burning_fuel > 0 and reactor.burner.currently_burning.fuel_value, reactor.burner.remaining_burning_fuel > 0 and reactor.burner.currently_burning.name
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



--[[Reactor control function Block]]--
--------------------------------

--delete reactor record from table
local function delete_reactor(unit_number)
	--remove mask entity
	local mask = global.reactors[unit_number].mask
	if mask.valid and string.match(mask.name, "nuclear%-reactor%-mask%-.+") then mask.destroy() end
	--delete FULL reactor record
	global.reactors[unit_number] = nil
end

--remove all mask on all surface
local function remove_all_mask()
	local surfaces = game.surfaces
	for key in pairs(colors) do
		for i=1, #surfaces do
			local masks = surfaces[i].find_entities_filtered{name="nuclear-reactor-mask-" .. key}
			--remove mask
			for i=1, #masks do masks[i].destroy() end
		end
	end
	debug_log("Remove all mask entities")
end

--generate reactor mask
local function gen_mask(data, color)
	local color = color or "normal"
	local reactor = data.reactor
	local mask = data.mask

	--generate mask
	debug_log("Mask generated: \"" .. color .. "\"", colors[color].entity_glow.color)
	data.mask = reactor.surface.create_entity{name = "nuclear-reactor-mask-" .. color, position = reactor.position, force = reactor.force, fast_replace = true, spill = false}
	mask = data.mask
	--mask.minable = false
	mask.destructible = false
	--mask.active = false
	--mask.operable = false --Disable interface open
	mask.insert({name = "fake-fuel-cell", count = 5000})
	data.mask_off_time = "on"
end

--pick and place mask
local function pick_and_place_mask(data, fuel_name)
	local reactor = data.reactor

	if fuel_name then
		gen_mask(data, fuel_glow[(string.gsub(fuel_name, "-", "_"))])
		--set fuel name
		data.last_fuel_name = fuel_name
	end
end

local function mask_status_control(data)
	local reactor = data.reactor
	local mask = data.mask
	local last_fuel_name = data.last_fuel_name
	local _mask = mask.valid
	local mask_off_time = data.mask_off_time
	local _, _, current_fuel_name = reactor_runing_status(reactor)
	if _mask and string.match(mask.name, "nuclear%-reactor%-mask%-.+") then _mask = true else _mask = false end

	if current_fuel_name then
	--fuel inventory is not empty

		if _mask then
			if current_fuel_name == last_fuel_name then
				local rx, ry = reactor.position.x, reactor.position.y
				local mx, my = mask.position.x, mask.position.y

				--sync position
				if not (mx == rx) or not (my == ry) then mask.teleport(reactor.position) end
				--Refueling "fake-fuel-cell"
			else
			--fuel is changed
				mask.teleport(reactor.position)
				pick_and_place_mask(data, current_fuel_name)
			end
		else
			pick_and_place_mask(data, current_fuel_name)
		end
	else
	--fuel inventory is empty

		--set fuel name
		if last_fuel_name then data.last_fuel_name = false end

		if _mask then
		--wait for glow off animation to stop

			if mask_off_time == "on" then
				--closs mask glow
				mask.burner.inventory.clear()
				mask.burner.remaining_burning_fuel = 0
				data.mask_off_time = 90 --remove mask after 1.5 seconds
			elseif mask_off_time > 0 then
				--debug_log(data.mask_off_time)
				data.mask_off_time = mask_off_time - FULL_UPDATE_INTERVAL
			else
				--remove mask
				debug_log("Mask removed.")
				mask.destroy()
				data.mask_off_time = "off"
				data.mask = {}
			end
		else
		--if not exist then delete record
			if not (mask_off_time == "off") then
				data.mask_off_time = "off"
				data.mask = {}
			end
		end
	end
end

local function reactor_status_control(data, reload_phase)
	local reactor = data.reactor
	local _runing = reactor_runing_status(reactor) and true
	local _overhead = reactor.temperature >= CRITICAL_TEMPERATURE
	local meltdown_type = CORE_MELTDOWN_TYPE()

	--mining limit
	if MINING_LIMIT then
		if _runing then
			--cancel deconstruction when reactor is running and MINING_LIMIT = true
			if reactor.to_be_deconstructed(reactor.force) then
				reactor.cancel_deconstruction(reactor.force)
				debug_log("Cancel deconstruction")
			end
			reactor.minable = false
		else
			reactor.minable = true
		end
	elseif reload_phase > 0 then
		reactor.minable = true
	end

	--critical pollution
	if CRITICAL_POLLUTION then
		if _runing and _overhead then
			local current_burned, current_fuel_value = reactor_runing_status(reactor)
			local last_burned = data.last_burned or current_burned
			local last_fuel_value = data.last_fuel_value or current_fuel_value
			local burned_fuel
			if current_burned >= last_burned then
				burned_fuel = math_modf((current_burned - last_burned)/1e+6)
			else
				burned_fuel = math_modf((current_burned + last_fuel_value - last_burned)/1e+6)
			end
			reactor.surface.pollute(reactor.position, burned_fuel * POLLUTION_MULTIPLIER)
			debug_log("critical pollution: " .. burned_fuel * POLLUTION_MULTIPLIER, {r=0.75,g=0,b=1,a=1})
			data.last_burned = current_burned
		else
			data.last_burned = false
			data.last_fuel_value = false
		end
	elseif reload_phase > 0 then
		data.last_burned = false
		data.last_fuel_value = false
	end

	--core meltdown
	if meltdown_type > 0 and _runing and _overhead then
		if mathbit.andOp(meltdown_type, 1) == 1 and reactor.valid then
			--overheat-damage
			reactor.damage(CRITICAL_DAMAGE, "neutral", "fire")
		end
		if mathbit.andOp(meltdown_type, 2) == 2 and reactor.valid then
			--fire
			math_randomseed(game.tick + math_random(0, FULL_UPDATE_INTERVAL))
			local radian = 2 * math_pi * math_random()
			local radius = math_random(FIRE_RADIUS_MIN, FIRE_RADIUS_MAX)
			local x = reactor.position.x + math_cos(radian) * radius
			local y = reactor.position.y + math_sin(radian) * radius
			--reactor.surface.create_entity{name = "fire-flame-on-tree", position = reactor.position, force = "neutral"}
			reactor.surface.create_entity{name = "fire-flame", position = {x = x, y = y}, force = "neutral", initial_ground_flame_count = FIRE_STRENGTH}
		end
	end
end



--[[Main Events function Block]]--
--------------------------------

--called when an reactor entity is destruction
local function died(event)
	local entity = event.entity
	if entity.name == "nuclear-reactor" then
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
		delete_reactor(id)
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
	if entity.name == "nuclear-reactor" then
		debug_log("Remove reactor from table")
		local id = entity.unit_number
		--if entity.die() then debug_log "kill the entity before destroyed." end --result items will be collect, corpse will generate
		delete_reactor(id)
		table_status_refresh()
	end
end

--[[
--called when mining an reactor entity
local function mining(event)
	local entity = event.entity
	if entity.name == "nuclear-reactor" then
		local id = entity.unit_number
		if MINING_LIMIT and reactor_runing_status(entity) then
			--to limit mining
			entity.minable = false
			return
		end
		--if entity.die() then debug_log "kill the entity before results are collected." end --result items will not be collect, corpse will generate
		delete_reactor(id)
	end
end
--]]

--called when an reactor entity is build
local function built(event)
	local entity = event.created_entity
	if entity.name == "nuclear-reactor" then
		debug_log("Add reactor to table")
		local id = entity.unit_number
		global.reactors[id] = {reactor = entity, last_burned = false, last_fuel_value = false, last_fuel_name = false, mask = {}, mask_off_time = "off"}
		if MULTICOLOR_REACTOR then
			local data = global.reactors[id]
			local _, _, fuel_name = reactor_runing_status(data.reactor)
			pick_and_place_mask(data, fuel_name)
		end
		table_status_refresh()
	end
end

local function surface_del(event)
	local index = event.surface_index
	local surface = game.surfaces[index]
	local reactors = surface.find_entities_filtered{name="nuclear-reactor"}
	for i=1, #reactors do
		local id = reactors[i].unit_number
		delete_reactor(id)
	end
	debug_log("The surface #" .. index .. ": \"" .. surface.name .. "\" is deleted")
	debug_log("Remove " ..  #reactors .. " reactors of this surface from table")
	table_status_refresh()
end

local function player_created(event)
	local player = game.players[event.player_index]
	setting_changed_notification(player)
end



--[[Main function Block]]--
--------------------------------

local function setup_global(reset)
	--read last EXACTING_MODE status
	local last_EXACTING_MODE
	if reset and global and global.EXACTING_MODE then last_EXACTING_MODE = global.EXACTING_MODE end

	--setup the global table to store startup settings status and reactor entity data
	global = {EXACTING_MODE = EXACTING_MODE, reactors = {}, index = nil, count = 0, update_interval = 40, update_intensity = 1, tab_refresh_interval = 0, reload_phase = 0}
		
	if reset and MULTICOLOR_REACTOR and not DEBUG then remove_all_mask() end

	--traverse all surface on map to find all nuclear reactors
	local surfaces = game.surfaces
	for i=1, #surfaces do
		local reactors = surfaces[i].find_entities_filtered{name="nuclear-reactor"}
		for i=1, #reactors do
			local reactor = reactors[i]
			built({created_entity = reactor})
			if reset and not EXACTING_MODE and (not EXACTING_MODE ~= not last_EXACTING_MODE) then reactor.minable = true end --unlock mining limit when on_configuration_changed (for EXACTING_MODE is changed to "off")
		end
	end
	table_status_refresh()
	if reset then reset_reactor_control() end
end

local function configuration_changed(event)
	local mod_changes = event.mod_changes
	local startup_changed = event.mod_startup_settings_changed

	--version check
	if table_length(mod_changes) > 0 then
		--[[
		for k, v in pairs(mod_changes) do
			debug_log(k .. ": " .. tostring(v.old_version) .. " --> " .. tostring(v.new_version))
		end
		]]--
		local mod = mod_changes["nuclear-fuel-cycle"]
		if mod then
			if mod.old_version == nil then 
				game.print({"message.head", {"message.mod-installed", tostring(mod.new_version)}}, {r=1,g=0.65,b=0,a=1})
			else
				game.print({"message.head", {"message.mod-updated", tostring(mod.old_version), tostring(mod.new_version)}}, {r=1,g=0.65,b=0,a=1})
				setup_global(true)
			end
			setting_changed_notification(game)
		end
	--startup settings check
	elseif startup_changed then
		setting_changed_notification(game)
		--
		if table_length(global) > 0 then
			local reactors = global.reactors

			--EXACTING_MODE on --> off
			for _, data in pairs(reactors) do
				data.last_burned = false
				data.last_fuel_value = false
				data.reactor.minable = true
			end
			--MULTICOLOR_REACTOR on --> off
			--remove all mask and mask records

			global.EXACTING_MODE = EXACTING_MODE
		else
		--EXACTING_MODE and MULTICOLOR_REACTOR off --> on
			setup_global()
		end
	end
end

local function onetime_run(event)
	--version check

	--startup settings check
	if event.mod_startup_settings_changed then
		debug_log("In noControlBack status!", {r=1,g=0.3,b=0,a=1})
		--read last EXACTING_MODE status
		local last_EXACTING_MODE
		if global and global.EXACTING_MODE then last_EXACTING_MODE = global.EXACTING_MODE end
		--
		debug_log("EXACTING_MODE: " .. tostring(last_EXACTING_MODE) .. " --> " .. tostring(EXACTING_MODE), {r=0.8,g=0.4,b=0.6,a=1})
		if not EXACTING_MODE and (not EXACTING_MODE ~= not last_EXACTING_MODE) then
			local surfaces = game.surfaces
			for i=1, #surfaces do
				local reactors = surfaces[i].find_entities_filtered{name="nuclear-reactor"}
				for i=1, #reactors do
					local reactor = reactors[i]
					reactor.minable = true
				end
			end
			debug_log("All reactors mining limit have been unlocked!")
			global={}
		end
	end
end

local function on_tick(event)
	local tick = event.tick
	local reactors = global.reactors
	--table status
	local reactor_count = global.count
	local update_interval = global.update_interval
	local update_intensity = global.update_intensity
	local tab_refresh_interval = global.tab_refresh_interval
	local reload_phase = global.reload_phase

	--every update cycle
	if reactor_count > 0 and tick % update_interval == 0 then
		--debug_log("update_interval: " .. update_interval)

		local next = _G.next --https://springrts.com/wiki/Lua_Performance
		local index, data = global.index, nil

		--process multiple times on every update cycle
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

			if reactor.valid and reactor.name == "nuclear-reactor" then
				--reactor glows control
				if MULTICOLOR_REACTOR then mask_status_control(data) end
				--reactor status control
				if EXACTING_MODE then reactor_status_control(data, reload_phase) end
			else
				--for entity destroyed by destroy()
				delete_reactor(index)
				debug_log("Removed an invalid reactor entity")
				goto redo
			end
			index = next(reactors, index)
			update_intensity = update_intensity - 1
		until(update_intensity <= 0)



		global.index = index

		--reload settings phase
		if reload_phase > 0 then
			reload_phase = reload_phase - update_interval
			global.reload_phase = reload_phase
			debug_log("Settings has been reloaded. Reload phase: " .. reload_phase)
		end

		--refresh table status on every SAFE_FULL_UPDATE_INTERVAL
		tab_refresh_interval = tab_refresh_interval + update_interval
		if tab_refresh_interval >= SAFE_FULL_UPDATE_INTERVAL then
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

if EXACTING_MODE or MULTICOLOR_REACTOR then

--setup event handler
script.on_init(setup_global)
script.on_configuration_changed(configuration_changed)
script.on_event(e.on_runtime_mod_setting_changed, load_settings)

--main
script.on_event(e.on_tick, on_tick)

--all game build/remove events handler
script.on_event(built_events, built)
--script.on_event(mining_events, mining)
script.on_event(mined_events, mined)
--script.on_event(mineditem_events, mineditem)
script.on_event(died_events, died)
script.on_event(surface_del_events, surface_del)
script.on_event(player_created_events, player_created)

else

script.on_configuration_changed(onetime_run)

end
