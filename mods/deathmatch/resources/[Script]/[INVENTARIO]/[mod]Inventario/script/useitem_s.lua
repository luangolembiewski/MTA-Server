useitem = {
    functions = {},
    weaponsEquiped = {},
}

useitem.functions["server:sendMessage"] = function(thePlayer, msg, type)
    triggerClientEvent(thePlayer, "serverNotifys2", thePlayer, msg, type)
end

useitem.functions["itens:use"] = function(thePlayer, itemID, amount)
    if config["Items"][tonumber(itemID)] then
        local tab = config["Items"][tonumber(itemID)]
        local state, quantidade = getItem(thePlayer, itemID)
        if state and quantidade >= amount then
            if tab.type == "comida" then
                local myHunger = getElementData(thePlayer, config["Configuração"].elementFome) or 0
                local value = amount*tab.value
                if myHunger+value <= 100 then
                    setPedAnimation(thePlayer, "FOOD", "EAT_Burger", 1000, false)
                    setElementData(thePlayer, config["Configuração"].elementFome, myHunger+value)
                    useitem.functions["server:sendMessage"](thePlayer, "Você comeu "..amount.." "..tab.nameItem.."(s)!", "sucess")
                    triggerEvent("TS:takeItem", thePlayer, thePlayer, tonumber(itemID), tonumber(amount))
                else
                    useitem.functions["server:sendMessage"](thePlayer, "Você não está com fome suficiente!", "error")
                end
            elseif tab.type == "bebida" then
                local mySede = getElementData(thePlayer, config["Configuração"].elementSede) or 0
                local value = amount*tab.value
                if mySede+value <= 100 then
                    setPedAnimation(thePlayer, "FOOD", "EAT_Burger", 1000, false)
                    setElementData(thePlayer, config["Configuração"].elementSede, mySede+value)
                    useitem.functions["server:sendMessage"](thePlayer, "Você bebeu "..amount.." "..tab.nameItem.."(s)!", "sucess")
                    triggerEvent("TS:takeItem", thePlayer, thePlayer, tonumber(itemID), tonumber(amount))
                else
                    useitem.functions["server:sendMessage"](thePlayer, "Você não está com fome suficiente!", "error")
                end
            elseif tab.type == "armas" then
                useitem.functions["weapon:equip"](thePlayer, itemID)
            elseif tab.type == "munição" then
                local weapon = getPedWeapon(thePlayer)
                if weapon and weaponsConfig[tonumber(weapon)] then
                    local weaponID = weaponsConfig[tonumber(weapon)].itemID
                    if weaponID then
                        local getMuniWeapon = config["Items"][tonumber(weaponID)].idAmmu
                        if tonumber(getMuniWeapon) == tonumber(itemID) then
                            triggerEvent("TS:takeItem", thePlayer, thePlayer, tonumber(itemID), tonumber(amount))
                            useitem.functions["server:sendMessage"](thePlayer, "Arma recarregada!", "sucess")
                            giveWeapon(thePlayer, weapon, amount)
                            toggleControl(thePlayer, 'fire',true)
                            reloadPedWeapon ( thePlayer )
                        else
                            useitem.functions["server:sendMessage"](thePlayer, "Essa arma usa outro tipo de munição!", "error")
                        end
                    else
                        useitem.functions["server:sendMessage"](thePlayer, "Fique com a arma na mão!", "error")
                    end
                end
            elseif tonumber(itemID) == 11 then
                setPedAnimation(thePlayer, "BOMBER", "BOM_Plant", 1000, false)
                setElementHealth(thePlayer, 100)
                useitem.functions["server:sendMessage"](thePlayer, "Você usou "..amount.." "..tab.nameItem.."(s)!", "sucess")
                triggerEvent("TS:takeItem", thePlayer, thePlayer, tonumber(itemID), tonumber(amount))
            elseif tonumber(itemID) == 12 then
                triggerEvent("TS:takeItem", thePlayer, thePlayer, tonumber(itemID), tonumber(amount))
                triggerClientEvent(thePlayer, "TS:usarCocaina", thePlayer)
                setElementHealth(thePlayer, getElementHealth(thePlayer)-10)
                setTimer(function()
                    triggerClientEvent(thePlayer, "TS:pararCocaina", thePlayer)
                end, amount*20000, 1)
            elseif tonumber(itemID) == 13 then
                setPedAnimation(thePlayer, "GHANDS", "gsign4", 1000, false)
                setPedArmor(thePlayer, 100)
                useitem.functions["server:sendMessage"](thePlayer, "Você usou "..amount.." "..tab.nameItem.."(s)!", "sucess")
                triggerEvent("TS:takeItem", thePlayer, thePlayer, tonumber(itemID), tonumber(amount))
            elseif tonumber(itemID) == 14 then
                local acl = tab.acl
                local taxaD = tab.taxa/100*amount
                if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup(acl)) then
                    triggerEvent("TS:takeItem", thePlayer, thePlayer, tonumber(itemID), tonumber(amount))
                    useitem.functions["server:sendMessage"](thePlayer, "Você limpou "..amount.." de dinheiro sujo, a maquina cobrou $"..taxaD.." ( "..tab.taxa.."% ) de taxa, sobrando "..(amount-taxaD).."!", "sucess")
                    givePlayerMoney(thePlayer, (amount-taxaD))
                else
                    useitem.functions["server:sendMessage"](thePlayer, "Você não é da facção responsável, entre em contato com um membro de lá!", "error")
                end
            elseif tonumber(itemID) == 15 then
                local vehicle = getPedOccupiedVehicle(thePlayer)
                if isElement(vehicle) then
                    triggerEvent("TS:takeItem", thePlayer, thePlayer, tonumber(itemID), tonumber(amount))
                    fixVehicle(vehicle)
                    setElementHealth(vehicle, 1000)
                    useitem.functions["server:sendMessage"](thePlayer, "Você usou "..amount.." "..tab.nameItem.."(s)!", "sucess")
                else
                    useitem.functions["server:sendMessage"](thePlayer, "Você não está em um veiculo!", "error")
                end
            elseif tonumber(itemID) == 17 then
                triggerEvent("TS:takeItem", thePlayer, thePlayer, tonumber(itemID), tonumber(amount))
                triggerClientEvent(thePlayer, "TS:usarMaconha", thePlayer)
                setElementHealth(thePlayer, getElementHealth(thePlayer)-10)
                setTimer(function()
                    triggerClientEvent(thePlayer, "TS:pararMaconha", thePlayer)
                end, amount*20000, 1)
            elseif tonumber(itemID) == 18 then
                local value = amount*tab.value
                if data[thePlayer] and data[thePlayer].info and data[thePlayer].info.pesoSlots then
                    local mySlot = tonumber(data[thePlayer].info.pesoSlots)
                    if mySlot+value <= config["Configuração"].maxSlots then
                        data[thePlayer].info.pesoSlots = tostring(mySlot+value)..".00"
                        triggerEvent("TS:takeItem", thePlayer, thePlayer, tonumber(itemID), tonumber(amount))
                        useitem.functions["server:sendMessage"](thePlayer, "Você aumentou sua mochila!", "sucess")
                    else
                        useitem.functions["server:sendMessage"](thePlayer, "Você já atingiu o maximo de slots permitidos!", "error")
                    end
                end
            elseif tonumber(itemID) == 19 then
                local vehicle = getPedOccupiedVehicle(thePlayer)
                if isElement(vehicle) then
                    local myFuel = getElementData(vehicle, config["Configuração"].elementFuel) or 0
                    local value = amount*tab.value
                    if myFuel+value <= 100 then
                        triggerEvent("TS:takeItem", thePlayer, thePlayer, tonumber(itemID), tonumber(amount))
                        setElementData(vehicle, config["Configuração"].elementFuel, myFuel+value)
                        useitem.functions["server:sendMessage"](thePlayer, "Você abasteceu "..value.."L de gasolina!", "sucess")
                    else
                        useitem.functions["server:sendMessage"](thePlayer, "O tanque de combústivel não cabe essa quantidade!", "error")
                    end
                else
                    useitem.functions["server:sendMessage"](thePlayer, "Você não está em um veiculo!", "error")
                end
            elseif tonumber(itemID) == 30 then
                local value = amount*tab.value
                if data[thePlayer] and data[thePlayer].info and data[thePlayer].info.pesoSlots then
                    local mySlot = tonumber(data[thePlayer].info.pesoSlots)
                    if mySlot+value <= config["Configuração"].maxSlots then
                        data[thePlayer].info.pesoSlots = tostring(mySlot+value)..".00"
                        triggerEvent("TS:takeItem", thePlayer, thePlayer, tonumber(itemID), tonumber(amount))
                        useitem.functions["server:sendMessage"](thePlayer, "Você aumentou sua mochila!", "sucess")
                    else
                        useitem.functions["server:sendMessage"](thePlayer, "Você já atingiu o maximo de slots permitidos!", "error")
                    end
                end
            elseif tonumber(itemID) == 31 then
                local value = amount*tab.value
                if data[thePlayer] and data[thePlayer].info and data[thePlayer].info.pesoSlots then
                    local mySlot = tonumber(data[thePlayer].info.pesoSlots)
                    if mySlot+value <= config["Configuração"].maxSlots then
                        data[thePlayer].info.pesoSlots = tostring(mySlot+value)..".00"
                        triggerEvent("TS:takeItem", thePlayer, thePlayer, tonumber(itemID), tonumber(amount))
                        useitem.functions["server:sendMessage"](thePlayer, "Você aumentou sua mochila!", "sucess")
                    else
                        useitem.functions["server:sendMessage"](thePlayer, "Você já atingiu o maximo de slots permitidos!", "error")
                    end
                end
            else
                useitem.functions["server:sendMessage"](thePlayer, "Esse item não pode ser usado!", "error")
            end
        else
            useitem.functions["server:sendMessage"](thePlayer, "Você não tem esse item!", "error")
        end
    else
        useitem.functions["server:sendMessage"](thePlayer, "Item inexistente!", "error")
    end
end
addEvent("TS:useItem", true)
addEventHandler("TS:useItem", root, useitem.functions["itens:use"])

useitem.functions["weapon:equip"] = function(thePlayer, itemID)
    local tab = config["Items"][tonumber(itemID)]
    local weaponID = tab.weaponID
    if not useitem.weaponsEquiped[thePlayer] then
        useitem.weaponsEquiped[thePlayer] = weaponID
        giveWeapon(thePlayer, weaponID, 1, true)
        triggerEvent("TS:takeItem", thePlayer, thePlayer, tonumber(itemID), tonumber(1))
        useitem.functions["server:sendMessage"](thePlayer, "Você equipou um(a) "..tab.nameItem.."!", "sucess")
    else
        useitem.functions["server:sendMessage"](thePlayer, "Você já tem uma arma equipada, digite /garmas antes!", "error")
    end
end

useitem.functions["weapon:take"] = function(thePlayer)
    if useitem.weaponsEquiped[thePlayer] then
        local weaponID = useitem.weaponsEquiped[thePlayer]
        local weaponSlot = getSlotFromWeapon ( weaponID )
        local Ammo = getPedTotalAmmo(thePlayer, weaponSlot)
        Ammo = Ammo-1
        local itemID = weaponsConfig[tonumber(weaponID)].itemID or 0
        if itemID then
            local muni = config["Items"][tonumber(itemID)].idAmmu 
            if verifyKGPlayer(thePlayer, tonumber(itemID), 1) and verifyKGPlayer(thePlayer, tonumber(muni), tonumber(Ammo)) then
                takeAllWeapons(thePlayer)
                if muni >= 1 then
                    triggerEvent("TS:addItem", thePlayer, thePlayer, tonumber(muni), tonumber(Ammo))
                end    
                triggerEvent("TS:addItem", thePlayer, thePlayer, tonumber(itemID), tonumber(1))
                useitem.functions["server:sendMessage"](thePlayer, "Arma guardada!", "sucess")
                useitem.weaponsEquiped[thePlayer] = nil
            end
        end
    end
end

addCommandHandler("garmas", function(thePlayer)
    useitem.functions["weapon:take"](thePlayer)
end)





addEventHandler("onPlayerQuit", root, function()
    useitem.functions["weapon:take"](source)
end)


function getTableGlobal()
    return config["Items"]
end 