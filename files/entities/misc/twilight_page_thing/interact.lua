dofile_once("mods/tome_magic/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function ReturnSouls()
    for i,soul in ipairs(soul_types) do
        AddSouls(soul, ModSettingGet("tome_magic.twilight_page_" .. soul .. "_soul_count"))
        ModSettingSet("tome_magic.twilight_page_" .. soul .. "_soul_count", 0)
    end
    GamePrint("Souls returned!")
    EntityKill(GetUpdatedEntityID())
end

function interacting()
    ReturnSouls()
end

function kick()
    ReturnSouls()
end