local blips = {}

function CreatePlayerBlip(playerId, playerName)
    local playerPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)
    local blip = AddBlipForCoord(playerCoords.x, playerCoords.y, playerCoords.z)

    SetBlipSprite(blip, 1)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 63)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(playerName)
    EndTextCommandSetBlipName(blip)

    table.insert(blips, blip)
end

function RemovePlayerBlip(playerId)
    for i, blip in ipairs(blips) do
        local blipCoords = GetBlipCoords(blip)
        local playerPed = GetPlayerPed(playerId)
        local playerCoords = GetEntityCoords(playerPed)

        if blipCoords.x == playerCoords.x and blipCoords.y == playerCoords.y and blipCoords.z == playerCoords.z then
            RemoveBlip(blip)
            table.remove(blips, i)
            break
        end
    end
end

function UpdatePlayerBlips()
    for _, playerId in ipairs(GetPlayers()) do
        local playerName = GetPlayerName(playerId)
        local playerPed = GetPlayerPed(playerId)
        local playerCoords = GetEntityCoords(playerPed)

        if DoesEntityExist(playerPed) and IsEntityVisible(playerPed) then
            local blipExists = false

            for i, blip in ipairs(blips) do
                local blipCoords = GetBlipCoords(blip)

                if blipCoords.x == playerCoords.x and blipCoords.y == playerCoords.y and blipCoords.z == playerCoords.z then
                    blipExists = true
                    break
                end
            end

            if not blipExists then
                CreatePlayerBlip(playerId, playerName)
            end
        else
            RemovePlayerBlip(playerId)
        end
    end
end

function Admin:Blips()
  Citizen.CreateThread(function()
      while true do
          Citizen.Wait(1000)
          UpdatePlayerBlips()
      end
  end)
end