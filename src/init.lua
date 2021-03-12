DynamicCP = DynamicCP or {}
DynamicCP.name = "DynamicCP"
DynamicCP.version = "0.2.0"

local defaultOptions = {
    firstTime = true,
    cp = {
        Red = {},
        Green = {},
        Blue = {},
    },
    hideBackground = false,
    showLabels = true,
    dockWithSpace = true,
    scale = 1.0,
    debug = false,
}

local initialOpened = false

---------------------------------------------------------------------
-- Collect messages for displaying later when addon is not fully loaded
DynamicCP.messages = {}
function DynamicCP.dbg(msg)
    if (not msg) then return end
    if (not DynamicCP.savedOptions.debug) then return end
    if (CHAT_SYSTEM.primaryContainer) then
        d("|c6666FF[DCP]|r " .. tostring(msg))
    else
        DynamicCP.messages[#DynamicCP.messages + 1] = msg
    end
end


---------------------------------------------------------------------
-- Post Load (player loaded)
local function OnPlayerActivated(_, initial)
    -- Soft dependency on pChat because its chat restore will overwrite
    for i = 1, #DynamicCP.messages do
        if (DynamicCP.savedOptions.debug) then
            d("|c6666FF[DCPdelay]|r " .. DynamicCP.messages[i])
        end
    end
    DynamicCP.messages = {}

    if (DynamicCP.savedOptions.hideBackground) then
        local backgroundOverride = function(line) return "/esoui/art/scrying/backdrop_stars.dds" end 
        GetChampionDisciplineBackgroundTexture = backgroundOverride
        GetChampionDisciplineBackgroundGlowTexture = backgroundOverride
        GetChampionDisciplineBackgroundSelectedTexture = backgroundOverride
        GetChampionClusterBackgroundTexture = backgroundOverride
    end
end


---------------------------------------------------------------------
-- Initialize
local function Initialize()
    DynamicCP.savedOptions = ZO_SavedVars:NewAccountWide("DynamicCPSavedVariables", 1, "Options", defaultOptions)
    DynamicCP.dbg("Initializing...")
    -- TODO: create settings menu

    -- Populate defaults only on first time, otherwise the keys will be remade even if user deletes
    if (DynamicCP.savedOptions.firstTime) then
        DynamicCP.savedOptions.cp = DynamicCP.defaultPresets
        DynamicCP.savedOptions.firstTime = false
    end

    DynamicCP:CreateSettingsMenu()
    ZO_CreateStringId("SI_BINDING_NAME_DCP_TOGGLE_MENU", "Toggle CP Preset Window")

    EVENT_MANAGER:RegisterForEvent(DynamicCP.name, EVENT_PLAYER_ACTIVATED, OnPlayerActivated)
    EVENT_MANAGER:RegisterForEvent(DynamicCP.name .. "Purchase", EVENT_CHAMPION_PURCHASE_RESULT, DynamicCP.OnPurchased)

    CHAMPION_PERKS_CONSTELLATIONS_FRAGMENT:RegisterCallback("StateChange", function(oldState, newState)
            if (newState == SCENE_HIDDEN) then
                DynamicCP.OnExitedCPScreen()
                return
            end

            if (newState ~= SCENE_SHOWN) then return end
            DynamicCP:InitializeDropdowns() -- Call it every time in case LFG role is changed
            if (not initialOpened) then
                initialOpened = true
                DynamicCP.InitLabels()
                DynamicCPContainer:SetScale(DynamicCP.savedOptions.scale)
                if (DynamicCP.savedOptions.showLabels) then
                    DynamicCP.RefreshLabels(true)
                end
            end
        end)

    SLASH_COMMANDS["/dcp"] = function(arg)
        if (arg == "hidebackground") then
            DynamicCP.savedOptions.hideBackground = not DynamicCP.savedOptions.hideBackground
            CHAT_SYSTEM:AddMessage("The Champion Points background images will now be "
                .. (DynamicCP.savedOptions.hideBackground and "hidden" or "shown")
                .. ". Reload UI for this to take effect.")
        elseif (arg == "showlabels") then
            DynamicCP.savedOptions.showLabels = not DynamicCP.savedOptions.showLabels
            CHAT_SYSTEM:AddMessage("The Champion Points star labels will now be "
                .. (DynamicCP.savedOptions.showLabels and "shown" or "hidden")
                .. ". Reload UI for this to take effect.")
            -- TODO: don't actually need to reload
        elseif (arg == "debug") then
            DynamicCP.savedOptions.debug = not DynamicCP.savedOptions.debug
            CHAT_SYSTEM:AddMessage("Debug messages are now " .. (DynamicCP.savedOptions.debug and "on" or "off"))
        else
            DynamicCPContainer:SetHidden(not DynamicCPContainer:IsHidden())
        end
    end
end

---------------------------------------------------------------------
-- On load
local function OnAddOnLoaded(_, addonName)
    if (addonName == DynamicCP.name) then
        EVENT_MANAGER:UnregisterForEvent(DynamicCP.name, EVENT_ADD_ON_LOADED)
        Initialize()
    end
end

EVENT_MANAGER:RegisterForEvent(DynamicCP.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
