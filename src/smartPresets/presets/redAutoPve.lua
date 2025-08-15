DynamicCP = DynamicCP or {}
DynamicCP.SmartPresets = DynamicCP.SmartPresets or {}


-----------------------------------------------------------
-- Pragmatic Fatecarver for Bastion
-----------------------------------------------------------
local red_dps_flex_pragmatic = {
    46, -- Bastion
}

local red_dps_flex_nonpragmatic = {
    270, -- Celerity (what else?)
}


-----------------------------------------------------------
-- Role presets
-----------------------------------------------------------
-- If stage is not specified, the star will be maxed out
-- If flex is specified, it uses the index in the flex data
-- If passive is specified, it uses the index in the respective data
-----------------------------------------------------------
local RED_DPS = {
    GetFlex = function(fatecarverUnlocked, isPragmatic, index)
        if (isPragmatic) then
            return red_dps_flex_pragmatic[index]
        end
        return red_dps_flex_nonpragmatic[index]
    end,
    -- TODO
    nodes = {},
}

local RED_HEAL = {
    -- TODO
    nodes = {},
}

local RED_TANK = {
    -- TODO
    nodes = {},
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
