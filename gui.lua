local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("HILAROUS", "DarkTheme")

local ModTab = Window:NewTab("Mods")
local ModSection = ModTab:NewSection("Modifications")

local MovementsSection = ModTab:NewSection("Movements")
local VisualSection = ModTab:NewSection("Visual")
local ServerSection = ModTab:NewSection("Server")

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

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

local speedPower = 16
local jumpPower = 50
local flying = false
local bodyVelocity, bodyGyro

MovementsSection:NewButton("Increase Speed Power", "Augmenter la vitesse", function()
    speedPower = 50
    humanoid.WalkSpeed = speedPower
    showNotification("Vitesse augmentée à " .. speedPower)
end)

MovementsSection:NewButton("Increase Jump Power", "Augmenter le saut", function()
    jumpPower = 100
    humanoid.JumpPower = jumpPower
    showNotification("Saut augmenté à " .. jumpPower)
end)

MovementsSection:NewButton("Fly like a Hero", "Voler comme un héros", function()
    if not flying then
        flying = true
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Parent = character:WaitForChild("HumanoidRootPart")

        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
        bodyGyro.P = 3000
        bodyGyro.Parent = character:WaitForChild("HumanoidRootPart")

        while flying do
            bodyVelocity.Velocity = Vector3.new(0, 50, 0)
            wait(0.1)
        end
    else
        flying = false
        bodyVelocity:Destroy()
        bodyGyro:Destroy()
        showNotification("Arrêt du vol")
    end
end)

VisualSection:NewButton("ESP", "Activer ESP", function()
    local ESP = Instance.new("Folder", game.CoreGui)
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player then
            local highlight = Instance.new("Highlight", ESP)
            highlight.Adornee = v.Character or v.CharacterAdded:Wait()
            highlight.FillColor = Color3.new(1, 0, 0)
            highlight.OutlineColor = Color3.new(0, 0, 0)
        end
    end
    showNotification("ESP activé")
end)

VisualSection:NewButton("Tracers", "Activer Tracers", function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player then
            local line = Instance.new("LineHandleAdornment")
            line.Adornee = v.Character and v.Character:FindFirstChild("HumanoidRootPart")
            line.Length = (line.Adornee.Position - player.Character.HumanoidRootPart.Position).Magnitude
            line.Color3 = Color3.new(0, 1, 0)
            line.Parent = player.Character
        end
    end
    showNotification("Tracers activés")
end)

VisualSection:NewButton("Box ESP", "Activer Box ESP", function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player then
            local box = Instance.new("BoxHandleAdornment")
            box.Adornee = v.Character:WaitForChild("HumanoidRootPart")
            box.Size = Vector3.new(2, 5, 1)
            box.Color3 = Color3.new(0, 0, 1)
            box.Parent = game.CoreGui
        end
    end
    showNotification("Box ESP activé")
end)

VisualSection:NewButton("Full ESP", "Activer Full ESP", function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player then
            local highlight = Instance.new("Highlight", game.CoreGui)
            highlight.Adornee = v.Character or v.CharacterAdded:Wait()
            highlight.FillColor = Color3.new(1, 0, 1)
            highlight.OutlineColor = Color3.new(0, 0, 0)

            local box = Instance.new("BoxHandleAdornment")
            box.Adornee = v.Character:WaitForChild("HumanoidRootPart")
            box.Size = Vector3.new(2, 5, 1)
            box.Color3 = Color3.new(0, 1, 1)
            box.Parent = game.CoreGui
        end
    end
    showNotification("Full ESP activé")
end)

local function getPlayerList()
    local playerList = {}
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player then
            table.insert(playerList, v.Name)
        end
    end
    return playerList
end

local selectedPlayer = nil

ServerSection:NewDropdown("Select Player", getPlayerList(), function(selected)
    selectedPlayer = selected
end)

ServerSection:NewButton("Kick Player", "Éjecter un joueur", function()
    if selectedPlayer then
        local playerInstance = game.Players:FindFirstChild(selectedPlayer)
        if playerInstance then
            playerInstance:Kick("Vous avez été éjecté du serveur.")
            showNotification(selectedPlayer .. " a été éjecté.")
        else
            showNotification("Joueur introuvable.")
        end
    else
        showNotification("Veuillez sélectionner un joueur.")
    end
end)

ServerSection:NewButton("Change Player's WalkSpeed", "Modifier la vitesse de marche d'un joueur", function()
    if selectedPlayer then
        local newWalkSpeed = 50
        local playerInstance = game.Players:FindFirstChild(selectedPlayer)
        if playerInstance then
            local character = playerInstance.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = newWalkSpeed
                    showNotification("Vitesse de marche de " .. selectedPlayer .. " modifiée.")
                else
                    showNotification("Humanoïde introuvable.")
                end
            else
                showNotification("Personnage introuvable.")
            end
        else
            showNotification("Joueur introuvable.")
        end
    else
        showNotification("Veuillez sélectionner un joueur.")
    end
end)

ServerSection:NewButton("Give Tool", "Donner un outil à un joueur", function()
    if selectedPlayer then
        local toolName = "PlayerName"
        local playerInstance = game.Players:FindFirstChild(selectedPlayer)
        if playerInstance then
            local tool = game.ServerStorage:FindFirstChild(toolName):Clone()
            tool.Parent = playerInstance.Backpack
            showNotification("Outil " .. toolName .. " donné à " .. selectedPlayer .. ".")
        else
            showNotification("Joueur introuvable.")
        end
    else
        showNotification("Veuillez sélectionner un joueur.")
    end
end)

local SettingsTab = Window:NewTab("Settings")
local SettingsSection = SettingsTab:NewSection("")

local function addFooter()
    local footer = Instance.new("TextLabel")
    footer.Size = UDim2.new(1, 0, 0.1, 0)
    footer.Position = UDim2.new(0, 0, 0.9, 0)
    footer.BackgroundTransparency = 1
    footer.TextColor3 = Color3.fromRGB(255, 255, 255)
    footer.Text = "HILAROUS v1.0"
    footer.Font = Enum.Font.SourceSans
    footer.TextSize = 24
    footer.TextStrokeTransparency = 0.5
    footer.Parent = Window
end

addFooter()
