dofile_once("mods/souls/files/scripts/utils.lua")

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local x, y = EntityGetTransform( entity_id )

local mark_radius = 50

local targets = EntityGetInRadiusWithTag( x, y, mark_radius, "homing_target" )

if ( #targets > 0 ) then
    for i,target_id in ipairs( targets ) do

        if ( EntityHasTag( target_id, "reap_marked_tome" ) == false ) then

            EntityAddComponent( target_id, "LuaComponent",
            {
                script_death = "mods/tome_magic/files/entities/misc/card_tome_page_dragon/reap.lua",
                execute_every_n_frame = "-1",
            } )

            EntityAddTag( target_id, "reap_marked_tome")
        end

        if EntityHasTag(target_id, "reap_marked_fx") == false then
            local effect_id = EntityLoad("mods/souls/files/entities/particles/marked_particles.xml", x, y)
            EntityAddChild(target_id, effect_id)
            EntityAddTag(target_id, "reap_marked_fx")
        end
    end
end