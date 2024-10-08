local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Frame.BorderSizePixel = 0
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Frame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0.2, 0)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
TitleLabel.BorderSizePixel = 0
TitleLabel.Text = "Aka-47"
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 24
TitleLabel.Parent = Frame

local WalkSpeedButton = Instance.new("TextButton")
WalkSpeedButton.Size = UDim2.new(0.8, 0, 0.2, 0)
WalkSpeedButton.Position = UDim2.new(0.1, 0, 0.3, 0)
WalkSpeedButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
WalkSpeedButton.BorderSizePixel = 0
WalkSpeedButton.Text = "Increase WalkSpeed"
WalkSpeedButton.TextColor3 = Color3.new(1, 1, 1)
WalkSpeedButton.Font = Enum.Font.Gotham
WalkSpeedButton.TextSize = 20
WalkSpeedButton.Parent = Frame

local JumpPowerButton = Instance.new("TextButton")
JumpPowerButton.Size = UDim2.new(0.8, 0, 0.2, 0)
JumpPowerButton.Position = UDim2.new(0.1, 0, 0.6, 0)
JumpPowerButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
JumpPowerButton.BorderSizePixel = 0
JumpPowerButton.Text = "Increase JumpPower"
JumpPowerButton.TextColor3 = Color3.new(1, 1, 1)
JumpPowerButton.Font = Enum.Font.Gotham
JumpPowerButton.TextSize = 20
JumpPowerButton.Parent = Frame

local UICornerWalkSpeed = Instance.new("UICorner")
UICornerWalkSpeed.CornerRadius = UDim.new(0, 8)
UICornerWalkSpeed.Parent = WalkSpeedButton

local UICornerJumpPower = Instance.new("UICorner")
UICornerJumpPower.CornerRadius = UDim.new(0, 8)
UICornerJumpPower.Parent = JumpPowerButton

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
