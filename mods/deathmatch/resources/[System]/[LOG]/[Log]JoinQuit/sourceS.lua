
function obterData()
    local time = getRealTime()
    local hours = time.hour
    local minutes = time.minute
    local seconds = time.second

    local monthday = time.monthday
    local month = time.month
    local year = time.year

    formattedTime = string.format("%02d/%02d/%02d - %02d:%02d:%02d", monthday, month + 1, year + 1900, hours-3, minutes, seconds)
end


local link = LinkWeebhooks

--addEvent("LS:teleportar",true)
--addEventHandler("LS:teleportar",root, function(player,x,y,z,dim)
    
--end)

addEventHandler("onPlayerLogin", root, function(root)
    obterData()
    local players = getElementsByType ("player")
    local ID = getAccountID(getPlayerAccount(source))
    Jogador = getPlayerName ( source )
    local dados = {
        embeds = {
            { -- embed 1
            title = "🟡     LOGIN",
            color = 14177041,
            description = message,
            fields = {
                {
                    name = getPlayerName(source).."["..ID.."] - Logou na cidade \nInformações: "..formattedTime,
                    value = "Jogadores: "..tostring ( #players).."/"..getMaxPlayers(),
                },
            },
            thumbnail = {
                --url = "https://cdn.discordapp.com/attachments/793528437444313109/805829405590290472/Sem_titulo_8_1080p-1.gif",
            },
            footer = {
                --text = "IP: "..getPlayerIP(source).."  SERIAL:"..getPlayerSerial(source).."",
            },
        },
    }
    }
    webhook = LinkWeebhooks
    dados = toJSON(dados)
    dados = dados:sub(2, -2)
    local opt = {
        connectionAttempts = 5,
        connectTimeout = 7000,
        headers = {
            ["Content-Type"] = "application/json"
        },
        postData = dados
    }
    fetchRemote ( webhook, opt, function() 
    end )
end)


addEventHandler("onPlayerQuit", root, function(quitType,root)
    obterData()
    local players = getElementsByType ("player")
    local ID = tostring(getAccountID(getPlayerAccount(source)))
    if (ID == "false") then
        ID = "N/A"
    end
    Jogador = getPlayerName ( source )
    local dados = {
        embeds = {
            { -- embed 1
            title = "🔴     QUIT",
            color = 14177041,
            description = message,
            fields = {
                {
                    name = getPlayerName(source).."["..ID.."] - Saiu da cidade "..quitType..". \nInformações: "..formattedTime,
                    value = "Jogadores: "..tostring ( #players-1).."/"..getMaxPlayers(), 
                },
            },
            thumbnail = {
                --url = "https://cdn.discordapp.com/attachments/793528437444313109/805829405590290472/Sem_titulo_8_1080p-1.gif",
            },
            footer = {
                --text = "IP: "..getPlayerIP(source).."  SERIAL:"..getPlayerSerial(source).."",
            },
        },
    }
    }
    webhook = LinkWeebhooks
    dados = toJSON(dados)
    dados = dados:sub(2, -2)
    local opt = {
        connectionAttempts = 5,
        connectTimeout = 7000,
        headers = {
            ["Content-Type"] = "application/json"
        },
        postData = dados
    }
    fetchRemote ( webhook, opt, function() 
    end )
end)

addEventHandler("onPlayerJoin", root, function(root)
    obterData()
    local players = getElementsByType ("player")
    Jogador = getPlayerName ( source )
    --xyz = getLocalization()
    --dim = getElementDimension()
    local dados = {
        embeds = {
            { -- embed 1
            title = "🟢     JOIN ",
            color = 14177041,
            description = message,
            fields = {
                {
                    name = Jogador.." - Entrou na cidade.\nInformações: "..formattedTime,
                    value = "Jogadores: "..tostring ( #players).."/"..getMaxPlayers(),
                },
            },
            thumbnail = {
                --url = "https://cdn.discordapp.com/attachments/793528437444313109/805829405590290472/Sem_titulo_8_1080p-1.gif",
            },
            footer = {
                --text = "IP: "..getPlayerIP(source).."  SERIAL:"..getPlayerSerial(source).."",
            },
        },
    }
    }
    webhook = LinkWeebhooks
    dados = toJSON(dados)
    dados = dados:sub(2, -2)
    local opt = {
        connectionAttempts = 5,
        connectTimeout = 7000,
        headers = {
            ["Content-Type"] = "application/json"
        },
        postData = dados
    }
    fetchRemote ( webhook, opt, function() 
    end )
end)