DynamicCP = DynamicCP or {}
DynamicCP.SmartPresets = DynamicCP.SmartPresets or {}


local TREE_TO_DISCIPLINE = {
    Green = 1,
    Blue = 2,
    Red = 3,
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
                -- Fatecarver
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
-- params: tree name as color string, the struct with the preset, total points (for testing) or nil
local function ApplySmartPreset(tree, preset, totalPoints)
    local disciplineIndex = TREE_TO_DISCIPLINE[tree]
    if (not totalPoints) then
        totalPoints = GetNumSpentChampionPoints(disciplineIndex) + GetNumUnspentChampionPoints(disciplineIndex)
    end

    local fatecarverUnlocked, isStamHigher = GetDecisions()
    DynamicCP.dbg(string.format("%s; %s",
        fatecarverUnlocked and "fatecarver available" or "no fatecarver",
        isStamHigher and "stam higher" or "mag higher"))

    local currentTotalPoints = 0
    local pendingPoints = {} -- {[10] = 10,}
    local slottables = {}
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
            desiredPoints = select(stage + 1, GetChampionSkillJumpPoints(id)) -- 0, 10, 20
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
local ROLE_ICONS = {
    [LFG_ROLE_TANK] = "|t100%:100%:esoui/art/lfg/lfg_tank_down_no_glow_64.dds|t",
    [LFG_ROLE_HEAL] = "|t100%:100%:esoui/art/lfg/lfg_healer_down_no_glow_64.dds|t",
    [LFG_ROLE_DPS] = "|t100%:100%:esoui/art/lfg/lfg_dps_down_no_glow_64.dds|t",
}

DynamicCP.SMART_PRESETS = {
    Green = {
        ["DEFAULT_SMART_GREEN_COMBAT"] = {
            name = function()
                return "Auto Combat |t80%:80%:esoui/art/icons/ability_arcanist_002_b.dds|t" -- TODO: combat icon
            end,
            applyFunc = DynamicCP.SmartPresets.ApplyGreenCombat,
        },
        ["DEFAULT_SMART_GREEN_LOOT_GOBLIN"] = {
            name = function()
                return "Auto Craft/Loot |t80%:80%:esoui/art/icons/ability_arcanist_002_b.dds|t" -- TODO: crafting icon
            end,
            applyFunc = DynamicCP.SmartPresets.ApplyGreenLootGoblin,
        },
    },
    Blue = {
        ["DEFAULT_SMART_BLUE_PVE"] = {
            name = function()
                local fatecarverUnlocked, isStamHigher = GetDecisions()
                d(string.format("fatecarverUnlocked: %s; isStamHigher: %s, role: %s",
                    fatecarverUnlocked and "true" or "false",
                    isStamHigher and "true" or "false",
                    ROLE_ICONS[GetSelectedLFGRole()] or "?"))
                return string.format("Auto PvE %s%s%s",
                    ROLE_ICONS[GetSelectedLFGRole()] or "?",
                    fatecarverUnlocked and " |t80%:80%:esoui/art/icons/ability_arcanist_002_b.dds|t" or "",
                    isStamHigher and "|t100%:100%:esoui/art/characterwindow/gamepad/gp_charactersheet_staminaicon.dds|t" or "|t100%:100%:esoui/art/characterwindow/gamepad/gp_charactersheet_magickaicon.dds|t"
                    )
            end,
            applyFunc = DynamicCP.SmartPresets.ApplyBluePVE,
        },
    },
    Red = {
        ["DEFAULT_SMART_RED_PVE"] = {
            name = function()
                return string.format("Auto PvE %s%s",
                    ROLE_ICONS[GetSelectedLFGRole()] or "?",
                    fatecarverUnlocked and " |t80%:80%:esoui/art/icons/ability_arcanist_002_b.dds|t" or ""
                    )
            end,
            applyFunc = DynamicCP.SmartPresets.ApplyRedPVE,
        },
    },
}
