﻿function MODULE:PlayerLoadedChar(client, char)
    local usergroup = client:GetUserGroup()
    local group = self.DonatorGroups[usergroup]
    if group then char:giveFlags(group) end
end

function MODULE:PlayerSpawn(client)
    local maxCharDonation = lia.data.get("charslotsteamids", {}, nil, true)
    if maxCharDonation[client:SteamID()] then
        MsgC(Color(0, 255, 0), "Player " .. client:Nick() .. " previously donated and has " .. maxCharDonation[client:SteamID()] .. " slots\n")
        client:setNetVar("overrideSlots", maxCharDonation[client:SteamID()])
    end
end

function AddOverrideCharSlots(client)
    for _, v in pairs(player.GetAll()) do
        if client and v == client then
            local contents = lia.data.get("charslotsteamids", {}, nil, true)
            if contents[v:SteamID()] then
                contents[v:SteamID()] = contents[v:SteamID()] + 1
            else
                contents[v:SteamID()] = lia.config.MaxCharacters + 1
            end

            lia.data.set("charslotsteamids", contents, nil, true)
            v:setNetVar("overrideSlots", contents[v:SteamID()])
        end
    end
end

function SubtractOverrideCharSlots(client)
    for _, v in pairs(player.GetAll()) do
        if client and v == client then
            local contents = lia.data.get("charslotsteamids", {}, nil, true)
            if contents[v:SteamID()] then
                contents[v:SteamID()] = contents[v:SteamID()] - 1
            else
                contents[v:SteamID()] = lia.config.MaxCharacters
            end

            lia.data.set("charslotsteamids", contents, nil, true)
            v:setNetVar("overrideSlots", contents[v:SteamID()])
        end
    end
end

function OverrideCharSlots(client, value)
    for _, v in pairs(player.GetAll()) do
        if client and v == client then
            local contents = lia.data.get("charslotsteamids", {}, nil, true)
            if contents[v:SteamID()] then
                contents[v:SteamID()] = value
            else
                contents[v:SteamID()] = value
            end

            lia.data.set("charslotsteamids", contents, nil, true)
            v:setNetVar("overrideSlots", contents[v:SteamID()])
        end
    end
end