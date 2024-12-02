dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local entity = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity)
local x, y = EntityGetTransform(root)

if EntityHasTag(root, "tome_magic_squidward_cursed") then
    EntityRemoveTag(root, "tome_magic_squidward_cursed")
end