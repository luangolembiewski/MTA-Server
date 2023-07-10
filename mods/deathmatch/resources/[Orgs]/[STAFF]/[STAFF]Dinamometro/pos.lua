local player = getLocalPlayer()
local firstColor = tocolor(0, 0, 0, 150)
local secondColor = tocolor(255, 255, 255, 255)
local screenX, screenY = guiGetScreenSize()
local vhspeedfont = dxCreateFont( "font.ttf", 77 )
local tempoIni = 0
local tempoTot = 0
local velo = 0

local x1,y1 = 0.9,0.9
local texto=""
local sound



function render()
	dxDrawText(texto, 0, 0, x1 * 1430, y1 * 20, tocolor(255,0,0), 1, vhspeedfont, "center", "top", false, false, false, false, false)
	velo = exports["[mod]Velocimetro"]:getVehicleSpeed();
	if velo > 100 then
		if tempoTot == 0 then
			tempoTot=getTickCount()-tempoIni
			
			texto= tempoTot/1000
			setTimer(function()
				tempoTot = 0
				removeEventHandler("onClientRender",root,render)
			end,10000,1)
		end
	end
end
addEvent(":openDina",true)
addEventHandler(":openDina",root,function()
	texto=5
	local veh = getPedOccupiedVehicle(player)
	setVehicleFrozen(veh,true)
	sound = playSound("bip.mp3")
	setSoundVolume(sound, 0.5)
	addEventHandler("onClientRender",root,render)
	setTimer(function()
		sound = playSound("bip.mp3")
		setSoundVolume(sound, 0.5) 
		texto=texto-1
	end,1000,4)
	setTimer(function()
		texto="Acelera!" 
		setVehicleFrozen(veh,false)
		sound = playSound("bip2.mp3")
		setSoundVolume(sound, 0.5)
		tempoIni = getTickCount()
	end,5000,1)
end)

addCommandHandler("arrancar", function( )
	if(getPedOccupiedVehicleSeat(player)==0) then
		triggerServerEvent(":verifDina",player)
	end
end)
