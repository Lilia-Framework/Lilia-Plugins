﻿local MODULE = MODULE
MODULE.entities = MODULE.entities or {}
function MODULE:PhysgunPickup(_, entity)
    if entity:getNetVar("persistent", false) then return false end
end

function MODULE:SaveData()
    local data = {}
    for _, v in ipairs(self.entities) do
        if IsValid(v) then
            local entData = {}
            entData.class = v:GetClass()
            entData.pos = v:GetPos()
            entData.angles = v:GetAngles()
            entData.model = v:GetModel()
            entData.skin = v:GetSkin()
            entData.color = v:GetColor()
            entData.material = v:GetMaterial()
            entData.bodygroups = v:GetBodyGroups()
            local physicsObject = v:GetPhysicsObject()
            if IsValid(physicsObject) then entData.moveable = physicsObject:IsMoveable() end
            data[#data + 1] = entData
        end
    end

    self:setData(data)
end

function MODULE:LoadData()
    for _, v in pairs(self:getData() or {}) do
        local ent = ents.Create(v.class)
        ent:SetPos(v.pos)
        ent:SetAngles(v.angles)
        ent:SetModel(v.model)
        ent:SetSkin(v.skin)
        ent:SetColor(v.color)
        ent:SetMaterial(v.material)
        ent:Spawn()
        ent:Activate()
        for _, data in pairs(v.bodygroups) do
            ent:SetBodygroup(data.id, data.num)
        end

        local physicsObject = ent:GetPhysicsObject()
        if IsValid(physicsObject) then physicsObject:EnableMotion(ent.moveable or false) end
        ent:setNetVar("persistent", true)
        self.entities[#self.entities + 1] = ent
    end
end

properties.Add("persist", {
    MenuLabel = "#makepersistent",
    Order = 400,
    MenuIcon = "icon16/link.png",
    Filter = function(_, ent, client)
        if ent:IsPlayer() then return false end
        if MODULE.blacklist[ent:GetClass()] then return false end
        if not gamemode.Call("CanProperty", client, "persist", ent) then return false end
        return not ent:getNetVar("persistent", false)
    end,
    Action = function(self, ent)
        self:MsgStart()
        net.WriteEntity(ent)
        self:MsgEnd()
    end,
    Receive = function(self, _, client)
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end
        if not self:Filter(ent, client) then return end
        ent:setNetVar("persistent", true)
        MODULE.entities[#MODULE.entities + 1] = ent
        lia.log.add(client, "persistedEntity", ent)
    end
})

properties.Add("persist_end", {
    MenuLabel = "#stoppersisting",
    Order = 400,
    MenuIcon = "icon16/link_break.png",
    Filter = function(_, ent, client)
        if ent:IsPlayer() then return false end
        if not gamemode.Call("CanProperty", client, "persist", ent) then return false end
        return ent:getNetVar("persistent", false)
    end,
    Action = function(self, ent)
        self:MsgStart()
        net.WriteEntity(ent)
        self:MsgEnd()
    end,
    Receive = function(self, _, client)
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end
        if not properties.CanBeTargeted(ent, client) then return end
        if not self:Filter(ent, client) then return end
        ent:setNetVar("persistent", false)
        for k, v in ipairs(MODULE.entities) do
            if v == entity then
                MODULE.entities[k] = nil
                break
            end
        end

        lia.log.add(client, "unpersistedEntity", ent)
    end
})
