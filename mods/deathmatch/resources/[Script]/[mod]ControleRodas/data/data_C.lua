
----------------------------------------------------------------------------------------------------
-------------------------------------------- By -Thiagu* -------------------------------------------
--                                Por favor, não retire os creditos!                              --


painelControle = false

local screenH, screenW = guiGetScreenSize()
local x, y = (screenH/1366), (screenW/768)

function cursorPosition(x, y, w, h)
	if (not isCursorShowing()) then
		return false
	end
	local mx, my = getCursorPosition()
	local fullx, fully = guiGetScreenSize()
	cursorx, cursory = mx*fullx, my*fully
	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
		return true
	else
		return false
	end
end

function painel_ControleRodas()
    CEE = 255
    CED = 255
    CDE = 255
    CDD = 255
    BED = 255
    BEE = 255
    BDE = 255
    BDD = 255

    dxDrawRectangle(x*483, y*335, x*44, y*49, tocolor(255, 254, 254, 0), false)
    if cursorPosition(x*483, y*335, x*44, y*49) then CEE = 100 end

    dxDrawRectangle(x*605, y*335, x*44, y*49, tocolor(255, 254, 254, 0), false)
    if cursorPosition(x*605, y*335, x*44, y*49) then CED = 100 end

    dxDrawRectangle(x*692, y*335, x*44, y*49, tocolor(255, 254, 254, 0), false)
    if cursorPosition(x*692, y*335, x*44, y*49) then CDE = 100 end

    dxDrawRectangle(x*808, y*335, x*44, y*49, tocolor(255, 254, 254, 0), false)
    if cursorPosition(x*808, y*335, x*44, y*49) then CDD = 100 end

    dxDrawRectangle(x*604, y*473, x*44, y*49, tocolor(255, 254, 254, 0), false)
    if cursorPosition(x*604, y*473, x*44, y*49) then BED = 100 end

    dxDrawRectangle(x*482, y*473, x*44, y*49, tocolor(255, 254, 254, 0), false)
    if cursorPosition(x*482, y*473, x*44, y*49) then BEE = 100 end

    dxDrawRectangle(x*688, y*474, x*44, y*49, tocolor(255, 254, 254, 0), false)
    if cursorPosition(x*688, y*474, x*44, y*49) then BDE = 100 end

    dxDrawRectangle(x*807, y*472, x*44, y*49, tocolor(255, 254, 254, 0), false)
    if cursorPosition(x*807, y*472, x*44, y*49) then BDD = 100 end

    dxDrawLine(x*474 - 1, y*210 - 1, x*474 - 1, y*249, tocolor(0, 0, 0, 255), x*1, false)
    dxDrawLine(x*862, y*210 - 1, x*474 - 1, y*210 - 1, tocolor(0, 0, 0, 255), x*1, false)
    dxDrawLine(x*474 - 1, y*249, x*862, y*249, tocolor(0, 0, 0, 255), x*1, false)
    dxDrawLine(x*862, y*249, x*862, y*210 - 1, tocolor(0, 0, 0, 255), x*1, false)
    dxDrawRectangle(x*474, y*210, x*388, y*39, tocolor(0, 0, 0, 233), false)
    dxDrawRectangle(x*474, y*249, x*388, y*335, tocolor(255, 255, 255, 91), false)
    dxDrawText("Controle de Rodas", x*474, y*210, x*862, y*249, tocolor(255, 255, 255, 255), x*2.00, "arial", "center", "center", false, false, false, true, false)
    dxDrawRectangle(x*474, y*584, x*388, y*26, tocolor(0, 0, 0, 219), false)
    dxDrawText("Criado por #00E1AC-T#2E3231hiagu*", x*474, y*584, x*862, y*610, tocolor(255, 255, 255, 255), x*1.00, "arial", "center", "center", false, false, false, true, false)


    dxDrawLine(x*474 - 1, y*249 - 1, x*474 - 1, y*584, tocolor(0, 0, 0, 255), x*1, false)
    dxDrawLine(x*862, y*249 - 1, x*474 - 1, y*249 - 1, tocolor(0, 0, 0, 255), x*1, false)
    dxDrawLine(x*474 - 1, y*584, x*862, y*584, tocolor(0, 0, 0, 255), x*1, false)
    dxDrawLine(x*862, y*584, x*862, y*249 - 1, tocolor(0, 0, 0, 255), x*1, false)
        
    dxDrawLine(x*484 - 1, y*458 - 1, x*484 - 1, y*541, tocolor(0, 0, 0, 255), x*1, false)
    dxDrawLine(x*852, y*458 - 1, x*484 - 1, y*458 - 1, tocolor(0, 0, 0, 255), x*1, false)
    dxDrawLine(x*484 - 1, y*541, x*852, y*541, tocolor(0, 0, 0, 255), x*1, false)
    dxDrawLine(x*852, y*541, x*852, y*458 - 1, tocolor(0, 0, 0, 255), x*1, false)
    dxDrawRectangle(x*484, y*458, x*368, y*83, tocolor(254, 254, 254, 0), false)
    dxDrawLine(x*485 - 1, y*319 - 1, x*485 - 1, y*402, tocolor(0, 0, 0, 255), x*1, false)
    dxDrawLine(x*853, y*319 - 1, x*485 - 1, y*319 - 1, tocolor(0, 0, 0, 255), x*1, false)
    dxDrawLine(x*485 - 1, y*402, x*853, y*402, tocolor(0, 0, 0, 255), x*1, false)
    dxDrawLine(x*853, y*402, x*853, y*319 - 1, tocolor(0, 0, 0, 255), x*1, false)
    dxDrawRectangle(x*485, y*319, x*368, y*83, tocolor(254, 254, 254, 0), false)

    dxDrawImage(x*527, y*323, x*78, y*74, "data/roda.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("<<", x*484, y*323, x*517, y*397, tocolor(255, 255, 255, CEE), x*2.00, "beckett", "right", "bottom", false, false, false, true, false)
    dxDrawText(">>", x*615, y*323, x*646, y*397, tocolor(255, 255, 255, CED), x*2.00, "beckett", "left", "bottom", false, false, false, true, false)
    dxDrawImage(x*736, y*323, x*78, y*74, "data/roda.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("<<", x*690, y*323, x*726, y*397, tocolor(255, 255, 255, CDE), x*2.00, "beckett", "right", "bottom", false, false, false, true, false)
    dxDrawText(">>", x*824, y*323, x*853, y*397, tocolor(255, 255, 255, CDD), x*2.00, "beckett", "left", "bottom", false, false, false, true, false)
    dxDrawImage(x*528, y*463, x*78, y*74, "data/roda.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("<<", x*484, y*463, x*518, y*537, tocolor(255, 255, 255, BEE), x*2.00, "beckett", "right", "bottom", false, false, false, true, false)
    dxDrawText(">>", x*616, y*463, x*647, y*537, tocolor(255, 255, 255, BED), x*2.00, "beckett", "left", "bottom", false, false, false, true, false)
    dxDrawImage(x*731, y*463, x*78, y*74, "data/roda.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("<<", x*687, y*463, x*721, y*537, tocolor(255, 255, 255, BDE), x*2.00, "beckett", "right", "bottom", false, false, false, true, false)
    dxDrawText(">>", x*819, y*463, x*852, y*537, tocolor(255, 255, 255, BDD), x*2.00, "beckett", "left", "bottom", false, false, false, true, false)
    dxDrawText("Rodas Dianteiras", x*485, y*294, x*854, y*313, tocolor(0, 0, 0, 255), x*1.00, "default-bold", "center", "center", false, false, false, true, false)
    dxDrawText("Rodas Traseiras", x*485, y*429, x*854, y*448, tocolor(0, 0, 0, 255), x*1.00, "default-bold", "center", "center", false, false, false, true, false)
end

frenteDireita = "wheel_rf_dummy"
frenteEsquerda = "wheel_lf_dummy"
trazDireita = "wheel_rb_dummy"
trazEsquerda = "wheel_lb_dummy"

function CEEF (_,state)
    local seat = getPedOccupiedVehicleSeat(getLocalPlayer())
    local veh = getPedOccupiedVehicle( getLocalPlayer() )
    if painelControle == true and veh ~= false and seat == 0 and state == "down" and cursorPosition(x*483, y*335, x*44, y*49) then
        if x >= 1.50 then
          outputChatBox("#CC0000Limite Maximo Atingido", 255, 140, 000, true)
        else
           triggerServerEvent( "controlWheels", getLocalPlayer(), getLocalPlayer(), veh, frenteEsquerda, false )
        end
    end
end

function CEDF (_,state)
    local seat = getPedOccupiedVehicleSeat(getLocalPlayer())
    local veh = getPedOccupiedVehicle( getLocalPlayer() )
    if painelControle == true and veh ~= false and seat == 0 and state == "down" and cursorPosition(x*605, y*335, x*44, y*49) then
        local x, y, z = getVehicleComponentPosition(veh, frenteEsquerda)
        if x >= 1.50 then
           outputChatBox("#CC0000Limite Maximo Atingido", 255, 140, 000, true)
        else
            triggerServerEvent( "controlWheels", getLocalPlayer(), getLocalPlayer(), veh, frenteEsquerda, true )
        end
    end
end

function CDEF (_,state)
    local seat = getPedOccupiedVehicleSeat(getLocalPlayer())
    local veh = getPedOccupiedVehicle( getLocalPlayer() )
    if painelControle == true and veh ~= false and seat == 0 and state == "down" and cursorPosition(x*692, y*335, x*44, y*49) then
        local x, y, z = getVehicleComponentPosition(veh, frenteDireita)
        if x >= 1.50 then
            outputChatBox("#CC0000Limite Maximo Atingido", 255, 140, 000, true)
        else
            triggerServerEvent( "controlWheels", getLocalPlayer(), getLocalPlayer(), veh, frenteDireita, false )
        end
    end
end

function CDDF (_,state)
	local seat = getPedOccupiedVehicleSeat(getLocalPlayer())
	local veh = getPedOccupiedVehicle( getLocalPlayer() )
    if painelControle == true and veh ~= false and seat == 0 and state == "down" and cursorPosition(x*808, y*335, x*44, y*49) then
        local x, y, z = getVehicleComponentPosition(veh, frenteDireita)
        if x >= 1.50 then
            outputChatBox("#CC0000Limite Maximo Atingido", 255, 140, 000, true)
        else
            triggerServerEvent( "controlWheels", getLocalPlayer(), getLocalPlayer(), veh, frenteDireita, true )
        end
    end
end

function BEDF (_,state)
    local seat = getPedOccupiedVehicleSeat(getLocalPlayer())
    local veh = getPedOccupiedVehicle( getLocalPlayer() )
    if painelControle == true and veh ~= false and seat == 0 and state == "down" and cursorPosition(x*604, y*473, x*44, y*49) then 
        local x, y, z = getVehicleComponentPosition(veh, trazEsquerda)
        if x >= 1.50 then
            outputChatBox("#CC0000Limite Maximo Atingido", 255, 140, 000, true)
        else
            triggerServerEvent( "controlWheels", getLocalPlayer(), getLocalPlayer(), veh, trazEsquerda, true )
        end
    end
end

function BDDF (_,state) 
	local seat = getPedOccupiedVehicleSeat(getLocalPlayer())
	local veh = getPedOccupiedVehicle( getLocalPlayer() )
    if painelControle == true and veh ~= false and seat == 0 and state == "down" and cursorPosition(x*482, y*473, x*44, y*49) then
        local x, y, z = getVehicleComponentPosition(veh, trazEsquerda)
        if x >= 1.50 then
            outputChatBox("#CC0000Limite Maximo Atingido", 255, 140, 000, true)
        else
            triggerServerEvent( "controlWheels", getLocalPlayer(), getLocalPlayer(), veh, trazEsquerda, false )
        end
    end
end

function BEEF (_,state)
    local seat = getPedOccupiedVehicleSeat(getLocalPlayer())
    local veh = getPedOccupiedVehicle( getLocalPlayer() )
    if painelControle == true and veh ~= false and seat == 0 and state == "down" and cursorPosition(x*688, y*474, x*44, y*49) then 
        local x, y, z = getVehicleComponentPosition(veh, trazDireita)
        if x >= 1.50 then
            outputChatBox("#CC0000Limite Maximo Atingido", 255, 140, 000, true)
        else
            triggerServerEvent( "controlWheels", getLocalPlayer(), getLocalPlayer(), veh, trazDireita, false )
        end
    end
end

function BDEF (_,state)
    local seat = getPedOccupiedVehicleSeat(getLocalPlayer())
    local veh = getPedOccupiedVehicle( getLocalPlayer() )
    if painelControle == true and veh ~= false and seat == 0 and state == "down" and cursorPosition(x*807, y*472, x*44, y*49) then
    local x, y, z = getVehicleComponentPosition(veh, trazDireita)
        if x >= 1.50 then
            outputChatBox("#CC0000Limite Maximo Atingido", 255, 140, 000, true)
        else
            triggerServerEvent( "controlWheels", getLocalPlayer(), getLocalPlayer(), veh, trazDireita, true )
        end
    end
end

function abrirPainel_ControleRodas()
    local seat = getPedOccupiedVehicleSeat(getLocalPlayer())
    local veh = getPedOccupiedVehicle( getLocalPlayer() )

    if not veh == false and seat == 0 then
        if painelControle == false then 
            addEventHandler("onClientRender", root, painel_ControleRodas)
            painelControle = true
            showCursor( true )
            addEventHandler ("onClientClick", root, BEEF)
            addEventHandler ("onClientClick", root, BDDF)
            addEventHandler ("onClientClick", root, BEDF)
            addEventHandler ("onClientClick", root, CDDF)
            addEventHandler ("onClientClick", root, CDEF)
            addEventHandler ("onClientClick", root, CEDF)
            addEventHandler ("onClientClick", root, CEEF)
            addEventHandler ("onClientClick", root, BDEF)
        elseif painelControle == true then
            removeEventHandler("onClientRender", root, painel_ControleRodas)
            painelControle = false
            showCursor( false )
            removeEventHandler ("onClientClick", root, BEEF)
            removeEventHandler ("onClientClick", root, BDDF)
            removeEventHandler ("onClientClick", root, BEDF)
            removeEventHandler ("onClientClick", root, CDDF)
            removeEventHandler ("onClientClick", root, CDEF)
            removeEventHandler ("onClientClick", root, CEDF)
            removeEventHandler ("onClientClick", root, CEEF)
            removeEventHandler ("onClientClick", root, BDEF)
        end
    end
end
bindKey(bind, "down", abrirPainel_ControleRodas)

addEvent("changeWheels", true)
addEventHandler("changeWheels", getRootElement(),
function( veh, wheel, sW )
    if sW == false then
        local x, y, z = getVehicleComponentPosition(veh, wheel)
        setVehicleComponentPosition( veh, wheel, x-0.01, y, z )
    elseif sW == true then
        local x, y, z = getVehicleComponentPosition(veh, wheel)
        setVehicleComponentPosition( veh, wheel, x+0.01, y, z )
    end
end
)