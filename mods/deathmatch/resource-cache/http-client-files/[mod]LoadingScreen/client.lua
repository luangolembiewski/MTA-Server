local screenW, screenH = guiGetScreenSize()
local rotation = 0
local font = dxCreateFont("fontes/RobotoBold.ttf", 13)
local tempo = nil

function start()
	toggleAllControls(false)
	addEventHandler("onClientRender", root, render)
	tempo = setTimer(function()
		if not isTransferBoxActive() then
			if isElement(localPlayer) then
				removeEventHandler("onClientRender", root, render)
				killTimer(tempo)
				tempo = nil
				toggleAllControls(true)
			end
		end
	end, 5000, 0)
end
addEventHandler("onClientResourceStart", resourceRoot, start)

function render()
	dxDrawImage(0, 0, screenW, screenH, "gfx/background.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	dxDrawText("Baixando recursos...", screenW * 0.0000, screenH * 0.9388, screenW * 1.0000, screenH * 1.0000, tocolor(255, 255, 255, 255), 1, font, "center", "center", false, false, true, false, false)
	dxDrawImage(screenW * 0.4817, screenH * 0.8646, screenW * 0.0366, screenH * 0.0651, "gfx/loading.png", rotation, 0, 0, tocolor(255, 255, 255, 255), true)
	rotation = rotation + 6
end