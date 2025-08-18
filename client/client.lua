local config = require 'config.shared'

local function visualLog(data)
    local visible, x, y = GetScreenCoordFromWorldCoord(data.coords.x, data.coords.y, data.coords.z)

    if not visible then
        return
    end

    SetTextScale(0.40, 0.40)
    SetTextFont(0)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(data.message)
    EndTextCommandDisplayText(x, y)
end

RegisterNetEvent('mnr_anticl:client:VisualLog', function(data)
    if GetInvokingResource() then return end

    local show = true
    SetTimeout(config.drawTime, function()
        show = false
    end)

    local draw = { coords = data.coords, message = locale(data.action, data.id, data.reason, data.author)}

    CreateThread(function()
        while show do
            Wait(0)
            local playerCoords = GetEntityCoords(cache.ped)
            if #(data.coords - playerCoords) < config.drawDistance then
                visualLog(draw)
            end
        end
    end)
end)