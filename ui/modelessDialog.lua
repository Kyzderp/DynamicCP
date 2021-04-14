DynamicCP = DynamicCP or {}

local currentCallback = nil

---------------------------------------------------------------------
-- Window
---------------------------------------------------------------------
-- On move stop
function DynamicCP.SaveModelessDialogPosition()
    local x, y = DynamicCPModelessDialog:GetCenter()
    local cX, cY = GuiRoot:GetCenter()
    DynamicCP.savedOptions.modelessX = x - cX
    DynamicCP.savedOptions.modelessY = y - cY
end

function DynamicCP.OnModelessConfirm()
    if (not currentCallback) then
        DynamicCP.dbg("SHOULD NOT SEE THIS")
        return
    end

    currentCallback()
    DynamicCPModelessDialog:SetHidden(true)
end

function DynamicCP.OnModelessCancel()
    DynamicCPModelessDialog:SetHidden(true)
end

---------------------------------------------------------------------
-- API
function DynamicCP.ShowModelessPrompt(text, callback)
    DynamicCPModelessDialogLabel:SetHeight(800)
    DynamicCPModelessDialogLabel:SetText(text)
    local labelHeight = DynamicCPModelessDialogLabel:GetTextHeight()
    DynamicCPModelessDialogLabel:SetHeight(labelHeight)
    DynamicCPModelessDialog:SetHeight(labelHeight + 70)
    DynamicCPModelessDialog:SetHidden(false)
    currentCallback = callback
end


---------------------------------------------------------------------
-- Init
function DynamicCP.InitModelessDialog()
    DynamicCPModelessDialog:SetAnchor(CENTER, GuiRoot, CENTER, DynamicCP.savedOptions.modelessX, DynamicCP.savedOptions.modelessY)
end
