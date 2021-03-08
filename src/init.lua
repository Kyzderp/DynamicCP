DynamicCP = DynamicCP or {}
DynamicCP.name = "DynamicCP"
DynamicCP.version = "0.1.0"

local defaultOptions = {
    firstTime = true,
    cp = {
        Red = {},
        Green = {},
        Blue = {},
    },
    hideBackground = false,
    showLabels = true,
}

local labelsInitialized = false

---------------------------------------------------------------------
-- Collect messages for displaying later when addon is not fully loaded
DynamicCP.messages = {}
function DynamicCP.dbg(msg)
    if (not msg) then return end
    if (CHAT_SYSTEM.primaryContainer) then
        d("|c6666FF[DCP]|r " .. tostring(msg))
    else
        DynamicCP.messages[#DynamicCP.messages + 1] = msg
    end
end

---------------------------------------------------------------------
-- Star labels?
function DynamicCP.ShowLabels()
    for i = 1, ZO_ChampionPerksCanvas:GetNumChildren() do
        local child = ZO_ChampionPerksCanvas:GetChild(i)
        if (child.star and child.star.championSkillData) then
            local id = child.star.championSkillData.championSkillId
            local n = WINDOW_MANAGER:CreateControl("$(parent)Name", child, CT_LABEL)
            n:SetInheritScale(false)
            n:SetAnchor(CENTER, child, CENTER, 0, -40)
            n:SetText(GetChampionSkillName(id))
            local slottable = CanChampionSkillTypeBeSlotted(GetChampionSkillType(id))
            if (slottable) then
                n:SetFont("ZoFontWinH4")
                n:SetColor(1, 1, 1)
            else
                n:SetFont("ZoFontWinH2")
                n:SetColor(1, 1, 0.5)
            end
        elseif (child.star and child.star.championClusterData) then
            -- TODOFLAMES: add labels for inside. how to register callback?
            d("cluster")
            local text = ""
            for _, clusterChild in ipairs(child.star.championClusterData.clusterChildren) do
                text = text .. clusterChild:GetFormattedName() .. "\n"
            end
            local n = WINDOW_MANAGER:CreateControl("$(parent)Name", child, CT_LABEL)
            n:SetInheritScale(false)
            n:SetAnchor(CENTER, child, CENTER, 0, -40)
            n:SetText(text)
            n:SetFont("ZoFontGameSmall")
            n:SetColor(1, 0.7, 1)
        end
    end
end

---------------------------------------------------------------------
-- Post Load (player loaded)
local function OnPlayerActivated(_, initial)
    -- Soft dependency on pChat because its chat restore will overwrite
    for i = 1, #DynamicCP.messages do
        d("|c6666FF[DCPdelay]|r " .. DynamicCP.messages[i])
    end
    DynamicCP.messages = {}

    if (DynamicCP.savedOptions.hideBackground) then
        local backgroundOverride = function(line) return "/esoui/art/scrying/backdrop_stars.dds" end 
        GetChampionDisciplineBackgroundTexture = backgroundOverride
        GetChampionDisciplineBackgroundGlowTexture = backgroundOverride
        GetChampionDisciplineBackgroundSelectedTexture = backgroundOverride
        GetChampionClusterBackgroundTexture = backgroundOverride
    end

    PrepareChampionPurchaseRequest(true)
end

---------------------------------------------------------------------
-- Initialize
local function Initialize()
    DynamicCP.dbg("Initializing...")
    DynamicCP.savedOptions = ZO_SavedVars:NewAccountWide("DynamicCPSavedVariables", 1, "Options", defaultOptions)
    -- TODO: create settings menu

    -- Populate defaults only on first time, otherwise the keys will be remade even if user deletes
    if (DynamicCP.savedOptions.firstTime) then
        DynamicCP.savedOptions.cp = DynamicCP.defaultPresets
        DynamicCP.savedOptions.firstTime = false
    end

    EVENT_MANAGER:RegisterForEvent(DynamicCP.name, EVENT_PLAYER_ACTIVATED, OnPlayerActivated)

    CHAMPION_PERKS_CONSTELLATIONS_FRAGMENT:RegisterCallback("StateChange", function(oldState, newState)
            DynamicCP:InitializeDropdowns() -- Call it every time in case LFG role is changed
            if (not labelsInitialized) then
                labelsInitialized = true
                if (DynamicCP.savedOptions.showLabels) then
                    DynamicCP.ShowLabels()
                end
            end
        end)
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
