
local scx, scy = guiGetScreenSize()

Settings = {}
Settings.var = {}
Settings.var.blur = 1
Settings.var.optim = 4 -- dzieli rozdzielczość w efekcie mniejsza ilosc pixeli do renderowania (nieco psuje jakosc)
Settings.screenRectangle = {}

local current

function createShader()
		if getVersion ().sortable < "1.1.0" then
			outputChatBox( "Resource is not compatible with this client." )
			return
		end
        myScreenSource = dxCreateScreenSource( scx/Settings.var.optim, scy/Settings.var.optim )
        blurHShader,tecName = dxCreateShader( "shaders/blurH.fx" )
        blurVShader,tecName = dxCreateShader( "shaders/blurV.fx" )
		bAllValid = myScreenSource and blurHShader and blurVShader
		if not bAllValid then
			outputChatBox( "Could not create some things. Please use debugscript 3" )
		end
end
createShader()



function blur_createBlurRenctagle(bool)
	if bool then
			Settings.screenRectangle = {pos_x, pos_y, size_x, size_y}
			createShader()
			addEventHandler( "onClientHUDRender", root,	blur_render2)
		else
		if isElement (blurHShader) and isElement (blurVShader) then
			Settings.screenRectangle = {}
			destroyElement (blurVShader)
			destroyElement (blurHShader)
		end
		removeEventHandler( "onClientHUDRender", root,	blur_render2)
	end
end

function preRender ()
	if not Settings.var then
		return
	end
	RTPool.frameStart()
	dxUpdateScreenSource( myScreenSource )
	current = myScreenSource
	current = applyGBlurH( current, Settings.var.blur )
	current = applyGBlurV( current, Settings.var.blur )
	dxSetRenderTarget()
end
addEventHandler ("onClientRender", root, preRender)

function dxDrawBluredRectangle (pos_x, pos_y, size_x, size_y, color)
	 if bAllValid and current then
		dxDrawImageSection ( pos_x, pos_y, size_x, size_y, pos_x/Settings.var.optim, pos_y/Settings.var.optim, size_x/Settings.var.optim, size_y/Settings.var.optim, current, 0,0,0, color)
	 end
end

-----------------------------------------------------------------------------------
-- Apply the different stages
-----------------------------------------------------------------------------------
function applyGBlurH( Src, blur )
	if not Src then return nil end
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true )
	dxSetShaderValue( blurHShader, "TEX0", Src )
	dxSetShaderValue( blurHShader, "TEX0SIZE", mx,my )
	dxSetShaderValue( blurHShader, "BLUR", blur )
	dxDrawImage( 0, 0, mx, my, blurHShader )
	return newRT
end

function applyGBlurV( Src, blur )
	if not Src then return nil end
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true )
	dxSetShaderValue( blurVShader, "TEX0", Src )
	dxSetShaderValue( blurVShader, "TEX0SIZE", mx,my )
	dxSetShaderValue( blurVShader, "BLUR", blur )
	dxDrawImage( 0, 0, mx,my, blurVShader )
	return newRT
end


-----------------------------------------------------------------------------------
-- Pool of render targets
-----------------------------------------------------------------------------------
RTPool = {}
RTPool.list = {}

function RTPool.frameStart()
	for rt,info in pairs(RTPool.list) do
		info.bInUse = false
	end
end

function RTPool.GetUnused( mx, my )
	-- Find unused existing
	for rt,info in pairs(RTPool.list) do
		if not info.bInUse and info.mx == mx and info.my == my then
			info.bInUse = true
			return rt
		end
	end
	-- Add new
	local rt = dxCreateRenderTarget( mx, my )
	if rt then
		RTPool.list[rt] = { bInUse = true, mx = mx, my = my }
	end
	return rt
end