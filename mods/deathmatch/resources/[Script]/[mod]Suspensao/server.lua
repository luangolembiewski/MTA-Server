addEventHandler("onPlayerVehicleEnter", root, function(veh, seat)
	if seat == 0 then
		local data = getElementData(source, "airVehicle")
		local state = true
		for i,v in ipairs(getElementsByType("player")) do
			if getElementData(v, "airVehicle") == veh then
				state = false
			end
		end
		if state then
			if data then
				removeElementData(source, "airVehicle")
			end
			setElementData(source, "airVehicle", veh)
		end
	end
end)

addEvent("s:air", true)
addEventHandler("s:air", root, function(type, int)
	local vehicle = getElementData(source, "airVehicle")
    if isElement(vehicle) then
		if int then
			if type == "baixar" then 
				local suspensao = (getVehicleHandling(vehicle)['suspensionLowerLimit'])
				if limitsuspension == "true" then
					if suspensao == math.abs(suspensao) then
					else
						setVehicleHandling(vehicle, "suspensionLowerLimit", suspensao + int)
					end
				else
					setVehicleHandling(vehicle, "suspensionLowerLimit", suspensao + int)
				end
				return
			end
			if type == "subir" then
				local altura_original = (getVehicleHandling(vehicle)["suspensionUpperLimit"]*-2)
				local suspensao = (getVehicleHandling(vehicle)['suspensionLowerLimit'])
				if limitsuspension == "true" then
					if (suspensao < altura_original - 0.2) then
					else
						setVehicleHandling(vehicle, "suspensionLowerLimit", suspensao + int)
					end
				else
					setVehicleHandling(vehicle, "suspensionLowerLimit", suspensao + int)
				end
				return
			end
			local new = (getVehicleHandling(vehicle)[type])+int
			if type == "suspensionFrontRearBias" and not (new >= 0.15 and new <= 0.8) then return end
			if type == "suspensionLowerLimit" and new < -0.5 then return end
			setVehicleHandling(vehicle, type, new)
			
		else
			local x, y, z = unpack(getVehicleHandling(vehicle)[type[1]])
			local newX = tonumber(x+type[2])
			local newY = tonumber(y+type[2])
			if newX >= -0.8 and newX <= 0.8 then
				setVehicleHandling(vehicle, type[1], {newX, y, z}) 
			end
		end
		if not getVehicleController(vehicle) then
			local x, y, z = getElementPosition(vehicle)
			setElementPosition(vehicle, x, y, z+0.0001) 
		end
	end
end)

addEvent("s:rootSoundAir", true)
addEventHandler("s:rootSoundAir", root, function(file)
	local vehicle = getElementData(source, "airVehicle")
    if isElement(vehicle) then
		triggerClientEvent(root, "c:playSoundAir", root, file, source)
	end
end)

function outputChatBox(text, player, r, g, b, bool)
	triggerClientEvent(player, "c:contextBar", player, RGBToHex(r, g, b)..text)
end