DynamicCP = DynamicCP or {}

function DynamicCP:CreateSettingsMenu()
    local LAM = LibAddonMenu2
    local panelData = {
        type = "panel",
        name = "|c08BD1DDynamic CP|r",
        author = "Kyzeragon",
        version = DynamicCP.version,
        registerForRefresh = true,
        registerForDefaults = true,
    }

    local optionsData = {
        {
            type = "checkbox",
            name = "Debug",
            tooltip = "Show spammy debug chat",
            default = false,
            getFunc = function() return DynamicCP.savedOptions.debug end,
            setFunc = function(value)
                DynamicCP.savedOptions.debug = value
            end,
            width = "full",
        },
---------------------------------------------------------------------
-- constellation
        {
            type = "submenu",
            name = "Constellation Settings",
            controls = {
                {
                    type = "checkbox",
                    name = "Show labels on stars",
                    tooltip = "Show the names of champion point stars above the stars",
                    default = true,
                    getFunc = function() return DynamicCP.savedOptions.showLabels end,
                    setFunc = function(value)
                        DynamicCP.savedOptions.showLabels = value
                    end,
                    width = "full",
                    requiresReload = true,
                },
                {
                    type = "checkbox",
                    name = "Hide background",
                    tooltip = "Hide the constellation background texture, useful if you have difficulty seeing the stars or don't like the extra clutter",
                    default = false,
                    getFunc = function() return DynamicCP.savedOptions.hideBackground end,
                    setFunc = function(value)
                        DynamicCP.savedOptions.hideBackground = value
                    end,
                    width = "full",
                    requiresReload = true,
                },
                {
                    type = "checkbox",
                    name = "Double click to slot or unslot stars",
                    tooltip = "Double click the slottable stars to add or remove them to the hotbar, or double click the hotbar stars to unslot them",
                    default = true,
                    getFunc = function() return DynamicCP.savedOptions.doubleClick end,
                    setFunc = function(value)
                        DynamicCP.savedOptions.doubleClick = value
                    end,
                    width = "full",
                    requiresReload = true,
                },
            },
        },
---------------------------------------------------------------------
-- window
        {
            type = "submenu",
            name = "Preset Window Settings",
            controls = {
                {
                    type = "checkbox",
                    name = "Show window with CP",
                    tooltip = "Display the window automatically when opening the Champion Points menu. You can turn this off if you do not wish to use presets",
                    default = true,
                    getFunc = function() return DynamicCP.savedOptions.showPresetsWithCP end,
                    setFunc = function(value)
                        DynamicCP.savedOptions.showPresetsWithCP = value
                    end,
                    width = "full",
                },
                {
                    type = "checkbox",
                    name = "Dock window",
                    tooltip = "Display the window in different positions on each constellation to avoid overlapping with stars. Recommend adjusting the scale so it fits in the Fitness tree, between Arcane Alacrity and Bashing Brutality",
                    default = true,
                    getFunc = function() return DynamicCP.savedOptions.dockWithSpace end,
                    setFunc = function(value)
                        DynamicCP.savedOptions.dockWithSpace = value
                    end,
                    width = "full",
                },
                {
                    type = "slider",
                    name = "Window scale %",
                    tooltip = "Scale of the window to display. Some spacing will look weird especially at more extreme values",
                    default = 100,
                    min = 50,
                    max = 150,
                    step = 5,
                    getFunc = function() return DynamicCP.savedOptions.scale * 100 end,
                    setFunc = function(value)
                        DynamicCP.savedOptions.scale = value / 100
                        DynamicCPPresets:SetScale(value / 100)
                    end,
                    width = "full",
                },
            },
        },
---------------------------------------------------------------------
-- preset application
        {
            type = "submenu",
            name = "Preset Settings",
            controls = {
                {
                    type = "checkbox",
                    name = "Automatically slot stars",
                    tooltip = "After confirming a preset, automatically slot slottable stars if there are 4 or fewer unlocked slottables",
                    default = true,
                    getFunc = function() return DynamicCP.savedOptions.slotStars end,
                    setFunc = function(value)
                        DynamicCP.savedOptions.slotStars = value
                    end,
                    width = "full",
                },
                -- {
                --     type = "checkbox",
                --     name = "Automatically slot higher stars",
                --     tooltip = "After confirming a preset, if there are 5 or more unlocked slottables, slot the 4 that are closest to max. If there are more than 4, the order is determined by the star's index",
                --     default = true,
                --     getFunc = function() return DynamicCP.savedOptions.slotHigherStars end,
                --     setFunc = function(value)
                --         DynamicCP.savedOptions.slotHigherStars = value
                --     end,
                --     width = "full",
                --     disabled = function() return not DynamicCP.savedOptions.slotStars end
                -- },
            },
        },
---------------------------------------------------------------------
-- other
        {
            type = "submenu",
            name = "Other Settings",
            controls = {
                {
                    type = "checkbox",
                    name = "Prompt unsaved changes",
                    tooltip = "Show a warning and option to commit changes if you leave the CP screen without saving changes",
                    default = true,
                    getFunc = function() return DynamicCP.savedOptions.showLeaveWarning end,
                    setFunc = function(value)
                        DynamicCP.savedOptions.showLeaveWarning = value
                    end,
                    width = "full",
                },
                {
                    type = "checkbox",
                    name = "Show cooldown warning",
                    tooltip = "Show a warning if you are unable to commit changes due to ZOS's 30-second cooldown on changing slottables",
                    default = true,
                    getFunc = function() return DynamicCP.savedOptions.showCooldownWarning end,
                    setFunc = function(value)
                        DynamicCP.savedOptions.showCooldownWarning = value
                    end,
                    width = "full",
                },
                {
                    type = "checkbox",
                    name = "Show points on slottables pulldown",
                    tooltip = "Show the number of committed points in the pulldown beneath the slottables hotbar",
                    default = false,
                    getFunc = function() return DynamicCP.savedOptions.showPulldownPoints end,
                    setFunc = function(value)
                        DynamicCP.savedOptions.showPulldownPoints = value
                        DynamicCP.OnSlotsChanged()
                    end,
                    width = "full",
                },
            },
        },
    }

    DynamicCP.addonPanel = LAM:RegisterAddonPanel("DynamicCPOptions", panelData)
    LAM:RegisterOptionControls("DynamicCPOptions", optionsData)
end

function DynamicCP:OpenSettingsMenu()
    LibAddonMenu2:OpenToPanel(DynamicCP.addonPanel)
end
