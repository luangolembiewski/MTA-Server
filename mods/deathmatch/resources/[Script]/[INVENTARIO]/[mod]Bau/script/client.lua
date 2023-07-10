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

local screenW, screenH = guiGetScreenSize()
local x, y = (screenW/1920), (screenH/1080)

bau = {
    functions = {}
}

bau["state"] = false
bau["myItens"] = {}
bau["shopItens"] = {}
bau["buttons"] = {}
bau["Fonte 01"] = dxCreateFont("assets/files/fonts/arial.ttf", x*14)
bau["Fonte 02"] = dxCreateFont("assets/files/fonts/arial.ttf", x*12)
bau["Fonte 03"] = dxCreateFont("assets/files/fonts/arial.ttf", x*11)
bau["editbox"] = createElement("TS:EditBoxBau")

bau.functions["dx:Painel"] = function()
    exports["Blur"]:dxDrawBluredRectangle(screenW * 0.0000, screenH * 0.0000, screenW * 1.0000, screenH * 1.0000, tocolor(255, 255, 255, 255))
	local anim = interpolateBetween ( 0, 0, 0, 255, 0, 0, ((getTickCount()-tick)/1000), "Linear")
	if bau["myItens"] then
        usefull["dx:createImage"](150, 96, 34, 36, "assets/files/inventory/bag.png", 0, 0, 0, tocolor(255, 255, 255, anim), false)
		usefull["dx:createText"]("#FFFFFF"..bau["info"][1].." #a0305e#"..bau["info"][2], 189, 96, 343, 132, tocolor(255, 255, 255, anim), 1.00, bau["Fonte 01"], "left", "center", false, false, false, true, false)
        usefull["dx:createText"]("#FFFFFF"..math.round(bau["myItens"].info.mySlots, 3, "ceil").."/"..math.round(bau["myItens"].info.pesoSlots, 3, "floor").."#a0305e kg", 637, 96, 791, 132, tocolor(255, 255, 255, anim), 1.00, bau["Fonte 01"], "right", "center", false, false, false, true, false)
        usefull["dx:createLine"](150, 136, 792, 136, tocolor(172, 58, 101, anim), 3, false)
        local posx, posy = 0, 0
        bau["buttons"] = {}
        for i=1, 30 do
            if usefull["dx:isCursorOnElement"](x*(posx+150), y*(posy+142), x*125, y*125) then
                usefull["dx:createRectangle"](posx+150, posy+142, 125, 125, tocolor(172, 58, 101, anim), false)
            else
                usefull["dx:createRectangle"](posx+150, posy+142, 125, 125, tocolor(0, 0, 0, interpolateBetween ( 0, 0, 0, 125, 0, 0, ((getTickCount()-tick)/1000), "Linear")), false)
            end
            if bau["myItens"] and bau["myItens"].itens then
                local item = bau.functions["itens:getItemFromSlot"](i, bau["myItens"].itens)
                if item and bau["myItens"].itens[item] then
					local tab = exports[config["Configurações"].inventoryName]:getItemInfo(item)
                    local itemPeso, itemName, itemAmount = tab.peso, tab.nameItem, bau["myItens"].itens[item].quantidade
                    table.insert(bau["buttons"], {posx+150, posy+142, 125, 125, i, item})
                    usefull["dx:createImage"](posx+150+15, posy+142+15, 100, 100, ":"..config["Configurações"].inventoryName.."/assets/files/itens/"..item..".png", 0, 0, 0, tocolor(255, 255, 255, anim), false)
                    usefull["dx:createText"](itemPeso, posx+150+0, posy+142+0, posx+150+39, posy+142+25, tocolor(255, 255, 255, anim), 1.00, bau["Fonte 02"], "center", "center", false, false, false, true, false)
                    usefull["dx:createImage"](posx+150+89, posy+142+0, 36, 22, "assets/files/inventory/circle.png", 0, 0, 0, tocolor(255, 255, 255, anim), false)
                    usefull["dx:createText"](itemAmount, posx+150+89, posy+142+0, posx+150+125, posy+142+22, tocolor(255, 255, 255, anim), 1.00, bau["Fonte 03"], "center", "center", false, false, false, true, false)
                    usefull["dx:createText"](itemName, posx+150+0, posy+142+103, posx+150+125, posy+142+125, tocolor(255, 255, 255, anim), 1.00, bau["Fonte 02"], "center", "center", false, false, false, true, false)
                else
                    table.insert(bau["buttons"], {posx+150, posy+142, 125, 125, i, nil})
                end
            else
                table.insert(bau["buttons"], {posx+150, posy+142, 125, 125, i, nil})
            end
            posx = posx+129
            if posx >= 645 then
                posx = 0
                posy = posy+130
            end
        end
        if bau["move_item"].state == true then
			local item = bau["move_item"].itemID
			local mx, my = getCursorPosition ()
			local fullx, fully = guiGetScreenSize ()
			local cursorx, cursory = mx*fullx, my*fully
			dxDrawRectangle(cursorx-50, cursory-50, x*125, y*125, tocolor(0, 0, 0, interpolateBetween ( 0, 0, 0, 125, 0, 0, ((getTickCount()-tick)/1000), "Linear")), true)
			dxDrawImage(cursorx-35, cursory-35, x*100, y*100, ":"..config["Configurações"].inventoryName.."/assets/files/itens/"..item..".png", 0, 0, 0, tocolor(255, 255, 255, anim), true )
		end
		usefull["dx:createRectangle"](820, 475, 97, 96, tocolor(177, 57, 103, interpolateBetween ( 0, 0, 0, 200, 0, 0, ((getTickCount()-tick)/1000), "Linear")), true, tocolor(177, 57, 103, 255))
        if usefull["dx:isCursorOnElement"](x*820, y*475, x*97, y*96) then
			dxDrawEditBox("0", x*820, y*475, x*97, y*96, false, 9, bau["editbox"])
			usefull["dx:createText"]("Quantidade", 819, 550, 915, 568, tocolor(255, 255, 255, anim), 1.00, bau["Fonte 03"], "center", "center", false, false, true, true, false)
		else
			if getElementData(bau["editbox"], "state") == true then
				setElementData(bau["editbox"], "state", false)
			end
			usefull["dx:createImage"](820, 475, 97, 96, ":"..config["Configurações"].inventoryName.."/assets/files/inventory/amount_icon.png", 0, 0, 0, tocolor(255, 255, 255, anim), true)
		end
    end
    usefull["dx:createImage"](150+795, 96, 42, 33, "assets/files/inventory/car.png", 0, 0, 0, tocolor(255, 255, 255, anim), false)
    usefull["dx:createText"]("#FFFFFF "..bau["info"][3], 189+795, 96, 343+795, 132, tocolor(255, 255, 255, anim), 1.00, bau["Fonte 01"], "left", "center", false, false, false, true, false)
    usefull["dx:createLine"](150+795, 136, 792+795, 136, tocolor(172, 58, 101, anim), 3, false)

    local posx2, posy2 = 795, 0
    bau["buttons2"] = {}
        for i=1, 30 do
            if usefull["dx:isCursorOnElement"](x*(posx2+150), y*(posy2+142), x*125, y*125) then
                usefull["dx:createRectangle"](posx2+150, posy2+142, 125, 125, tocolor(172, 58, 101, anim), false)
            else
                usefull["dx:createRectangle"](posx2+150, posy2+142, 125, 125, tocolor(0, 0, 0, interpolateBetween ( 0, 0, 0, 125, 0, 0, ((getTickCount()-tick)/1000), "Linear")), false)
            end
            if bau["shopItens"] then
				local item = bau.functions["itens:getItemFromSlot"](i, bau["shopItens"])
				if item and bau["shopItens"][item] then
					local text = tonumber(getElementData(bau["editbox"], "text2") or 0) or 0
					local tab = exports[config["Configurações"].inventoryName]:getItemInfo(item)
					local itemPeso, itemName = tab.peso, tab.nameItem
					table.insert(bau["buttons2"], {posx2+150, posy2+142, 125, 125, i, item, price})
					usefull["dx:createImage"](posx2+150+15, posy2+142+15, 100, 100, ":"..config["Configurações"].inventoryName.."/assets/files/itens/"..item..".png", 0, 0, 0, tocolor(255, 255, 255, anim), false)
					usefull["dx:createImage"](posx2+150+89, posy2+142+0, 36, 22, "assets/files/inventory/circle.png", 0, 0, 0, tocolor(255, 255, 255, anim), false)
					usefull["dx:createText"](bau["shopItens"][item].quantidade, posx2+150+89, posy2+142+0, posx2+150+125, posy2+142+22, tocolor(255, 255, 255, anim), 1.00, bau["Fonte 03"], "center", "center", false, false, false, true, false)
					usefull["dx:createText"](itemPeso, posx2+150+0, posy2+142+0, posx2+150+39, posy2+142+25, tocolor(255, 255, 255, anim), 1.00, bau["Fonte 02"], "center", "center", false, false, false, true, false)
					usefull["dx:createText"](itemName, posx2+150+0, posy2+142+103, posx2+150+125, posy2+142+125, tocolor(255, 255, 255, anim), 1.00, bau["Fonte 02"], "center", "center", false, false, false, true, false)
				else
					table.insert(bau["buttons2"], {posx2+150, posy2+142, 125, 125, i, nil})
				end    
			else
                table.insert(bau["buttons2"], {posx2+150, posy2+142, 125, 125, i, nil})
            end
            posx2 = posx2+129
            if posx2 >= 1332 then
                posx2 = 795
                posy2 = posy2+130
            end
        end
end

getBauState = function()
    return bau["state"]
end

bau.functions["dx:Open"] = function(myItens, name, shopItens)
    if exports[config["Configurações"].inventoryName]:getInvState() == false then
        if bau["state"] == false then
            bau["move_item"] = {
                state = false,
                itemID = nil,
                slot = nil,
            }
            --showChat( false )
            setElementData(bau["editbox"], "text2", "")
            bau["info"] = {getPlayerName(localPlayer), getElementData(localPlayer, "ID") or "0", name}
            tick = getTickCount()
            bau["state"] = true
            bau["myItens"] = myItens
            bau["shopItens"] = shopItens
            showCursor( true )
            addEventHandler("onClientRender", root, bau.functions["dx:Painel"])
        end 
    else
        triggerServerEvent("TS:closeBau", localPlayer, localPlayer)
    end
end
addEvent("TS:openBau", true)
addEventHandler("TS:openBau", root, bau.functions["dx:Open"])

bau.functions["dx:Clicks"] = function(button,state)
	if bau["state"] == true then
		if state == "down" then
            for i, v in ipairs(bau["buttons"]) do
                if usefull["dx:isCursorOnElement"] ( x*v[1], y*v[2], x*v[3], y*v[4] ) then
                    if button == "right" then --- esquerda
                        if bau["move_item"].state == true and bau["move_item"].type == "bau" then
                            local item = bau["move_item"].itemID
                            local text = tonumber(getElementData(bau["editbox"], "text2") or 0) or 0
                            if tonumber(text) >= 1 and type(text) == "number" then
                                triggerServerEvent("TS:removeItem", localPlayer, localPlayer, bau["info"][3], item, text)
                            else
                                triggerEvent("serverNotifys2", localPlayer, "Quantidade inválida!", "error")
                            end
							bau["move_item"] = {
                                state = false,
                                itemID = nil,
                                slot = nil,
                            }      
						elseif bau["move_item"].state == true and bau["move_item"].type == "inv" then
							bau["move_item"] = {
                                state = false,
                                itemID = nil,
                                slot = nil,
                            }    
						elseif v[6] then
							bau["move_item"] = {
                                state = true,
                                itemID = v[6],
                                slot = v[5],
                                price = v[7],
								type = "inv",
                            }
                        end
					end
				end
			end
            for i, v in ipairs(bau["buttons2"]) do
                if usefull["dx:isCursorOnElement"] ( x*v[1], y*v[2], x*v[3], y*v[4] ) then
                    if button == "right" then --- esquerda
                        if bau["move_item"].state == true and bau["move_item"].type == "inv" then
							local item = bau["move_item"].itemID
                            local text = tonumber(getElementData(bau["editbox"], "text2") or 0) or 0
                            if tonumber(text) >= 1 and type(text) == "number" then
                                triggerServerEvent("TS:saveItem", localPlayer, localPlayer, bau["info"][3], item, text)
                            else
                                triggerEvent("serverNotifys2", localPlayer, "Quantidade inválida!", "error")
                            end
                            bau["move_item"] = {
                                state = false,
                                itemID = nil,
                                slot = nil,
                            }           
						elseif bau["move_item"].state == true and bau["move_item"].type == "bau" then
							bau["move_item"] = {
                                state = false,
                                itemID = nil,
                                slot = nil,
                            }    
                        elseif v[6] then
                            bau["move_item"] = {
                                state = true,
                                itemID = v[6],
                                slot = v[5],
                                price = v[7],
								type = "bau",
                            }
                        end
					end
				end
			end
		end
	end
end
addEventHandler ("onClientClick", root, bau.functions["dx:Clicks"] )

addEvent("TS:atualizeInv", true)
addEventHandler("TS:atualizeInv", root, function(data)
	bau["myItens"] = data
end)

addEvent("TS:atualizeBau", true)
addEventHandler("TS:atualizeBau", root, function(data)
	bau["shopItens"] = data
end)



addEventHandler("onClientKey", root, function(button, press)
    if button == "backspace" and ( press ) then
        if bau["state"] == true and getElementData(bau["editbox"], "state") == false then
            --showChat( true )
            showCursor( false )
            bau["myItens"] = {}
            bau["shopItens"] = {}
            removeEventHandler("onClientRender", root, bau.functions["dx:Painel"])
            bau["state"] = false
            triggerServerEvent("TS:closeBau", localPlayer, localPlayer)
        end
    end
end)

bau.functions["itens:getItemFromSlot"] = function(slot, table)
	local itemID = false
	for i, v in pairs(table) do
		if v.slot == slot then
			itemID = i
			break
		end
	end
	return itemID
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end