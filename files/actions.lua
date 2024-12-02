dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local actions_to_insert = {
    {
		id          = "TOME_MAGIC",
		name 		= "$action_moldos_tome_magic",
		description = "$actiondesc_moldos_tome_magic",
		sprite 		= "mods/tome_magic/files/spell_icons/tome_magic.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/tome_bomb/proj.xml"},
		type 		= ACTION_TYPE_OTHER,
		inject_after = "SUMMON_WANDGHOST",
		spawn_level                       = "",
		spawn_probability                 = "",
		spawn_level_table = {},
		spawn_probability_table = {},
		price = 100,
		mana = 50,
		custom_xml_file="mods/tome_magic/files/entities/misc/card_tome_magic/card.xml",
		action 		= function()
			dofile_once("mods/souls/files/scripts/souls.lua")
			if reflecting then return end
            local entity = GetUpdatedEntityID()
			local active_soul_group = TomeMagicGetActiveSoulGroup()
            local tome = EntityGetWithTag("soul_tome")[1]
			local wand = 0
			local comp_inv = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if comp_inv then
				wand = ComponentGetValue2(comp_inv, "mActiveItem")
            end
            if wand ~= tome then GamePrint("This spell must be casted on the tome.") return end
            if active_soul_group == 1 then
				local soulscount = GetTotalSoulsOfGroup(active_soul_group)
				if soulscount >= 1 then
					local effect = EntityLoad("mods/tome_magic/files/entities/misc/effect_tome_magic_uno/effect.xml", x, y)
					EntityAddChild(player, effect)
					RemoveSoulsFromGroup(1, 1)
				else
					GamePrint("You do not have enough souls for this.")
				end
            end
            if active_soul_group == 2 then
				local soulscount = GetTotalSoulsOfGroup(active_soul_group)
				if soulscount >= 1 then
					RemoveSoulsFromGroup(active_soul_group, 1)
					c.spread_degrees = c.spread_degrees + 5
					add_projectile("mods/tome_magic/files/entities/projectiles/tome_magic_sniper_shot/projectile.xml")
					add_projectile("mods/tome_magic/files/entities/projectiles/tome_magic_sniper_shot/projectile.xml")
					add_projectile("mods/tome_magic/files/entities/projectiles/tome_magic_sniper_shot/projectile.xml")
					local pagecount = GetTomePageCountOnTome(tome)
					if pagecount >= 11 then
						add_projectile("mods/tome_magic/files/entities/projectiles/all_pages/proj.xml")
					end
					for i=1,pagecount do
						add_projectile("mods/tome_magic/files/entities/projectiles/tome_magic_sniper_shot/projectile.xml")
					end
				else
					GamePrint("You do not have enough souls for this.")
				end
            end
            if active_soul_group == 3 then
				local soulscount = GetTotalSoulsOfGroup(active_soul_group)
				local x, y = EntityGetTransform(entity)
				local dest_x, dest_y = TomeMagicGetTeleCoords()
				local cost = TomeMagicGetTeleSoulCost(x, y)
				if soulscount >= cost then
					EntitySetTransform(entity, dest_x, dest_y)
					GamePrint("Teleported!")
					RemoveSoulsFromGroup(3, cost)
				else
					GamePrint("You do not have enough souls for this.")
				end
            end
		end,
	},
	{
		id          = "TOME_PAGE_TINY",
		name 		= "$action_moldos_tome_page_tiny",
		description = "$actiondesc_moldos_tome_page_tiny",
		sprite 		= "mods/tome_magic/files/spell_icons/tome_page_tiny.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "SUMMON_WANDGHOST",
		spawn_level                       = "",
		spawn_probability                 = "",
		spawn_level_table = {},
		spawn_probability_table = {},
		price = 100,
		mana = 40,
		custom_xml_file="mods/tome_magic/files/entities/misc/card_tome_page_tiny/card.xml",
		action 		= function()
			draw_actions(1, true)
			if reflecting then return end
			local entity = GetUpdatedEntityID()
			local tome = EntityGetWithTag("soul_tome")[1]
			local wand = 0
			local comp_inv = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if comp_inv then
				wand = ComponentGetValue2(comp_inv, "mActiveItem")
            end
            if wand ~= tome then GamePrint("This spell must be casted on the tome.") return end
			local x, y = EntityGetTransform(entity)
			if y > 0 then
				local amount = 0.1 * (y / 1000)
				c.damage_projectile_add = c.damage_projectile_add + amount
			end
		end,
	},
	{
		id          = "TOME_PAGE_PYRAMID",
		name 		= "$action_moldos_tome_page_pyramid",
		description = "$actiondesc_moldos_tome_page_pyramid",
		sprite 		= "mods/tome_magic/files/spell_icons/tome_page_pyramid.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "SUMMON_WANDGHOST",
		spawn_level                       = "",
		spawn_probability                 = "",
		spawn_level_table = {},
		spawn_probability_table = {},
		price = 100,
		mana = 40,
		custom_xml_file="mods/tome_magic/files/entities/misc/card_tome_page_pyramid/card.xml",
		action 		= function()
			draw_actions(1, true)
			if reflecting then return end
			local entity = GetUpdatedEntityID()
			local tome = EntityGetWithTag("soul_tome")[1]
			local wand = 0
			local comp_inv = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if comp_inv then
				wand = ComponentGetValue2(comp_inv, "mActiveItem")
            end
            if wand ~= tome then GamePrint("This spell must be casted on the tome.") return end
			local x, y = EntityGetTransform(entity)
			if y < 0 then
				local amount = 0.1 * (-y / 1000)
				amount = amount * (1 + GameGetGameEffectCount(entity, "TRIP"))
				c.damage_projectile_add = c.damage_projectile_add + amount
			end
		end,
	},
	{
		id          = "TOME_PAGE_GHOST",
		name 		= "$action_moldos_tome_page_ghost",
		description = "$actiondesc_moldos_tome_page_ghost",
		sprite 		= "mods/tome_magic/files/spell_icons/tome_page_ghost.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		type 		= ACTION_TYPE_PASSIVE,
		inject_after = "SUMMON_WANDGHOST",
		spawn_level                       = "",
		spawn_probability                 = "",
		spawn_level_table = {},
		spawn_probability_table = {},
		price = 100,
		mana = -1,
		custom_xml_file="mods/tome_magic/files/entities/misc/card_tome_page_ghost/card.xml",
		action 		= function()
			draw_actions(1, true)
			local entity = GetUpdatedEntityID()
			local tome = EntityGetWithTag("soul_tome")[1]
			local wand = 0
			local comp_inv = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if comp_inv then
				wand = ComponentGetValue2(comp_inv, "mActiveItem")
            end
            if wand ~= tome then GamePrint("This spell must be casted on the tome.") return end
		end,
	},
	{
		id          = "TOME_PAGE_DRAGON",
		name 		= "$action_moldos_tome_page_dragon",
		description = "$actiondesc_moldos_tome_page_dragon",
		sprite 		= "mods/tome_magic/files/spell_icons/tome_page_dragon.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "SUMMON_WANDGHOST",
		spawn_level                       = "",
		spawn_probability                 = "",
		spawn_level_table = {},
		spawn_probability_table = {},
		price = 100,
		mana = 70,
		custom_xml_file="mods/tome_magic/files/entities/misc/card_tome_page_dragon/card.xml",
		action 		= function( recursion_level, iteration )
			c.fire_rate_wait = c.fire_rate_wait + 10
			local entity = GetUpdatedEntityID()
			local tome = EntityGetWithTag("soul_tome")[1]
			local wand = 0
			local comp_inv = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if comp_inv then
				wand = ComponentGetValue2(comp_inv, "mActiveItem")
            end
            if wand ~= tome then GamePrint("This spell must be casted on the tome.") return end
			local firerate = c.fire_rate_wait
			local reload = current_reload_time
			local mana_ = mana
			if discarded ~= nil then
				for i,data in ipairs(discarded) do
					local rec = check_recursion(data, recursion_level)
					if data ~= nil and data.type == 2  and rec > -1 then
						dont_draw_actions = true
						data.action(rec)
						dont_draw_actions = false
					end
				end
			end
			if hand ~= nil then
				for i,data in ipairs(hand) do
					local rec = check_recursion(data, recursion_level)
					if data ~= nil and data.type == 2  and rec > -1 then
						dont_draw_actions = true
						data.action(rec)
						dont_draw_actions = false
					end
				end
			end
			c.fire_rate_wait = firerate
			current_reload_time = reload
			mana = mana_

			draw_actions( 1, true )
		end,
	},
	{
		id          = "TOME_PAGE_SQUIDWARD",
		name 		= "$action_moldos_tome_page_squidward",
		description = "$actiondesc_moldos_tome_page_squidward",
		sprite 		= "mods/tome_magic/files/spell_icons/tome_page_squidward.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "SUMMON_WANDGHOST",
		spawn_level                       = "",
		spawn_probability                 = "",
		spawn_level_table = {},
		spawn_probability_table = {},
		price = 100,
		mana = 20,
		custom_xml_file="mods/tome_magic/files/entities/misc/card_tome_page_squidward/card.xml",
		action = function()
			local entity = GetUpdatedEntityID()
			local tome = EntityGetWithTag("soul_tome")[1]
			local wand = 0
			local comp_inv = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if comp_inv then
				wand = ComponentGetValue2(comp_inv, "mActiveItem")
            end
            if wand ~= tome then GamePrint("This spell must be casted on the tome.") return end
			c.extra_entities = c.extra_entities .. "mods/tome_magic/files/entities/misc/hitfx_tome_page_squidward/hitfx.xml"
			draw_actions( 1, true )
		end,
	},
	{
		id          = "TOME_PAGE_ROBOT",
		name 		= "$action_moldos_tome_page_robot",
		description = "$actiondesc_moldos_tome_page_robot",
		sprite 		= "mods/tome_magic/files/spell_icons/tome_page_robot.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		type 		= ACTION_TYPE_PASSIVE,
		inject_after = "SUMMON_WANDGHOST",
		spawn_level                       = "",
		spawn_probability                 = "",
		spawn_level_table = {},
		spawn_probability_table = {},
		price = 100,
		mana = 10,
		custom_xml_file="mods/tome_magic/files/entities/misc/card_tome_page_robot/card.xml",
		action 		= function()
			local entity = GetUpdatedEntityID()
			local tome = EntityGetWithTag("soul_tome")[1]
			local wand = 0
			local comp_inv = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if comp_inv then
				wand = ComponentGetValue2(comp_inv, "mActiveItem")
            end
            if wand ~= tome then GamePrint("This spell must be casted on the tome.") return end
			draw_actions(1, true)
		end,
	},
	{
		id          = "TOME_PAGE_ALCHEMIST",
		name 		= "$action_moldos_tome_page_alchemist",
		description = "$actiondesc_moldos_tome_page_alchemist",
		sprite 		= "mods/tome_magic/files/spell_icons/tome_page_alchemist.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "SUMMON_WANDGHOST",
		spawn_level                       = "",
		spawn_probability                 = "",
		spawn_level_table = {},
		spawn_probability_table = {},
		price = 100,
		mana = 10,
		custom_xml_file="mods/tome_magic/files/entities/misc/card_tome_page_alchemist/card.xml",
		action = function()
			local entity = GetUpdatedEntityID()
			local tome = EntityGetWithTag("soul_tome")[1]
			local wand = 0
			local comp_inv = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if comp_inv then
				wand = ComponentGetValue2(comp_inv, "mActiveItem")
            end
            if wand ~= tome then GamePrint("This spell must be casted on the tome.") return end
			add_projectile("data/entities/projectiles/deck/material_water.xml")
			c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_apply_wet.xml,"
			add_projectile("data/entities/projectiles/deck/material_oil.xml")
			c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_apply_oiled.xml,"
			add_projectile("data/entities/projectiles/deck/material_blood.xml")
			c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_apply_bloody.xml,"
			draw_actions( 1, true )
		end,
	},
	{
		id          = "TOME_PAGE_LEVIATHAN",
		name 		= "$action_moldos_tome_page_leviathan",
		description = "$actiondesc_moldos_tome_page_leviathan",
		sprite 		= "mods/tome_magic/files/spell_icons/tome_page_leviathan.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		type 		= ACTION_TYPE_PASSIVE,
		inject_after = "SUMMON_WANDGHOST",
		spawn_level                       = "",
		spawn_probability                 = "",
		spawn_level_table = {},
		spawn_probability_table = {},
		price = 100,
		mana = -1,
		custom_xml_file="mods/tome_magic/files/entities/misc/card_tome_page_leviathan/card.xml",
		action 		= function()
			local entity = GetUpdatedEntityID()
			local tome = EntityGetWithTag("soul_tome")[1]
			local wand = 0
			local comp_inv = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if comp_inv then
				wand = ComponentGetValue2(comp_inv, "mActiveItem")
            end
            if wand ~= tome then GamePrint("This spell must be casted on the tome.") return end
			draw_actions(1, true)
		end,
	},
	{
		id          = "TOME_PAGE_SPIRIT",
		name 		= "$action_moldos_tome_page_spirit",
		description = "$actiondesc_moldos_tome_page_spirit",
		sprite 		= "mods/tome_magic/files/spell_icons/tome_page_spirit.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		inject_after = "SUMMON_WANDGHOST",
		spawn_level                       = "",
		spawn_probability                 = "",
		spawn_level_table = {},
		spawn_probability_table = {},
		price = 100,
		mana = 200,
		custom_xml_file="mods/tome_magic/files/entities/misc/card_tome_page_spirit/card.xml",
		action = function()
			local entity = GetUpdatedEntityID()
			local tome = EntityGetWithTag("soul_tome")[1]
			local wand = 0
			local comp_inv = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if comp_inv then
				wand = ComponentGetValue2(comp_inv, "mActiveItem")
            end
            if wand ~= tome then GamePrint("This spell must be casted on the tome.") return end
			add_projectile("mods/tome_magic/files/entities/projectiles/tome_page_spirit/proj.xml")
			draw_actions(1, true)
		end,
	},
	{
		id          = "TOME_PAGE_MEAT",
		name 		= "$action_moldos_tome_page_meat",
		description = "$actiondesc_moldos_tome_page_meat",
		sprite 		= "mods/tome_magic/files/spell_icons/tome_page_meat.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		type 		= ACTION_TYPE_PASSIVE,
		inject_after = "SUMMON_WANDGHOST",
		spawn_level                       = "",
		spawn_probability                 = "",
		spawn_level_table = {},
		spawn_probability_table = {},
		price = 100,
		mana = 100,
		custom_xml_file="mods/tome_magic/files/entities/misc/card_tome_page_meat/card.xml",
		action 		= function()
			local entity = GetUpdatedEntityID()
			local tome = EntityGetWithTag("soul_tome")[1]
			local wand = 0
			local comp_inv = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if comp_inv then
				wand = ComponentGetValue2(comp_inv, "mActiveItem")
            end
            if wand ~= tome then GamePrint("This spell must be casted on the tome.") return end
			draw_actions(1, true)
		end,
	},
	{
		id          = "TOME_PAGE_GRANDMASTER",
		name 		= "$action_moldos_tome_page_grandmaster",
		description = "$actiondesc_moldos_tome_page_grandmaster",
		sprite 		= "mods/tome_magic/files/spell_icons/tome_page_grandmaster.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		type 		= ACTION_TYPE_PASSIVE,
		inject_after = "SUMMON_WANDGHOST",
		spawn_level                       = "",
		spawn_probability                 = "",
		spawn_level_table = {},
		spawn_probability_table = {},
		price = 100,
		mana = 100,
		custom_xml_file="mods/tome_magic/files/entities/misc/card_tome_page_grandmaster/card.xml",
		action 		= function()
			local entity = GetUpdatedEntityID()
			local tome = EntityGetWithTag("soul_tome")[1]
			local wand = 0
			local comp_inv = EntityGetFirstComponentIncludingDisabled(entity, "Inventory2Component")
			if comp_inv then
				wand = ComponentGetValue2(comp_inv, "mActiveItem")
            end
            if wand ~= tome then GamePrint("This spell must be casted on the tome.") return end
			draw_actions(1, true)
		end,
	},
}

for i,action in ipairs(actions_to_insert) do
	action.id = "MOLDOS_" .. action.id
	local levels = ""
	local probabilities = ""
	levels = ""
	probabilities = ""
	local multiplier = tonumber(ModSettingGet("souls.spell_spawn_chance_multiplier"))
	for i,level in ipairs(action.spawn_level_table) do
		levels = levels .. tostring(level) .. ","
	end
	action.spawn_level = levels
	for i,chance in ipairs(action.spawn_probability_table) do
		chance = chance * multiplier
		probabilities = probabilities .. tostring(chance) .. ","
	end
	action.spawn_probability = probabilities
	table.insert(actions, action)
end