dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

spawn_tome_old = spawn_tome

function spawn_tome(x, y)
    CreateItemActionEntity("MOLDOS_TOME_MAGIC", x, y - 30)
    spawn_tome_old(x, y)
end