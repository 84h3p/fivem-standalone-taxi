local customerCoord = vector4(-1160.63, -961.09, 3.05, 0)
local destinationCoord = vector4(-760.5, -900, 19.73, 91)
local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), customerCoord, false)


-- Taxi command
RegisterCommand('taxi', function(source, args)
    RemoveBlip(customerBlip)
    RemoveBlip(destinationBlip)
    -- Creates customer ped
    RequestModel( GetHashKey( "s_m_m_bouncer_01" ) )
    while ( not HasModelLoaded( GetHashKey( "s_m_m_bouncer_01" ) ) ) do
    Citizen.Wait( 1 )
    end
    local customer = CreatePed(4, 0x9fd4292d, customerCoord, true, true)

    local customerNetID = PedToNet(customer)
    print(customerNetID, 'customer')
    
    local customerBlip = AddBlipForCoord(customerCoord)

    while GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), customerCoord, false) >= 4 do
        Citizen.Wait(0) 
    end

    local taxiVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    Citizen.Wait(1000) -- Задержка 500 миллисекунд
    print(taxiVehicle, 'vehicle')
    TaskWarpPedIntoVehicle(customer, taxiVehicle, 0)
    RemoveBlip(customerBlip)

    local destinationBlip = AddBlipForCoord(destinationCoord)    

    while GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), destinationCoord, false) >= 4 do
        Citizen.Wait(0) 
    end

    TaskLeaveVehicle(customer, taxiVehicle, 0)
    RemoveBlip(destinationBlip)
    local  customer = SetEntityAsNoLongerNeeded()
end, false)


-- get coord function
RegisterCommand('getcoord', function(source, args)
    TriggerEvent('chat:addMessage', {
        args = {'x: ', Floor((GetEntityCoords(GetPlayerPed(-1), true).x)*100)/100,}
    })
    TriggerEvent('chat:addMessage', {
        args = {'y: ', Floor((GetEntityCoords(GetPlayerPed(-1), true).y)*100)/100,}
    })
    TriggerEvent('chat:addMessage', {
        args = {'z: ', Floor((GetEntityCoords(GetPlayerPed(-1), true).z)*100)/100,}
    })
    TriggerEvent('chat:addMessage', {
        args = {'h: ', Floor(GetEntityHeading(PlayerPedId()))}
    })
end, false)