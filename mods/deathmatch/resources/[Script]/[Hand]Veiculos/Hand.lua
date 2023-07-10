local dados = nil
local x = nil
veiculos = {
	[1] = {
		name = "Ferrari",
		type = "415",
		value = "1475 2950 0.3 0 0 -0.25 70 1.2 0.9 0.215 5 480 18 30 4 p 13 0.6 false 20 1.2 0.19 0 0.25 -0.16 0.5 0.4 0.37 0.54 105000 40002004 1C08000 0 0 1"
	},
	[2] = {
		name = "R34",
		type = "549",
		value = "1475 2950 0.3 0 0 -0.25 70 1.2 0.9 0.215 5 480 18 30 4 p 13 0.6 false 20 1.2 0.19 0 0.25 -0.16 0.5 0.4 0.37 0.54 105000 40002004 1C08000 0 0 1"
	},
}

function subsDados(dados)
	if dados[15] == "4" then
		dados[15]="awd"
	else if dados[15] == "r" then
		dados[15]="rwd"
	else if dados[15] == "f" then
		dados[15]="fwd"
	else print("Erro: Hand")
		end
		end
	end
	if dados[16] == "p" then
		dados[16]="petrol"
	else if dados[16] == "d" then
		dados[16]="diesel"
	else if dados[16] == "e" then
		dados[16]="electric"
	else print("Erro: Hand")
		end
		end
	end
end

function loadHandling(v,type,name,dados)
	if getElementModel(v) == tonumber(type) then 	
		--Corpo
		setVehicleHandling(v, "mass", dados[1])
		setVehicleHandling(v, "turnMass", dados[2])
		setVehicleHandling(v, "dragCoeff", dados[3])
		setVehicleHandling(v, "centerOfMass", { dados[4],dados[5],dados[6] } )
		setVehicleHandling(v, "percentSubmerged", dados[7])
		--setVehicleHandling(v, "suspensionForceLevel", 0.85)
		--setVehicleHandling(v, "suspensionDamping", 0.15)
		setVehicleHandling(v, "suspensionUpperLimit", dados[24])
		setVehicleHandling(v, "suspensionLowerLimit", dados[25])
		--Rodas
		setVehicleHandling(v, "tractionMultiplier", dados[8])
		setVehicleHandling(v, "tractionLoss", dados[9])
		setVehicleHandling(v, "tractionBias", dados[10])
		setVehicleHandling(v, "brakeDeceleration", dados[17])
		--Motor
		setVehicleHandling(v, "numberOfGears", dados[11])
		setVehicleHandling(v, "maxVelocity", dados[12]) 
		setVehicleHandling(v, "engineAcceleration", dados[13]) 
		setVehicleHandling(v, "engineInertia", dados[14])
		setVehicleHandling(v, "driveType", dados[15]) 
		setVehicleHandling(v, "engineType", dados[16])
		setVehicleHandling(v, "collisionDamageMultiplier", dados[29])


		setVehicleHandling(v, "ABS", true)
		setVehicleHandling(v, "steeringLock", 47)
		setVehicleHandling(v, "headLight", 0)
		setVehicleHandling(v, "tailLight", 1)
		setVehicleHandling(v, "animGroup", 0)
		print("[HAND]Veiculo: "..name.." Carregado!")
	end			
end 		

function loadHandlings()
	for k, v in ipairs(getElementsByType("vehicle")) do
		for w,x in ipairs(veiculos)
		do
			dados = split(veiculos[w].value,' ')
			subsDados(dados)
			loadHandling(v,veiculos[w].type,veiculos[w].name,dados)
		end
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadHandlings)

function vehicleEnter()
	for k, v in ipairs(getElementsByType("vehicle")) do
		for w,x in ipairs(veiculos)
		do
			dados = split(veiculos[w].value,' ')
			subsDados(dados)
			loadHandling(source,veiculos[w].type,veiculos[w].name,dados)
		end
	end
end
addEventHandler("onVehicleEnter", getRootElement(), vehicleEnter)