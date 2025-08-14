DynamicCP = DynamicCP or {}
DynamicCP.SmartPresets = DynamicCP.SmartPresets or {}


-----------------------------------------------------------
-- Role presets
-----------------------------------------------------------
-- If stage is not specified, the star will be maxed out
-- If flex is specified, it uses the index in the flex data
-- If passive is specified, it uses the index in the respective data
-----------------------------------------------------------
local RED_DPS = {
    -- TODO
}

local RED_HEAL = {
    -- TODO
}

local RED_TANK = {
    -- TODO
}


-----------------------------------------------------------
-- applyFunc
-----------------------------------------------------------
function DynamicCP.SmartPresets.ApplyRedPVE()
    local role = GetSelectedLFGRole()
    if (role == LFG_ROLE_TANK) then
        return DynamicCP.ApplySmartPreset("Red", RED_TANK)
    elseif (role == LFG_ROLE_HEAL) then
        return DynamicCP.ApplySmartPreset("Red", RED_HEAL)
    else
        return DynamicCP.ApplySmartPreset("Red", RED_DPS)
    end
end
