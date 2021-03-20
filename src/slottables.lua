DynamicCP = DynamicCP or {}

-- Current POSSIBLY PENDING slottables, updates with the UI, [index] = championSkillData
-- ONLY for use with the pulldown, because this is UI-only
local currentSlottables = {}
-- Slottables that are already committed, [index] = skillId
local committedSlottables = nil
-- Slottables that need to be added to purchase request, used from preset
local pendingSlottables = nil

---------------------------------------------------------------------
-- When the star in the constellation is double clicked
local function ToggleSlotStar(championSkillData)
    -- CHAMPION_PERKS.championBar:GetSlot(4):AssignChampionSkillToSlot(ZO_ChampionPerksCanvasStar11.star.championSkillData)
    local id = championSkillData.championSkillId
    if (not CanChampionSkillTypeBeSlotted(GetChampionSkillType(id))) then
        DynamicCP.dbg("WARNING ATTEMPTED TO SLOT NONSLOTTABLE - FROM CLUSTER MAYBE?")
        return
    end

    -- First, check if it's already assigned
    local slot = CHAMPION_PERKS.championBar:FindSlotMatchingChampionSkill(championSkillData)
    if (slot) then
        -- Remove it from the bar
        DynamicCP.dbg(zo_strformat("Unslotting <<C:1>>", GetChampionSkillName(id)))
        slot:ClearSlot()
        return
    end

    -- Find an open slot
    local disciplineIndex = championSkillData.championDisciplineData.disciplineIndex
    for i = 1, 4 do
        local possibleIndex = disciplineIndex * 4 - 4 + i
        local possibleSlot = CHAMPION_PERKS.championBar:GetSlot(possibleIndex)
        if (not possibleSlot.championSkillData) then
            DynamicCP.dbg(zo_strformat("Slotting <<C:1>>", GetChampionSkillName(id)))
            possibleSlot:AssignChampionSkillToSlot(championSkillData)
            return
        end
    end
    DynamicCP.dbg("Couldn't find an empty slot")
end


---------------------------------------------------------------------
-- Register double click handlers
local function AddMouseDoubleClickStars()
    -- Slottable stars, at least on the main screen for now
    for i = 1, ZO_ChampionPerksCanvas:GetNumChildren() do
        local child = ZO_ChampionPerksCanvas:GetChild(i)
        if (child.star and child.star.championSkillData) then
            local id = child.star.championSkillData.championSkillId
            if (CanChampionSkillTypeBeSlotted(GetChampionSkillType(id))) then
                if (child:GetHandler("OnMouseDoubleClick") == nil) then
                    -- DynamicCP.dbg(zo_strformat("Adding doubleclick handler for <<C:1>>", GetChampionSkillName(id)))
                    child:SetHandler("OnMouseDoubleClick", function()
                        ToggleSlotStar(child.star.championSkillData)
                    end)
                end
            end
        end
    end
end
DynamicCP.AddMouseDoubleClickStars = AddMouseDoubleClickStars

local function AddMouseDoubleClick()
    DynamicCP.dbg("Adding mouse actions")

    AddMouseDoubleClickStars()

    -- Do the hotbar slots too
    for i = 1, 12 do
        local slotButton = ZO_ChampionPerksActionBar:GetNamedChild(string.format("Slot%dButton", i))
        if (slotButton:GetHandler("OnMouseDoubleClick") == nil) then
            slotButton:SetHandler("OnMouseDoubleClick", function()
                local slot = CHAMPION_PERKS.championBar:GetSlot(i)
                slot:ClearSlot()
            end)
        end
    end
end

---------------------------------------------------------------------
-- Register callbacks for slot changing
local function CollectCurrentSlottables()
    currentSlottables = {}
    for i = 1, 12 do
        currentSlottables[i] = CHAMPION_PERKS.championBar:GetSlot(i).championSkillData
    end
end

local function OnSlotsChanged()
    DynamicCP.dbg("OnSlotsChanged")
    CollectCurrentSlottables()
    DynamicCP.ApplyCurrentSlottables(currentSlottables)
    -- TODO: display on hud?
end
DynamicCP.OnSlotsChanged = OnSlotsChanged

local function AddSlotChange()
    DynamicCP.dbg("Adding slot change callbacks")

    -- Slot changes from the UI
    CHAMPION_PERKS.championBar:RegisterCallback("SlotChanged", function()
        -- DynamicCP.dbg("slot changed")
        OnSlotsChanged()
    end)

    -- This is called when starting or stopping respec
    CHAMPION_DATA_MANAGER:RegisterCallback("AllPointsChanged", function()
        -- DynamicCP.dbg("all points changed")
        OnSlotsChanged()
    end)
end


---------------------------------------------------------------------
-- Committed slottables
---------------------------------------------------------------------
-- Get cached
local function GetCommittedSlottables()
    -- Cached to avoid more calls
    if (committedSlottables ~= nil) then
        return committedSlottables
    end

    committedSlottables = {}
    for i = 1, 12 do
        local skillId = GetSlotBoundId(i, HOTBAR_CATEGORY_CHAMPION)
        committedSlottables[i] = skillId
        DynamicCP.dbg(zo_strformat("<<1>> <<C:2>>", i, GetChampionSkillName(skillId)))
    end
    return committedSlottables
end
DynamicCP.GetCommittedSlottables = GetCommittedSlottables

-- Clear cache
local function ClearCommittedSlottables()
    committedSlottables = nil
end
DynamicCP.ClearCommittedSlottables = ClearCommittedSlottables


---------------------------------------------------------------------
-- Pending slottables
---------------------------------------------------------------------
local function SetSlottablePoints(slotIndex, skillId)
    if (not pendingSlottables) then
        pendingSlottables = {}
    end
    pendingSlottables[slotIndex] = skillId
end
DynamicCP.SetSlottablePoints = SetSlottablePoints

-- Iterate through the pending slottables and add to purchase request
local function ConvertPendingSlottablesToPurchase()
    if (not pendingSlottables) then return end

    for slotIndex, skillId in pairs(pendingSlottables) do
        AddHotbarSlotToChampionPurchaseRequest(slotIndex, skillId)
    end
end
DynamicCP.ConvertPendingSlottablesToPurchase = ConvertPendingSlottablesToPurchase

---------------------------------------------------------------------
-- Modifications to slottables UI
function DynamicCP.InitSlottables()
    if (DynamicCP.savedOptions.doubleClick) then
        AddMouseDoubleClick()
    end

    AddSlotChange()
    OnSlotsChanged()
end
