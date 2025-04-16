-- Rayfield UI Loader
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local autoGreenEnabled = false

-- UI
local Window = Rayfield:CreateWindow({
    Name = "Diamond Hub",
    LoadingTitle = "RH2",
    ConfigurationSaving = {
        Enabled = false
    },
    KeySystem = false
})

local Tab = Window:CreateTab("Test Tools", 4483362458)
Tab:CreateSection("Tirs")

Tab:CreateToggle({
    Name = "Auto Green ",
    CurrentValue = false,
    Flag = "AutoGreenSilent",
    Callback = function(value)
        autoGreenEnabled = value
    end,
})

-- Accès à la remote
local shootEvent = game:GetService("ReplicatedStorage"):WaitForChild("Shoot")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Fausse fonction "human-like"
local function getLegitTiming()
    -- Retourne un timing dans une "zone verte" crédible, genre 0.92 - 0.98
    return math.random(920, 980) / 1000
end

local function getPower()
    -- Simule un joueur qui varie un peu sa puissance
    return math.random(85, 100)
end

local function getAngle()
    -- Simule un angle légèrement variable
    return math.random(40, 48)
end

-- Tir simulé
local function silentGreenShoot()
    if not autoGreenEnabled then return end

    local shotData = {
        timing = getLegitTiming(),
        power = getPower(),
        angle = getAngle(),
        -- on n’envoie pas isGreen du tout
    }

    shootEvent:FireServer(shotData)
end

-- Appui sur G => shoot
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.G then
        -- petite latence humaine simulée
        task.delay(math.random(0.05, 0.15), function()
            silentGreenShoot()
        end)
    end
end)
