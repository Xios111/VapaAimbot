loadstring(game:HttpGet("https://raw.githubusercontent.com/Nickyangtpe/Vapa-v2/refs/heads/main/Vapav2-Arsenal.lua", true))()

local Aimbot = {
    Enabled = true,
    AimKey = "MouseButton2",
    Smoothness = 0.3,
    FOV = 120
}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VapaAimbot"
ScreenGui.Parent = game.CoreGui

local KeyBtn = Instance.new("TextButton")
KeyBtn.Parent = ScreenGui
KeyBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
KeyBtn.Position = UDim2.new(0, 10, 0, 200)
KeyBtn.Size = UDim2.new(0, 180, 0, 30)
KeyBtn.Text = "Tik: Sag"
KeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBtn.Font = Enum.Font.SourceSansBold
KeyBtn.TextSize = 14

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
ToggleBtn.Position = UDim2.new(0, 10, 0, 240)
ToggleBtn.Size = UDim2.new(0, 180, 0, 30)
ToggleBtn.Text = "Aimbot: ACIK"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 14

ToggleBtn.MouseButton1Click:Connect(function()
    Aimbot.Enabled = not Aimbot.Enabled
    ToggleBtn.Text = Aimbot.Enabled and "Aimbot: ACIK" or "Aimbot: KAPALI"
    ToggleBtn.BackgroundColor3 = Aimbot.Enabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
end)

KeyBtn.MouseButton1Click:Connect(function()
    if Aimbot.AimKey == "MouseButton2" then
        Aimbot.AimKey = "MouseButton1"
        KeyBtn.Text = "Tik: Sol"
    else
        Aimbot.AimKey = "MouseButton2"
        KeyBtn.Text = "Tik: Sag"
    end
end)

local function getClosestTarget()
    local closestTarget = nil
    local closestDistance = Aimbot.FOV
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
            
            if onScreen then
                local distance = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                
                if distance < closestDistance then
                    closestDistance = distance
                    closestTarget = head
                end
            end
        end
    end
    
    return closestTarget
end

RunService.RenderStepped:Connect(function()
    if not Aimbot.Enabled then return end
    
    if UserInputService:IsMouseButtonPressed(Enum.UserInputType[Aimbot.AimKey]) then
        local target = getClosestTarget()
        if target then
            local targetPosition = target.Position
            local currentPosition = Camera.CFrame.Position
            local newCFrame = CFrame.lookAt(currentPosition, targetPosition)
            
            Camera.CFrame = Camera.CFrame:Lerp(newCFrame, Aimbot.Smoothness)
        end
    end
end)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)
 
