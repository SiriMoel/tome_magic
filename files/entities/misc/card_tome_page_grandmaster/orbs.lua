dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local player = GetPlayer()
local x, y = EntityGetTransform(player)

if not EntityHasTag(EntityGetParent(card), "soul_tome") then return end

local child = EntityLoad("mods/tome_magic/files/entities/misc/card_tome_page_grandmaster/orb.xml", x - 28, y)
EntityAddChild(player, child)

child = EntityLoad("mods/tome_magic/files/entities/misc/card_tome_page_grandmaster/orb.xml", x + 28, y)
EntityAddChild(player, child)

