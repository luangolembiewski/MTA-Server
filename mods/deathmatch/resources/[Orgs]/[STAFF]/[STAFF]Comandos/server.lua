local fly = false
local invisible = false
local holdingVeh = false
local chat = false
local godmode = false
veiculos={
  
  [1] = {nome="Ferrari",id=415},
  [2] = {nome="R34",id=549},
  --[[ [1] = {nome="Mobilete",id=448},
  [2] = {nome="Tron",id=521},
  [3] = {nome="Rocam",id=468},
  [4] = {nome="Z1000",id=461},
  [5] = {nome="Xj6",id=581},
  --Carros
  [7] = {nome="R35",id=494},
  [8] = {nome="Gol",id=496},
  [9] = {nome="R8",id=411},
  [10] = {nome="Amg",id=426},
  [11] = {nome="Kuruma",id=445},
  [13] = {nome="Supra",id=429},
  [14] = {nome="Hellcat",id=402},
  [15] = {nome="Fttrail",id=546},
  [16] = {nome="Ftduster",id=596},
  [17] = {nome="Fusca",id=545},
  [18] = {nome="Chevette",id=491}, ]]
}
  
function obterData()
  local time = getRealTime()
  local hours = time.hour
  local minutes = time.minute
  local seconds = time.second

  local monthday = time.monthday
  local month = time.month
  local year = time.year

  local formattedTime = string.format("%02d/%02d/%02d - %02d:%02d:%02d", monthday, month + 1, year + 1900, hours, minutes, seconds)
  return formattedTime
end

function confirmAcl(player,boll)
  triggerClientEvent(player,"staff:confirmAcl", player, boll)
end
addEvent("aclVerificar",true)
addEventHandler("aclVerificar",root,function(player,group)
  local acl = aclGetGroup(group)
  if acl then
    if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(player)), acl) then 
      confirmAcl(player,true)
    else
      confirmAcl(player,false)
    end
  else
    confirmAcl(player,false)
  end
end)

function msg(root,tipo,mensagem)
    local LinkWeebhooks="https://discord.com/api/webhooks/1071080004286431274/nw8SuOpfijbVNPugbphue57hpfwoxVrjNVVsgIbCYmM0m4rks3rwvigMhKdelkjrlAkM"
    local players = getElementsByType ("player")
    local ID = getAccountID(getPlayerAccount(root))
    Jogador = getPlayerName ( root )
    local dados = {
        embeds = {
            { -- embed 1
            title = tipo,
            color = 14177041,
            description = message,
            fields = {
                {
                    name = mensagem,
                    value = "Informações: "..obterData(),
                },
            },
            thumbnail = {
                --url = "https://cdn.discordapp.com/attachments/793528437444313109/805829405590290472/Sem_titulo_8_1080p-1.gif",
            },
        },
    }
    }
    webhook = LinkWeebhooks
    dados = toJSON(dados)
    dados = dados:sub(2, -2)
    local opt = {
        connectionAttempts = 5,
        connectTimeout = 7000,
        headers = {
            ["Content-Type"] = "application/json"
        },
        postData = dados
    }
    fetchRemote ( webhook, opt, function() 
    end )
end 

function getPlayerID(id)
  v = false
  for i, player in ipairs (getElementsByType("player")) do
    if getElementData(player, Apolo_Config.Geral["Id"]) == id then
      v = player
      break
    end
  end
  return v
end

-- 0 Argumento

addCommandHandler("queda", function(thePlayer, commandName)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup ("Staff")) then
    triggerClientEvent(thePlayer,"eventQueda",thePlayer)
  end
end)

local x = true
addCommandHandler("din", function(thePlayer, commandName)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup ("Staff")) then
    local veh=getPedOccupiedVehicle(thePlayer)
    setVehicleFrozen(veh,x)
    function teste()
      print(getvehicle)
    end
    if(x)then
      addEventHandler("onPlayerRender",thePlayer,teste)
    else
      removeEventHandler("onPlayerRender",thePlayer,teste)
    end
    x= not x
  end
end)

addCommandHandler(Apolo_Config.Comandos["Dv"], function(thePlayer, commandName)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup (Apolo_Config.Acls["AclDv"])) then
    local x,y,z = getElementPosition(thePlayer)
    --local col = createColSphere(x,y,z, 100)
    local car = getElementsWithinRange(x,y,z, 5, "vehicle")
    for i,v in ipairs(car) do
			if v and isElement(v) then
				destroyElement(v)
			end
		end
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

addCommandHandler(Apolo_Config.Comandos["Staff"], function(thePlayer, commandName)
  local aclPlayer = "user." ..getAccountName(getPlayerAccount(thePlayer))
  if isObjectInACLGroup (aclPlayer , aclGetGroup (Apolo_Config.Acls["Staff"])) then
    aclGroupAddObject(aclGetGroup("Staff_off"),aclPlayer)
    aclGroupRemoveObject(aclGetGroup("Staff"),aclPlayer)
    outputMessage(thePlayer,"Modo STAFF desativado","success")
    msg(thePlayer,"STAFF",">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Desativou o modo Staff")
  else if isObjectInACLGroup ( aclPlayer, aclGetGroup ("Staff_off")) then 
    aclGroupAddObject(aclGetGroup("Staff"),aclPlayer)
    aclGroupRemoveObject(aclGetGroup("Staff_off"),aclPlayer)
    outputMessage(thePlayer,"Modo STAFF ativado","success")
    msg(thePlayer,"STAFF",">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Ativou o modo Staff")
  end
  end
end)

addCommandHandler("godmode", function(thePlayer, commandName)
  if isObjectInACLGroup ("user." ..getAccountName(getPlayerAccount(thePlayer)) , aclGetGroup (Apolo_Config.Acls["Staff"])) then
    if(godmode == false) then
      triggerClientEvent(thePlayer,"Egodmode",thePlayer,not godmode)
      outputMessage(thePlayer,"GodMode ativado!","success")
      msg(thePlayer,"GODMODE",">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Ativou o Godmode")
      godmode = not godmode
    else
      triggerClientEvent(thePlayer,"Egodmode",thePlayer,not godmode)
      outputMessage(thePlayer,"GodMode desativado!","success")
      msg(thePlayer,"GODMODE",">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Desativou o Godmode")
      godmode = not godmode
    end
  else 
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

addCommandHandler(Apolo_Config.Comandos["Nc"], function(thePlayer, commandName)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup (Apolo_Config.Acls["AclNc"])) then
    if invisible then
      setElementAlpha(thePlayer, 255)
      invisible = false
    else
      setElementAlpha(thePlayer, 0)

      invisible = true
    end
    if fly then
      triggerClientEvent(thePlayer, "onClientFlyToggle", thePlayer)
      outputMessage(thePlayer, Apolo_Config.Mensagens["MsgDesativouNC"], "success")
      fly = false
    else
      triggerClientEvent(thePlayer, "onClientFlyToggle", thePlayer)
      outputMessage(thePlayer, Apolo_Config.Mensagens["MsgAtivouNC"], "success")
      fly = true
    end
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

addCommandHandler(Apolo_Config.Comandos["Invisivel"], function(thePlayer, commandName)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup (Apolo_Config.Acls["AclNc"])) then
    if invisible then
      setElementAlpha(thePlayer, 255)
      invisible = false
      outputMessage(thePlayer, Apolo_Config.Mensagens["MsgAtivouInv"], "success")
    else
      setElementAlpha(thePlayer, 0)
      invisible = true
      outputMessage(thePlayer, Apolo_Config.Mensagens["MsgDesativouInv"], "success")
    end
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

--1 Argumento
addCommandHandler("setcar",function(thePlayer, cmd, id)
  if isObjectInACLGroup("user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup("Staff")) then
    local playerID = tonumber(id)
    local targetPlayer = getPlayerID(playerID)
    if exports["[script]Concessionaria"]:set_vehicle(targetPlayer) then
      local veh = getPlayerOccupiedVehicle(targetPlayer)
      local vehId = getVehicleModelFromName(veh)
      outputMessage(thePlayer, getPlayerName(targetPlayer).." recebeu um veículo", "success")
      msg(thePlayer,"GARAGEM",">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Setou um veículo ao player: "..getPlayerName(targetPlayer).." ("..(getElementData(targetPlayer, "ID") or 0)..") \n`🚗` **Veiculo:** ("..veh.."["..vehId.."])" )
    else
      outputMessage(thePlayer, "ERRO", "error")
    end
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

addCommandHandler(Apolo_Config.Comandos["TpLoc"], function(thePlayer, commandName, loc, dim)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup (Apolo_Config.Acls["AclTp"])) then
    if not loc then outputMessage(thePlayer,Apolo_Config.Mensagens["ErroTpLoc"],"error") return end
    local xyz = split(loc,',')
    local x = tostring(xyz[1])
    local y = tostring(xyz[2])
    local z = tostring(xyz[3])
    if not dim then dim=0 end
    if x=="nil" or y=="nil" or z=="nil" then outputMessage(thePlayer,"Use o formato da loc: X,Y,Z","error") return end
    if getPedOccupiedVehicle(thePlayer) then
      local veh = getPedOccupiedVehicle(thePlayer)
      setVehicleTurnVelocity(veh, 0, 0, 0)
      setElementPosition(veh, x, y, z)
      setElementDimension(thePlayer, dim)
      warpPedIntoVehicle ( thePlayer, veh )
      setTimer(setVehicleTurnVelocity, 50, 20, veh, 0, 0, 0)
    else
      setElementPosition(thePlayer, x, y, z)
      setElementDimension(thePlayer, dim)
    end
    outputMessage(thePlayer, "Teleportado", "success")
    --msg(">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Deu tp no player: "..getPlayerName(targetPlayer).." ("..(getElementData(targetPlayer, "ID") or 0)..")")
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)
addCommandHandler(Apolo_Config.Comandos["Tp"], function(thePlayer, commandName, id)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup (Apolo_Config.Acls["AclTp"])) then
    if not tonumber(id) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroID"], "error") return end
    local playerID = tonumber(id)
    local targetPlayer = getPlayerID(playerID)
    if not targetPlayer then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPlayer"], "error") return end
    local x, y, z = getElementPosition(targetPlayer)
    local interior = getElementInterior(targetPlayer)
    local dimension = getElementDimension(targetPlayer)
    local r = getPedRotation(targetPlayer)
    setCameraInterior(thePlayer, interior)
    if getPedOccupiedVehicle(thePlayer) then
      local veh = getPedOccupiedVehicle(thePlayer)
      setVehicleTurnVelocity(veh, 0, 0, 0)
      setElementInterior(thePlayer, interior)
      setElementDimension(thePlayer, dimension)
      setElementInterior(veh, interior)
      setElementDimension(veh, dimension)
      setElementPosition(veh, x, y, z + 1)
      warpPedIntoVehicle ( thePlayer, veh )
      setTimer(setVehicleTurnVelocity, 50, 20, veh, 0, 0, 0)
    else
      setElementPosition(thePlayer, x, y, z+2)
      setElementInterior(thePlayer, interior)
      setElementDimension(thePlayer, dimension)
    end
    outputMessage(thePlayer, "Voce teleportou ao player "..getPlayerName(targetPlayer).."["..(getElementData(targetPlayer, "ID") or 0).."]", "success")
    --msg(">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Deu tp no player: "..getPlayerName(targetPlayer).." ("..(getElementData(targetPlayer, "ID") or 0)..")")
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

addCommandHandler(Apolo_Config.Comandos["Reviver"], function(thePlayer, commandName, id)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup (Apolo_Config.Acls["AclVida"])) then
    if not tonumber(id) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroID"], "error") return end
    local playerID = tonumber(id)
    local targetPlayer = getPlayerID(playerID)
    if not targetPlayer then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPlayer"], "error") return end
    if not isPedDead(targetPlayer) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroReviver"], "error") return end
    setElementHealth(targetPlayer, 5)
    outputMessage(thePlayer, "Você reviveu o player "..getPlayerName(targetPlayer).."["..(getElementData(targetPlayer, "ID") or 0).."]", "success")
    msg(thePlayer,"REVIVER",">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Reviveu o player: "..getPlayerName(targetPlayer).." ("..(getElementData(targetPlayer, "ID") or 0)..")")
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

--[[addCommandHandler("volume", function(thePlayer, commandName, vol)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup ("Staff")) then  
    exports["[mod]Radio"]:volume(vol)
    --outputMessage(thePlayer, "Você reviveu o player "..getPlayerName(targetPlayer).."["..(getElementData(targetPlayer, "ID") or 0).."]", "success")
    
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)
]]

addCommandHandler(Apolo_Config.Comandos["Puxar"], function(thePlayer, commandName, id)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup (Apolo_Config.Acls["AclPuxar"])) then
    if not tonumber(id) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroID"], "error") return end
    local playerID = tonumber(id)
    local targetPlayer = getPlayerID(playerID)
    if not targetPlayer then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPlayer"], "error") return end
    local x, y, z = getElementPosition(thePlayer)
    local interior = getElementInterior(thePlayer)
    local dimension = getElementDimension(thePlayer)
    local r = getPedRotation(thePlayer)
    setCameraInterior(targetPlayer, interior)
    --msg(">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Puxou o player: "..getPlayerName(targetPlayer).." ("..(getElementData(targetPlayer, "ID") or 0)..")")
    if getPedOccupiedVehicle(targetPlayer) then
      local veh = getPedOccupiedVehicle(targetPlayer)
      setVehicleTurnVelocity(veh, 0, 0, 0)
      setElementPosition(veh, x, y, z + 2)
      setTimer(setVehicleTurnVelocity, 50, 10, veh, 0, 0, 0)
      setElementInterior(veh, interior)
      setElementDimension(veh, dimension)
    else
      setElementPosition(targetPlayer, x, y, z+2)
      setElementInterior(targetPlayer, interior)
      setElementDimension(targetPlayer, dimension)
    end
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

addCommandHandler(Apolo_Config.Comandos["Vida"], function(thePlayer, commandName, id)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup (Apolo_Config.Acls["AclVida"])) then
    local id = id
    if not tonumber(id) then 
      id = getAccountID(getPlayerAccount(thePlayer))
    end
    local playerID = tonumber(id)
    local targetPlayer = getPlayerID(playerID)
    if not targetPlayer then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPlayer"], "error") return end
    setElementHealth(targetPlayer, 100)
    setPedArmor(targetPlayer, 100)
    outputMessage(thePlayer, "Você deu vida/colete ao player "..getPlayerName(targetPlayer).."["..(getElementData(targetPlayer, "ID") or 0).."]", "success")
    msg(thePlayer,"GOD",">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Deu god no player: "..getPlayerName(targetPlayer).." ("..(getElementData(targetPlayer, "ID") or 0)..")")
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

  
addCommandHandler(Apolo_Config.Comandos["Fix"], function(thePlayer, commandName, id)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup (Apolo_Config.Acls["AclFix"])) then
    local id = id
    if not tonumber(id) then 
      id = getAccountID(getPlayerAccount(thePlayer))
    end
    local playerID = tonumber(id)
    local targetPlayer = getPlayerID(playerID)
    if not targetPlayer then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPlayer"], "error") return end
    if not getPedOccupiedVehicle(targetPlayer) then outputMessage(thePlayer, ERRORNOVEHICLE, "error") return end
    local veh = getPedOccupiedVehicle(targetPlayer)
    fixVehicle(veh)
    local rX, rY, rZ = getElementRotation(veh)
    setElementRotation(veh, 0, 0, (rX > 90 and rX < 270) and (rZ + 180) or rZ)
    outputMessage(thePlayer, "Voce consertou o veiculo do player "..getPlayerName(targetPlayer).."["..(getElementData(targetPlayer, "ID") or 0).."]", "success")
    --msg(">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Concertou o veiculo do player: "..getPlayerName(targetPlayer).." ("..(getElementData(targetPlayer, "ID") or 0)..")")
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

addCommandHandler(Apolo_Config.Comandos["DvId"], function(thePlayer, commandName, id)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup (Apolo_Config.Acls["AclDv"])) then
    if not tonumber(id) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroID"], "error") return end
    local playerID = tonumber(id)
    local targetPlayer = getPlayerID(playerID)
    if not targetPlayer then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPlayer"], "error") return end
    if not getPedOccupiedVehicle(targetPlayer) then outputMessage(thePlayer, ERRORNOVEHICLE, "error") return end
    local veh = getPedOccupiedVehicle(targetPlayer)
    destroyElement(veh)
    outputMessage(thePlayer, "Voce destruiu o veiculo do player "..getPlayerName(targetPlayer).."["..(getElementData(targetPlayer, "ID") or 0).."]", "success")
    --msg(">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Destruiu o carro do player: "..getPlayerName(targetPlayer).." ("..(getElementData(targetPlayer, "ID") or 0)..")")
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

addCommandHandler("alarme", function(thePlayer, commandName, id)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup ("Staff")) then
    if not tonumber(id) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroID"], "error") return end
    local playerID = tonumber(id)
    local targetPlayer = getPlayerID(playerID)
    if not targetPlayer then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPlayer"], "error") return end
    --local veh = getNearestVehicle()
    --setVehicleLocked(veh, not isVehicleLocked(veh))
    local tranca = exports["[mod]Concessionaria"]:lockVehicle( targetPlayer, "l", "down" )
    if tranca==true then
    --if isVehicleLocked(veh) then
      outputMessage(thePlayer, "Voce trancou o veiculo do player "..getPlayerName(targetPlayer).."["..(getElementData(targetPlayer, "ID") or 0).."]", "success")
    else if tranca==false then
      outputMessage(thePlayer, "Voce destrancou o veiculo do player "..getPlayerName(targetPlayer).."["..(getElementData(targetPlayer, "ID") or 0).."]", "success")  
      end
    end
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

--2 argumentos
addCommandHandler("settime", function(thePlayer, commandName, hora, min)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup (Apolo_Config.Acls["Staff"])) then
    if hora and min then
      if (tonumber(hora)>= 0 and tonumber(hora)<=23) and (tonumber(min)>=0 and tonumber(min)<=59) then
        setTime(tonumber(hora),tonumber(min))
        outputMessage(thePlayer, "Você setou a hora para: "..hora..":"..min, "success")
        msg(thePlayer,"HORA",">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Setou a hora para: "..hora..":"..min)
      else
        outputMessage(thePlayer, "Os valores deve ser entre [0-23],[0-59]", "error")
      end
    else
      outputMessage(thePlayer, "Informe a hora e os minutos!", "error")
    end
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

addCommandHandler(Apolo_Config.Comandos["SetSkin"], function(thePlayer, commandName, id, skin)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup (Apolo_Config.Acls["Staff"])) then
    if not tonumber(id) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroID"], "error") return end
    if not tonumber(skin) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroSkin"], "error") return end
    local playerID = tonumber(id)
    local targetPlayer = getPlayerID(playerID)
    if not isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup ("Dono")) and isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(targetPlayer)), aclGetGroup ("Dono")) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error") return end
    if not targetPlayer then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPlayer"], "error") return end
    if tonumber(skin) == 100 then
      if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup ("Dono")) then
        setElementModel(targetPlayer,skin)
      else
        return
      end
    else 
      setElementModel(targetPlayer,skin)
    end
    outputMessage(thePlayer, "Você setou a skin "..skin.." no player "..getPlayerName(targetPlayer).."["..(getElementData(targetPlayer, "ID") or 0).."]", "success")
    msg(thePlayer,"SKIN",">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Setou a skin["..skin.."] no jogador "..getPlayerName(targetPlayer).." ("..(getElementData(targetPlayer, "ID") or 0)..")")
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

addCommandHandler(Apolo_Config.Comandos["Dinheiro"], function(thePlayer, commandName, id, quant)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup (Apolo_Config.Acls["Staff"])) then
    if not tonumber(id) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroID"], "error") return end
    if not tonumber(quant) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroMoney"], "error") return end
    local playerID = tonumber(id)
    local targetPlayer = getPlayerID(playerID)
    if not targetPlayer then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPlayer"], "error") return end
    givePlayerMoney(targetPlayer,quant)
    outputMessage(thePlayer, "Você deu R$"..quant.." para o player "..getPlayerName(targetPlayer).."["..(getElementData(targetPlayer, "ID") or 0).."]", "success")
    msg(thePlayer,"DINHEIRO",">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Deu R$"..quant.." para "..getPlayerName(targetPlayer).." ("..(getElementData(targetPlayer, "ID") or 0)..")")
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

addCommandHandler(Apolo_Config.Comandos["Fome"], function(thePlayer, commandName, id, porc)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup (Apolo_Config.Acls["Staff"])) then
    if not tonumber(id) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroID"], "error") return end
    if not tonumber(porc) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroFome"], "error") return end
    if tonumber(porc) < 0 or tonumber(porc) > 100 then outputMessage(thePlayer, "Valor permitido: [0-100]", "error") return end
    local playerID = tonumber(id)
    local targetPlayer = getPlayerID(playerID)
    if not targetPlayer then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPlayer"], "error") return end
    setElementData (targetPlayer,"fome",porc)
    outputMessage(thePlayer, "Voce alterou a fome do player "..getPlayerName(targetPlayer).."["..(getElementData(targetPlayer, "ID") or 0).."] para o valor "..porc, "success")
    msg(thePlayer,"FOME",">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Alterou a fome do player: "..getPlayerName(targetPlayer).." ("..(getElementData(targetPlayer, "ID") or 0)..") para "..porc.."%")
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

addCommandHandler(Apolo_Config.Comandos["Sede"], function(thePlayer, commandName, id, porc)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup (Apolo_Config.Acls["Staff"])) then
    if not tonumber(id) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroID"], "error") return end
    if not tonumber(porc) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroAgua"], "error") return end
    if tonumber(porc) < 0 or tonumber(porc) > 100 then outputMessage(thePlayer, "Valor permitido: [0-100]", "error") return end
    local playerID = tonumber(id)
    local targetPlayer = getPlayerID(playerID)
    if not targetPlayer then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPlayer"], "error") return end
    setElementData (targetPlayer,"sede",porc)
    outputMessage(thePlayer, "Voce alterou a sede do player "..getPlayerName(targetPlayer).."["..(getElementData(targetPlayer, "ID") or 0).."] para o valor "..porc, "success")
      msg(thePlayer,"SEDE",">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Alterou a sede do player: "..getPlayerName(targetPlayer).." ("..(getElementData(targetPlayer, "ID") or 0)..") para "..porc.."%")
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

addCommandHandler(Apolo_Config.Comandos["Colete"], function(thePlayer, commandName, id, armor)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup (Apolo_Config.Acls["AclColete"])) then
    if not tonumber(id) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroID"], "error") return end
    if not tonumber(armor) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroArmor"], "error") return end
    local playerID = tonumber(id)
    local targetPlayer = getPlayerID(playerID)
    if not targetPlayer then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPlayer"], "error") return end
    setPedArmor(targetPlayer, armor)
    outputMessage(thePlayer, "Voce alterou o colete do player "..getPlayerName(targetPlayer).."["..(getElementData(targetPlayer, "ID") or 0).."] para o valor "..armor, "success")
    msg(thePlayer,"COLETE",">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Alterou o colete do player: "..getPlayerName(targetPlayer).." ("..(getElementData(targetPlayer, "ID") or 0)..") para "..armor.."%")
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

addCommandHandler(Apolo_Config.Comandos["Car"], function(thePlayer, commandName, id, vehid)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup (Apolo_Config.Acls["AclCar"])) then
    if not tonumber(id) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroID"], "error") return end
    local playerID = tonumber(id)
    local targetPlayer = getPlayerID(playerID)
    if not targetPlayer then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPlayer"], "error") return end
    if getPedOccupiedVehicle(targetPlayer) then outputMessage(thePlayer, ERRORVEHICLEEXISTS, "error") return end
    if(tonumber(vehid)) then
      if not (tonumber(vehid) >= 400) or not(tonumber(vehid) <= 611) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroIdVeiculo"], "error") return end
      local veh = createVehicle(vehid, getElementPosition(targetPlayer))
      warpPedIntoVehicle(targetPlayer, veh)
      outputMessage(thePlayer, "Voce deu um veiculo ao player "..getPlayerName(targetPlayer).."["..(getElementData(targetPlayer, "ID") or 0).."]", "success")
      msg(thePlayer,"VEICULO",">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Deu um veiculo ao player: "..getPlayerName(targetPlayer).." ("..(getElementData(targetPlayer, "ID") or 0)..") \n`🚗` **Veiculo de ID:** ("..vehid..")" )
    else
      for i,j in ipairs(veiculos) do
        if (veiculos[i].nome==vehid) then
          local veh = createVehicle(veiculos[i].id, getElementPosition(targetPlayer))
          warpPedIntoVehicle(targetPlayer, veh)
          outputMessage(thePlayer, "Voce deu um veiculo ao player "..getPlayerName(targetPlayer).."["..(getElementData(targetPlayer, "ID") or 0).."]", "success")
          msg(thePlayer,"VEICULO",">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Deu um veiculo ao player: "..getPlayerName(targetPlayer).." ("..(getElementData(targetPlayer, "ID") or 0)..") \n`🚗` **Veiculo de ID:** ("..vehid..")" )
        end
      end
    end
  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

addCommandHandler(Apolo_Config.Comandos["Avisar"], function(thePlayer, commandName, id, ...)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup (Apolo_Config.Acls["AclAvisar"])) then
    if not tonumber(id) then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroID"], "error") return end
    local playerID = tonumber(id)
    local targetPlayer = getPlayerID(playerID)
    if not targetPlayer then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPlayer"], "error") return end
    if not ... then outputMessage(thePlayer, Apolo_Config.Mensagens["ErroAviso"], "error") return end
    local message = table.concat({...}, " ")
    outputMessage(targetPlayer, "O Staff "..getPlayerName(thePlayer).."["..(getElementData(thePlayer, "ID") or 0).."] Lhe deu um aviso: "..message, "success")
    outputMessage(thePlayer, "Voce deu um aviso ao player "..getPlayerName(targetPlayer).."["..(getElementData(targetPlayer, "ID") or 0).."]", "success")
    msg(thePlayer,"AVISO",">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Deu um aviso ao player: "..getPlayerName(targetPlayer).." ("..(getElementData(targetPlayer, "ID") or 0)..") \n`🧧` **Aviso:** "..message.."")

  else
    outputMessage(thePlayer, Apolo_Config.Mensagens["ErroPermissao"], "error")
  end
end)

--3+ argumentos
addCommandHandler("item", function(thePlayer, cmd, idPlayer, item, qt)
  local targetPlayer = getPlayerID(tonumber(idPlayer))
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup ("Staff")) then
    if(exports["[mod]inventario"]:obterItem(thePlayer,idPlayer, item, qt) == true) then
      outputMessage(thePlayer, getPlayerName(targetPlayer).." Recebeu "..qt.."x ".. item, "success")
      msg(thePlayer,"ITEM",">>> `🗽` **Staff:** "..getPlayerName(thePlayer).." ("..(getElementData(thePlayer, "ID") or 0)..") \n`📑` **Mensagem:** Deu "..qt.."x "..item.." \nPara: "..getPlayerName(targetPlayer))
    else
      outputMessage(thePlayer, "Erro!", "error")
    end
  end
end)

addCommandHandler("carcolor", function(thePlayer, cmd, corR,corG,corB ,farolR,farolG,farolB)
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup ("Staff")) then
    if isPedInVehicle(thePlayer) then
      local veh = getPlayerOccupiedVehicle(thePlayer)
      if corR and corG and corB then
        if (tonumber(corR)>=0 and tonumber(corR)<=255) and (tonumber(corG)>=0 and tonumber(corG)<=255) and (tonumber(corB)>=0 and tonumber(corB)<=255) then
          setVehicleColor(veh,corR,corG,corB)
        else
          outputMessage(thePlayer, "Cada valor deve ser entre [0-255]", "error")
        end
      end
      if farolR and farolG and farolB then
        if (tonumber(farolR)>=0 and tonumber(farolR)<=255) and (tonumber(farolG)>=0 and tonumber(farolG)<=255) and (tonumber(farolB)>=0 and tonumber(farolB)<=255) then
          setVehicleHeadLightColor(veh,farolR,farolG,farolB)
        else
          outputMessage(thePlayer, "Cada valor deve ser entre [0-255]", "error")
        end
      end
    end
  else
    outputMessage(thePlayer, "Erro!", "error")
  end
end)


