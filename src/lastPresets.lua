DynamicCP = DynamicCP or {}

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
-- Time data
---------------------------------------------------------------------
local function GetLocalDateTimeString(timeStamp)
    local timeShift = GetSecondsSinceMidnight() - (GetTimeStamp() % 86400)

    if (timeShift < -12 * 60 * 60) then
        timeShift = timeShift + 86400
    end

    local dateString = GetDateStringFromTimestamp(timeStamp - timeShift)
    local timeString = ZO_FormatTime(timeStamp % 86400, TIME_FORMAT_STYLE_CLOCK_TIME, TIME_FORMAT_PRECISION_TWENTY_FOUR_HOUR)
    return dateString .. " " .. timeString
end

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
        newData.lastRedPreset = {
            name = pendingPresets.Red,
            time = GetTimeStamp()
        }
    end
    if (pendingPresets.Green) then
        newData.lastGreenPreset = {
            name = pendingPresets.Green,
            time = GetTimeStamp()
        }
    end
    if (pendingPresets.Blue) then
        newData.lastBluePreset = {
            name = pendingPresets.Blue,
            time = GetTimeStamp()
        }
    end
    DynamicCP.savedOptions.charData[charId] = newData

    -- Clear
    ClearPendingPresets()

    -- Debug results
    DynamicCP.dbg(string.format(" Green: %s (%s) Blue: %s (%s) Red: %s (%s)",
        newData.lastGreenPreset and newData.lastGreenPreset.name or "",
        newData.lastGreenPreset and GetLocalDateTimeString(newData.lastGreenPreset.time) or "",
        newData.lastBluePreset and newData.lastBluePreset.name or "",
        newData.lastBluePreset and GetLocalDateTimeString(newData.lastBluePreset.time) or "",
        newData.lastRedPreset and newData.lastRedPreset.name or "",
        newData.lastRedPreset and GetLocalDateTimeString(newData.lastRedPreset.time) or ""))
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

    newData[tree] = {
        name = name,
        time = GetTimeStamp()
    }

    DynamicCP.savedOptions.charData[charId] = newData

    -- Debug results
    DynamicCP.dbg(string.format(" Green: %s (%s) Blue: %s (%s) Red: %s (%s)",
        newData.lastGreenPreset and newData.lastGreenPreset.name or "",
        newData.lastGreenPreset and GetLocalDateTimeString(newData.lastGreenPreset.time) or "",
        newData.lastBluePreset and newData.lastBluePreset.name or "",
        newData.lastBluePreset and GetLocalDateTimeString(newData.lastBluePreset.time) or "",
        newData.lastRedPreset and newData.lastRedPreset.name or "",
        newData.lastRedPreset and GetLocalDateTimeString(newData.lastRedPreset.time) or ""))
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

-- * EVENT_ARMORY_BUILD_RESTORE_RESPONSE (*[ArmoryBuildRestoreResult|#ArmoryBuildRestoreResult]* _result_, *luaindex* _buildIndex_)
-- * EVENT_ARMORY_BUILD_SAVE_RESPONSE (*[ArmoryBuildSaveResult|#ArmoryBuildSaveResult]* _result_, *luaindex* _buildIndex_)
