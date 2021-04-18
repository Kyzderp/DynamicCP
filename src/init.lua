DynamicCP = DynamicCP or {}
DynamicCP.name = "DynamicCP"
DynamicCP.version = "0.6.6"

DynamicCP.experimental = true -- Flip to true when developing

local defaultOptions = {
    firstTime = true,
    cp = {
        Red = {},
        Green = {},
        Blue = {},
    },
    pulldownExpanded = true,

-- user options
    hideBackground = false,
    showLabels = true,
    dockWithSpace = true,
    scale = 1.0,
    debug = false,
    showLeaveWarning = true,
    showCooldownWarning = true,
    slotStars = true,
    slotHigherStars = true,
    doubleClick = true,
    showPresetsWithCP = true,
    showPulldownPoints = false,
    showPointGainedMessage = true,
    presetsBackdropAlpha = 0.5,
    passiveLabelColor = {1, 1, 0.5},
    passiveLabelSize = 24,
    slottableLabelColor = {1, 1, 1},
    slottableLabelSize = 18,
    clusterLabelColor = {1, 0.7, 1},
    clusterLabelSize = 13,
    showTotalsLabel = true,
    quickstarsX = GuiRoot:GetWidth() / 4, -- Anchor TOPLEFT
    quickstarsY = GuiRoot:GetHeight() / 4,
    selectedQuickstarTab = "Green",
    showQuickstars = true,
    lockQuickstars = false,
    quickstarsWidth = 200,
    quickstarsAlpha = 0.5,
    quickstarsScale = 1.0,
    quickstarsVertical = true,
    quickstarsMirrored = false,
    quickstarsDropdownHideSlotted = false,
    quickstarsShowOnHud = true,
    quickstarsShowOnHudUi = true,
    quickstarsShowOnCpScreen = false,
    quickstarsShowCooldown = true,
    quickstarsCooldownColor = {0.7, 0.7, 0.7},

    customRules = {
        playSound = true, -- CHAMPION_POINTS_COMMITTED
        showInChat = true,
        firstTime = true,
        overrideOrder = true,
        autoSlot = false,
        promptConflicts = true,
        rules = {},
    },

    modelessX = GuiRoot:GetWidth() / 4, -- Anchor center
    modelessY = 0,

    -- 1: added quickstarsShowOnHudUi, which should inherit quickstarsShowOnHud
    -- settingsVersion = 1,
}

local initialOpened = false

---------------------------------------------------------------------
-- Collect messages for displaying later when addon is not fully loaded
DynamicCP.dbgMessages = {}
function DynamicCP.dbg(msg)
    if (not msg) then return end
    if (not DynamicCP.savedOptions.debug) then return end
    if (CHAT_SYSTEM.primaryContainer) then
        d("|c6666FF[DCP]|r " .. tostring(msg))
    else
        DynamicCP.dbgMessages[#DynamicCP.dbgMessages + 1] = msg
    end
end

DynamicCP.messages = {}
function DynamicCP.msg(msg)
    if (not msg) then return end
    if (CHAT_SYSTEM.primaryContainer) then
        CHAT_SYSTEM:AddMessage("|c3bdb5e[DynamicCP]|cAAAAAA " .. tostring(msg) .. "|r")
    else
        DynamicCP.messages[#DynamicCP.messages + 1] = msg
    end
end


---------------------------------------------------------------------
-- Post Load (player loaded)
local function OnPlayerActivated(_, initial)
    -- Display all the delayed chat
    for i = 1, #DynamicCP.dbgMessages do
        d("|c6666FF[DCPdelay]|r " .. tostring(DynamicCP.dbgMessages[i]))
    end
    DynamicCP.dbgMessages = {}

    for i = 1, #DynamicCP.messages do
        CHAT_SYSTEM:AddMessage("|c3bdb5e[DynamicCP]|cAAAAAA " .. tostring(DynamicCP.messages[i]) .. "|r")
    end
    DynamicCP.messages = {}

    -- Post load init
    DynamicCP.InitPoints()
    DynamicCP.InitQuickstars()

    if (DynamicCP.savedOptions.hideBackground) then
        local backgroundOverride = function(line) return "/esoui/art/scrying/backdrop_stars.dds" end 
        GetChampionDisciplineBackgroundTexture = backgroundOverride
        GetChampionDisciplineBackgroundGlowTexture = backgroundOverride
        GetChampionDisciplineBackgroundSelectedTexture = backgroundOverride
        GetChampionClusterBackgroundTexture = backgroundOverride
    end

    -- Hide the pulldown because it's expanded by default
    if (not DynamicCP.savedOptions.pulldownExpanded) then
        DynamicCPPulldownTabArrowExpanded:SetHidden(true)
        DynamicCPPulldownTabArrowHidden:SetHidden(false)
        DynamicCPPulldown:SetHidden(true)
        DynamicCPPulldownTab:SetAnchor(TOP, ZO_ChampionPerksActionBar, BOTTOM)
    end

    DynamicCPInfoLabel:SetHidden(not DynamicCP.savedOptions.showTotalsLabel)

    EVENT_MANAGER:UnregisterForEvent(DynamicCP.name .. "Activated", EVENT_PLAYER_ACTIVATED)
end


---------------------------------------------------------------------
-- Register events
local function RegisterEvents()
    EVENT_MANAGER:RegisterForEvent(DynamicCP.name .. "Activated", EVENT_PLAYER_ACTIVATED, OnPlayerActivated)

    EVENT_MANAGER:RegisterForEvent(DynamicCP.name .. "Purchase", EVENT_CHAMPION_PURCHASE_RESULT,
        function(eventCode, result)
            DynamicCP.OnPurchased(eventCode, result)
            DynamicCP.ClearCommittedCP() -- Invalidate the cache
            DynamicCP.ClearCommittedSlottables() -- Invalidate the cache
            DynamicCP.OnSlotsChanged()
            DynamicCP.QuickstarsOnPurchased(result)
        end)

    EVENT_MANAGER:RegisterForEvent(DynamicCP.name .. "Gained", EVENT_CHAMPION_POINT_GAINED,
        function(_, championPointsDelta)
            -- Show CP gained message
            if (DynamicCP.savedOptions.showPointGainedMessage) then
                DynamicCP.dbg("Gained " .. tostring(championPointsDelta))
                -- This is what the game code uses to generate the center announcement text,
                -- but it's actually kinda buggy. If you gain more than 1 point at once, the
                -- text shows the wrong tree gained because it's already updated.
                -- We'll live with that for now though...
                local gainedString = ZO_CenterScreenAnnounce_GetEventHandler(EVENT_CHAMPION_POINT_GAINED)(championPointsDelta).secondaryText
                gainedString = string.gsub(gainedString, "\n", " ")
                if (championPointsDelta > 1) then
                    gainedString = tostring(championPointsDelta) .. " points: " .. gainedString
                end
                CHAT_SYSTEM:AddMessage("|cAAAAAAGained " .. gainedString .. "|r")
            end

            -- Update totals label
            DynamicCPInfoLabel:SetText(string.format(
                "|cc4c19eTotal:|r |t32:32:esoui/art/champion/champion_icon_32.dds|t %d"
                .. " |t32:32:esoui/art/champion/champion_points_stamina_icon-hud-32.dds|t %d"
                .. " |t32:32:esoui/art/champion/champion_points_magicka_icon-hud-32.dds|t %d"
                .. " |t32:32:esoui/art/champion/champion_points_health_icon-hud-32.dds|t %d",
                GetPlayerChampionPointsEarned(),
                GetNumSpentChampionPoints(3) + GetNumUnspentChampionPoints(3),
                GetNumSpentChampionPoints(1) + GetNumUnspentChampionPoints(1),
                GetNumSpentChampionPoints(2) + GetNumUnspentChampionPoints(2)))
        end)

    -- I guess I have to fix it myself. This prevents the bug with star animation not being initialized
    ZO_PreHook(CHAMPION_PERKS, "OnUpdate", function()
        CHAMPION_PERKS.firstStarConfirm = false
        return false
    end)
end


---------------------------------------------------------------------
-- Initialize
local function Initialize()
    DynamicCP.savedOptions = ZO_SavedVars:NewAccountWide("DynamicCPSavedVariables", 1, "Options", defaultOptions)
    DynamicCP.dbg("Initializing...")

    -- Populate defaults only on first time, otherwise the keys will be remade even if user deletes
    if (DynamicCP.savedOptions.firstTime) then
        DynamicCP.savedOptions.cp = DynamicCP.defaultPresets
        DynamicCP.savedOptions.firstTime = false
    end

    if (DynamicCP.experimental) then
        -- TODO: populate with example custom rule
        if (DynamicCP.savedOptions.customRules.firstTime) then
            DynamicCP.savedOptions.customRules.rules = {
                ["Example Trial"] = {
                    name = "Example Trial",
                    trigger = DynamicCP.TRIGGER_TRIAL,
                    priority = 100,
                    normal = true,
                    veteran = true,
                    stars = {
                        [1] = 79, -- Treasure Hunter
                        [2] = 66, -- Steed's Blessing
                        [3] = 86, -- Liquid Efficiency
                        [4] = -1, -- Flex for JoaT Homemaker / Rationer / Upkeep
                        [5] = -1,
                        [6] = -1,
                        [7] = -1,
                        [8] = -1,
                        [9] = -1,
                        [10] = -1,
                        [11] = -1,
                        [12] = -1,
                    },
                    tank = true,
                    healer = true,
                    dps = true,
                    chars = {},
                },
                ["Example Trial Dps"] = {
                    name = "Example Trial Dps",
                    trigger = DynamicCP.TRIGGER_TRIAL,
                    priority = 101,
                    normal = true,
                    veteran = true,
                    stars = {
                        [1] = -1,
                        [2] = -1,
                        [3] = -1,
                        [4] = -1,
                        [5] = 31, -- Backstabber
                        [6] = 12, -- Fighting Finesse
                        [7] = 25, -- Deadly Aim
                        [8] = 27, -- Thaumaturge
                        [9] =  2, -- Boundless Vitality
                        [10] = 34, -- Ironclad
                        [11] = 35, -- Rejuvenation
                        [12] = 56, -- Spirit Mastery
                    },
                    tank = false,
                    healer = false,
                    dps = true,
                    chars = {},
                },
            }
            DynamicCP.AddOptionsForEachCharacter("Example Trial")
            DynamicCP.AddOptionsForEachCharacter("Example Trial Dps")
            -- TODO: unset first time
        end
    end

    -- Migrate settings versions if applicable
    if (not DynamicCP.savedOptions.settingsVersion) then
        DynamicCP.savedOptions.settingsVersion = 0
    end
    if (DynamicCP.savedOptions.settingsVersion < 1) then
        -- Inherit HUD setting for HUD_UI
        DynamicCP.dbg("Inheriting HUD option " .. tostring(DynamicCP.savedOptions.quickstarsShowOnHud))
        DynamicCP.savedOptions.quickstarsShowOnHudUi = DynamicCP.savedOptions.quickstarsShowOnHud
    end
    DynamicCP.savedOptions.settingsVersion = 1

    -- Settings menu
    DynamicCP:CreateSettingsMenu()
    if (DynamicCP.experimental) then
        DynamicCP.CreateCustomRulesMenu()
    end
    ZO_CreateStringId("SI_BINDING_NAME_DCP_TOGGLE_MENU", "Toggle CP Preset Window")
    ZO_CreateStringId("SI_BINDING_NAME_DCP_TOGGLE_QUICKSTARS", "Toggle Quickstars Panel")
    ZO_CreateStringId("SI_BINDING_NAME_DCP_CYCLE_QUICKSTARS", "Cycle Quickstars Tab")

    -- Initialize
    if (DynamicCP.experimental) then
        DynamicCP.InitModelessDialog()
        DynamicCP.InitCustomRules()
    end

    -- Register events
    RegisterEvents()

    CHAMPION_PERKS_CONSTELLATIONS_FRAGMENT:RegisterCallback("StateChange", function(oldState, newState)
        if (newState == SCENE_HIDDEN) then
            DynamicCP.OnExitedCPScreen()
            return
        end

        if (newState ~= SCENE_SHOWN) then return end
        DynamicCPPresets:SetHidden(not DynamicCP.savedOptions.showPresetsWithCP)
        DynamicCP:InitializeDropdowns() -- Call it every time in case LFG role is changed

        -- First time opened calls
        if (not initialOpened) then
            initialOpened = true
            DynamicCP.InitLabels()
            DynamicCP.InitSlottables()
            DynamicCPPresets:SetScale(DynamicCP.savedOptions.scale)
            if (DynamicCP.savedOptions.showLabels) then
                DynamicCP.RefreshLabels(true)
            end
        end
    end)

    SLASH_COMMANDS["/dcp"] = function(arg)
        if (arg == "quickstar" or arg == "quickstars" or arg == "q" or arg == "qs") then
            DynamicCP.ToggleQuickstars()
        else
            DynamicCP.TogglePresetsWindow()
        end
    end
end

---------------------------------------------------------------------
-- On load
local function OnAddOnLoaded(_, addonName)
    if (addonName == DynamicCP.name) then
        EVENT_MANAGER:UnregisterForEvent(DynamicCP.name, EVENT_ADD_ON_LOADED)
        Initialize()
    end
end

EVENT_MANAGER:RegisterForEvent(DynamicCP.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)
