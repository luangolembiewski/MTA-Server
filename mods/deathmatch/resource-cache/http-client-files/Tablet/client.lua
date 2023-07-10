local resoureName = getResourceName(getThisResource())
local screenW, screenH = guiGetScreenSize()
local link = "http://mta/"..resoureName.."/html/index.html"

local lar = screenW*0.8
local alt = screenH*0.8
x, y = (screenW-lar)/2, (screenH-alt)/2

addEvent("tablet",true)
addEventHandler("tablet",getLocalPlayer(),function(status)
	local Browser = guiCreateBrowser(x,y,lar,alt, true,true,false)
	local getBrowser = guiGetBrowser(Browser)
    
	addEventHandler("onClientBrowserCreated", getBrowser, 
	function()
		showCursor(true)
		loadBrowserURL(source, link)

		function fechar(button,press)
			if(button=="backspace") then
				destroyElement(Browser)
				showCursor(false)
				removeEventHandler("onClientKey",root,fechar)
			end
		end
		addEventHandler("onClientKey",root,fechar)
	end)
	addEventHandler("onClientBrowserDocumentReady",getBrowser,
	function()
		executeBrowserJavascript(getBrowser, screenW, screenH)
	end)
end)
