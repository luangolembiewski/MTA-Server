local screenW, screenH = guiGetScreenSize()
local x, y = (screenW/1920), (screenH/1080)

inventory = {}
inventory["state"] = false
inventory["move"] = 0
inventory["selected"] = {}
inventory["move_item"] = {
	state = false,
	itemID = false,
	slot = false,
}
inventory["renderTarget"] = dxCreateRenderTarget(641, 815, true)

inventory["dx:Inventory"] = function()
	exports["Blur"]:dxDrawBluredRectangle(screenW * 0.0000, screenH * 0.0000, screenW * 1.0000, screenH * 1.0000, tocolor(255, 255, 255, 255))
	local anim = interpolateBetween ( 0, 0, 0, 255, 0, 0, ((getTickCount()-tick)/1000), "Linear")
	if inventory["data"] then
		usefull["dx:createImage"](150, 96, 34, 36, "assets/files/inventory/bag.png", 0, 0, 0, tocolor(255, 255, 255, anim), false)
		usefull["dx:createText"]("#FFFFFF"..inventory["info"][1].." #a0305e#"..inventory["info"][2], 189, 96, 343, 132, tocolor(255, 255, 255, anim), 1.00, inventory["Fonte 01"], "left", "center", false, false, false, true, false)
		usefull["dx:createText"]("#FFFFFF"..inventory["data"].info.mySlots.."/"..inventory["data"].info.pesoSlots.."#a0305e kg", 637, 96, 791, 132, tocolor(255, 255, 255, anim), 1.00, inventory["Fonte 01"], "right", "center", false, false, false, true, false)
		usefull["dx:createLine"](150, 136, 792, 136, tocolor(1, 19, 154, anim), 3, false)
		dxSetRenderTarget(inventory["renderTarget"], true)
			local posx, posy = 0, 0
			inventory["buttons"] = {}
			for i=1, 80 do
				if usefull["dx:isCursorOnElement"](x*(posx+150), y*(inventory["move"]+posy+142), x*125, y*125) or inventory["selected"][1] == i then
					dxDrawRectangle(posx, inventory["move"]+posy, 125, 125, tocolor(1, 19, 154, anim), false)
				else
					dxDrawRectangle(posx, inventory["move"]+posy, 125, 125, tocolor(0, 0, 0, interpolateBetween ( 0, 0, 0, 125, 0, 0, ((getTickCount()-tick)/1000), "Linear")), false)
				end
				if inventory["data"] and inventory["data"].itens then
					local item = inventory["itens:getItemFromSlot"](i, inventory["data"].itens)
					if item and inventory["data"].itens[item] then
						table.insert(inventory["buttons"], {posx+150, inventory["move"]+posy+142, 125, 125, i, item})
						local itemPeso, itemName, itemAmount = config["Items"][tonumber(item)].peso, config["Items"][tonumber(item)].nameItem, inventory["data"].itens[item].quantidade
						dxDrawImage(posx+15, inventory["move"]+posy+15, 100, 100, "assets/files/itens/"..item..".png", 0, 0, 0, tocolor(255, 255, 255, anim), false)
						dxDrawText(itemPeso, posx+0, inventory["move"]+posy+0, posx+39, inventory["move"]+posy+25, tocolor(255, 255, 255, anim), 1.00, inventory["Fonte 02"], "center", "center", false, false, false, true, false)
						dxDrawImage(posx+89, inventory["move"]+posy+0, 36, 22, "assets/files/inventory/circle.png", 0, 0, 0, tocolor(255, 255, 255, anim), false)
						dxDrawText(itemAmount, posx+89, inventory["move"]+posy+0, posx+125, inventory["move"]+posy+22, tocolor(255, 255, 255, anim), 1.00, inventory["Fonte 03"], "center", "center", false, false, false, true, false)
						dxDrawText(itemName, posx+0, inventory["move"]+posy+103, posx+125, inventory["move"]+posy+125, tocolor(255, 255, 255, anim), 1.00, inventory["Fonte 02"], "center", "center", false, false, false, true, false)
					else
						table.insert(inventory["buttons"], {posx+150, inventory["move"]+posy+142, 125, 125, i, nil})	
					end
				else
					table.insert(inventory["buttons"], {posx+150, inventory["move"]+posy+142, 125, 125, i, nil})
				end
				posx = posx+129
				if posx >= 645 then
					posx = 0
					posy = posy+130
				end
			end
		dxSetRenderTarget(inventory["renderTarget"])
		if inventory["renderTarget"] then
			usefull["dx:createImage"](150, 141, 641, 815, inventory["renderTarget"], 0, 0, 0, tocolor(255, 255, 255, 255), true)
			if getKeyState("pgdn") then
				if inventory["move"] > -1005 then
					inventory["move"] = inventory["move"]-5
				end
			elseif getKeyState("pgup") then
				if inventory["move"] < 0 then
					inventory["move"] = inventory["move"]+5
				end
			end
		end
		usefull["dx:createRectangle"](820, 355, 97, 96, tocolor(1, 19, 154, interpolateBetween ( 0, 0, 0, 200, 0, 0, ((getTickCount()-tick)/1000), "Linear")), true, tocolor(1, 19, 154, 255))
		usefull["dx:createRectangle"](820, 455, 97, 96, tocolor(1, 19, 154, interpolateBetween ( 0, 0, 0, 200, 0, 0, ((getTickCount()-tick)/1000), "Linear")), true, tocolor(1, 19, 154, 255))
		usefull["dx:createRectangle"](820, 555, 97, 96, tocolor(1, 19, 154, interpolateBetween ( 0, 0, 0, 200, 0, 0, ((getTickCount()-tick)/1000), "Linear")), true, tocolor(1, 19, 154, 255))
		usefull["dx:createRectangle"](820, 655, 97, 96, tocolor(1, 19, 154, interpolateBetween ( 0, 0, 0, 200, 0, 0, ((getTickCount()-tick)/1000), "Linear")), true, tocolor(1, 19, 154, 255))
		if usefull["dx:isCursorOnElement"](x*820, y*355, x*97, y*96) then
			dxDrawEditBox("0", x*820, y*355, x*97, y*96, false, 9, inventory["editbox"])
			usefull["dx:createText"]("Quantidade", 819, 430, 915, 448, tocolor(255, 255, 255, anim), 1.00, inventory["Fonte 03"], "center", "center", false, false, true, true, false)
		else
			if getElementData(inventory["editbox"], "state") == true then
				setElementData(inventory["editbox"], "state", false)
			end
			usefull["dx:createImage"](820, 355, 97, 96, "assets/files/inventory/amount_icon.png", 0, 0, 0, tocolor(255, 255, 255, anim), true)
		end
		if usefull["dx:isCursorOnElement"](x*820, y*455, x*97, y*96) then
			usefull["dx:createText"]("Usar", 819, 532, 915, 550, tocolor(255, 255, 255, anim), 1.00, inventory["Fonte 02"], "center", "center", false, false, true, true, false)
		end
		usefull["dx:createImage"](820, 455, 97, 96, "assets/files/inventory/use_icon.png", 0, 0, 0, tocolor(255, 255, 255, anim), true)
		if usefull["dx:isCursorOnElement"](x*820, y*555, x*97, y*96) then
			usefull["dx:createText"]("Enviar", 819, 631, 915, 649, tocolor(255, 255, 255, anim), 1.00, inventory["Fonte 02"], "center", "center", false, false, true, true, false)
		end
		usefull["dx:createImage"](820, 555, 97, 96, "assets/files/inventory/send_icon.png", 0, 0, 0, tocolor(255, 255, 255, anim), true)
		if usefull["dx:isCursorOnElement"](x*820, y*655, x*97, y*96) then
			usefull["dx:createText"]("Dropar", 819, 732, 915, 750, tocolor(255, 255, 255, anim), 1.00, inventory["Fonte 02"], "center", "center", false, false, true, true, false)
		end
		usefull["dx:createImage"](820, 655, 97, 96, "assets/files/inventory/drop_icon.png", 0, 0, 0, tocolor(255, 255, 255, anim), true)
		if inventory["move_item"].state == true then
			local item = inventory["move_item"].itemID
			local itemPeso, itemName, itemAmount = config["Items"][tonumber(item)].peso, config["Items"][tonumber(item)].nameItem, inventory["data"].itens[item].quantidade
			local mx, my = getCursorPosition ()
			local fullx, fully = guiGetScreenSize ()
			local cursorx, cursory = mx*fullx, my*fully
			dxDrawRectangle(cursorx-50, cursory-50, x*125, y*125, tocolor(0, 0, 0, interpolateBetween ( 0, 0, 0, 125, 0, 0, ((getTickCount()-tick)/1000), "Linear")), true)
			dxDrawImage(cursorx-35, cursory-35, x*100, y*100, "assets/files/itens/"..item..".png", 0, 0, 0, tocolor(255, 255, 255, anim), true )
		end
	end
end

inventory["dx:Close"] = function()
	removeEventHandler ( "onClientRender", root, inventory["dx:Inventory"] )
	inventory["state"] = false
	showCursor ( false )
	--showChat( true )
	playSoundFrontEnd ( 43 )
	if isElement(inventory["Fonte 01"]) then
		destroyElement(inventory["Fonte 01"])
		inventory["Fonte 01"] = nil
	end
	if isElement(inventory["Fonte 02"]) then
		destroyElement(inventory["Fonte 02"])
		inventory["Fonte 02"] = nil
	end
	if isElement(inventory["Fonte 03"]) then
		destroyElement(inventory["Fonte 03"])
		inventory["Fonte 03"] = nil
	end
	if isElement(inventory["editbox"]) then
		destroyElement(inventory["editbox"])
		inventory["editbox"] = nil
	end
end

getInvState = function()
	return inventory["state"]
end

getItemInfo = function(itemID)
	return config["Items"][tonumber(itemID)]
end

inventory["dx:Open"] = function()
	if ( exports[config["Configuração"].bauName]:getBauState() or false ) == false then
		if shops["state"] == false then
			if inventory["state"] == false then
				inventory["selected"] = {}
				--showChat( false )
				tick = getTickCount()
				inventory["move"] = 0
				inventory["data"] = nil
				triggerServerEvent("TS:atualizeInv", localPlayer, localPlayer)
				inventory["info"] = {getPlayerName(localPlayer), getElementData(localPlayer, "ID") or "0"}
				inventory["Fonte 01"] = dxCreateFont("assets/files/fonts/arial.ttf", x*14)
				inventory["Fonte 02"] = dxCreateFont("assets/files/fonts/arial.ttf", x*12)
				inventory["Fonte 03"] = dxCreateFont("assets/files/fonts/arial.ttf", x*11)
				inventory["editbox"] = createElement("TS:EditBoxInv")
				addEventHandler ( "onClientRender", root, inventory["dx:Inventory"] )
				inventory["state"] = true
				showCursor ( true )
				playSoundFrontEnd ( 43 )
			end
		end
	end
end

--addEventHandler("onClientKey", root, function()
--	if inventory["state"] then
--		cancelEvent()
--	end
--end)

inventory["itens:getItemFromSlot"] = function(slot, table)
	local itemID = false
	for i, v in pairs(table) do
		if v.slot == slot then
			itemID = i
			break
		end
	end
	return itemID
end

--addEventHandler("onClientKey", root, function(button, press)

function setInventario(status)
	if status then
		bindKey("i","down",function()
			--if not isChatBoxInputActive() and not guiGetInputEnabled() then
				if inventory["state"] == true and inventory["editbox"] and getElementData(inventory["editbox"], "state") == false then
					inventory["dx:Close"]()
				elseif inventory["state"] == false then
					inventory["dx:Open"]()
				end
			--end
		end)
	else
		unbindKey("i","down")
	end
end
setInventario(true)

inventory["dx:Clicks"] = function(button,state)
	if inventory["state"] == true then
		if state == "down" then
			if usefull["dx:isCursorOnElement"] ( x*820, y*455, x*97, y*96 ) then
				if inventory["selected"][1] and inventory["selected"][2] then
					local text = tonumber(getElementData(inventory["editbox"], "text2") or 0) or 0
					if tonumber(text) >= 1 and type(text) == "number" then
						triggerServerEvent("TS:useItem", localPlayer, localPlayer, inventory["selected"][2], tonumber(text))
						inventory["selected"] = {}
					else
						text=1
						triggerServerEvent("TS:useItem", localPlayer, localPlayer, inventory["selected"][2], tonumber(text))
						inventory["selected"] = {}
					end
				else
					triggerEvent("serverNotifys2", localPlayer, "Você não selecionou um item!", "error")
				end
			elseif usefull["dx:isCursorOnElement"] ( x*820, y*555, x*97, y*96 ) then
				if inventory["selected"][1] and inventory["selected"][2] then
					local text = tonumber(getElementData(inventory["editbox"], "text2") or 0) or 0
					if tonumber(text) >= 1 and type(text) == "number" then
						triggerServerEvent("TS:sendItem", localPlayer, localPlayer, inventory["selected"][2], tonumber(text))
						inventory["selected"] = {}
					else
						text=1
						triggerServerEvent("TS:sendItem", localPlayer, localPlayer, inventory["selected"][2], tonumber(text))
						inventory["selected"] = {}
					end
				else
					triggerEvent("serverNotifys2", localPlayer, "Você não selecionou um item!", "error")
				end
			elseif usefull["dx:isCursorOnElement"] ( x*820, y*655, x*97, y*96 ) then
				if inventory["selected"][1] and inventory["selected"][2] then
					local text = tonumber(getElementData(inventory["editbox"], "text2") or 0) or 0
					if tonumber(text) >= 1 and type(text) == "number" then
						triggerServerEvent("TS:dropItem", localPlayer, localPlayer, inventory["selected"][2], tonumber(text))
						inventory["selected"] = {}
					else
						text=1
						triggerServerEvent("TS:dropItem", localPlayer, localPlayer, inventory["selected"][2], tonumber(text))
						inventory["selected"] = {}
					end
				else
					triggerEvent("serverNotifys2", localPlayer, "Você não selecionou um item!", "error")
				end
			else
				for i, v in ipairs(inventory["buttons"]) do
					if usefull["dx:isCursorOnElement"] ( x*v[1], y*v[2], x*v[3], y*v[4] ) then
						if button == "left" then --- esquerda
							if inventory["move_item"].state == true then
								local slotNew = v[5]
								local slotAntigo = inventory["move_item"].slot
								if slotNew ~= slotAntigo then
									inventory["selected"] = {}
									if v[6] then
										inventory["data"].itens[v[6]].slot = slotAntigo
										inventory["data"].itens[inventory["move_item"].itemID].slot = slotNew
									else
										inventory["data"].itens[inventory["move_item"].itemID].slot = slotNew
									end
								end
								inventory["move_item"].state = false
								triggerServerEvent("TS:atualizeData", localPlayer, localPlayer, inventory["data"])
							elseif v[6] then
								inventory["selected"] = {}
								inventory["move_item"] = {
									state = true,
									itemID = v[6],
									slot = v[5],
								}
							end
						elseif button == "right" and v[6] then --- direita
							if inventory["selected"][1] == v[5] then
								inventory["selected"] = {}
							else
								inventory["selected"] = {v[5], v[6]}
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler ("onClientClick", root, inventory["dx:Clicks"] )

addEvent("TS:atualizeInv", true)
addEventHandler("TS:atualizeInv", root, function(data)
	inventory["data"] = data
end)

addEventHandler('onClientPlayerWeaponFire',getLocalPlayer() ,function(weapon,ammo,inClip,hitX, hitY, hitZ, hitElement) 
    if(weapon > 15 and weapon < 19) or weapon == 39 or weapon == 22 then 
		return  
	end
    if(ammo == 1) then 
		toggleControl('fire',false) 
	end 
end) 
  
addEventHandler('onClientPlayerWeaponSwitch',getLocalPlayer(),function(prevSlot,currSlot) 
	local weap = getPedWeapon(getLocalPlayer(), currSlot)
    if(weap >= 0 and weap <= 9 or weap == 46) then
        toggleControl('fire',true)
        return
    end
    if(getPedTotalAmmo(getLocalPlayer(), prevSlot) == 1) then 
        toggleControl('fire',true) 
    end 
    if(getPedTotalAmmo(getLocalPlayer(), currSlot) == 1) then 
        toggleControl('fire',false) 
    end 
end) 
