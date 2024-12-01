dofile_once("mods/souls/files/scripts/utils.lua")
dofile_once("data/scripts/perks/perk.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity)
	if not GameHasFlagRun("tome_magic_alchemist_dead") then
		GameAddFlagRun("tome_magic_alchemist_dead")
		CreateItemActionEntity("MOLDOS_TOME_PAGE_ALCHEMIST", x, y)
	end
end