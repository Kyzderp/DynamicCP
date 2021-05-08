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
    ["House Decon"] = {
        description = "A single rule that slots:\n\n|ca5d752Steed's Blessing|r, |ca5d752Liquid Efficiency|r, and |ca5d752Meticulous Disassembly|r\n\nwhen you enter a player-owned house.",
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
        description = "A set of rules that slots:\n\n|ca5d752Treasure Hunter|r, |ca5d752Steed's Blessing|r, |ca5d752Liquid Efficiency|r, |ce46b2eBoundless Vitality|r, |ce46b2eIronclad|r, and |ce46b2eRejuvenation|r on all roles;\n\n|ce46b2eSpirit Mastery|r, |c59bae7Backstabber|r, |c59bae7Fighting Finesse|r, |c59bae7Biting Aura|r, and |c59bae7Thaumaturge|r on dps;\n\n|ce46b2eExpert Evasion|r, |c59bae7Duelist's Rebuff|r, |c59bae7Enduring Resolve|r, |c59bae7Unassailable|r, and |c59bae7Bulwark|r on tank;\n\n|ce46b2eSlippery|r, |c59bae7Soothing Tide|r, |c59bae7Fighting Finesse|r, |c59bae7Arcane Supremacy|r, and |c59bae7Untamed Aggression|r on healer;\n\nwhen you enter a trial.",
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
                ["healer"] = true,
                ["priority"] = 110,
                ["normal"] = true,
                ["reeval"] = false,
                ["veteran"] = true,
                ["stars"] = {
                    [1] = -1,
                    [2] = -1,
                    [3] = -1,
                    [4] = -1,
                    [5] = 24, -- Soothing Tide
                    [6] = 12, -- Fighting Finesse
                    [7] = 3, -- Arcane Supremacy
                    [8] = 4, -- Untamed Aggression
                    [9] = -1,
                    [10] = -1,
                    [11] = -1,
                    [12] = 52, -- Slippery
                },
                ["param2"] = "",
                ["param1"] = "",
                ["dps"] = false,
            },
        },
    },
    ["Dungeon / Group Arena"] = {
        description = "A set of rules that slots:\n\n|ca5d752Treasure Hunter|r, |ca5d752Steed's Blessing|r, |ca5d752Liquid Efficiency|r, |ca5d752Homemaker|r, |ce46b2eBoundless Vitality|r, |ce46b2eIronclad|r, and |ce46b2eRejuvenation|r on all roles;\n\n|ce46b2eBloody Renewal / Siphoning Spells|r, |c59bae7Backstabber|r, |c59bae7Fighting Finesse|r, |c59bae7Biting Aura|r, and |c59bae7Thaumaturge|r on dps;\n\n|ce46b2eExpert Evasion|r, |c59bae7Duelist's Rebuff|r, |c59bae7Enduring Resolve|r, |c59bae7Unassailable|r, and |c59bae7Bulwark|r on tank;\n\n|ce46b2eSlippery|r, |c59bae7Soothing Tide|r, |c59bae7Fighting Finesse|r, |c59bae7Arcane Supremacy|r, and |c59bae7Untamed Aggression|r on healer;\n\nwhen you enter a group dungeon or group arena.",
        rules = {
            ["Dungeon Green / Red"] = {
                ["name"] = "Dungeon Green / Red",
                ["trigger"] = "Group Dungeon",
                ["healer"] = true,
                ["param1"] = "",
                ["veteran"] = true,
                ["priority"] = 500,
                ["normal"] = true,
                ["tank"] = true,
                ["param2"] = "",
                ["stars"] = {
                    [1] = 79, -- Treasure Hunter
                    [2] = 66, -- Steed's Blessing
                    [3] = 86, -- Liquid Efficiency
                    [4] = 91, -- Homemaker
                    [5] = -1,
                    [6] = -1,
                    [7] = -1,
                    [8] = -1,
                    [9] = 2, -- Boundless Vitality
                    [10] = 34, -- Ironclad
                    [11] = 35, -- Rejuvenation
                    [12] = -1,
                },
                ["dps"] = true,
            },
            ["Dungeon Dps Stab AOE / Sustain"] = {
                ["name"] = "Dungeon Dps Stab AOE / Sustain",
                ["trigger"] = "Group Dungeon",
                ["healer"] = false,
                ["param1"] = "",
                ["veteran"] = true,
                ["priority"] = 520,
                ["normal"] = true,
                ["tank"] = false,
                ["param2"] = "",
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
                    [12] = 48, -- Bloody Renewal
                },
                ["dps"] = true,
            },
            ["Dungeon Tank Blue / Dodge"] = {
                ["name"] = "Dungeon Tank Blue / Dodge",
                ["trigger"] = "Group Dungeon",
                ["healer"] = false,
                ["tank"] = true,
                ["param2"] = "",
                ["veteran"] = true,
                ["priority"] = 510,
                ["normal"] = true,
                ["param1"] = "",
                ["dps"] = false,
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
                ["reeval"] = false,
            },
            ["Dungeon Healer Blue / Slippery"] = {
                ["name"] = "Dungeon Healer Blue / Slippery",
                ["trigger"] = "Group Dungeon",
                ["healer"] = true,
                ["tank"] = false,
                ["param2"] = "",
                ["veteran"] = true,
                ["priority"] = 510,
                ["normal"] = true,
                ["param1"] = "",
                ["dps"] = false,
                ["stars"] = {
                    [1] = -1,
                    [2] = -1,
                    [3] = -1,
                    [4] = -1,
                    [5] = 24, -- Soothing Tide
                    [6] = 12, -- Fighting Finesse
                    [7] = 3, -- Arcane Supremacy
                    [8] = 4, -- Untamed Aggression
                    [9] = -1,
                    [10] = -1,
                    [11] = -1,
                    [12] = 52, -- Slippery
                },
                ["reeval"] = false,
            },
            ["Arena Green / Red"] = {
                ["name"] = "Arena Green / Red",
                ["trigger"] = "Group Arena",
                ["healer"] = true,
                ["param1"] = "",
                ["veteran"] = true,
                ["priority"] = 500,
                ["normal"] = true,
                ["tank"] = true,
                ["param2"] = "",
                ["stars"] = {
                    [1] = 79, -- Treasure Hunter
                    [2] = 66, -- Steed's Blessing
                    [3] = 86, -- Liquid Efficiency
                    [4] = 91, -- Homemaker
                    [5] = -1,
                    [6] = -1,
                    [7] = -1,
                    [8] = -1,
                    [9] = 2, -- Boundless Vitality
                    [10] = 34, -- Ironclad
                    [11] = 35, -- Rejuvenation
                    [12] = -1,
                },
                ["dps"] = true,
            },
            ["Arena Dps Stab AOE / Sustain"] = {
                ["name"] = "Arena Dps Stab AOE / Sustain",
                ["trigger"] = "Group Arena",
                ["healer"] = false,
                ["param1"] = "",
                ["veteran"] = true,
                ["priority"] = 520,
                ["normal"] = true,
                ["tank"] = false,
                ["param2"] = "",
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
                    [12] = 48, -- Bloody Renewal
                },
                ["dps"] = true,
            },
            ["Arena Tank Blue / Dodge"] = {
                ["name"] = "Arena Tank Blue / Dodge",
                ["trigger"] = "Arena",
                ["healer"] = false,
                ["tank"] = true,
                ["param2"] = "",
                ["veteran"] = true,
                ["priority"] = 510,
                ["normal"] = true,
                ["param1"] = "",
                ["dps"] = false,
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
                ["reeval"] = false,
            },
            ["Arena Healer Blue / Slippery"] = {
                ["name"] = "Arena Healer Blue / Slippery",
                ["trigger"] = "Arena",
                ["healer"] = true,
                ["tank"] = false,
                ["param2"] = "",
                ["veteran"] = true,
                ["priority"] = 510,
                ["normal"] = true,
                ["param1"] = "",
                ["dps"] = false,
                ["stars"] = {
                    [1] = -1,
                    [2] = -1,
                    [3] = -1,
                    [4] = -1,
                    [5] = 24, -- Soothing Tide
                    [6] = 12, -- Fighting Finesse
                    [7] = 3, -- Arcane Supremacy
                    [8] = 4, -- Untamed Aggression
                    [9] = -1,
                    [10] = -1,
                    [11] = -1,
                    [12] = 52, -- Slippery
                },
                ["reeval"] = false,
            },
        },
    },
    ["Solo Arena"] = {
        description = "A single rule that slots:\n\n|ca5d752Rationer|r, |ca5d752Steed's Blessing|r, |ca5d752Liquid Efficiency|r, |ca5d752Professional Upkeep|r, |ce46b2eBoundless Vitality|r, |ce46b2eIronclad|r, |ce46b2eRejuvenation|r, |ce46b2eBloody Renewal / Siphoning Spells|r, |c59bae7Deadly Aim|r, |c59bae7Fighting Finesse|r, |c59bae7Biting Aura|r, and |c59bae7Thaumaturge|r\n\nwhen you enter a solo arena.",
        rules = {
            ["Solo Arena Green / Red / NonStab"] = {
                ["param2"] = "",
                ["trigger"] = "Solo Arena",
                ["healer"] = true,
                ["param1"] = "",
                ["priority"] = 400,
                ["dps"] = true,
                ["normal"] = true,
                ["stars"] = {
                    [1] = 85, -- Rationer
                    [2] = 66, -- Steed's Blessing
                    [3] = 86, -- Liquid Efficiency
                    [4] = 1, -- Professional Upkeep
                    [5] = 25, -- Deadly Aim
                    [6] = 12, -- Fighting Finesse
                    [7] = 23, -- Biting Aura
                    [8] = 27, -- Thaumaturge
                    [9] = 2, -- Boundless Vitality
                    [10] = 34, -- Ironclad
                    [11] = 35, -- Rejuvenation
                    [12] = 48, -- Bloody Renewal
                },
                ["veteran"] = true,
                ["tank"] = true,
                ["name"] = "Solo Arena Green / Red / NonStab",
            },
        },
    },
    ["Overland"] = {
        description = "A set of rules that slots:\n\n|ca5d752Treasure Hunter|r, |ca5d752Steed's Blessing|r, |ca5d752Gifted Rider|r, and |ca5d752Meticulous Disassembly|r on all roles;\n\n|ce46b2eBloody Renewal / Siphoning Spells|r, |c59bae7Deadly Aim|r, |c59bae7Fighting Finesse|r, |c59bae7Biting Aura|r, and |c59bae7Thaumaturge|r on dps;\n\nwhen you enter an overland zone.\n\nAnd |ca5d752Liquid Efficiency|r and |ca5d752Homemaker|r instead of Gifted Rider and Meticulous Disassembly in public dungeons, delves, and group instances.",
        rules = {
            ["Instance Green"] = {
                ["name"] = "Instance Green",
                ["dps"] = true,
                ["trigger"] = "Group Instance **",
                ["priority"] = 640,
                ["stars"] = {
                    [1] = 79,
                    [2] = 66,
                    [3] = 86,
                    [4] = 91,
                    [5] = -1,
                    [6] = -1,
                    [7] = -1,
                    [8] = -1,
                    [9] = -1,
                    [10] = -1,
                    [11] = -1,
                    [12] = -1,
                },
                ["reeval"] = false,
                ["param2"] = "",
                ["normal"] = true,
                ["veteran"] = true,
                ["tank"] = true,
                ["healer"] = true,
                ["param1"] = "",
            },
            ["Instance Dps NonStab"] = {
                ["name"] = "Instance Dps NonStab",
                ["dps"] = true,
                ["trigger"] = "Group Instance **",
                ["priority"] = 650,
                ["stars"] = {
                    [1] = -1,
                    [2] = -1,
                    [3] = -1,
                    [4] = -1,
                    [5] = 25,
                    [6] = 12,
                    [7] = 23,
                    [8] = 27,
                    [9] = -1,
                    [10] = -1,
                    [11] = -1,
                    [12] = -1,
                },
                ["reeval"] = false,
                ["param2"] = "",
                ["normal"] = true,
                ["veteran"] = true,
                ["tank"] = false,
                ["healer"] = false,
                ["param1"] = "",
            },
            ["Overland Green"] = {
                ["normal"] = true,
                ["dps"] = true,
                ["trigger"] = "Overland",
                ["priority"] = 600,
                ["stars"] = {
                    [1] = 79,
                    [2] = 66,
                    [3] = 92,
                    [4] = 83,
                    [5] = -1,
                    [6] = -1,
                    [7] = -1,
                    [8] = -1,
                    [9] = -1,
                    [10] = -1,
                    [11] = -1,
                    [12] = -1,
                },
                ["reeval"] = false,
                ["param2"] = "",
                ["name"] = "Overland Green",
                ["veteran"] = true,
                ["tank"] = true,
                ["healer"] = true,
                ["param1"] = "",
            },
            ["Public / Delve NonStab"] = {
                ["name"] = "Public / Delve NonStab",
                ["dps"] = true,
                ["trigger"] = "Public Instance *",
                ["priority"] = 630,
                ["stars"] = {
                    [1] = -1,
                    [2] = -1,
                    [3] = -1,
                    [4] = -1,
                    [5] = 25,
                    [6] = 12,
                    [7] = 23,
                    [8] = 27,
                    [9] = -1,
                    [10] = -1,
                    [11] = -1,
                    [12] = -1,
                },
                ["reeval"] = false,
                ["param2"] = "",
                ["normal"] = true,
                ["veteran"] = true,
                ["tank"] = false,
                ["healer"] = false,
                ["param1"] = "",
            },
            ["Public / Delve Green"] = {
                ["name"] = "Public / Delve Green",
                ["dps"] = true,
                ["trigger"] = "Public Instance *",
                ["priority"] = 620,
                ["stars"] = {
                    [1] = 79,
                    [2] = 66,
                    [3] = 86,
                    [4] = 91,
                    [5] = -1,
                    [6] = -1,
                    [7] = -1,
                    [8] = -1,
                    [9] = -1,
                    [10] = -1,
                    [11] = -1,
                    [12] = -1,
                },
                ["reeval"] = false,
                ["param2"] = "",
                ["normal"] = true,
                ["veteran"] = true,
                ["tank"] = true,
                ["healer"] = true,
                ["param1"] = "",
            },
            ["Overland Dps NonStab"] = {
                ["normal"] = true,
                ["dps"] = true,
                ["trigger"] = "Overland",
                ["priority"] = 610,
                ["stars"] = {
                    [1] = -1,
                    [2] = -1,
                    [3] = -1,
                    [4] = -1,
                    [5] = 25,
                    [6] = 12,
                    [7] = 23,
                    [8] = 27,
                    [9] = -1,
                    [10] = -1,
                    [11] = -1,
                    [12] = -1,
                },
                ["reeval"] = false,
                ["param2"] = "",
                ["name"] = "Overland Dps NonStab",
                ["veteran"] = true,
                ["tank"] = false,
                ["healer"] = false,
                ["param1"] = "",
            },
        },
    },
    ["PVP"] = {
        description = "A set of rules that slots:\n\n|ca5d752Gifted Rider|r, |ca5d752Steed's Blessing|r, |ca5d752Liquid Efficiency|r, and |ca5d752War Mount|r on all roles;\n\n|ce46b2eBoundless Vitality|r, |ce46b2eJuggernaut|r, |ce46b2eRejuvenation|r, |ce46b2eStrategic Reserve|r, |c59bae7Backstabber|r, |c59bae7Fighting Finesse|r, |c59bae7Deadly Aim|r, and |c59bae7Resilience|r on dps;\n\nwhen you enter Cyrodiil or Imperial City / Sewers.",
        rules = {
            ["IC Dps Red / Blue"] = {
                ["trigger"] = "Cyrodiil",
                ["name"] = "IC Dps Red / Blue",
                ["priority"] = 730,
                ["param2"] = "",
                ["reeval"] = false,
                ["veteran"] = true,
                ["normal"] = true,
                ["stars"] = {
                    [1] = -1,
                    [2] = -1,
                    [3] = -1,
                    [4] = -1,
                    [5] = 31,
                    [6] = 12,
                    [7] = 25,
                    [8] = 13,
                    [9] = 2,
                    [10] = 59,
                    [11] = 35,
                    [12] = 49,
                },
                ["param1"] = "",
                ["tank"] = false,
                ["dps"] = true,
                ["healer"] = false,
            },
            ["Cyro Dps Red / Blue"] = {
                ["trigger"] = "Cyrodiil",
                ["param2"] = "",
                ["priority"] = 710,
                ["param1"] = "",
                ["veteran"] = true,
                ["normal"] = true,
                ["dps"] = true,
                ["healer"] = false,
                ["tank"] = false,
                ["reeval"] = false,
                ["name"] = "Cyro Dps Red / Blue",
                ["stars"] = {
                    [1] = -1,
                    [2] = -1,
                    [3] = -1,
                    [4] = -1,
                    [5] = 31,
                    [6] = 12,
                    [7] = 25,
                    [8] = 13,
                    [9] = 2,
                    [10] = 59,
                    [11] = 35,
                    [12] = 49,
                },
            },
            ["IC Green"] = {
                ["trigger"] = "Cyrodiil",
                ["name"] = "IC Green",
                ["priority"] = 720,
                ["param2"] = "",
                ["reeval"] = false,
                ["veteran"] = true,
                ["normal"] = true,
                ["stars"] = {
                    [1] = 92,
                    [2] = 66,
                    [3] = 86,
                    [4] = 82,
                    [5] = -1,
                    [6] = -1,
                    [7] = -1,
                    [8] = -1,
                    [9] = -1,
                    [10] = -1,
                    [11] = -1,
                    [12] = -1,
                },
                ["param1"] = "",
                ["tank"] = true,
                ["dps"] = true,
                ["healer"] = true,
            },
            ["Cyro Green"] = {
                ["trigger"] = "Cyrodiil",
                ["param2"] = "",
                ["priority"] = 700,
                ["param1"] = "",
                ["veteran"] = true,
                ["normal"] = true,
                ["dps"] = true,
                ["healer"] = true,
                ["tank"] = true,
                ["name"] = "Cyro Green",
                ["reeval"] = false,
                ["stars"] = {
                    [1] = 92,
                    [2] = 66,
                    [3] = 86,
                    [4] = 82,
                    [5] = -1,
                    [6] = -1,
                    [7] = -1,
                    [8] = -1,
                    [9] = -1,
                    [10] = -1,
                    [11] = -1,
                    [12] = -1,
                },
            },
        },
    },
}
