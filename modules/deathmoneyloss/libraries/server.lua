﻿
function MODULE:PlayerDeath(ply)
    local char = ply:getChar()
    local money = char:getMoney()
    if money > 0 then
        local take = math.floor(money * self.DeathTake)
        char:takeMoney(take)
        ply:setNetVar("previousDeathTake", take)
    end
end

