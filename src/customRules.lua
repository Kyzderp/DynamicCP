DynamicCP = DynamicCP or {}

---------------------------------------------------------------------
-- Constants
DynamicCP.DIFFICULTY_NORMAL = 1
DynamicCP.DIFFICULTY_VETERAN = 2

DynamicCP.TRIGGER_TRIAL             =  1 -- (DungeonDifficulty)
DynamicCP.TRIGGER_GROUP_DUNGEON     =  2
DynamicCP.TRIGGER_PUBLIC_DUNGEON    =  3
DynamicCP.TRIGGER_DELVE             =  4
DynamicCP.TRIGGER_OVERLAND          =  5
DynamicCP.TRIGGER_CYRO              =  6
DynamicCP.TRIGGER_IC                =  7
DynamicCP.TRIGGER_ZONEID            =  8
DynamicCP.TRIGGER_BOSS              =  9
DynamicCP.TRIGGER_BOSSNAME          = 10

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


---------------------------------------------------------------------
-- Data
---------------------------------------------------------------------
local function SortRuleKeys()
    -- TODO: automatically sort them such that specific rule are at the top
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

-- Iterate through all rules and find a matching one
local function GetRuleForTrigger(trigger, isVet, param1, param2)
    local requiredParams = triggerParams[trigger]
    local role = GetPlayerRole()
    local difficulty = isVet and "veteran" or "normal"

    -- TODO: iterate using sorted keys instead
    for name, rule in pairs(DynamicCP.savedOptions.customRules.rules) do
        if (rule.trigger == trigger
            and (param1 == nil or rule[requiredParams[1]] == param1)
            and (param2 == nil or rule[requiredParams[2]] == param2)
            ) then
            if (rule[role] and rule[difficulty]) then
                return name
            end
        end
    end

    return nil
end

-- Apply the stars from this rule
local function ApplyRule(rule)
    local message = "Applying:"

    PrepareChampionPurchaseRequest(false)
    for slotIndex, skillId in pairs(rule.stars) do
        local color = "e46b2e" -- Red
        if (slotIndex <= 8) then color = "59bae7" end -- Blue
        if (slotIndex <= 4) then color = "a5d752" end -- Green
        message = message .. zo_strformat("\n|c<<1>> <<2>> - <<C:3>>",
                color, slotIndex, GetChampionSkillName(skillId))

        local unlocked = WouldChampionSkillNodeBeUnlocked(skillId, GetNumPointsSpentOnChampionSkill(skillId))
        if (not unlocked) then
            message = message .. " |cFF2222not unlocked"
        else
            AddHotbarSlotToChampionPurchaseRequest(slotIndex, skillId)
        end
    end
    SendChampionPurchaseRequest()
    -- TODO: keep track of what is being applied and cancel if same
    -- TODO: handle overrideOrder

    DynamicCP.msg(message)
end

-- TODO: make a first-time dialog box

---------------------------------------------------------------------
-- Events
-- Params: initial - true if first time entering, false if going through door etc.
---------------------------------------------------------------------
local function OnEnteredTrial(initial)
    DynamicCP.dbg("|cFF4444Entered a TRIAL difficulty "
        .. difficulties[GetCurrentZoneDungeonDifficulty()] .. "|r")

    local ruleName = GetRuleForTrigger(DynamicCP.TRIGGER_TRIAL, GetCurrentZoneDungeonDifficulty() == DUNGEON_DIFFICULTY_VETERAN)
    if (not ruleName) then return end
    local rule = DynamicCP.savedOptions.customRules.rules[ruleName]

    -- Artificial couple second wait to make it more noticeable for user
    -- hopefully after they've exited loadscreen
    EVENT_MANAGER:RegisterForUpdate(DynamicCP.name .. "CustomApply", 3000, function()
        EVENT_MANAGER:UnregisterForUpdate(DynamicCP.name .. "CustomApply")
        ApplyRule(rule)
    end)
end


---------------------------------------------------------------------
-- Entry point
---------------------------------------------------------------------
local function OnPlayerActivated()
    DynamicCP.dbg(string.format("IsActiveWorldGroupOwnable: %s IsUnitInDungeon: %s",
        tostring(IsActiveWorldGroupOwnable()),
        tostring(IsUnitInDungeon("player"))
    ))
    -- Trial: groupownable true indungeon true
    -- Solo arena: groupownable false indungeon true
    local zoneId = GetZoneId(GetUnitZoneIndex("player"))
    local initial = zoneId == lastZoneId
    lastZoneId = zoneId

    -- TODO: maybe priority order isn't needed because you would always want specifics to take priority over the generic ones

    if (DynamicCP.TRIAL_ZONEIDS[tostring(zoneId)]) then
        OnEnteredTrial(initial)
    end
end

---------------------------------------------------------------------
-- Init
function DynamicCP.InitCustomRules()
    EVENT_MANAGER:RegisterForEvent(DynamicCP.name .. "CustomActivated", EVENT_PLAYER_ACTIVATED, OnPlayerActivated)
end
