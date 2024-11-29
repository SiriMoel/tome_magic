dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local actions_to_insert = {
    {
		id          = "TOME_MAGIC", -- infinite bombs
		name 		= "$action_moldos_tome_magic",
		description = "$actiondesc_moldos_tome_magic",
		sprite 		= "mods/tome_magic/files/spell_icons/tome_magic.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		related_projectiles	= {"mods/souls/files/entities/projectiles/tome_bomb/proj.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
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

            if wand ~= tome then return end

            if active_soul_group == 1 then
                
            end
            if active_soul_group == 2 then
                
            end
            if active_soul_group == 3 then
				local x, y = EntityGetTransform(entity)
				local dest_x, dest_y = TomeMagicGetTeleCoords()
				local cost = TomeMagicGetTeleSoulCost(x, y)
				local current_active_soul_group = TomeMagicGetActiveSoulGroup()
				local soulscount = GetTotalSoulsOfGroup(current_active_soul_group)
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