dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local proj = GetUpdatedEntityID()
local x, y = EntityGetTransform(proj)

local targets = EntityGetInRadiusWithTag(x, y, 50, "homing_target")

for i,target in ipairs(targets) do
    if not EntityHasTag(target, "tome_page_spirit_charmed") and EntityHasTag(target, "reap_marked") then
        local effect = EntityLoad("mods/tome_magic/files/entities/projectiles/tome_page_spirit/effect.xml", x, y)
        EntityAddChild(target, effect)
        EntityAddTag(target, "tome_page_spirit_charmed")
    end
end