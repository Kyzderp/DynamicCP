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
    DynamicCP.dbg("confirm")
    if (not currentCallback) then
        DynamicCP.dbg("SHOULD NOT SEE THIS")
        return
    end

    currentCallback()
    DynamicCPModelessDialog:SetHidden(true)
end

function DynamicCP.OnModelessCancel()
    DynamicCP.dbg("cancel")
    DynamicCPModelessDialog:SetHidden(true)
end

---------------------------------------------------------------------
-- API
function DynamicCP.ShowModelessPrompt(text, callback)
    DynamicCPModelessDialogLabel:SetText(text)
    currentCallback = callback
end


---------------------------------------------------------------------
-- Init
function DynamicCP.InitModelessDialog()
    DynamicCPModelessDialog:SetAnchor(CENTER, GuiRoot, CENTER, DynamicCP.savedOptions.modelessX, DynamicCP.savedOptions.modelessY)
end
