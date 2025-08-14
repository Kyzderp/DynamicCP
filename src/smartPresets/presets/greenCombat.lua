DynamicCP = DynamicCP or {}
DynamicCP.SmartPresets = DynamicCP.SmartPresets or {}


-----------------------------------------------------------
-- Role presets
-----------------------------------------------------------
-- If stage is not specified, the star will be maxed out
-- If flex is specified, it uses the index in the flex data
-- If passive is specified, it uses the index in the respective data
-----------------------------------------------------------

-- I thought about conditional Discipline Artisan, but it'd
-- be impossible to assume whether the user has lines they
-- want to level

-- Combat-oriented green tree: prioritizes things usable in
-- trials and dungeons, such as Treasure Hunter, Liquid
-- Efficiency, and Steed's Blessing
local GREEN_COMBAT = {
    -- TODO
}


-----------------------------------------------------------
-- applyFunc
-----------------------------------------------------------
function DynamicCP.SmartPresets.ApplyGreenCombat()
    return DynamicCP.ApplySmartPreset("Green", GREEN_COMBAT)
end
