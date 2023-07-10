
local inventory = {
    functions = {},
    itensDrops = {},
    playerDrop = {},
}

data = {}

addEventHandler("onResourceStart",resourceRoot,function(res)
    if res == getThisResource() then
        db = dbConnect("sqlite", "assets/database/database.sqlite")
        dbExec(db,"CREATE TABLE IF NOT EXISTS inventory (account, data)")
        if db then
            outputDebugString("dbConnect[inventory]: Sucesso!")
        else
            outputDebugString("dbConnect[inventory]: Fail!")
        end
        for i, v in ipairs(getElementsByType("player")) do 
            inventory.functions["data:load"](v)
        end
    end
end)

inventory.functions["server:sendMessage"] = function(thePlayer, msg, type)
    triggerClientEvent(thePlayer, "serverNotifys2", thePlayer, msg, type)
end

addEvent("TS:atualizeInv", true)
addEventHandler("TS:atualizeInv", root, function(thePlayer)
    triggerClientEvent(thePlayer, "TS:atualizeInv", thePlayer, data[thePlayer])
end)

addEvent("TS:atualizeData", true)
addEventHandler("TS:atualizeData", root, function(thePlayer, dt)
    data[thePlayer] = dt
end)

inventory.functions["data:load"] = function(thePlayer)
    if getAccountName(getPlayerAccount(thePlayer)) ~= "guest" then
        local db = dbPoll(dbQuery(db, "SELECT * FROM inventory WHERE account = ?", getAccountName(getPlayerAccount(thePlayer))), -1) 
        data[thePlayer] = {
            itens = {},
            info = {
                pesoSlots = config["Configuração"].pesoSlots,
                mySlots = "0.00",
            }
        }
        if #db >= 1 then
            data[thePlayer] = fromJSON(db[1]["data"])
        end
    end
end

inventory.functions["data:save"] = function(thePlayer)
    if getAccountName(getPlayerAccount(thePlayer)) ~= "guest" then
        local dt = dbPoll(dbQuery(db, "SELECT * FROM inventory WHERE account = ?", getAccountName(getPlayerAccount(thePlayer))), -1) 
        if not data[thePlayer] then
            data[thePlayer] = {
                itens = {},
                info = {
                    pesoSlots = config["Configuração"].pesoSlots,
                    mySlots = "0.00",
                }
            }
        end
        if #dt >= 1 then
            dbExec(db,"UPDATE inventory SET data = ? WHERE account = ?", toJSON(data[thePlayer]), getAccountName(getPlayerAccount(thePlayer)))
            data[thePlayer] = nil
        else
            dbExec(db,"INSERT INTO inventory VALUES( ?, ? )", getAccountName(getPlayerAccount(thePlayer)), toJSON(data[thePlayer]))
            data[thePlayer] = nil
        end
    end
end

inventory.functions["data:addItem"] = function(thePlayer, itemid, amount)
    local ret = false
    if tonumber(amount) >= 1 then
        if config["Items"][tonumber(itemid)] then
            if not data[thePlayer] then
                data[thePlayer] = {
                    itens = {},
                    info = {
                        pesoSlots = config["Configuração"].pesoSlots,
                        mySlots = "0.00",
                    }
                }
            end
            local mySlots, pesoSlots = tonumber(data[thePlayer].info.mySlots), tonumber(data[thePlayer].info.pesoSlots)
            local pesoItem = tonumber(config["Items"][tonumber(itemid)].peso)*tonumber(amount)
            if (mySlots+pesoItem) <= pesoSlots then
                if type(data[thePlayer].itens[tostring(itemid)]) ~= "table" then
                    data[thePlayer].itens[tostring(itemid)] = {
                        quantidade = 0,
                        slot = inventory.functions["data:getSlot"](thePlayer),
                    }
                end
                local myItem = data[thePlayer].itens[tostring(itemid)].quantidade or 0
                data[thePlayer].itens[tostring(itemid)].quantidade = myItem+amount
                data[thePlayer].info.mySlots = tostring(mySlots+pesoItem)
                inventory.functions["server:sendMessage"](thePlayer, "Item adicionado!", "sucess")
                triggerClientEvent(thePlayer, "TS:atualizeInv", thePlayer, data[thePlayer])
                ret = true
            else
                inventory.functions["server:sendMessage"](thePlayer, "Espaço insuficiente!", "error")
            end
        else
            inventory.functions["server:sendMessage"](thePlayer, "Item não existe!", "error")
        end

    end
    return ret
end
addEvent("TS:addItem", true)
addEventHandler("TS:addItem", root, inventory.functions["data:addItem"])

inventory.functions["server:sendItem"] = function(thePlayer, itemID, amount)
    local state, value = getItem(thePlayer, itemID)
    if state and value >= amount then
        if config["Configuração"].enviarItemInVehicle == false and isPedInVehicle(thePlayer) then
            inventory.functions["server:sendMessage"](thePlayer, "Saia do veiculo para fazer isso!", "error")
            return
        end
        local player = inventory.functions["server:getNearestPlayer"](thePlayer, 4)
        local itemName = config["Items"][tonumber(itemID)].nameItem
        if isElement(player) then
            if verifyKGPlayer(player, itemID, amount) then
                inventory.functions["data:takeItem"](thePlayer, itemID, amount)
                inventory.functions["data:addItem"](player, itemID, amount)
                setPedAnimation(thePlayer, "DEALER", "DEALER_DEAL", 3000, false, false, false, false)
                setPedAnimation(player, "DEALER", "DEALER_DEAL", 3000, false, false, false, false)
                inventory.functions["server:sendMessage"](thePlayer, "Você enviou "..amount.." "..itemName.." para "..getPlayerName(player).."!", "sucess")
                inventory.functions["server:sendMessage"](player, "Você recebeu "..amount.." "..itemName.." de "..getPlayerName(thePlayer).."!", "sucess")
            end
        else
            inventory.functions["server:sendMessage"](thePlayer, "Não encontramos o jogador proximo a você!", "error")
        end
    else
        inventory.functions["server:sendMessage"](thePlayer, "Você não tem esse item!", "error")
    end
end
addEvent("TS:sendItem", true)
addEventHandler("TS:sendItem", root, inventory.functions["server:sendItem"])

inventory.functions["data:takeItem"] = function(thePlayer, itemid, amount)
    if tonumber(amount) >= 1 then
        if not data[thePlayer] then
            data[thePlayer] = {
                itens = {},
                info = {
                    pesoSlots = config["Configuração"].pesoSlots,
                    mySlots = "0.00",
                }
            }
        end
        local mySlots, pesoSlots = tonumber(data[thePlayer].info.mySlots), tonumber(data[thePlayer].info.pesoSlots)
        local pesoItem = tonumber(config["Items"][tonumber(itemid)].peso)*tonumber(amount)
        if data[thePlayer].itens[tostring(itemid)] then
            local quantidade = data[thePlayer].itens[tostring(itemid)].quantidade
            data[thePlayer].itens[tostring(itemid)].quantidade = quantidade-amount
            data[thePlayer].info.mySlots = tostring(mySlots-pesoItem)
            if data[thePlayer].itens[tostring(itemid)].quantidade <= 0 then
                data[thePlayer].itens[tostring(itemid)] = nil
            end
            if tonumber(data[thePlayer].info.mySlots) <= 0 then
                data[thePlayer].info.mySlots = "0.00"
            end
            triggerClientEvent(thePlayer, "TS:atualizeInv", thePlayer, data[thePlayer])
        end
    end
end
addEvent("TS:takeItem", true)
addEventHandler("TS:takeItem", root, inventory.functions["data:takeItem"])

inventory.functions["server:dropItem"] = function(thePlayer, itemid, amount)
    if tonumber(amount) >= 1 then
        if not data[thePlayer] then
            data[thePlayer] = {
                itens = {},
                info = {
                    pesoSlots = config["Configuração"].pesoSlots,
                    mySlots = "0.00",
                }
            }
        end
        local state, value = getItem(thePlayer, itemid)
        local itemName = config["Items"][tonumber(itemid)].nameItem
        if state and value >= amount then
            if not isElement(inventory.playerDrop[thePlayer]) then
                inventory.functions["data:takeItem"](thePlayer, itemid, amount)
                local name = getPlayerName(thePlayer).." ( "..(getElementData(thePlayer, "ID") or 0).." )"
                local x,y,z = getElementPosition(thePlayer)
                local caixa = createObject(1220, x,y,z-0.5)
                setObjectScale(caixa, 0.5)
                setElementFrozen(caixa, true)
                inventory.playerDrop[thePlayer] = caixa
                inventory.itensDrops[caixa] = {itemID = itemid, value = amount, namePlayer = name}
                inventory.functions["server:sendMessage"](thePlayer, "Nessa caixa tem "..amount.." "..itemName.."!", "sucess")
                setTimer(function()
                    if isElement(caixa) then
                        destroyElement(caixa)
                    end
                end, 20000, 1)
            else
                inventory.functions["server:sendMessage"](thePlayer, "Você já tem um item dropado!", "sucess")
            end
        end
    else
        inventory.functions["server:sendMessage"](thePlayer, "Você não tem esse item!", "error")
    end
end
addEvent("TS:dropItem", true)
addEventHandler("TS:dropItem", root, inventory.functions["server:dropItem"])

inventory.functions["server:clickItem"] = function( button, state, player ) -- Add the function
    if button == "left" and state == "down" then
        if getElementType( source ) == "object" and getElementModel(source) == 1220 and inventory.itensDrops[source] then -- If the clicked element is a vehicle...
            local x, y, z = getElementPosition( player )
            local x1, y1, z1 = getElementPosition( source ) 
            local distance = getDistanceBetweenPoints3D( x, y, z, x1, y1, z1 ) -- Some distance calculations
            if distance < 2 then -- Check if the player is near the vehicle
                local item = inventory.itensDrops[source].itemID
                local amount = inventory.itensDrops[source].value
                local namePlayer = inventory.itensDrops[source].namePlayer
                local itemName = config["Items"][tonumber(item)].nameItem
                if verifyKGPlayer(player, item, amount) then
                    inventory.itensDrops[source] = nil
                    destroyElement(source)
                    inventory.functions["data:addItem"](player, item, amount)
                    inventory.functions["server:sendMessage"](player, "Nessa caixa tinha "..amount.." "..itemName.." dropada por "..namePlayer.."!", "sucess")
                end
            end
        end
    end
end
addEventHandler( "onElementClicked", root, inventory.functions["server:clickItem"] ) -- Add the event handler

getAllItens = function(thePlayer)
    return data[thePlayer]
end

getItem = function(thePlayer, itemid)
    if not data[thePlayer] then
        data[thePlayer] = {
            itens = {},
            info = {
                pesoSlots = config["Configuração"].pesoSlots,
                mySlots = "0.00",
            }
        }
    end
    if data[thePlayer].itens[tostring(itemid)] and data[thePlayer].itens[tostring(itemid)].quantidade then
        return true, data[thePlayer].itens[tostring(itemid)].quantidade
    elseif data[thePlayer].itens[tonumber(itemid)] and data[thePlayer].itens[tonumber(itemid)].quantidade then
        return true, data[thePlayer].itens[tonumber(itemid)].quantidade
    else
        return false, 0
    end
end

inventory.functions["data:getSlot"] = function(thePlayer)
    local slots = inventory.functions["data:getItemSlot"](data[thePlayer].itens)
    for i=1, 80 do
        if not slots[i] then
            return i
        end
    end
end

inventory.functions["data:getItemSlot"] = function(table)
    local slotsOccuped = {}
    for i, v in pairs(table) do
        slotsOccuped[v.slot] = true
    end
    return slotsOccuped
end

inventory.functions["server:getPlayerID"] = function(id)
    local player = false
    for i, v in ipairs(getElementsByType("player")) do
        if tonumber(getElementData(v, "ID")) == tonumber(id) then
            player = v 
            break
        end
    end
    return player
end

function obterItem(thePlayer,idPlayer, item, amount)
    if idPlayer and item and amount then
        local existe=false
        local itemID = nil
        if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup(config["Configuração"].ACL)) then
            local player = inventory.functions["server:getPlayerID"](tonumber(idPlayer))

            for i, v in ipairs(config["Items"]) do
                if (config["Items"][i].nameItem == item) then
                    itemID = i
                    break
                end
            end
            if isElement(player) and itemID then
                if(inventory.functions["data:addItem"](player, itemID, amount)) then
                    existe=true
                end
            end
        end
        return existe
    end
end

addCommandHandler("takeitem", function(thePlayer, cmd, idPlayer, itemID, amount)
    if idPlayer and itemID and amount then
        if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup(config["Configuração"].ACL)) then
            local player = inventory.functions["server:getPlayerID"](tonumber(idPlayer))
            if isElement(player) then
                inventory.functions["data:takeItem"](player, itemID, amount)
            end
        end
    end
end)

addEventHandler("onPlayerLogin", root, function()
    inventory.functions["data:load"](source)
end)

addEventHandler("onResourceStop", resourceRoot, function(res)
    if res == resource then
        for i, v in ipairs(getElementsByType("player")) do 
            useitem.functions["weapon:take"](v)
            inventory.functions["data:save"](v)
        end
    end
end)

addEventHandler("onPlayerWasted", root, function()
	takeAllWeapons(source)
	useitem.weaponsEquiped[source] = nil
    if config["Configuração"].morrerPerder == true then
        data[source].info.pesoSlots = config["Configuração"].pesoSlots
        data[source].info.mySlots = "0.00"
        data[source].itens = {}
        triggerClientEvent(source, "TS:atualizeInv", source, data[source])
    end
end)

addEventHandler("onPlayerQuit", root, function()
    if useitem.weaponsEquiped[source] then
        local Weapon = useitem.weaponsEquiped[source]
        if inventory.functions["verifyWeapon"](source, Weapon) then
            local IDItem, IDMuni = inventory.functions["getIDItemFromWeapon"](source, Weapon)
            local weaponSlot = getSlotFromWeapon ( Weapon )
            local Municao = getPedTotalAmmo(source, weaponSlot)
            if IDItem then
                if verifyKGPlayer(source, IDItem, 1) then
                    triggerEvent("TS:addItem", source, source, tonumber(IDItem), 1)
                    takeWeapon(source, Weapon)
                    useitem.weaponsEquiped[source] = nil
                end
                if Municao > 1 then
                    if verifyKGPlayer(source, IDMuni, Municao -1) then
                        triggerEvent("TS:addItem", source, source, tonumber(IDMuni), Municao -1)
                    end
                end
            end
        else
            useitem.weaponsEquiped[source] = nil
        end
    end
    inventory.functions["data:save"](source)
end, true, "high")

local counter = {}

inventory.functions["server:getNearestPlayer"] = function(player,distance)
    counter[player] = 0
    local lastMinDis = distance-0.0001
    local nearestVeh = false
    local px,py,pz = getElementPosition(player)
    local pint = getElementInterior(player)
    local pdim = getElementDimension(player)

    for _,v in pairs(getElementsByType("player")) do
        local vint,vdim = getElementInterior(v),getElementDimension(v)
        if vint == pint and vdim == pdim then
            if v ~= player then
                local vx,vy,vz = getElementPosition(v)
                local dis = getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz)
                if dis < distance then
                    if dis < lastMinDis then 
                        lastMinDis = dis
                        nearestVeh = v
                        counter[player] = counter[player]+1
                    end
                end
            end
        end
    end
    return nearestVeh
end

inventory.functions["verifyWeapon"] = function(player, weapon)
    for i = 1,12 do
        local Weapon = getPedWeapon(player, i)
        if Weapon == weapon then
            return true
        end
    end
    return false
end

inventory.functions["getIDItemFromWeapon"] = function(player, weapon)
    for i,v in pairs(config["Items"]) do
        if v.weaponID and v.weaponID == weapon then
            return i,v.idAmmu
        end
    end
    return false
end

function verifyKGPlayer(player, item, quantidade)
    local kg = config["Items"][tonumber(item)].peso * tonumber(quantidade)
    local Infos = getAllItens(player)
    local Informacoes = Infos.info
    local PesoTotal = Informacoes.pesoSlots
    local PesConsumido = Informacoes.mySlots
    local PesoLivre = PesoTotal - PesConsumido
    if PesoLivre >= kg then
        return true
    end
    inventory.functions["server:sendMessage"](player, "Espaço insuficiente", "error")
    return false
end