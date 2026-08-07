-- [[ DELTA EXECUTOR - THE ULTIMATE BYPASS GOD-KILL HUB 2026 ]] --
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local TrueGodActive = false
local HitboxActive = false
local OneShotActive = false
local KillAuraActive = false
local HitboxSize = 30

pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("UltimateServerDestroyerGui") then
        game:GetService("CoreGui").UltimateServerDestroyerGui:Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateServerDestroyerGui"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 340, 0, 300)
MainFrame.Position = UDim2.new(0.5, -170, 0.3, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.Text = "REAL GOD HUB"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.TextSize = 14
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local SizeDisplay = Instance.new("TextLabel")
SizeDisplay.Size = UDim2.new(0, 140, 0, 35)
SizeDisplay.Position = UDim2.new(0, 100, 0, 145)
SizeDisplay.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SizeDisplay.Text = "Xbox Size: " .. tostring(HitboxSize)
SizeDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
SizeDisplay.TextSize = 14
SizeDisplay.Font = Enum.Font.SourceSansBold
SizeDisplay.Parent = MainFrame

local function CreateToggleButton(name, pos, size, callback)
    local Button = Instance.new("TextButton")
    Button.Size = size
    Button.Position = pos
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Button.Text = name .. " : OFF"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    Button.Font = Enum.Font.SourceSansBold
    Button.Parent = MainFrame
    
    local state = false
    Button.MouseButton1Click:Connect(function()
        state = not state
        Button.BackgroundColor3 = state and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(45, 45, 45)
        Button.Text = name .. (state and " : ON" or " : OFF")
        callback(state)
    end)
end

CreateToggleButton("True Online God Mode", UDim2.new(0, 20, 0, 45), UDim2.new(0, 300, 0, 40), function(v) TrueGodActive = v end)
CreateToggleButton("Expand Enemy Xbox", UDim2.new(0, 20, 0, 95), UDim2.new(0, 300, 0, 40), function(v) 
    HitboxActive = v 
    if not v then
        pcall(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local EnemyRoot = player.Character.HumanoidRootPart
                    EnemyRoot.Size = Vector3.new(2, 2, 1)
                    EnemyRoot.Transparency = 0
                    EnemyRoot.CanCollide = true
                end
            end
        end)
    end
end)

local MinusSize = Instance.new("TextButton")
MinusSize.Size = UDim2.new(0, 60, 0, 35)
MinusSize.Position = UDim2.new(0, 20, 0, 145)
MinusSize.BackgroundColor3 = Color3.fromRGB(50, 15, 15)
MinusSize.Text = "[-]"
MinusSize.TextColor3 = Color3.fromRGB(255, 255, 255)
MinusSize.TextSize = 15
MinusSize.Font = Enum.Font.SourceSansBold
MinusSize.Parent = MainFrame
MinusSize.MouseButton1Click:Connect(function()
    if HitboxSize > 5 then 
        HitboxSize = HitboxSize - 5 
        SizeDisplay.Text = "Xbox Size: " .. tostring(HitboxSize) 
    end
end)

local PlusSize = Instance.new("TextButton")
PlusSize.Size = UDim2.new(0, 60, 0, 35)
PlusSize.Position = UDim2.new(0, 240, 0, 145)
PlusSize.BackgroundColor3 = Color3.fromRGB(15, 50, 15)
PlusSize.Text = "[+]"
PlusSize.TextColor3 = Color3.fromRGB(255, 255, 255)
PlusSize.TextSize = 15
PlusSize.Font = Enum.Font.SourceSansBold
PlusSize.Parent = MainFrame
PlusSize.MouseButton1Click:Connect(function()
    if HitboxSize < 150 then 
        HitboxSize = HitboxSize + 5 
        SizeDisplay.Text = "Xbox Size: " .. tostring(HitboxSize) 
    end
end)

CreateToggleButton("Absolute Kill-Touch", UDim2.new(0, 20, 0, 195), UDim2.new(0, 300, 0, 40), function(v) OneShotActive = v end)
CreateToggleButton("Auto Kill Aura", UDim2.new(0, 20, 0, 245), UDim2.new(0, 300, 0, 40), function(v) KillAuraActive = v end)

task.spawn(function()
    while true do
        RunService.RenderStepped:Wait()
        if TrueGodActive then
            pcall(function()
                local Character = LocalPlayer.Character
                local Root = Character and Character:FindFirstChild("HumanoidRootPart")
                local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                
                if Character and Root and Humanoid then
                    Humanoid.Health = Humanoid.MaxHealth
                    for _, part in pairs(Character:GetChildren()) do
                        if part:IsA("BasePart") then part.CanTouch = false end
                    end
                    
                    local RealCFrame = Root.CFrame
                    Root.CFrame = RealCFrame * CFrame.new(0, 999999, 0)
                    RunService.Heartbeat:Wait()
                    Root.CFrame = RealCFrame
                    Root.Velocity = Vector3.new(0, 0, 0)
                end
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.5)
        if HitboxActive then
            pcall(function()
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local EnemyRoot = player.Character.HumanoidRootPart
                        EnemyRoot.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
                        EnemyRoot.Transparency = 0.6
                        EnemyRoot.CanCollide = false
                    end
                end
            end)
        end
    end
end)

local function ObliterateEnemy(EnemyCharacter, EnemyRoot, WeaponPart)
    pcall(function()
        EnemyCharacter:BreakJoints()
        if EnemyCharacter:FindFirstChild("Head") then
            EnemyCharacter.Head:Destroy()
        end
        for i = 1, 200 do
            firetouchinterest(WeaponPart, EnemyRoot, 0)
            firetouchinterest(WeaponPart, EnemyRoot, 1)
        end
    end)
end

task.spawn(function()
    while true do
        task.wait(0.01)
        pcall(function()
            local Character = LocalPlayer.Character
            local Tool = Character and Character:FindFirstChildOfClass("Tool")
            
            if Tool and (Tool:FindFirstChild("Handle") or Tool:FindFirstChildOfClass("BasePart")) then
                local WeaponPart = Tool:FindFirstChild("Handle") or Tool:FindFirstChildOfClass("BasePart")
                
                for _, enemy in pairs(Players:GetPlayers()) do
                    if enemy ~= LocalPlayer and enemy.Character then
                        local EnemyCharacter = enemy.Character
                        local EnemyRoot = EnemyCharacter:FindFirstChild("HumanoidRootPart")
                        local EnemyHumanoid = EnemyCharacter:FindFirstChildOfClass("Humanoid")
                        local MyRoot = Character:FindFirstChild("HumanoidRootPart")
                        
                        if EnemyRoot and EnemyHumanoid and MyRoot and EnemyHumanoid.Health >= 0 then
                            local Distance = (MyRoot.Position - EnemyRoot.Position).Magnitude
                            
                            if OneShotActive and Distance < (HitboxSize + 10) then
                                ObliterateEnemy(EnemyCharacter, EnemyRoot, WeaponPart)
                            elseif KillAuraActive and Distance < 35 then
                                Tool:Activate()
                                ObliterateEnemy(EnemyCharacter, EnemyRoot, WeaponPart)
                            end
                        end
                    end
                end
            end
        end)
    end
end)

print("★ LOADED ★")
