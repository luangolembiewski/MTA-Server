
local screenW, screenH = guiGetScreenSize()
local x, y = (screenW/1366), (screenH/768)
local exibindo_painel = false
local textoPainel=nil
local cmd = nil

function painel()
        dxDrawImage(0, 0, screenW, screenH , "Files/Background.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        
        local a = 0.3000
        local b = 0.3299
        local c,d
        local escala = 1.40
        for x,y in ipairs(cmd)
        do
            d=x
        end
        escala = 1.4
        c = 0.035
        if d>40 then 
            showCursor(false)
            showChat(true)
            removeEventHandler("onClientRender",getRootElement(),painel)
            exibindo_painel = false  
            return exports.Scripts_Dxmessages:createNotification("Painel excedeu o limite de 40 linhas", "error"); 
        end
        if d>18 then
            escala = 40/d
            c = 0.66/d
        end
        --escala = 1
        --c = 0.0165
        for i, v in ipairs(textoPainel)do
            --Comandos
            dxDrawText(textoPainel[i].nome, screenW * 0.03, screenH * a, screenW * 0.4473, screenH * b, tocolor(255, 255, 255, 255), escala, "default-bold", "left", "top", false, false, true, false, false)
            
            --Informações
            dxDrawText(textoPainel[i].info, screenW * 0.6, screenH * a, screenW * 0.8719, screenH * b, tocolor(255, 255, 255, 255), escala, "default-bold", "left", "top", false, false, true, false, false)

            a=a+c
            b=b+c
        end
        dxDrawText("'Backspace' PARA FECHAR O PAINEL", screenW * 0.38, screenH * 0.965, screenW * 0.6719, screenH * 0.9949, tocolor(255, 255, 255, 255), 1.5, "default-bold", "left", "top", false, false, true, false, false)
end

function painelHelp(comandos)
    textoPainel = comandos
    cmd = comandos
    if exibindo_painel == false then
        showCursor(true)
        showChat(false)
        addEventHandler("onClientRender",getRootElement(),painel)
        exibindo_painel = true
    else
        showCursor(false)
        showChat(true)
        removeEventHandler("onClientRender",getRootElement(),painel)
        exibindo_painel = false
    end
     
end

addEvent("Evehelp",true)
addEventHandler("Evehelp",getRootElement(), painelHelp, comandos)

bindKey("f10","down",function()
    triggerServerEvent("helpKey",getLocalPlayer(),getLocalPlayer())
end)
bindKey("backspace","down",function()
    if (exibindo_painel == true) then
        showCursor(false)
        showChat(true)
        removeEventHandler("onClientRender",getRootElement(),painel)
        exibindo_painel = false
    end
end)

