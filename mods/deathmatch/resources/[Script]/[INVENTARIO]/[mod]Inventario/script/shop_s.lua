local shops = {
    functions = {},
    markerInfo = {}
}

addEventHandler("onResourceStart", resourceRoot, function(resource)
    if resource == getThisResource() then
        for i, v in ipairs(config["Shops"]) do
            local x,y,z,int,dim,blip,itens = v.x, v.y, v.z, v.int, v.dim, v.blip, v.itens
            local a = createMarker( x,y,z-1, "cylinder", 1.3, 16, 111, 231, 200)
            setElementInterior(a, int)
            setElementDimension(a, dim)
            shops.markerInfo[a] = {
                itens = v.itens,
                name = v.name,
            }
            if int == 0 then 
                local att = createBlipAttachedTo ( a, blip )
                setBlipVisibleDistance(att, 300) 
                setElementData(att, "blipName", shops.markerInfo[a].name)
            end
        end
    end
end)

addEventHandler("onMarkerHit", resourceRoot, function(thePlayer)
    if getElementType(thePlayer) == "player" then
        if not isPedInVehicle(thePlayer) then
            if shops.markerInfo[source] then
                triggerClientEvent(thePlayer, "TS:openShop", thePlayer, data[thePlayer], shops.markerInfo[source])
            end
        end
    end
end)

shops.functions["server:sendMessage"] = function(thePlayer, msg, type)
    triggerClientEvent(thePlayer, "serverNotifys2", thePlayer, msg, type)
end

shops.functions["server:buyShop"] = function(thePlayer, itemid, price, amount)
    if getPlayerMoney(thePlayer) >= tonumber(price) then
        local mySlots, pesoSlots = tonumber(data[thePlayer].info.mySlots), tonumber(data[thePlayer].info.pesoSlots)
        local pesoItem = tonumber(config["Items"][tonumber(itemid)].peso)*tonumber(amount)
        local itemName = config["Items"][tonumber(itemid)].nameItem
        if (mySlots+pesoItem) <= pesoSlots then
            takePlayerMoney(thePlayer, price)
            triggerEvent("TS:addItem", thePlayer, thePlayer, tonumber(itemid), tonumber(amount))
            shops.functions["server:sendMessage"](thePlayer, "Você comprou "..amount.." "..itemName.."(s)!", "sucess")
        else
            shops.functions["server:sendMessage"](thePlayer, "Espaço insuficiente!", "error")
        end
    end
end
shops.functions["giveItem"] = function(thePlayer, itemid, amount)
        local mySlots, pesoSlots = tonumber(data[thePlayer].info.mySlots), tonumber(data[thePlayer].info.pesoSlots)
        local pesoItem = tonumber(config["Items"][tonumber(itemid)].peso)*tonumber(amount)
        local itemName = config["Items"][tonumber(itemid)].nameItem
        if (mySlots+pesoItem) <= pesoSlots then
            triggerEvent("TS:addItem", thePlayer, thePlayer, tonumber(itemid), tonumber(amount))
            shops.functions["server:sendMessage"](thePlayer, "Você comprou "..amount.." "..itemName.."(s)!", "sucess")
        else
            shops.functions["server:sendMessage"](thePlayer, "Espaço insuficiente!", "error")
        end
end
addEvent("TS:buyShop", true)
addEventHandler("TS:buyShop", root, shops.functions["server:buyShop"])