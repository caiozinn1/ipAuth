local ipliberado = ""
local webhooklogsucesso = ""
local webhooklogerro= ""

local function logSucesso() 
    PerformHttpRequest(webhooklogsucesso, function(err, text, headers) end, 'POST', json.encode({username = 'Log', embeds = {
        { 	------------------------------------------------------------
            title = "Autenticado com sucesso",
            fields = {
                {
                    name = "IP Autenticado",
                    value = "```"..ipliberado.."```"
                },
            }, 
            footer = { 
                text = "Autenticação IP     "..os.date("%d/%m/%Y | %H:%M:%S")
            },
            color = 1286027
        }
    }
}), { ['Content-Type'] = 'application/json' })
end

local function logInvalido(ipUsado) 
    PerformHttpRequest(webhooklogsucesso, function(err, text, headers) end, 'POST', json.encode({username = 'Log', embeds = {
        { 	------------------------------------------------------------
            title = "Erro na autenticacao",
            fields = {
                {
                    name = "IP Liberado",
                    value = "```"..ipliberado.."```"
                },
                {
                    name = "IP Usado",
                    value = "```"..ipUsado.."```"
                },
            }, 
            footer = { 
                text = "Autenticação IP     "..os.date("%d/%m/%Y | %H:%M:%S")
            },
            color = 1286027
        }
    }
}), { ['Content-Type'] = 'application/json' })
end

PerformHttpRequest('https://api.ipify.org/?format=json', function(errorCode, result, resultHeaders)
    local data = json.decode(result)
    local userIp = data.ip
    if ipliberado == userIp then 
        print("Autenticado com sucesso!")
        logSucesso()
        auth = true
    else
        print("Ip Invalido")
        logInvalido(userIp)
        auth = false
        return
    end
    
end, 'GET', json.encode({}), {['Content-Type'] = 'application/json'})

if auth == true then 
    --Seu codigo
    --Lembrando que é uma autenticacao muito simples e facil de quebrar
end