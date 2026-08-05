-- DELTA X "GOD MODE CYBER-GLASS" ULTIMATE EDITION
local P, Cam, RS, UIS, TS = game:GetService("Players"), workspace.CurrentCamera, game:GetService("RunService"), game:GetService("UserInputService"), game:GetService("TweenService")
local LP, S, Rainbow, ESP = P.LocalPlayer, {Aim = false, ESP = false, Head = false, FOV = 130}, Color3.fromRGB(255,0,0), {}

-- อัปเกรด Aura Pulse FOV สีดำกลางจอ คมชัดสูง
local FOV = Drawing.new("Circle")
FOV.Thickness, FOV.NumSides, FOV.Radius, FOV.Filled, FOV.Color, FOV.Visible = 2, 64, S.FOV, false, Color3.fromRGB(0,0,0), true

task.spawn(function() 
    local h = 0 while task.wait() do h = (h + 1.5) % 360 Rainbow = Color3.fromHSV(h/360, 1, 1) end 
end)

local function isVisible(t)
    if not t.Character or not t.Character:FindFirstChild("HumanoidRootPart") then return false end
    local p = RaycastParams.new() p.FilterType, p.FilterDescendantsInstances = Enum.RaycastFilterType.Exclude, {LP.Character, t.Character}
    return not workspace:Raycast(Cam.CFrame.Position, t.Character.HumanoidRootPart.Position - Cam.CFrame.Position, p)
end

local function getTarget()
    local cl, sh = nil, S.FOV
    for _, p in ipairs(P:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 and isVisible(p) then
            local part = p.Character:FindFirstChild(S.Head and "Head" or "HumanoidRootPart")
            if part then
                local pos, on = Cam:WorldToViewportPoint(part.Position)
                local d = (Vector2.new(pos.X, pos.Y) - Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)).Magnitude
                if on and d < sh then sh, cl = d, p end
            end
        end
    end return cl
end

local function setESP(p, st)
    if st and not ESP[p] then
        ESP[p] = {Box = Drawing.new("Square"), BoxBG = Drawing.new("Square"), Tracer = Drawing.new("Line"), TracerShadow = Drawing.new("Line")}
        ESP[p].Box.Thickness, ESP[p].Box.Filled, ESP[p].Box.Color = 2.5, false, Color3.fromRGB(0, 210, 255)
        ESP[p].BoxBG.Thickness, ESP[p].BoxBG.Filled, ESP[p].BoxBG.Color, ESP[p].BoxBG.Transparency = 1, true, Color3.fromRGB(0, 210, 255), 0.12
        ESP[p].Tracer.Thickness, ESP[p].TracerShadow.Thickness, ESP[p].TracerShadow.Color = 2, 4.5, Color3.fromRGB(0,0,0)
    elseif not st and ESP[p] then 
        ESP[p].Box:Remove() ESP[p].BoxBG:Remove() ESP[p].Tracer:Remove() ESP[p].TracerShadow:Remove() ESP[p] = nil 
    end
end
P.PlayerAdded:Connect(function(p) setESP(p, true) end) P.PlayerRemoving:Connect(function(p) setESP(p, false) end)
for _, p in ipairs(P:GetPlayers()) do if p ~= LP then setESP(p, true) end end

RS.RenderStepped:Connect(function()
    FOV.Position = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)
    if S.Aim then
        local t = getTarget() local part = t and t.Character and t.Character:FindFirstChild(S.Head and "Head" or "HumanoidRootPart")
        if part then 
            Cam.CFrame = CFrame.new(Cam.CFrame.Position, part.Position)
            FOV.Radius = math.max(S.FOV - 15, FOV.Radius - 1.8) -- เอฟเฟกต์วงกลมหดตัวตอนล็อกเป้าแบบสมูท
        end
    else FOV.Radius = math.min(S.FOV, FOV.Radius + 1.8) end
    
    for p, d in pairs(ESP) do
        if S.ESP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Head") and p.Character.Humanoid.Health > 0 then
            local headPos, on = Cam:WorldToViewportPoint(p.Character.Head.Position + Vector3.new(0, 0.5, 0))
            local legPos = Cam:WorldToViewportPoint(p.Character.HumanoidRootPart.Position - Vector3.new(0, 3, 0))
            if on then
                local h = math.abs(headPos.Y - legPos.Y) local w = h / 1.55
                local size, pos = Vector2.new(w, h), Vector2.new(headPos.X - w/2, headPos.Y)
                
                d.Box.Size, d.Box.Position, d.Box.Visible = size, pos, true
                d.BoxBG.Size, d.BoxBG.Position, d.BoxBG.Visible = size, pos, true
                
                local topCenter = Vector2.new(Cam.ViewportSize.X / 2, 0)
                local targetPos = Vector2.new(headPos.X, headPos.Y)
                
                d.TracerShadow.From, d.TracerShadow.To, d.TracerShadow.Visible = topCenter, targetPos, true
                d.Tracer.From, d.Tracer.To, d.Tracer.Color, d.Tracer.Visible = topCenter, targetPos, Rainbow, true
            else d.Box.Visible, d.BoxBG.Visible, d.Tracer.Visible, d.TracerShadow.Visible = false, false, false, false end
        else d.Box.Visible, d.BoxBG.Visible, d.Tracer.Visible, d.TracerShadow.Visible = false, false, false, false end
    end
end)

-- ===== โคตรพ่อโคตรแม่สวย GOD TIER UI DESIGN =====
local UI = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", UI)
MainFrame.BackgroundColor3, MainFrame.Position, MainFrame.Size, MainFrame.Active, MainFrame.Draggable = Color3.fromRGB(8,9,13), UDim2.new(0.05,0,0.3,0), UDim2.new(0,250,0,210), true, true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)

-- ใส่ภาพพื้นหลังอนิเมะไซเบอร์พังก์พรีเมียมตัวใหม่ลงบนหน้าต่างตามคำขอ! 🌃
local ImgBG = Instance.new("ImageLabel", MainFrame)
ImgBG.Size, ImgBG.BackgroundTransparency, ImgBG.Image, ImgBG.ImageColor3, ImgBG.ImageTransparency = UDim2.new(1,0,1,0), 1, "rbxassetid://12604652285", Color3.fromRGB(150,150,180), 0.5
Instance.new("UICorner", ImgBG).CornerRadius = UDim.new(0, 16)

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Thickness, Stroke.Color = 2.5, Color3.fromRGB(0, 210, 255)

-- บังคับอนิเมชันขอบไฟให้เปลี่ยนสีรุ้งวิ่งวนแบบโคตรล้ำ (Rainbow Frame Edge)
task.spawn(function()
    while task.wait() do Stroke.Color = Rainbow end
end)

-- แถบหัวข้อดีไซน์กระจกแก้วสลัว
local Title = Instance.new("TextLabel", MainFrame)
Title.Size, Title.BackgroundTransparency, Title.Text, Title.TextColor3, Title.Font, Title.TextSize, Title.ZIndex = UDim2.new(1,-40,0,45), 1, "   ⚡ GENESIS GOD v3", Color3.fromRGB(255,255,255), Enum.Font.GothamBold, 14, 2
Title.TextXAlignment = Enum.TextXAlignment.Left
local TitleGrad = Instance.new("UIGradient", Title)
TitleGrad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(0,255,255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))}

-- ปุ่มกดซ่อนหน้าต่างหลัก ดีไซน์ Clean ยุบตัวได้
local HideBtn = Instance.new("TextButton", MainFrame)
HideBtn.Size, HideBtn.Position, HideBtn.BackgroundTransparency, HideBtn.Text, HideBtn.TextColor3, HideBtn.Font, HideBtn.TextSize, HideBtn.ZIndex = UDim2.new(0,30,0,30), UDim2.new(1,-35,0,7), 1, "—", Color3.fromRGB(200,210,230), Enum.Font.GothamBold, 18, 2

-- ปุ่มลอยตอนซ่อน UI (Hologram Cyber-Mask Image Key) ปรับแต่งให้โคตรสวย: เป็นปุ่มกระจกทรงกลมรูปโลโก้ไซเบอร์โฮโลแกรมเรืองแสง
local FloatBtn = Instance.new("ImageButton", UI)
FloatBtn.Size, FloatBtn.Position, FloatBtn.BackgroundColor3, FloatBtn.Visible = UDim2.new(0,52,0,52), UDim2.new(0.05,0,0.25,0), Color3.fromRGB(9,10,15), false
FloatBtn.Image = "rbxassetid://18210344445" -- รูปภาพไอคอนแก้วโฮโลแกรมส่องสว่างสะท้อนไฟ มีมิติและเรียบเนียนไปกับจอเกม
FloatBtn.Active, FloatBtn.Draggable = true, true
Instance.new("UICorner", FloatBtn).CornerRadius = UDim.new(0, 26)
local FloatStroke = Instance.new("UIStroke", FloatBtn) FloatStroke.Thickness, FloatStroke.Color = 2.5, Color3.fromRGB(0,255,255)

task.spawn(function()
    while task.wait() do if FloatBtn.Visible then FloatStroke.Color = Rainbow end end
end)

-- ระบบแอนิเมชันสลับพับซ่อน/แสดงเมนูแบบนุ่มนวลสูงสุด
HideBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    FloatBtn.Position = UDim2.new(0, MainFrame.AbsolutePosition.X, 0, MainFrame.AbsolutePosition.Y)
    FloatBtn.Visible = true
end)

FloatBtn.MouseButton1Click:Connect(function()
    FloatBtn.Visible = false
    MainFrame.Position = UDim2.new(0, FloatBtn.AbsolutePosition.X, 0, FloatBtn.AbsolutePosition.Y)
    MainFrame.Visible = true
end)

local function makeToggle(text, key, y)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size, btn.Position, btn.BackgroundColor3, btn.Text, btn.TextColor3, btn.Font, btn.TextSize, btn.TextXAlignment, btn.ZIndex, btn.BackgroundTransparency = UDim2.new(0.9,0,0,42), UDim2.new(0.05,0,0,y), Color3.fromRGB(15,16,22), "     [ ]  " .. text, Color3.fromRGB(140,150,170), Enum.Font.GothamSemibold, 12, Enum.TextXAlignment.Left, 2, 0.25
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    local bStroke = Instance.new("UIStroke", btn) bStroke.Thickness, bStroke.Color = 1.5, Color3.fromRGB(32,34,44)
    
    btn.MouseButton1Click:Connect(function()
        S[key] = not S[key]
        local active = S[key]
        -- แอนิเมชันเฟดปรับแสงสีปุ่มเปิดปิดไฟนีออนแบบรวดเร็วไหลลื่นทะลุจอ
        TS:Create(btn, TweenInfo.new(0.22, Enum.EasingStyle.Sine), {BackgroundColor3 = active and Color3.fromRGB(15,35,45) or Color3.fromRGB(15,16,22), TextColor3 = active and Color3.fromRGB(0,255,200) or Color3.fromRGB(140,150,170)}):Play()
        TS:Create(bStroke, TweenInfo.new(0.22, Enum.EasingStyle.Sine), {Color = active and Color3.fromRGB(0,255,200) or Color3.fromRGB(32,34,44)}):Play()
        btn.Text = "     " .. (active and "[✓]" or "[ ]") .. "  " .. text
    end)
end

makeToggle("เปิดระบบ ล็อคเป้า (Aimbot)", "Aim", 52)
makeToggle("สลับล็อกหัว (เปิด=หัว / ปิด=ตัว)", "Head", 102)
makeToggle("เปิดระบบ มองทะลุ (ESP)", "ESP", 152)

-- ระบบคีย์บอร์ดลัดสำรองเสริม (กดปุ่ม Insert หรือ RightShift ได้เช่นกัน)
UIS.InputBegan:Connect(function(i, g) 
    if not g and (i.KeyCode == Enum.KeyCode.Insert or i.KeyCode == Enum.KeyCode.RightShift) then 
        if FloatBtn.Visible then FloatBtn.Visible = false MainFrame.Visible = true else MainFrame.Visible = not MainFrame.Visible end
    end 
end)
