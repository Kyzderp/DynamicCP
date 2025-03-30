DynamicCP = DynamicCP or {}

---------------------------------------------------------------------
-- UI
---------------------------------------------------------------------
local numEntries = 0
local shownTree

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

local function HideMenu()
    EVENT_MANAGER:UnregisterForEvent(DynamicCP.name .. "QSMouseUpHide", EVENT_GLOBAL_MOUSE_UP)
    DynamicCPQuickstarsContextMenu:SetHidden(true)
end
DynamicCP.HideSlotGroupMenu = HideMenu

local function ShowMenu(tree)
    shownTree = tree

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

    -- Add a mouse listener to close menu when "losing focus"
    EVENT_MANAGER:UnregisterForEvent(DynamicCP.name .. "QSMouseUpHide", EVENT_GLOBAL_MOUSE_UP)
    zo_callLater(function()
        EVENT_MANAGER:RegisterForEvent(DynamicCP.name .. "QSMouseUpHide", EVENT_GLOBAL_MOUSE_UP, function()
            if (not DynamicCPQuickstarsContextMenu:IsHidden() and not MouseIsOver(DynamicCPQuickstarsContextMenu)) then
                HideMenu()
            end
        end)
    end, 250)
end
DynamicCP.ShowSlotGroupMenu = ShowMenu
-- /script DynamicCP.ShowSlotGroupMenu("Red")

local function ToggleMenu(tree)
    if (not DynamicCPQuickstarsContextMenu:IsHidden() and tree == shownTree) then
        HideMenu()
    else
        ShowMenu(tree)
    end
end
DynamicCP.ToggleSlotGroupMenu = ToggleMenu

---------------------------------------------------------------------
-- On entry clicked in menu
---------------------------------------------------------------------
local function OnQuickstarSlotGroupClicked(text)
    d(text)
    HideMenu()

    local data = DynamicCP.savedOptions.slotGroups[shownTree][text]
    if (not data) then
        d("|cFF0000DOES NOT EXIST?|r")
        return
    end

    -- Slot each slottable
    for i = 1, 4 do
        local skillId = data[i]
        if (skillId and skillId ~= 0) then
            DynamicCP.SelectQuickstar(shownTree, i, skillId)
        else
            DynamicCP.SelectQuickstar(shownTree, i, -1)
        end
    end
end
DynamicCP.OnQuickstarSlotGroupClicked = OnQuickstarSlotGroupClicked
