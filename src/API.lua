local DCP = DynamicCP

-- "tree"
DCP.RED = "Red"
DCP.GREEN = "Green"
DCP.BLUE = "Blue"
local OFFSETS = { -- For slotIndex
    [DCP.GREEN] = 0,
    [DCP.BLUE] = 4,
    [DCP.RED] = 8,
}

local function IsTreeValid(tree)
    if (not OFFSETS[tree]) then return false end
    return true
end


---------------------------------------------------------------------
local pendingSets = {} -- {[uniqueName] = {Red = "Red1", Green = "Green2"}}


---------------------------------------------------------------------
-- Gets all slottable sets for a tree
-- @param tree - "Red" "Green" "Blue" or you can use DynamicCP.RED DynamicCP.GREEN DynamicCP.BLUE
-- @return a table of format {[slotSetId] = {name = "Slot Set Name", [1] = 12, [2] = 34, [3] = 56, [4] = 78}} where the numbers are champion skill IDs
function DCP.GetSlottableSets(tree)
    if (not IsTreeValid(tree)) then
        DCP.msg("Invalid tree: " .. tree)
        return
    end

    return ZO_DeepTableCopy(DCP.savedOptions.slotGroups[tree])
end


---------------------------------------------------------------------
-- Queues a slottable set to be committed
-- @param uniqueName - a unique name, e.g. your addon name. This avoids multiple addons trying to slot CP at once
-- @param tree - "Red" "Green" "Blue" or you can use DynamicCP.RED DynamicCP.GREEN DynamicCP.BLUE
-- @param slotSetId - the ID of the slot set to equip, i.e. the key from DynamicCP.GetSlottableSets(tree)
function DCP.QueueSlottableSet(uniqueName, tree, slotSetId)
    if (not IsTreeValid(tree)) then
        DCP.msg("Invalid tree: " .. tree)
        return
    end

    if (not pendingSets[uniqueName]) then
        pendingSets[uniqueName] = {}
    end
    pendingSets[uniqueName][tree] = slotSetId
end


---------------------------------------------------------------------
-- Clears the slottable set queue for your addon. Should be used when cancelling a respec
-- @param uniqueName - a unique name, e.g. your addon name
function DCP.ClearSlottableSetQueue(uniqueName)
    pendingSets[uniqueName] = nil
end


---------------------------------------------------------------------
-- Sends a champion purchase request with all the slottable sets you have previously queued
-- @param uniqueName - a unique name, e.g. your addon name
function DCP.CommitSlottableSets(uniqueName)
    local sets = pendingSets[uniqueName]
    if (ZO_IsTableEmpty(sets)) then
        DCP.dbg("No pending slottable sets for " .. uniqueName)
        return
    end

    PrepareChampionPurchaseRequest(false)

    -- TODO: will it complain if there are no changes?
    for tree, slotSetId in pairs(sets) do
        if (slotSetId ~= -1) then
            local slotSet = DCP.savedOptions.slotGroups[tree][slotSetId]
            if (slotSet) then
                for i = 1, 4 do
                    local skillId = slotSet[i]
                    if (skillId) then
                        AddHotbarSlotToChampionPurchaseRequest(OFFSETS[tree] + i, skillId)
                    end
                end
            else
                DCP.msg(string.format("|cFF0000Unable to apply slottable set %s in %s tree; was it deleted?", slotSetId, tree))
            end
        end
    end

    SendChampionPurchaseRequest()
    PlaySound(SOUNDS.CHAMPION_POINTS_COMMITTED)
end
