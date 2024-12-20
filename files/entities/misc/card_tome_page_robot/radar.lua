dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
pos_y = pos_y - 4 -- offset to middle of character

if not EntityHasTag(EntityGetParent(entity_id), "soul_tome") then return end

local range = 500
local indicator_distance = 24

-- ping nearby wand
for _,id in pairs(EntityGetInRadiusWithTag( pos_x, pos_y, range, "wand")) do
	local wand_x, wand_y = EntityGetTransform(id)
	local parent = EntityGetRootEntity( id );

	if( IsPlayer( parent ) == false ) then 

		local dir_x = wand_x - pos_x
		local dir_y = wand_y - pos_y
		local distance = get_magnitude(dir_x, dir_y)

		-- sprite positions around character
		dir_x,dir_y = vec_normalize(dir_x,dir_y)
		local indicator_x = pos_x + dir_x * indicator_distance
		local indicator_y = pos_y + dir_y * indicator_distance

		-- display sprite based on proximity
		if distance > range * 0.5 then
			GameCreateSpriteForXFrames( "data/particles/radar_wand_faint.png", indicator_x, indicator_y )
		elseif distance > range * 0.25 then
			GameCreateSpriteForXFrames( "data/particles/radar_wand_medium.png", indicator_x, indicator_y )
		elseif distance > 10 then
			GameCreateSpriteForXFrames( "data/particles/radar_wand_strong.png", indicator_x, indicator_y )
		end
	end
end

local range_dos = 1000
local indicator_distance_dos = 24

-- ping nearby wand
for _,id in pairs(EntityGetInRadiusWithTag( pos_x, pos_y, range, "tome_magic_twilight_page_thing")) do
	local wand_x, wand_y = EntityGetTransform(id)
	local parent = EntityGetRootEntity( id );

	if( IsPlayer( parent ) == false ) then 

		local dir_x = wand_x - pos_x
		local dir_y = wand_y - pos_y
		local distance = get_magnitude(dir_x, dir_y)

		-- sprite positions around character
		dir_x,dir_y = vec_normalize(dir_x,dir_y)
		local indicator_x = pos_x + dir_x * indicator_distance_dos
		local indicator_y = pos_y + dir_y * indicator_distance_dos

		-- display sprite based on proximity
		if distance > range_dos * 0.5 then
			GameCreateSpriteForXFrames( "mods/tome_magic/files/entities/misc/card_tome_page_robot/radar_faint.png", indicator_x, indicator_y )
		elseif distance > range_dos * 0.25 then
			GameCreateSpriteForXFrames( "mods/tome_magic/files/entities/misc/card_tome_page_robot/radar_medium.png", indicator_x, indicator_y )
		elseif distance > 10 then
			GameCreateSpriteForXFrames( "mods/tome_magic/files/entities/misc/card_tome_page_robot/radar_strong.png", indicator_x, indicator_y )
		end
	end
end
