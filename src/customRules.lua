DynamicCP = DynamicCP or {}

---------------------------------------------------------------------
-- Constants
DynamicCP.TRIGGER_TRIAL             = "Trial"
DynamicCP.TRIGGER_GROUP_ARENA       = "Group Arena"
DynamicCP.TRIGGER_SOLO_ARENA        = "Solo Arena"
DynamicCP.TRIGGER_GROUP_DUNGEON     = "Group Dungeon"
DynamicCP.TRIGGER_PUBLIC_DUNGEON    = "Public Dungeon"
DynamicCP.TRIGGER_DELVE             = "Delve"
DynamicCP.TRIGGER_OVERLAND          = "Overland"
DynamicCP.TRIGGER_CYRO              = "Cyrodiil"
DynamicCP.TRIGGER_IC                = "Imperial City"
DynamicCP.TRIGGER_ZONEID            = "Specific Zone"
DynamicCP.TRIGGER_BOSS              = "Boss Area"
DynamicCP.TRIGGER_BOSSNAME          = "Specific Boss Name"

local triggerParams = {
    [DynamicCP.TRIGGER_TRIAL] = {
    },
}

local difficulties = {
    [DUNGEON_DIFFICULTY_NONE] = "NONE",
    [DUNGEON_DIFFICULTY_NORMAL] = "NORMAL",
    [DUNGEON_DIFFICULTY_VETERAN] = "VETERAN",
}

local lastZoneId = 0
local sortedKeys = {}

---------------------------------------------------------------------
-- First-time dialog box
---------------------------------------------------------------------
function DynamicCP.ShowFirstTimeDialog()
    local text = string.format("Welcome to Dynamic CP v%s!\n\nYou now have the ability to set custom rules for slottable stars. These are conditions that you can define to slot certain stars when you enter certain zones.\n\nThe current defaults demonstrate how to set up a general rule for green stars to slot upon entering a trial, as well as a rule only for DPS to slot blue and red stars upon entering a trial. If you are on a DPS character, both of these rules will be applied when you enter a trial.\n\nGo to the custom rules menu now to add, delete, or change rules?",
        DynamicCP.version
        )
    DynamicCP.ShowModelessPrompt(text, DynamicCP.OpenCustomRulesMenu)
end


---------------------------------------------------------------------
-- Data
---------------------------------------------------------------------
local function SortRuleKeys()
    local sortedRules = {}
    for name, rule in pairs(DynamicCP.savedOptions.customRules.rules) do
        table.insert(sortedRules, {name = name, priority = rule.priority})
    end

    table.sort(sortedRules, function(item1, item2)
        return item1.priority < item2.priority
    end)

    sortedKeys = {}
    for _, data in ipairs(sortedRules) do
        table.insert(sortedKeys, data.name)
    end
end
DynamicCP.SortRuleKeys = SortRuleKeys

local function GetSortedKeys()
    return sortedKeys
end
DynamicCP.GetSortedKeys = GetSortedKeys

local function GetFlippedSlottables()
    local committed = DynamicCP.GetCommittedSlottables() -- [skillId] = index
    local flipped = {}
    for skillId, slotIndex in pairs(committed) do
        flipped[slotIndex] = skillId
    end
    return flipped
end


---------------------------------------------------------------------
-- Rules handling
---------------------------------------------------------------------
local function GetPlayerRole()
    local roles = {
        [LFG_ROLE_DPS] = "dps",
        [LFG_ROLE_HEAL] = "healer",
        [LFG_ROLE_TANK] = "tank",
    }
    local role = roles[GetSelectedLFGRole()]

    -- TODO: extra handling with roles like player-specified or something. smh fake tanks and healers

    return role
end

-- Convert the pending slottables into the request
local function ProcessAndCommitRules(sortedRuleNames, pendingSlottables, triggerString)
    local flipped = GetFlippedSlottables()
    local diffMessages = {}
    PrepareChampionPurchaseRequest(false)
    for slotIndex, skillId in pairs(pendingSlottables) do
        local unlocked = WouldChampionSkillNodeBeUnlocked(skillId, GetNumPointsSpentOnChampionSkill(skillId))
        local color = "e46b2e" -- Red
        if (slotIndex <= 8) then color = "59bae7" end -- Blue
        if (slotIndex <= 4) then color = "a5d752" end -- Green
        local diffMessage = zo_strformat("|c<<1>><<2>> - <<C:3>> → <<C:4>>",
                color, slotIndex, GetChampionSkillName(flipped[slotIndex]), GetChampionSkillName(skillId))
        if (unlocked) then
            if (flipped[slotIndex] == skillId) then
                -- If it's the same skill in the same slot, we can skip it
                -- DynamicCP.dbg("skipping " .. tostring(slotIndex))
            else
                -- Not the same
                AddHotbarSlotToChampionPurchaseRequest(slotIndex, skillId)
                table.insert(diffMessages, diffMessage)
            end
        else
            diffMessage = diffMessage .. " |cFF4444- not unlocked"
            table.insert(diffMessages, diffMessage)
        end
    end
    SendChampionPurchaseRequest()
    -- TODO: handle promptConflicts
    -- TODO: automatic filling. maybe also automatic filling even if no other slots are changed?

    if (DynamicCP.savedOptions.customRules.showInChat) then
        DynamicCP.msg(string.format("%s\n|cAAAAAAApplying rules %s:\n%s",
            triggerString,
            table.concat(sortedRuleNames, " < "),
            table.concat(diffMessages, "\n")))
    end

    if (DynamicCP.savedOptions.customRules.playSound) then
        PlaySound(SOUNDS.CHAMPION_POINTS_COMMITTED)
    end
end

-- Iterate through all rules and find any matching ones
local function GetSortedRulesForTrigger(trigger, isVet, param1, param2)
    local requiredParams = triggerParams[trigger]
    local role = GetPlayerRole()
    local difficulty = isVet and "veteran" or "normal"
    local ruleNames = {}
    local numRules = 0
    local charId = GetCurrentCharacterId()

    -- Iterate using sorted keys so we get them in prioritized order
    for _, name in ipairs(GetSortedKeys()) do
        local rule = DynamicCP.savedOptions.customRules.rules[name]
        if (rule.trigger == trigger
            and (param1 == nil or rule[requiredParams[1]] == param1)
            and (param2 == nil or rule[requiredParams[2]] == param2)
            ) then
            if (rule[role] and rule[difficulty] and rule.chars[charId]) then
                table.insert(ruleNames, name)
                numRules = numRules + 1
            end
        end
    end

    if (numRules == 0) then return nil end
    return ruleNames
end

-- Apply the stars from this rule
local function ApplyRules(sortedRuleNames, triggerString)
    if (not sortedRuleNames) then return end

    -- First pass collects them into pending, overwriting lower priority rules
    local pendingSlottables = {}
    for _, ruleName in ipairs(sortedRuleNames) do
        local rule = DynamicCP.savedOptions.customRules.rules[ruleName]
        for slotIndex, skillId in pairs(rule.stars) do
            if (skillId ~= -1) then
                pendingSlottables[slotIndex] = skillId
            end
        end
    end

    -- Second pass checks if all of the stars are already slotted, or if they're all in the same slots
    local committed = DynamicCP.GetCommittedSlottables() -- [skillId] = slotIndex
    local hasUnslotted = false
    local hasDifferentSlot = false
    for slotIndex, skillId in pairs(pendingSlottables) do
        if (not committed[skillId]) then
            hasUnslotted = true
            break
        elseif (committed[skillId] ~= slotIndex) then
            hasDifferentSlot = true
        end
    end
    if (not hasUnslotted) then
        if (hasDifferentSlot) then -- If there are stars in different slots, check override
            DynamicCP.dbg("Stars are already slotted in different order")
            if (not DynamicCP.savedOptions.customRules.overrideOrder) then
                -- If not overriding, then we're done here
                return
            end
        else
            DynamicCP.msg(triggerString .. "\n|cAAAAAAAll stars are already slotted from rules " .. table.concat(sortedRuleNames, " < "))
            return
        end
    end

    -- If autoslotting then we can just do it immediately, no need for dialog
    if (DynamicCP.savedOptions.customRules.autoSlot) then
        ProcessAndCommitRules(sortedRuleNames, pendingSlottables, triggerString)
    else
        -- Third pass to generate text for the dialog. Not the most efficient probably...
        local flipped = GetFlippedSlottables()
        local diffMessages = {}
        for slotIndex, skillId in pairs(pendingSlottables) do
            local unlocked = WouldChampionSkillNodeBeUnlocked(skillId,
                GetNumPointsSpentOnChampionSkill(skillId))
            local color = "e46b2e" -- Red
            if (slotIndex <= 8) then color = "59bae7" end -- Blue
            if (slotIndex <= 4) then color = "a5d752" end -- Green
            local diffMessage = zo_strformat("|c<<1>><<2>> - <<C:3>> → <<C:4>>",
                    color, slotIndex, GetChampionSkillName(flipped[slotIndex]), GetChampionSkillName(skillId))
            if (not unlocked) then
                diffMessage = diffMessage .. " |cFF4444- not unlocked"
                table.insert(diffMessages, diffMessage)
            elseif (unlocked and flipped[slotIndex] ~= skillId) then
                -- Not the same
                table.insert(diffMessages, diffMessage)
            end
        end

        -- It's possible for there to be no changes here if all potential changes aren't unlocked
        if (#diffMessages == 0) then
            DynamicCP.msg(triggerString .. "\n|cAAAAAAAll stars are already slotted from rules " .. table.concat(sortedRuleNames, " < "))
            return
        end

        local text = string.format("%s\nSlot these stars according to the custom rules: %s?\n\n%s",
            triggerString,
            table.concat(sortedRuleNames, " < "),
            table.concat(diffMessages, "\n"))

        DynamicCP.ShowModelessPrompt(text, function()
            ProcessAndCommitRules(sortedRuleNames, pendingSlottables, triggerString)
        end)
    end
end

-- TODO: make a first-time dialog box

---------------------------------------------------------------------
-- Events
-- Params: initial - true if first time entering, false if going through door etc.
---------------------------------------------------------------------
local function OnEnteredTrial(initial)
    if (not initial) then return end -- TODO: make this a setting?
    DynamicCP.dbg("|cFF4444Entered a TRIAL difficulty "
        .. difficulties[GetCurrentZoneDungeonDifficulty()] .. "|r")

    local sortedRuleNames = GetSortedRulesForTrigger(DynamicCP.TRIGGER_TRIAL, GetCurrentZoneDungeonDifficulty() == DUNGEON_DIFFICULTY_VETERAN)
    ApplyRules(sortedRuleNames, zo_strformat("You entered trial <<C:1>> (zone id <<2>>).",
        GetPlayerActiveZoneName(),
        GetZoneId(GetUnitZoneIndex("player"))))
end
DynamicCP.OnEnteredTrial = OnEnteredTrial -- For testing /script DynamicCP.OnEnteredTrial(true)


---------------------------------------------------------------------
-- Entry point
---------------------------------------------------------------------
local function OnPlayerActivated()
    DynamicCP.dbg(string.format("IsActiveWorldGroupOwnable: %s IsUnitInDungeon: %s",
        tostring(IsActiveWorldGroupOwnable()),
        tostring(IsUnitInDungeon("player"))
    ))
    -- Trial: groupownable true indungeon true
    -- Group dungeon: groupownable true indungeon true
    -- Solo arena: groupownable false indungeon true
    -- Overland: false false
    local zoneId = GetZoneId(GetUnitZoneIndex("player"))
    local initial = zoneId ~= lastZoneId
    lastZoneId = zoneId

    if (DynamicCP.TRIAL_ZONEIDS[tostring(zoneId)]) then
        OnEnteredTrial(initial)
    end
end

---------------------------------------------------------------------
-- Init
function DynamicCP.InitCustomRules()
    SortRuleKeys()
    EVENT_MANAGER:RegisterForEvent(DynamicCP.name .. "CustomActivated", EVENT_PLAYER_ACTIVATED, OnPlayerActivated)
end
