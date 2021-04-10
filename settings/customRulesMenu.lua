DynamicCP = DynamicCP or {}


local selectedRuleName = nil
-- /script d(DynamicCP.savedOptions.customRules.rules)

---------------------------------------------------------------------
-- Select which rule to edit dropdown
local ruleDisplays = {}
local ruleValues = {}

local function RefreshCustomRules()
    -- TODO: check for duplicate names
    -- TODO: sort
    for name, ruleData in pairs(DynamicCP.savedOptions.customRules.rules) do
        table.insert(ruleDisplays, name)
        table.insert(ruleValues, name)
    end
end

---------------------------------------------------------------------
-- Trigger dropdown
local triggerDisplays = {
    DynamicCP.TRIGGER_TRIAL,
}

---------------------------------------------------------------------
-- Get string for preview
local triggerToPreview = {
    [DynamicCP.TRIGGER_TRIAL]          = "any trial or arena",
    [DynamicCP.TRIGGER_GROUP_DUNGEON]  = "any group dungeon",
    [DynamicCP.TRIGGER_PUBLIC_DUNGEON] = "any public dungeon",
    [DynamicCP.TRIGGER_DELVE]          = "any public delve",
    [DynamicCP.TRIGGER_OVERLAND]       = "any overland zone",
    [DynamicCP.TRIGGER_CYRO]           = "Cyrodiil",
    [DynamicCP.TRIGGER_IC]             = "Imperial City or Sewers",
    [DynamicCP.TRIGGER_ZONEID]         = "specific zone",
    [DynamicCP.TRIGGER_BOSS]           = "any boss area",
    [DynamicCP.TRIGGER_BOSSNAME]       = "specific boss",
}

local hasVet = {
    [DynamicCP.TRIGGER_TRIAL]          = true,
    [DynamicCP.TRIGGER_GROUP_DUNGEON]  = true,
    [DynamicCP.TRIGGER_PUBLIC_DUNGEON] = false,
    [DynamicCP.TRIGGER_DELVE]          = false,
    [DynamicCP.TRIGGER_OVERLAND]       = false,
    [DynamicCP.TRIGGER_CYRO]           = false,
    [DynamicCP.TRIGGER_IC]             = false,
    [DynamicCP.TRIGGER_ZONEID]         = true,
    [DynamicCP.TRIGGER_BOSS]           = true,
    [DynamicCP.TRIGGER_BOSSNAME]       = true,
}

local function GetCurrentPreview()
    if (not selectedRuleName) then
        return ""
    end

    local rule = DynamicCP.savedOptions.customRules.rules[selectedRuleName]

    local difficultyString = ""
    if (hasVet[rule.trigger]) then
        if (rule.normal and rule.veteran) then
            difficultyString = " on both normal and vet"
        elseif (rule.normal) then
            difficultyString = " on normal"
        elseif (rule.veteran) then
            difficultyString = " on vet"
        else
            difficultyString = " |cFF4444on neither difficulty|r"
        end
    end

    local preview = string.format("Upon entering %s%s,",
        triggerToPreview[rule.trigger],
        difficultyString
        )
    return preview
end

---------------------------------------------------------------------
-- Build the stars dropdown choices
local starDisplays = {}
local starValues = {}

local function BuildStarsDropdowns()
    for disciplineIndex = 1, GetNumChampionDisciplines() do
        starDisplays[disciplineIndex] = {"--"}
        starValues[disciplineIndex] = {-1}
        for skillIndex = 1, GetNumChampionDisciplineSkills(disciplineIndex) do
            local skillId = GetChampionSkillId(disciplineIndex, skillIndex)
            if (CanChampionSkillTypeBeSlotted(GetChampionSkillType(skillId))) then
                table.insert(starDisplays[disciplineIndex], zo_strformat("<<C:1>>", GetChampionSkillName(skillId)))
                table.insert(starValues[disciplineIndex], skillId)
            end
        end
    end
end

DynamicCP.BuildStarsDropdowns = BuildStarsDropdowns

---------------------------------------------------------------------
function DynamicCP.CreateCustomRulesMenu()
    BuildStarsDropdowns()

    local LAM = LibAddonMenu2
    local panelData = {
        type = "panel",
        name = "Dynamic CP - Custom Rules",
        displayName = "|c08BD1DDynamic CP - Custom Rules|r",
        author = "Kyzeragon",
        version = DynamicCP.version,
        registerForRefresh = true,
        registerForDefaults = true,
    }

    local optionsData = {
        {
            type = "header",
            name = "General Settings",
            width = "full",
        },
        {
            type = "checkbox",
            name = "Play sound",
            tooltip = "Play the champion points committed sound when slotting stars",
            default = true,
            getFunc = function() return DynamicCP.savedOptions.customRules.playSound end,
            setFunc = function(value)
                DynamicCP.savedOptions.customRules.playSound = value
            end,
            width = "full",
        },
        {
            type = "checkbox",
            name = "Show message in chat",
            tooltip = "Show a message in chatbox when slotting stars",
            default = true,
            getFunc = function() return DynamicCP.savedOptions.customRules.showInChat end,
            setFunc = function(value)
                DynamicCP.savedOptions.customRules.showInChat = value
            end,
            width = "full",
        },
        {
            type = "header",
            name = "Custom Rules",
            width = "full",
        },
        {
            type = "description",
            title = nil,
            text = "Here, you can specify which CP stars to automatically slot in specific instances. Choose a rule below or press the \"New Rule\" button to get started.",
            width = "full",
        },
        {
            type = "dropdown",
            name = "Select rule to edit",
            tooltip = "Choose a rule to edit",
            choices = ruleDisplays,
            choicesValues = ruleValues,
            getFunc = function()
                return WINDOW_MANAGER:GetControlByName("DynamicCP#RuleDropdown").combobox.m_comboBox:GetSelectedItem()
            end,
            setFunc = function(name)
                DynamicCP.dbg("selected " .. tostring(name))
                selectedRuleName = name
                -- TODO: select and update
            end,
            width = "full",
            reference = "DynamicCP#RuleDropdown",
        },
        {
            type = "button",
            name = "New Rule",
            tooltip = "Add a new rule and edit it",
            func = function() end,
            width = "full",
        },
---------------------------------------------------------------------
-- EDIT RULE
        {
            type = "header",
            name = "|c08BD1DEdit Rule|r", -- TODO: show color only when active?
            width = "full",
        },
        {
            type = "description",
            title = nil,
            text = function()
                if (selectedRuleName) then
                    return "Customize the rule by first selecting when you want it to trigger. Different options are available for different triggers."
                else
                    return "|cFF4444Select a rule to edit in the dropdown above first!|r"
                end
            end,
            width = "full",
        },
        {
            type = "editbox",
            name = "Name",
            tooltip = "The name of the rule",
            getFunc = function() return selectedRuleName end,
            setFunc = function(name)
                if (not name) then return end
                DynamicCP.dbg("Renaming to " .. name)
                DynamicCP.savedOptions.customRules.rules[name] = DynamicCP.savedOptions.customRules.rules[selectedRuleName]
                DynamicCP.savedOptions.customRules.rules[name].name = name
                DynamicCP.savedOptions.customRules.rules[selectedRuleName] = nil
                selectedRuleName = name
            end,
            isMultiline = false,
            isExtraWide = false,
            maxChars = 30,
            width = "full",
            disabled = function() return selectedRuleName == nil end,
        },
        {
            type = "description",
            title = "Preview",
            text = GetCurrentPreview,
            width = "full",
            disabled = function() return selectedRuleName == nil end,
        },
        {
            type = "dropdown",
            name = "Trigger",
            tooltip = "When to apply the rule",
            choices = triggerDisplays,
            getFunc = function() return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].trigger or nil end,
            setFunc = function(name)
                if (not selectedRuleName) then return end
                DynamicCP.savedOptions.customRules.rules[selectedRuleName].trigger = name
            end,
            width = "full",
            disabled = function() return selectedRuleName == nil end,
        },
        {
            type = "checkbox",
            name = "Apply for normal",
            tooltip = "Whether this rule should apply for normal difficulty",
            getFunc = function()
                return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].normal or false
            end,
            setFunc = function(value)
                if (not selectedRuleName) then return end
                DynamicCP.savedOptions.customRules.rules[selectedRuleName].normal = value
            end,
            width = "half",
            disabled = function() return selectedRuleName == nil or not hasVet[DynamicCP.savedOptions.customRules.rules[selectedRuleName].trigger] end,
        },
        {
            type = "checkbox",
            name = "Apply for veteran",
            tooltip = "Whether this rule should apply for veteran difficulty",
            getFunc = function()
                return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].veteran or false
            end,
            setFunc = function(value)
                if (not selectedRuleName) then return end
                DynamicCP.savedOptions.customRules.rules[selectedRuleName].veteran = value
            end,
            width = "half",
            disabled = function() return selectedRuleName == nil or not hasVet[DynamicCP.savedOptions.customRules.rules[selectedRuleName].trigger] end,
        },
---------------------------------------------------------------------
-- Stars
        {
            type = "header",
            name = "|ca5d752Craft|r",
            width = "full",
        },
        {
            type = "dropdown",
            name = "Craft Star 1",
            tooltip = "Which star to slot in slot 1 of the Craft tree",
            choices = starDisplays[1],
            choicesValues = starValues[1],
            getFunc = function()
                return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[1] or -1
            end,
            setFunc = function(value)
                if (not selectedRuleName) then return end
                DynamicCP.dbg("selected " .. tostring(value))
                DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[1] = value
            end,
            width = "full",
            disabled = function() return selectedRuleName == nil end,
        },
        {
            type = "dropdown",
            name = "Craft Star 2",
            tooltip = "Which star to slot in slot 2 of the Craft tree",
            choices = starDisplays[1],
            choicesValues = starValues[1],
            getFunc = function()
                return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[2] or -1
            end,
            setFunc = function(value)
                if (not selectedRuleName) then return end
                DynamicCP.dbg("selected " .. tostring(value))
                DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[2] = value
            end,
            width = "full",
            disabled = function() return selectedRuleName == nil end,
        },
        {
            type = "dropdown",
            name = "Craft Star 3",
            tooltip = "Which star to slot in slot 3 of the Craft tree",
            choices = starDisplays[1],
            choicesValues = starValues[1],
            getFunc = function()
                return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[3] or -1
            end,
            setFunc = function(value)
                if (not selectedRuleName) then return end
                DynamicCP.dbg("selected " .. tostring(value))
                DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[3] = value
            end,
            width = "full",
            disabled = function() return selectedRuleName == nil end,
        },
        {
            type = "dropdown",
            name = "Craft Star 4",
            tooltip = "Which star to slot in slot 4 of the Craft tree",
            choices = starDisplays[1],
            choicesValues = starValues[1],
            getFunc = function()
                return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[4] or -1
            end,
            setFunc = function(value)
                if (not selectedRuleName) then return end
                DynamicCP.dbg("selected " .. tostring(value))
                DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[4] = value
            end,
            width = "full",
            disabled = function() return selectedRuleName == nil end,
        },
        {
            type = "header",
            name = "|c59bae7Warfare|r",
            width = "full",
            disabled = function() return selectedRuleName == nil end,
        },
        {
            type = "dropdown",
            name = "Warfare Star 1",
            tooltip = "Which star to slot in slot 1 of the Warfare tree",
            choices = starDisplays[2],
            choicesValues = starValues[2],
            getFunc = function()
                return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[5] or -1
            end,
            setFunc = function(value)
                if (not selectedRuleName) then return end
                DynamicCP.dbg("selected " .. tostring(value))
                DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[5] = value
            end,
            width = "full",
            disabled = function() return selectedRuleName == nil end,
        },
        {
            type = "dropdown",
            name = "Warfare Star 2",
            tooltip = "Which star to slot in slot 2 of the Warfare tree",
            choices = starDisplays[2],
            choicesValues = starValues[2],
            getFunc = function()
                return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[6] or -1
            end,
            setFunc = function(value)
                if (not selectedRuleName) then return end
                DynamicCP.dbg("selected " .. tostring(value))
                DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[6] = value
            end,
            width = "full",
            disabled = function() return selectedRuleName == nil end,
        },
        {
            type = "dropdown",
            name = "Warfare Star 3",
            tooltip = "Which star to slot in slot 3 of the Warfare tree",
            choices = starDisplays[2],
            choicesValues = starValues[2],
            getFunc = function()
                return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[7] or -1
            end,
            setFunc = function(value)
                if (not selectedRuleName) then return end
                DynamicCP.dbg("selected " .. tostring(value))
                DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[7] = value
            end,
            width = "full",
            disabled = function() return selectedRuleName == nil end,
        },
        {
            type = "dropdown",
            name = "Warfare Star 4",
            tooltip = "Which star to slot in slot 4 of the Warfare tree",
            choices = starDisplays[2],
            choicesValues = starValues[2],
            getFunc = function()
                return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[8] or -1
            end,
            setFunc = function(value)
                if (not selectedRuleName) then return end
                DynamicCP.dbg("selected " .. tostring(value))
                DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[8] = value
            end,
            width = "full",
            disabled = function() return selectedRuleName == nil end,
        },
        {
            type = "header",
            name = "|ce46b2eFitness|r",
            width = "full",
            disabled = function() return selectedRuleName == nil end,
        },
        {
            type = "dropdown",
            name = "Fitness Star 1",
            tooltip = "Which star to slot in slot 1 of the Fitness tree",
            choices = starDisplays[3],
            choicesValues = starValues[3],
            getFunc = function()
                return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[9] or -1
            end,
            setFunc = function(value)
                if (not selectedRuleName) then return end
                DynamicCP.dbg("selected " .. tostring(value))
                DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[9] = value
            end,
            width = "full",
            disabled = function() return selectedRuleName == nil end,
        },
        {
            type = "dropdown",
            name = "Fitness Star 2",
            tooltip = "Which star to slot in slot 2 of the Fitness tree",
            choices = starDisplays[3],
            choicesValues = starValues[3],
            getFunc = function()
                return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[10] or -1
            end,
            setFunc = function(value)
                if (not selectedRuleName) then return end
                DynamicCP.dbg("selected " .. tostring(value))
                DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[10] = value
            end,
            width = "full",
            disabled = function() return selectedRuleName == nil end,
        },
        {
            type = "dropdown",
            name = "Fitness Star 3",
            tooltip = "Which star to slot in slot 3 of the Fitness tree",
            choices = starDisplays[3],
            choicesValues = starValues[3],
            getFunc = function()
                return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[11] or -1
            end,
            setFunc = function(value)
                if (not selectedRuleName) then return end
                DynamicCP.dbg("selected " .. tostring(value))
                DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[11] = value
            end,
            width = "full",
            disabled = function() return selectedRuleName == nil end,
        },
        {
            type = "dropdown",
            name = "Fitness Star 4",
            tooltip = "Which star to slot in slot 4 of the Fitness tree",
            choices = starDisplays[3],
            choicesValues = starValues[3],
            getFunc = function()
                return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[12] or -1
            end,
            setFunc = function(value)
                if (not selectedRuleName) then return end
                DynamicCP.dbg("selected " .. tostring(value))
                DynamicCP.savedOptions.customRules.rules[selectedRuleName].stars[12] = value
            end,
            width = "full",
            disabled = function() return selectedRuleName == nil end,
        },
---------------------------------------------------------------------
-- Advanced options
        {
            type = "submenu",
            name = "Advanced Settings",
            disabled = function() return selectedRuleName == nil end,
            controls = {
                {
                    type = "checkbox",
                    name = "Override different order",
                    tooltip = "Slot the stars anyway even if they are already slotted in a different order",
                    default = true,
                    getFunc = function()
                        return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].overrideOrder or false
                    end,
                    setFunc = function(value)
                        if (not selectedRuleName) then return end
                        DynamicCP.savedOptions.customRules.rules[selectedRuleName].overrideOrder = value
                    end,
                    width = "full",
                },
                {
                    type = "checkbox",
                    name = "Semi-automatic slotting",
                    tooltip = "Show a prompt asking if you want to slot the stars instead of slotting them automatically",
                    default = false,
                    getFunc = function()
                        return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].semiAuto or false
                    end,
                    setFunc = function(value)
                        if (not selectedRuleName) then return end
                        DynamicCP.savedOptions.customRules.rules[selectedRuleName].semiAuto = value
                    end,
                    width = "full",
                },
                {
                    type = "checkbox",
                    name = "Apply for tanks",
                    tooltip = "Apply this rule if you are on a tank, as defined in settings",
                    default = true,
                    getFunc = function()
                        return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].tank or false
                    end,
                    setFunc = function(value)
                        if (not selectedRuleName) then return end
                        DynamicCP.savedOptions.customRules.rules[selectedRuleName].tank = value
                    end,
                    width = "full",
                },
                {
                    type = "checkbox",
                    name = "Apply for healers",
                    tooltip = "Apply this rule if you are on a healer, as defined in settings",
                    default = true,
                    getFunc = function()
                        return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].healer or false
                    end,
                    setFunc = function(value)
                        if (not selectedRuleName) then return end
                        DynamicCP.savedOptions.customRules.rules[selectedRuleName].healer = value
                    end,
                    width = "full",
                },
                {
                    type = "checkbox",
                    name = "Apply for DPS",
                    tooltip = "Apply this rule if you are on a DPS, as defined in settings",
                    default = true,
                    getFunc = function()
                        return selectedRuleName ~= nil and DynamicCP.savedOptions.customRules.rules[selectedRuleName].dps or false
                    end,
                    setFunc = function(value)
                        if (not selectedRuleName) then return end
                        DynamicCP.savedOptions.customRules.rules[selectedRuleName].dps = value
                    end,
                    width = "full",
                },
            },
        },
    }

    RefreshCustomRules()
    DynamicCP.customRulesPanel = LAM:RegisterAddonPanel(DynamicCP.name .. "CustomRules", panelData)
    LAM:RegisterOptionControls(DynamicCP.name .. "CustomRules", optionsData)
end
