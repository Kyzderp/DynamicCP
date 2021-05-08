DynamicCP = DynamicCP or {}

--[[
"|ce46b2e" -- Red
"|c59bae7" -- Blue
"|ca5d752" -- Green
    [""] = {
        description = "",
        rules = {

        },
    },
]]

-- TODO: do a pass of priority for all
-- [name of group to display] = {description = desc, rules = {}}
DynamicCP.exampleRules = {
    ["House Parse / Decon"] = {
        description = "A single rule that slots |ca5d752Steed's Blessing|r, |ca5d752Liquid Efficiency|r, and |ca5d752Meticulous Disassembly|r when you enter a player-owned house.",
        rules = {
            ["House Green Decon"] = {
                ["tank"] = true,
                ["name"] = "House Green Decon",
                ["param2"] = "",
                ["param1"] = "",
                ["stars"] = {
                    [1] = -1,
                    [2] = 66, -- Steed's Blessing
                    [3] = 86, -- Liquid Efficiency
                    [4] = 83, -- Meticulous Disassembly
                    [5] = -1,
                    [6] = -1,
                    [7] = -1,
                    [8] = -1,
                    [9] = -1,
                    [10] = -1,
                    [11] = -1,
                    [12] = -1,
                },
                ["dps"] = true,
                ["trigger"] = "Player House",
                ["healer"] = true,
                ["normal"] = true,
                ["priority"] = 0,
                ["veteran"] = true,
            },
        },
    },
    ["General Trial"] = {
        description = "A set of rules that slot:\n|ca5d752Treasure Hunter|r, |ca5d752Steed's Blessing|r, |ca5d752Liquid Efficiency|r, |ce46b2eBoundless Vitality|r, |ce46b2eIronclad|r, and |ce46b2eRejuvenation|r on all roles;\n|ce46b2eSpirit Mastery|r, |c59bae7Backstabber|r, |c59bae7Fighting Finesse|r, |c59bae7Biting Aura|r, and |c59bae7Thaumaturge|r on dps;\n|ce46b2eExpert Evasion|r, |c59bae7Duelist's Rebuff|r, |c59bae7Enduring Resolve|r, |c59bae7Unassailable|r, and |c59bae7Bulwark|r on tank;\n|ce46b2eSlippery|r, |c59bae7Soothing Tide|r, |c59bae7Fighting Finesse|r, |c59bae7Arcane Supremacy|r, and |c59bae7Untamed Aggression|r on healer\nwhen you enter a trial.",
        rules = {
            ["Trial Green / Red"] = {
                ["dps"] = true,
                ["name"] = "Trial Green / Red",
                ["tank"] = true,
                ["healer"] = true,
                ["param2"] = "",
                ["normal"] = true,
                ["veteran"] = true,
                ["stars"] = {
                    [1] = 79, -- Treasure Hunter
                    [2] = 66, -- Steed's Blessing
                    [3] = 86, -- Liquid Efficiency
                    [4] = -1,
                    [5] = -1,
                    [6] = -1,
                    [7] = -1,
                    [8] = -1,
                    [9] = 2, -- Boundless Vitality
                    [10] = 34, -- Ironclad
                    [11] = 35, -- Rejuvenation
                    [12] = -1,
                },
                ["priority"] = 100,
                ["trigger"] = "Trial",
                ["param1"] = "",
            },
            ["Trial Dps Stab AOE / Rezzer"] = {
                ["dps"] = true,
                ["name"] = "Trial Dps Stab AOE / Rezzer",
                ["tank"] = false,
                ["healer"] = false,
                ["param2"] = "",
                ["normal"] = true,
                ["veteran"] = true,
                ["stars"] = {
                    [1] = -1,
                    [2] = -1,
                    [3] = -1,
                    [4] = -1,
                    [5] = 31, -- Backstabber
                    [6] = 12, -- Fighting Finesse
                    [7] = 23, -- Biting Aura
                    [8] = 27, -- Thaumaturge
                    [9] = -1,
                    [10] = -1,
                    [11] = -1,
                    [12] = 56, -- Spirit Mastery
                },
                ["priority"] = 110,
                ["trigger"] = "Trial",
                ["param1"] = "",
            },
            ["Trial Tank Blue / Red Dodge"] = {
                ["trigger"] = "Trial",
                ["name"] = "Trial Tank Blue / Red Dodge",
                ["tank"] = true,
                ["healer"] = false,
                ["priority"] = 110,
                ["normal"] = true,
                ["reeval"] = false,
                ["veteran"] = true,
                ["stars"] = {
                    [1] = -1,
                    [2] = -1,
                    [3] = -1,
                    [4] = -1,
                    [5] = 134, -- Duelist's Rebuff
                    [6] = 136, -- Enduring Resolve
                    [7] = 133, -- Unassailable
                    [8] = 159, -- Bulwark
                    [9] = -1,
                    [10] = -1,
                    [11] = -1,
                    [12] = 51, -- Expert Evasion
                },
                ["param2"] = "",
                ["param1"] = "",
                ["dps"] = false,
            },
            ["Trial Healer Blue / Slippery"] = {
                ["trigger"] = "Trial",
                ["name"] = "Trial Healer Blue / Slippery",
                ["tank"] = false,
                ["healer"] = false,
                ["priority"] = 110,
                ["normal"] = true,
                ["reeval"] = false,
                ["veteran"] = true,
                ["stars"] = {
                    [1] = -1,
                    [2] = -1,
                    [3] = -1,
                    [4] = -1,
                    [5] = 31, -- Soothing Tide
                    [6] = 12, -- Fighting Finesse
                    [7] = 23, -- Arcane Supremacy
                    [8] = 27, -- Untamed Aggression
                    [9] = -1,
                    [10] = -1,
                    [11] = -1,
                    [12] = 52, -- Slippery
                },
                ["param2"] = "",
                ["param1"] = "",
                ["dps"] = true,
            },
        },
    },
}
