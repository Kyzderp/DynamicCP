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

-- Loot/craft-oriented green tree: prioritizes Treasure
-- Hunter, Plentiful Harvest, etc
local GREEN_LOOT = {
    -- TODO
}


-----------------------------------------------------------
-- applyFunc
-----------------------------------------------------------
function DynamicCP.SmartPresets.ApplyGreenLootGoblin()
    return DynamicCP.ApplySmartPreset("Green", GREEN_LOOT)
end
