guiLanguage.english = {
    --
    -- GENERAL STRINGS
    --
    windowHeader = "Mega Mods",
    
    restrictedPassenger = "Voc� n�o tem permiss�o de usar o editor-a��o como um passageiro.",
    needVehicle = "Voc� deve estar dirigindo um ve�culo para usar o editor de manipula��o!",
    needLogin = "Voc� precisa estar logado para ver este menu.",
    needAdmin = "Voc� deve estar logado como administrador para aceder a este menu.",
    invalidMenu = "Este menu n�o existe!",
    disabledMenu = "Este menu foi desativado.",
    notifyUpdate = "O editor de manipula��o foi atualizado desde a �ltima vez que voc� usou. Gostaria de ver uma lista das altera��es agora? \ n Voc� sempre pode ver a lista de mudan�as em 'Extras'> 'Atualiza��es'",
    notifyUpgrade = "O editor de manipula��o foi atualizado. Isso significa que alguns de seus arquivos, como manejos salvos foram alteradas para outro formato. Como resultado, os servidores com uma vers�o desatualizada do hedit n�o s�o totalmente suportados. \ NVoc� gostaria de ver uma lista das altera��es agora? \ n Voc� sempre pode ver a lista de mudan�as em 'Extras'> 'Atualiza��es'",
    outdatedUpdate = "Este servidor executa uma vers�o desactualizada do editor manuseio. Como resultado, alguns recursos podem estar faltando. \ NPor favor, contate um administrador.",
    outdatedUpgrade = "Este servidor executa uma vers�o extremamente desatualizada do editor manuseio. Como resultado, todas as defini��es / configura��es de manuseio salvos s�o incompat�veis. \ NPor favor, contate um administrador.",
    mtaUpdate = "If you have any saved handlings on MTA 1.1, your handlings are no longer compatible; please visit 'http://hedit.googclecode.com/' for details.",
    sameValue = "O% s � que j�!",
    exceedLimits = "Valor utilizado em% s excede o limite. [%s]!",
    cantSameValue = "% s n�o pode o mesmo que% s!",
    needNumber = "Voc� deve usar um n�mero!",
    unsupportedProperty = "% s n�o � uma propriedade suportada.",
    successRegular = "set% s para% s.",
    successHex = "%s %s.",
    unableToChange = "N�o � poss�vel definir o% s para% s!",
	disabledProperty = "Editar% s est� desativada neste servidor!",
    
    resetted = "Reiniciada com sucesso as configura��es de manuseio do ve�culo!",
    loaded = "Carregado com �xito as suas defini��es de manipula��o!",
    imported = "Importados com �xito as configura��es de manuseio!",
    invalidImport = "Importa��o falhou; tratamento dos dados que voc� forneceu � inv�lido!",
    invalidSave = "Por favor, forne�a um nome e uma descri��o v�lida para salvar os dados de manuseio deste ve�culo!",
    
    confirmReplace = "Tem certeza que voc� gostaria de substituir os existentes save?",
    confirmLoad = "Tem certeza que voc� gostaria de carregar essas configura��es de manipula��o? Quaisquer altera��es n�o salvas ser�o perdidas!",
    confirmDelete = "Tem certeza de que deseja excluir essas configura��es de manipula��o?",
    confirmReset = "Tem certeza que voc� gostaria de redefinir a sua manipula��o? Quaisquer altera��es n�o salvas ser�o perdidas!",
    confirmImport = "Tem certeza que voc� gostaria de importar esta manipula��o? Quaisquer altera��es n�o salvas ser�o perdidas!",

    successSave = "Salvo com sucesso suas configura��es de manuseio!",
    successLoad = "Carregado com �xito as suas defini��es de manipula��o!",
    
	confirmVersionReset = "Tem a certeza que pretende definir o n�mero da vers�o do editor de um deste servidor? Seus manejos salvos podem se tornar incompat�veis.",
	successVersionReset = "A vers�o do seu editor foi atualizado.",
    wantTheSettings = "Tem certeza que voc� gostaria de aplicar essas configura��es? O editor de manipula��o ser� reiniciado.",
    
    vehicle = "Ve�culo.",
    unsaved = "n�o salvo",
    
    clickToEdit = "Clique para editar.",
    enterToSubmit = "Pressione Enter para confirmar.",
    clickToViewFullLog = "Clique para ver o log ve�culo completo.",
    copiedToClipboard = "As defini��es de manipula��o foram copiados para o clipboard!",
    
    special = {
        commode = {
            "Divis�o",
            "Mesclado"
        }
    },
    
    --
    -- BUTTON / MENU STRINGS
    --
    
    --Warning level strings
    warningtitles = {
        info = "Informa��es",
        question = "Pergunta",
        warning = "Aviso!",
        ["error"] = "Erro!"
    },
    --Strings for the buttons at the top
    utilbuttons = {
        handling = "Handling",
        tools = "Ferramentas",
        extra = "Extra",
        close = "X"
    },

    --Strings for the buttons at the right
    menubuttons = {
        engine = "Motor",
        body = "Corpo",
        wheels = "Rodas",
        appearance = "Apar�ncia",
        modelflags = "Modelo\Flags",
        handlingflags = "Manuseio\nFlags",
        dynamometer = "Dyno",
        help = "Ajudar"
    },
    
    --Strings for the various menus of the editor. Empty strings are placeholder to avoid debug as the debug is meant to show items which are missing text.
    menuinfo = {
        engine = {
            shortname = "Motor",
            longname = "Configura��es de motor"
        },
        body = {
            shortname = "Corpo",
            longname = "Configura��es de suspens�o do Corpo"
        },
        wheels = {
            shortname = "Rodas",
            longname = "Configura��es de rodas"
        },
        appearance = {
            shortname = "Apar�ncia",
            longname = "Configura��es de Apar�ncia"
        },
        modelflags = {
            shortname = "Flags modelo",
            longname = "Ve�culo Configura��es Modelo"
        },
        handlingflags = {
            shortname = "Manipula��o de Bandeiras",
            longname = "Configura��es de tratamento especial"
        },
        reset = {
            shortname = "Restabelecer",
            longname = "Redefinir as configura��es de manuseio deste ve�culo.",
            itemtext = {
                label = "Ve�culo de base:",
                combo = "-----",
                button = "Restabelecer"
            }
        },
        save = {
            shortname = "Salvar",
            longname = "Salve as configura��es de manuseio deste ve�culo.",
            itemtext = {
                nameLabel = "Nome",
                descriptionLabel = "Descri��o",
                button = "Salvar",
                grid = "",
                nameEdit = "",
                descriptionEdit = ""
            }
        },
        load = {
            shortname = "Carregar",
            longname = "Carregar um conjunto de configura��es de manuseio.",
            itemtext = {
                button = "Carregar",
                grid = ""
            }
        },
        import = {
            shortname = "Importar",
            longname = "Importar uma linha de tratamento em formato handling.cfg.",
            itemtext = {
                button = "Importar",
                III = "III",
                VC = "VC",
                SA = "SA",
                IV = "IV",
                memo = ""
            }
        },
        export = {
            shortname = "Exportar",
            longname = "Exportar as configura��es de manuseio em formato handling.cfg.",
            itemtext = {
                button = "Copiar para o Clipboard",
                memo = ""
            }
        },
        get = {
            shortname = "Obter",
            longname = "Obter lidar com as configura��es de outro jogador."
        },
        share = {
            shortname = "Share",
            longname = "Compartilhe suas configura��es de manuseio com outro jogador."
        },
        upload = {
            shortname = "Carregar",
            longname = "Publique as suas configura��es de manuseio para o servidor."
        },
        download = {
            shortname = "Baixar",
            longname = "Baixe um conjunto de manipula��o configura��es do servidor."
        },
        
        resourcesave = {
            shortname = "Save recurso",
            longname = "Salve o seu manuseio a um recurso."
        },
        resourceload = {
            shortname = "Carga de recursos",
            longname = "Carregar uma manipula��o de um recurso."
        },
        options = {
            shortname = "Op��es",
            longname = "Op��es",
            itemtext = {
                label_key = "Alternar chave",
                label_cmd = "Command Alternar:",
                label_template = "GUI modelo:",
                label_language = "Idioma:",
                label_commode = "Centro De modo de edi��o em massa:",
                checkbox_versionreset = "Downgrade meu n�mero da vers�o de% s para% s?",
                button_save = "Aplicar",
                combo_key = "",
                combo_template = "",
                edit_cmd = "",
                combo_commode = "",
                combo_language = "",
				checkbox_lockwhenediting = "Bloqueio do ve�culo durante a edi��o?"
            }
        },
        administration = {
            shortname = "Administra��o",
            longname = "Ferramentas do Administrador."
        },
        handlinglog = {
            shortname = "Manuseio de toras",
            longname = "Log de ??mudan�as recentes para lidar com configura��es.",
            itemtext = {
                logpane = ""
            }
        },
        updatelist = {
            shortname = "Atualiza��es",
            longname = "Lista de atualiza��es recentes.",
            itemtext = {
                scrollpane = ""
            }
        },
        mtaversionupdate = {
            shortname = "MTA Atualiza��o",
            longname = "Multi Theft Auto foi atualizado!",
            itemtext = {
                infotext = "Multi Theft Auto foi atualizado. Devido a isso, os seus manejos salvos na vers�o anterior n�o s�o mais compat�veis. Por favor, visite o link abaixo para ajudar e obter os seus manejos de volta.",
                websitebox = "http://hedit.googlecode.com/"
            }
        }
    },
    
    --
    --NOTE: 12/17/2011 This section is pending review for typos and grammar.
    --
    handlingPropertyInformation = { 
        ["identifier"] = {
            friendlyName = "Identificador ve�culo",
            information = "Isto representa o identificador de ve�culo a ser utilizado em handling.cfg.",
            syntax = { "Corda "," S� use identificadores v�lidos, caso contr�rio n�o vai funcionar exporta��o." }
        },
        ["mass"] = {
            friendlyName = "Massa",
            information = "Define o peso do seu ve�culo em KG.",
            syntax = { "Flutuar", "Lembre-se de mudar o 'transformar Mass' primeiro para evitar saltar!" }
        },
        ["turnMass"] = {
            friendlyName = "transformar Mass",
            information = "Usados ??para calcular os efeitos do movimento.",
            syntax = { "Flutuar", "Valores mais altos fazem o seu ve�culo um pouco mais'flutuante'." }
        },
        ["dragCoeff"] = {
            friendlyName = "Arraste Multiplicador",
            information = "Varia��es resist�ncia ao movimento.",
            syntax = { "Flutuar", "Quanto maior o valor, menor ser� a sua velocidade m�xima vai ficar." }
        },
        ["centerOfMass"] = {
            friendlyName = "Centro de massa",
            information = "Define o ponto de gravidade do seu ve�culo, em metros.",
            syntax = { "Flutuar", "Hover X, Y ou Z para obter informa��es." }
        },
        ["centerOfMassX"] = {
            friendlyName = "Centro de massa X",
            information = "Define a dist�ncia frente-traseira do centro de massa em metros.",
            syntax = { "Flutuar", "Os valores mais altos s�o os valores para a parte inferior dianteira � parte traseira." }
        },
        ["centerOfMassY"] = {
            friendlyName = "Centro de massa Y",
            information = "Define a dist�ncia esquerda para a direita do centro de massa em metros.",
            syntax = { "Flutuar", "Os valores mais altos s�o os valores mais baixos para a direita e a esquerda." }
        },
        ["centerOfMassZ"] = {
            friendlyName = "Centro de massa Z",
            information = "Define a altura do centro de massa em metros.",
            syntax = { "Flutuar", "Quanto maior for o valor, maior ser� o ponto." }
        },
        ["percentSubmerged"] = {
            friendlyName = "por cento submerso",
            information = "Define o qu�o profundo o seu ve�culo precisa estar na �gua antes que ele ir� flutuar em percentagem.",
            syntax = { "N�meroInteiro", "Os valores mais altos far� com que o seu ve�culo flutuando mais profundo." }
        },
        ["tractionMultiplier"] = {
            friendlyName = "Multiplicador de tra��o",
            information = "Define a quantidade de ader�ncia de seu ve�culo ter� nas curvas.",
            syntax = { "Flutuar", "Os valores mais altos far� com que seu ve�culo tem mais ader�ncia." }
        },
        ["tractionLoss"] = {
            friendlyName = "Perda de tra��o",
            information = "Define a quantidade de ader�ncia de seu ve�culo ter� quando acelera��o e desacelera��o.",
            syntax = { "Flutuar", "Os valores mais altos far� com que seus cantos cortados ve�culo melhor." }
        },
        ["tractionBias"] = {
            friendlyName = "Vi�s de tra��o",
            information = "Define onde toda a ader�ncia de suas rodas v�o para.",
            syntax = { "Flutuar", "Os valores mais altos ir� definir o vi�s mais para a frente." }
        },
        ["numberOfGears"] = {
            friendlyName = "N�mero de mudan�as",
            information = "Define o n�mero de engrenagens que voc� quer ter em seu ve�culo.",
            syntax = { "N�meroInteiro", "N�o tem efeito sobre a velocidade m�xima ou acelera��o." }
        },
        ["maxVelocity"] = {
            friendlyName = "Velocidade maxima",
            information = "Define a velocidade m�xima do ve�culo em km / h.",
            syntax = { "Flutuar", "Afetado por outras propriedades." }
        },
        ["engineAcceleration"] = {
            friendlyName = "Acelera��o",
            information = "Define a acelera��o do MS ^ 2 de seu ve�culo.",
            syntax = { "Flutuar", "Os valores mais elevados ir�o aumentar a taxa do ve�culo acelera." }
        },
        ["engineInertia"] = {
            friendlyName = "In�rcia",
            information = "Suaviza ou agu�a a curva de acelera��o.",
            syntax = { "Flutuar", "Valores mais altos fazem a curva de acelera��o mais suave." }
        },
        ["driveType"] = {
            friendlyName = "Tipo de unidade",
            information = "Define que as rodas ser�o utilizados durante a condu��o.",
            syntax = { "Corda", "escolher 'todas as rodas' resultar� em que o ve�culo sendo mais f�cil de controlar." },
            options = { ["f"]="rodas dianteiras",["r"]="rodas traseiras",["4"]="todas as rodas" }
        },
        ["engineType"] = {
            friendlyName = "Tipo de motor",
            information = "Define o tipo de motor para o seu ve�culo.",
            syntax = { "Corda", "[UNKNOWN]" },
            options = { ["p"]="Gasolina",["d"]="Diesel",["e"]="El�trico" }
        },
        ["brakeDeceleration"] = {
            friendlyName = "Desacelera��o Freio",
            information = "Define sua desacelera��o em MS ^ 2.",
            syntax = { "Flutuar", "Os valores mais altos far� com que o mais forte travagem, mas pode escorregar se sua tra��o � muito baixo." }
        },
        ["brakeBias"] = {
            friendlyName = "Vi�s de Freio",
            information = "Define a posi��o principal dos freios.",
            syntax = { "Flutuar", "Os valores mais altos v�o colocar o vi�s mais para a frente." }
        },
        ["ABS"] = {
            friendlyName = "ABS",
            information = "Ativar ou desativar ABS em seu ve�culo.",
            syntax = { "Bool", "Sem efeito." },
            options = { ["Verdadeiro"]="Ativado",["Falso"]="Inv�lido" }
        },
        ["steeringLock"] = {
            friendlyName = "Bloqueio de direc��o",
            information = "Define o �ngulo m�ximo que o seu ve�culo pode dirigir.",
            syntax = { "Flutuar", "�ngulo de dire��o fica menor quanto mais r�pido voc� ir." }
        },
        ["suspensionForceLevel"] = {
            friendlyName = "Suspens�o n�vel de for�a",
            information = "Efeitos desconhecidos.",
            syntax = { "Flutuar", "Desconhecido." }
        },
        ["suspensionDamping"] = {
            friendlyName = "Amortecimento da suspens�o",
            information = "Efeitos desconhecidos.",
            syntax = { "Flutuar", "Desconhecido." }
        },
        ["suspensionHighSpeedDamping"] = {
            friendlyName = "Suspens�o de amortecimento de alta velocidade",
            information = "Define a sua suspens�o mais dura vai ser quando a condu��o mais r�pida.",
            syntax = { "Flutuar", "N�oTestado" } -- HERE
        },
        ["suspensionUpperLimit"] = {
            friendlyName = "Suspens�o limite superior",
            information = "Movimento superior de rodas em metros.",
            syntax = { "Flutuar", "N�oTestado" } -- HERE
        },
        ["suspensionLowerLimit"] = {
            friendlyName = "Suspens�o Limite Inferior",
            information = "A altura da sua suspens�o.",
            syntax = { "Flutuar", "Os valores mais baixos v�o fazer o seu ve�culo mais alto." }
        },
        ["suspensionFrontRearBias"] = {
            friendlyName = "Vi�s suspens�o",
            information = "Conjuntos onde a maioria do poder suspens�o v�o para.",
            syntax = { "Flutuar", "Os valores mais altos v�o colocar o vi�s mais para a frente." }
        },
        ["suspensionAntiDiveMultiplier"] = {
            friendlyName = "Suspens�o Anti Multiplicador Dive",
            information = "Altera a quantidade de arremesso corpo sob frenagem e acelera��o.",
            syntax = { "Flutuar", "" }
        },
        ["seatOffsetDistance"] = {
            friendlyName = "Assento Dist�ncia de offset",
            information = "Define o quanto o banco � da porta do seu ve�culo.",
            syntax = { "Flutuar", "" }
        },
        ["collisionDamageMultiplier"] = {
            friendlyName = "Dano colisao multiplicado",
            information = "Define o dano que seu ve�culo vai come�ar a partir de colis�es.",
            syntax = { "Flutuar", "" }
        },
        ["monetary"] = {
            friendlyName = "Valor Monet�rio",
            information = "Define o pre�o exato do seu ve�culo.",
            syntax = { "N�meroInteiro", "" }
        },
        ["modelFlags"] = {
            friendlyName = "Flags modelo",
            information = "Recursos de anima��es especiais do que pode ser ativado ou desativado.",
            syntax = { "Hexadecimal", "" },
            items = {
                {
                    ["1"] = {"IS_VAN","Permite portas duplas para a anima��o de tr�s."},
                    ["2"] = {"IS_BUS","Ve�culo utiliza paragens de autocarro e vai tentar levar em passageiros."},
                    ["4"] = {"IS_LOW","Motoristas e passageiros se sentar mais baixo e magro."},
                    ["8"] = {"IS_BIG","Muda a maneira que o AI dirige em torno dos cantos."}
                },
                {
                    ["1"] = {"REVERSE_BONNET","Bonnet e bota aberta na dire��o oposta do normal."},
                    ["2"] = {"HANGING_BOOT","Bota abre de borda superior."},
                    ["4"] = {"TAILGATE_BOOT","Bota abre de borda inferior."},
                    ["8"] = {"NOSWING_BOOT","Bota n�o abre."}
                },
                {
                    ["1"] = {"NO_DOORS","Porta anima��es de abertura e fechamento s�o ignorados."},
                    ["2"] = {"TANDEM_SEATS","Duas pessoas ir� utilizar o banco do passageiro da frente."},
                    ["4"] = {"SIT_IN_BOAT","Usa anima��o barco sentado em vez de estar."},
                    ["8"] = {"CONVERTIBLE","Altera��es como prostitutas atuam e outros efeitos pequenos."}
                },
                {
                    ["1"] = {"NO_EXHAUST","Remove todas as part�culas de escape."},
                    ["2"] = {"DBL_EXHAUST","Adiciona uma segunda part�cula escape no lado oposto ao primeiro.."},
                    ["4"] = {"NO1FPS_LOOK_BEHIND","Impede jogador usando retrovisor quando em modo de primeira pessoa."},
                    ["8"] = {"FORCE_DOOR_CHECK","precisa de testes."}
                },
                {
                    ["1"] = {"AXLE_F_NOTILT","Rodas dianteiras ficar vertical para o carro como GTA 3."},
                    ["2"] = {"AXLE_F_SOLID","As rodas da frente ficar paralelas umas �s outras."},
                    ["4"] = {"AXLE_F_MCPHERSON","Rodas dianteiras tilt como GTA Vice City."},
                    ["8"] = {"AXLE_F_REVERSE","nverte a inclina��o das rodas quando se utiliza suspens�o AXLE_F_MCPHERSON."}
                },
                {
                    ["1"] = {"AXLE_R_NOTILT","Rodas traseiras ficar vertical para o carro como GTA 3."},
                    ["2"] = {"AXLE_R_SOLID","Rodas traseiras ficar paralelos um ao outro."},
                    ["4"] = {"AXLE_R_MCPHERSON","Rodas traseiras tilt como GTA Vice City."},
                    ["8"] = {"AXLE_R_REVERSE","Inverte a inclina��o das rodas quando se utiliza eixo de suspens�o MCPHERSON R."}
                },
                {
                    ["1"] = {"IS_BIKE","Use as configura��es de manuseio extra na se��o de bikes."},
                    ["2"] = {"IS_HELI","Use as configura��es de manuseio extra na se��o de voar."},
                    ["4"] = {"IS_PLANE","Use as configura��es de manuseio extra na se��o de voar."},
                    ["8"] = {"IS_BOAT","Use as configura��es de manuseio extra na se��o de voar."}
                },
                {
                    ["1"] = {"BOUNCE_PANELS","precisa de testes."},
                    ["2"] = {"DOUBLE_RWHEELS","Coloca uma segunda inst�ncia de cada roda traseira ao lado do normal."},
                    ["4"] = {"FORCE_GROUND_CLEARANCE","precisa de testes."},
                    ["8"] = {"IS_HATCHBACK","precisa de testes."}
                }
            }
        },
        ["handlingFlags"] = {
            friendlyName = "manipula��o de Bandeiras",
            information = "As caracter�sticas especiais de desempenho.",
            syntax = { "Hexadecimal", "" },
            items = {
                {
                    ["1"] = {"1G_BOOST","D� mais pot�ncia do motor para partidas em p�, ou melhor subidas."},
                    ["2"] = {"2G_BOOST","D� mais pot�ncia do motor em velocidades um pouco mais altas."},
                    ["4"] = {"NPC_ANTI_ROLL","No rolo do corpo quando impulsionada por personagens AI."},
                    ["8"] = {"NPC_NEUTRAL_HANDL","Menos propensos a sair quando impulsionada por personagens AI."}
                },
                {
                    ["1"] = {"NO_HANDBRAKE","Desativa o efeito de trav�o de m�o."},
                    ["2"] = {"STEER_REARWHEELS","Rodas traseiras orientar em vez de frente, como uma empilhadeira."},
                    ["4"] = {"HB_REARWHEEL_STEER","Handbrake faz com que as rodas traseiras orientar, bem como frente, como o monster truck"},
                    ["8"] = {"ALT_STEER_OPT","precisa de testes."}
                },
                {
                    ["1"] = {"WHEEL_F_NARROW2","Muito estreitas rodas dianteiras."},
                    ["2"] = {"WHEEL_F_NARROW","Rodas dianteiras estreitas."},
                    ["4"] = {"WHEEL_F_WIDE","Rodas dianteiras de largura."},
                    ["8"] = {"WHEEL_F_WIDE2","Rodas da frente muito larga."}
                },
                {
                    ["1"] = {"WHEEL_R_NARROW2","Rodas traseiras estreitas."},
                    ["2"] = {"WHEEL_R_NARROW","Rodas traseiras estreitas."},
                    ["4"] = {"WHEEL_R_WIDE","Rodas traseiras largas."},
                    ["8"] = {"WHEEL_R_WIDE2","Muito largas rodas traseiras."}
                },
                {
                    ["1"] = {"HYDRAULIC_GEOM","precisa de testes."},
                    ["2"] = {"HYDRAULIC_INST","V�o aparecer com sistema hidr�ulico instalado."},
                    ["4"] = {"HYDRAULIC_NONE","Sistema hidr�ulico n�o pode ser instalado."},
                    ["8"] = {"NOS_INST","Ve�culo fica automaticamente NOS instalado quando ele gera."}
                },
                {
                    ["1"] = {"OFFROAD_ABILITY","Ve�culo ter� um desempenho melhor em superf�cies soltas, como sujeira."},
                    ["2"] = {"OFFROAD_ABILITY2","Ve�culo ter� um desempenho melhor em superf�cies macias, como areia."},
                    ["4"] = {"HALOGEN_LIGHTS","Faz far�is mais brilhante e mais azul."},
                    ["8"] = {"PROC_REARWHEEL_1ST","precisa de testes."}
                },
                {
                    ["1"] = {"USE_MAXSP_LIMIT","Impede ve�culo indo mais r�pido do que a velocidade m�xima."},
                    ["2"] = {"LOW_RIDER","Permite que o ve�culo a ser modificado em Loco Co lojas Baixa."},
                    ["4"] = {"STREET_RACER","Quando definido, o ve�culo s� podem ser modificados a Roda Arch Anjos."},
                    ["8"] = {"UNDEFINED","Sem efeito."}
                },
                {
                    ["1"] = {"SWINGING_CHASSIS","Permite que o movimento do corpo do carro de um lado para outro sobre a suspens�o."},
                    ["2"] = {"UNDEFINED","Sem efeito."},
                    ["4"] = {"UNDEFINED","Sem efeito."},
                    ["8"] = {"UNDEFINED","Sem efeito."}
                }
            }
        },
        ["headLight"] = {
            friendlyName = "Luzes de cabe�a",
            information = "Define o tipo de luzes dianteiras de seu ve�culo ter�.",
            syntax = { "Integer", "" },
            options = { ["0"]="Longo",["1"]="Pequeno",["2"]="Grande",["3"]="Tall" }
        },
        ["tailLight"] = {
            friendlyName = "Luzes da cauda",
            information = "Define o tipo de luzes traseiras de seu ve�culo ter�.",
            syntax = { "Integer", "" },
            options = { ["0"]="Longo",["1"]="Pequeno",["2"]="Grande",["3"]="Tall" }
        },
        ["animGroup"] = {
            friendlyName = "anima��o Grupo",
            information = "Define o grupo de anima��o de seu ped usar� para ele do ve�culo.",
            syntax = { "Integer", "" }
        }
    }
}