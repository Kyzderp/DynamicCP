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

    local committed = GetFlippedSlottables()
    for i = 1, 4 do
        local dropdown = ZO_ComboBox_ObjectFromContainer(DynamicCPQuickstarsList:GetNamedChild("Star" .. tostring(i)))
        local name = zo_strformat("<<C:1>>", GetChampionSkillName(committed[i]))


        local function OnItemSelected(_, _, entry)
            DynamicCP.dbg("Selected " .. tostring(entry))
        end
        local entry = ZO_ComboBox:CreateItemEntry(name, OnItemSelected)
        dropdown:AddItem(entry, ZO_COMBOBOX_SUPRESS_UPDATE)
        dropdown:UpdateItems()
        dropdown:SelectItem(entry)
    end
end
