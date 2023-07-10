addEvent("onRequestLogin",true)
addEventHandler("onRequestLogin",resourceRoot,
	function(username,password,checksave)
		if not (username == "") then
			if not (password == "") then
				local account = getAccount ( username, password )
				if ( account ~= false ) then
					logIn(client,account,password)
					triggerClientEvent (client,"onClientPlayerLogin",resourceRoot)
					if checksave and checksave == "1" then
						triggerClientEvent(client,"useLoginFile",resourceRoot,"set",username,password)
					else
						triggerClientEvent(client,"useLoginFile",resourceRoot,"remove",username,password)
					end
				else
					triggerClientEvent(client,"setNotification",resourceRoot,"Errado nome de usuário ou senha!")
				end
			else
				triggerClientEvent(client,"setNotification",resourceRoot,"Por favor, digite sua senha!")
			end
		else
			triggerClientEvent(client,"setNotification",resourceRoot,"Digite seu nome de usuário!")
		end
	end
)

addEvent("onRequestRegister",true)
addEventHandler("onRequestRegister",resourceRoot,
	function(username,password,repassword)
		if not (username == "") then
			if not (password == "") then
				if not (repassword == "") then
					if password == repassword then
						local account = getAccount (username)
						if (account == false) then
							local accountAdded = addAccount(tostring(username),tostring(password))
							if (accountAdded) then
								logIn(client,accountAdded,password)
								triggerClientEvent(client,"onClientPlayerLogin",resourceRoot)
								triggerClientEvent(client,"useLoginFile",resourceRoot,"set",username,password)
								outputChatBox("*Você se cadastrou com sucesso! ( Nome de Usuário: #ee8a11" .. username .. " #FFFFFF| Senha: #ee8a11" .. password .. "#FFFFFF )",client,255,255,255,true)
							else
								triggerClientEvent(client,"setNotification",resourceRoot,"Por favor, escolha uma conta e/ou senha diferente")
							end
						else
							triggerClientEvent(client,"setNotification",resourceRoot,"Uma conta com este nome de usuário já existe!")
						end
					else
						triggerClientEvent(client,"setNotification",resourceRoot,"As senhas não coincidem!")
					end
				else
					triggerClientEvent(client,"setNotification",resourceRoot,"Por favor, confirme sua senha!")
				end
			else
				triggerClientEvent(client,"setNotification",resourceRoot,"Por favor, insira uma senha para sua nova conta!")
			end
		else
			triggerClientEvent(client,"setNotification",resourceRoot,"Por favor, insira um nome de usuário para criar uma conta!")
		end
	end
)