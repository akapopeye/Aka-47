local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Frame.Parent = ScreenGui

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0.2, 0)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
TitleLabel.Text = "Aka-47"
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.SourceSans
TitleLabel.TextSize = 24
TitleLabel.Parent = Frame

local WalkSpeedButton = Instance.new("TextButton")
WalkSpeedButton.Size = UDim2.new(1, 0, 0.2, 0)
WalkSpeedButton.Position = UDim2.new(0, 0, 0.3, 0)
WalkSpeedButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
WalkSpeedButton.Text = "Increase WalkSpeed"
WalkSpeedButton.TextColor3 = Color3.new(1, 1, 1)
WalkSpeedButton.Font = Enum.Font.SourceSans
WalkSpeedButton.TextSize = 20
WalkSpeedButton.Parent = Frame

local JumpPowerButton = Instance.new("TextButton")
JumpPowerButton.Size = UDim2.new(1, 0, 0.2, 0)
JumpPowerButton.Position = UDim2.new(0, 0, 0.6, 0)
JumpPowerButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
JumpPowerButton.Text = "Increase JumpPower"
JumpPowerButton.TextColor3 = Color3.new(1, 1, 1)
JumpPowerButton.Font = Enum.Font.SourceSans
JumpPowerButton.TextSize = 20
JumpPowerButton.Parent = Frame

WalkSpeedButton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    character:WaitForChild("Humanoid").WalkSpeed = 100
end)

JumpPowerButton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    character:WaitForChild("Humanoid").JumpPower = 100
end)
