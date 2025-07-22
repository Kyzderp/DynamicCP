DynamicCP = DynamicCP or {}

--[[
]]

local TREE_TO_DISCIPLINE = {
    Green = 1,
    Blue = 2,
    Red = 3,
}

-----------------------------------------------------------
-- Beam vs ST (more later?)
-----------------------------------------------------------
local blue_dps_flex_arc = {
    264, -- Master-at-Arms
    23, -- Biting Aura
    8, -- Wrathful Strikes
    277, -- Exploiter
}

local blue_dps_flex_st = {
    264, -- Master-at-Arms
    25, -- Deadly Aim
    8, -- Wrathful Strikes
    277, -- Exploiter
}


-----------------------------------------------------------
-- Passive stats
-----------------------------------------------------------
local blue_dps_stam = { -- TODO: fatecarver "mag" instead?
    18, -- Battle Mastery
    22, -- Mighty
    17, -- Flawless Ritual
    21, -- War Mage
    6, -- Tireless Discipline
    99, -- Eldritch Insight
}

local blue_dps_mag = {
    17, -- Flawless Ritual
    21, -- War Mage
    18, -- Battle Mastery
    22, -- Mighty
    99, -- Eldritch Insight
    6, -- Tireless Discipline
}


-----------------------------------------------------------
-- Role presets
-----------------------------------------------------------
-- If stage is not specified, the star will be maxed out
-- If flex is specified, it uses the index in the flex data
-- If passive is specified, it uses the index in the respective data
-----------------------------------------------------------
local BLUE_DPS = {
    GetFlex = function(fatecarverUnlocked, index)
        if (fatecarverUnlocked) then
            return blue_dps_flex_arc[index]
        end
        return blue_dps_flex_st[index]
    end,
    GetPassive = function(isStamHigher, index)
        if (isStamHigher) then
            return blue_dps_stam[index]
        end
        return blue_dps_mag[index]
    end,
    nodes = {
        {
            id = 10, -- Piercing (open nodes)
            stage = 1,
        },
        {
            flex = 1,
        },
        {
            flex = 2,
        },
        {
            id = 11, -- Precision (open nodes)
            stage = 1,
        },
        {
            flex = 3,
        },
        {
            flex = 4,
        },
        {
            id = 10, -- Piercing (maxed)
        },
        {
            id = 11, -- Precision (maxed)
        },
        {
            passive = 1, -- Flawless Ritual / Battle Mastery
        },
        {
            passive = 2, -- War Mage / Mighty
        },
        {
            passive = 3, -- Flawless Ritual / Battle Mastery
        },
        {
            passive = 4, -- War Mage / Mighty
        },
        {
            passive = 5, -- Eldritch Insight / Tireless Discipline
        },
        {
            id = 20, -- Quick Recovery (open nodes)
            stage = 1,
        },
        {
            id = 14, -- Preparation
        },
        {
            id = 15, -- Elemental Aegis
        },
        {
            id = 16, -- Hardy
        },
        {
            id = 20, -- Quick Recovery (maxed)
        },
        {
            id = 108, -- Blessed
        },
        -- 4 slottables and all passives done
    },
}


-----------------------------------------------------------
-- Apply the preset??
-----------------------------------------------------------
-- returns: fatecarverUnlocked, isStamHigher
local function GetDecisions()
    -- Whether fatecarver is unlocked
    local fatecarverUnlocked = false
    for skillLineIndex = 1, GetNumSkillLines(SKILL_TYPE_CLASS) do
        local skillLineId = GetSkillLineId(SKILL_TYPE_CLASS, skillLineIndex)
        -- Herald of the Tome
        if (skillLineId == 218) then
            local _, _, isActive = GetSkillLineDynamicInfo(SKILL_TYPE_CLASS, skillLineIndex)
            if (not isActive) then
                break
            end

            for skillIndex = 1, GetNumSkillAbilities(SKILL_TYPE_CLASS, skillLineIndex) do
                local progressionId = GetProgressionSkillProgressionId(SKILL_TYPE_CLASS, skillLineIndex, skillIndex)
                -- d(name .. " " .. tostring(progressionId))
                -- Herald of the Tome
                if (progressionId == 535) then
                    local _, _, _, _, _, purchased = GetSkillAbilityInfo(SKILL_TYPE_CLASS, skillLineIndex, skillIndex)
                    if (purchased) then
                        fatecarverUnlocked = true
                    end
                end
            end
        end
    end

    -- Whether stam or mag is higher
    local _, maxStam, effectiveMaxStam = GetUnitPower("player", COMBAT_MECHANIC_FLAGS_STAMINA)
    local _, maxMag, effectiveMaxMag = GetUnitPower("player", COMBAT_MECHANIC_FLAGS_MAGICKA)
    return fatecarverUnlocked, maxStam > maxMag
end

-- We don't care about existing points, i.e. overwrite anything
-- So just go down the data list and allocate as many as max points allow
local function ApplySmartPreset(tree, preset, totalPoints)
    local fatecarverUnlocked, isStamHigher = GetDecisions()
    DynamicCP.dbg(string.format("%s; %s",
        fatecarverUnlocked and "fatecarver available" or "no fatecarver",
        isStamHigher and "stam higher" or "mag higher"))

    local currentTotalPoints = 0
    local pendingPoints = {} -- {[10] = 10,}
    local slottables = {}
    local disciplineIndex = TREE_TO_DISCIPLINE[tree]
    local pendingCP = {
        [disciplineIndex] = pendingPoints,
        slottables = slottables,
    }
    for _, node in ipairs(preset.nodes) do
        local id, stage
        if (node.id) then
            id = node.id
            stage = node.stage
        elseif (node.flex) then
            id = preset.GetFlex(fatecarverUnlocked, node.flex)
        elseif (node.passive) then
            id = preset.GetPassive(isStamHigher, node.passive)
        end

        -- Get number of points to use, including previous partial opens
        local existingPoints = pendingPoints[id] or 0
        local desiredPoints
        if (stage) then
            desiredPoints = select(stage + 1, GetChampionSkillJumpPoints(id))-- 0, 10, 20
        else
            desiredPoints = GetChampionSkillMaxPoints(id)
        end
        local pointsToAllocate = desiredPoints - existingPoints

        -- Not enough CP, spend the last bit
        if (currentTotalPoints + pointsToAllocate > totalPoints) then
            DynamicCP.dbg("Ran out of points at " .. GetChampionSkillName(id))
            local overflow = currentTotalPoints + pointsToAllocate - totalPoints
            desiredPoints = desiredPoints - overflow
            pointsToAllocate = totalPoints - currentTotalPoints
        end

        -- "Put" the points in
        DynamicCP.dbg(string.format("Putting %d points into %s", pointsToAllocate, GetChampionSkillName(id)))
        pendingPoints[id] = desiredPoints
        currentTotalPoints = currentTotalPoints + pointsToAllocate

        -- If it's slottable, put it in desired slottables
        if (#slottables < 4 and CanChampionSkillTypeBeSlotted(GetChampionSkillType(id))) then
            table.insert(slottables, id)
        end

        -- Not enough points to continue
        if (currentTotalPoints >= totalPoints) then
            return pendingCP
        end
    end
    DynamicCP.dbg("Finished all desired nodes")
    return pendingCP
end
DynamicCP.ApplySmartPreset = ApplySmartPreset -- /script DynamicCP.ApplySmartPreset(67)

-----------------------------------------------------------
-- To be called from presets
-----------------------------------------------------------
local function ApplyBluePVE()
    local totalPoints = GetNumSpentChampionPoints(1) + GetNumUnspentChampionPoints(1)
    -- TODO: role
    return ApplySmartPreset("Blue", BLUE_DPS, totalPoints)
end

local ROLE_ICONS = {
    [LFG_ROLE_TANK] = "|t100%:100%:esoui/art/lfg/lfg_tank_down_no_glow_64.dds|t",
    [LFG_ROLE_HEAL] = "|t100%:100%:esoui/art/lfg/lfg_healer_down_no_glow_64.dds|t",
    [LFG_ROLE_DPS] = "|t100%:100%:esoui/art/lfg/lfg_dps_down_no_glow_64.dds|t",
}

DynamicCP.SMART_PRESETS = {
    Green = {},
    Blue = {
        ["DEFAULT_SMART_BLUE_DPS"] = {
            name = function()
                local fatecarverUnlocked, isStamHigher = GetDecisions()
                d(fatecarverUnlocked, isStamHigher)
                return string.format("Auto PvE %s%s%s",
                    ROLE_ICONS[GetSelectedLFGRole()],
                    fatecarverUnlocked and " |t80%:80%:esoui/art/icons/ability_arcanist_002_b.dds|t" or "",
                    isStamHigher and "|t100%:100%:esoui/art/characterwindow/gamepad/gp_charactersheet_staminaicon.dds|t" or "|t100%:100%:esoui/art/characterwindow/gamepad/gp_charactersheet_magickaicon.dds|t"
                    )
            end,
            func = ApplyBluePVE,
        },
    },
    Red = {},
}
