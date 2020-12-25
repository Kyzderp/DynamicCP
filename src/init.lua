DynamicCP = DynamicCP or {}
DynamicCP.name = "DynamicCP"
DynamicCP.version = "0.0.1"

local defaultOptions = {
    firstTime = true,
    cp = {
        Red = {},
        Green = {},
        Blue = {},
    },
}

---------------------------------------------------------------------
-- Collect messages for displaying later when addon is not fully loaded
DynamicCP.messages = {}
function DynamicCP.dbg(msg)
    if (not msg) then return end
    if (CHAT_SYSTEM.primaryContainer) then
        d("|c6666FF[DCP]|r " .. tostring(msg))
    else
        DynamicCP.messages[#DynamicCP.messages + 1] = msg
    end
end

---------------------------------------------------------------------
-- Post Load (player loaded)
function OnPlayerActivated(_, initial)
    -- Soft dependency on pChat because its chat restore will overwrite
    for i = 1, #DynamicCP.messages do
        d("|c6666FF[DCPdelay]|r " .. DynamicCP.messages[i])
    end
    DynamicCP.messages = {}
end

---------------------------------------------------------------------
-- Initialize
local function Initialize()
    DynamicCP.dbg("Initializing...")
    DynamicCP.savedOptions = ZO_SavedVars:NewAccountWide("DynamicCPSavedVariables", 1, "Options", defaultOptions)
    -- TODO: create settings menu

    -- Populate defaults only on first time, otherwise the keys will be remade even if user deletes
    if (DynamicCP.savedOptions.firstTime) then
        DynamicCP.savedOptions.cp = DynamicCP.defaultPresets
        DynamicCP.savedOptions.firstTime = false
    end

    EVENT_MANAGER:RegisterForEvent(DynamicCP.name, EVENT_PLAYER_ACTIVATED, OnPlayerActivated)

    DynamicCP:InitializeDropdowns()
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
