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
-- general
        {
            type = "submenu",
            name = "Constellation Settings",
            controls = {
                {
                    type = "checkbox",
                    name = "Show Labels on Stars",
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
                    name = "Hide Background",
                    tooltip = "Hide the constellation background texture, useful if you have difficulty seeing the stars or don't like the extra clutter",
                    default = false,
                    getFunc = function() return DynamicCP.savedOptions.hideBackground end,
                    setFunc = function(value)
                        DynamicCP.savedOptions.hideBackground = value
                    end,
                    width = "full",
                    requiresReload = true,
                },
            }
        }
    }

    DynamicCP.addonPanel = LAM:RegisterAddonPanel("DynamicCPOptions", panelData)
    LAM:RegisterOptionControls("DynamicCPOptions", optionsData)
end