local exibindo_painel = false
local comandos = nil

--PLAYER
function painelHelp(thePlayer)
    comandos = {
        [1] = {nome = "/ajuda + cargo", info = "Painel de ajuda de cada cargo Ex: /ajudastaff"},
        [2] = {nome = "J", info = "Ligar/Desligar farol do veículo"},
        [3] = {nome = "K", info = "Ligar/Desligar motor do veículo"},
        [4] = {nome = "L", info = "Trancar/Destrancar o veículo"},
        [5] = {nome = "R", info = "Radio"},
        [6] = {nome = "F5", info = "Suspensão a ar"},
        [7] = {nome = "F6", info = "Controle das rodas"},
        [8] = {nome = "F7", info = "Esconder HUD"},
        [9] = {nome = "LAlt", info = "Cursor livre"},
        [10] = {nome = "LAlt+mouse1", info = "Abrir/fechar porta do carro"},
        [11] = {nome = "/mods", info = "Abrir painel de Gerenciamento de mods"},
    }
    triggerClientEvent(thePlayer,"Evehelp",thePlayer,comandos)
end
addEvent("helpKey",true)
addEventHandler("helpKey",getRootElement(),painelHelp)
addCommandHandler("ajuda", painelHelp)

--STAFF
addCommandHandler("ajudastaff",function(thePlayer)
    if isObjectInACLGroup("user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup("Staff")) then
        comandos = {
            [1] = {nome = "/staff", info = "Entrar ou sair do modo STAFF"},
            [2] = {nome = "/nc", info = "Modo invisível + fly + colisão"},
            [3] = {nome = "/fix", info = "Arrumar Veículo"},
            [4] = {nome = "/dv", info = "Remove o veículo"},
            [5] = {nome = "/invisivel", info = "Modo invisivel"},
            [6] = {nome = "/tp [idPlayer]", info = "Teleportar para um jogador"},
            [7] = {nome = "/tptome [idPlayer]", info = "Puxar um jogador até você"},
            [8] = {nome = "/tploc [x,y,z] [Dimensão]", info = "Teleportar para a coordenada"},
            [9] = {nome = "/god [idPlayer]", info = "Setar Vida e colete do player para 100%"},
            [10] = {nome = "/reviver [idPalyer]", info = "Revive o Jogador"},
            [11] = {nome = "/dvid [idPlayer]", info = "Remove o veiculo do jogador"},
            [12] = {nome = "/fome [idPlayer] [%]", info = "Setar fome ao jogador"},
            [13] = {nome = "/sede [idPlayer] [%]", info = "Setar sede ao jogador"},
            [14] = {nome = "/colete [idPlayer] [%]", info = "Seta colete para o player"},
            [15] = {nome = "/money [idPlayer] [Quantia]", info = "Dar dinheiro ao player"},
            [16] = {nome = "/ss [idPlayer] [idSkin]", info = "Seta skin no Player"},
            [17] = {nome = "/car [idPlayer] [idCarro]", info = "Dar carro para o player"},
            [18] = {nome = "/avisar [idPlayer] [Mensagem]", info = "Enviar aviso ao player"},
            [19] = {nome = "/item [idPlayer] [nomeItem] [quantidade]", info = "Enviar item ao player"},
            [20] = {nome = "/quedas", info = "Ativar/desativar cair da moto"},
            [21] = {nome = "/setcar [idPlayer]", info = "Adicionar o veículo que o player está tripulando a garagem"},
            [22] = {nome = "/carcolor cor[r g b] farol[r g b]", info = "Trocar cor do veículo"},
            [23] = {nome = "/settime [horas] [minutos]", info = "Alterar horário"},
            [24] = {nome = "/coordenadas", info = "Exibir coordenadas"},
            [25] = {nome = "/long", info = "Ativar LongVision"},
            [26] = {nome = "/arrancar", info = "Ativar contador de arrancada"},
            [27] = {nome = "/godmode", info = "Modo imortal"},
            [28] = {nome = "/blips", info = "Informações do player"},
            [28] = {nome = "/blips2", info = "Distância do player"},
            -------------------------------------------------------------------------------------------------------------------
        }
        triggerClientEvent(thePlayer,"Evehelp",thePlayer,comandos)
    end
end)