DynamicCP = DynamicCP or {}

-- For the select which rule to edit dropdown
local ruleDisplays = {}
local ruleValues = {}

local function RefreshCustomRules()
    -- TODO: check for duplicate names
    -- TODO: sort
    for name, ruleData in pairs(DynamicCP.savedOptions.customRules.rules) do
        table.insert(ruleDisplays, tostring(ruleData.order) .. ": " .. name)
        table.insert(ruleValues, name)
    end
end

function DynamicCP.CreateCustomRulesMenu()
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
            getFunc = function() return "Example Trial Rule" end,
            setFunc = function(name)
                DynamicCP.dbg("selected " .. tostring(name))
                -- TODO: select and update
            end,
            width = "full",
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
            text = "Customize the rule by first selecting when you want it to trigger. Different options are available for different triggers.",
            width = "full",
        },
        {
            type = "editbox",
            name = "Name",
            tooltip = "The name of the rule",
            getFunc = function() end,
            setFunc = function(name) end,
            isMultiline = false,
            isExtraWide = false,
            maxChars = 30,
            width = "full",
        },
        {
            type = "dropdown",
            name = "Trigger",
            tooltip = "When to apply the rule",
            choices = {"Entering Any Trial"},
            choicesValues = {"Entering Any Trial"}, -- TODO
            getFunc = function() return "Entering Any Trial" end,
            setFunc = function(name)
                DynamicCP.dbg("selected " .. tostring(name))
                -- TODO: select and update
            end,
            width = "full",
        },
        {
            type = "slider",
            name = "Priority Order",
            tooltip = "The priority order at which this rule should be applied. Smaller numbers will be applied first.",
            default = 100,
            min = 0,
            max = 1000,
            step = 10,
            getFunc = function() end,
            setFunc = function(value) end,
            width = "full",
        },
        {
            type = "dropdown",
            name = "Difficulty",
            tooltip = "What difficulty this rule applies to",
            choices = {"Normal & Veteran"},
            choicesValues = {DynamicCP.DIFFICULTY_BOTH}, -- TODO
            getFunc = function() return DynamicCP.DIFFICULTY_BOTH end,
            setFunc = function(difficulty)
                DynamicCP.dbg("selected " .. tostring(difficulty))
                -- TODO: select and update
            end,
            width = "full",
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
            choices = {}, -- TODO
            choicesValues = {},
            getFunc = function() return "--" end,
            setFunc = function(name)
                DynamicCP.dbg("selected " .. tostring(name))
                -- TODO: select and update
            end,
            width = "full",
        },
        {
            type = "dropdown",
            name = "Craft Star 2",
            tooltip = "Which star to slot in slot 2 of the Craft tree",
            choices = {}, -- TODO
            choicesValues = {},
            getFunc = function() return "--" end,
            setFunc = function(name)
                DynamicCP.dbg("selected " .. tostring(name))
                -- TODO: select and update
            end,
            width = "full",
        },
        {
            type = "dropdown",
            name = "Craft Star 3",
            tooltip = "Which star to slot in slot 3 of the Craft tree",
            choices = {}, -- TODO
            choicesValues = {},
            getFunc = function() return "--" end,
            setFunc = function(name)
                DynamicCP.dbg("selected " .. tostring(name))
                -- TODO: select and update
            end,
            width = "full",
        },
        {
            type = "dropdown",
            name = "Craft Star 4",
            tooltip = "Which star to slot in slot 4 of the Craft tree",
            choices = {}, -- TODO
            choicesValues = {},
            getFunc = function() return "--" end,
            setFunc = function(name)
                DynamicCP.dbg("selected " .. tostring(name))
                -- TODO: select and update
            end,
            width = "full",
        },
        {
            type = "header",
            name = "|c59bae7Warfare|r",
            width = "full",
        },
        {
            type = "dropdown",
            name = "Warfare Star 1",
            tooltip = "Which star to slot in slot 1 of the Warfare tree",
            choices = {}, -- TODO
            choicesValues = {},
            getFunc = function() return "--" end,
            setFunc = function(name)
                DynamicCP.dbg("selected " .. tostring(name))
                -- TODO: select and update
            end,
            width = "full",
        },
        {
            type = "dropdown",
            name = "Warfare Star 2",
            tooltip = "Which star to slot in slot 2 of the Warfare tree",
            choices = {}, -- TODO
            choicesValues = {},
            getFunc = function() return "--" end,
            setFunc = function(name)
                DynamicCP.dbg("selected " .. tostring(name))
                -- TODO: select and update
            end,
            width = "full",
        },
        {
            type = "dropdown",
            name = "Warfare Star 3",
            tooltip = "Which star to slot in slot 3 of the Warfare tree",
            choices = {}, -- TODO
            choicesValues = {},
            getFunc = function() return "--" end,
            setFunc = function(name)
                DynamicCP.dbg("selected " .. tostring(name))
                -- TODO: select and update
            end,
            width = "full",
        },
        {
            type = "dropdown",
            name = "Warfare Star 4",
            tooltip = "Which star to slot in slot 4 of the Warfare tree",
            choices = {}, -- TODO
            choicesValues = {},
            getFunc = function() return "--" end,
            setFunc = function(name)
                DynamicCP.dbg("selected " .. tostring(name))
                -- TODO: select and update
            end,
            width = "full",
        },
        {
            type = "header",
            name = "|ce46b2eFitness|r",
            width = "full",
        },
        {
            type = "dropdown",
            name = "Fitness Star 1",
            tooltip = "Which star to slot in slot 1 of the Fitness tree",
            choices = {}, -- TODO
            choicesValues = {},
            getFunc = function() return "--" end,
            setFunc = function(name)
                DynamicCP.dbg("selected " .. tostring(name))
                -- TODO: select and update
            end,
            width = "full",
        },
        {
            type = "dropdown",
            name = "Fitness Star 2",
            tooltip = "Which star to slot in slot 2 of the Fitness tree",
            choices = {}, -- TODO
            choicesValues = {},
            getFunc = function() return "--" end,
            setFunc = function(name)
                DynamicCP.dbg("selected " .. tostring(name))
                -- TODO: select and update
            end,
            width = "full",
        },
        {
            type = "dropdown",
            name = "Fitness Star 3",
            tooltip = "Which star to slot in slot 3 of the Fitness tree",
            choices = {}, -- TODO
            choicesValues = {},
            getFunc = function() return "--" end,
            setFunc = function(name)
                DynamicCP.dbg("selected " .. tostring(name))
                -- TODO: select and update
            end,
            width = "full",
        },
        {
            type = "dropdown",
            name = "Fitness Star 4",
            tooltip = "Which star to slot in slot 4 of the Fitness tree",
            choices = {}, -- TODO
            choicesValues = {},
            getFunc = function() return "--" end,
            setFunc = function(name)
                DynamicCP.dbg("selected " .. tostring(name))
                -- TODO: select and update
            end,
            width = "full",
        },
---------------------------------------------------------------------
-- Advanced options
        {
            type = "submenu",
            name = "Advanced Settings",
            controls = {
                {
                    type = "checkbox",
                    name = "Override different order",
                    tooltip = "Slot the stars anyway even if they are already slotted in a different order",
                    default = false,
                    getFunc = function() return false end,
                    setFunc = function(value)
                    end,
                    width = "full",
                },
                {
                    type = "checkbox",
                    name = "Semi-automatic slotting",
                    tooltip = "Show a prompt asking if you want to slot the stars instead of slotting them automatically",
                    default = false,
                    getFunc = function() return false end,
                    setFunc = function(value)
                    end,
                    width = "full",
                },
                {
                    type = "checkbox",
                    name = "Apply for tanks",
                    tooltip = "Apply this rule if you are on a tank, as defined in settings",
                    default = true,
                    getFunc = function() return true end,
                    setFunc = function(value)
                    end,
                    width = "full",
                },
                {
                    type = "checkbox",
                    name = "Apply for healers",
                    tooltip = "Apply this rule if you are on a healer, as defined in settings",
                    default = true,
                    getFunc = function() return true end,
                    setFunc = function(value)
                    end,
                    width = "full",
                },
                {
                    type = "checkbox",
                    name = "Apply for DPS",
                    tooltip = "Apply this rule if you are on a DPS, as defined in settings",
                    default = true,
                    getFunc = function() return true end,
                    setFunc = function(value)
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
