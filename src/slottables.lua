DynamicCP = DynamicCP or {}

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
local function AddMouseDoubleClick()
    DynamicCP.dbg("Adding mouse actions")
    -- Slottable stars, at least on the main screen for now
    -- TODO: inner screen
    for i = 1, ZO_ChampionPerksCanvas:GetNumChildren() do
        local child = ZO_ChampionPerksCanvas:GetChild(i)
        if (child.star and child.star.championSkillData) then
            local id = child.star.championSkillData.championSkillId
            if (CanChampionSkillTypeBeSlotted(GetChampionSkillType(id))) then
                if (child:GetHandler("OnMouseDoubleClick") == nil) then
                    DynamicCP.dbg(zo_strformat("Adding doubleclick handler for <<C:1>>", GetChampionSkillName(id)))
                    child:SetHandler("OnMouseDoubleClick", function()
                        ToggleSlotStar(child.star.championSkillData)
                    end)
                end
            end
        end
    end

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
-- Modifications to slottables UI
function DynamicCP.InitSlottables()
    if (DynamicCP.savedOptions.doubleClick) then
        AddMouseDoubleClick()
    end
end
