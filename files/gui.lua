dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local active_soul_group = 2

function OnWorldPreUpdate()
    if GetPlayer() ~= nil then
        active_soul_group = TomeMagicGetActiveSoulGroup()
    end
end

function OnWorldPostUpdate()
    local player = EntityGetWithTag("player_unit")[1]
    if player ~= nil then
        GuiRender()
    end
end

function GuiRender()
    local gui = GuiCreate()
    GuiStartFrame(gui)

    local player = GetPlayer()
    local x, y = EntityGetTransform(x, y)
    
    if EntityHasTag(HeldItem(player), "soul_tome") and active_soul_group == 3 then
        GuiText(gui, 50, 50, "TELE COST: " .. TomeMagicGetTeleSoulCost(x, y)) -- pos not final ofc
    end

    GuiDestroy(gui)
end