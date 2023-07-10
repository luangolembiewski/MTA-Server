config = {
    ["Configuração"] = {
        bindKey = "i",
        pesoSlots = "5.00", --- Peso Padrão
        maxSlots = 100, --- Peso Maximo
        ACL = "Staff",
        elementFome = "fome",
        elementSede = "sede",
        elementFuel = "fuel",
        enviarItemInVehicle = true, --- Permitir envia items dentro de veiculos
        morrerPerder = true,
        bauName = "[mod]Bau",
    },
    ["Items"] = {
        [1] = {nameItem = "Donuts", peso = 0.20, type = "comida", value = 10}, --- Name item, peso, tipo, valor que sobe na fome/sede
        [2] = {nameItem = "Batata", peso = 0.15, type = "comida", value = 5}, --- Name item, peso, tipo, valor que sobe na fome/sede
        [3] = {nameItem = "Hambúrguer", peso = 0.25, type = "comida", value = 15}, --- Name item, peso, tipo, valor que sobe na fome/sede
        [4] = {nameItem = "Pizza", peso = 0.25, type = "comida", value = 15}, --- Name item, peso, tipo, valor que sobe na fome/sede
        [5] = {nameItem = "Prato Feito", peso = 0.40, type = "comida", value = 25}, --- Name item, peso, tipo, valor que sobe na fome/sede
        [6] = {nameItem = "Energético", peso = 0.20, type = "bebida", value = 10}, --- Name item, peso, tipo, valor que sobe na fome/sede
        [7] = {nameItem = "Suco", peso = 0.15, type = "bebida", value = 5}, --- Name item, peso, tipo, valor que sobe na fome/sede
        [8] = {nameItem = "Vodka", peso = 0.20, type = "bebida", value = 5}, --- Name item, peso, tipo, valor que sobe na fome/sede
        [9] = {nameItem = "Água", peso = 0.10, type = "bebida", value = 10}, --- Name item, peso, tipo, valor que sobe na fome/sede
        [10] = {nameItem = "Whisky", peso = 0.40, type = "bebida", value = 20}, --- Name item, peso, tipo, valor que sobe na fome/sede
        [11] = {nameItem = "Bandagem", peso = 0.20, type = "utilitários", value = 25}, --- Name item, peso, tipo, Valor que sobe a vida
        [12] = {nameItem = "Cocaina", peso = 0.50, type = "ilegal"},  --- Name item, peso, tipo
        [13] = {nameItem = "Colete", peso = 1.00, type = "utilitários"},  --- Name item, peso, tipo
        [14] = {nameItem = "Dinheiro-Sujo", peso = 0.00, type = "ilegal", taxa = 0, acl = "SUJO"},  --- Name item, peso, tipo, taxa em %, ACL para limpar
        [15] = {nameItem = "Kit-de-Reparo", peso = 2.00, type = "utilitários"}, --- Name item, peso, tipo,
        [16] = {nameItem = "Lock-Pick", peso = 1.20, type = "ilegal"}, --- Name item, peso, tipo,
        [17] = {nameItem = "Maconha", peso = 0.20, type = "ilegal"}, --- Name item, peso, tipo,
        [18] = {nameItem = "Mochila-P", peso = 0.50, type = "utilitários", value = 10}, --- Name item, peso, tipo, Valor que aumenta nos slots
        [19] = {nameItem = "Combústivel", peso = 1.00, type = "utilitários", value = 50}, --- Name item, peso, tipo, Valor que aumenta de gasolina
        [20] = {nameItem = "Colt-45", peso = 2.00, type = "armas", weaponID = 22, idAmmu = 27}, --- Name item, peso, tipo, id do Item da munição
        [21] = {nameItem = "AK-47", peso = 2.50, type = "armas", weaponID = 30, idAmmu = 26}, --- Name item, peso, tipo, id do Item da munição
        [22] = {nameItem = "Desert", peso = 1.00, type = "armas", weaponID = 24, idAmmu = 27}, --- Name item, peso, tipo, id do Item da munição
        [23] = {nameItem = "M4", peso = 2.00, type = "armas", weaponID = 31, idAmmu = 29}, --- Name item, peso, tipo, id do Item da munição
        [24] = {nameItem = "MP5", peso = 1.50, type = "armas", weaponID = 29, idAmmu = 29}, --- Name item, peso, tipo, id do Item da munição
        [25] = {nameItem = "Shotgun", peso = 2.00, type = "armas", weaponID = 25, idAmmu = 28}, --- Name item, peso, tipo, id do Item da munição
        [26] = {nameItem = "Munição-762", peso = 0.01, type = "munição"}, --- Name item, peso, tipo
        [27] = {nameItem = "Munição-.40", peso = 0.01, type = "munição"}, --- Name item, peso, tipo
        [28] = {nameItem = "Munição-338", peso = 0.01, type = "munição"}, --- Name item, peso, tipo
        [29] = {nameItem = "Munição-556", peso = 0.01, type = "munição"}, --- Name item, peso, tipo
        [30] = {nameItem = "Mochila-M", peso = 0.50, type = "utilitários", value = 15}, --- Name item, peso, tipo, Valor que aumenta nos slots
        [31] = {nameItem = "Mochila-G", peso = 0.50, type = "utilitários", value = 20}, --- Name item, peso, tipo, Valor que aumenta nos slots
        [32] = {nameItem = "Paraquedas", peso = 0.20, type = "armas", weaponID = 46, idAmmu = 0}, --- Name item, peso, tipo, Valor que aumenta nos slots
        [33] = {nameItem = "Extintor", peso = 0.20, type = "armas", weaponID = 42, idAmmu = 0}, --- Name item, peso, tipo, Valor que aumenta nos slots
        [34] = {nameItem = "Cassetete", peso = 0.20, type = "armas", weaponID = 3, idAmmu = 0}, --- Name item, peso, tipo, Valor que aumenta nos slots
        [35] = {nameItem = "Carvão", peso = 0.02, type = ""}, --- Name item, peso, tipo,
        [36] = {nameItem = "Esmeralda", peso = 1.70, type = ""}, --- Name item, peso, tipo,
        [37] = {nameItem = "Ouro", peso = 1.00, type = ""}, --- Name item, peso, tipo,
        [38] = {nameItem = "Prata", peso = 0.50, type = ""}, --- Name item, peso, tipo,
        [39] = {nameItem = "Bronze", peso = 0.06, type = ""}, --- Name item, peso, tipo,
        [40] = {nameItem = "Diamante", peso = 1.02, type = ""}, --- Name item, peso, tipo,
        [41] = {nameItem = "Anel-De-Diamante", peso = 0.01, type = ""}, --- Name item, peso, tipo,
        [42] = {nameItem = "Xbox-360", peso = 0.60, type = ""}, --- Name item, peso, tipo,
        [43] = {nameItem = "Relógio", peso = 0.07, type = ""}, --- Name item, peso, tipo,
        [44] = {nameItem = "Pulseira", peso = 0.01, type = ""}, --- Name item, peso, tipo,
        [45] = {nameItem = "Playstation-2", peso = 0.10, type = ""}, --- Name item, peso, tipo,
        [46] = {nameItem = "Teclado", peso = 0.02, type = ""}, --- Name item, peso, tipo,
        [47] = {nameItem = "Colar", peso = 0.02, type = ""}, --- Name item, peso, tipo,
        [48] = {nameItem = "Brinco", peso = 0.01, type = ""}, --- Name item, peso, tipo,
        [49] = {nameItem = "Bracelete", peso = 0.02, type = ""}, --- Name item, peso, tipo,
        [50] = {nameItem = "Pacu", peso = 2.00, type = ""}, --- Name item, peso, tipo,
        [51] = {nameItem = "Atum", peso = 2.70, type = ""}, --- Name item, peso, tipo,
        [52] = {nameItem = "Corvina", peso = 3.00, type = ""}, --- Name item, peso, tipo,
        [53] = {nameItem = "Dourado", peso = 3.00, type = ""}, --- Name item, peso, tipo,
        [54] = {nameItem = "Marfimazul", peso = 4.02, type = ""}, --- Name item, peso, tipo,
        [55] = {nameItem = "Pintado", peso = 2.02, type = ""}, --- Name item, peso, tipo,
        [56] = {nameItem = "Pirarucu", peso = 3.02, type = ""}, --- Name item, peso, tipo,
        [57] = {nameItem = "Tilapia", peso = 1.02, type = ""}, --- Name item, peso, tipo,
        [58] = {nameItem = "Garrafa-Vazia", peso = 0.01, type = "utilitários"}, --- Name item, peso, tipo,
        [59] = {nameItem = "Leite", peso = 0.05, type = "utilitários"}, --- Name item, peso, tipo,
        [60] = {nameItem = "C4", peso = 1.00, type = "ilegal"}, --- Name item, peso, tipo,
        [61] = {nameItem = "Lança-Perfume", peso = 0.30, type = "ilegal"}, --- Name item, peso, tipo,
        [62] = {nameItem = "LSD", peso = 0.10, type = "ilegal"}, --- Name item, peso, tipo,
        [63] = {nameItem = "Chave", peso = 0.20, type = "ilegal"}, --- Name item, peso, tipo,
        [64] = {nameItem = "Agulha", peso = 0.20, type = "ilegal"}, --- Name item, peso, tipo,
        [65] = {nameItem = "Sniper", peso = 4.00, type = "armas", weaponID = 34, idAmmu = 29}, --- Name item, peso, tipo, id do Item da munição


    },
    ["Shops"] = {
        --{ name = "Barraca do Jorge", x = 2104.329, y = -1385.51, z = 23.828, int = 0, dim = 0, blip = 10, itens = { {1, 15},{2, 8},{3, 20},{4, 10},{5, 18},{6, 24},{7, 30},{8, 14},{9, 10},{10, 50},}}, --- loja de comida
        { name = "Mc Donald's", x = 379, y = -1922, z = 7.8, int = 0, dim = 0, blip = 10, itens = { {1, 15},{2, 8},{3, 20},{4, 10},{5, 18},{6, 24},{7, 30},{8, 14},{9, 10},{10, 50},{31, 10000},}}, --- loja de comida
        --{ name = "Barraca do Jorge", x = -2285.153, y = 148.5, z = 35.312, int = 0, dim = 0, blip = 10, itens = { {1, 15},{2, 8},{3, 20},{4, 10},{5, 18},{6, 24},{7, 30},{8, 14},{9, 10},{10, 50},}}, --- loja de comida
        --{ name = "Barraca do Jorge", x = 1931.13, y = 763.926, z = 10.82, int = 0, dim = 0, blip = 10, itens = { {1, 15},{2, 8},{3, 20},{4, 10},{5, 18},{6, 24},{7, 30},{8, 14},{9, 10},{10, 50},}}, --- loja de comida
        --{ name = "Barraca do Jorge", x = 2226.206, y = 1838.525, z = 10.82, int = 0, dim = 0, blip = 10, itens = { {1, 15},{2, 8},{3, 20},{4, 10},{5, 18},{6, 24},{7, 30},{8, 14},{9, 10},{10, 50},}}, --- loja de comida
        --{ name = "Barraca do Jorge", x = 1908.215, y = -1812.942, z = 13.549, int = 0, dim = 0, blip = 10, itens = { {1, 15},{2, 8},{3, 20},{4, 10},{5, 18},{6, 24},{7, 30},--{8, 14},{9, 10},{10, 50},}}, --- loja de comida
        --{ name = "Barraca do Jorge", x = 552.79, y = -1742.228, z = 12.599, int = 0, dim = 0, blip = 10, itens = { {1, 15},{2, 8},{3, 20},{4, 10},{5, 18},{6, 24},{7, 30},{8, 14},{9, 10},{10, 50},}}, --- loja de comida
        --{ name = "Banca do Cicim", x = 2116.298, y = -1385.609, z = 23.828, int = 0, dim = 0, blip = 0, itens = { {20, 10000},{21, 40000},{22, 15000},}}, --- loja de armas PAPI
        --{ name = "Banca do Cleitin", x = 2129.749, y = -1385.654, z = 23.828, int = 0, dim = 0, blip = 17, itens = { {26, 25},{27, 40},{28, 60},{29, 20},}}, --- loja de munição PAPI 
        --{ name = "Banca do Cicim", x = 2636.777, y = 1899.34, z = 11.023, int = 0, dim = 0, blip = 0, itens = { {20, 10000},{21, 40000},{22, 15000},}}, --- loja de armas HELON
        --{ name = "Banca do Cleitin", x = 2636.07, y = 1893.526, z = 11.023, int = 0, dim = 0, blip = 17, itens = { {26, 25},{27, 40},{28, 60},{29, 20},}}, --- loja de munição HELON
        --{ name = "Barraca do Claudio", x = 2140.023, y = -1385.549, z = 23.836, int = 0, dim = 0, blip = 47, itens = { {11, 1000},{32, 350},{58, 20},{15, 1000},{19, 500},{18, 800},{30, 3000},{31, 5000},}}, --- loja de utilitarios
        --{ name = "Barraca do Claudio", x = 2017.58, y = 1201.4, z = 10.82, int = 0, dim = 0, blip = 48, itens = { {11, 1000},{32, 350},{58, 20},{15, 1000},{19, 1000},{18, 800},{30, 3000},{31, 5000},}}, --- loja de utilitarios
        --{ name = "Barraca do Claudio", x = -2158.999, y = 753.669, z = 69.519, int = 0, dim = 0, blip = 48, itens = { {11, 1000},{32, 350},{58, 20},{15, 1000},{19, 1000},{18, 800},{30, 3000},{31, 5000},}}, --- loja de utilitarios
        --{ name = "Biqueira", x = 1543, y = -1675.392, z = 14, int = 0, dim = 0, blip = 44, itens = { {12, 500},{17, 500},{61,00},{62,500}}}, --- loja de drogas papi
        --{ name = "Ilegal", x = 2155.264, y = -1385.392, z = 23.836, int = 0, dim = 0, blip = 44, itens = { {60, 2000},}}, --- loja de c4
        --{ name = "YKZ", x = 2204.402, y = -1385.491, z = 23.831, int = 0, dim = 0, blip = 44, itens = { {16, 2000},}}, --- loja de lockpick
        --{ name = "Ilegal", x = 2190.438, y = -1385.079, z = 23.831, int = 0, dim = 0, blip = 44, itens = { {63, 2000},}}, --- loja de chave TON
        --{ name = "Biqueira", x = 2179.273, y = -1385.57, z = 23.83, int = 0, dim = 0, blip = 44, itens = { {62, 500},}}, --- loja de drogas LSD
        --{ name = "Biqueira", x = 1067.8468017578, y = 2106.6525878906, z = 10.8203125, int = 0, dim = 0, blip = 44, itens = { {12, 500},{17, 500},}}, --- loja de drogas TON
        --{ name = "Biqueira", x = 2348.1335449219, y = -649.5927734375, z = 132.32669067383, int = 0, dim = 0, blip = 44, itens = { {61, 500},}}, --- loja de drogas PCC
        --{ name = "Biqueira", x = -857.27893066406, y = -1499.0834960938, z = 126.14530944824, int = 0, dim = 0, blip = 44, itens = { {61, 500},}}, --- loja de drogas RODO

    }
}

weaponsConfig = {
    [22] = {itemID = 20}, --- [ ID ARMA ] = { id Item }
    [30] = {itemID = 21}, --- [ ID ARMA ] = { id Item }
    [24] = {itemID = 22}, --- [ ID ARMA ] = { id Item }
    [31] = {itemID = 23}, --- [ ID ARMA ] = { id Item }
    [29] = {itemID = 24}, --- [ ID ARMA ] = { id Item }
    [25] = {itemID = 25}, --- [ ID ARMA ] = { id Item }
    [46] = {itemID = 32}, --- [ ID ARMA ] = { id Item }
    [42] = {itemID = 33}, --- [ ID ARMA ] = { id Item }
    [3] = {itemID = 34}, --- [ ID ARMA ] = { id Item }
    --munição

}