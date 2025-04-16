--[[ 
💎 Diamond Hub - Créé par Moha 
Fonctions :
- Menu UI amélioré avec un design élégant
- Reach personnalisable
- Auto Goal
- Infini Stamina
- Fonctionnalités avec un style premium
]]

-- SERVICES & VARIABLES
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local reach = 3
local menuOpen = false
local staminaEnabled = false

-- UI SETUP (Menu Diamond Hub)
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "DiamondHub"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0, 20, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Visible = false
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.1
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.ZIndex = 10

-- Diamond Hub Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "💎 Diamond Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(0, 170, 255) -- Blue gradient background
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextStrokeTransparency = 0.8
title.TextStrokeColor3 = Color3.fromRGB(0, 102, 204)
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextYAlignment = Enum.TextYAlignment.Center

-- Subtitle "Créé par Moha"
local subtitle = Instance.new("TextLabel", frame)
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 40)
subtitle.Text = "Créé par Moha"
subtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
subtitle.BackgroundTransparency = 1
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 14
subtitle.TextXAlignment = Enum.TextXAlignment.Center
subtitle.TextYAlignment = Enum.TextYAlignment.Center

-- Buttons Setup
local function createButton(text, position, callback)
    local button = Instance.new("TextButton", frame)
    button.Size = UDim2.new(0, 260, 0, 40)
    button.Position = position
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 18
    button.TextStrokeTransparency = 0.8
    button.TextStrokeColor3 = Color3.fromRGB(0, 102, 204)
    button.BorderSizePixel = 0
    button.AutoButtonColor = true

    -- Hover effect
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)

    button.MouseButton1Click:Connect(callback)

    return button
end

-- Buttons for functionality
local reachLabel = Instance.new("TextLabel", frame)
reachLabel.Position = UDim2.new(0, 20, 0, 90)
reachLabel.Size = UDim2.new(1, -40, 0, 20)
reachLabel.Text = "Reach: " .. tostring(reach)
reachLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
reachLabel.BackgroundTransparency = 1
reachLabel.Font = Enum.Font.Gotham
reachLabel.TextSize = 14

local increaseBtn = createButton("+", UDim2.new(0, 20, 0, 120), function()
    reach = reach + 1
    reachLabel.Text = "Reach: " .. tostring(reach)
end)

local decreaseBtn = createButton("-", UDim2.new(0, 20, 0, 160), function()
    if reach > 1 then
        reach = reach - 1
        reachLabel.Text = "Reach: " .. tostring(reach)
    end
end)

local autoGoalBtn = createButton("⚽ Auto Goal", UDim2.new(0, 20, 0, 200), function()
    local ball = workspace:FindFirstChild("Ball")
    local goal = workspace:FindFirstChild("Goal")
    if ball and goal then
        ball.CFrame = goal.CFrame + Vector3.new(0, 2, 0)
        print("🚀 Auto Goal activé")
    else
        warn("❌ Ball ou Goal introuvable")
    end
end)

local staminaBtn = createButton("💨 Infini Stamina: OFF", UDim2.new(0, 20, 0, 240), function()
    staminaEnabled = not staminaEnabled
    staminaBtn.Text = staminaEnabled and "💨 Infini Stamina: ON" or "💨 Infini Stamina: OFF"
end)

-- MENU TOGGLE (RightShift)
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        menuOpen = not menuOpen
        frame.Visible = menuOpen
    end
end)

-- Cheat Loops
RunService.RenderStepped:Connect(function()
    -- Reach hit simulation
    for _, target in pairs(Players:GetPlayers()) do
        if target ~= LocalPlayer and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local root = target.Character.HumanoidRootPart
            local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if myRoot and (myRoot.Position - root.Position).Magnitude <= reach then
                print("💢 Touché :", target.Name)
                -- À relier avec un RemoteEvent si tu veux activer des effets
            end
        end
    end

    -- Infini stamina
    if staminaEnabled and LocalPlayer.Character then
        local stamina = LocalPlayer.Character:FindFirstChild("Stamina")
        if stamina and stamina:IsA("NumberValue") then
            stamina.Value = 100 -- Change selon ta valeur max
        end
    end
end)
