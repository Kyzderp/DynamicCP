DynamicCP = DynamicCP or {}

local selectedTree = "Green"

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
-- Slot selected handler
---------------------------------------------------------------------
local function OnStarSelected(tree, dropdownIndex, skillId)
end


---------------------------------------------------------------------
-- Reinitialize dropdowns for the particular tree
---------------------------------------------------------------------
local function UpdateDropdowns(tree)
    local offsets = {
        Green = 0,
        Blue = 4,
        Red = 8,
    }
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
        local selectedSkillId = flipped[offset + i]
        local entryToSelect = nil

        -- Iterate through all available slottable stars and add sort keys and format name
        local sortedSlottables = {}
        local index = 1
        for skillId, points in pairs(availableSlottables) do
            local name = zo_strformat("<<C:1>>", GetChampionSkillName(skillId))

            -- Adjust the color of the item according to whether it's slotted (mastermind, anyone?)
            local sortKey = 999
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

        -- Sort the table according to sort keys
        table.sort(sortedSlottables, function(item1, item2)
            return item1.sortKey < item2.sortKey
        end)

        -- Add sorted items to dropdown
        for i, data in ipairs(sortedSlottables) do
            local function OnItemSelected(_, _, entry)
                DynamicCP.dbg("Selected " .. tostring(entry) .. " " .. tostring(data.skillId))
                OnStarSelected(tree, i, data.skillId)
            end

            local entry = ZO_ComboBox:CreateItemEntry(data.name, OnItemSelected)
            dropdown:AddItem(entry, ZO_COMBOBOX_SUPRESS_UPDATE)
            if (data.skillId == selectedSkillId) then
                entryToSelect = entry
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
    local colors = {
        Green = {0.55, 0.78, 0.22, 1},
        Blue = {0.35, 0.73, 0.9, 1},
        Red = {0.88, 0.4, 0.19, 1},
    }
    local color = colors[tree]
    DynamicCPQuickstarsListBackdrop:SetCenterColor(unpack(color))
    DynamicCPQuickstarsListConfirmBackdrop:SetCenterColor(unpack(color))
    DynamicCPQuickstarsListCancelBackdrop:SetCenterColor(unpack(color))

    DynamicCPQuickstarsGreenButtonBackdrop:SetCenterColor(0, 0, 0, 1)
    DynamicCPQuickstarsBlueButtonBackdrop:SetCenterColor(0, 0, 0, 1)
    DynamicCPQuickstarsRedButtonBackdrop:SetCenterColor(0, 0, 0, 1)
    DynamicCPQuickstars:GetNamedChild(tree .. "Button"):GetNamedChild("Backdrop"):SetCenterColor(unpack(color))
end


---------------------------------------------------------------------
-- Called when user clicks tab button
---------------------------------------------------------------------
function DynamicCP.SelectQuickstarTab(tree)
    -- Will be nil if we are just refreshing the dropdowns
    if (tree == nil) then
        tree = selectedTree
    end
    selectedTree = tree

    -- Set backdrops to appropriate color
    SetBackdrops(tree)

    -- Update dropdowns
    UpdateDropdowns(tree)

    -- Hide confirm/cancel buttons
    DynamicCPQuickstarsListConfirm:SetHidden(true)
    DynamicCPQuickstarsListCancel:SetHidden(true)
end


---------------------------------------------------------------------
-- On move stop
---------------------------------------------------------------------
function DynamicCP.SaveQuickstarsPosition()
    DynamicCP.savedOptions.quickstarsX = DynamicCPQuickstars:GetLeft()
    DynamicCP.savedOptions.quickstarsY = DynamicCPQuickstars:GetTop()
end


---------------------------------------------------------------------
-- Init
function DynamicCP.InitQuickstars()
    DynamicCPQuickstars:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, DynamicCP.savedOptions.quickstarsX, DynamicCP.savedOptions.quickstarsY)
    -- TODO: show setting

    DynamicCP.SelectQuickstarTab("Green")
end
