local player = getLocalPlayer()

addEvent(":openCoords",true)
addEventHandler(":openCoords",root,function()
	--Window
	win = guiCreateWindow(317, 256, 494, 281, "PAINEL DE COORDENADAS", false)
	guiWindowSetSizable(win, false)
	tabpanel = guiCreateTabPanel(9, 19, 475, 252, false, win)

	--Coordenada Tab
	tabCoord = guiCreateTab("Coordenadas", tabpanel)
	memo = guiCreateEdit(51, 66, 317, 43, "", false, tabCoord)
	Label = guiCreateLabel(44, 33, 326, 39, "Coordenadas:", false, tabCoord)
	guiSetFont(Label, "default-bold-small")
	buttonClose = guiCreateButton(408, 197, 57, 20, "Fechar", false, tabCoord)
	guiSetProperty(buttonClose, "NormalTextColour", "FFAAAAAA")
	buttonCopy = guiCreateButton(240, 119, 98, 38, "Copiar", false, tabCoord)
	guiSetProperty(buttonCopy, "NormalTextColour", "FFAAAAAA")
	buttonClear = guiCreateButton(72, 119, 98, 38, "Limpar", false, tabCoord)
	guiSetProperty(buttonClear, "NormalTextColour", "FFAAAAAA")
	buttonGetPos = guiCreateButton(342, 4, 123, 48, "Obter Coordenadas", false, tabCoord)
	guiSetProperty(buttonGetPos, "NormalTextColour", "FFAAAAAA")
	checkbox = guiCreateCheckBox(10, 196, 197, 15, "Arredondar Milésimos", false, false, tabCoord)

	--Rotação Tab
	tabRot = guiCreateTab("Rotação", tabpanel)
	memoTwo = guiCreateEdit(51, 66, 317, 43, "", false, tabRot)
	guiEditSetReadOnly(memoTwo, true)
	buttonGetRot = guiCreateButton(340, 4, 123, 48, "Obter Rotação", false, tabRot)
	guiSetProperty(buttonGetRot, "NormalTextColour", "FFAAAAAA")
	checkboxTwo = guiCreateCheckBox(10, 196, 197, 15, "Arredondar Milésimos", false, false, tabRot)
	buttonClose2 = guiCreateButton(408, 197, 57, 20, "Fechar", false, tabRot)
	guiSetProperty(buttonClose, "NormalTextColour", "FFAAAAAA")
	buttonClearTwo = guiCreateButton(72, 119 , 98, 38, "Limpar", false, tabRot)
	guiSetProperty(buttonClearTwo, "NormalTextColour", "FFAAAAAA")
	buttonCopyTwo = guiCreateButton(240, 119, 98, 38, "Copiar", false, tabRot)
	guiSetProperty(buttonCopyTwo, "NormalTextColour", "FFAAAAAA")
	LabelTwo = guiCreateLabel(44, 33, 326, 39, "Rotação:", false, tabRot)
	guiSetFont(LabelTwo, "default-bold-small")

	--Dimensão Tab
	tabDimInt = guiCreateTab("Dimensão/Interior", tabpanel)
	memoThree = guiCreateEdit(45, 66, 110, 43, "", false, tabDimInt)
	guiEditSetReadOnly(memoThree, true)
	memoFour = guiCreateEdit(200, 66, 110, 43, "", false, tabDimInt)
	guiEditSetReadOnly(memoFour, true)
	buttonGetDimInt = guiCreateButton(340, 4, 123, 48, "Obter Dimensão/Interior", false, tabDimInt)
	guiSetProperty(buttonGetDimInt, "NormalTextColour", "FFAAAAAA")
	buttonClose3 = guiCreateButton(408, 197, 57, 20, "Fechar", false, tabDimInt)
	guiSetProperty(buttonClose, "NormalTextColour", "FFAAAAAA")
	buttonClearThree = guiCreateButton(340, 119 , 98, 38, "Limpar", false, tabDimInt)
	guiSetProperty(buttonClearThree, "NormalTextColour", "FFAAAAAA")
	buttonCopyThree = guiCreateButton(45, 119, 98, 38, "Copiar", false, tabDimInt)
	buttonCopyFour = guiCreateButton(200, 119, 98, 38, "Copiar", false, tabDimInt)
	guiSetProperty(buttonCopyThree, "NormalTextColour", "FFAAAAAA")
	guiSetProperty(buttonCopyFour, "NormalTextColour", "FFAAAAAA")
	LabelThree = guiCreateLabel(45, 33, 326, 39, "Dimensão:", false, tabDimInt)
	LabelFour = guiCreateLabel(200, 33, 326, 39, "Interior:", false, tabDimInt)
	
	guiSetFont(LabelThree, "default-bold-small")
	guiSetFont(LabelFour, "default-bold-small")

	guiSetVisible(win,false)

	bindKey("backspace","down",function()
		guiSetVisible ( win, false )
		showCursor ( false )
		unbindKey("backspace","down")
	end)
	guiSetVisible ( win, true )
	showCursor ( true )

	addEventHandler ("onClientGUIClick",root, function ()
		--Coordenada
		if ( source == buttonClose ) then 
			guiSetVisible ( win, false )
			showCursor ( false )
		elseif ( source == buttonCopy ) then
			if (guiGetText(memo) == "") then return end
			setClipboard ( guiGetText (memo) )
			outputChatBox("Position copied to clipboard.")
		elseif ( source == buttonGetPos ) then
			local x,y,z = getElementPosition (player)
			if (guiCheckBoxGetSelected (checkbox) == false) then
				local x,y,z = getElementPosition (player)
				guiSetText(memo,x..","..y..","..z)
			else
				guiSetText(memo,table.concat ( { math.round ( x, 3 ), math.round ( y, 3 ), math.round ( z, 3 ), int }, ', ' ) )
			end
		elseif ( source == buttonClear ) then
			guiSetText(memo,"")
		--Rotação
		elseif( source == buttonGetRot) then
			local rx,ry,rz = getElementRotation(player)
			if (guiCheckBoxGetSelected(checkboxTwo) == false) then
				guiSetText(memoTwo,rx..", "..ry..", "..rz) 
			else
				guiSetText(memoTwo,table.concat ( { math.round ( rx, 3 ), math.round ( ry, 3 ), math.round ( rz, 3 ), int }, ', ' ) )
			end
		elseif ( source == buttonClearTwo) then
			guiSetText(memoTwo,"")
		elseif ( source == buttonCopyTwo ) then
			if (guiGetText(memoTwo) == "") then return end
			setClipboard ( guiGetText (memoTwo) ) 
			outputChatBox("Posição Copiada Só Colar")
		elseif ( source == buttonClose2 ) then 
			guiSetVisible ( win, false )
			showCursor ( false )
		--Dimensão
		elseif ( source == buttonGetDimInt ) then
			local dim = getElementDimension(player)
			guiSetText(memoThree, dim)
			local int = getCameraInterior(player)
			guiSetText(memoFour, int) 	
		elseif ( source == buttonClose3 ) then 
			guiSetVisible ( win, false )
			showCursor ( false )
		elseif ( source == buttonClearThree ) then
			guiSetText(memoThree,"")
			guiSetText(memoFour,"")
		elseif ( source == buttonCopyThree ) then
			if (guiGetText(memoThree) == "") then return end
			setClipboard ( guiGetText (memoThree) ) 
			outputChatBox("Localização Copiada so colar")
		--Interior
		elseif ( source == buttonCopyFour ) then
			if (guiGetText(memoFour) == "") then return end
			setClipboard ( guiGetText (memoFour) ) 
			outputChatBox("Localização Copiada so colar")
		end
	end)

	function math.round(number, decimals, method)
		decimals = decimals or 0
		local factor = 10 ^ decimals
		if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
		else return tonumber(("%."..decimals.."f"):format(number)) end
	end
end)

addCommandHandler("coordenadas", function( )
	triggerServerEvent(":verifCoords",player)
end)