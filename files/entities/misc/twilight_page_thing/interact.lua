dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function ReturnSouls()
    for i,soul in ipairs(soul_types) do
        AddSouls(soul, ModSettingGet("tome_magic.twilight_page_" .. soul .. "_soul_count"))
        ModSettingSet("tome_magic.twilight_page_" .. soul .. "_soul_count", 0)
    end
    GamePrintImportant("YOUR SOULS HAVE BEEN RETURNED", "", "mods/tome_magic/files/souls_decoration.png")
    EntityKill(GetUpdatedEntityID())
end

function interacting()
    ReturnSouls()
end

function kick()
    ReturnSouls()
end