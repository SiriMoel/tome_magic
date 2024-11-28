dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card) -- player, right?
local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent") or 0
local comp_cd = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "cooldown_frame") or 0
local cooldown_frames = 6
local cooldown_frame = ComponentGetValue2(comp_cd, "value_int")
local tome = EntityGetWithTag("soul_tome")[1]

if ComponentGetValue2(comp_controls, "mButtonDownRightClick") == true and GameGetFrameNum() >= cooldown_frame then
    if HeldItem(player) ~= tome or root ~= GetPlayer() then return end
    
    local x, y = EntityGetTransform(root)

    local current_active_soul_group = TomeMagicGetActiveSoulGroup()
    local soulscount = GetTotalSoulsOfGroup(current_active_soul_group)

    if current_active_soul_group == 1 then
        
    end
    if current_active_soul_group == 2 then
        if soulscount >= 3 then
            local aim_x, aim_y = ComponentGetValue2(comp_controls, "mAimingVectorNormalized")
            local vel = 60
            local vel_x, vel_y = aim_x * vel, aim_y * vel
            cooldown_frames = 20
            shoot_projectile( root, "mods/souls/files/entities/projectiles/tome_bomb/proj.xml", x, y, vel_x, vel_y, true)
        else
            GamePrint("You do not have enough souls for this.")
        end
    end
    if current_active_soul_group == 3 then
        TomeMagicSetTeleCoords(x, y)
        GamePrint("Set Tome Tele coords to x, y.")
    end

    ComponentSetValue2( comp_cd, "value_int", GameGetFrameNum() + cooldown_frames )
end