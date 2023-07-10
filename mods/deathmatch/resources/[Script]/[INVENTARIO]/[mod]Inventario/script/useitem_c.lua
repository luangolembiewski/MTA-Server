local screenW, screenH = guiGetScreenSize ()
local resW, resH = 1920,1080
local x, y = (screenW/resW), (screenH/resH)

local isEventHandlerAdded = function( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
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

local MaconhaDX = function()
    if Parte == 1 then
        R,G,B = interpolateBetween(255,255,255,100,100,100,(getTickCount() - tick)/2000, "Linear")
        if R == 100 and G == 100 and B == 100 then
            Parte = 2
            tick = getTickCount()
        end
    elseif Parte == 2 then
        R,G,B = interpolateBetween(0,0,0,255,255,255,(getTickCount() - tick)/2000, "Linear")
        if R == 255 and G == 255 and B == 255 then
            Parte = 1
            tick = getTickCount()
        end
    end
    dxDrawImage(x*0, y*0, x*1920, y*1080, "assets/files/drugs/maconha.png", 0, 0, 0, tocolor(R,G,B, 75), false)
end

local usarMaconha = function()
    if isEventHandlerAdded("onClientRender",root,MaconhaDX) then
        removeEventHandler("onClientRender",root,MaconhaDX)
    end
    addEventHandler("onClientRender",root,MaconhaDX)
    setGameSpeed(1.5)
    setCameraShakeLevel(255)
    setWindVelocity(100, 100, 0)
    tick = getTickCount()
    Parte = 1
end
addEvent("TS:usarMaconha",true)
addEventHandler("TS:usarMaconha",root,usarMaconha)

local pararMaconha = function()
    if isEventHandlerAdded("onClientRender",root,MaconhaDX) then
        removeEventHandler("onClientRender",root,MaconhaDX)
    end
    setCameraShakeLevel(1)
    setGameSpeed(1)
    resetWindVelocity()
end
addEvent("TS:pararMaconha",true)
addEventHandler("TS:pararMaconha",root,pararMaconha)

local cocainaDX = function()
    for i,v in ipairs(Posicoes) do
        if Parte == 1 then
            AlphaMeta = interpolateBetween(0,0,0,255,0,0,(getTickCount() - tick)/5000, "Linear")
            if AlphaMeta == 255 then
                Parte = 2
                tick = getTickCount()
                setCameraGoggleEffect("thermalvision")
                setTimer(function()
                    setCameraGoggleEffect("normal")
                end,2000,1)
            end
        elseif Parte == 2 then
            AlphaMeta = interpolateBetween(255,0,0,0,0,0,(getTickCount() - tick)/5000, "Linear")
            if AlphaMeta == 0 then
                Parte = 1
                tick = getTickCount()
                setCameraGoggleEffect("thermalvision")
                setTimer(function()
                    setCameraGoggleEffect("normal")
                end,4000,1)
            end
        end
        dxDrawImage(v[1], v[2], x*170, y*163, "assets/files/drugs/sorriso.png", 0, 0, 0, tocolor(255, 254, 254, AlphaMeta), false)
    end
end

local usarCocaina = function()
    if isEventHandlerAdded("onClientRender",root,cocainaDX) then
        removeEventHandler("onClientRender",root,cocainaDX)
    end
    addEventHandler("onClientRender",root,cocainaDX)
    Posicoes = {}
    for i = 1,50 do
        local sx,sy = guiGetScreenSize()
        table.insert(Posicoes, {math.random(0,sx), math.random(0,sy)})
    end
    tick = getTickCount()
    Parte = 1
end
addEvent("TS:usarCocaina",true)
addEventHandler("TS:usarCocaina",root,usarCocaina)

local pararCocaina = function()
    if isEventHandlerAdded("onClientRender",root,cocainaDX) then
        removeEventHandler("onClientRender",root,cocainaDX)
    end
end
addEvent("TS:pararCocaina",true)
addEventHandler("TS:pararCocaina",root,pararCocaina)