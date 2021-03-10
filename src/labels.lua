DynamicCP = DynamicCP or {}

local labelsInitialized = false

---------------------------------------------------------------------
-- Initialize star labels
function DynamicCP.ShowLabel()
    if (labelsInitialized) then return end
    labelsInitialized = true

    for i = 1, ZO_ChampionPerksCanvas:GetNumChildren() do
        local child = ZO_ChampionPerksCanvas:GetChild(i)
        if (child.star and child.star.championSkillData) then
            local id = child.star.championSkillData.championSkillId
            local n = WINDOW_MANAGER:CreateControl("$(parent)Name", child, CT_LABEL)
            n:SetInheritScale(false)
            n:SetAnchor(CENTER, child, CENTER, 0, -40)
            n:SetText(zo_strformat("<<C:1>>", GetChampionSkillName(id)))
            local slottable = CanChampionSkillTypeBeSlotted(GetChampionSkillType(id))
            if (slottable) then
                n:SetFont("ZoFontWinH4")
                n:SetColor(1, 1, 1)
            else
                n:SetFont("ZoFontWinH2")
                n:SetColor(1, 1, 0.5)
            end
        elseif (child.star and child.star.championClusterData) then
            -- TODOFLAMES: add labels for inside. how to register callback?
            local text = ""
            for _, clusterChild in ipairs(child.star.championClusterData.clusterChildren) do
                text = text .. clusterChild:GetFormattedName() .. "\n"
            end
            local n = WINDOW_MANAGER:CreateControl("$(parent)Name", child, CT_LABEL)
            n:SetInheritScale(false)
            n:SetAnchor(CENTER, child, CENTER, 0, -40)
            n:SetText(text)
            n:SetFont("ZoFontGameSmall")
            n:SetColor(1, 0.7, 1)
        end
    end
end