DynamicCP = DynamicCP or {}

---------------------------------------------------------------------
--[[ Both of these should be of the format:
{
    [disciplineIndex] = {
        [skillIndex] = points,
    },
    [3] = {
        [28] = 50,
    },
}
]]
local committedCP = nil
local pendingCP = nil

---------------------------------------------------------------------
-- Keep track of committed CP
---------------------------------------------------------------------
-- Get current non-pending CP
local function GetCommittedCP()
    -- Cached to avoid more calls
    if (committedCP ~= nil) then
        return committedCP
    end

    local current = {}
    for disciplineIndex = 1, GetNumChampionDisciplines() do
        current[disciplineIndex] = {}
        for skill = 1, GetNumChampionDisciplineSkills(disciplineIndex) do
            local id = GetChampionSkillId(disciplineIndex, skill)
            current[disciplineIndex][skill] = GetNumPointsSpentOnChampionSkill(id)
        end
    end
    committedCP = current
    return current
end
DynamicCP.GetCommittedCP = GetCommittedCP

---------------------------------------------------------------------
-- Invalidate cache
local function ClearCommittedCP()
    committedCP = nil
end
DynamicCP.ClearCommittedCP = ClearCommittedCP


---------------------------------------------------------------------
-- Keep track of pending CP
---------------------------------------------------------------------
-- Remove any pending points that are the same as the committed
local function CleanUpPending()
    -- TODO
end

local function SetStarPoints(disciplineIndex, skillIndex, points)
    if (not pendingCP) then
        pendingCP = {}
    end
    if (not pendingCP[disciplineIndex]) then
        pendingCP[disciplineIndex] = {}
    end
    pendingCP[disciplineIndex][skillIndex] = points
end

local function ClearPendingCP()
    pendingCP = nil
end

---------------------------------------------------------------------
-- Init
function DynamicCP.InitPoints()
end
