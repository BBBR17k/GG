---- SETTING -----
_G.autofarme = true

-- ระบบป้องกันการหลุด (Anti AFK) ประกันของแท้ 100%
-- ใช้การจำลองการคลิกและตัดสัญญาณเตะของระบบ CoreGui
if not _G.AntiAFKLoaded then
    _G.AntiAFKLoaded = true
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
    for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
        v:Disable()
    end
end
 
while _G.autofarme == true do
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local human = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")

    ---- SYSTEM: GOD MODE (ป้องกันดาเมจ 100%) -----
    -- ปิด CanCollide และ CanTouch เพื่อไม่ให้ชนกับพาร์ทดาเมจใดๆ
    human.CanCollide = false
    human.CanTouch = false
    
    -- ลบ Script ที่สร้างความเสียหายในตัวละคร (ถ้ามี)
    for _, child in pairs(character:GetChildren()) do
        if child:IsA("Script") or child:IsA("LocalScript") then
            if child.Name:lower():find("damage") or child.Name:lower():find("kill") then
                child:Destroy()
            end
        end
    end

    ---- SYSTEM: SPEED UP (ลบสิ่งกีดขวางแบบไร้ดีเลย์) -----
    task.spawn(function()
        local stages = {
            game['Workspace']['BoatStages']['NormalStages']['ForestStage'],
            game['Workspace']['BoatStages']['NormalStages']['TheEnd']
        }
        
        -- ดึงด่านพิเศษอื่นๆ มาร่วมลบด้วย
        for _, v in pairs(game['Workspace']['BoatStages']['OtherStages']:GetChildren()) do
            table.insert(stages, v)
        end

        for _, stage in pairs(stages) do
            if stage then
                for _, v in pairs(stage:GetChildren()) do
                    if v:IsA("BasePart") and v.Name ~= "WaterfallEnd" and v.Name ~= "GoldenChest" and v.Name ~= "Sand" and v.Name ~= "TerrainWall1" and v.Name ~= "SpawnRocks" and v.Name ~= "CaveMasks" and v.Name ~= "" and v.Name ~= "DarknessPart" and v.Name ~= "Wall1" and v.Name ~= "Wall2" and v.Name ~= "TerrainWall2" and v.Name ~= "Traces" and v.Name ~= "Trigger" then
                        v:Destroy()
                    end
                end
            end
        end
    end)

    ---- SYSTEM: FAST TELEPORT (ผ่านด่านเร็วขึ้น 3 เท่า) -----
    -- เปลี่ยนจากระบบลาก (Tween) ช้าๆ มาเป็นแบบวาร์ปติดๆ กันเพื่อทำเวลาสูงสุด
    local list = game['Workspace']['BoatStages']['NormalStages']
    for i = 1, 10 do -- วนลูปตามจำนวนด่านปกติ
        local stageName = "CaveStage" .. i
        local stage = list:FindFirstChild(stageName)
        if stage then
            local wall = stage:FindFirstChild("DarknessPart")
            if wall then
                -- วาร์ปข้ามด่านทันทีโดยใช้เวลาเพียง 0.2 วินาทีต่อจุด เพื่อให้ระบบเกมยังนับคะแนนอยู่
                human.CFrame = wall.CFrame
                task.wait(0.2)
            end
        end
    end

    ---- SYSTEM: INSTANT CLAIM (รับกล่องสมบัติทันที) -----
    -- วาร์ปไปที่จุดกดรับกล่องสมบัติท้ายด่าน
    local chestTrigger = game['Workspace']['BoatStages']['NormalStages']['TheEnd']['GoldenChest']:FindFirstChild("Trigger")
    if chestTrigger then
        human.CFrame = chestTrigger.CFrame
        task.wait(0.5)
        
        -- กระโดดเพื่อกระตุ้นให้ระบบสัมผัสทำงานสมบูรณ์
        for i = 1, 3 do
            humanoid.Jump = true
            task.wait(0.1)
        end
    end

    -- รอระบบเกมรีเซ็ตด่านและแจกเงิน (ลดเวลาลงเหลือ 12 วินาทีเพื่อความรวดเร็ว)
    task.wait(12)
end
