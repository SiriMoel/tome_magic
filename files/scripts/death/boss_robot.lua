dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("data/scripts/perks/perk.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)
	if not GameHasFlagRun("tome_magic_robot_dead") then
		GameAddFlagRun("tome_magic_robot_dead")
		CreateItemActionEntity("MOLDOS_TOME_PAGE_ROBOT", x, y)
	end
end