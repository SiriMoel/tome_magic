dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
    local entity = GetUpdatedEntityID()
    local player = GetPlayer()
    local x, y = EntityGetTransform(entity)
    local frame = GameGetFrameNum()
    math.randomseed(x + frame, y + frame)
    local soul = soul_groups[2][math.random(1, #soul_groups[2])]
    if ModSettingGet("souls.say_soul") == true then
        GamePrint("You have acquired a " .. SoulNameCheck(soul) .. " soul!")
    end
    AddSouls(soul, 1)
    if EntityHasTag(player, "souls_anima_conduit") then
        local comp_damagemodel = EntityGetFirstComponentIncludingDisabled(player, "DamageModelComponent")
        if comp_damagemodel ~= nil then
            local hp = ComponentGetValue2(comp_damagemodel, "hp")
            local max_hp = ComponentGetValue2(comp_damagemodel, "max_hp")
            -- heals 0.25% rounding up, stronger at lower max hp, weaker at higher max hp as you get more reaping spells
            hp = hp + math.ceil((max_hp * 0.0025))
            if hp > max_hp then
                hp = max_hp
            end
            ComponentSetValue2(comp_damagemodel, "hp", hp)
        end
    end
end