---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function getOverrideChars(client)
    if client:getNetVar("overrideSlots", nil) then
        return client:getNetVar("overrideSlots")
    else
        return lia.config.MaxCharacters
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function getRankChars(client)
    local rank = client:GetUserGroup()
    if lia.config.OverrideCharLimit[rank] then return lia.config.OverrideCharLimit[rank] end
    return lia.config.MaxCharacters
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:getOOCDelay(client)
    if client:isVIP() then return lia.config.VIPOOCDelay end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function MODULE:GetMaxPlayerCharacter(client)
    return math.max(lia.config.MaxCharacters, getOverrideChars(client), getRankChars(client)) + client:GetAdditionalCharSlots()
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------