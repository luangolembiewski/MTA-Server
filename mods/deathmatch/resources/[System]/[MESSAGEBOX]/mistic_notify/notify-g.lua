--[[
 ________  ________  ________  ___    ___ ________  ___  ________  ___  ___  _________        ________      ___    ___     
|\   ____\|\   __  \|\   __  \|\  \  /  /|\   __  \|\  \|\   ____\|\  \|\  \|\___   ___\     |\   __  \    |\  \  /  /|    
\ \  \___|\ \  \|\  \ \  \|\  \ \  \/  / | \  \|\  \ \  \ \  \___|\ \  \\\  \|___ \  \_|     \ \  \|\ /_   \ \  \/  / /    
 \ \  \    \ \  \\\  \ \   ____\ \    / / \ \   _  _\ \  \ \  \  __\ \   __  \   \ \  \       \ \   __  \   \ \    / /     
  \ \  \____\ \  \\\  \ \  \___|\/  /  /   \ \  \\  \\ \  \ \  \|\  \ \  \ \  \   \ \  \       \ \  \|\  \   \/  /  /      
   \ \_______\ \_______\ \__\ __/  / /      \ \__\\ _\\ \__\ \_______\ \__\ \__\   \ \__\       \ \_______\__/  / /        
    \|_______|\|_______|\|__||\___/ /        \|__|\|__|\|__|\|_______|\|__|\|__|    \|__|        \|_______|\___/ /         
                             \|___|/                                                                      \|___|/                                                                                                    
 _____ ______   ___  ________  _________  ___  ________          ________  _________  ________  ________  _______          
|\   _ \  _   \|\  \|\   ____\|\___   ___\\  \|\   ____\        |\   ____\|\___   ___\\   __  \|\   __  \|\  ___ \         
\ \  \\\__\ \  \ \  \ \  \___|\|___ \  \_\ \  \ \  \___|        \ \  \___|\|___ \  \_\ \  \|\  \ \  \|\  \ \   __/|        
 \ \  \\|__| \  \ \  \ \_____  \   \ \  \ \ \  \ \  \            \ \_____  \   \ \  \ \ \  \\\  \ \   _  _\ \  \_|/__      
  \ \  \    \ \  \ \  \|____|\  \   \ \  \ \ \  \ \  \____        \|____|\  \   \ \  \ \ \  \\\  \ \  \\  \\ \  \_|\ \     
   \ \__\    \ \__\ \__\____\_\  \   \ \__\ \ \__\ \_______\        ____\_\  \   \ \__\ \ \_______\ \__\\ _\\ \_______\    
    \|__|     \|__|\|__|\_________\   \|__|  \|__|\|_______|       |\_________\   \|__|  \|_______|\|__|\|__|\|_______|    
]]

--[[
    Como usar nossa Infobox : {
        server - side = {
            triggerClientEvent (elemento, "MST.sendPlayerNotification", elemento, mensagem, type, segundos) | Exemplo : (triggerClientEvent (player, "MST.sendPlayerNotification", player, "Olá Mundo.", "error", segundos))
        };
        client - side = {
            triggerEvent ("MST.sendPlayerNotification", elemento, mensagem, type, segundos) | Exemplo : (triggerEvent ("MST.sendPlayerNotification", localPlayer, "Olá Mundo.", "error", segundos))
        };
    }
]]

config = {
    Geral = {
        Som = true; -- Na hora que der a Notificação executar um som (true = "sim" // false = "não").
        SegundosPadrao = 3; -- Tempo Padrão da Infobox caso não específique o Valor 'segundos' no argumento.
        InfoboxPadrao = "error"; -- Tipo da Infobox Padrão.
    };
    Infobox = {
        error = {color = {230, 26, 66}, image = "assets/gfx/cancel.png", sound = "assets/sfx/nil.mp3"}; -- ["Tipo da Infobox"] = {color = {R, G, B}, image = "Diretório da Imagem desse tipo.", sound = "Diretório do som desse tipo."}.
        warning = {color = {255, 180, 0}, image = "assets/gfx/important.png", sound = "assets/sfx/nil.mp3"}; -- ["Tipo da Infobox"] = {color = {R, G, B}, image = "Diretório da Imagem desse tipo.", sound = "Diretório do som desse tipo."}.
        success = {color = {175, 205, 100}, image = "assets/gfx/check.png", sound = "assets/sfx/nil.mp3"}; -- ["Tipo da Infobox"] = {color = {R, G, B}, image = "Diretório da Imagem desse tipo.", sound = "Diretório do som desse tipo."}.
        carLocked = {color = {133, 193, 129}, image = "assets/gfx/locked.png", sound = "assets/sfx/nil.mp3"}; -- ["Tipo da Infobox"] = {color = {R, G, B}, image = "Diretório da Imagem desse tipo.", sound = "Diretório do som desse tipo."}.
        information = {color = {124, 175, 221}, image = "assets/gfx/ring.png", sound = "assets/sfx/nil.mp3"}; -- ["Tipo da Infobox"] = {color = {R, G, B}, image = "Diretório da Imagem desse tipo.", sound = "Diretório do som desse tipo."}.
        social = {color = {213, 72, 103}, image = "assets/gfx/social.png", sound = "assets/sfx/nil.mp3"}; -- ["Tipo da Infobox"] = {color = {R, G, B}, image = "Diretório da Imagem desse tipo.", sound = "Diretório do som desse tipo."}.
        carUnlocked = {color = {230, 36, 65}, image = "assets/gfx/unlocked.png", sound = "assets/sfx/nil.mp3"}; -- ["Tipo da Infobox"] = {color = {R, G, B}, image = "Diretório da Imagem desse tipo.", sound = "Diretório do som desse tipo."}.
        anuncio = {color = {123, 104, 172}, image = "assets/gfx/announce.png", sound = "assets/sfx/nil.mp3"}; -- ["Tipo da Infobox"] = {color = {R, G, B}, image = "Diretório da Imagem desse tipo.", sound = "Diretório do som desse tipo."}.
        blood = {color = {251, 88, 88}, image = "assets/gfx/blood.png", sound = "assets/sfx/nil.mp3"}; -- ["Tipo da Infobox"] = {color = {R, G, B}, image = "Diretório da Imagem desse tipo.", sound = "Diretório do som desse tipo."}.
    };
}