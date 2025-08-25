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
-- be infeasible to assume whether the user has lines they
-- want to level

-- Combat-oriented green tree: prioritizes things usable in
-- trials and dungeons, such as Treasure Hunter, Liquid
-- Efficiency, and Steed's Blessing
local GREEN_COMBAT = {
    nodes = {
        {
            id = 279, -- Discipline Artisan
        },
        {
            id = 74, -- Gilded Fingers (open nodes)
            stage = 1,
        },
        {
            id = 71, -- Fortune's Favor (open nodes)
            stage = 1,
        },
        {
            id = 70, -- Wanderer (open nodes)
            stage = 1,
        },
        {
            id = 75, -- Steadfast Enchantment (open nodes)
            stage = 1,
        },
        {
            id = 79, -- Treasure Hunter
        },
        {
            id = 85, -- Rationer (open nodes)
            stage = 1,
        },
        {
            id = 86, -- Liquid Efficiency
        },
        {
            id = 83, -- Meticulous Disassembly
        },
        {
            id = 66, -- Steed's Blessing
        },
        {
            id = 85, -- Rationer (maxed)
        },
        {
            id = 74, -- Gilded Fingers (maxed)
        },
        {
            id = 78, -- Master Gatherer (open nodes)
            stage = 1,
        },
        {
            id = 81, -- Plentiful Harvest (open nodes)
            stage = 1,
        },
        {
            id = 91, -- Homemaker
        },
        {
            id = 71, -- Fortune's Favor (maxed)
        },
        {
            id = 81, -- Plentiful Harvest (maxed)
        },
        {
            id = 72, -- Inspiration Boost -- TODO: is crafting maxed?
        },
        {
            id = 69, -- Breakfall
        },
        {
            id = 75, -- Steadfast Enchantment (maxed)
        },
        {
            id = 70, -- Wanderer (maxed)
        },
        {
            id = 87, -- Soul Reservoir
        },
        {
            id = 68, -- Out of Sight
        },
        {
            id = 67, -- Fleet Phantom
        },
        {
            id = 1, -- Professional Upkeep
        },
        {
            id = 78, -- Master Gatherer (maxed)
        },
        {
            id = 92, -- Gifted Rider
        },
        {
            id = 82, -- War Mount
        },
        {
            id = 65, -- Sustaining Shadows
        },
        {
            id = 88, -- Reel Technique
        },
        {
            id = 89, -- Angler's Instincts
        },
        {
            id = 76, -- Friends in Low Places
        },
        {
            id = 77, -- Infamous
        },
        {
            id = 84, -- Fade Away
        },
        {
            id = 90, -- Cutpurse's Art
        },
        {
            id = 80, -- Shadowstrike
        },
    },
}


-----------------------------------------------------------
-- applyFunc
-----------------------------------------------------------
function DynamicCP.SmartPresets.ApplyGreenCombat()
    return DynamicCP.ApplySmartPreset("Green", GREEN_COMBAT)
end
