DynamicCP = DynamicCP or {}

---------------------------------------------------------------------
local SLOTTABLE_COOLDOWN = 30000
local lastChange = 0

local isOnCooldown = false
local listeners = {} -- {{startFunc = func, updateFunc = func, endFunc = func},}

---------------------------------------------------------------------
function IsOnCooldown()
    return isOnCooldown
end
DynamicCP.IsOnCooldown = IsOnCooldown

local function GetCooldownSeconds()
    return (SLOTTABLE_COOLDOWN - GetGameTimeMilliseconds() + lastChange) / 1000
end
DynamicCP.GetCooldownSeconds = GetCooldownSeconds

---------------------------------------------------------------------
local function ProcessListeners(event)
    for _, functions in pairs(listeners) do
        local func = functions[event]
        if (func) then
            func()
        end
    end
end

function DynamicCP.RegisterCooldownListener(name, startFunc, updateFunc, endFunc)
    listeners[name] = {startFunc = startFunc, updateFunc = updateFunc, endFunc = endFunc}
end

---------------------------------------------------------------------
-- On purchase, set the cooldown
function DynamicCP.OnCooldownStarted(result)
    if (result ~= CHAMPION_PURCHASE_SUCCESS) then return end
    isOnCooldown = true
    lastChange = GetGameTimeMilliseconds()
    ProcessListeners("startFunc")

    -- Update the cooldown label
    EVENT_MANAGER:RegisterForUpdate(DynamicCP.name .. "Cooldown", 1000, function()
        local secondsRemaining = GetCooldownSeconds()
        if (secondsRemaining <= 0) then
            EVENT_MANAGER:UnregisterForUpdate(DynamicCP.name .. "Cooldown")
            ProcessListeners("endFunc")
            isOnCooldown = false
        else
            ProcessListeners("updateFunc")
        end
    end)
end
