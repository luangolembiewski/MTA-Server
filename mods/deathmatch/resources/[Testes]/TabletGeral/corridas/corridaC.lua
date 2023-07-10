local corridas = {}
local textura = dxCreateTexture("images/bandeira.png")
local l1, l2, l3 = nil
local marker = nil

function entrarCorrida(corrida)end

local function iniciarDB()
    triggerServerEvent("corrida:StartDB",localPlayer)
end
local function obterCorridas()
    triggerServerEvent("corrida:GetAllCorridas",localPlayer)
end
local function entrarCorrida(corrida,idPlayer)
    table.insert(corrida.corredores,idPlayer)
    outputChatBox(tostring(table.concat(corrida.corredores),"- "))
    return triggerServerEvent("corrida:entrarCorrida",localPlayer, corrida.corredores,corrida.id)
end


function buzina(button,press)
    if(button=="h" and press == false) then
        if(isPlayerInVehicle(localPlayer) and getPedOccupiedVehicleSeat(localPlayer)==0) then
            obterCorridas()
            for x,y in ipairs(corridas) do
                if(isElementWithinMarker(localPlayer,y.startMarker)) then
                    --outputChatBox(y.corredores)
                    --[[ if(#y.corredores < y.vagas)then
                        local idPlayer = tonumber(getElementData(localPlayer,"ID"))
                        if(entrarCorrida(y,idPlayer)) then
                            outputChatBox(idPlayer.." entrou na ".. y.nome)
                        end
                    else
                        outputChatBox("Corrida está cheia!")
                    end ]]
                end
            end
        end
    end
end


function setStartMarker()
    --dxDrawMaterialLine3D(1472.504, -1639.452, 14.148,1485.956, -1638.823, 14.148,dxCreateTexture("images/racing.png"),1, white)
    for x,y in ipairs(corridas) do
        if(marker) then Maker
        marker = createMarker( y.cdsStartMarker[1], y.cdsStartMarker[2], y.cdsStartMarker[3]-1, "cylinder", 5, 255, 255, 0, 0 )
        corridas[x].startMarker = marker
        l1, l2, l3 = y.cdsStartMarker[1], y.cdsStartMarker[2], y.cdsStartMarker[3]
    end
    outputChatBox("Markers corridas criados")
end

function rendenizar()
    removeEventHandler("onClientRender", root, rendenizar)
    obterCorridas()
    setStartMarker()
    setTimer(function()
        addEventHandler("onClientRender", root, rendenizar)
    end
    ,5000,1)
end


addEvent("corrida:SetCorridas",true)
addEventHandler("corrida:SetCorridas",root, function(corrida)
    corridas = corrida
end)

addCommandHandler("co",function()
    outputChatBox(#corridas)
end)


function render()
    if(isPlayerInVehicle(localPlayer) and getPedOccupiedVehicleSeat(localPlayer)==0) then
        dxDrawMaterialLine3D (l1, l2, l3+1 , l1, l2, l3-0.5, textura , 2, tocolor(255, 255, 255, 255))
    end
end

addEventHandler("onClientResourceStart",root,function()
    iniciarDB()
    addEventHandler("onClientKey",root, buzina)
    addEventHandler("onClientRender", root, rendenizar)
    addEventHandler("onClientRender", root, render)
end)