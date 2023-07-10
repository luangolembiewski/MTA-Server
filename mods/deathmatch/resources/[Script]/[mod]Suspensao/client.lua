local screenW, screenH = guiGetScreenSize()
local mostrandoPainel = false
local som = "files/sounds/air.mp3"

function carregarControle()
    --controle--
    controle = guiCreateStaticImage(screenW * 0.7500, screenH * 0.4852, screenW * 0.2448, screenH * 0.4333,"files/images/controle.png",false)
    guiSetVisible(controle,false)
    guiSetEnabled(controle,false)

    --Botões--
    up = guiCreateButton(0.85, 0.51, 0.04, 0.05, "", true)
    guiSetAlpha(up, 0.00)
    guiSetVisible(up,false)

    down = guiCreateButton(0.85, 0.61, 0.04, 0.05, "", true)
    guiSetAlpha(down, 0.00)
    guiSetVisible(down,false)

    left  = guiCreateButton(0.83, 0.55, 0.03, 0.07, " ", true)
    guiSetAlpha(left , 0.00)
    guiSetVisible(left,false)
    
    right  = guiCreateButton(0.89, 0.55, 0.03, 0.07, "", true)
    guiSetAlpha(right , 0.00)
    guiSetVisible(right,false)

    allUp = guiCreateButton(0.84, 0.67, 0.03, 0.05, "", true)
    guiSetAlpha(allUp, 0.00)
    guiSetVisible(allUp,false)

    allDown = guiCreateButton(0.84, 0.72, 0.03, 0.05, "", true)
    guiSetAlpha(allDown, 0.00)
    guiSetVisible(allDown,false)

    disable1 = guiCreateButton(0.87, 0.67, 0.03, 0.05, "", true)
    guiSetAlpha(disable1, 0.00)
    guiSetVisible(disable1,false)

    disable2 = guiCreateButton(0.87, 0.72, 0.03, 0.05, "", true)
    guiSetAlpha(disable2, 0.00) 
    guiSetVisible(disable2,false)   
end
addEventHandler("onClientResourceStart", getRootElement(), carregarControle)

function mostrarOcultar(status)
    guiSetVisible(controle,status)
    guiSetVisible(up,status)
    guiSetVisible(down,status)
    guiSetVisible(left,status)
    guiSetVisible(right,status)
    guiSetVisible(allUp,status)
    guiSetVisible(allDown,status)
    guiSetVisible(disable1,status)
    guiSetVisible(disable2,status)
end

bindKey('F5','down', function()
    local veh  = getPedOccupiedVehicle(getLocalPlayer())
    --local veh = true
    if veh then 
        if mostrandoPainel == false then
            mostrarOcultar(true)
            showCursor(true)
            mostrandoPainel = true
        else
            mostrarOcultar(false)
            showCursor(false)
            mostrandoPainel = false
        end
    end
end)
bindKey('backspace','down', function()
    if mostrandoPainel == true then
        mostrarOcultar(false)
        showCursor(false)
        mostrandoPainel = false
    end
end)

addEventHandler("onClientGUIMouseDown", resourceRoot, function()
    if mostrandoPainel == true then
        if source == up then
            killAirTime()
            rootSound(som)
            triggerServerEvent("s:air", localPlayer, "suspensionFrontRearBias", 0.01)
            timer = setTimer(function()
                triggerServerEvent("s:air", localPlayer, "suspensionFrontRearBias", 0.01)
            end, 20, 0)
        elseif source == down then
            killAirTime()
            rootSound(som)
            triggerServerEvent("s:air", localPlayer, "suspensionFrontRearBias", -0.01)
            timer = setTimer(function()
                triggerServerEvent("s:air", localPlayer, "suspensionFrontRearBias", -0.01)
            end, 20, 0)
        elseif source == left then
            killAirTime()
            rootSound(som)
            triggerServerEvent("s:air", localPlayer, {"centerOfMass", -0.05})
            timer = setTimer(function()
                triggerServerEvent("s:air", localPlayer, {"centerOfMass", -0.05})
            end, 20, 0)
        elseif source == right then
            killAirTime()
            rootSound(som)
            triggerServerEvent("s:air", localPlayer, {"centerOfMass", 0.05})
            timer = setTimer(function()
                triggerServerEvent("s:air", localPlayer, {"centerOfMass", 0.05})
            end, 20, 0)
            
        elseif source == allUp then
            killAirTime()
            rootSound(som)
            triggerServerEvent("s:air", localPlayer, "subir", -0.01)
        elseif source == allDown then
            killAirTime()
            rootSound(som)
            triggerServerEvent("s:air", localPlayer, "baixar", 0.01)
        end
    end
end)

addEventHandler("onClientGUIMouseUp", resourceRoot, function()
	killAirTime()
end)

function killAirTime()
	if isTimer(timer) then
		killTimer(timer)
	end
	timer = false
end

local sound = false
addEvent("c:playSoundAir", true)
addEventHandler("c:playSoundAir", root, function(file, element)
	if isElement(sound) then
		destroyElement(sound)
	end
	if isElement(element) then
		local x, y, z = getElementPosition(element)
		sound = playSound3D(file, x, y, z)
		setSoundVolume(sound, 0.5)
		setSoundMaxDistance(sound, 15)
	end
end)

function rootSound(file)
	triggerServerEvent("s:rootSoundAir", localPlayer, file)
end

function outputChatBox(text, r, g, b, bool)
	ContextBar.add(RGBToHex(r, g, b)..text)
end