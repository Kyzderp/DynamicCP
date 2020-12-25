DynamicCP = DynamicCP or {}

local CREATE_NEW_STRING = "-- Create New --"

local ROLE_TO_STRING = {
    [LFG_ROLE_DPS] = "Dps",
    [LFG_ROLE_HEAL] = "Healer",
    [LFG_ROLE_TANK] = "Tank",
}

local CLASSES = {
    Dragonknight = true,
    Sorcerer = true,
    Nightblade = true,
    Templar = true,
    Warden = true,
    Necromancer = true,
}

local ROLES = {
    Tank = true,
    Healer = true,
    Dps = true,
}

local TREE_TO_DISCIPLINES = {
    Red = {2, 3, 4},
    Green = {1, 8, 9},
    Blue = {5, 6, 7},
}

---------------------------------------------------------------------
-- TODO: use heuristics to make non-stam/non-mag more grayed out? needs more sorting then
local libDialog = LibDialog

local selected = {
    Red = nil,
    Green = nil,
    Blue = nil,
}

---------------------------------------------------------------------
-- Strip control name down to just Red/Green/Blue
local function GetTreeName(name, prefix, suffix)
    return name:sub(prefix:len() + 1, name:len() - suffix:len())
end


---------------------------------------------------------------------
-- Get current CP because apparently if you set respec mode it yeets everything, yay
local function GetCurrentCP(ignorePending)
    local respec = IsChampionInRespecMode()
    if (ignorePending) then
        respec = false
    end

    local current = {}
    for discipline = 1, 9 do
        current[discipline] = {}
        for skill = 1, 4 do
            current[discipline][skill] = respec and GetNumPendingChampionPoints(discipline, skill) or GetNumPointsSpentOnChampionSkill(discipline, skill)
        end
    end
    return current
end

-- TODO: non-capped CP
---------------------------------------------------------------------
-- Show a message in the area under the options
local function ShowMessage(tree, text)
    local label = DynamicCPContainer:GetNamedChild(tree .. "Messages")
    label:SetHidden(false)
    label:SetText(text)

    -- Need to move it upwards if it's a "delete" which means nothing is selected and it looks empty
    if (DynamicCPContainer:GetNamedChild(tree .. "Options"):IsHidden()) then
        label:SetAnchor(TOP, DynamicCPContainer:GetNamedChild(tree), TOP, 0, 70)
    else
        label:SetAnchor(TOP, DynamicCPContainer:GetNamedChild(tree), TOP, 0, 260)
    end
end

local function HideMessage(tree)
    local label = DynamicCPContainer:GetNamedChild(tree .. "Messages")
    label:SetHidden(true)
end


---------------------------------------------------------------------
-- Find and build string of the diff between two cp sets
local function GenerateDiff(before, after)
    local result = "Changes:"

    for discipline = 1, 9 do
        if (before[discipline] and after[discipline]) then
            for skill = 1, 4 do
                local first = before[discipline][skill] or 0
                local second = after[discipline][skill] or 0
                if (first ~= second and (first ~= 0 or second ~= 0)) then
                    local line = string.format("\n|cBBBBBB%s:  %d → %d",
                        GetAbilityName(GetChampionAbilityId(discipline, skill)),
                        first,
                        second)

                    if (first < second) then
                        line = line .. "|c00FF00↑|r"
                    else
                        line = line .. "|cFF0000↓|r"
                    end
                    result = result .. line
                end
            end
        end
    end

    if (result == "Changes:") then
        result = "|cBBBBBBNo changes.|r"
    end
    return result
end


---------------------------------------------------------------------
-- When apply button is clicked
function DynamicCP:OnApplyClicked(button)
    local tree = GetTreeName(button:GetName(), "DynamicCPContainer", "OptionsApplyButton")
    local presetName = selected[tree]

    if (not presetName) then
        d("You shouldn't be seeing this message! Please leave Kyzer a message saying which buttons you clicked to get here. OnApplyClicked")
        return
    end

    DynamicCP.dbg("Attempting to apply \"" .. presetName .. "\" to the " .. tree .. " tree.")

    local currentCP = GetCurrentCP()

    if (not IsChampionInRespecMode()) then
        SetChampionIsInRespecMode(true)
    end

    local cp = DynamicCP.savedOptions.cp[tree][presetName]
    for discipline = 1, 9 do
        for skill = 1, 4 do
            if (cp[discipline] and cp[discipline][skill]) then
                SetNumPendingChampionPoints(discipline, skill, cp[discipline][skill])
            else
                SetNumPendingChampionPoints(discipline, skill, currentCP[discipline][skill])
            end
        end
    end

    ShowMessage(tree, GenerateDiff(GetCurrentCP(true), cp) .. "\n\n|c00FF00Preset loaded!|cBBBBBB\nPress \"Confirm\" to commit.|r")
end

---------------------------------------------------------------------
-- Perform saving of CP preset
local function SavePreset(tree, oldName, presetName, newCP, message)
    if (oldName ~= CREATE_NEW_STRING) then
        DynamicCP.savedOptions.cp[tree][oldName] = nil
    end

    DynamicCP.savedOptions.cp[tree][presetName] = newCP

    DynamicCP:InitializeDropdown(tree, presetName)
    DynamicCP.dbg("Saved preset " .. presetName)

    message = message or ("|c00FF00Done! Saved preset \"" .. presetName .. "\"|r")
    ShowMessage(tree, message)
    -- TODO: show the saved points
end


---------------------------------------------------------------------
-- When save button is clicked
function DynamicCP:OnSaveClicked(button, tree)
    tree = tree or GetTreeName(button:GetName(), "DynamicCPContainer", "OptionsSaveButton")
    local presetName = selected[tree]
    if (presetName == nil) then
        d("You shouldn't be seeing this message! Please leave Kyzer a message saying which buttons you clicked to get here. OnSaveClicked")
        return
    end

    -- Do a deep copy
    local currentCP = GetCurrentCP()
    local newCP = {}
    for _, discipline in pairs(TREE_TO_DISCIPLINES[tree]) do
        newCP[discipline] = {}
        for k, v in pairs(currentCP[discipline]) do
            newCP[discipline][k] = v
        end
    end

    -- Don't want to deal with formatting, colors are stripped when parsing name from dropdown
    local newName = DynamicCPContainer:GetNamedChild(tree .. "OptionsTextField"):GetText()
    if (newName:find("|")) then
        ShowMessage(tree, "|cFF0000\"||\" is not allowed in preset names.|r")
        return
    end

    -- New and no conflict
    if (presetName == CREATE_NEW_STRING and not DynamicCP.savedOptions.cp[tree][newName]) then
        DynamicCP.dbg("Saving to new preset")
        SavePreset(tree, presetName, newName, newCP)

    -- New but has the same name as existing... OR overwrite existing that has been selected
    elseif (presetName == CREATE_NEW_STRING or presetName == newName) then
        DynamicCP.dbg("Overwriting existing preset")
        local function OverwritePreset()
            SavePreset(tree, presetName, newName, newCP,
                "|c00FF00Done! Overwrote preset \"" .. presetName .. "\"|r")
        end

        libDialog:RegisterDialog(
            DynamicCP.name,
            "OverwriteConfirmation",
            "Overwrite Preset",
            "Overwrite the \"" .. newName .. "\" preset?\n" .. GenerateDiff(DynamicCP.savedOptions.cp[tree][newName], currentCP),
            OverwritePreset,
            nil,
            nil,
            true)
        libDialog:ShowDialog(DynamicCP.name, "OverwriteConfirmation")

    else
        d("You shouldn't be seeing this message! Please leave Kyzer a message saying which buttons you clicked to get here. OnSaveClicked fallthrough")
    end
end


---------------------------------------------------------------------
-- When focus is lost on the text field
function DynamicCP:OnTextFocusLost(textfield)
    DynamicCP.dbg("focus lost")
    tree = tree or GetTreeName(textfield:GetName(), "DynamicCPContainer", "OptionsTextField")
    local presetName = selected[tree]
    if (presetName == nil) then
        d("You shouldn't be seeing this message! Please leave Kyzer a message saying which buttons you clicked to get here. OnTextFocusLost")
        return
    end

    if (presetName == CREATE_NEW_STRING) then
        return
    end

    local newName = DynamicCPContainer:GetNamedChild(tree .. "OptionsTextField"):GetText()

    if (presetName == newName) then
        return
    end

    -- We are renaming an existing preset
    SavePreset(tree, presetName, newName, DynamicCP.savedOptions.cp[tree][presetName],
        "|c00FF00Renamed preset \"" .. presetName .. "\" to \"" .. newName .. "\"|r")
end


---------------------------------------------------------------------
-- When delete button is clicked
function DynamicCP:OnDeleteClicked(button)
    local tree = GetTreeName(button:GetName(), "DynamicCPContainer", "OptionsDeleteButton")
    local presetName = selected[tree]
    if (presetName == nil or presetName == CREATE_NEW_STRING) then
        d("You shouldn't be seeing this message! Please leave Kyzer a message saying which buttons you clicked to get here. OnDeleteClicked")
        return
    end

    function DeletePreset()
        DynamicCP.savedOptions.cp[tree][presetName] = nil
        DynamicCP:InitializeDropdown(tree)
        DynamicCP.dbg("Deleted " .. presetName)
        ShowMessage(tree, "Preset \"" .. presetName .. "\" deleted.")
    end

    libDialog:RegisterDialog(
        DynamicCP.name,
        "DeleteConfirmation",
        "Delete Preset",
        "Delete the \"" .. presetName .. "\" preset?",
        DeletePreset,
        nil,
        nil,
        true)
    libDialog:ShowDialog(DynamicCP.name, "DeleteConfirmation")
end


---------------------------------------------------------------------
-- Hide/unhide the options
local function AdjustDividers()
    local r = not DynamicCPContainer:GetNamedChild("RedOptions"):IsHidden()
    local g = not DynamicCPContainer:GetNamedChild("GreenOptions"):IsHidden()
    local b = not DynamicCPContainer:GetNamedChild("BlueOptions"):IsHidden()

    DynamicCPContainerRedGreenDivider:SetHeight((r or g) and 230 or 60)
    DynamicCPContainerGreenBlueDivider:SetHeight((g or b) and 230 or 60)

    DynamicCPContainerInstructions:SetHidden(r or g or b)
end

local function UnhideOptions(tree)
    DynamicCPContainer:GetNamedChild(tree .. "Options"):SetHidden(false)
    AdjustDividers()
end

local function HideOptions(tree)
    DynamicCPContainer:GetNamedChild(tree .. "Options"):SetHidden(true)
    AdjustDividers()
end


---------------------------------------------------------------------
-- Class/Role buttons

local function DecoratePresetName(presetName, cp)
    local class = GetUnitClass("player")
    local role = ROLE_TO_STRING[GetSelectedLFGRole()]

    if (cp.classes and not cp.classes[class]) then
        return "|c444444" .. presetName .. "|r"
    elseif (cp.roles and not cp.roles[role]) then
        return "|c444444" .. presetName .. "|r"
    else
        return "|c9FBFAF" .. presetName .. "|r"
    end
end

local function SetTextureButtonEnabled(textureButton, enabled)
    textureButton.enabled = enabled
    if (enabled) then
        textureButton:SetColor(0.9, 1, 0.9)
    else
        textureButton:SetColor(0.4, 0.3, 0.3)
    end
end

function DynamicCP:ToggleOptionButton(textureButton)
    local tree = GetTreeName(textureButton:GetName(), "DynamicCPContainer", "OptionsButtons" .. (textureButton.class or textureButton.role))

    if (selected[tree] == CREATE_NEW_STRING) then
        d("You shouldn't be seeing this message! Please leave Kyzer a message saying which buttons you clicked to get here. ToggleOptionButton")
        return
    end

    SetTextureButtonEnabled(textureButton, not textureButton.enabled)
    local presetName = selected[tree]

    -- Immediately save to the preset when buttons are toggled
    if (textureButton.class) then
        if (not DynamicCP.savedOptions.cp[tree][presetName].classes) then
            DynamicCP.savedOptions.cp[tree][presetName].classes = {
                Dragonknight = true,
                Sorcerer = true,
                Nightblade = true,
                Templar = true,
                Warden = true,
                Necromancer = true,
            }
        end
        DynamicCP.savedOptions.cp[tree][presetName].classes[textureButton.class] = textureButton.enabled
    elseif (textureButton.role) then
        if (not DynamicCP.savedOptions.cp[tree][presetName].roles) then
            DynamicCP.savedOptions.cp[tree][presetName].roles = {
                Tank = true,
                Healer = true,
                Dps = true, 
            }
        end
        DynamicCP.savedOptions.cp[tree][presetName].roles[textureButton.role] = textureButton.enabled
    end

    -- Update the dropdown to reflect matching or not matching
    local dropdown = ZO_ComboBox_ObjectFromContainer(DynamicCPContainer:GetNamedChild(tree .. "Dropdown"))
    local itemData = dropdown:GetSelectedItemData()
    itemData.name = DecoratePresetName(presetName, DynamicCP.savedOptions.cp[tree][presetName])
    dropdown:UpdateItems()
    dropdown:SelectItem(itemData)

    ZO_ComboBox_ObjectFromContainer(DynamicCPContainerRedDropdown)
end

---------------------------------------------------------------------
-- Populate the dropdown with presets
function DynamicCP:InitializeDropdown(tree, desiredEntryName)
    if (tree ~= "Red" and tree ~= "Green" and tree ~= "Blue") then
        DynamicCP.dbg("You're using this wrong >:[")
        return
    end

    local function OnPresetSelected(_, _, entry)
        local presetName = entry.name:gsub("|[cC]%x%x%x%x%x%x", ""):gsub("|r", "")

        selected[tree] = presetName
        UnhideOptions(tree)

        if (presetName == CREATE_NEW_STRING) then
            local newIndex = 1
            while (DynamicCP.savedOptions.cp[tree]["Preset " .. newIndex] ~= nil) do
                newIndex = newIndex + 1
            end
            DynamicCPContainer:GetNamedChild(tree .. "OptionsTextField"):SetText("Preset " .. newIndex)
            DynamicCPContainer:GetNamedChild(tree .. "OptionsApplyButton"):SetHidden(true)
            DynamicCPContainer:GetNamedChild(tree .. "OptionsDeleteButton"):SetHidden(true)
            DynamicCPContainer:GetNamedChild(tree .. "OptionsSaveButton"):SetWidth(190)
            DynamicCPContainer:GetNamedChild(tree .. "OptionsButtons"):SetHidden(true)
        else
            DynamicCPContainer:GetNamedChild(tree .. "OptionsTextField"):SetText(presetName)
            DynamicCPContainer:GetNamedChild(tree .. "OptionsApplyButton"):SetHidden(false)
            DynamicCPContainer:GetNamedChild(tree .. "OptionsDeleteButton"):SetHidden(false)
            DynamicCPContainer:GetNamedChild(tree .. "OptionsSaveButton"):SetWidth(95)
            DynamicCPContainer:GetNamedChild(tree .. "OptionsButtons"):SetHidden(false)
        end


        local data = DynamicCP.savedOptions.cp[tree][presetName] or {}

        local buttons = DynamicCPContainer:GetNamedChild(tree .. "OptionsButtons")
        for class, _ in pairs(CLASSES) do
            SetTextureButtonEnabled(buttons:GetNamedChild(class), data.classes == nil or data.classes[class] == nil or data.classes[class]) -- Both nil or true
        end
        for role, _ in pairs(ROLES) do
            SetTextureButtonEnabled(buttons:GetNamedChild(role), data.roles == nil or data.roles[role] == nil or data.roles[role]) -- Both nil or true
        end

        if (presetName == CREATE_NEW_STRING) then
            -- TODO: show the cp that is about to be saved
            ShowMessage(tree, "|cBBBBBBRename and click \"Save\" to create a new preset.|r")
        else
            ShowMessage(tree, GenerateDiff(GetCurrentCP(true), data) .. "\n\n|cBBBBBBClick \"Apply\" to load this preset.|r")
        end
    end

    -- Add entries to dropdown
    local data = DynamicCP.savedOptions.cp[tree]
    local dropdown = ZO_ComboBox_ObjectFromContainer(DynamicCPContainer:GetNamedChild(tree .. "Dropdown"))
    local desiredEntry = nil
    dropdown:ClearItems()
    for presetName, cp in pairs(data) do
        local name = DecoratePresetName(presetName, cp)
        local entry = ZO_ComboBox:CreateItemEntry(name, OnPresetSelected)
        dropdown:AddItem(entry, ZO_COMBOBOX_SUPRESS_UPDATE)

        if (presetName == desiredEntryName) then
            desiredEntry = entry
        end
    end
    local entry = ZO_ComboBox:CreateItemEntry("|cEBDB34" .. CREATE_NEW_STRING .. "|r", OnPresetSelected)
    dropdown:AddItem(entry, ZO_COMBOBOX_SUPRESS_UPDATE)
    dropdown:UpdateItems()

    if (desiredEntry) then
        dropdown:SelectItem(desiredEntry)
        OnPresetSelected(nil, nil, desiredEntry)
    else
        selected[tree] = nil
        HideOptions(tree)
    end
end


---------------------------------------------------------------------
-- Entry point
function DynamicCP:InitializeDropdowns()
    DynamicCP:InitializeDropdown("Red")
    DynamicCP:InitializeDropdown("Green")
    DynamicCP:InitializeDropdown("Blue")
end