local config = require 'config.shared'

local function sendVisualLog(source, action, reason, author)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local data = { id = source, action = action, coords = coords, reason = reason, author = author }
    local nearbyPlayers = lib.getNearbyPlayers(coords, config.drawDistance + 20.0)
    for i = 1, #nearbyPlayers do
        local player = nearbyPlayers[i]
        TriggerClientEvent('mnr_anticl:client:VisualLog', player.id, data)
    end
end

AddEventHandler('txAdmin:events:playerKicked', function(eventData)
    if not eventData.target then return end

    sendVisualLog(eventData.target, 'player_kicked', eventData.reason or 'Kicked by Admin', eventData.author or 'System')
end)

AddEventHandler('txAdmin:events:playerBanned', function(eventData)
    if not eventData.targetNetId then return end

    sendVisualLog(eventData.targetNetId, 'player_banned', eventData.reason or 'Banned by Admin', eventData.author or 'System')
end)

AddEventHandler('playerDropped', function(reason)
    local src = source

    if string.match(reason:lower(), '^%[txadmin%]') then
        return
    end

    sendVisualLog(src, 'player_logout', reason)
end)