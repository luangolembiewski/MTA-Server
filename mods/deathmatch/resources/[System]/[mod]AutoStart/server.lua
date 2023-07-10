
scripts = {
	[1] = {
		

	
	--ID
	"[mod]ID",
	"[mod]IDTag",

	--MessageBOX
	"Scripts_Dxmessages",
	"mistic_notify",
	"notify",

    --SISTEM
	"[mod]PainelLogin",
    "[Log]JoinQuit",
	"[mod]SaveSystem",
	"[mod]LoadingScreen",
	"[mod]Help",
	"[mod]NoSpeedBlur",

	--SCRIPT
	"[mod]GerenciadorMods",
	"[mod]Bau",
	"[mod]Inventario",
	"Blur",
	"[mod]ComandosBasicos",
	"[mod]PortasVehicle",
    "[mod]Suspensao",
    "[mod]ControleRodas",
	"[mod]Radio",
   
	

	--HANDS
	--"[Hand]Veiculos",

	--VEICULOS Obrigatórios

	--STAFF
	"[STAFF]Comandos",

	},
}

function startServer(id)
	local sucess = 0
	local fail = 0
	local att = 0
	local size = #scripts[(id)]	
	for i=1 , size do
		local resource = getResourceFromName(scripts[tonumber(id)][tonumber(i)])
		if (resource) then
			resstate = startResource(resource, true)
			if resstate then
				sucess = sucess + 1
				outputDebugString("* Resource: '"..scripts[tonumber(id)][tonumber(i)].."' Iniciado!" )	
			else
				att = att + 1
			end
		else
			fail = fail + 1
			outputDebugString("* Resource: '"..scripts[tonumber(id)][tonumber(i)].."' não encontrado, indo para o próximo...")
		end
	end
end

function displayLoadedRes ( res )
    local thisResource = getThisResource ( )
    local resourceName = getResourceName ( thisResource )
	if res == thisResource then
	    startServer ( tonumber ( 1 ) )
	end
end
addEventHandler ( "onResourceStart", getRootElement ( ), displayLoadedRes )