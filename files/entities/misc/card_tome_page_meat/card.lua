dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local x, y = EntityGetTransform(this)

local targets = EntityGetInRadiusWithTag(x, y, 100, "ragdoll")

if #targets > 0 then
    GamePrint("found")
end