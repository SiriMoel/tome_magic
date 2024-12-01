if not ModIsEnabled("souls") then
    function OnPlayerSpawned(player)
        GamePrint("Activate Souls.")
    end
    return
end

ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/tome_magic/files/actions.lua" )

ModLuaFileAppend("mods/souls/files/scripts/souls.lua", "mods/tome_magic/files/scripts/souls_append.lua")

dofile_once("mods/souls/files/scripts/souls.lua")

local nxml = dofile_once("mods/tome_magic/lib/nxml.lua")

-- biome things
local biomes = {
    {
        path = "data/scripts/biomes/mountain_tree.lua",
        script = "mods/tome_magic/files/scripts/biome/mountain_tree.lua",
    },
}
for i,v in ipairs(biomes) do
    if ModTextFileGetContent(v.path) ~= nil then
        ModLuaFileAppend(v.path, v.script)
    end
end

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

-- page icon generation
local pages = { "tiny", "dragon", "pyramid", "squidward", "leviathan", "spirit", "ghost", "grandmaster", "alchemist", "robot", "meat" }
for i,page in ipairs(pages) do
    local base_id, base_w, base_h = ModImageMakeEditable("mods/tome_magic/files/spell_icons/page.png", 16, 16)
    local page_id, page_w, page_h = ModImageMakeEditable("mods/tome_magic/files/spell_icons/tome_page_" .. page .. ".png", 16, 16)
    if page_id ~= nil then
        for k=1,16 do
            for n=1,16 do
                local pixel = ModImageGetPixel(page_id, k, n)
                if pixel ~= nil then
                    if pixel == 0 then
                        ModImageSetPixel(page_id, k, n, ModImageGetPixel(base_id, k, n))
                    end
                end
            end
        end
    end
end

--translations
local translations = ModTextFileGetContent( "data/translations/common.csv" );
if translations ~= nil then
    while translations:find("\r\n\r\n") do
        translations = translations:gsub("\r\n\r\n","\r\n")
    end
    local new_translations = ModTextFileGetContent( table.concat({"mods/tome_magic/files/translations.csv"}) )
    translations = translations .. new_translations
    ModTextFileSetContent( "data/translations/common.csv", translations )
end

function OnPlayerSpawned(player)
    dofile_once("mods/tome_magic/files/gui.lua")

    if GameHasFlagRun("tome_magic_init") then return end

    local px, py = EntityGetTransform(player)

    TomeMagicSetActiveSoulGroup(2, false)
    TomeMagicSetTeleCoords(px, py)

    GameAddFlagRun("tome_magic_init")
end