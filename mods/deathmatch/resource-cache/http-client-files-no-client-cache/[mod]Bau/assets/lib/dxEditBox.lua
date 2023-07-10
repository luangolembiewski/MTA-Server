local sx, sy = guiGetScreenSize()
local font = dxCreateFont("assets/files/fonts/arial.ttf", 12, false, "proof")

function dxDrawEditBox(text, x, y, w, h, password, maxCharacter, element)
	local getText = getElementData(element, "text2") or setElementData(element, "text2", "")
	local state = getElementData(element, "state") or setElementData(element, "state", false)
	local character = getElementData(element, "maximum") or setElementData(element, "maximum", maxCharacter)
	--drawBorde(x, y, w, h, tocolor(11, 11, 11, 200), false)
	if (#getElementData(element, "text2") == 0) then
		dxDrawText(text, x + 5, y, x + w - 10, y + h, tocolor(255, 255, 255, 255), 1, font, "center", "center", true, false, true)
	end
	if (dxGetTextWidth(password and string.gsub(getElementData(element, "text2"), ".", "•") or getElementData(element, "text2"), 1, font) <= w - 10) then
		dxDrawText(password and string.gsub(getElementData(element, "text2"), ".", "•") or getElementData(element, "text2"), x + 5, y, x + w - 10, y + h, tocolor(255, 255, 255, 255), 1, font, "center", "center", true, false, true)
	else
		dxDrawText(password and string.gsub(getElementData(element, "text2"), ".", "•") or getElementData(element, "text2"), x + 5, y, x + w - 10, y + h, tocolor(255, 255, 255, 255), 1, font, "center", "center", true, false, true)
	end
	if (getElementData(element, "state") == true) then
		if (dxGetTextWidth(password and string.gsub(getElementData(element, "text2"), ".", "•") or getElementData(element, "text2"), 1, font) <= w - 10) then
			--dxDrawLine(x + 5 + dxGetTextWidth(password and string.gsub(getElementData(element, "text2"), ".", "•") or getElementData(element, "text2"), 1, font), y + 5, x + 5 + dxGetTextWidth(password and string.gsub(getElementData(element, "text2"), ".", "•") or getElementData(element, "text2"), 1, font), y + h - 5, tocolor(255, 255, 255, math.abs(math.sin(getTickCount() / 255) * 255)), 1, true)
		else
			--dxDrawLine(x + w - 10, y + 5, x + w - 10, y + h - 5, tocolor(255, 255, 255, math.abs(math.sin(getTickCount() / 255) * 255)), 1, true)
		end
	end
	if (isCursorOnElement(x, y, w, h)) then
		setElementData(element, "mouseState", "hovered")
	else
		setElementData(element, "mouseState", "normal")
	end
end

function dxClickElement(button, state, cx, cy)
	if (button == "left") and (state == "down") then
		local buttonId = false
		for id, element in ipairs(getElementsByType("dxButton")) do
			if (getElementData(element, "mouseState") == "hovered") then
				buttonId = id
			end
		end
		if (buttonId) then
			if (isElement(getElementsByType("dxButton")[buttonId])) then
				setElementData(getElementsByType("dxButton")[buttonId], "mouseState", "clicked")
				triggerEvent("onClickButton", getElementsByType("dxButton")[buttonId])
			end
		end
	end
	if (button == "left") and (state == "down") then
		local editBoxId = false
		for id, element in ipairs(getElementsByType("TS:EditBoxBau")) do
			if (getElementData(element, "mouseState") == "hovered") then
				editBoxId = id
			elseif (getElementData(element, "mouseState") == "normal") then
				if (getElementData(element, "state") == true) then
					--guiSetInputMode("allow_binds")
					setElementData(element, "state", false)
				end
			end
		end
		if (editBoxId) then
			if (isElement(getElementsByType("TS:EditBoxBau")[editBoxId])) then
				if (getElementData(getElementsByType("TS:EditBoxBau")[editBoxId], "state") == false) then
					--guiSetInputMode("no_binds")
					setElementData(getElementsByType("TS:EditBoxBau")[editBoxId], "state", true)
				end
			end
		end
	end
	if (button == "left") and (state == "down") then
		local checkBoxId = false
		for id, element in ipairs(getElementsByType("dxCheckBox")) do
			if (getElementData(element, "mouseState") == "hovered") then
				checkBoxId = id
			end
		end
		if (checkBoxId) then
			if (isElement(getElementsByType("dxCheckBox")[checkBoxId])) then
				if (getElementData(getElementsByType("dxCheckBox")[checkBoxId], "state") == true) then
					setElementData(getElementsByType("dxCheckBox")[checkBoxId], "state", false)
				else
					setElementData(getElementsByType("dxCheckBox")[checkBoxId], "state", true)
				end
			end
		end
	end
	if (button == "left") then
		for _, element in ipairs(getElementsByType("dxGridList")) do
			if (getElementData(element, "mouseState") == "hovered") then
				local barCount = getElementData(element, "barCount")
				local barList = getElementData(element, "barList")
				if (#barList > barCount) then
					local x = getElementData(element, "x")
					local y = getElementData(element, "y")
					local w = getElementData(element, "w")
					local h = getElementData(element, "h")
					local scrollOffset = getElementData(element, "scrollOffset")
					local scrollY = getElementData(element, "scrollY")
					local scrollSpace = #barList > barCount and 11 or 0
					local size = barCount / #barList
					local scrollList = scrollOffset / #barList
					if (state == "down") then
						if (cx >= x + w - scrollSpace) and (cx <= x + w - scrollSpace + 3) and (cy >= y + scrollList * h) and (cy <= y + scrollList * h + size * h) then
							setElementData(element, "scrollAlpha", 255)
							setElementData(element, "scrollAttached", true)
							local mouseOffset = y + scrollY * (1 - size) * h
							setElementData(element, "scrollAttachedOffset", cy - mouseOffset)
						end
					end
				end
				if (state == "up") and not (getElementData(element, "scrollAttached")) then
					setElementData(element, "selected", {getElementData(element, "barAttached")[1], getElementData(element, "barAttached")[2] or ""})
					triggerEvent("loginClick", element)
				end
			end
			if (state == "up") then
				setElementData(element, "scrollAttached", false)
				setElementData(element, "scrollAlpha", 150)
			end
		end
	end
end
addEventHandler("onClientClick", getRootElement(), dxClickElement)

function dxCharacterElement(button)
	if (isChatBoxInputActive()) or (isConsoleActive()) or (isMainMenuActive()) then
		return
	end
	for _, element in ipairs(getElementsByType("TS:EditBoxBau")) do
		if (getElementData(element, "state") == true) then
			if (#getElementData(element, "text2") < getElementData(element, "maximum")) then
				setElementData(element, "text2", getElementData(element, "text2")..button)
			end
		end
	end
end
addEventHandler("onClientCharacter", getRootElement(), dxCharacterElement)

function dxKeyElement(button, press)
	if (isChatBoxInputActive()) or (isConsoleActive()) or (isMainMenuActive()) then
		return
	end
	if (press) and (button == "backspace") then
		for _, element in ipairs(getElementsByType("TS:EditBoxBau")) do
			if (getElementData(element, "state") == true) then
				if (#getElementData(element, "text2") > 0) then
					setElementData(element, "text2", string.sub(getElementData(element, "text2"), 1, #getElementData(element, "text2") - 1))
				end
			end
		end
	end
end
addEventHandler("onClientKey", getRootElement(), dxKeyElement)

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
	if 
		type( sEventName ) == 'string' and 
		isElement( pElementAttachedTo ) and 
		type( func ) == 'function' 
	then
		local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
		if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
			for i, v in ipairs( aAttachedFunctions ) do
				if v == func then
					return true
				end
			end
		end
	end

	return false
end

function isCursorOnElement ( x, y, w, h )
	local mx, my = getCursorPosition ()
	 local fullx, fully = guiGetScreenSize ()
	  cursorx, cursory = mx*fullx, my*fully
	   if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
		return true
	   else
	  return false
	 end
	end