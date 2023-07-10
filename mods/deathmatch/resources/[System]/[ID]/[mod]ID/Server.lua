
function Start_Id ( _, acc )
	if eventName == "onPlayerLogin" then
		setElementData ( source, "ID", getAccountID(acc) or "N/A" )
	elseif eventName == "onPlayerLogout" then
		removeElementData( source, "ID" )
	elseif eventName == "onResourceStart" then
		for _, player in pairs(getElementsByType("player")) do
			local acc = getPlayerAccount(player)
			if not isGuestAccount(acc) then
				setElementData( source, "ID", getAccountID(acc) or "N/A" )
			end
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, Start_Id)
addEventHandler("onPlayerLogout", root, Start_Id)
addEventHandler("onPlayerLogin", root, Start_Id)

function getPlayerID(id)
	v = false
	for i, player in ipairs (getElementsByType("player")) do
		if getElementData(player, "ID") == id then
			v = player
			break
		end
	end
	return v
end
--============================================================================================================================--
                                   --=============================--
                                   ----------- ID PLAYER ------------
                                   --=============================--
function getnick(player, command, id, ...)
    if(id) then
        local playerID = tonumber(id)
		if(playerID) then
			local Player2 = getPlayerID(playerID)
			if(Player2) then	
				outputChatBox ( "#838B83➲ #ff0000INFO #ff0000 ➲ #ff0000 Nome do Jogador #ff0000" .. getPlayerName(Player2) .."", player, 255,255,255,true)
			else
				outputChatBox ( "#838B83➲ #ff0000ERRO #ff0000 ➲ #ff0000 O Jogador(a) de ID: #ff0000( " .. id .. " ) #ff0000Não Foi Encontrado!", player, 255,255,255,true)
			end 
		else
			outputChatBox ( "#838B83➲ #ff0000ERRO #ff0000 ➲ #ff0000 ID: #ff0000( " .. id .. " ) #ff0000Inválido!", player, 255,255,255,true)
		end
	else
		outputChatBox ( "#838B83➲ #ff0000 Use /id #ff0000[#ffffffID#00ff00]", player, 255,255,255,true)
	end
end
addCommandHandler("id", getnick)