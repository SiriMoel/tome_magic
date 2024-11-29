dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local player = GetPlayer()

if EntityGetRootEntity(card) ~= player then return end

local comp_cd = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "cooldown_frame") or 0
local cooldown_frames = 6
local cooldown_frame = ComponentGetValue2(comp_cd, "value_int")
local frame = GameGetFrameNum()

if frame < cooldown_frame then return end

local current_active_soul_group = TomeMagicGetActiveSoulGroup()

if current_active_soul_group >= 3 then
    current_active_soul_group = 1
else
    current_active_soul_group = current_active_soul_group + 1
end

GamePrint(tostring(current_active_soul_group)) -- TESTING

TomeMagicSetActiveSoulGroup(current_active_soul_group, true)

ComponentSetValue2( comp_cd, "value_int", frame + cooldown_frames )