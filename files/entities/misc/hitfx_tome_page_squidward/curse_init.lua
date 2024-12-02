dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local entity = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity)
local x, y = EntityGetTransform(root)

if EntityHasTag(root, "curse_NOT") then return end

if not EntityHasTag(root, "tome_magic_squidward_cursed") then
    local entity_curse = EntityLoad("mods/tome_magic/files/entities/misc/hitfx_tome_page_squidward/curse.xml", x, y)
    EntityAddChild(root, entity_curse)
    EntityAddTag(root, "tome_magic_squidward_cursed")
    local comps = EntityGetComponent(entity, "VariableStorageComponent")
    if comps ~= nil then
        for i,comp in ipairs(comps) do
            local name = ComponentGetValue2(comp, "name")
            if name == "projectile_who_shot" then
                local who_shot = ComponentGetValue2(comp, "value_int")
                EntityAddComponent2(entity_curse, "VariableStorageComponent", {
                    name="projectile_who_shot",
                    value_int=who_shot
                })
            end
        end
    end
else
    local children = EntityGetAllChildren(root)
    if children ~= nil then
        for i,child in ipairs(children) do
            if EntityHasTag(child, "tome_magic_squidward_curse") then
                local comp = EntityGetFirstComponent(child, "LifetimeComponent", "effect_curse_lifetime")
                if comp ~= nil then
                    local frame = GameGetFrameNum()
                    ComponentSetValue2(comp, "creation_frame", frame)
                    ComponentSetValue2(comp, "kill_frame", frame + 300)
                    comp = EntityGetFirstComponent(child, "VariableStorageComponent", "effect_curse_damage")
                    if comp ~= nil then
                        local damage = ComponentGetValue2(comp, "value_float")
                        damage = damage + 0.08
                        ComponentSetValue2(comp, "value_float", damage)
                    end
                end
            end
        end
    end
end



EntityKill(entity)