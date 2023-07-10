--/ Vars \--

local radioInfos = {}

--/ Fonts \--

local regular = dxCreateFont("core/fonts/regular.otf", sy*20, false, "cleartype")
local medium = dxCreateFont("core/fonts/medium.otf", sy*20, false, "cleartype")
local clash = dxCreateFont("core/fonts/clash.otf", sy*20, false, "cleartype")
local txt = "Nenhuma música tocando atualmente."

--/ Interface \--
function volume(c)
    radioInfos["SelectedMusic"]["ChangeVolume"] = c
end
function radioInterface()
    local veh = getPedOccupiedVehicle(localPlayer)
    if not veh then
        closeRadio()
    end
    dxDrawRoundedRectangle(501, 235, 918, 610, tocolor(30, 30, 30, 255), 15, false)
    dxDrawText(""..(radioInfos["SelectedMusic"] and "Tocando atualmente #1ED760"..radioInfos["SelectedMusic"]["title"].."" or txt).." ", 531, 260, 241, 18, tocolor(255, 255, 255, 255), 0.5, regular, "left", "top", false, false, false, true)
    dxDrawRoundedRectangle(531, 302, 858, 47, tocolor(37, 38, 39, 255), 27, false)
    
    dxSetBlendMode("add")
    dxDrawImage(555, 318, 15, 15, Images["Lupa"], 0, 0, 0, tocolor(255, 255, 255, 90))
    dxSetBlendMode("blend")

    dxDrawEditbox(587, 302, 800, 45, 100, 1)
    local musicName = getEditboxText(1)
    dxDrawText(#musicName ~= 0 and musicName or "Pesquise músicas, artistas ou podcasts...", 587, 302, 270, 45, (isBoxActive(1) and tocolor(255, 255, 255, 195) or tocolor(255, 255, 255, 127)), 0.5, regular, "left", "center")
    
    if radioInfos["Search"] and #radioInfos["Search"] ~= 0 then 
        local data = radioInfos["Scroll"] or 0
        dxDrawRoundedRectangle(1386, 357, 3, 382, tocolor(37, 37, 37, 255), 1.5, false)
        dxDrawRoundedRectangle(1386, 357 + (data * (302 / (#radioInfos["Search"] - 6))), 3, 80, tocolor(135, 135, 135, 255), 1.4, false)
        for i = 1, 6 do 
            local musicValues = radioInfos["Search"][i + data]
            if musicValues then 
                local heightDif = (357 - 72) + (i * 72)
                dxDrawRoundedRectangle(531, heightDif, 842, 65, radioInfos["SelectedMusic"] == musicValues and tocolor(46, 46, 46, 255) or (isCursorOnElement(531, heightDif, 842, 65) and tocolor(46, 46, 46, 255) or tocolor(34, 35, 36, 255)), 12, false)
                if musicValues["title"] then
                    dxDrawText(musicValues["title"], 555, heightDif, 665, 34, radioInfos["SelectedMusic"] == musicValues and tocolor(30, 215, 96, 255) or (isCursorOnElement(531, heightDif, 842, 65) and tocolor(30, 215, 96, 255) or tocolor(255, 255, 255, 255)), 0.54, medium, "left", "bottom", true)
                end
                if musicValues["author"] then
                    dxDrawText(musicValues["author"]["name"], 555, (heightDif + 34), 665, 34, radioInfos["SelectedMusic"] == musicValues and tocolor(255, 255, 255, 255) or (isCursorOnElement(531, heightDif, 842, 65) and tocolor(255, 255, 255, 255) or tocolor(255, 255, 255, 165)), 0.49, regular, "left", "top", true)
                end
                if musicValues["duration"] then
                    dxDrawText(musicValues["duration"], 1220, heightDif, 127, 65, radioInfos["SelectedMusic"] == musicValues and tocolor(255, 255, 255, 255) or (isCursorOnElement(531, heightDif, 842, 65) and tocolor(255, 255, 255, 255) or tocolor(255, 255, 255, 102)), 0.54, regular, "right", "center")
                end
            end
        end
    end
    
    dxSetBlendMode("add")
    dxDrawImage(501, 765, 918, 80, Images["BackBar"], 0, 0, 0, tocolor(37, 38, 39, 255))
    dxDrawImage(545, 799, 14, 12, Images["ArrowL"], 0, 0, 0, tocolor(255, 255, 255, 115))
    dxDrawImage(633, 799, 14, 12, Images["ArrowR"], 0, 0, 0, tocolor(255, 255, 255, 115))
    dxDrawImage(1267, 797, 23, 16, Images["Speaker"], 0, 0, 0, tocolor(241, 241, 241, 255))
    if radioSound[veh] and radioSound[veh].soundElement and isElement(radioSound[veh].soundElement) then
        if isSoundPaused(radioSound[veh].soundElement) then
            dxDrawImage(569 + 7, 785, 40, 40, Images["Paused"], 0, 0, 0, tocolor(255, 255, 255, 115))
        else
            dxDrawImage(569 + 7, 785, 40, 40, Images["Played"], 0, 0, 0, tocolor(255, 255, 255, 115))
        end
    else
        dxDrawImage(569 + 7, 785, 40, 40, Images["Paused"], 0, 0, 0, tocolor(255, 255, 255, 115))
    end
    dxDrawImage(1208, 797, 21, 17, radioInfos["SelectedMusic"] and Images["VehicleGreen"] or Images["Vehicle"], 0, 0, 0, tocolor(255, 255, 255, 255))
    
    dxSetBlendMode("blend")
    
    dxDrawRoundedRectangle(1303, 800, 86, 9, tocolor(48, 49, 50, 255), 2, false)

    if radioInfos["SelectedMusic"] and radioInfos["SelectedMusic"]["ChangeVolume"] then
        if isCursorShowing() and isCursorOnElement(1303, 800, 90, 9) and getKeyState("mouse1") then 
            local mx, my = getCursorPosition()
            local cursorx, cursory = (mx * screenW), (my * screenH)
            local startRectangle = ((cursorx - sx*86) + sx*86 - sx*1303)
            if startRectangle < sx*86 then
                radioInfos["SelectedMusic"]["ChangeVolume"] = startRectangle/(sx*86)*Config["Gerais"]["MaxSound"]
            elseif startRectangle > sx*86 then
                radioInfos["SelectedMusic"]["ChangeVolume"] = Config["Gerais"]["MaxSound"]
            end
        end
    end

    if radioSound[veh] and radioSound[veh].soundElement and isElement(radioSound[veh].soundElement) then
        if radioInfos["SelectedMusic"]["ChangeVolume"] then
            dxDrawRoundedRectangle(1303, 800, 86/Config["Gerais"]["MaxSound"]*radioInfos["SelectedMusic"]["ChangeVolume"], 9, tocolor(234, 234, 234, 255), 2, false)
        else
            dxDrawRoundedRectangle(1303, 800, 86/Config["Gerais"]["MaxSound"]*getSoundVolume(radioSound[veh].soundElement), 9, tocolor(234, 234, 234, 255), 2, false)
        end
    end

    dxDrawRoundedRectangle(728, 799, 395, 9, tocolor(45, 45, 45, 255), 2.1, false)

    if radioInfos["SelectedMusic"] then
        if radioSound[veh] and radioSound[veh].soundElement and isElement(radioSound[veh].soundElement) then 
            radioInfos["SelectedMusic"]["ActualTime"] = getSoundPosition(radioSound[veh].soundElement)
            if getSoundLength(radioSound[veh].soundElement) then
                if tonumber((sx*395)/getSoundLength(radioSound[veh].soundElement)*radioInfos["SelectedMusic"]["ActualTime"]) and ((sx*395)/getSoundLength(radioSound[veh].soundElement)*radioInfos["SelectedMusic"]["ActualTime"] > 0) then
                    if getSoundLength(radioSound[veh].soundElement) >= radioInfos["SelectedMusic"]["ActualTime"] then
                        dxDrawRoundedRectangle(728, 799, 395/getSoundLength(radioSound[veh].soundElement)*radioInfos["SelectedMusic"]["ActualTime"], 9, tocolor(234, 234, 234, 255), 2.1, false)
                    end
                end
            end
        end
    end
    dxDrawText(radioInfos["SelectedMusic"] and radioInfos["SelectedMusic"]["duration"] or "0:00", 1136, 796, 34, 18, tocolor(255, 255, 255, 127), 0.46, clash, "left", "center")
    if radioInfos["SelectedMusic"] and radioInfos["SelectedMusic"]["ActualTime"] then
        dxDrawText(radioInfos["SelectedMusic"] and SecondsToClock(radioInfos["SelectedMusic"]["ActualTime"]) or "0:00", 674, 796, 34, 18, tocolor(255, 255, 255, 127), 0.46, clash, "right", "center")
    end

end
function SecondsToClock(seconds)
    local seconds = tonumber(seconds)
  
    if seconds <= 0 then
      return "00:00";
    else
      mins = string.format("%02.f", math.floor(seconds/60));
      secs = string.format("%02.f", math.floor(seconds - mins *60));
      return mins..":"..secs
    end
  end

--/ Render Functions \--


function openRadio()
    if not isEventHandlerAdded("onClientRender", getRootElement(), radioInterface) then 
        bindKey("backspace","down", closeRadio)
        addEventHandler("onClientRender", getRootElement(), radioInterface)
        showCursor(true)
    end
end
addEvent("VC:OpenRadio", true)
addEventHandler("VC:OpenRadio", getRootElement(), openRadio)

function closeRadio()
    if isEventHandlerAdded("onClientRender", getRootElement(), radioInterface) then 
        unbindKey("backspace","down", closeRadio)
        removeEventHandler("onClientRender", getRootElement(), radioInterface)
        showCursor(false)
        destroyBox()
    end
end

addEvent("VC:CloseRadio", true)
addEventHandler("VC:CloseRadio", getRootElement(), closeRadio)

function bindRadio()
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if vehicle and not Config["BlockedVehs"][getElementModel(vehicle)] then
        if getVehicleType(vehicle) == "Bike" or getVehicleType(vehicle) == "BMX" then return end    
        if not isEventHandlerAdded("onClientRender", getRootElement(), radioInterface) then 
            exports["[mod]Inventario"]:setInventario(false)
            openRadio()
        else
            exports["[mod]Inventario"]:setInventario(true)
            closeRadio()
        end
    end
end
bindKey(Config["Gerais"]["Key"], "down", bindRadio)

addEvent("VC:GetSearch", true)
addEventHandler("VC:GetSearch", getRootElement(), function(infos)
    txt = "Nenhuma música tocando atualmente."
    if infos then 
        radioInfos["Search"] = infos["items"]
    end
end)

function callSearch()
    if isEventHandlerAdded("onClientRender", getRootElement(), radioInterface) then 
        txt = "Buscando Aguarde..."
        local musicName = getEditboxText(1)
        triggerServerEvent("VC:CallSearch", localPlayer, localPlayer, musicName)
    end
end
addEventHandler("onClientKey",getRootElement(),function(button,press)
    if button=="enter" and press then
        callSearch()
    end
end)


addEventHandler("onClientVehicleExit", getRootElement(), function()
    if isEventHandlerAdded("onClientRender", getRootElement(), radioInterface) then 
        closeRadio()
    end
end)

function rollResults(button)
    if isEventHandlerAdded("onClientRender", getRootElement(), radioInterface) then 
        if isCursorOnElement(501, 235, 918, 610) then 
            local data = radioInfos["Scroll"] or 0
            if button == "mouse_wheel_down" and data < (#radioInfos["Search"] - 6) then 
                data = data + 1
            elseif button == "mouse_wheel_up" and data > 0 then 
                data = data - 1 
            end
            radioInfos["Scroll"] = data
        end
    end
end
bindKey("mouse_wheel_up", "down", rollResults)
bindKey("mouse_wheel_down", "down", rollResults)

--/ Click Functions \--

addEventHandler("onClientClick", getRootElement(), function(button, state)
    if isEventHandlerAdded("onClientRender", getRootElement(), radioInterface) then 
        if (button == "left") and (state == "down") then 
            if isCursorOnElement(555, 318, 15, 15) then 
                callSearch()
            elseif isCursorOnElement(569 + 7, 785, 40, 40) then 
                clientToggleRadio()
            elseif isCursorOnElement(1303, 800, 86, 9) then 
                if radioInfos["SelectedMusic"] then 
                    radioInfos["SelectedMusic"]["ChangeVolume"] = true
                end
            elseif isCursorOnElement(545, 799, 14, 12) then 
                if radioInfos["SelectedMusic"] then 
                    if radioInfos["Search"][radioInfos["SelectedMusic"]["Index"] - 1] then 
                        local index = radioInfos["SelectedMusic"]["Index"]
                        if radioSound[veh] and radioSound[veh].soundElement and isElement(radioSound[veh].soundElement) then
                            stopSound(radioSound[veh].soundElement)
                            radioSound[veh].soundElement = nil
                        end
                        radioInfos["SelectedMusic"] = radioInfos["Search"][radioInfos["SelectedMusic"]["Index"] - 1]
                        radioInfos["SelectedMusic"]["Index"] = index - 1
                        triggerServerEvent("VC:CallMusic", localPlayer, localPlayer, radioInfos["SelectedMusic"])
                    end
                end
            elseif isCursorOnElement(633, 799, 14, 12) then 
                if radioInfos["SelectedMusic"] then 
                    if radioInfos["Search"][radioInfos["SelectedMusic"]["Index"] + 1] then 
                        local index = radioInfos["SelectedMusic"]["Index"]
                        if radioSound[veh] and radioSound[veh].soundElement and isElement(radioSound[veh].soundElement) then
                            stopSound(radioSound[veh].soundElement)
                            radioSound[veh].soundElement = nil
                        end
                        radioInfos["SelectedMusic"] = radioInfos["Search"][radioInfos["SelectedMusic"]["Index"] + 1]
                        radioInfos["SelectedMusic"]["Index"] = index + 1
                        triggerServerEvent("VC:CallMusic", localPlayer, localPlayer, radioInfos["SelectedMusic"])
                    end
                end
            end
            if radioInfos["Search"] and #radioInfos["Search"] ~= 0 then
                local data = radioInfos["Scroll"] or 0
                for i = 1, 6 do 
                    local musicValues = radioInfos["Search"][i + data]
                    if musicValues then 
                        local heightDif = (357 - 72) + (i * 72)
                        if isCursorOnElement(531, heightDif, 842, 65) then 
                            if musicValues["duration"] then
                                radioInfos["SelectedMusic"] = musicValues
                                radioInfos["SelectedMusic"]["Index"] = i
                                triggerServerEvent("VC:CallMusic", localPlayer, localPlayer, radioInfos["SelectedMusic"])
                            end
                            break
                        end
                    end
                end
            end
        elseif (button == "left") and (state == "up") then 
            if radioInfos["SelectedMusic"] and radioInfos["SelectedMusic"]["ChangeVolume"] then
                triggerServerEvent("onPlayerRadioVolumeChange", getLocalPlayer(), radioInfos["SelectedMusic"]["ChangeVolume"])
                radioInfos["SelectedMusic"]["ChangeVolume"] = nil
            end
        end
    end
end)

--/ Radio Veh \--

radioSound = {}

addEvent("onServerToggleRadio", true)
addEventHandler("onServerToggleRadio", getLocalPlayer(), function(toggle, url, veh, volume)	
    if not isElement(veh) then
        if radioSound[veh] and radioSound[veh].soundElement and isElement(radioSound[veh].soundElement) then
            stopSound(radioSound[veh].soundElement)
            radioSound[veh].soundElement = nil
        end
        return
    end

    if toggle == true then
        local x, y, z = getElementPosition(veh)
        if radioSound[veh] then
            if radioSound[veh].soundElement and isElement(radioSound[veh].soundElement) then
                setSoundPaused(radioSound[veh].soundElement, false)
            end
        else
            if not url then
                return
            end
            local sound = playSound3D(url, x, y, z)
            if volume ~= nil then
                setSoundVolume(sound, volume)
            end
            if sound and isElement (sound) then
                setSoundMinDistance(sound, 6.0)
                setSoundMaxDistance(sound, Config["Gerais"]["MaxDistance"] )
                attachElements(sound, veh)
                
                radioSound[veh] = { }
                radioSound[veh].soundElement = sound
            end
        end
    else
        if radioSound[veh] ~= nil then
            if radioSound[veh].soundElement and isElement(radioSound[veh].soundElement) then
                setSoundPaused(radioSound[veh].soundElement, true)
            end
        end
    end
end)

addEvent("onServerRadioURLChange", true)
addEventHandler("onServerRadioURLChange", getLocalPlayer(), function(newurl, veh, volume)
    if radioSound[veh] ~= nil then
        if radioSound[veh].soundElement and isElement(radioSound[veh].soundElement) then
            stopSound(radioSound[veh].soundElement)
            radioSound[veh].soundElement = nil
        end
    
        local x, y, z = getElementPosition(veh)
        local sound = playSound3D(newurl, x, y, z)
        if volume ~= nil then
            setSoundVolume(sound, volume)
        end

        setSoundMinDistance(sound, 6.0)
        setSoundMaxDistance(sound, Config["Gerais"]["MaxDistance"] )
        attachElements(sound, veh)
    
        radioSound[veh] = { }
        radioSound[veh].soundElement = sound

    end
end)

addEvent("onServerVolumeChangeAccept", true)
addEventHandler("onServerVolumeChangeAccept", getLocalPlayer(), function(veh, newVolume)
    if veh and newVolume then
        if radioSound[veh] and radioSound[veh].soundElement and isElement(radioSound[veh].soundElement) then
            setSoundVolume(radioSound[veh].soundElement, newVolume)
        end
    end
end)

function clientToggleRadio()
	triggerServerEvent("onPlayerToggleRadio", getLocalPlayer())
end

