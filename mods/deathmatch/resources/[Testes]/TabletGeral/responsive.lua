screen = {guiGetScreenSize ()}
resolution = {1920, 1080}
sx, sy = screen[1] / resolution[1], screen[2] / resolution[2]

function setScreenPosition (x, y, w, h)
    return ((x / resolution[1]) * screen[1]), ((y / resolution[2]) * screen[2]), ((w / resolution[1]) * screen[1]), ((h / resolution[2]) * screen[2])
end

function isCursorOnElement (x, y, w, h)
    if isCursorShowing () then
        local cursor = {getCursorPosition ()}
        local mx, my = cursor[1] * screen[1], cursor[2] * screen[2]
        return mx > x and mx < x + w and my > y and my < y + h
    end
    return false
end

function formatNumber(number, sep)
	assert(type(tonumber(number))=="number", "Bad argument @'formatNumber' [Expected number at argument 1 got "..type(number).."]")
	assert(not sep or type(sep)=="string", "Bad argument @'formatNumber' [Expected string at argument 2 got "..type(sep).."]")
	local money = number
	for i = 1, tostring(money):len()/3 do
		money = string.gsub(money, "^(-?%d+)(%d%d%d)", "%1"..sep.."%2")
	end
	return money
end


function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
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

_dxCreateFont = dxCreateFont
function dxCreateFont (path, scale, ...)
    local _, scale, _, _ = setScreenPosition (0, scale, 0, 0)

    return _dxCreateFont (path, scale, ...)
end

_dxDrawRectangle = dxDrawRectangle
function dxDrawRectangle (x, y, w, h, ...)
    local x, y, w, h = setScreenPosition (x, y, w, h)
    
    return _dxDrawRectangle (x, y, w, h, ...)
end

_dxDrawImage = dxDrawImage
function dxDrawImage (x, y, w, h, ...)
    local x, y, w, h = setScreenPosition (x, y, w, h)
    
    return _dxDrawImage (x, y, w, h, ...)
end

_dxDrawImageSection = dxDrawImageSection
function dxDrawImageSection (x, y, w, h, ...)
    local x, y, w, h = setScreenPosition (x, y, w, h)
    
    return _dxDrawImageSection (x, y, w, h, ...)
end

_dxDrawText = dxDrawText
function dxDrawText (text, x, y, w, h, ...)
    local x, y, w, h = setScreenPosition (x, y, w, h)
    
    return _dxDrawText (text, x, y, (x + w), (y + h), ...)
end

_isCursorOnElement = isCursorOnElement
function isCursorOnElement (x, y, w, h)
    local x, y, w, h = setScreenPosition (x, y, w, h)
    return _isCursorOnElement (x, y, w, h)
end

svgsRectangle = {};
function dxDrawRoundedRectangle(x, y, w, h, radius, color, post)
    if not svgsRectangle[radius] then
        svgsRectangle[radius] = {}
    end
    if not svgsRectangle[radius][w] then
        svgsRectangle[radius][w] = {}
    end
    if not svgsRectangle[radius][w][h] then
        local path = string.format([[
        <svg width="%s" height="%s" viewBox="0 0 %s %s" fill="none" xmlns="http://www.w3.org/2000/svg">
        <rect opacity="1" width="%s" height="%s" rx="%s" fill="#FFFFFF"/>
        </svg>
        ]], w, h, w, h, w, h, radius)
        svgsRectangle[radius][w][h] = svgCreate(w, h, path)
    end
    if svgsRectangle[radius][w][h] then
        dxDrawImage(x, y, w, h, svgsRectangle[radius][w][h], 0, 0, 0, color, post or false)
    end
end

local buttons = {};

function dxDrawButton(index, x, y, w, h, color2, next_color, text, alpha, font)
    if not buttons[index] then
        buttons[index] = {
            pos = {x, y, w, h},
            holding = false,
            anim_color2 = color2,
            tick = getTickCount()
        }
    end
    if isCursorOnElement(x, y, w, h) and not buttons[index].holding then
        buttons[index].holding = true;
        buttons[index].tick = getTickCount();
    elseif not isCursorOnElement(x, y, w, h) and buttons[index].holding then
        buttons[index].holding = false;
        buttons[index].tick = getTickCount();
    end
    if buttons[index].holding and not getKeyState("mouse1") then
        buttons[index].anim_color2 = {interpolateBetween(buttons[index].anim_color2[1], buttons[index].anim_color2[2], buttons[index].anim_color2[3], next_color[1], next_color[2], next_color[3], (getTickCount()-buttons[index].tick)/500, "Linear")}
    else
        buttons[index].anim_color2 = {interpolateBetween(buttons[index].anim_color2[1], buttons[index].anim_color2[2], buttons[index].anim_color2[3], color2[1], color2[2], color2[3], (getTickCount()-buttons[index].tick)/500, "Linear")}
    end
    buttons[index].anim_color2[4] = alpha;
    dxDrawRoundedRectangle(x, y, w, h, 5, tocolor(unpack(buttons[index].anim_color2)), false)
    if text then
        dxDrawText(text, x, y, w, h, tocolor(255, 255, 255, alpha or 255), 1, font, "center", "center")
    end
end