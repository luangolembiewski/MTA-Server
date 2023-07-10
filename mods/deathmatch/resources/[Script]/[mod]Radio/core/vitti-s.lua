function message(player, mensagem, estilo)
    if player and isElement(player) then
        if mensagem and type(mensagem) == "string" then
            if estilo and type(estilo) == "string" then
                export.Scripts_dxMessages:outputDx(player, mensagem, estilo);
            end
        end
    end
end
addEvent("VC:CallSearch", true)
addEventHandler("VC:CallSearch", getRootElement(), function(player, music)
    if #music ~= 0 then
        fetchRemote("https://server1.mtabrasil.com.br/youtube/search?q="..string.gsub(music, " ", "+"), function(response)
            if (response ~= "ERROR") then
                local fakeTable = fromJSON(response)

                for key = 1, #fakeTable.items do
                    if fakeTable.items[key] and fakeTable.items[key].type ~= 'video' then
                        table.remove (fakeTable.items, key)
                    end
                end

                triggerClientEvent(player, "VC:GetSearch", player, fakeTable)
            else
                message(player, "Erro ao procurar música.", "error")
            end
        end)
    else
        message(player, "Você precisa procurar a música que deseja por seu nome!", "error")
    end
end)

addEvent("VC:CallMusic", true)
addEventHandler("VC:CallMusic", getRootElement(), function(player, music)
    if isPedInVehicle(player) then
        local url = "https://server1.mtabrasil.com.br/youtube/play?id="..music["id"]
        playMusic(player, url)
    end
end) 

--/ Radio veh \--

g_VehicleList = {}

local radioStreams = 0

addEventHandler("onResourceStart", resourceRoot, function()	
    for i,veh in ipairs(getElementsByType("vehicle")) do
        g_VehicleList[veh] = { }
        g_VehicleList[veh].radio = false
        g_VehicleList[veh].radioStation = defaultRadio
        g_VehicleList[veh].volume = 1.0
    end
end)

addEventHandler("onPlayerJoin", root, function()		
    for i,veh in ipairs(getElementsByType("vehicle")) do
        if g_VehicleList[veh] ~= nil then
            if g_VehicleList[veh].radio == true then
                triggerClientEvent(source, "onServerToggleRadio", root, true, g_VehicleList[veh].radioStation, veh, g_VehicleList[veh].volume)
            end
        end
    end
end)

addEventHandler("onVehicleExplode", root, function()
    if g_VehicleList[source] ~= nil then
        if g_VehicleList[source].radio == true then
            triggerClientEvent("onServerToggleRadio", root, false, nil, source)
            g_VehicleList[source].radio = false
            destroyElement(g_VehicleList[source].radioMarker)
            if radioStreams ~= 0 then
                radioStreams = radioStreams - 1
            end
        end
    end
end)

addEventHandler("onElementDestroy", root, function()
    if g_VehicleList[source] ~= nil then
        if g_VehicleList[source].radio == true then
            triggerClientEvent("onServerToggleRadio", root, false, nil, source)
            g_VehicleList[source].radio = false
            destroyElement(g_VehicleList[source].radioMarker)
            if radioStreams ~= 0 then
                radioStreams = radioStreams - 1
            end
        end
    end
end)

addEvent("onPlayerToggleRadio", true)
addEventHandler("onPlayerToggleRadio", root, function()
    if source and getElementType(source) == "player" then
        toggleRadio(source)
    end
end)

function toggleRadio(player)
	local veh = getPedOccupiedVehicle(player)
	if veh then
		local occupants = getVehicleOccupants(veh)
		local seats = getVehicleMaxPassengers(veh)
		
		local playerSeat = getPedOccupiedVehicleSeat(player)
		if g_VehicleList[veh] == nil then
			g_VehicleList[veh] = { }
			g_VehicleList[veh].radio = false
			g_VehicleList[veh].radioStation = defaultRadio
			g_VehicleList[veh].volume = 1.0
		end
		
		if g_VehicleList[veh].radio == false then

			local settingToggleAntifloodTick = 2000
			
			if g_VehicleList[veh].lastTick and (getTickCount() - g_VehicleList[veh].lastTick) <= settingToggleAntifloodTick then return end
			
			local x, y, z = getElementPosition(veh)
			g_VehicleList[veh].radio = true
			g_VehicleList[veh].lastTick = getTickCount()
			g_VehicleList[veh].turnedOnBy = getPlayerName(player)
			g_VehicleList[veh].radioMarker = createMarker(x, y, z, "corona", 0.05, 0, 0, 0, 0)
			attachElements(g_VehicleList[veh].radioMarker, veh)
			
			radioStreams = radioStreams + 1

			for seat = 0, seats do
				local occupant = occupants[seat]
				if occupant and getElementType(occupant) == "player" then
					triggerClientEvent("onServerToggleRadio", root, true, g_VehicleList[veh].radioStation, veh, g_VehicleList[veh].volume)
				end
			end
		else		
			g_VehicleList[veh].radio = false
			destroyElement(g_VehicleList[veh].radioMarker)
			
			radioStreams = radioStreams - 1
			
			for seat = 0, seats do
				local occupant = occupants[seat]
				if occupant and getElementType(occupant) == "player" then
					triggerClientEvent("onServerToggleRadio", root, false, nil, veh, g_VehicleList[veh].volume)
				end
			end
		end
	end
end

addEvent("onPlayerRadioVolumeChange", true)
addEventHandler("onPlayerRadioVolumeChange", root, function(volume)
    local veh = getPedOccupiedVehicle(source)
    if veh then
        local playerSeat = getPedOccupiedVehicleSeat(source)
        if playerSeat == 0 or playerSeat == 1 then
            g_VehicleList[veh].volume = volume
            triggerClientEvent("onServerVolumeChangeAccept", root, veh, g_VehicleList[veh].volume)
        end
    end
end)

function playMusic(player, url)

	local veh = getPedOccupiedVehicle(source)
	if veh then
		local occupants = getVehicleOccupants(veh)
		local seats = getVehicleMaxPassengers(veh)
		
		if g_VehicleList[veh] == nil then
			local x, y, z = getElementPosition(veh)
			g_VehicleList[veh] = { }
			g_VehicleList[veh].radio = true
			g_VehicleList[veh].lastTick = getTickCount()
			g_VehicleList[veh].radioStation = defaultRadio
			g_VehicleList[veh].volume = 1.0
			g_VehicleList[veh].radioMarker = createMarker(x, y, z, "corona", 0.1, 0, 0, 0, 0)
			attachElements(g_VehicleList[veh].radioMarker, veh)
		end

		local playerSeat = getPedOccupiedVehicleSeat(source)
		
		for seat = 0, seats do
			local occupant = occupants[seat]
			if occupant and getElementType(occupant) == "player" then
				g_VehicleList[veh].radioStation = url
				g_VehicleList[veh].changedBy = getPlayerName(source)
				
				--if g_VehicleList[veh].radio == true then
					triggerClientEvent("onServerRadioURLChange", root, g_VehicleList[veh].radioStation, veh, g_VehicleList[veh].volume)
                    toggleRadio(player)
				--end

			end
		end
	end
end
