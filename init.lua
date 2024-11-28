if ModIsEnabled("souls") then
    dofile_once("mods/souls/files/scripts/souls.lua")

    local nxml = dofile_once("mods/tome_magic/lib/nxml.lua")

    -- drops
    local dropdoers = {
        {
            path = "data/entities/animals/boss_alchemist/boss_alchemist.xml",
            script = "mods/tome_magic/files/scripts/death/boss_alchemist.lua",
        },
        {
            path = "data/entities/animals/boss_limbs/boss_limbs.xml",
            script = "mods/tome_magic/files/scripts/death/boss_limbs.lua",
        },
        {
            path = "data/entities/animals/boss_dragon.xml",
            script = "mods/tome_magic/files/scripts/death/boss_dragon.lua",
        },
        {
            path = "data/entities/animals/boss_wizard/boss_wizard.xml",
            script = "mods/tome_magic/files/scripts/death/boss_wizard.lua",
        },
        {
            path = "data/entities/animals/boss_fish/fish_giga.xml",
            script = "mods/tome_magic/files/scripts/death/boss_fish.lua",
        },
        {
            path = "data/entities/animals/boss_spirit/islandspirit.xml",
            script = "mods/tome_magic/files/scripts/death/boss_deer.lua",
        },
        {
            path = "data/entities/animals/boss_ghost/boss_ghost.xml",
            script = "mods/tome_magic/files/scripts/death/boss_ghost.lua",
        },
        {
            path = "data/entities/animals/boss_meat/boss_meat.xml",
            script = "mods/tome_magic/files/scripts/death/boss_meat.lua",
        },
        {
            path = "data/entities/animals/boss_robot/boss_robot.xml",
            script = "mods/tome_magic/files/scripts/death/boss_robot.lua",
        },
        {
            path = "data/entities/animals/maggot_tiny/maggot_tiny.xml",
            script = "mods/tome_magic/files/scripts/death/maggot_tiny.lua",
        },
    }

    for i,v in ipairs(dropdoers) do
        local xml = nxml.parse(ModTextFileGetContent(v.path))
        xml:add_child(nxml.parse(([[
            <LuaComponent
                script_death="%s"
                >
            </LuaComponent>
        ]]):format(v.script)))
        ModTextFileSetContent(v.path, tostring(xml))
    end

    ModLuaFileAppend("mods/souls/files/scripts/souls.lua", "mods/tome_magic/files/scripts/souls_append.lua")

    function OnPlayerSpawned(player)
        if GameHasFlagRun("tome_magic_init") then return end
        GameAddFlagRun("tome_magic_init")
    end
else
    function OnPlayerSpawned(player)
        GamePrint("Activate Souls.")
    end
end