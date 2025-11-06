---------------------------------------------------------------------
-- Apply last presets behavior:
-- Never apply = 0
-- Always prompt = 1
-- Prompt if respec required = 2
-- Always auto apply??? = 3
---------------------------------------------------------------------
local NEVER_APPLY = 0
local ALWAYS_PROMPT = 1
local PROMPT_RESPEC = 2

local pendingPresets = {}

---------------------------------------------------------------------
-- UI Update
---------------------------------------------------------------------
local function UpdateLastPresetsUI()
    local charId = GetCurrentCharacterId()
    local lastPresets = DynamicCP.savedOptions.charData[charId] or {}

    -- Not doing the windowed mode for now
    if (DynamicCP.GetSubControl("InnerGreenLastPreset") == nil) then return end

    DynamicCP.GetSubControl("InnerGreenLastPreset"):SetText(string.format("Last preset: %s", lastPresets.Green or "none"))
    DynamicCP.GetSubControl("InnerBlueLastPreset"):SetText(string.format("Last preset: %s", lastPresets.Blue or "none"))
    DynamicCP.GetSubControl("InnerRedLastPreset"):SetText(string.format("Last preset: %s", lastPresets.Red or "none"))
end
DynamicCP.UpdateLastPresetsUI = UpdateLastPresetsUI

---------------------------------------------------------------------
-- Keep track of pending presets
---------------------------------------------------------------------

-- Cancel clicked
local function ClearPendingPresets()
    pendingPresets = {}
end
DynamicCP.ClearPendingPresets = ClearPendingPresets

-- Confirm clicked
local function ConfirmPendingPresets()
    local charId = GetCurrentCharacterId()
    local newData = DynamicCP.savedOptions.charData[charId]
    if (not newData) then
        newData = {}
    end

    -- Save
    if (pendingPresets.Red) then
        newData.Red = pendingPresets.Red
    end
    if (pendingPresets.Green) then
        newData.Green = pendingPresets.Green
    end
    if (pendingPresets.Blue) then
        newData.Blue = pendingPresets.Blue
    end
    DynamicCP.savedOptions.charData[charId] = newData

    -- Clear
    ClearPendingPresets()
    UpdateLastPresetsUI()
end
DynamicCP.ConfirmPendingPresets = ConfirmPendingPresets

-- Apply clicked
local function OnPresetApplied(tree, name)
    pendingPresets[tree] = name
end
DynamicCP.OnPresetApplied = OnPresetApplied

-- Save clicked
local function OnPresetSaved(tree, name)
    local charId = GetCurrentCharacterId()
    local newData = DynamicCP.savedOptions.charData[charId]
    if (not newData) then
        newData = {}
    end
    if (not newData.armoryBuilds) then
        newData.armoryBuilds = {}
    end

    newData[tree] = name

    DynamicCP.savedOptions.charData[charId] = newData
    UpdateLastPresetsUI()
end
DynamicCP.OnPresetSaved = OnPresetSaved

---------------------------------------------------------------------
-- Saving preset
---------------------------------------------------------------------
-- TODO: if a char's cp is saved to a preset, also consider that as applied preset
-- TODO: flow: apply -> save on the same preset -> confirm/cancel
-- TODO: flow: apply -> save on different preset -> confirm/cancel
-- TODO: flow: save -> apply on different preset -> confirm/cancel

-- TODO: preset renamed? deleted?
-- TODO: make sure the preset actually exists when checking. if not, delete?

-- TODO: what if you load from armory?? save preset per armory build

-- TODO: if respec manually, clear last presets, how to get for only one? or maybe don't care, just check if assigning the new points requires respec
-- TODO: autodetect?

-- * EVENT_ARMORY_BUILD_RESTORE_RESPONSE (*[ArmoryBuildRestoreResult|#ArmoryBuildRestoreResult]* _result_, *luaindex* _buildIndex_)
-- * EVENT_ARMORY_BUILD_SAVE_RESPONSE (*[ArmoryBuildSaveResult|#ArmoryBuildSaveResult]* _result_, *luaindex* _buildIndex_)
