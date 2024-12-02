dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card) -- player, right?
local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent") or 0
local comp_cd = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "cooldown_frame") or 0
local cooldown_frames = 600
local cooldown_frame = ComponentGetValue2(comp_cd, "value_int")
local tome = EntityGetWithTag("soul_tome")[1]
local frame = GameGetFrameNum()
local player = GetPlayer()

if ComponentGetValue2(comp_controls, "mButtonDownRightClick") == true then
    if HeldItem(root) ~= tome or root ~= player then return end
    if frame >= cooldown_frame then
        EntitySetTransform(player, 3836, 7518)
        ComponentSetValue2( comp_cd, "value_int", frame + cooldown_frames )
        GamePrint("Teleported!")
    else
        GamePrint("On cooldown...")
    end
end