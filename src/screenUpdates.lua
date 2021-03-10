DynamicCP = DynamicCP or {}

local rectThrottling = false
local lastThrottle = 0

---------------------------------------------------------------------
-- Refresh/reset star labels to the default
function DynamicCP.RefreshLabels(show)
    DynamicCP.dbg("Refreshing labels")
    for i = 1, ZO_ChampionPerksCanvas:GetNumChildren() do
        local child = ZO_ChampionPerksCanvas:GetChild(i)
        if (child.star and child.star.championSkillData) then
            local id = child.star.championSkillData.championSkillId
            local n = child:GetNamedChild("Name")
            if (not n) then
                n = WINDOW_MANAGER:CreateControl("$(parent)Name", child, CT_LABEL)
                n:SetInheritScale(false)
                n:SetAnchor(CENTER, child, CENTER, 0, -40)
            end

            local slottable = CanChampionSkillTypeBeSlotted(GetChampionSkillType(id))
            if (slottable) then
                n:SetFont("ZoFontWinH4")
                n:SetColor(1, 1, 1)
            else
                n:SetFont("ZoFontWinH2")
                n:SetColor(1, 1, 0.5)
            end
            n:SetText(zo_strformat("<<C:1>>", GetChampionSkillName(id)))

            n:SetHidden(not show)
        elseif (child.star and child.star.championClusterData) then
            local text = ""
            for _, clusterChild in ipairs(child.star.championClusterData.clusterChildren) do
                text = text .. clusterChild:GetFormattedName() .. "\n"
            end
            local n = child:GetNamedChild("Name")
            if (not n) then
                n = WINDOW_MANAGER:CreateControl("$(parent)Name", child, CT_LABEL)
                n:SetInheritScale(false)
                n:SetAnchor(CENTER, child, CENTER, 0, -40)
                n:SetFont("ZoFontGameSmall")
            end
            n:SetColor(1, 0.7, 1)
            n:SetText(text)
            n:SetHidden(not show)
        end
    end
end


---------------------------------------------------------------------
-- Dock the window
local function DockWindow(activeConstellation)
    local ox, oy = DynamicCPContainer:GetCenter()
    local tx, ty = DynamicCPContainer:GetCenter()
    
    if (activeConstellation == "All" or activeConstellation == "Green" or activeConstellation == "Cluster") then
        tx = GuiRoot:GetWidth() - DynamicCPContainer:GetWidth() / 2 - 10
        ty = DynamicCPContainer:GetHeight() / 2 + 10
        -- DynamicCPContainer:SetAnchor(TOPRIGHT, ZO_ChampionPerksCanvas, TOPRIGHT, -10, 10)
    elseif (activeConstellation == "Blue") then
        tx = GuiRoot:GetWidth() - DynamicCPContainer:GetWidth() / 2 - 10
        ty = GuiRoot:GetHeight() * 0.35
        -- DynamicCPContainer:SetAnchor(RIGHT, ZO_ChampionPerksCanvas, RIGHT, -10, -GuiRoot:GetHeight() * 0.15)
    elseif (activeConstellation == "Red") then
        tx = GuiRoot:GetWidth() * 0.6875
        ty = GuiRoot:GetHeight() * 0.27
        -- DynamicCPContainer:SetAnchor(CENTER, ZO_ChampionPerksCanvas, CENTER, GuiRoot:GetWidth() * 0.1875, -GuiRoot:GetHeight() * 0.23)
    end

    -- Play animation
    local dx = tx - ox
    local dy = ty - oy
    DynamicCPContainer.slide:SetDeltaOffsetX(dx)
    DynamicCPContainer.slide:SetDeltaOffsetY(dy)
    DynamicCPContainer.slideAnimation:PlayFromStart()
end


---------------------------------------------------------------------
-- utils
local function IsInBounds(control)
    local x, y = control:GetCenter()
    -- DynamicCP.dbg(control:GetName() .. " " .. tostring(x) .. " " .. tostring(y))
    return x >= 0 and x <= GuiRoot:GetWidth() and y >= 0 and y <= GuiRoot:GetHeight()
end

---------------------------------------------------------------------
-- idk if this is the right way to do it...
-- When the animations have settled, check positions of the canvases to see which is active
local function OnCanvasAnimationStopped()
    if (ZO_ChampionPerksCanvas:IsHidden()) then
        -- TODO: need to do anything?
        DynamicCP.dbg("EXIT")
        return
    end

    local greenBounds = IsInBounds(ZO_ChampionPerksCanvasConstellation1) or IsInBounds(ZO_ChampionPerksCanvasConstellation4)
    local blueBounds = IsInBounds(ZO_ChampionPerksCanvasConstellation2) or IsInBounds(ZO_ChampionPerksCanvasConstellation5)
    local redBounds = IsInBounds(ZO_ChampionPerksCanvasConstellation3) or IsInBounds(ZO_ChampionPerksCanvasConstellation6)

    local activeConstellation = nil
    if (greenBounds and blueBounds and redBounds) then
        activeConstellation = "All"
    elseif (greenBounds) then
        activeConstellation = "Green"
    elseif (blueBounds) then
        activeConstellation = "Blue"
    elseif (redBounds) then
        activeConstellation = "Red"
    else
        -- TODO: clusters
        activeConstellation = "Cluster"
        DynamicCP.RefreshLabels(DynamicCP.savedOptions.showLabels)
    end

    DynamicCP.dbg(activeConstellation)
    if (DynamicCP.savedOptions.dockWithSpace) then
        DockWindow(activeConstellation)
    end
end

---------------------------------------------------------------------
-- Some first-time actions
function DynamicCP.InitLabels()
    -- some throttling to not spam operations on every animation tick
    ZO_ChampionPerksCanvasConstellation1:SetHandler("OnRectChanged", function(control, newLeft, newTop, newRight, newBottom, oldLeft, oldTop, oldRight, oldBottom)
        local currTime = GetGameTimeMilliseconds()
        if (not rectThrottling) then
            -- DynamicCP.dbg("start")
            rectThrottling = true
        elseif (currTime - lastThrottle > 150) then
            -- DynamicCP.dbg("reregister")
            lastThrottle = currTime
        else
            return
        end

        EVENT_MANAGER:UnregisterForUpdate(DynamicCP.name .. "RectThrottle")
        EVENT_MANAGER:RegisterForUpdate(DynamicCP.name .. "RectThrottle", 200, function()
            rectThrottling = false
            EVENT_MANAGER:UnregisterForUpdate(DynamicCP.name .. "RectThrottle")

            -- Position has finished changing
            OnCanvasAnimationStopped()
        end)
    end)

    -- Create sliding animation
    DynamicCPContainer.slideAnimation = GetAnimationManager():CreateTimelineFromVirtual("ZO_LootSlideInAnimation", DynamicCPContainer)
    DynamicCPContainer.slide = DynamicCPContainer.slideAnimation:GetFirstAnimation()
    -- TODO: do i need an OnStop?
end
