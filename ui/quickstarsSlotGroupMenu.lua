DynamicCP = DynamicCP or {}

---------------------------------------------------------------------
-- UI
---------------------------------------------------------------------
local numEntries = 0

local function GetOrCreateMenuButton(index)
    local button = DynamicCPQuickstarsContextMenu:GetNamedChild("Entry" .. tostring(index))
    if (not button) then
        button = WINDOW_MANAGER:CreateControlFromVirtual("$(parent)Entry" .. tostring(index), DynamicCPQuickstarsContextMenu, "DynamicCPQuickstarsMenuEntry")
        if (index == 1) then
            button:SetAnchor(TOPLEFT, DynamicCPQuickstarsContextMenu, TOPLEFT, 4, 4)
        else
            button:SetAnchor(TOPLEFT, DynamicCPQuickstarsContextMenu:GetNamedChild("Entry" .. tostring(index - 1)), BOTTOMLEFT, 0, 4)
        end
        button:SetDrawTier(DT_HIGH)
        -- button:GetLabelControl():SetDrawLayer()
    end
    if (index > numEntries) then
        numEntries = index
    end

    button:SetHidden(false)
    return button
end

local function ShowMenu(tree)
    -- Sort keys because ugh
    local keys = {}
    for groupName, _ in pairs(DynamicCP.savedOptions.slotGroups[tree]) do
        table.insert(keys, groupName)
    end
    table.sort(keys)

    -- Create a button for each
    for i, key in ipairs(keys) do
        local button = GetOrCreateMenuButton(i)
        button:SetText(key)
    end

    -- Hide unused entries
    for i = #keys + 1, numEntries do
        DynamicCPQuickstarsContextMenu:GetNamedChild("Entry" .. tostring(i)):SetHidden(true)
    end

    -- Adjust backdrop
    DynamicCPQuickstarsContextMenu:SetHeight(#keys * 20 + 8)
    DynamicCPQuickstarsContextMenu:SetAnchor(TOPLEFT, DynamicCPQuickstars:GetNamedChild(tree .. "Button"), TOPRIGHT)
    DynamicCPQuickstarsContextMenu:SetHidden(false)
end
DynamicCP.ShowSlotGroupMenu = ShowMenu
-- /script DynamicCP.ShowSlotGroupMenu("Red")

---------------------------------------------------------------------
-- On entry clicked in menu
---------------------------------------------------------------------
local function OnQuickstarSlotGroupClicked(text)
    d(text)
    DynamicCPQuickstarsContextMenu:SetHidden(true)
end
DynamicCP.OnQuickstarSlotGroupClicked = OnQuickstarSlotGroupClicked
