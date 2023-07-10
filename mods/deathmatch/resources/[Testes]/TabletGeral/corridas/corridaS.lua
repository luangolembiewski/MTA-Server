
local db = nil
local corridas={}

local function setAllCorridas(player)
    triggerClientEvent(player,"corrida:SetCorridas",player,corridas)
end

function startDB()
    db = dbConnect("sqlite", "corridas/assets/database/corridas.db")
    if db then
        dbExec(db, "CREATE TABLE IF NOT EXISTS corridas (id INTEGER NOT NULL UNIQUE PRIMARY KEY AUTOINCREMENT,cdsStartMarker BLOB,startMarker,nome,vagas,corredores BLOB,points BLOB)")
        return print("Servidor corridas iniciado")
    end
    return print("Erro ao iniciar corridas")
end
addEvent("corrida:StartDB",true)
addEventHandler("corrida:StartDB", getRootElement(),startDB)

function getAllCorridas()
    if db then
        local query = dbPoll(dbQuery(db, "SELECT * FROM corridas"), -1)
        if #query > 0 then
            for i, v in pairs(query) do
                table.insert(corridas,i,
                {
                    id = v.id,
                    cdsStartMarker = fromJSON(v.cdsStartMarker),
                    startMarker = v.startMarker,
                    nome = v.nome,
                    vagas = v.vagas,
                    corredores = fromJSON(v.corredores),
                    points = fromJSON(v.points),
                })
            end
        end
        outputChatBox("Dados de corridas carregados")
        setAllCorridas(source)
    end
end
addEvent("corrida:GetAllCorridas",true)
addEventHandler("corrida:GetAllCorridas", getRootElement(),getAllCorridas)



function getCorrida(id)
    local query = dbPoll(dbQuery(db, "SELECT * FROM corridas WHERE ID=?",id), -1)
end
addEvent("corrida:getCorrida",true)
addEventHandler("corrida:getCorrida", getRootElement(),getCorrida)


function createCorrida(corrida)
    corridasT = {
         [1] = {
            id = 1,
            cdsStartMarker = {1358.873, -1754.142, 13.36},
            startMarker = {},
            nome = "A",
            vagas = 2,
            corredores = {7,8},
            points = {}
        },
    }
    if(dbExec(db, "INSERT INTO corridas VALUES(?, ?, ?, ?, ?, ?, ?)",corridas[1].id,toJSON(corridasT[1].cdsStartMarker),toJSON(corridasT[1].startMarker),corridasT[1].nome,corridasT[1].vagas,toJSON(corridasT[1].corredores),toJSON(corridasT[1].points ))) then 
        outputChatBox("Corrida criada com sucesso!")
    else
        outputChatBox("Erro ao criar corrida!")
    end
end
addEvent("corrida:createCorrida",true)
addEventHandler("corrida:createCorrida", getRootElement(),createCorrida)


function entrarCorrida(corredores,id)
    if(dbExec(db,"UPDATE corridas SET corredores=? WHERE id=?",corredores,id)) then 
        outputChatBox("Você entrou na corrida!")
    else
        outputChatBox("Erro ao entrar corrida!")
    end
end
addEvent("corrida:entrarCorrida",true)
addEventHandler("corrida:entrarCorrida", getRootElement(),entrarCorrida)

function deleteCorrida()end
function updateCorrida()end

addCommandHandler("addCorrida",createCorrida)

