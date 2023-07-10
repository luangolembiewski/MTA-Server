local joinX = 1549.187
local joinY = -1365.566
local joinZ = 326.211
local joinD = 10
local joinSkin = 0 -- skin ao entrar no servidor
local spawnSkin = 0
local joinMoney = 500 -- Dinheiro ao entrar no servidor

local spawnX = 2032.3931884766
local spawnY = -1416.2508544922
local spawnZ = 16.9921875

function spawnOnJoin()
    spawnPlayer(source, joinX, joinY, joinZ, 0 , joinSkin) 
	fadeCamera(source, true)
	setCameraTarget(source, source)
	setElementDimension(source,joinD)
	givePlayerMoney(source, joinMoney)
	showChat(source,false)
end


function spawnOnDead(killer, bodypart)
	setTimer(spawnPlayer, 3000, 1, source, spawnX, spawnY, spawnZ, 0, spawnSkin)
	setCameraTarget(source, source)
	if tonumber(getElementData(source, "ID")) == 1 then
		setTimer(spawnPlayer, 3000, 1, source, spawnX, spawnY, spawnZ, 0, 100)
	end
end




-- Event handlers
addEventHandler("onPlayerJoin", getRootElement(), spawnOnJoin)
addEventHandler("onPlayerWasted", getRootElement(), spawnOnDead)