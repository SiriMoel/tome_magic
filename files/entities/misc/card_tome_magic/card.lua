dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local card = GetUpdatedEntityID()
local root = EntityGetRootEntity(card) -- player, right?
local comp_controls = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent") or 0
local comp_cd = EntityGetFirstComponentIncludingDisabled(card, "VariableStorageComponent", "cooldown_frame") or 0
local cooldown_frames = 6
local cooldown_frame = ComponentGetValue2(comp_cd, "value_int")
local tome = EntityGetWithTag("soul_tome")[1]
local frame = GameGetFrameNum()

if ComponentGetValue2(comp_controls, "mButtonDownKick") == true and frame >= cooldown_frame then
    if HeldItem(root) ~= tome or root ~= GetPlayer() then return end
    local current_active_soul_group = TomeMagicGetActiveSoulGroup()
    if current_active_soul_group >= 3 then
        current_active_soul_group = 1
    else
        current_active_soul_group = current_active_soul_group + 1
    end
    cooldown_frames = 12
    TomeMagicSetActiveSoulGroup(current_active_soul_group, true)
    ComponentSetValue2( comp_cd, "value_int", frame + cooldown_frames )
end

if ComponentGetValue2(comp_controls, "mButtonDownRightClick") == true and frame >= cooldown_frame then
    if HeldItem(root) ~= tome or root ~= GetPlayer() then return end
    local x, y = EntityGetTransform(root)
    local current_active_soul_group = TomeMagicGetActiveSoulGroup()
    local soulscount = GetTotalSoulsOfGroup(current_active_soul_group)
    if current_active_soul_group == 1 then
        cooldown_frames = 20
        if soulscount >= 1 then
            local entity = EntityLoad("mods/tome_magic/files/entities/misc/effect_tome_magic_dos/effect.xml", x, y)
            EntityAddChild(player, entity)
            RemoveSoulsFromGroup(1, 1)
        else
            GamePrint("You do not have enough souls for this.")
        end
    end
    if current_active_soul_group == 2 then
        if soulscount >= 3 then
            local aim_x, aim_y = ComponentGetValue2(comp_controls, "mAimingVectorNormalized")
            local vel = 60
            local vel_x, vel_y = aim_x * vel, aim_y * vel
            cooldown_frames = 20
            shoot_projectile( root, "mods/souls/files/entities/projectiles/tome_bomb/proj.xml", x, y, vel_x, vel_y, true)
            RemoveSoulsFromGroup(2, 3)
        else
            GamePrint("You do not have enough souls for this.")
        end
    end
    if current_active_soul_group == 3 then
        TomeMagicSetTeleCoords(x, y)
        GamePrint("Set Tome Tele coords to (" .. math.floor(x + 0.5) .. ", " .. math.floor(y + 0.5) .. ").")
    end
    ComponentSetValue2( comp_cd, "value_int", frame + cooldown_frames )
end