DynamicCP = DynamicCP or {}

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
-- When user switches tab, we should update backdrops and dropdowns

-- Set backdrops to reflect which tab is selected
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

-- Reinitialize dropdowns for the particular tree
local function UpdateDropdowns(tree)
    local offsets = {
        Green = 0,
        Blue = 4,
        Red = 8,
    }

    local offset = offsets[tree]
    local committed = GetFlippedSlottables()
    for i = 1, 4 do
        local dropdown = ZO_ComboBox_ObjectFromContainer(DynamicCPQuickstarsList:GetNamedChild("Star" .. tostring(i)))
        dropdown:ClearItems()

        local currentSkillId = committed[offset + i]
        local name = zo_strformat("<<C:1>>", GetChampionSkillName(currentSkillId))

        local function OnItemSelected(_, _, entry)
            DynamicCP.dbg("Selected " .. tostring(entry))
        end
        local entry = ZO_ComboBox:CreateItemEntry(name, OnItemSelected)
        dropdown:AddItem(entry, ZO_COMBOBOX_SUPRESS_UPDATE)
        dropdown:UpdateItems()
        dropdown:SelectItem(entry)
    end
end

-- Called when user clicks tab button
function DynamicCP.SelectTab(tree)
    DynamicCP.dbg("clicked " .. tree)
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
function DynamicCP.SaveQuickstarsPosition()
    DynamicCP.savedOptions.quickstarsX = DynamicCPQuickstars:GetLeft()
    DynamicCP.savedOptions.quickstarsY = DynamicCPQuickstars:GetTop()
end


---------------------------------------------------------------------
-- Init
function DynamicCP.InitQuickstars()
    DynamicCPQuickstars:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, DynamicCP.savedOptions.quickstarsX, DynamicCP.savedOptions.quickstarsY)
    -- TODO: show setting

    DynamicCP.SelectTab("Green")
end
