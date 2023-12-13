local speedometerEnabled = false

RegisterCommand('speedometer', function()
    speedometerEnabled = not speedometerEnabled
    SendNUIMessage({
        type = 'toggle',
        status = speedometerEnabled
    })
end, false)

sleep = 2000
CreateThread(function()
    while true do
        Wait(sleep)
        local speed = GetEntitySpeed(cache.vehicle) * 3.6 -- For kilometers ()
        if IsPedInAnyVehicle(cache.ped, false) and GetIsVehicleEngineRunning(cache.vehicle) then
            sleep = 50
            SendNUIMessage({
                type = 'updateSpeed',
                speed = math.floor(speed)
            })
            SendNUIMessage({
                type = 'updateFuel',
                fuel = math.floor(GetVehicleFuelLevel(cache.vehicle))
            })
            SendNUIMessage({
                type = 'showhud',
                show = true
            })
            DisplayRadar(true)
        else
            sleep = 2000
            DisplayRadar(false)
            SendNUIMessage({
                type = 'showhud',
                show = false
            })
        end
    end
end)
