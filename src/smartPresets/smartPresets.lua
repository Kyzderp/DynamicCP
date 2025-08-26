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
-- returns: fatecarverUnlocked, isStamHigher, isPragmatic, craftingMaxed
local function GetDecisions()
    -- Whether skills are unlocked
    local fatecarverUnlocked = false
    local jabsUnlocked = false
    local pragmatic = false
    for skillLineIndex = 1, GetNumSkillLines(SKILL_TYPE_CLASS) do
        local skillLineId = GetSkillLineId(SKILL_TYPE_CLASS, skillLineIndex)
        local _, _, isActive = GetSkillLineDynamicInfo(SKILL_TYPE_CLASS, skillLineIndex)
        -- Aedric Spear and Herald of the Tome
        if (isActive and skillLineId == 22 or skillLineId == 218) then
            for skillIndex = 1, GetNumSkillAbilities(SKILL_TYPE_CLASS, skillLineIndex) do
                local progressionId = GetProgressionSkillProgressionId(SKILL_TYPE_CLASS, skillLineIndex, skillIndex)

                -- Fatecarver
                if (progressionId == 535) then
                    local _, _, _, _, _, purchased = GetSkillAbilityInfo(SKILL_TYPE_CLASS, skillLineIndex, skillIndex)
                    if (purchased) then
                        fatecarverUnlocked = true
                        local morph = GetProgressionSkillCurrentMorphSlot(progressionId)
                        if (morph == MORPH_SLOT_MORPH_2) then
                            pragmatic = true
                        end
                    end
                    break

                -- Jabs
                elseif (progressionId == 43) then
                    local _, _, _, _, _, purchased = GetSkillAbilityInfo(SKILL_TYPE_CLASS, skillLineIndex, skillIndex)
                    if (purchased) then
                        jabsUnlocked = true
                    end
                    break
                end
            end
        end
    end

    -- Whether stam or mag is higher
    local _, maxStam, effectiveMaxStam = GetUnitPower("player", COMBAT_MECHANIC_FLAGS_STAMINA)
    local _, maxMag, effectiveMaxMag = GetUnitPower("player", COMBAT_MECHANIC_FLAGS_MAGICKA)

    -- Whether all crafting lines are maxed
    local craftingMaxed = true
    for skillLineIndex = 1, GetNumSkillLines(SKILL_TYPE_TRADESKILL) do
        local rank = GetSkillLineDynamicInfo(SKILL_TYPE_TRADESKILL, skillLineIndex)
        if (rank < 50) then
            craftingMaxed = false
            break
        end
    end

    -- Whether this is a "heavy attack" build: look for Sergeant's Mail and lightning staff
    local isHABuild = false
    local _, _, _, numSergeant = GetItemSetInfo(29)
    if (numSergeant >= 3) then
        local function IsLightning(slot)
            local itemLink = GetItemLink(BAG_WORN, slot)
            return GetItemLinkWeaponType(itemLink) == WEAPONTYPE_LIGHTNING_STAFF
        end
        isHABuild = IsLightning(EQUIP_SLOT_MAIN_HAND) or IsLightning(EQUIP_SLOT_BACKUP_MAIN)
    end

    return fatecarverUnlocked, maxStam > maxMag, pragmatic, craftingMaxed, jabsUnlocked, isHABuild
end

-- We don't care about existing points, i.e. overwrite anything
-- So just go down the data list and allocate as many as max points allow
-- params: tree name as color string, the struct with the preset, total points (for testing) or nil
local function ApplySmartPreset(tree, preset, totalPoints)
    local disciplineIndex = TREE_TO_DISCIPLINE[tree]
    if (not totalPoints) then
        totalPoints = GetNumSpentChampionPoints(disciplineIndex) + GetNumUnspentChampionPoints(disciplineIndex)
    end

    local fatecarverUnlocked, isStamHigher, isPragmatic, craftingMaxed, jabsUnlocked, isHABuild = GetDecisions()
    DynamicCP.dbg(string.format("%s; %s; %s; %s; %s; %s",
        fatecarverUnlocked and "fatecarver available" or "no fatecarver",
        isStamHigher and "stam higher" or "mag higher",
        isPragmatic and "is pragmatic" or "not pragmatic",
        craftingMaxed and "crafting maxed" or "crafting not maxed",
        jabsUnlocked and "jabs" or "no jabs",
        isHABuild and "HA" or "not HA"))

    local currentTotalPoints = 0
    local pendingPoints = {} -- {[10] = 10,}
    local slottables = {}
    local deprioritizedSlottables = {}
    local pendingCP = {
        [disciplineIndex] = pendingPoints,
        slottables = slottables,
    }
    for _, node in ipairs(preset.nodes) do
        local id, stage
        if (node.id) then
            id = node.id
        elseif (node.flex) then
            local hasAoeSpammable = fatecarverUnlocked or jabsUnlocked
            id = preset.GetFlex(hasAoeSpammable, isHABuild, isPragmatic, craftingMaxed, node.flex, totalPoints)
        elseif (node.passive) then
            id = preset.GetPassive(isStamHigher, node.passive)
        end
        stage = node.stage -- can be nil

        -- id -1 means skip. Likely used for Inspiration Boost flex
        if (id ~= -1) then
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

            -- If it's slottable, put it in desired slottables in order of maxing
            if (#slottables < 4 and CanChampionSkillTypeBeSlotted(GetChampionSkillType(id)) and desiredPoints == GetChampionSkillMaxPoints(id)) then
                if (node.deprioritizeSlotting) then
                    table.insert(deprioritizedSlottables, id)
                else
                    table.insert(slottables, id)
                end
            end

            -- Not enough points to continue
            if (currentTotalPoints >= totalPoints) then
                -- If there were deprioritizeSlotting slottables, they can be slotted if there is still space
                for _, id in ipairs(deprioritizedSlottables) do
                    if (#slottables >= 4) then
                        break
                    end
                    table.insert(slottables, id)
                end

                return pendingCP
            end
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
                return "Auto Combat |t100%:100%:esoui/art/icons/mapkey/mapkey_raiddungeon.dds|t"
            end,
            applyFunc = DynamicCP.SmartPresets.ApplyGreenCombat,
        },
        ["DEFAULT_SMART_GREEN_LOOT_GOBLIN"] = {
            name = function()
                return "Auto Craft/Loot |t80%:80%:esoui/art/icons/ability_tradecraft_005.dds|t"
            end,
            applyFunc = DynamicCP.SmartPresets.ApplyGreenLootGoblin,
        },
        ["DEFAULT_SMART_GREEN_THIEVING"] = {
            name = function()
                return "Auto Thieving |t100%:100%:esoui/art/icons/crowncrate_sweetroll.dds|t"
            end,
            applyFunc = DynamicCP.SmartPresets.ApplyGreenThieving,
        },
    },
    Blue = {
        ["DEFAULT_SMART_BLUE_PVE"] = {
            name = function()
                local fatecarverUnlocked, isStamHigher, isPragmatic, craftingMaxed, jabsUnlocked, isHABuild = GetDecisions()
                local build
                if (isHABuild) then
                    build = " |t80%:80%:esoui/art/icons/death_recap_shock_ranged.dds|t"
                elseif (fatecarverUnlocked) then
                    build = " |t80%:80%:esoui/art/icons/ability_arcanist_002.dds|t"
                elseif (jabsUnlocked) then
                    build = " |t80%:80%:esoui/art/icons/ability_templar_trained_attacker.dds|t"
                else
                    build = ""
                end
                return string.format("Auto PvE %s%s%s",
                    ROLE_ICONS[GetSelectedLFGRole()] or "?",
                    build,
                    isStamHigher and "|t100%:100%:esoui/art/characterwindow/gamepad/gp_charactersheet_staminaicon.dds|t" or "|t100%:100%:esoui/art/characterwindow/gamepad/gp_charactersheet_magickaicon.dds|t"
                    )
            end,
            applyFunc = DynamicCP.SmartPresets.ApplyBluePVE,
        },
    },
    Red = {
        ["DEFAULT_SMART_RED_PVE"] = {
            name = function()
                local fatecarverUnlocked, isStamHigher, isPragmatic = GetDecisions()
                return string.format("Auto PvE %s%s",
                    ROLE_ICONS[GetSelectedLFGRole()] or "?",
                    isPragmatic and " |t80%:80%:esoui/art/icons/ability_arcanist_002_b.dds|t" or ""
                    )
            end,
            applyFunc = DynamicCP.SmartPresets.ApplyRedPVE,
        },
    },
}
