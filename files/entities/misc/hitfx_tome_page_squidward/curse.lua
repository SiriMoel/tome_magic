dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local entity = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity)
local who_shot = entity

if EntityHasTag(entity, "curse_NOT") then return end

local damage = 0.08

local comps = EntityGetComponent(entity, "VariableStorageComponent")

if comps ~= nil then
    for i,comp in ipairs(comps) do
        local name = ComponentGetValue2( comp, "name" )
        if name == "effect_curse_damage" then
            damage = ComponentGetValue2( comp, "value_float" )
        elseif name == "projectile_who_shot" then
            who_shot = ComponentGetValue2( comp, "value_int" )
        end
    end
end

if EntityHasTag(root, "reap_marked") then
    EntityInflictDamage( root, damage, "DAMAGE_CURSE", "$damage_hitfx_curse", "DISINTEGRATED", 0, 0, who_shot )
end