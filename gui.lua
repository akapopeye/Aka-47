local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("HILAROUS", "DarkTheme")

local VisualTab = Window:NewTab("Visual")
local ServerTab = Window:NewTab("Server")

local VisualSection = VisualTab:NewSection("Visuals")
local ServerSection = ServerTab:NewSection("Server")

local player = game.Players.LocalPlayer
local highlights = {}
local tracersActive = false
local boxEspActive = false
local selectedPlayer = nil

local function showNotification(message)
    local notification = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    local frame = Instance.new("Frame", notification)
    frame.Size = UDim2.new(0.3, 0, 0.1, 0)
    frame.Position = UDim2.new(0.35, 0, 0.9, 0)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    frame.BackgroundTransparency = 0.4
    frame.ZIndex = 10
    frame.ClipsDescendants = true

    local roundedCorner = Instance.new("UICorner", frame)
    roundedCorner.CornerRadius = UDim.new(0, 10)

    local textLabel = Instance.new("TextLabel", frame)
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Text = message
    textLabel.TextScaled = true
    textLabel.TextStrokeTransparency = 0.5
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.TextWrapped = true

    wait(3)
    notification:Destroy()
end

VisualSection:NewToggle("Activer ESP", "Activer/Désactiver l'ESP", function(state)
    if state then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= player then
                local highlight = Instance.new("Highlight", game.CoreGui)
                highlight.Adornee = v.Character or v.CharacterAdded:Wait()
                highlight.FillColor = Color3.new(1, 0, 0)
                highlight.OutlineColor = Color3.new(0, 0, 0)
                highlights[v.UserId] = highlight
                    
                local nameLabel = Instance.new("BillboardGui", highlight)
                nameLabel.Adornee = v.Character:WaitForChild("Head")
                nameLabel.Size = UDim2.new(1, 0, 1, 0)
                nameLabel.StudsOffset = Vector3.new(0, 2, 0)
                nameLabel.AlwaysOnTop = true

                local nameText = Instance.new("TextLabel", nameLabel)
                nameText.Size = UDim2.new(1, 0, 1, 0)
                nameText.BackgroundTransparency = 1
                nameText.TextColor3 = Color3.new(1, 1, 1)
                nameText.Text = v.Name
                nameText.TextScaled = true
                nameText.TextStrokeTransparency = 0.5
                nameText.TextWrapped = true
            end
        end
        showNotification("ESP activé")
    else
        for _, highlight in pairs(highlights) do
            highlight:Destroy()
        end
        highlights = {}
        showNotification("ESP désactivé")
    end
end)

VisualSection:NewToggle("Activer Box ESP", "Activer/Désactiver Box ESP", function(state)
    if state then
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= player then
                local box = Instance.new("BoxHandleAdornment")
                box.Adornee = v.Character:WaitForChild("HumanoidRootPart")
                box.Size = Vector3.new(2, 5, 1)
                box.Color3 = Color3.new(0, 1, 1)
                box.Parent = game.CoreGui
                box.ZIndex = 5
                box.AlwaysOnTop = true
            end
        end
        showNotification("Box ESP activée")
    else
        for _, box in pairs(game.CoreGui:GetChildren()) do
            if box:IsA("BoxHandleAdornment") then
                box:Destroy()
            end
        end
        showNotification("Box ESP désactivée")
    end
end)

VisualSection:NewToggle("Activer Tracers", "Activer/Désactiver les tracers", function(state)
    tracersActive = state
    if tracersActive then
        game:GetService("RunService").RenderStepped:Connect(function()
            if tracersActive then
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local line = Instance.new("LineHandleAdornment")
                        line.Adornee = player.Character.HumanoidRootPart
                        line.Length = (v.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        line.Color3 = Color3.new(0, 1, 0)
                        line.Parent = game.CoreGui
                        line.ZIndex = 5
                        line.AlwaysOnTop = true
                        line.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position, v.Character.HumanoidRootPart.Position)
                    end
                end
            end
        end)
        showNotification("Tracers activés")
    else
        for _, line in pairs(game.CoreGui:GetChildren()) do
            if line:IsA("LineHandleAdornment") then
                line:Destroy()
            end
        end
        showNotification("Tracers désactivés")
    end
end)

ServerSection:NewButton("Mettre à jour la liste des joueurs", "Mettre à jour la liste pour voir les joueurs actuels", function()
    local playerNames = {}
    for _, v in pairs(game.Players:GetPlayers()) do
        table.insert(playerNames, v.Name)
    end
    ServerSection:UpdateDropdown("Liste des joueurs", playerNames)
    showNotification("Liste des joueurs mise à jour")
end)

ServerSection:NewTextbox("Nom du joueur à sélectionner", "Écrivez le nom du joueur", function(name)
    selectedPlayer = game.Players:FindFirstChild(name)
    if selectedPlayer then
        showNotification("Joueur sélectionné : " .. selectedPlayer.Name)
    else
        showNotification("Joueur non trouvé")
    end
end)

local function updatePlayerList()
    local playerNames = {}
    for _, v in pairs(game.Players:GetPlayers()) do
        table.insert(playerNames, v.Name)
    end
    ServerSection:UpdateDropdown("Liste des joueurs", playerNames)
end

game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)

ServerSection:NewDropdown("Liste des joueurs", "Sélectionnez un joueur pour des actions", {}, function(playerName)
    selectedPlayer = game.Players:FindFirstChild(playerName)
    if selectedPlayer then
        showNotification("Joueur sélectionné : " .. selectedPlayer.Name)
    else
        showNotification("Aucun joueur sélectionné.")
    end
end)

ServerSection:NewButton("Kicker le joueur sélectionné", "Kicker le joueur sélectionné", function()
    if selectedPlayer then
        selectedPlayer:Kick("Vous avez été kické par un admin.")
        showNotification("Joueur kické : " .. selectedPlayer.Name)
    else
        showNotification("Aucun joueur sélectionné.")
    end
end)

ServerSection:NewButton("Donner un code d'erreur au joueur sélectionné", "Donner un code d'erreur au joueur sélectionné", function()
    if selectedPlayer then
        selectedPlayer:Kick("Erreur : Code 404.")
        showNotification("Code d'erreur donné à : " .. selectedPlayer.Name)
    else
        showNotification("Aucun joueur sélectionné.")
    end
end)

updatePlayerList()
