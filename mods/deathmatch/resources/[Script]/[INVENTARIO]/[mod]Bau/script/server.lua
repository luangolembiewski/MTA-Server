--[[
===========================================================
# Minha página: https://www.facebook.com/TioSteinScripter/#
#      ╔════╗╔══╗╔═══╗     ╔═══╗╔════╗╔═══╗╔══╗╔═╗─╔╗     #
#      ║╔╗╔╗║╚╣─╝║╔═╗║     ║╔═╗║║╔╗╔╗║║╔══╝╚╣─╝║║╚╗║║     #
#      ╚╝║║╚╝─║║─║║─║║     ║╚══╗╚╝║║╚╝║╚══╗─║║─║╔╗╚╝║     #
#      ──║║───║║─║║─║║     ╚══╗║──║║──║╔══╝─║║─║║╚╗║║     #
#      ──║║──╔╣─╗║╚═╝║     ║╚═╝║──║║──║╚══╗╔╣─╗║║─║║║     #
#      ──╚╝──╚══╝╚═══╝     ╚═══╝──╚╝──╚═══╝╚══╝╚╝─╚═╝     #
===========================================================
--]]

local bau = {
    functions = {},
    index = {},
    players = {},
}

local data = {}
addEventHandler("onResourceStart", resourceRoot, function(resource)
    if resource == getThisResource() then
        bau["db"] = dbConnect("sqlite", "assets/database/database.db")
        if bau["db"] then
            print("database conectada com sucesso!")
            dbExec(bau["db"],"CREATE TABLE IF NOT EXISTS baus (data)") 
            for i, v in ipairs(config["Bau"]) do
                local a = createObject(964, v.x, v.y, v.z-1)
                setElementRotation(a, v.rotx, v.roty, v.rotz)
                setElementInterior(a, v.int)
                setElementDimension(a, v.dim)
                bau.index[a] = i
            end
            bau.functions["data:load"]()
        else
            print("error na database")
        end
    end
end)

addEventHandler("onElementClicked", root, function( button, state, player )
    if button == "left" and state == "down" then
        if getElementType( source ) == "object" then 
            if getElementModel( source ) == 964 and bau.index[source] and not isElement(bau.players[source]) then
                local tab = config["Bau"][bau.index[source]]
                if isObjectInACLGroup ("user."..getAccountName ( getPlayerAccount ( player ) ), aclGetGroup ( tab.ACL ) ) then
                    local x, y, z = getElementPosition( player )
                    local x1, y1, z1 = getElementPosition( source ) 
                    local distance = getDistanceBetweenPoints3D( x, y, z, x1, y1, z1 ) 
                    if distance <= 4 then
                        bau.players[source] = player
                        bau.players[player] = source
                        if not data[tab.name] then
                            data[tab.name] = {}
                        end
                        local myItens = exports[config["Configurações"].inventoryName]:getAllItens(player)
                        triggerClientEvent(player, "TS:openBau", player, myItens, tab.name, data[tab.name])
                    end
                end
            end
        end
    end
end)

addEventHandler("onResourceStop", resourceRoot, function(res)
    if res == resource then
        bau.functions["data:save"]()
    end
end)

bau.functions["server:sendMessage"] = function(thePlayer, msg, type)
    triggerClientEvent(thePlayer, "serverNotifys2", thePlayer, msg, type)
end

bau.functions["bau:close"] = function(thePlayer)
    if isElement(bau.players[thePlayer]) then
        bau.players[bau.players[thePlayer]] = nil
        bau.players[thePlayer] = nil
    end
end
addEvent("TS:closeBau", true)
addEventHandler("TS:closeBau", root, bau.functions["bau:close"])

bau.functions["data:load"] = function()
    local db = dbPoll(dbQuery(bau["db"], "SELECT * FROM baus"), -1) 
    if #db >= 1 then
        local tab = fromJSON(db[1]["data"])

        bau_t = {}
        for index, _ in pairs(tab) do
            for i, v in ipairs(config["Bau"]) do
                table.insert(bau_t, {i})
                if index == v.name then
                    bau_v = true
                    if i == #bau_t then
                        bau_t = {}
                        bau_v = false
                    end
                else
                    if i == #bau_t then
                        if not bau_v then
                            bau_t = {}
                            tab[index] = nil
                            dbExec(bau["db"],"UPDATE baus SET data = ?", toJSON(tab))
                            print("DB Bau: "..index.." não foi encontrado no global e foi deletado!")
                        end
                    end
                end
            end
        end

        for i, v in pairs(tab) do
            iprint("Bau "..i.." loaded")
            data[i] = v
        end
    end
end

bau.functions["data:save"] = function()
    local dt = dbPoll(dbQuery(bau["db"], "SELECT * FROM baus"), -1) 
    if #dt >= 1 then
        dbExec(bau["db"],"UPDATE baus SET data = ?", toJSON(data))
        data = nil
    else
        dbExec(bau["db"],"INSERT INTO baus VALUES( ? )", toJSON(data))
        data = nil
    end
end

bau.functions["server:saveItem"] = function(thePlayer, nameBau, itemID, amount)
    local state, quantity = exports[config["Configurações"].inventoryName]:getItem(thePlayer, itemID)
    if state and tonumber(quantity) >= tonumber(amount) then
        local quantityBau = data[nameBau][tostring(itemID)]
        if quantityBau and quantityBau.quantidade then
            triggerEvent("TS:takeItem", thePlayer, thePlayer, itemID, amount)
            data[nameBau][tostring(itemID)].quantidade = quantityBau.quantidade + amount
            triggerClientEvent(thePlayer, "TS:atualizeBau", thePlayer, data[nameBau])
        else
            triggerEvent("TS:takeItem", thePlayer, thePlayer, itemID, amount)
            data[nameBau][tostring(itemID)] = {
                quantidade = amount,
                slot = bau.functions["data:getSlot"](thePlayer, data[nameBau])
            }
            triggerClientEvent(thePlayer, "TS:atualizeBau", thePlayer, data[nameBau])
            bau.functions["server:sendMessage"](thePlayer, "Item guardado!", "sucess")
        end
        local id_e = getElementData(thePlayer, "ID") or "N/A"
        sendDiscordMessage("LOGS BAU: "..nameBau, "Nome: "..removeHex(getPlayerName(thePlayer)).." ("..id_e..")\n\nAção: Colocou "..amount.."x do Item de ID: "..itemID)
    else
        bau.functions["server:sendMessage"](thePlayer, "Você não tem item suficiente!", "error")
    end
end
addEvent("TS:saveItem", true)
addEventHandler("TS:saveItem", root, bau.functions["server:saveItem"])

bau.functions["server:removeItem"] = function(thePlayer, nameBau, itemID, amount)
    if data[nameBau][tostring(itemID)] and tonumber(data[nameBau][tostring(itemID)].quantidade) >= tonumber(amount) then
        local quantity = data[nameBau][tostring(itemID)].quantidade
        if exports[config["Configurações"].inventoryName]:verifyKGPlayer(thePlayer, tonumber(itemID), amount) then
            if tonumber(quantity) == tonumber(amount) then
                data[nameBau][tostring(itemID)] = nil
            else
                data[nameBau][tostring(itemID)].quantidade = quantity-tonumber(amount)
            end
            bau.functions["server:sendMessage"](thePlayer, "Item retirado!", "sucess")
            local id_e = getElementData(thePlayer, "ID") or "N/A"
            sendDiscordMessage("LOGS BAU: "..nameBau, "Nome: "..removeHex(getPlayerName(thePlayer)).." ("..id_e..")\n\nAção: Retirou "..amount.."x do Item de ID: "..itemID)
            triggerEvent("TS:addItem", thePlayer, thePlayer, itemID, amount)
            triggerClientEvent(thePlayer, "TS:atualizeBau", thePlayer, data[nameBau])
        else
            bau.functions["server:sendMessage"](thePlayer, "Sem Espaço em Sua Mochila!", "error")
        end
    else
        bau.functions["server:sendMessage"](thePlayer, "Você não tem item suficiente!", "error")
    end
end
addEvent("TS:removeItem", true)
addEventHandler("TS:removeItem", root, bau.functions["server:removeItem"])

bau.functions["data:getSlot"] = function(thePlayer, table)
    local slots = bau.functions["data:getItemSlot"](table)
    for i=1, 30 do
        if not slots[i] then
            return i
        end
    end
end

bau.functions["data:getItemSlot"] = function(table)
    local slotsOccuped = {}
    for i, v in pairs(table) do
        slotsOccuped[v.slot] = true
    end
    return slotsOccuped
end