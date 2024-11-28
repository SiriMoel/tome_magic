dofile_once("mods/tome_magic/files/scripts/utils.lua")

soul_groups = {
    { "bat", "fly", "worm", "spider" },
    { "zombie", "orcs", "slimes", "friendly" },
    { "fungus", "mage", "ghost", "gilded" },
}

GamePrint("tome magic souls_append.lua ran!")

function GetSoulFromGroup(group)
    local upto = 1
    for i=1,#soul_groups[group] do
        while upto < 4 do
            if GetSoulsCount(soul_groups[group][upto]) > 0 then
                return soul_groups[group][upto]
            else
                upto = upto + 1
            end
        end
        return ""
    end
end

function RemoveSoulFromGroup(group)
    local soul = GetSoulFromGroup(group)
    if soul ~= "" then
        RemoveSoul(soul)
    end
end

function GetTotalSoulsOfGroup(group)
    local amount = 0
    for i=1,#soul_groups[group] do
        amount = amount + GetSoulsCount(soul_groups[group][i])
    end
    return amount
end