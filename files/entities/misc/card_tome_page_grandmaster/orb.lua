dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local orb = GetUpdatedEntityID()
local x, y = EntityGetTransform(orb)
local player = GetPlayer()

local targets = EntityGetInRadiusWithTag( x, y, 12, "projectile" )


for i,target in ipairs(targets) do
    local comp = EntityGetFirstComponent( v, "ProjectileComponent" )
    local proj_id
			
    if comp ~= nil then
        local who = ComponentGetValue2( comp, "mWhoShot" )
        
        if who ~= player then
            proj_id = target
        end

        if proj_id ~= nil then
            EntityLoad("data/entities/particles/poof_red_tiny.xml", x, y)
            EntityKill(proj_id)
        end
    end
end