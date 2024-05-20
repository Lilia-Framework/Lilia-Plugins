﻿lia.command.add("subtractcharslots", {
    privilege = "Characters - Subtract CharSlots",
    superAdminOnly = true,
    syntax = "<string player>",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        if not target then return end
        SubtractOverrideCharSlots(target)
    end
})

lia.command.add("addcharslots", {
    privilege = "Characters - Add CharSlots",
    superAdminOnly = true,
    syntax = "<string player>",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        if not target then return end
        AddOverrideCharSlots(target)
    end
})

lia.command.add("setcharslots", {
    privilege = "Characters - Set CharSlots",
    superAdminOnly = true,
    syntax = "<string player> <string count>",
    onRun = function(client, arguments)
        local target = lia.command.findPlayer(client, arguments[1])
        local count = arguments[2]
        if not (target or count) then return end
        OverrideCharSlots(target, count)
    end
})
