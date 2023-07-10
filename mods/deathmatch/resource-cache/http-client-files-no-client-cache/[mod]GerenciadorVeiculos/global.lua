availableMods = { -- nome do veiculo dentro da pasta, id veiculo, nome
	-- Ferrari --
	["FerrariGTB/ferrariGTB"] = {415, "Ferrari GTB", true},
	--R34
	["NissanR34/nissanR34"] = {549, "Nissan R34", true},
	
	--[[ -- Chevette --
	["Chevette/chevette"] = {491, "Chevette", true},
    -- Dodge --
	["DodgeHellcat/dodgeHellcat"] = {402, "Dodge Hellcat", true},
	-- Fusca --
	["Fusca/fusca"] = {545, "Fusca", true},
    -- Gol --
	["GolGTI/golGti"] = {496, "Gol GTI", true},
    -- Kuruma --
	["Kuruma/kuruma"] = {445, "Kuruma", true},
    -- Mercedes --
	["Mercedes63S/mercedes63S"] = {426, "Mercedes 63S", true},
    -- R34 --
	["NissanR34/nissanR34"] = {549, "Nissan R34", true},
    -- R35 --
	["NissanR35/nissanR35"] = {494, "Nissan R35", true},
    -- Supra --
	["Supra/supra"] = {429, "Supra", true}, ]]
	

}

vehicleNames = {}

for k, v in pairs(availableMods) do
	local model = tonumber(v[1]) or getVehicleModelFromName(v[1])

	if model then
		vehicleNames[model] = v[2]
	end
end

_getVehicleNameFromModel = getVehicleNameFromModel
_getVehicleName = getVehicleName

function getVehicleNameFromModel(model)
	if vehicleNames[model] then
		return vehicleNames[model]
	end

	return _getVehicleNameFromModel(model)
end

function getVehicleName(vehicleElement)
	local model = getElementModel(vehicleElement)

	if vehicleNames[model] then
		return vehicleNames[model]
	end

	return _getVehicleName(vehicleElement)
end

function getVehicleNameList()
	local list = {}

	for k, v in pairs(availableMods) do
		table.insert(list, v[2])
	end

	return list
end