DynamicCP = DynamicCP or {}

--[[
/script for line=1,9 do d(GetChampionDisciplineName(line)) for skill=1,4 do d("    "..GetAbilityName(GetChampionAbilityId(line,skill))) end end
1 - The Tower - Green left
    1 - Bashing Focus
    2 - Sprinter
    3 - Siphoner
    4 - Warlord
2 - The Lord - Red right
    1 - Heavy Armor Focus
    2 - Bastion
    3 - Expert Defender
    4 - Quick Recovery
3 - The Lady - Red mid
    1 - Light Armor Focus
    2 - Thick Skinned
    3 - Hardy
    4 - Elemental Defender
4 - The Steed - Red left
    1 - Medium Armor Focus
    2 - Ironclad
    3 - Spell Shield
    4 - Resistant
5 - The Ritual - Blue right
    1 - Thaumaturge
    2 - Precise Strikes
    3 - Piercing
    4 - Mighty
6 - The Atronach - Blue mid
    1 - Physical Weapon Expert
    2 - Shattering Blows
    3 - Master-at-Arms Staff
    4 - Expert
7 - The Apprentice - Blue left
    1 - Elemental Expert
    2 - Spell Erosion
    3 - Elfborn
    4 - Blessed
8 - The Shadow - Green right
    1 - Befoul
    2 - Shade
    3 - Shadow Ward
    4 - Tumbling
9 - The Lover - Green mid
    1 - Mooncalf
    2 - Arcanist
    3 - Healthy
    4 - Tenacity 
]]

DynamicCP.kyzerPresets = {
    ["Red"] = 
    {
        ["vCR/vKA DPS/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 56,
                [3] = 70,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [2] = 
            {
                [4] = 32,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 56,
                [3] = 0,
            },
        },
        ["vAS OT"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 16,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
            [2] = 
            {
                [4] = 32,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 40,
                [3] = 37,
            },
        },
        ["vMA"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 32,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [2] = 
            {
                [4] = 11,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 49,
                [1] = 0,
                [2] = 48,
                [3] = 49,
            },
        },
        ["vHRC DPS/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 32,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [2] = 
            {
                [4] = 11,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 49,
                [1] = 0,
                [2] = 48,
                [3] = 49,
            },
        },
        ["Stuhn"] = 
        {
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Warden"] = false,
                ["Sorcerer"] = false,
                ["Dragonknight"] = false,
                ["Templar"] = false,
                ["Nightblade"] = true,
            },
            [2] = 
            {
                [4] = 19,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 32,
                [1] = 0,
                [2] = 66,
                [3] = 32,
            },
            [4] = 
            {
                [4] = 48,
                [1] = 0,
                [2] = 73,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
        },
        ["vSS Tank"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 16,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 49,
                [1] = 0,
                [2] = 81,
                [3] = 43,
            },
        },
        ["vBRP"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 41,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [2] = 
            {
                [4] = 23,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 37,
                [3] = 32,
            },
        },
        ["vHRC Tank"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 27,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 37,
                [1] = 0,
                [2] = 61,
                [3] = 64,
            },
        },
        ["Bowgank"] = 
        {
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Warden"] = false,
                ["Sorcerer"] = false,
                ["Dragonknight"] = false,
                ["Templar"] = false,
                ["Nightblade"] = true,
            },
            [2] = 
            {
                [4] = 11,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 49,
                [1] = 0,
                [2] = 34,
                [3] = 49,
            },
            [4] = 
            {
                [4] = 61,
                [1] = 0,
                [2] = 66,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
        },
        ["Bombblade"] = 
        {
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Warden"] = false,
                ["Sorcerer"] = false,
                ["Dragonknight"] = false,
                ["Templar"] = false,
                ["Nightblade"] = true,
            },
            [2] = 
            {
                [4] = 32,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 56,
                [3] = 0,
            },
            [4] = 
            {
                [4] = 10,
                [1] = 0,
                [2] = 56,
                [3] = 60,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
        },
        ["vSO DPS/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 61,
                [3] = 30,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [2] = 
            {
                [4] = 11,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 56,
                [3] = 56,
            },
        },
        ["vMoL Tank"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 5,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
            [2] = 
            {
                [4] = 11,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 66,
                [3] = 43,
            },
        },
        ["vAA DPS/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 74,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [2] = 
            {
                [4] = 11,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 48,
                [3] = 0,
            },
        },
        ["vHoF Tank"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 11,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 66,
                [3] = 56,
            },
        },
        ["vSS LokkHM DPS"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 61,
                [3] = 45,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [2] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 44,
                [3] = 0,
            },
        },
        ["vCR Mini Tank"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
            [2] = 
            {
                [4] = 19,
                [1] = 29,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 66,
                [3] = 19,
            },
        },
        ["vMoL DPS/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 32,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [2] = 
            {
                [4] = 11,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 49,
                [1] = 0,
                [2] = 48,
                [3] = 49,
            },
        },
        ["vAS DPS"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 87,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [2] = 
            {
                [4] = 11,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 0,
                [3] = 27,
            },
        },
        ["vHoF DPS/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 66,
                [3] = 33,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [2] = 
            {
                [4] = 11,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 48,
                [3] = 56,
            },
        },
        ["vKA MT"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
            [2] = 
            {
                [4] = 19,
                [1] = 1,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 49,
                [1] = 0,
                [2] = 56,
                [3] = 64,
            },
        },
        ["vCR ZM/Port Tank"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 5,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
            [2] = 
            {
                [4] = 43,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 75,
                [1] = 0,
                [2] = 66,
                [3] = 0,
            },
        },
        ["vVH"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 32,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [2] = 
            {
                [4] = 11,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 18,
                [3] = 64,
            },
        },
        ["vAS Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 55,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 53,
                [1] = 0,
                [2] = 44,
                [3] = 37,
            },
        },
        ["vAS MT"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 42,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 49,
                [1] = 0,
                [2] = 34,
                [3] = 64,
            },
        },
        ["vAA MT"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 24,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 66,
                [3] = 43,
            },
        },
        ["vSO Tank"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 16,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 43,
                [1] = 0,
                [2] = 66,
                [3] = 64,
            },
        },
    },
    ["Green"] = 
    {
        ["vAS TH"] = 
        {
            [8] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 0,
                [3] = 56,
            },
            [1] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 21,
                [3] = 0,
            },
            [9] = 
            {
                [4] = 37,
                [1] = 0,
                [2] = 100,
                [3] = 0,
            },
            ["classes"] = 
            {
                ["Necromancer"] = true,
                ["Warden"] = true,
                ["Sorcerer"] = false,
                ["Dragonknight"] = false,
                ["Templar"] = true,
                ["Nightblade"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = false,
                ["Healer"] = true,
            },
        },
        ["IR"] = 
        {
            [8] = 
            {
                [4] = 61,
                [1] = 0,
                [2] = 0,
                [3] = 61,
            },
            [1] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 14,
                [3] = 0,
            },
            [9] = 
            {
                [4] = 23,
                [1] = 11,
                [2] = 100,
                [3] = 0,
            },
            ["classes"] = 
            {
                ["Necromancer"] = true,
                ["Warden"] = true,
                ["Sorcerer"] = true,
                ["Dragonknight"] = true,
                ["Templar"] = true,
                ["Nightblade"] = true,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
        },
        ["FalgravnHM"] = 
        {
            [8] = 
            {
                [4] = 81,
                [1] = 0,
                [2] = 0,
                [3] = 81,
            },
            [1] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
            [9] = 
            {
                [4] = 33,
                [1] = 0,
                [2] = 75,
                [3] = 0,
            },
        },
        ["vAS OT"] = 
        {
            [8] = 
            {
                [4] = 52,
                [1] = 0,
                [2] = 0,
                [3] = 81,
            },
            [1] = 
            {
                [4] = 23,
                [1] = 9,
                [2] = 19,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
            [9] = 
            {
                [4] = 43,
                [1] = 0,
                [2] = 43,
                [3] = 0,
            },
        },
        ["NB-stam"] = 
        {
            [8] = 
            {
                [4] = 51,
                [1] = 0,
                [2] = 0,
                [3] = 44,
            },
            [1] = 
            {
                [4] = 48,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [9] = 
            {
                [4] = 27,
                [1] = 100,
                [2] = 0,
                [3] = 0,
            },
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = true,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
        },
        ["Stuhn"] = 
        {
            [8] = 
            {
                [4] = 66,
                [1] = 0,
                [2] = 3,
                [3] = 9,
            },
            [1] = 
            {
                [4] = 66,
                [1] = 0,
                [2] = 0,
                [3] = 1,
            },
            [9] = 
            {
                [4] = 0,
                [1] = 76,
                [2] = 49,
                [3] = 0,
            },
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = true,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
        },
        ["NB Tank"] = 
        {
            [8] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 0,
                [3] = 44,
            },
            [1] = 
            {
                [4] = 56,
                [1] = 2,
                [2] = 0,
                [3] = 0,
            },
            [9] = 
            {
                [4] = 56,
                [1] = 7,
                [2] = 49,
                [3] = 0,
            },
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = true,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
        },
        ["vCR GH"] = 
        {
            [8] = 
            {
                [4] = 37,
                [1] = 0,
                [2] = 0,
                [3] = 40,
            },
            [1] = 
            {
                [4] = 44,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [9] = 
            {
                [4] = 0,
                [1] = 49,
                [2] = 100,
                [3] = 0,
            },
        },
        ["Bowgank"] = 
        {
            [8] = 
            {
                [4] = 48,
                [1] = 0,
                [2] = 23,
                [3] = 23,
            },
            [1] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [9] = 
            {
                [4] = 27,
                [1] = 56,
                [2] = 37,
                [3] = 0,
            },
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = true,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
        },
        ["Bombblade"] = 
        {
            [8] = 
            {
                [4] = 66,
                [1] = 0,
                [2] = 21,
                [3] = 0,
            },
            [1] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [9] = 
            {
                [4] = 0,
                [1] = 27,
                [2] = 100,
                [3] = 0,
            },
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = true,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
        },
        ["vKA MT DK"] = 
        {
            [8] = 
            {
                [4] = 72,
                [1] = 0,
                [2] = 0,
                [3] = 81,
            },
            [1] = 
            {
                [4] = 34,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [9] = 
            {
                [4] = 19,
                [1] = 0,
                [2] = 64,
                [3] = 0,
            },
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = true,
                ["Sorcerer"] = false,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
        },
        ["Magdps"] = 
        {
            [8] = 
            {
                [4] = 48,
                [1] = 0,
                [2] = 0,
                [3] = 56,
            },
            [1] = 
            {
                [4] = 34,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [9] = 
            {
                [4] = 32,
                [1] = 0,
                [2] = 100,
                [3] = 0,
            },
        },
        ["vCR Tank"] = 
        {
            [8] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 0,
                [3] = 44,
            },
            [1] = 
            {
                [4] = 56,
                [1] = 9,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
            [9] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 49,
                [3] = 0,
            },
        },
        ["Tankcro"] = 
        {
            [8] = 
            {
                [4] = 37,
                [1] = 0,
                [2] = 0,
                [3] = 72,
            },
            [1] = 
            {
                [4] = 41,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [9] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 56,
                [3] = 0,
            },
            ["classes"] = 
            {
                ["Necromancer"] = true,
                ["Nightblade"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
        },
        ["vMA Mag"] = 
        {
            [8] = 
            {
                [4] = 37,
                [1] = 0,
                [2] = 0,
                [3] = 40,
            },
            [1] = 
            {
                [4] = 44,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [9] = 
            {
                [4] = 49,
                [1] = 0,
                [2] = 100,
                [3] = 0,
            },
        },
        ["Stam/Tank"] = 
        {
            [8] = 
            {
                [4] = 44,
                [1] = 0,
                [2] = 0,
                [3] = 48,
            },
            [1] = 
            {
                [4] = 40,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = true,
                ["Healer"] = false,
            },
            [9] = 
            {
                [4] = 27,
                [1] = 100,
                [2] = 11,
                [3] = 0,
            },
        },
        ["Tankblade"] = 
        {
            [8] = 
            {
                [4] = 44,
                [1] = 0,
                [2] = 0,
                [3] = 56,
            },
            [1] = 
            {
                [4] = 41,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [9] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 65,
                [3] = 0,
            },
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = true,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
        },
    },
    ["Blue"] = 
    {
        ["Tank Alk wSharp"] = 
        {
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 0,
                [3] = 58,
            },
            [6] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 44,
            },
            [7] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 0,
                [3] = 40,
            },
        },
        ["StamDK"] = 
        {
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = true,
                ["Sorcerer"] = false,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 49,
                [1] = 56,
                [2] = 48,
                [3] = 61,
            },
            [6] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 56,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
        },
        ["Markarth stamNB"] = 
        {
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = true,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 64,
                [1] = 40,
                [2] = 72,
                [3] = 3,
            },
            [6] = 
            {
                [4] = 0,
                [1] = 19,
                [2] = 0,
                [3] = 72,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
        },
        ["Tank Alk noSharp"] = 
        {
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 0,
                [3] = 59,
            },
            [6] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 52,
            },
            [7] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 0,
                [3] = 31,
            },
        },
        ["Magcro Parse"] = 
        {
            ["classes"] = 
            {
                ["Necromancer"] = true,
                ["Nightblade"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 72,
                [2] = 0,
                [3] = 3,
            },
            [6] = 
            {
                [4] = 9,
                [1] = 0,
                [2] = 0,
                [3] = 66,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 64,
                [2] = 0,
                [3] = 56,
            },
        },
        ["clive vMA"] = 
        {
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 26,
                [2] = 0,
                [3] = 0,
            },
            [6] = 
            {
                [4] = 25,
                [1] = 0,
                [2] = 0,
                [3] = 66,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 64,
                [2] = 23,
                [3] = 66,
            },
        },
        ["Magden"] = 
        {
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = false,
                ["Warden"] = true,
                ["Dragonknight"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 40,
                [2] = 0,
                [3] = 0,
            },
            [6] = 
            {
                [4] = 19,
                [1] = 0,
                [2] = 0,
                [3] = 66,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 64,
                [2] = 9,
                [3] = 72,
            },
        },
        ["Bombblade"] = 
        {
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = true,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [6] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 100,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 64,
                [2] = 55,
                [3] = 51,
            },
        },
        ["MagNB Optie"] = 
        {
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = true,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 20,
                [2] = 0,
                [3] = 0,
            },
            [6] = 
            {
                [4] = 39,
                [1] = 0,
                [2] = 0,
                [3] = 72,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 64,
                [2] = 9,
                [3] = 66,
            },
        },
        ["Magplar Parse"] = 
        {
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = true,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 72,
                [2] = 0,
                [3] = 3,
            },
            [6] = 
            {
                [4] = 29,
                [1] = 0,
                [2] = 0,
                [3] = 52,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 49,
                [2] = 9,
                [3] = 56,
            },
        },
        ["Stamsorc 2H"] = 
        {
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = true,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 64,
                [1] = 23,
                [2] = 56,
                [3] = 58,
            },
            [6] = 
            {
                [4] = 0,
                [1] = 3,
                [2] = 0,
                [3] = 66,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
        },
        ["MagDK"] = 
        {
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = true,
                ["Sorcerer"] = false,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 75,
                [2] = 0,
                [3] = 0,
            },
            [6] = 
            {
                [4] = 19,
                [1] = 0,
                [2] = 0,
                [3] = 56,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 49,
                [2] = 10,
                [3] = 61,
            },
        },
        ["vVH Magblade?"] = 
        {
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = true,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 40,
                [2] = 0,
                [3] = 0,
            },
            [6] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 61,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 64,
                [2] = 39,
                [3] = 66,
            },
        },
        ["My Stamplar"] = 
        {
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = true,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 64,
                [1] = 28,
                [2] = 52,
                [3] = 60,
            },
            [6] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 66,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
        },
        ["vKA Magblade"] = 
        {
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = true,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 31,
                [2] = 0,
                [3] = 0,
            },
            [6] = 
            {
                [4] = 37,
                [1] = 0,
                [2] = 0,
                [3] = 72,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 64,
                [2] = 0,
                [3] = 66,
            },
        },
        ["Healer"] = 
        {
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 40,
                [2] = 0,
                [3] = 0,
            },
            [6] = 
            {
                [4] = 9,
                [1] = 0,
                [2] = 0,
                [3] = 5,
            },
            [7] = 
            {
                [4] = 75,
                [1] = 37,
                [2] = 23,
                [3] = 81,
            },
        },
        ["Skinny stamblade"] = 
        {
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = true,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 64,
                [1] = 13,
                [2] = 72,
                [3] = 55,
            },
            [6] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 66,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
        },
        ["Magsorc Parse"] = 
        {
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = true,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 72,
                [2] = 0,
                [3] = 3,
            },
            [6] = 
            {
                [4] = 19,
                [1] = 0,
                [2] = 0,
                [3] = 61,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 49,
                [2] = 10,
                [3] = 56,
            },
        },
        ["WW"] = 
        {
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 64,
                [1] = 18,
                [2] = 66,
                [3] = 21,
            },
            [6] = 
            {
                [4] = 0,
                [1] = 29,
                [2] = 0,
                [3] = 72,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
        },
        ["Mark Magsorc"] = 
        {
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = true,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 72,
                [2] = 0,
                [3] = 3,
            },
            [6] = 
            {
                [4] = 14,
                [1] = 0,
                [2] = 0,
                [3] = 61,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 64,
                [2] = 0,
                [3] = 56,
            },
        },
        ["Bowgank"] = 
        {
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Nightblade"] = true,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [5] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 66,
                [3] = 67,
            },
            [6] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 73,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
        },
        ["Stuhn"] = 
        {
            [5] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 56,
                [3] = 50,
            },
            [6] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 81,
            },
            [7] = 
            {
                [4] = 27,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
        },
    },
}
