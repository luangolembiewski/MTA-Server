local racing = nil
local grupos = nil
local screen = "desktop"
local fontBold = dxCreateFont("fonts/FiraSansExtraCondensed-Bold.ttf",12)
local fontSemiBold = dxCreateFont("fonts/FiraSansExtraCondensed-SemiBold.ttf",11)

function Desktop()
    if(screen == "desktop") then
        local nome = getPlayerName(localPlayer)
        local id = getElementData(localPlayer, "ID") or "N/A"
        local group = table.concat(getElementData(localPlayer, "ACLs"),", ")
        local hora,min = getTime()
        hora = string.sub("00"..tostring(hora),-2,-1)
        min = string.sub("00"..tostring(min),-2,-1)
        
        --apps
        racing = {x=472,y=187,w=95,h=95}
        grupos = {x=627,y=187,w=95,h=95}

        --tablet
        dxDrawImage(317, 51, 1288, 937, "images/tablet.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        --wallpaper
        dxDrawImage(392, 147, 1133, 741, "images/wallpaper.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

        --apps
        --racing
        dxDrawRoundedRectangle(472, 187, 95, 95, 20, tocolor(0, 94, 123, 255))
        dxDrawImage(472, 212, 95, 45, "images/racing.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("Racing", 476, 287, 88, 26, tocolor(255, 255, 255, 255), 1, fontBold, "center", "center", true, true, true)
        --grupos
        dxDrawRoundedRectangle(627, 187, 95, 95, 20, tocolor(0, 99, 28, 255))
        dxDrawImage(643, 207, 64, 55, "images/grupos.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("Grupos", 624, 287, 101, 26, tocolor(255, 255, 255, 255), 1, fontBold, "center", "center", true, true, true)
        
        --menu
        dxDrawRoundedRectangle(1288, 187, 226, 610, 20, tocolor(5, 5, 5, 165))
        dxDrawRoundedRectangle(1326, 212, 150, 150, 20, tocolor(217, 217, 217, 255))
        dxDrawText(nome.."("..id..")", 1333, 378, 136, 30, tocolor(189, 189, 189, 255), 1, fontBold, "center", "center", true, true, true)
        dxDrawText(group, 1369, 408, 64, 30, tocolor(189, 189, 189, 255), 0.9, fontSemiBold, "center", "top", false, false, true)
        dxDrawImage(1348, 740, 30, 30, "images/schedule.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawText(hora..":"..min, 1391, 740, 62, 30, tocolor(189, 189, 189, 255), 1, fontBold, "center", "center", true, true, true)
    elseif(screen=="appRacing") then
        --tablet
        dxDrawImage(317, 51, 1288, 937, "images/tablet.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    elseif(screen=="appGrupos") then
        --tablet
        dxDrawImage(317, 51, 1288, 937, "images/tablet.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
end

function tabletClick(button,state)
    if(button=="left" and state=="down") then 
        if(screen=="desktop") then
            if(isCursorOnElement(racing.x,racing.y,racing.w,racing.h)) then
                screen="appRacing"
            elseif(isCursorOnElement(grupos.x,grupos.y,grupos.w,grupos.h)) then
                screen="appGrupos"
            end
        elseif(screen=="appRacing") then

        elseif(screen=="appGrupos") then
        end
    end
end

addCommandHandler("tablet", function()
    if isEventHandlerAdded("onClientRender", getRootElement(), Desktop) then
        removeEventHandler("onClientRender", root, Desktop)
        removeEventHandler("onClientKey",root,fechar)
        removeEventHandler("onClientClick", root, tabletClick)
        screen = "desktop"
        showCursor(false)
    else
        showCursor(true)
        addEventHandler("onClientRender", root, Desktop)
        function fechar(button,press)
            if(button=="backspace") then
                removeEventHandler("onClientRender", root, Desktop)
                removeEventHandler("onClientKey",root,fechar)
                removeEventHandler("onClientClick", root, tabletClick)   
                screen = "desktop"
                showCursor(false)
            end
        end
        addEventHandler("onClientKey",root,fechar)
        addEventHandler ("onClientClick", root, tabletClick )
    end
end)
