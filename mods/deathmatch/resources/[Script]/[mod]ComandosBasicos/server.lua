addEvent("desligarMotor",true) 
addEventHandler("desligarMotor",root,function(player,car)
    if getPlayerOccupiedVehicleSeat(player) == 0 then
        setVehicleEngineState(car,not getVehicleEngineState(car))
    end
end)
addEvent("desligarFarol",true) 
addEventHandler("desligarFarol",root,function(player,car)
    if getPlayerOccupiedVehicleSeat(player) == 0 then
        if getVehicleOverrideLights(car) == 2 then
            setVehicleOverrideLights(car,1)
        else
            setVehicleOverrideLights(car,2)
        end
    end
end)

function changeSeat(theVehicle,seat)
    warpPedIntoVehicle(source,theVehicle,seat)
end                          
addEvent ("changeSeat", true)
addEventHandler ("changeSeat", root, changeSeat)