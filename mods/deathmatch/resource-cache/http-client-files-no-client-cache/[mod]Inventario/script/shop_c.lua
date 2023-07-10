local screenW, screenH = guiGetScreenSize()
local x, y = (screenW/1920), (screenH/1080)

shops = {
    functions = {}
}

shops["state"] = false
shops["myItens"] = {}
shops["shopItens"] = {}
shops["buttons"] = {}
shops["Fonte 01"] = dxCreateFont("assets/files/fonts/arial.ttf", x*14)
shops["Fonte 02"] = dxCreateFont("assets/files/fonts/arial.ttf", x*12)
shops["Fonte 03"] = dxCreateFont("assets/files/fonts/arial.ttf", x*11)
shops["editbox"] = createElement("TS:EditBoxInv")

shops.functions["dx:Painel"] = function()
    exports["Blur"]:dxDrawBluredRectangle(screenW * 0.0000, screenH * 0.0000, screenW * 1.0000, screenH * 1.0000, tocolor(255, 255, 255, 255))
	local anim = interpolateBetween ( 0, 0, 0, 255, 0, 0, ((getTickCount()-tick)/1000), "Linear")
	if shops["myItens"] then
        usefull["dx:createImage"](150, 96, 34, 36, "assets/files/inventory/bag.png", 0, 0, 0, tocolor(255, 255, 255, anim), false)
		usefull["dx:createText"]("#FFFFFF"..shops["info"][1].." #a0305e#"..shops["info"][2], 189, 96, 343, 132, tocolor(255, 255, 255, anim), 1.00, shops["Fonte 01"], "left", "center", false, false, false, true, false)
        usefull["dx:createText"]("#FFFFFF"..shops["myItens"].info.mySlots.."/"..shops["myItens"].info.pesoSlots.."#a0305e kg", 637, 96, 791, 132, tocolor(255, 255, 255, anim), 1.00, shops["Fonte 01"], "right", "center", false, false, false, true, false)
        usefull["dx:createLine"](150, 136, 792, 136, tocolor(172, 58, 101, anim), 3, false)
        local posx, posy = 0, 0
        shops["buttons"] = {}
        for i=1, 30 do
            if usefull["dx:isCursorOnElement"](x*(posx+150), y*(posy+142), x*125, y*125) then
                usefull["dx:createRectangle"](posx+150, posy+142, 125, 125, tocolor(172, 58, 101, anim), false)
            else
                usefull["dx:createRectangle"](posx+150, posy+142, 125, 125, tocolor(0, 0, 0, interpolateBetween ( 0, 0, 0, 125, 0, 0, ((getTickCount()-tick)/1000), "Linear")), false)
            end
            if shops["myItens"] and shops["myItens"].itens then
                local item = shops.functions["itens:getItemFromSlot"](i, shops["myItens"].itens)
                if item and shops["myItens"].itens[item] then
                    local itemPeso, itemName, itemAmount = config["Items"][tonumber(item)].peso, config["Items"][tonumber(item)].nameItem, shops["myItens"].itens[item].quantidade
                    table.insert(shops["buttons"], {posx+150, posy+142, 125, 125, i, item})
                    usefull["dx:createImage"](posx+150+15, posy+142+15, 100, 100, "assets/files/itens/"..item..".png", 0, 0, 0, tocolor(255, 255, 255, anim), false)
                    usefull["dx:createText"](itemPeso, posx+150+0, posy+142+0, posx+150+39, posy+142+25, tocolor(255, 255, 255, anim), 1.00, shops["Fonte 02"], "center", "center", false, false, false, true, false)
                    usefull["dx:createImage"](posx+150+89, posy+142+0, 36, 22, "assets/files/inventory/circle.png", 0, 0, 0, tocolor(255, 255, 255, anim), false)
                    usefull["dx:createText"](itemAmount, posx+150+89, posy+142+0, posx+150+125, posy+142+22, tocolor(255, 255, 255, anim), 1.00, shops["Fonte 03"], "center", "center", false, false, false, true, false)
                    usefull["dx:createText"](itemName, posx+150+0, posy+142+103, posx+150+125, posy+142+125, tocolor(255, 255, 255, anim), 1.00, shops["Fonte 02"], "center", "center", false, false, false, true, false)
                else
                    table.insert(shops["buttons"], {posx+150, posy+142, 125, 125, i, nil})
                end
            else
                table.insert(shops["buttons"], {posx+150, posy+142, 125, 125, i, nil})
            end
            posx = posx+129
            if posx >= 645 then
                posx = 0
                posy = posy+130
            end
        end
        if shops["move_item"].state == true then
			local item = shops["move_item"].itemID
			local mx, my = getCursorPosition ()
			local fullx, fully = guiGetScreenSize ()
			local cursorx, cursory = mx*fullx, my*fully
			dxDrawRectangle(cursorx-50, cursory-50, x*125, y*125, tocolor(0, 0, 0, interpolateBetween ( 0, 0, 0, 125, 0, 0, ((getTickCount()-tick)/1000), "Linear")), true)
			dxDrawImage(cursorx-35, cursory-35, x*100, y*100, "assets/files/itens/"..item..".png", 0, 0, 0, tocolor(255, 255, 255, anim), true )
		end
		usefull["dx:createRectangle"](820, 475, 97, 96, tocolor(177, 57, 103, interpolateBetween ( 0, 0, 0, 200, 0, 0, ((getTickCount()-tick)/1000), "Linear")), true, tocolor(177, 57, 103, 255))
        if usefull["dx:isCursorOnElement"](x*820, y*475, x*97, y*96) then
			dxDrawEditBox("0", x*820, y*475, x*97, y*96, false, 9, shops["editbox"])
			usefull["dx:createText"]("Quantidade", 819, 550, 915, 568, tocolor(255, 255, 255, anim), 1.00, shops["Fonte 03"], "center", "center", false, false, true, true, false)
		else
			if getElementData(shops["editbox"], "state") == true then
				setElementData(shops["editbox"], "state", false)
			end
			usefull["dx:createImage"](820, 475, 97, 96, "assets/files/inventory/amount_icon.png", 0, 0, 0, tocolor(255, 255, 255, anim), true)
		end
    end
    usefull["dx:createImage"](150+795, 96, 42, 33, "assets/files/inventory/car.png", 0, 0, 0, tocolor(255, 255, 255, anim), false)
    usefull["dx:createText"]("#FFFFFF "..shops["shopItens"].name, 189+795, 96, 343+795, 132, tocolor(255, 255, 255, anim), 1.00, shops["Fonte 01"], "left", "center", false, false, false, true, false)
    usefull["dx:createLine"](150+795, 136, 792+795, 136, tocolor(172, 58, 101, anim), 3, false)

    local posx2, posy2 = 795, 0
    shops["buttons2"] = {}
        for i=1, 30 do
            if usefull["dx:isCursorOnElement"](x*(posx2+150), y*(posy2+142), x*125, y*125) then
                usefull["dx:createRectangle"](posx2+150, posy2+142, 125, 125, tocolor(172, 58, 101, anim), false)
            else
                usefull["dx:createRectangle"](posx2+150, posy2+142, 125, 125, tocolor(0, 0, 0, interpolateBetween ( 0, 0, 0, 125, 0, 0, ((getTickCount()-tick)/1000), "Linear")), false)
            end
            -- posx2+150+0, posy2+142+0, posx2+150+39, posy2+142+25
            if shops["shopItens"].itens and shops["shopItens"].itens[i] then
                local item = shops["shopItens"].itens[i][1]
                local price = shops["shopItens"].itens[i][2]
                local text = tonumber(getElementData(shops["editbox"], "text2") or 0) or 0
                if tonumber(text) >= 1 and type(text) == "number" then
                    price = price*text
                end
                local itemPeso, itemName = config["Items"][tonumber(item)].peso, config["Items"][tonumber(item)].nameItem
                table.insert(shops["buttons2"], {posx2+150, posy2+142, 125, 125, i, item, price})
                usefull["dx:createImage"](posx2+150+15, posy2+142+15, 100, 100, "assets/files/itens/"..item..".png", 0, 0, 0, tocolor(255, 255, 255, anim), false)
                usefull["dx:createImage"](posx2+150+89, posy2+142+0, 36, 22, "assets/files/inventory/circle.png", 0, 0, 0, tocolor(255, 255, 255, anim), false)
                usefull["dx:createText"](itemPeso, posx2+150+89, posy2+142+0, posx2+150+125, posy2+142+22, tocolor(255, 255, 255, anim), 1.00, shops["Fonte 03"], "center", "center", false, false, false, true, false)
                usefull["dx:createText"](" $"..price, posx2+150+0, posy2+142+0, posx2+150+39, posy2+142+25, tocolor(255, 255, 255, anim), 1.00, shops["Fonte 03"], "left", "center", false, false, false, true, false)
                usefull["dx:createText"](itemName, posx2+150+0, posy2+142+103, posx2+150+125, posy2+142+125, tocolor(255, 255, 255, anim), 1.00, shops["Fonte 02"], "center", "center", false, false, false, true, false)
            else
                table.insert(shops["buttons2"], {posx2+150, posy2+142, 125, 125, i, nil})
            end
            posx2 = posx2+129
            if posx2 >= 1332 then
                posx2 = 795
                posy2 = posy2+130
            end
        end
end

shops.functions["dx:Open"] = function(myItens, shopItens)
    if inventory["state"] == false then
        if shops["state"] == false then
            shops["move_item"] = {
                state = false,
                itemID = nil,
                slot = nil,
            }
            --showChat( false )
            setElementData(shops["editbox"], "text2", "")
            shops["info"] = {getPlayerName(localPlayer), getElementData(localPlayer, "ID") or "0"}
            tick = getTickCount()
            shops["state"] = true
            shops["myItens"] = myItens
            shops["shopItens"] = shopItens
            showCursor( true )
            addEventHandler("onClientRender", root, shops.functions["dx:Painel"])
        end
    end
end
addEvent("TS:openShop", true)
addEventHandler("TS:openShop", root, shops.functions["dx:Open"])

shops.functions["dx:Clicks"] = function(button,state)
	if shops["state"] == true then
		if state == "down" then
            for i, v in ipairs(shops["buttons"]) do
                if usefull["dx:isCursorOnElement"] ( x*v[1], y*v[2], x*v[3], y*v[4] ) then
                    if button == "right" then --- esquerda
                        if shops["move_item"].state == true then
                            local item = shops["move_item"].itemID
                            local price = shops["move_item"].price
                            local text = tonumber(getElementData(shops["editbox"], "text2") or 0) or 0
                            if tonumber(text) >= 1 and type(text) == "number" then
                                triggerServerEvent("TS:buyShop", localPlayer, localPlayer, item, price*text, text)
                            else
                                triggerEvent("serverNotifys2", localPlayer, "Quantidade inválida!", "error")
                            end
                        end
					end
				end
			end
            for i, v in ipairs(shops["buttons2"]) do
                if usefull["dx:isCursorOnElement"] ( x*v[1], y*v[2], x*v[3], y*v[4] ) then
                    if button == "right" then --- esquerda
                        if shops["move_item"].state == true then
                            shops["move_item"] = {
                                state = false,
                                itemID = nil,
                                slot = nil,
                            }           
                        elseif v[6] then
                            shops["move_item"] = {
                                state = true,
                                itemID = v[6],
                                slot = v[5],
                                price = v[7],
                            }
                        end
					end
				end
			end
		end
	end
end
addEventHandler ("onClientClick", root, shops.functions["dx:Clicks"] )

addEvent("TS:atualizeInv", true)
addEventHandler("TS:atualizeInv", root, function(data)
	shops["myItens"] = data
end)


addEventHandler("onClientKey", root, function(button, press)
    if button == "backspace" and ( press ) then
        if shops["state"] == true and getElementData(shops["editbox"], "state") == false then
            --showChat( true )
            showCursor( false )
            shops["myItens"] = {}
            shops["shopItens"] = {}
            removeEventHandler("onClientRender", root, shops.functions["dx:Painel"])
            shops["state"] = false
        end
    end
end)

shops.functions["itens:getItemFromSlot"] = function(slot, table)
	local itemID = false
	for i, v in pairs(table) do
		if v.slot == slot then
			itemID = i
			break
		end
	end
	return itemID
end