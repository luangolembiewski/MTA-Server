--[[
 ______     ______     ______   __  __     ______     __     ______     __  __     ______      ______     __  __       
/\  ___\   /\  __ \   /\  == \ /\ \_\ \   /\  == \   /\ \   /\  ___\   /\ \_\ \   /\__  _\    /\  == \   /\ \_\ \      
\ \ \____  \ \ \/\ \  \ \  _-/ \ \____ \  \ \  __<   \ \ \  \ \ \__ \  \ \  __ \  \/_/\ \/    \ \  __<   \ \____ \     
 \ \_____\  \ \_____\  \ \_\    \/\_____\  \ \_\ \_\  \ \_\  \ \_____\  \ \_\ \_\    \ \_\     \ \_____\  \/\_____\    
  \/_____/   \/_____/   \/_/     \/_____/   \/_/ /_/   \/_/   \/_____/   \/_/\/_/     \/_/      \/_____/   \/_____/    
                                                                                                                       
 ______   __  __     __     ______     ______     ______        ______     ______     ______                           
/\__  _\ /\ \_\ \   /\ \   /\  ___\   /\  __ \   /\  ___\      /\  ___\   /\  ___\   /\  == \                          
\/_/\ \/ \ \  __ \  \ \ \  \ \ \__ \  \ \  __ \  \ \___  \     \ \___  \  \ \ \____  \ \  __<                          
   \ \_\  \ \_\ \_\  \ \_\  \ \_____\  \ \_\ \_\  \/\_____\     \/\_____\  \ \_____\  \ \_\ \_\                        
    \/_/   \/_/\/_/   \/_/   \/_____/   \/_/\/_/   \/_____/      \/_____/   \/_____/   \/_/ /_/                                                                                                                                    
--]]

------------------/CONFIG UTIL\------------------
local screenW, screenH = guiGetScreenSize ()
local x, y = screenW/1280, screenH/720

local dxfont0_font = dxCreateFont('assets/font/font.ttf', y*9)

local data = { }

function createEventHandler (event, ...)
    addEvent (event, true)
    addEventHandler (event, getRootElement(), ...)
end

function removeHex (s)
    if type (s) == "string" then
        while (s ~= s:gsub ("#%x%x%x%x%x%x", "")) do
            s = s:gsub ("#%x%x%x%x%x%x", "")
        end
    end
    return s or false
end

function drawBorde(x, y, w, h, borderColor, bgColor, postGUI)
    if (x and y and w and h) then
        if (not borderColor) then
            borderColor = tocolor(0, 0, 0, 200)
        end
      
        if (not bgColor) then
            bgColor = borderColor
        end
        postGUI = true

        dxDrawRectangle(x, y, w, h, bgColor, postGUI)

        dxDrawRectangle(x + 2, y - 1, w - 4, 1, borderColor, postGUI) -- top
        dxDrawRectangle(x + 2, y + h, w - 4, 1, borderColor, postGUI) -- bottom
        dxDrawRectangle(x - 1, y + 2, 1, h - 4, borderColor, postGUI) -- left
        dxDrawRectangle(x + w, y + 2, 1, h - 4, borderColor, postGUI) -- right
    end
end
------------------/CONFIG UTIL\------------------

------------------/CONFIG DX\------------------
addEventHandler ('onClientRender', getRootElement(),
function ()
    for i, v in ipairs (data) do
        if i > 3 then
            table.remove (data, 1)
        end
        local width = dxGetTextWidth (removeHex(v.message), 1, dxfont0_font)
        if v.visible then
            v.alpha = v.alpha
        end
        if getTickCount () - v.tick > v.segundos then
            table.remove (data, 1)
        end
        local progress = (getTickCount () - v.tick) / 600
        local animation = interpolateBetween (0, 0, 0, screenW + x*82 - width, 0, 0, progress, 'Linear')
        local barra = interpolateBetween (0, 0, 0, x*35 + width, 0, 0, (getTickCount() - v.tick)/v.segundos, 'Linear')
        dxDrawRectangle(animation - screenW - x*75 + width, y*472 + i * y* -40, x*42 + width, y*34, tocolor(v.color[1], v.color[2], v.color[3], v.alpha))
        dxDrawRectangle(animation - screenW - x*75 + width, y*472 + i * y* -40, barra, y*34, tocolor(v.color[1] - 0, v.color[2] - 0, v.color[3] - 0, v.alpha - 20))
        dxDrawText(v.message, animation - screenW - x*55 + width, y*482 + i * y*-40, x*0.7 + width, y*445, tocolor(255, 255, 255, 255), 1.00, dxfont0_font, 'left', 'top', false, false, true, true, false)
    end
end)
------------------/CONFIG DX\------------------

------------------/CONFIG DX CONTROLLER\------------------
createEventHandler ('serverNotifys2',
function (message, type)
    if config[type] then
        local settings = setmetatable({
            message = message,
            type = type,
            visible = true,
            tick = getTickCount (),
            segundos = config[type][1].Segundos*1000,
            alpha = config[type][1].A,
            color = { },
        }, data)
        table.insert (data, settings)
        if settings then
            settings.color = {config[type][1].R, config[type][1].G, config[type][1].B}
            local sound = playSound ('assets/sfx/'..settings.type..'.mp3', false)
            setSoundVolume (sound, 0.2)
        end
    else
        local settings = setmetatable({
            message = message,
            type = "info",
            visible = true,
            tick = getTickCount (),
            segundos = 7000,
            alpha = 255,
            color = { },
        }, data)
        table.insert (data, settings)
        if settings then
            settings.color = {79, 168, 227}
            local sound = playSound ('assets/sfx/info.mp3', false)
            setSoundVolume (sound, 0.2)
        end
    end
    return false
end)
------------------/CONFIG DX CONTROLLER\------------------