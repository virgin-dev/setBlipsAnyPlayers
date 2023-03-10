function SetBlipsAnyPlayers()
    local players = Base:GetNearestPlayers(1000000000)

    for i, k in ipairs(players) do
    end
    local playerPed = GetPlayerPed(player)
    local blip = AddBlipForEntity(playerPed)
    SetBlipColour(blip, 2)
    SetBlipScale(blip, 0.85)
    SetBlipAsShortRange(blip, false)

     Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1000)
      if DoesBlipExist(blip) then
        SetBlipCoords(blip, GetEntityCoords(playerPed))
      else
        break
      end
    end
  end)
end