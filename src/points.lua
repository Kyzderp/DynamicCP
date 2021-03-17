DynamicCP = DynamicCP or {}

local nonPendingCP = nil

---------------------------------------------------------------------
-- Get current CP
local function GetCurrentCP()
    -- Cached to avoid more calls
    if (nonPendingCP ~= nil) then
        return nonPendingCP
    end

    local current = {}
    for disciplineIndex = 1, GetNumChampionDisciplines() do
        current[disciplineIndex] = {}
        for skill = 1, GetNumChampionDisciplineSkills(disciplineIndex) do
            local id = GetChampionSkillId(disciplineIndex, skill)
            current[disciplineIndex][skill] = GetNumPointsSpentOnChampionSkill(id)
        end
    end
    nonPendingCP = current
    return current
end
DynamicCP.GetCurrentCP = GetCurrentCP


---------------------------------------------------------------------
-- Invalidate cache
local function ClearCurrentCP()
    nonPendingCP = nil
end
DynamicCP.ClearCurrentCP = ClearCurrentCP


---------------------------------------------------------------------
-- Init
function DynamicCP.InitPoints()
end
