DynamicCP = DynamicCP or {}

-- Keep track of our own pending slottables, even though slottables.lua also has it
-- because slottables.lua is for presets and it's possible the user still has pending
-- changes in a preset
-- For now, only allow pending for one tree, [slotIndex] = skillId
local pendingSlottables = nil

-- [1] = emptyEntry,
local emptyEntries = {}

local offsets = {
    Green = 0,
    Blue = 4,
    Red = 8,
}

---------------------------------------------------------------------
-- Utility
---------------------------------------------------------------------
-- Flip the key and value for easier use for quickstars
local function GetFlippedSlottables()
    local committed = DynamicCP.GetCommittedSlottables() -- [skillId] = index
    local flipped = {}
    for skillId, slotIndex in pairs(committed) do
        flipped[slotIndex] = skillId
    end
    return flipped
end

---------------------------------------------------------------------
-- Provides list of stars that have enough points to be slotted
-- {[skillId] = points,}
local function GetAvailableSlottables(tree)
    local treeToIndex = {
        Green = 1,
        Blue = 2,
        Red = 3,
    }
    -- [disciplineIndex][skillIndex] = points
    local committedPoints = DynamicCP.GetCommittedCP()
    local available = {}

    local disciplineIndex = treeToIndex[tree]
    local disciplineData = committedPoints[disciplineIndex]
    for skillIndex, points in pairs(disciplineData) do
        local skillId = GetChampionSkillId(disciplineIndex, skillIndex)
        if (CanChampionSkillTypeBeSlotted(GetChampionSkillType(skillId)) and WouldChampionSkillNodeBeUnlocked(skillId, points)) then
            available[skillId] = points
        end
    end

    return available
end


---------------------------------------------------------------------
-- Pending functions
---------------------------------------------------------------------
local function NeedsSlottableRespec()
    if (not pendingSlottables) then
        return false
    end

    local committed = GetFlippedSlottables()
    for slotIndex, skillId in pairs(pendingSlottables) do
        -- If star is not already slotted in the same slot, then we're done

        local committedId = committed[slotIndex]
        if (committedId == 0) then committedId = -1 end
        if (committedId ~= skillId) then
            return true
        end
    end

    -- If nothing changed, then we can just clear everything
    pendingSlottables = nil
    return false
end

local function SetSlottableSlot(slotIndex, skillId)
    if (not pendingSlottables) then
        pendingSlottables = {}
    end
    pendingSlottables[slotIndex] = skillId


    -- Check the other slots
    local committed = GetFlippedSlottables()
    if (skillId == -1) then return end
    for dropdownIndex = 1, 4 do
        local offset = math.floor((slotIndex - 1) / 4) * 4
        local i = offset + dropdownIndex
        if (slotIndex ~= i) then
            local currentId = pendingSlottables[i]
            if (not currentId) then
                currentId = committed[i]
            end

            -- If it's currently slotted in a different dropdown, it needs to be removed
            if (currentId == skillId) then
                local dropdown = ZO_ComboBox_ObjectFromContainer(DynamicCPQuickstarsList:GetNamedChild("Star" .. tostring(dropdownIndex)))
                dropdown:SelectItem(emptyEntries[dropdownIndex])
            end
        end
    end
end

---------------------------------------------------------------------
-- Button click handlers
---------------------------------------------------------------------
function DynamicCP.OnQuickstarConfirm()
    PrepareChampionPurchaseRequest(false)

    -- Convert pending points to purchase request
    for slotIndex, skillId in pairs(pendingSlottables) do
        local id = skillId
        if (id == -1) then
            id = nil
        end
        AddHotbarSlotToChampionPurchaseRequest(slotIndex, id)
    end

    -- Should be able to just use this because points aren't being changed
    -- If we want to do point respecs too eventually, will probably
    -- need to use the button spend points again, with confirmation dialog
    SendChampionPurchaseRequest()

    -- TODO: add message maybe
end

function DynamicCP.OnQuickstarCancel()
    DynamicCP.SelectQuickstarTab("REFRESH")
end


---------------------------------------------------------------------
-- Slot selected handler
---------------------------------------------------------------------
local function OnStarSelected(tree, dropdownIndex, skillId, origSkillId)
    local dropdownControl = DynamicCPQuickstarsList:GetNamedChild("Star" .. tostring(dropdownIndex))
    local slotIndex = offsets[tree] + dropdownIndex

    -- Show the unsaved changes icon if it is changed
    if (skillId == origSkillId) then
        dropdownControl:GetNamedChild("Unsaved"):SetHidden(true)
    else
        dropdownControl:GetNamedChild("Unsaved"):SetHidden(false)
    end

    SetSlottableSlot(slotIndex, skillId)

    -- Show/hide confirm/cancel buttons
    local needsRespec = NeedsSlottableRespec()
    if (needsRespec) then
        DynamicCPQuickstarsListConfirm:SetHidden(false)
        DynamicCPQuickstarsListCancel:SetHidden(false)
    else
        DynamicCPQuickstarsListConfirm:SetHidden(true)
        DynamicCPQuickstarsListCancel:SetHidden(true)
    end
end


---------------------------------------------------------------------
-- Reinitialize dropdowns for the particular tree
---------------------------------------------------------------------
local function UpdateDropdowns(tree)
    if (tree == "NONE") then return end
    local selectedColor = {
        Green = "a5d752",
        Blue = "59bae7",
        Red = "e46b2e",
    }
    local slottedColor = {
        Green = "7f9c4f",
        Blue = "5096b3",
        Red = "b56238",
    }

    local offset = offsets[tree]
    local committed = DynamicCP.GetCommittedSlottables()
    local flipped = GetFlippedSlottables()
    local availableSlottables = GetAvailableSlottables(tree)

    for i = 1, 4 do
        local dropdown = ZO_ComboBox_ObjectFromContainer(DynamicCPQuickstarsList:GetNamedChild("Star" .. tostring(i)))
        dropdown:ClearItems()
        dropdown:SetSortsItems(false)
        local entryToSelect = nil
        local selectedSkillId = flipped[offset + i]
        if (not selectedSkillId or selectedSkillId == 0) then
            selectedSkillId = -1
        end

        -- Iterate through all available slottable stars and add sort keys and format name
        local sortedSlottables = {}
        local index = 1
        for skillId, points in pairs(availableSlottables) do
            local name = zo_strformat("<<C:1>>", GetChampionSkillName(skillId))

            -- Adjust the color of the item according to whether it's slotted (mastermind, anyone?)
            local sortKey = 99
            if (skillId == selectedSkillId) then
                -- For the currently slotted in the same slot
                name = "|c" .. selectedColor[tree] .. name .. "|r"
                sortKey = committed[skillId]
            elseif (committed[skillId]) then
                -- Currently slotted in a different slot
                name = "|c" .. slottedColor[tree] .. name .. "|r"
                sortKey = committed[skillId]
            end
            sortedSlottables[index] = {skillId = skillId, name = name, sortKey = sortKey}
            index = index + 1
        end

        -- Add an empty item
        local emptyName = "---"
        if (selectedSkillId == -1) then
            emptyName = "|c" .. selectedColor[tree] .. emptyName .. "|r"
        end
        sortedSlottables[index] = {skillId = -1, name = emptyName, sortKey = 100}

        -- Sort the table according to sort keys
        table.sort(sortedSlottables, function(item1, item2)
            return item1.sortKey < item2.sortKey
        end)

        -- Add sorted items to dropdown
        for _, data in ipairs(sortedSlottables) do
            local function OnItemSelected(_, _, entry)
                DynamicCP.dbg("Selected " .. data.name .. " " .. tostring(data.skillId))
                OnStarSelected(tree, i, data.skillId, selectedSkillId)
            end

            local entry = ZO_ComboBox:CreateItemEntry(data.name, OnItemSelected)
            dropdown:AddItem(entry, ZO_COMBOBOX_SUPRESS_UPDATE)
            if (data.skillId == selectedSkillId) then
                entryToSelect = entry
            end
            if (data.skillId == -1) then
                emptyEntries[i] = entry
            end
        end

        dropdown:UpdateItems()
        dropdown:SelectItem(entryToSelect)
    end
end


---------------------------------------------------------------------
-- Set backdrops to reflect which tab is selected
---------------------------------------------------------------------
local function SetBackdrops(tree)
    DynamicCPQuickstarsGreenButtonBackdrop:SetCenterColor(0, 0, 0, 1)
    DynamicCPQuickstarsBlueButtonBackdrop:SetCenterColor(0, 0, 0, 1)
    DynamicCPQuickstarsRedButtonBackdrop:SetCenterColor(0, 0, 0, 1)

    if (tree == "NONE") then return end
    local colors = {
        Green = {0.55, 0.78, 0.22, 1},
        Blue = {0.35, 0.73, 0.9, 1},
        Red = {0.88, 0.4, 0.19, 1},
    }
    local color = colors[tree]
    DynamicCPQuickstarsListBackdrop:SetCenterColor(unpack(color))
    DynamicCPQuickstarsListConfirmBackdrop:SetCenterColor(unpack(color))
    DynamicCPQuickstarsListCancelBackdrop:SetCenterColor(unpack(color))

    DynamicCPQuickstars:GetNamedChild(tree .. "Button"):GetNamedChild("Backdrop"):SetCenterColor(unpack(color))
end


---------------------------------------------------------------------
-- Called when user clicks tab button
---------------------------------------------------------------------
function DynamicCP.SelectQuickstarTab(tree)
    DynamicCP.dbg("selecting " .. tostring(tree))
    -- TODO: show warning if navigating off of the tab with unsaved changes?
    -- Keep same if we are just refreshing the dropdowns
    if (tree == "REFRESH") then
        tree = DynamicCP.savedOptions.selectedQuickstarTab
    elseif (tree == DynamicCP.savedOptions.selectedQuickstarTab) then
        -- Same tab = close it instead
        tree = "NONE"
    end
    DynamicCP.savedOptions.selectedQuickstarTab = tree
    pendingSlottables = nil
    DynamicCPQuickstarsList:SetHidden(tree == "NONE")

    -- Set backdrops to appropriate color
    SetBackdrops(tree)

    -- Update dropdowns
    UpdateDropdowns(tree)

    -- Hide confirm/cancel buttons
    DynamicCPQuickstarsListConfirm:SetHidden(true)
    DynamicCPQuickstarsListCancel:SetHidden(true)
end


---------------------------------------------------------------------
-- Window
---------------------------------------------------------------------
-- On move stop
function DynamicCP.SaveQuickstarsPosition()
    DynamicCP.savedOptions.quickstarsX = DynamicCPQuickstars:GetLeft()
    DynamicCP.savedOptions.quickstarsY = DynamicCPQuickstars:GetTop()
end

---------------------------------------------------------------------
-- Should be called on init and also when user changes window width
function DynamicCP.ResizeQuickstars()
    local dropdownWidth = DynamicCP.savedOptions.quickstarsWidth
    DynamicCPQuickstarsList:SetWidth(dropdownWidth + 8)
    DynamicCPQuickstarsListStar1:SetWidth(dropdownWidth)
    DynamicCPQuickstarsListStar2:SetWidth(dropdownWidth)
    DynamicCPQuickstarsListStar3:SetWidth(dropdownWidth)
    DynamicCPQuickstarsListStar4:SetWidth(dropdownWidth)
end


---------------------------------------------------------------------
-- Init
function DynamicCP.InitQuickstars()
    DynamicCPQuickstars:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, DynamicCP.savedOptions.quickstarsX, DynamicCP.savedOptions.quickstarsY)
    DynamicCPQuickstars:SetHidden(not DynamicCP.savedOptions.showQuickstars)
    DynamicCPQuickstars:SetMovable(not DynamicCP.savedOptions.lockQuickstars)

    DynamicCP.ResizeQuickstars()
    DynamicCP.SelectQuickstarTab("REFRESH")

    local alpha = DynamicCP.savedOptions.quickstarsAlpha
    DynamicCPQuickstarsGreenButtonBackdrop:SetAlpha(alpha)
    DynamicCPQuickstarsBlueButtonBackdrop:SetAlpha(alpha)
    DynamicCPQuickstarsRedButtonBackdrop:SetAlpha(alpha)
    DynamicCPQuickstarsListBackdrop:SetAlpha(alpha)
    DynamicCPQuickstarsListCancelBackdrop:SetAlpha(alpha)
    DynamicCPQuickstarsListConfirmBackdrop:SetAlpha(alpha)

    DynamicCPQuickstars:SetScale(DynamicCP.savedOptions.quickstarsScale)
end
