﻿local MODULE = MODULE
netstream.Hook("liaItemSpawn", function(client, itemID)
    if not client.itemSpawnCooldown then client.itemSpawnCooldown = 0 end
    if CurTime() > client.itemSpawnCooldown and client:HasPrivilege("Staff Permissions - Can Spawn Menu Items", nil) then
        client.itemSpawnCooldown = CurTime() + MODULE.cooldown
        lia.item.spawn(itemID, client:GetShootPos())
    end
end)
