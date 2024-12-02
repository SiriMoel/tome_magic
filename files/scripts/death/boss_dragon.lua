dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("data/scripts/perks/perk.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)
	if not GameHasFlagRun("tome_magic_dragon_dead") then
		GameAddFlagRun("tome_magic_dragon_dead")
		CreateItemActionEntity("MOLDOS_TOME_PAGE_DRAGON", x, y)
	end
end