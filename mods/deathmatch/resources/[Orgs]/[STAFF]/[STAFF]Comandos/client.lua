
local blips = false
local blips2 = false
local godMode = false
local flyingState = false
local blipsDist = 200
local keys = {}
keys.up = "up"
keys.down = "up"
keys.f = "up"
keys.b = "up"
keys.l = "up"
keys.r = "up"
keys.a = "up"
keys.s = "up"
keys.m = "up"

addEvent("eventQueda",true)
addEventHandler("eventQueda",getLocalPlayer(),function()
  local player = getLocalPlayer()
  if canPedBeKnockedOffBike(player) then
    setPedCanBeKnockedOffBike(player,false)
    exports.Scripts_Dxmessages:createNotification("Sem quedas ativado!","success");
  else
    setPedCanBeKnockedOffBike(player,true)
    exports.Scripts_Dxmessages:createNotification("Sem quedas desativado!","error");
  end
end)

addEvent("onClientFlyToggle",true)
addEventHandler("onClientFlyToggle",getLocalPlayer(),function()
flyingState = not flyingState

if flyingState then
  addEventHandler("onClientRender",getRootElement(),flyingRender)
  bindKey("lshift","both",keyH)
  bindKey("rshift","both",keyH)
  bindKey("lctrl","both",keyH)
  bindKey("rctrl","both",keyH)

  bindKey("forwards","both",keyH)
  bindKey("backwards","both",keyH)
  bindKey("left","both",keyH)
  bindKey("right","both",keyH)

  bindKey("lalt","both",keyH)
  bindKey("space","both",keyH)
  bindKey("ralt","both",keyH)
  bindKey("mouse1","both",keyH)
  --setElementFrozen(getLocalPlayer(),true)
  setElementCollisionsEnabled(getLocalPlayer(),false)
else
  removeEventHandler("onClientRender",getRootElement(),flyingRender)
  unbindKey("mouse1","both",keyH)
  unbindKey("lshift","both",keyH)
  unbindKey("rshift","both",keyH)
  unbindKey("lctrl","both",keyH)
  unbindKey("rctrl","both",keyH)

  unbindKey("forwards","both",keyH)
  unbindKey("backwards","both",keyH)
  unbindKey("left","both",keyH)
  unbindKey("right","both",keyH)

  unbindKey("space","both",keyH)

  keys.up = "up"
  keys.down = "up"
  keys.f = "up"
  keys.b = "up"
  keys.l = "up"
  keys.r = "up"
  keys.a = "up"
  keys.s = "up"
  --setElementFrozen(getLocalPlayer(),false)
  setElementCollisionsEnabled(getLocalPlayer(),true)
end
end)

function flyingRender()
  local x,y,z = getElementPosition(getLocalPlayer())
  local speed = 10
  if keys.a=="down" then
    speed = 3
  elseif keys.s=="down" then
    speed = 50
  elseif keys.m=="down" then
    speed = 300
  end

  if keys.f=="down" then
    local a = rotFromCam(0)
    setElementRotation(getLocalPlayer(),0,0,a)
    local ox,oy = dirMove(a)
    x = x + ox * 0.1 * speed
    y = y + oy * 0.1 * speed
  elseif keys.b=="down" then
    local a = rotFromCam(180)
    setElementRotation(getLocalPlayer(),0,0,a)
    local ox,oy = dirMove(a)
    x = x + ox * 0.1 * speed
    y = y + oy * 0.1 * speed
  end

  if keys.l=="down" then
    local a = rotFromCam(-90)
    setElementRotation(getLocalPlayer(),0,0,a)
    local ox,oy = dirMove(a)
    x = x + ox * 0.1 * speed
    y = y + oy * 0.1 * speed
  elseif keys.r=="down" then
    local a = rotFromCam(90)
    setElementRotation(getLocalPlayer(),0,0,a)
    local ox,oy = dirMove(a)
    x = x + ox * 0.1 * speed
    y = y + oy * 0.1 * speed
  end

  if keys.up=="down" then
    z = z + 0.1*speed
  elseif keys.down=="down" then
    z = z - 0.1*speed
  end

  setElementPosition(getLocalPlayer(),x,y,z)
end

function keyH(key,state)
  if key=="lshift" or key=="rshift" then
    keys.s = state
  end
  if key=="lctrl" or key=="rctrl" then
    keys.down = state
  end
  if key=="forwards" then
    keys.f = state
  end
  if key=="backwards" then
    keys.b = state
  end
  if key=="left" then
    keys.l = state
  end
  if key=="right" then
    keys.r = state
  end
  if key=="lalt" or key=="ralt" then
    keys.a = state
  end
  if key=="space" then
    keys.up = state
  end
  if key=="mouse1" then
    keys.m = state
  end
end

function rotFromCam(rzOffset)
  local cx,cy,_,fx,fy = getCameraMatrix(getLocalPlayer())
  local deltaY,deltaX = fy-cy,fx-cx
  local rotZ = math.deg(math.atan((deltaY)/(deltaX)))
  if deltaY >= 0 and deltaX <= 0 then
    rotZ = rotZ+180
  elseif deltaY <= 0 and deltaX <= 0 then
    rotZ = rotZ+180
  end
  return -rotZ+90 + rzOffset
end

function dirMove(a)
  local x = math.sin(math.rad(a))
  local y = math.cos(math.rad(a))
  return x,y
end


function math.round(number, decimals, method)
  decimals = decimals or 0
  local factor = 10 ^ decimals
  if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
else return tonumber(("%."..decimals.."f"):format(number)) end
end

--LONG VISION
local long = false
local fog = nil
local clouds = nil
local Far = nil
addCommandHandler("long",function(player)
	local player = getLocalPlayer() 
  function confirmAcl(ac)
    if long==false then
			far=getFarClipDistance()
			clouds=getCloudsEnabled()
			fog=getFogDistance()
			setFarClipDistance(10000)
			setCloudsEnabled(false)
			setFogDistance(0)
			long=true
      exports.Scripts_Dxmessages:createNotification("LongVision Ativado", "success")
		else
			setFarClipDistance(far)
			setCloudsEnabled(clouds)
			setFogDistance(fog)
      exports.Scripts_Dxmessages:createNotification("LongVision Desativado", "error")
			long=false
		end
    removeEventHandler('staff:confirmAcl',localPlayer,confirmAcl)
  end
  addEvent('staff:confirmAcl',true)
  addEventHandler('staff:confirmAcl',localPlayer,confirmAcl)    
	triggerServerEvent("aclVerificar",root,player,"Staff")
end)


addEvent("Egodmode",true)
addEventHandler("Egodmode",getLocalPlayer(),function(sts)
  godMode=sts
  function cancel()
    if godMode then
      cancelEvent()
    end
  end
  if godMode then
    addEventHandler("onClientPlayerDamage",localPlayer,cancel)
    addEventHandler("onClientPlayerStealthKill",localPlayer,cancel)
  else
    removeEventHandler("onClientPlayerDamage",localPlayer,cancel)
    removeEventHandler("onClientPlayerStealthKill",localPlayer,cancel)
  end
end)

function startBlips()
  function confirmAcl(ac)
    if(blips==false)then
      local drawDistance = blipsDist
      g_StreamedInPlayers = {}
      function onClientRender()
        local cx, cy, cz, lx, ly, lz = getCameraMatrix()
        local players = getElementsByType("player")
        for k, player in pairs(players) do
          if isElement(player) and player~=localPlayer then
            do
              local vx, vy, vz = getPedBonePosition(player, 8)
              local dist = getDistanceBetweenPoints3D(cx, cy, cz, vx, vy, vz)
              if dist < drawDistance and isLineOfSightClear(cx, cy, cz, vx, vy, vz, true, false, false) then
                local x, y = getScreenFromWorldPosition(vx, vy, vz + 0.3)
                if x and y then
                  local ID = getElementData(player, "ID") or "N/A"
                  local Nome = getPlayerName(player)
                  local ACL = getElementData(player, "ACLs")
                  local Group = tostring(table.concat(ACL,"-"))
                  local w = dxGetTextWidth(ID, 0.1, "default-bold")
                  local wG = dxGetTextWidth(Group, 0.1, "default-bold")
                  local h = dxGetFontHeight(1, "default-bold")
                  
                  dxDrawText("["..ID.."] "..Nome, x-1 , y-17,x-1 , y-17, tocolor(255, 255, 255), 1.20, "default-bold", "center", "center", false, false, false, false, false)		
                
                  function table.removeValue(tab, val)
                    for index, value in ipairs(tab) do
                        if value == val then
                            table.remove(tab, index)
                            return index
                        end
                    end
                  return false
                  end

                  if(#ACL>1)then
                    table.removeValue(ACL, "Everyone")
                    Group = table.concat(ACL,"-")
                    wG = dxGetTextWidth(Group, 0.1, "default-bold")
                  else
                    Group = "Desempregado"
                  end
                  dxDrawText(Group, x-1 , y-1,x-1 , y-1, tocolor(0, 140, 160), 1.20, "default-bold", "center", "center", false, false, false, false, false)		
                end
              end
            end
          end
        end
      end
      addEventHandler("onClientRender", root, onClientRender)
      exports.Scripts_Dxmessages:createNotification("Blips Ativado", "success")
      blips=true
    else
      removeEventHandler("onClientRender", root, onClientRender)
      exports.Scripts_Dxmessages:createNotification("Blips Desativado", "error")
      blips=false
    end
    removeEventHandler('staff:confirmAcl',localPlayer,confirmAcl)
  end
  addEvent('staff:confirmAcl',true)
  addEventHandler('staff:confirmAcl',localPlayer,confirmAcl)
  triggerServerEvent("aclVerificar",root,localPlayer,"Staff")
end
addCommandHandler("blips",startBlips)

function startBlips2()
  function confirmAcl(ac)
    if ac then
      if(blips2==false)then
        function tst()
          local result = getElementsByType ("player")
          if result and #result ~= 0 then
              for i = 1, #result do
                  local other = result[i]
                  if isElement (other) then
                      if other ~= localPlayer then
                          local x, y, z = getElementPosition (localPlayer)
                          local ax, ay, az = getElementPosition (other)
                          if getDistanceBetweenPoints3D (x, y, z, ax, ay, az) <= blipsDist and getElementHealth (other) > 0 then
                              dxDrawLine3D (x, y, z, ax, ay, az, tocolor (65,105,225), 1, true)
                          end
                      end
                  else
                      table.remove (result, i)
                  end
              end
          end
        end
        addEventHandler ("onClientRender", getRootElement (), tst)
        exports.Scripts_Dxmessages:createNotification("Blips2 Ativado", "success")
        blips2=true    
      else
        removeEventHandler("onClientRender", getRootElement(), tst)
        exports.Scripts_Dxmessages:createNotification("Blips2 Desativado", "error")
        blips2=false
      end
    end 
    
    removeEventHandler('staff:confirmAcl',localPlayer,confirmAcl)
  end
  addEvent('staff:confirmAcl',true)
  addEventHandler('staff:confirmAcl',localPlayer,confirmAcl)
  triggerServerEvent("aclVerificar",root,localPlayer,"Staff")
end
addCommandHandler("blips2", startBlips2)



