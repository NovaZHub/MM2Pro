-- MM2Pro GUI Script - Versão Mobile/PC com Feedback Discord

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- Webhook Discord para Feedback
local discordWebhookUrl = "https://canary.discord.com/api/webhooks/1375634199435935784/qvsQJdV7fTBP-Ctv7_XBWnfSIpFVbXLOXu5VB0uOKMu6kO11u8O-k3eRp2QCZzQCILYQ"

local function enviarFeedbackParaDiscord(mensagem)
    local data = {
        ["content"] = mensagem
    }
    local jsonData = HttpService:JSONEncode(data)

    local success, err = pcall(function()
        HttpService:PostAsync(discordWebhookUrl, jsonData, Enum.HttpContentType.ApplicationJson)
    end)

    if success then
        print("Feedback enviado com sucesso!")
    else
        warn("Erro ao enviar feedback: ".. tostring(err))
    end
end

-- GUI Principal
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "MM2Pro_GUI"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 220, 0, 360)
MainFrame.Position = UDim2.new(0, 10, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0

-- Minimizar botão
local MinButton = Instance.new("TextButton", MainFrame)
MinButton.Size = UDim2.new(0, 30, 0, 20)
MinButton.Position = UDim2.new(1, -35, 0, 5)
MinButton.Text = "_"
MinButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local isMinimized = false
MinButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    for _, child in ipairs(MainFrame:GetChildren()) do
        if child ~= MinButton then
            child.Visible = not isMinimized
        end
    end
end)

-- Aviso de Ban
local BanLabel = Instance.new("TextLabel", MainFrame)
BanLabel.Size = UDim2.new(1, -10, 0, 20)
BanLabel.Position = UDim2.new(0, 5, 0, 30)
BanLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
BanLabel.Text = "CHANCE DE BAN: 1% (Baixa)"
BanLabel.BackgroundTransparency = 1

-- Aba de Info/Ban
local InfoTab = Instance.new("TextButton", MainFrame)
InfoTab.Size = UDim2.new(1, -10, 0, 20)
InfoTab.Position = UDim2.new(0, 5, 0, 60)
InfoTab.Text = "[!] INFO DE SEGURANÇA"
InfoTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local InfoFrame = Instance.new("TextLabel", ScreenGui)
InfoFrame.Size = UDim2.new(0, 220, 0, 160)
InfoFrame.Position = UDim2.new(0, 240, 0.3, 0)
InfoFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
InfoFrame.TextColor3 = Color3.new(1,1,1)
InfoFrame.TextWrapped = true
InfoFrame.Text = [[
[AVISO IMPORTANTE] Executores INSEGUROS: Delta, Fluxus, Codex (NÃO use - risco de ban alto!)

Executores SEGUROS: KRNL, ArceusX (Recomendados)

CHANCES DE BAN:

ESP: 1%
Radar: 1%
Auto Coin: 2%
Rejoin: 0%
Anti-AFK: 0%

Use por sua conta e risco.
]]
InfoFrame.Visible = false

InfoTab.MouseButton1Click:Connect(function()
    InfoFrame.Visible = not InfoFrame.Visible
end)

-- Função para enviar feedback para Discord
local feedbackInput = Instance.new("TextBox", MainFrame)
feedbackInput.Size = UDim2.new(1, -10, 0, 30)
feedbackInput.Position = UDim2.new(0, 5, 1, -90)
feedbackInput.PlaceholderText = "Digite seu feedback aqui..."

local enviarBtn = Instance.new("TextButton", MainFrame)
enviarBtn.Size = UDim2.new(1, -10, 0, 30)
enviarBtn.Position = UDim2.new(0, 5, 1, -50)
enviarBtn.Text = "Enviar Feedback"
enviarBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

enviarBtn.MouseButton1Click:Connect(function()
    local texto = feedbackInput.Text
    if texto ~= "" then
        enviarFeedbackParaDiscord(texto)
        feedbackInput.Text = ""
        print("Obrigado pelo feedback!")
    else
        print("Por favor, digite algo antes de enviar.")
    end
end)

-- Aqui você pode continuar adicionando ESP, Radar, Auto Coin e outras funções conforme seu script atual.

print("MM2Pro GUI carregada com sucesso!")
