local root = getRootElement();

function doServerInteractions(door)
    local lookAtVehicle = getPedTarget(source);
    local player = source;
    
    if (lookAtVehicle) and (getElementType(lookAtVehicle) == "vehicle" ) then
        local doorRatio = getVehicleDoorOpenRatio(lookAtVehicle, door);
        local doorStateS = getElementData(lookAtVehicle, tostring(door), true);
        if(doorStateS=="open") then
            setElementData(lookAtVehicle, door, "closed", true);
        else
            setElementData(lookAtVehicle, door, "open", true);
        end
        interactWith(player, lookAtVehicle, door);
        setPedAnimation(source, "Ped", "CAR_open_LHS", 300, false, false, true, false);     
    end
end
addEvent("onInteractVehicleDoor", true)
addEventHandler("onInteractVehicleDoor", root, doServerInteractions)

local canInterActWith = "true";

function interactWith(source, vehicle, door)
    local player = source;
    doorRatio = getVehicleDoorOpenRatio(vehicle, door);
    doorState = getElementData(vehicle, door);
    if (doorRatio <= 0) then
        doorState = "closed";
    elseif (doorRatio >= 1) then
        doorState = "open";
    end
    if (canInterActWith == "true") then 
        if (doorState == "closed") then
            setTimer(function()
                canInterActWith = "false";
                
                if (doorRatio <= 1) then
                    doorRatio = doorRatio + 0.1;
                    if (doorRatio >= 1) then
                        doorRatio = 1;
                        setElementData(vehicle, door, "open", true);
                        canInterActWith = "true";
                        triggerOpenEvents(player, door);
                        killTimers(50);
                    end
                end
                setElementData(vehicle, door, "closed", true);
                setVehicleDoorOpenRatio(vehicle, door, doorRatio);        
            end, 50, 11);
            
        elseif (doorState == "open") then
            setTimer ( function()
                canInterActWith = "false";
                
                if (doorRatio > 0) then
                    doorRatio = doorRatio - 0.1;
                    if (doorRatio <= 0) then
                        doorRatio = 0;
                        setElementData(vehicle, door, "closed", true);
                        canInterActWith = "true";
                        triggerCloseEvents(player, door);
                        killTimers(50);
                    end                
                end
                setElementData(vehicle, door, "open", true);
                setVehicleDoorOpenRatio(vehicle, door, doorRatio);
            end, 50, 11);
        end
    end   
end

function triggerOpenEvents(source, door)
    if (source) and (door) then   
        local x, y, z = getElementPosition(source)
        if door then
            
            triggerClientEvent(root, "onDoorOpened", root, x, y, z);
        end
        --[[
        if (door == 0) then
            triggerClientEvent(source, "onHoodOpened", root);
        elseif (door == 1) then
            triggerClientEvent(source, "onTrunkOpened", root);
        elseif (door == 2) then
            triggerClientEvent(source, "onLeftFrontDoorOpened", root);
        elseif (door == 3) then
            triggerClientEvent(source, "onRightFrontDoorOpened", root);
        elseif (door == 4) then
            triggerClientEvent(source, "onLeftRearDoorOpened", root);
        elseif (door == 5) then
            triggerClientEvent(source, "onRightRearDoorOpened", root);  
        end
        ]]--
    end
end

function triggerCloseEvents(source, door)
    if (source) and (door) then
        local x, y, z = getElementPosition(source)
        
        if door then
            triggerClientEvent(root, "onDoorClosed", root, x, y, z);
        end
        --[[
        if (door == 0) then
            triggerClientEvent(source, "onHoodClosed", root);
        elseif (door == 1) then
            triggerClientEvent(source, "onTrunkClosed", root);
        elseif (door == 2) then
            triggerClientEvent(source, "onLeftFrontDoorClosed", root);
        elseif (door == 3) then
            triggerClientEvent(source, "onRightFrontDoorClosed", root);
        elseif (door == 4) then
            triggerClientEvent(source, "onLeftRearDoorClosed", root);
        elseif (door == 5) then
            triggerClientEvent(source, "onRightRearDoorClosed", root);        
        end
        ]]--
    end
end

function killTimers(time)
    local timers = getTimers(time);

    for i, v in ipairs(timers) do
        killTimer(v);
    end
end