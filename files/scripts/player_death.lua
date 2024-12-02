dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local player = GetUpdatedEntityID()
	local x, y = EntityGetTransform(player)

    local items = GameGetAllInventoryItems(player) or {}
    for i,item in ipairs(items) do
        if #EntityGetAllChildren(item, "tome_magic_ghost_page") > 0 then
            ModSettingSet("tome_magic.twilight_page_active", true)
            ModSettingSet("tome_magic.twilight_page_x", x)
            ModSettingSet("tome_magic.twilight_page_y", y)
            for k,soul in ipairs(soul_types) do
                ModSettingSet("tome_magic.twilight_page_" .. soul .. "_soul_count", GetSoulsCount(soul))
            end
            GamePrint("Your souls have been saved")
        end
    end
end