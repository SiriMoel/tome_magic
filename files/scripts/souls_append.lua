dofile_once("mods/tome_magic/files/scripts/utils.lua")

soul_groups = {
    { "bat", "fly", "worm", "spider" },
    { "zombie", "orcs", "slimes", "friendly" },
    { "fungus", "mage", "ghost", "souls_void" },
}

soul_group_names = { "Rising", "Lesser", "Special" }

function GetSoulFromGroup(group)
    local upto = 1
    for i=1,#soul_groups[group] do
        if GetSoulsCount(soul_groups[group][i]) > 0 then
            return soul_groups[group][i]
        end
    end
    return ""
end

function RemoveSoulFromGroup(group)
    local soul = GetSoulFromGroup(group)
    if soul ~= "" then
        RemoveSoul(soul)
    end
end

function RemoveSoulsFromGroup(group, count)
    for i=1,count do
        RemoveSoulFromGroup(group)
    end
end

function GetTotalSoulsOfGroup(group)
    local amount = 0
    for i=1,#soul_groups[group] do
        amount = amount + GetSoulsCount(soul_groups[group][i])
    end
    return amount
end

function GetSoulGroupName(group, includesouls)
    local string = ""
    string = soul_group_names[group] .. " souls"
    if includesouls then
        string = string .. " ("
        for i=1,#soul_groups[group] do
            string = string .. SoulNameCheck(soul_groups[group][i])
            if i == 4 then
                 string = string .. ")"
            else
                string = string .. ", "
            end
        end
    end
    return string
end

function TomeMagicGetActiveSoulGroup()
    return tonumber(GlobalsGetValue("tome_magic_active_soul_group", "2"))
end

function TomeMagicSetActiveSoulGroup(num, announce)
    if announce then
        GamePrint("Now consuming " .. GetSoulGroupName(num, true))
    end
    GlobalsSetValue("tome_magic_active_soul_group", tostring(num))
end

function TomeMagicGetTeleCoords()
    return tonumber(GlobalsGetValue("tome_magic_tele_x", "0")), tonumber(GlobalsGetValue("tome_magic_tele_y", "0"))
end

function TomeMagicSetTeleCoords(x, y)
    GlobalsSetValue("tome_magic_tele_x", tostring(math.floor(x + 0.5)))
    GlobalsSetValue("tome_magic_tele_y", tostring(math.floor(y + 0.5)))
end

function TomeMagicGetTeleSoulCost(x, y)
    local cost = 0
    local dest_x, dest_y = TomeMagicGetTeleCoords()
    local dist = DistanceBetween(x, y, dest_x, dest_y)
    cost = math.ceil(dist / 250) + 5
    return cost
end

function GetTomePageCountOnTome(tome)
    local targets = EntityGetAllChildren(tome, "souls_tome_page")
    --GamePrint("tome page count: " .. tostring(#targets)) -- TESTING
    return #targets
end