Apolo_Config = {

    Geral = {
        ["Id"] = "ID", -- [[  ElementData ID ]] -- 
    },

    Url = {-- [[  Link da Webhooks ]] -- 
        ["UrlDiscord"] = "https://discord.com/api/webhooks/1125451061688291328/iikXzhn8LyBgcSn92psXbNQ0G8oyLh03AEJntKTOck6dUZxGVfm8NiRnVZYrjnYiz_DO",
    },
    
    Comandos = { -- [[  Coamndos do script ]] -- 
        ["Nc"] = "nc", 
        ["Invisivel"] = "invisivel",
        ["Fome"] = "fome",
        ["Sede"] = "sede",
        ["Vida"] = "god",
        ["Reviver"] = "reviver",
        ["Dinheiro"] = "money",
        ["Fix"] = "fix",
        ["SetSkin"] = "ss",
        ["Dv"] = "dv",
        ["DvId"] = "dvid",
        ["Colete"] = "colete",
        ["Car"] = "car",
        ["Avisar"] = "avisar",
        ["Tp"] = "tp",
        ["TpLoc"] = "tploc",
        ["Puxar"] = "tptome",
        ["Staff"] = "staff",
    },

    Acls = { -- [[  Permissões para executar os comandos ]] -- 
        ["Staff"] = "Staff",
        ["AclNc"] = "Staff",
        ["AclVida"] = "Staff",
        ["AclFix"] = "Staff",
        ["AclDv"] = "Staff",
        ["AclReviver"] = "Staff",
        ["AclColete"] = "Staff",
        ["AclCar"] = "Staff",
        ["AclAvisar"] = "Staff",
        ["AclTp"] = "Staff",
        ["AclPuxar"] = "Staff",
    },

    Mensagens = {-- [[ Mensagens Infobox ]] -- 
        ["ErroID"] = "Informe o id do player.",
        ["ErroPlayer"] = "Jogador não encontrado.",
        ["ErroVida"] = "Informe a quantidade de vida que o jogador receberá.",
        ["ErroVeiculo"] = "O Jogador nao esta em um veiculo.",
        ["ErroArmor"] = "Informe a quantidade de colete que o jogador receberá.",
        ["ErroFome"] = "Informe a porcentagem de fome que o jogador receberá.",
        ["ErroAgua"] = "Informe a porcentagem de água que o jogador receberá.",
        ["ErroAviso"] = "Informe o aviso que o jogador receberá.",
        ["ErroAgua"] = "Informe a porcentagem de água que o jogador receberá.",
        ["ErroReviver"] = "O jogador não está morto.",
        ["ErroSkin"] = "Informe a skin que o jogador receberá.",
        ["ErroTpLoc"] = "Informe a localização.",
        ["MsgAtivouNC"] = "Voce ativou o modo de nc.",
        ["MsgDesativouNC"] = "Voce desativou o modo de nc.",
        ["MsgAtivouInv"] = "Voce ativou o modo invisivel.",
        ["MsgDesativouInv"] = "Voce desativou o modo invisivel.",
        ["ErroIdVeiculo"] = "Informe o id do veiculo.",
        ["ErroVeiculoExistente"] = "O jogador ja esta em um veiculo.",
        ["ErroTpID"] = "Voce precisa adicionar o segundo id.",
        ["ErroPermissao"] = "Você não ter permissão para usar esse comando."
    },
}

function outputMessage(elem, msg, type)
    exports.Scripts_Dxmessages:outputDx (elem, msg, type)
end