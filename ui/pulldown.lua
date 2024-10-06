DynamicCP = DynamicCP or {}

---------------------------------------------------------------------
-- Per-tree values
local function GetMiddlePoint(tree)
    if (tree == "Green") then
        return ZO_ChampionPerksActionBarSlot2:GetCenter() + ZO_ChampionPerksActionBarSlot3:GetCenter()
    elseif (tree == "Blue") then
        return ZO_ChampionPerksActionBarSlot6:GetCenter() + ZO_ChampionPerksActionBarSlot7:GetCenter()
    elseif (tree == "Red") then
        return ZO_ChampionPerksActionBarSlot10:GetCenter() + ZO_ChampionPerksActionBarSlot11:GetCenter()
    end
    return 0
end

local TEXT_COLORS = {
    Green = {0.55, 0.78, 0.22},
    Blue = {0.35, 0.73, 0.9},
    Red = {0.88, 0.4, 0.19},
}

local TEXT_COLORS_HEX = {
    Green = "a5d752",
    Blue = "59bae7",
    Red = "e46b2e",
}

local INDEX_TO_TREE = {
    [1] = "Green",
    [2] = "Blue",
    [3] = "Red",
}

local TREE_TO_FIRST_INDEX = {
    Green = 1,
    Blue = 5,
    Red = 9,
}

local function GetStarControlFromIndex(index)
    local tree = INDEX_TO_TREE[math.floor((index - 1) / 4) + 1]
    local starIndex = (index - 1) % 4 + 1
    return DynamicCPPulldown:GetNamedChild(tree):GetNamedChild("Star" .. tostring(starIndex))
end

---------------------------------------------------------------------
-- Slot sets
---------------------------------------------------------------------
-- Called from pulldown.xml. Disable the save button if no name is specified
function DynamicCP.OnSlotSetTextFocusLost(editBox)
    local text = editBox:GetText()
    local saveButton = editBox:GetParent():GetNamedChild("Save")
    saveButton:SetEnabled(text and text ~= "")
end

-- Iterate through the UI stars to find the championSkilLData for a skillId
-- I guess this info is UI-only, so this is Not IdealTM
local function FindChampionSkillData(skillId)
    for i = 1, ZO_ChampionPerksCanvas:GetNumChildren() do
        local child = ZO_ChampionPerksCanvas:GetChild(i)
        if (child.star and child.star.championSkillData) then
            local id = child.star.championSkillData.championSkillId
            if (id == skillId) then
                return child.star.championSkillData
            end
        end
    end
end

local function LoadSlotSet(tree, name)
    local setData = DynamicCP.savedOptions.slotGroups[tree][name]
    for i = 1, 4 do
        local slot = CHAMPION_PERKS.championBar:GetSlot(TREE_TO_FIRST_INDEX[tree] + i - 1)
        slot:ClearSlot()
        if (setData[i]) then
            slot:AssignChampionSkillToSlot(FindChampionSkillData(setData[i]))
        end
    end
end

-- Initialize the dropdown with the saved slot sets
local function InitSlotSetDropdown(tree, nameToSelect)
    local dropdown = ZO_ComboBox_ObjectFromContainer(DynamicCPPulldown:GetNamedChild(tree .. "SlotSetControlsDropdown"))
    dropdown:ClearItems()
    dropdown:SetSortsItems(true)

    -- Add the data to dropdown
    local entryToSelect
    for setName, setData in pairs(DynamicCP.savedOptions.slotGroups[tree]) do
        local function OnItemSelected(_, _, entry)
            d("load " .. setName)
            LoadSlotSet(tree, setName)
        end

        local entry = ZO_ComboBox:CreateItemEntry(setName, OnItemSelected)
        dropdown:AddItem(entry, ZO_COMBOBOX_SUPRESS_UPDATE)

        if (setName == nameToSelect) then
            entryToSelect = entry
        end
    end

    -- TODO: if pending is cancelled, then need to deselect?
    if (entryToSelect) then
        dropdown:SelectItem(entryToSelect)
    end
    dropdown:UpdateItems()
end

-- Called from pulldown.xml. Save the UI-pending slottables into a slot set
local function SaveSlotSet(button)
    local tree = string.sub(button:GetParent():GetParent():GetName(), 18)
    local pendingName = button:GetParent():GetNamedChild("TextField"):GetText()
    if (not pendingName or pendingName == "") then
        d("|cFF0000Pending name is empty; this shouldn't be reachable!|r")
        return
    end

    local firstIndex = TREE_TO_FIRST_INDEX[tree]
    local currentSlottables = DynamicCP.GetCurrentUISlottables()

    local setData = {}
    local starsString = ""
    for i = 1, 4 do
        local slottableSkillData = currentSlottables[firstIndex + i - 1]
        local starName = ""
        if (slottableSkillData) then
            setData[i] = slottableSkillData.championSkillId
            starName = GetChampionSkillName(slottableSkillData.championSkillId)
        end

        starsString = starsString .. zo_strformat("\n|c<<1>><<2>> - <<C:3>>|r",
            TEXT_COLORS_HEX[tree],
            i,
            starName)
    end

    -- Save in data
    local overwrite = DynamicCP.savedOptions.slotGroups[tree][pendingName]
    local function OnSaveConfirmed()
        DynamicCP.savedOptions.slotGroups[tree][pendingName] = setData
        InitSlotSetDropdown(tree, pendingName)
    end

    LibDialog:RegisterDialog(
        DynamicCP.name,
        "ConfirmSaveSlotSet",
        "Confirm Saving Slottable Set",
        zo_strformat("Save the following as |c<<1>><<2>>|r?<<3>>", TEXT_COLORS_HEX[tree], pendingName, starsString),
        OnSaveConfirmed,
        nil,
        nil,
        true)
    LibDialog:ShowDialog(DynamicCP.name, "ConfirmSaveSlotSet")
end
DynamicCP.SaveSlotSet = SaveSlotSet

---------------------------------------------------------------------
-- Since U43, the ActionBar has deferred initialization, so it's
-- possible the user hasn't opened the CP screen yet before changing
-- CP via addons
DynamicCP.pulldownInitialized = false

---------------------------------------------------------------------
-- Update every item in the pulldown
local function ApplyCurrentSlottables(currentSlottables)
    if (not DynamicCP.pulldownInitialized) then return end

    for index = 1, 12 do
        local slottableSkillData = currentSlottables[index]
        local star = GetStarControlFromIndex(index)

        -- It could be empty
        if (not slottableSkillData) then
            star:GetNamedChild("Name"):SetText("")
            star:GetNamedChild("Points"):SetText("")
        else
            -- Set labels
            local id = slottableSkillData.championSkillId
            star:GetNamedChild("Name"):SetText(zo_strformat("<<C:1>>", GetChampionSkillName(id)))

            -- TODO: show pending points after refactor
            if (DynamicCP.savedOptions.showPulldownPoints) then
                star:GetNamedChild("Points"):SetText(GetNumPointsSpentOnChampionSkill(id))
            else
                star:GetNamedChild("Points"):SetText("")
            end
        end
    end
end
DynamicCP.ApplyCurrentSlottables = ApplyCurrentSlottables


---------------------------------------------------------------------
-- Expand / hide the pulldown
local function TogglePulldown()
    if (DynamicCPPulldown:IsHidden()) then
        -- Expand it
        DynamicCPPulldownTabArrowExpanded:SetHidden(false)
        DynamicCPPulldownTabArrowHidden:SetHidden(true)
        DynamicCPPulldown:SetHidden(false)
        DynamicCPPulldownTab:SetAnchor(TOP, DynamicCPPulldown, BOTTOM)
        DynamicCP.savedOptions.pulldownExpanded = true
    else
        -- Hide it
        DynamicCPPulldownTabArrowExpanded:SetHidden(true)
        DynamicCPPulldownTabArrowHidden:SetHidden(false)
        DynamicCPPulldown:SetHidden(true)
        DynamicCPPulldownTab:SetAnchor(TOP, ZO_ChampionPerksActionBar, BOTTOM)
        DynamicCP.savedOptions.pulldownExpanded = false
    end
end
DynamicCP.TogglePulldown = TogglePulldown


---------------------------------------------------------------------
-- tree = "Green" "Blue" "Red"
local function InitTree(control, tree)
    local width = ZO_ChampionPerksActionBarSlot4:GetRight() - ZO_ChampionPerksActionBarSlot1:GetLeft() + 20

    -- Size and position
    control:SetHeight(40)
    control:SetWidth(width)
    control:SetAnchor(TOP, GuiRoot, TOPLEFT, GetMiddlePoint(tree) / 2, ZO_ChampionPerksActionBar:GetBottom())

    -- Stars
    local color = TEXT_COLORS[tree]
    local starNameLength = width / 2 - 20 - (DynamicCP.savedOptions.showPulldownPoints and 20 or 0)

    local star1 = CreateControlFromVirtual("$(parent)Star1", control, "DynamicCPPulldownStar", "")
    star1:SetAnchor(TOPLEFT, control, TOPLEFT)
    star1.SetColors(color)
    star1:GetNamedChild("Name"):SetWidth(starNameLength)
    local star2 = CreateControlFromVirtual("$(parent)Star2", control, "DynamicCPPulldownStar", "")
    star2:SetAnchor(TOPLEFT, star1, BOTTOMLEFT)
    star2.SetColors(color)
    star2:GetNamedChild("Name"):SetWidth(starNameLength)
    local star3 = CreateControlFromVirtual("$(parent)Star3", control, "DynamicCPPulldownStar", "")
    star3:SetAnchor(LEFT, star1, RIGHT)
    star3.SetColors(color)
    star3:GetNamedChild("Name"):SetWidth(starNameLength)
    local star4 = CreateControlFromVirtual("$(parent)Star4", control, "DynamicCPPulldownStar", "")
    star4:SetAnchor(LEFT, star2, RIGHT)
    star4.SetColors(color)
    star4:GetNamedChild("Name"):SetWidth(starNameLength)

    -- Slot set controls
    local setControls = CreateControlFromVirtual("$(parent)SlotSetControls", control, "DynamicCPPulldownSetControls", "")
    setControls:SetWidth(width - 10)
    setControls:GetNamedChild("Dropdown"):SetWidth(width - 40)
    setControls:GetNamedChild("TextField"):SetWidth(width - 40)

    InitSlotSetDropdown(tree)
end

function DynamicCP.InitPulldown()
    InitTree(DynamicCPPulldownGreen, "Green")
    InitTree(DynamicCPPulldownBlue, "Blue")
    InitTree(DynamicCPPulldownRed, "Red")

    DynamicCP.pulldownInitialized = true
end
