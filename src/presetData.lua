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
    ["Green"] = 
    {
        ["PvP Stamblade Generic"] = 
        {
            [8] = 
            {
                [4] = 66,
                [1] = 0,
                [2] = 2,
                [3] = 13,
            },
            [1] = 
            {
                [4] = 66,
                [1] = 0,
                [2] = 9,
                [3] = 1,
            },
            ["classes"] = 
            {
                ["Templar"] = false,
                ["Necromancer"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = true,
                ["Sorcerer"] = false,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [9] = 
            {
                [4] = 0,
                [1] = 64,
                [2] = 49,
                [3] = 0,
            },
        },
        ["Stamdps Generic"] = 
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
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [9] = 
            {
                [4] = 27,
                [1] = 100,
                [2] = 0,
                [3] = 0,
            },
        },
        ["Tank Generic"] = 
        {
            [8] = 
            {
                [4] = 44,
                [1] = 0,
                [2] = 0,
                [3] = 66,
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
                ["Healer"] = false,
                ["Tank"] = true,
                ["Dps"] = false,
            },
            [9] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 64,
                [3] = 0,
            },
        },
        ["vKA MT"] = 
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
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = true,
                ["Dps"] = false,
            },
            [9] = 
            {
                [4] = 19,
                [1] = 0,
                [2] = 64,
                [3] = 0,
            },
        },
        ["PvP Bombblade"] = 
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
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = false,
                ["Necromancer"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = true,
                ["Sorcerer"] = false,
            },
            [9] = 
            {
                [4] = 0,
                [1] = 27,
                [2] = 100,
                [3] = 0,
            },
        },
        ["Magdps/Heal Generic"] = 
        {
            [8] = 
            {
                [4] = 44,
                [1] = 0,
                [2] = 0,
                [3] = 51,
            },
            [1] = 
            {
                [4] = 48,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = true,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [9] = 
            {
                [4] = 27,
                [1] = 0,
                [2] = 100,
                [3] = 0,
            },
        },
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
            ["roles"] = 
            {
                ["Healer"] = true,
                ["Tank"] = false,
                ["Dps"] = false,
            },
            [9] = 
            {
                [4] = 37,
                [1] = 0,
                [2] = 100,
                [3] = 0,
            },
        },
    },
    ["Red"] = 
    {
        ["vSO Tank"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 0,
            },
            [2] = 
            {
                [4] = 16,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = true,
                ["Dps"] = false,
            },
            [3] = 
            {
                [4] = 43,
                [1] = 0,
                [2] = 66,
                [3] = 64,
            },
        },
        ["vDSA Magdps/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 0,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = true,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [3] = 
            {
                [4] = 49,
                [1] = 30,
                [2] = 61,
                [3] = 49,
            },
        },
        ["vHoF Magdps/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 0,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = true,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [3] = 
            {
                [4] = 49,
                [1] = 10,
                [2] = 81,
                [3] = 49,
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
            [2] = 
            {
                [4] = 43,
                [1] = 16,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = true,
                ["Dps"] = false,
            },
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 66,
                [3] = 0,
            },
        },
        ["vDSA Stamdps"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 30,
                [2] = 81,
                [3] = 0,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [3] = 
            {
                [4] = 49,
                [1] = 0,
                [2] = 61,
                [3] = 49,
            },
        },
        ["vMA/vVH"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 26,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 51,
                [3] = 56,
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
            [2] = 
            {
                [4] = 0,
                [1] = 11,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = true,
                ["Dps"] = false,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 66,
                [3] = 56,
            },
        },
        ["vCR Portal Tank"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 1,
            },
            [2] = 
            {
                [4] = 43,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = true,
                ["Dps"] = false,
            },
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 81,
                [3] = 0,
            },
        },
        ["vSS Dps"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 66,
                [3] = 40,
            },
            [2] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 44,
                [3] = 0,
            },
        },
        ["vHRC Dps/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 16,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = true,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 61,
                [3] = 56,
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
            [2] = 
            {
                [4] = 0,
                [1] = 16,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = true,
                ["Dps"] = false,
            },
            [3] = 
            {
                [4] = 49,
                [1] = 0,
                [2] = 81,
                [3] = 43,
            },
        },
        ["vAA Tank"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 0,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 11,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = true,
                ["Dps"] = false,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 66,
                [3] = 56,
            },
        },
        ["PvP Dps Generic"] = 
        {
            [4] = 
            {
                [4] = 36,
                [1] = 0,
                [2] = 72,
                [3] = 0,
            },
            [2] = 
            {
                [4] = 32,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [3] = 
            {
                [4] = 37,
                [1] = 0,
                [2] = 56,
                [3] = 37,
            },
        },
        ["vAS OT"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 0,
            },
            [2] = 
            {
                [4] = 43,
                [1] = 1,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = true,
                ["Dps"] = false,
            },
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 44,
                [3] = 37,
            },
        },
        ["vAA Dps/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 61,
            },
            [2] = 
            {
                [4] = 11,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = true,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 61,
                [3] = 0,
            },
        },
        ["vAS Dps"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 87,
            },
            [2] = 
            {
                [4] = 11,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 0,
                [3] = 27,
            },
        },
        ["vHoF Stamdps"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 10,
                [2] = 81,
                [3] = 0,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [3] = 
            {
                [4] = 49,
                [1] = 0,
                [2] = 81,
                [3] = 49,
            },
        },
        ["vSO Magdps/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 73,
                [3] = 0,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = true,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [3] = 
            {
                [4] = 43,
                [1] = 24,
                [2] = 66,
                [3] = 64,
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
            [2] = 
            {
                [4] = 0,
                [1] = 18,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = true,
                ["Dps"] = false,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 51,
                [3] = 64,
            },
        },
        ["vSS Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 34,
            },
            [2] = 
            {
                [4] = 19,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = true,
                ["Tank"] = false,
                ["Dps"] = false,
            },
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 72,
                [3] = 0,
            },
        },
        ["vKA Tank"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 0,
            },
            [2] = 
            {
                [4] = 19,
                [1] = 3,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = true,
                ["Dps"] = false,
            },
            [3] = 
            {
                [4] = 37,
                [1] = 0,
                [2] = 66,
                [3] = 64,
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
            [2] = 
            {
                [4] = 0,
                [1] = 16,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = true,
                ["Dps"] = false,
            },
            [3] = 
            {
                [4] = 43,
                [1] = 0,
                [2] = 66,
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
                [3] = 27,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = true,
                ["Tank"] = false,
                ["Dps"] = false,
            },
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 61,
                [3] = 37,
            },
        },
        ["vDSA Tank"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 0,
            },
            [2] = 
            {
                [4] = 19,
                [1] = 6,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = true,
                ["Dps"] = false,
            },
            [3] = 
            {
                [4] = 49,
                [1] = 0,
                [2] = 66,
                [3] = 49,
            },
        },
        ["vSO Stamdps"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 24,
                [2] = 73,
                [3] = 0,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [3] = 
            {
                [4] = 43,
                [1] = 0,
                [2] = 66,
                [3] = 64,
            },
        },
        ["vMoL Dps/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 73,
                [3] = 48,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = true,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 66,
                [3] = 19,
            },
        },
        ["vCR/vKA Dps/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 66,
                [3] = 55,
            },
            [2] = 
            {
                [4] = 19,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = true,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 66,
                [3] = 0,
            },
        },
        ["vBRP Dps/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 42,
            },
            [2] = 
            {
                [4] = 11,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = true,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 48,
                [3] = 32,
            },
        },
        ["vMoL Tank"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 3,
            },
            [2] = 
            {
                [4] = 19,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = true,
                ["Dps"] = false,
            },
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 66,
                [3] = 37,
            },
        },
        ["vBRP Tank"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 0,
            },
            [2] = 
            {
                [4] = 11,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = true,
                ["Dps"] = false,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 66,
                [3] = 56,
            },
        },
    },
    ["Blue"] = 
    {
        ["clive vMA"] = 
        {
            [6] = 
            {
                [4] = 25,
                [1] = 0,
                [2] = 0,
                [3] = 66,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 26,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 64,
                [2] = 23,
                [3] = 66,
            },
        },
        ["PvP Bowgank"] = 
        {
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = false,
                ["Dragonknight"] = false,
                ["Warden"] = false,
                ["Necromancer"] = false,
                ["Nightblade"] = true,
                ["Sorcerer"] = false,
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
        ["Magplar Dummy"] = 
        {
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = true,
                ["Necromancer"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = false,
                ["Sorcerer"] = false,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 81,
                [2] = 0,
                [3] = 0,
            },
            [6] = 
            {
                [4] = 13,
                [1] = 0,
                [2] = 0,
                [3] = 56,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 64,
                [2] = 0,
                [3] = 56,
            },
        },
        ["PvP Stamblade Generic"] = 
        {
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = false,
                ["Necromancer"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = true,
                ["Sorcerer"] = false,
            },
            [5] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 56,
                [3] = 47,
            },
            [6] = 
            {
                [4] = 0,
                [1] = 19,
                [2] = 0,
                [3] = 81,
            },
            [7] = 
            {
                [4] = 11,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
        },
        ["Magcro Dummy"] = 
        {
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = false,
                ["Necromancer"] = true,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = false,
                ["Sorcerer"] = false,
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
        ["StamDK Dummy"] = 
        {
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = false,
                ["Necromancer"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = true,
                ["Nightblade"] = false,
                ["Sorcerer"] = false,
            },
            [5] = 
            {
                [4] = 49,
                [1] = 66,
                [2] = 56,
                [3] = 38,
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
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
        },
        ["Tank Alkosh nonSharp"] = 
        {
            [6] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 52,
            },
            [5] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 0,
                [3] = 59,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = true,
                ["Dps"] = false,
            },
            [7] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 0,
                [3] = 31,
            },
        },
        ["Stamcro Dummy"] = 
        {
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = false,
                ["Necromancer"] = true,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = false,
                ["Sorcerer"] = false,
            },
            [5] = 
            {
                [4] = 64,
                [1] = 56,
                [2] = 66,
                [3] = 18,
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
        ["PvP Caluurion"] = 
        {
            [6] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 81,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 64,
                [2] = 64,
                [3] = 61,
            },
        },
        ["Healer Generic"] = 
        {
            [6] = 
            {
                [4] = 6,
                [1] = 0,
                [2] = 0,
                [3] = 28,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 40,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Healer"] = true,
                ["Tank"] = false,
                ["Dps"] = false,
            },
            [7] = 
            {
                [4] = 64,
                [1] = 49,
                [2] = 11,
                [3] = 72,
            },
        },
        ["Magblade Dummy"] = 
        {
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = false,
                ["Necromancer"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = true,
                ["Sorcerer"] = false,
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
                [4] = 6,
                [1] = 0,
                [2] = 0,
                [3] = 72,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 56,
                [2] = 0,
                [3] = 61,
            },
        },
        ["Stamsorc Dummy"] = 
        {
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = false,
                ["Necromancer"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = false,
                ["Sorcerer"] = true,
            },
            [5] = 
            {
                [4] = 64,
                [1] = 37,
                [2] = 56,
                [3] = 38,
            },
            [6] = 
            {
                [4] = 0,
                [1] = 3,
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
        ["Magden Dummy"] = 
        {
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = false,
                ["Necromancer"] = false,
                ["Warden"] = true,
                ["Dragonknight"] = false,
                ["Nightblade"] = false,
                ["Sorcerer"] = false,
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
        ["Magsorc Dummy"] = 
        {
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = false,
                ["Necromancer"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = false,
                ["Sorcerer"] = true,
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
        ["PvP Bombblade"] = 
        {
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = false,
                ["Necromancer"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = true,
                ["Sorcerer"] = false,
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
        ["MagDK Dummy"] = 
        {
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = false,
                ["Necromancer"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = true,
                ["Nightblade"] = false,
                ["Sorcerer"] = false,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 81,
                [2] = 0,
                [3] = 0,
            },
            [6] = 
            {
                [4] = 16,
                [1] = 0,
                [2] = 0,
                [3] = 61,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 56,
                [2] = 0,
                [3] = 56,
            },
        },
        ["vVH Magblade"] = 
        {
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = false,
                ["Dragonknight"] = false,
                ["Warden"] = false,
                ["Necromancer"] = false,
                ["Nightblade"] = true,
                ["Sorcerer"] = false,
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
        ["vVH Magsorc"] = 
        {
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = false,
                ["Dragonknight"] = false,
                ["Warden"] = false,
                ["Necromancer"] = false,
                ["Nightblade"] = false,
                ["Sorcerer"] = true,
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
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 66,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 64,
                [2] = 48,
                [3] = 66,
            },
        },
        ["Tank Alkosh Sharp"] = 
        {
            [6] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 44,
            },
            [5] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 0,
                [3] = 58,
            },
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = true,
                ["Dps"] = false,
            },
            [7] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 0,
                [3] = 40,
            },
        },
        ["Stamplar Dummy"] = 
        {
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = true,
                ["Necromancer"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = false,
                ["Sorcerer"] = false,
            },
            [5] = 
            {
                [4] = 64,
                [1] = 18,
                [2] = 72,
                [3] = 38,
            },
            [6] = 
            {
                [4] = 0,
                [1] = 6,
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
        ["Stamden Dummy"] = 
        {
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = false,
                ["Necromancer"] = false,
                ["Warden"] = true,
                ["Dragonknight"] = false,
                ["Nightblade"] = false,
                ["Sorcerer"] = false,
            },
            [5] = 
            {
                [4] = 75,
                [1] = 16,
                [2] = 66,
                [3] = 38,
            },
            [6] = 
            {
                [4] = 0,
                [1] = 3,
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
        ["Stamblade Skinny"] = 
        {
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = false,
                ["Dragonknight"] = false,
                ["Warden"] = false,
                ["Necromancer"] = false,
                ["Nightblade"] = true,
                ["Sorcerer"] = false,
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
        ["Stamblade Dummy"] = 
        {
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = false,
                ["Necromancer"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = true,
                ["Sorcerer"] = false,
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
        ["vSS Magblade"] = 
        {
            ["roles"] = 
            {
                ["Healer"] = false,
                ["Tank"] = false,
                ["Dps"] = true,
            },
            ["classes"] = 
            {
                ["Templar"] = false,
                ["Dragonknight"] = false,
                ["Warden"] = false,
                ["Necromancer"] = false,
                ["Nightblade"] = true,
                ["Sorcerer"] = false,
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
                [4] = 27,
                [1] = 0,
                [2] = 0,
                [3] = 72,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 64,
                [2] = 10,
                [3] = 66,
            },
        },
    },
}

DynamicCP.defaultPresets = {
        ["Green"] = 
    {
        ["PvP Stamblade Generic"] = 
        {
            [8] = 
            {
                [4] = 66,
                [1] = 0,
                [2] = 2,
                [3] = 13,
            },
            [1] = 
            {
                [4] = 66,
                [1] = 0,
                [2] = 9,
                [3] = 1,
            },
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = true,
            },
            ["roles"] = 
            {
                ["Tank"] = false,
                ["Dps"] = true,
                ["Healer"] = false,
            },
            [9] = 
            {
                [4] = 0,
                [1] = 64,
                [2] = 49,
                [3] = 0,
            },
        },
        ["Tank Generic"] = 
        {
            [1] = 
            {
                [1] = 0,
                [2] = 0,
                [3] = 0,
                [4] = 40,
            },
            [8] = 
            {
                [1] = 0,
                [2] = 0,
                [3] = 66,
                [4] = 44,
            },
            [9] = 
            {
                [1] = 0,
                [2] = 64,
                [3] = 0,
                [4] = 56,
            },
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
        },
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
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [9] = 
            {
                [4] = 37,
                [1] = 0,
                [2] = 100,
                [3] = 0,
            },
        },
        ["Stamdps Generic"] = 
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
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = false,
            },
            [9] = 
            {
                [4] = 27,
                [1] = 100,
                [2] = 0,
                [3] = 0,
            },
        },
        ["vKA MT"] = 
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
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = true,
                ["Healer"] = false,
            },
            [9] = 
            {
                [4] = 19,
                [1] = 0,
                [2] = 64,
                [3] = 0,
            },
        },
        ["Magdps/Heal Generic"] = 
        {
            [8] = 
            {
                [4] = 44,
                [1] = 0,
                [2] = 0,
                [3] = 51,
            },
            [1] = 
            {
                [4] = 48,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [9] = 
            {
                [4] = 27,
                [1] = 0,
                [2] = 100,
                [3] = 0,
            },
        },
    },
    ["Red"] = 
    {
        ["vAA Dps/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 61,
            },
            [2] = 
            {
                [4] = 11,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 61,
                [3] = 0,
            },
        },
        ["vDSA Magdps/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 0,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [3] = 
            {
                [4] = 49,
                [1] = 30,
                [2] = 61,
                [3] = 49,
            },
        },
        ["vCR Portal Tank"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 1,
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
                [4] = 64,
                [1] = 0,
                [2] = 81,
                [3] = 0,
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
                [1] = 18,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 51,
                [3] = 64,
            },
        },
        ["vSO Magdps/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 73,
                [3] = 0,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [3] = 
            {
                [4] = 43,
                [1] = 24,
                [2] = 66,
                [3] = 64,
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
        ["vAS Dps"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 87,
            },
            [2] = 
            {
                [4] = 11,
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
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 0,
                [3] = 27,
            },
        },
        ["vHoF Magdps/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 0,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [3] = 
            {
                [4] = 49,
                [1] = 10,
                [2] = 81,
                [3] = 49,
            },
        },
        ["vDSA Stamdps"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 30,
                [2] = 81,
                [3] = 0,
            },
            [2] = 
            {
                [4] = 0,
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
            [3] = 
            {
                [4] = 49,
                [1] = 0,
                [2] = 61,
                [3] = 49,
            },
        },
        ["PvP Dps Generic"] = 
        {
            [4] = 
            {
                [4] = 36,
                [1] = 0,
                [2] = 72,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Tank"] = false,
                ["Dps"] = true,
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
                [4] = 37,
                [1] = 0,
                [2] = 56,
                [3] = 37,
            },
        },
        ["vDSA Tank"] = 
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
                [1] = 6,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 49,
                [1] = 0,
                [2] = 66,
                [3] = 49,
            },
        },
        ["vAS Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 27,
            },
            [2] = 
            {
                [4] = 0,
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
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 61,
                [3] = 37,
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
        ["vBRP Tank"] = 
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
                [4] = 11,
                [1] = 0,
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
        ["vKA Tank"] = 
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
                [1] = 3,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 37,
                [1] = 0,
                [2] = 66,
                [3] = 64,
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
                [4] = 43,
                [1] = 16,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 66,
                [3] = 0,
            },
        },
        ["vBRP Dps/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 42,
            },
            [2] = 
            {
                [4] = 11,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 48,
                [3] = 32,
            },
        },
        ["vHoF Stamdps"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 10,
                [2] = 81,
                [3] = 0,
            },
            [2] = 
            {
                [4] = 0,
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
            [3] = 
            {
                [4] = 49,
                [1] = 0,
                [2] = 81,
                [3] = 49,
            },
        },
        ["vSS Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 34,
            },
            [2] = 
            {
                [4] = 19,
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
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 72,
                [3] = 0,
            },
        },
        ["vMA/vVH"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 26,
            },
            [2] = 
            {
                [4] = 0,
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
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 51,
                [3] = 56,
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
                [4] = 16,
                [1] = 0,
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
        ["vHRC Dps/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 16,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 61,
                [3] = 56,
            },
        },
        ["vAA Tank"] = 
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
        ["vSO Stamdps"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 24,
                [2] = 73,
                [3] = 0,
            },
            [2] = 
            {
                [4] = 0,
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
            [3] = 
            {
                [4] = 43,
                [1] = 0,
                [2] = 66,
                [3] = 64,
            },
        },
        ["vMoL Dps/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 73,
                [3] = 48,
            },
            [2] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 66,
                [3] = 19,
            },
        },
        ["vCR/vKA Dps/Heal"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 66,
                [3] = 55,
            },
            [2] = 
            {
                [4] = 19,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Dps"] = true,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 66,
                [3] = 0,
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
        ["vSS Dps"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 66,
                [3] = 40,
            },
            [2] = 
            {
                [4] = 64,
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
            [3] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 44,
                [3] = 0,
            },
        },
        ["vMoL Tank"] = 
        {
            [4] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 81,
                [3] = 3,
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
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 66,
                [3] = 37,
            },
        },
        ["vAS OT"] = 
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
                [4] = 43,
                [1] = 1,
                [2] = 0,
                [3] = 0,
            },
            [3] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 44,
                [3] = 37,
            },
        },
    },
    ["Blue"] = 
    {
        ["Magplar Dummy"] = 
        {
            [6] = 
            {
                [4] = 13,
                [1] = 0,
                [2] = 0,
                [3] = 56,
            },
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = true,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = false,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 81,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Tank"] = false,
                ["Dps"] = true,
                ["Healer"] = false,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 64,
                [2] = 0,
                [3] = 56,
            },
        },
        ["Stamcro Dummy"] = 
        {
            [6] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 66,
            },
            ["classes"] = 
            {
                ["Necromancer"] = true,
                ["Sorcerer"] = false,
                ["Templar"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = false,
            },
            [5] = 
            {
                [4] = 64,
                [1] = 56,
                [2] = 66,
                [3] = 18,
            },
            ["roles"] = 
            {
                ["Tank"] = false,
                ["Dps"] = true,
                ["Healer"] = false,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
        },
        ["MagDK Dummy"] = 
        {
            [6] = 
            {
                [4] = 16,
                [1] = 0,
                [2] = 0,
                [3] = 61,
            },
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = true,
                ["Nightblade"] = false,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 81,
                [2] = 0,
                [3] = 0,
            },
            ["roles"] = 
            {
                ["Tank"] = false,
                ["Dps"] = true,
                ["Healer"] = false,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 56,
                [2] = 0,
                [3] = 56,
            },
        },
        ["StamDK Dummy"] = 
        {
            [6] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 61,
            },
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = true,
                ["Nightblade"] = false,
            },
            [5] = 
            {
                [4] = 49,
                [1] = 66,
                [2] = 56,
                [3] = 38,
            },
            ["roles"] = 
            {
                ["Tank"] = false,
                ["Dps"] = true,
                ["Healer"] = false,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
        },
        ["Stamsorc Dummy"] = 
        {
            [6] = 
            {
                [4] = 0,
                [1] = 3,
                [2] = 0,
                [3] = 72,
            },
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Sorcerer"] = true,
                ["Templar"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = false,
            },
            [5] = 
            {
                [4] = 64,
                [1] = 37,
                [2] = 56,
                [3] = 38,
            },
            ["roles"] = 
            {
                ["Tank"] = false,
                ["Dps"] = true,
                ["Healer"] = false,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
        },
        ["PvP Stamblade Generic"] = 
        {
            [6] = 
            {
                [4] = 0,
                [1] = 19,
                [2] = 0,
                [3] = 81,
            },
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = true,
            },
            [5] = 
            {
                [4] = 56,
                [1] = 0,
                [2] = 56,
                [3] = 47,
            },
            ["roles"] = 
            {
                ["Tank"] = false,
                ["Dps"] = true,
                ["Healer"] = false,
            },
            [7] = 
            {
                [4] = 11,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
        },
        ["Stamblade Dummy"] = 
        {
            [6] = 
            {
                [4] = 0,
                [1] = 19,
                [2] = 0,
                [3] = 72,
            },
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = true,
            },
            [5] = 
            {
                [4] = 64,
                [1] = 40,
                [2] = 72,
                [3] = 3,
            },
            ["roles"] = 
            {
                ["Tank"] = false,
                ["Dps"] = true,
                ["Healer"] = false,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
        },
        ["Stamplar Dummy"] = 
        {
            [6] = 
            {
                [4] = 0,
                [1] = 6,
                [2] = 0,
                [3] = 72,
            },
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = true,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = false,
            },
            [5] = 
            {
                [4] = 64,
                [1] = 18,
                [2] = 72,
                [3] = 38,
            },
            ["roles"] = 
            {
                ["Tank"] = false,
                ["Dps"] = true,
                ["Healer"] = false,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
        },
        ["Healer Generic"] = 
        {
            ["roles"] = 
            {
                ["Dps"] = false,
                ["Tank"] = false,
                ["Healer"] = true,
            },
            [5] = 
            {
                [1] = 40,
                [2] = 0,
                [3] = 0,
                [4] = 0,
            },
            [6] = 
            {
                [1] = 0,
                [2] = 0,
                [3] = 28,
                [4] = 6,
            },
            [7] = 
            {
                [1] = 49,
                [2] = 11,
                [3] = 72,
                [4] = 64,
            },
        },
        ["Magden Dummy"] = 
        {
            [6] = 
            {
                [4] = 14,
                [1] = 0,
                [2] = 0,
                [3] = 61,
            },
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
                ["Warden"] = true,
                ["Dragonknight"] = false,
                ["Nightblade"] = false,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 72,
                [2] = 0,
                [3] = 3,
            },
            ["roles"] = 
            {
                ["Tank"] = false,
                ["Dps"] = true,
                ["Healer"] = false,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 64,
                [2] = 0,
                [3] = 56,
            },
        },
        ["Tank Alkosh Sharp"] = 
        {
            [6] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 44,
            },
            [5] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 0,
                [3] = 58,
            },
            ["roles"] = 
            {
                ["Tank"] = true,
                ["Dps"] = false,
                ["Healer"] = false,
            },
            [7] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 0,
                [3] = 40,
            },
        },
        ["Magcro Dummy"] = 
        {
            [6] = 
            {
                [4] = 9,
                [1] = 0,
                [2] = 0,
                [3] = 66,
            },
            ["classes"] = 
            {
                ["Necromancer"] = true,
                ["Sorcerer"] = false,
                ["Templar"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = false,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 72,
                [2] = 0,
                [3] = 3,
            },
            ["roles"] = 
            {
                ["Tank"] = false,
                ["Dps"] = true,
                ["Healer"] = false,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 64,
                [2] = 0,
                [3] = 56,
            },
        },
        ["Magblade Dummy"] = 
        {
            [6] = 
            {
                [4] = 6,
                [1] = 0,
                [2] = 0,
                [3] = 72,
            },
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = true,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 72,
                [2] = 0,
                [3] = 3,
            },
            ["roles"] = 
            {
                ["Tank"] = false,
                ["Dps"] = true,
                ["Healer"] = false,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 56,
                [2] = 0,
                [3] = 61,
            },
        },
        ["Tank Alkosh nonSharp"] = 
        {
            [6] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 52,
            },
            [5] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 0,
                [3] = 59,
            },
            ["roles"] = 
            {
                ["Tank"] = true,
                ["Dps"] = false,
                ["Healer"] = false,
            },
            [7] = 
            {
                [4] = 64,
                [1] = 0,
                [2] = 0,
                [3] = 31,
            },
        },
        ["Magsorc Dummy"] = 
        {
            [6] = 
            {
                [4] = 14,
                [1] = 0,
                [2] = 0,
                [3] = 61,
            },
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Sorcerer"] = true,
                ["Templar"] = false,
                ["Warden"] = false,
                ["Dragonknight"] = false,
                ["Nightblade"] = false,
            },
            [5] = 
            {
                [4] = 0,
                [1] = 72,
                [2] = 0,
                [3] = 3,
            },
            ["roles"] = 
            {
                ["Tank"] = false,
                ["Dps"] = true,
                ["Healer"] = false,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 64,
                [2] = 0,
                [3] = 56,
            },
        },
        ["Stamden Dummy"] = 
        {
            [6] = 
            {
                [4] = 0,
                [1] = 3,
                [2] = 0,
                [3] = 72,
            },
            ["classes"] = 
            {
                ["Necromancer"] = false,
                ["Sorcerer"] = false,
                ["Templar"] = false,
                ["Warden"] = true,
                ["Dragonknight"] = false,
                ["Nightblade"] = false,
            },
            [5] = 
            {
                [4] = 75,
                [1] = 16,
                [2] = 66,
                [3] = 38,
            },
            ["roles"] = 
            {
                ["Tank"] = false,
                ["Dps"] = true,
                ["Healer"] = false,
            },
            [7] = 
            {
                [4] = 0,
                [1] = 0,
                [2] = 0,
                [3] = 0,
            },
        },
    },
}
