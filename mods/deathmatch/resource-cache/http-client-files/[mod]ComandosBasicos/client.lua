bindKey("lalt","down", 
function()
    showCursor(true)
end)
bindKey("lalt","up", 
function()
    showCursor(false)
end)
bindKey("k","down", 
function(button, press)
    if isPlayerInVehicle(localPlayer) then
        local car = getPedOccupiedVehicle(localPlayer)
        if not isChatBoxInputActive() and not guiGetInputEnabled() then
            triggerServerEvent("desligarMotor", getRootElement(),localPlayer,car)
        end
    end
end)
bindKey("j","down", 
function(button, press)
    if isPlayerInVehicle(localPlayer) then
        local car = getPedOccupiedVehicle(localPlayer)
        if not isChatBoxInputActive() and not guiGetInputEnabled() then
            triggerServerEvent("desligarFarol", getRootElement(),localPlayer,car)
        end
    end
end)
addCommandHandler("seat",function(commandName, banco)
    banco=banco-1
    local thePlayer = getLocalPlayer()
    if isPlayerInVehicle(thePlayer) then
        local carro = getPedOccupiedVehicle(thePlayer)
        for i=0,getVehicleMaxPassengers(carro)
        do
            if not getVehicleOccupant(carro,i) then
                if tonumber(banco)==i then
                    triggerServerEvent("changeSeat", thePlayer,carro,i)
                end
            end
        end
    end
end)

--Ocultar HUD
--addEventHandler("onClientRender",getRootElement(),PlayerNameTags)
local screenWidth,screenHeight = guiGetScreenSize()
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        myScreenSource = dxCreateScreenSource ( screenWidth, screenHeight )         
    end
)
 
function cleanmyscreen()
	if myScreenSource then
		dxUpdateScreenSource( myScreenSource )                  
		dxDrawImage( screenWidth - screenWidth,  screenHeight - screenHeight,  screenWidth, screenHeight, myScreenSource, 0, 0, 0, tocolor (255, 255, 255, 255), true)      
	end
end

function tooglecleanmyscreen ()
enabled = not enabled
                playSound("music.wav")
if enabled then
	addEventHandler( "onClientRender", root, cleanmyscreen)
	else
	playSound("music.wav")
	removeEventHandler( "onClientRender", root, cleanmyscreen)
end
end
bindKey ("f7", "down", tooglecleanmyscreen)

