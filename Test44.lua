-- // KECUYA HUB (FIXED FLY, ROCKS, KARMA & NO HITBOX LAG)
-- // Author: @kecuya | Key: Guest666

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

local CorrectKey = "Guest666"

-- Рабочие ID Аниме-тянок (Decals / Textures)
local ANIME_GIRL_BG = "rbxassetid://6071575925"   -- Красивый аниме фон
local ANIME_GIRL_ICON = "rbxassetid://7260058863" -- Иконка аниме тянки

local playerGui = LocalPlayer:WaitForChild("PlayerGui")
if playerGui:FindFirstChild("KecuyaSmoothHub") then
    playerGui.KecuyaSmoothHub:Destroy()
end

local Flags = {
    AirRock = false,
    AutoDumbbell = false,
    AutoPushups = false,
    AutoSitups = false,
    AutoPunch = false,
    FastPunch = false,
    InfiniteRebirth = false,
    TargetRebirth = false,
    AutoKillAir = false,
    FarmGoodKarma = false,
    FarmEvilKarma = false,
    TargetKill = false,
    FlingPunch = false,
    AntiKnockback = false,
    Fly = false,
    AutoPosition = false,
    IgnoreFriends = true,
    AntiAFK = false,
    HitboxSize = 35
}

local SelectedRock = "Medium Rock"
local TargetRebirthValue = 100
local FlySpeed = 60
local SelectedTargetPlayer = nil
local MobileUp, MobileDown = false, false
local StartTime = tick()
local SavedPosition = nil
local LastAttackTick = 0
local TargetRockInstance = nil

local RockList = {
    "Tiny Rock",
    "Medium Rock",
    "Large Rock", 
    "Huge Rock", 
    "Legends Rock", 
    "Jungle Rock", 
    "Muscle King Rock"
}

-- UI Root
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KecuyaSmoothHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

-- ==========================================
-- 1. ANTI-AFK ТАЙМЕР И ВИДЖЕТ
-- ==========================================
local AntiAfkFrame = Instance.new("Frame")
AntiAfkFrame.Size = UDim2.new(0, 130, 0, 26)
AntiAfkFrame.Position = UDim2.new(0.5, -65, 0.02, 0)
AntiAfkFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
AntiAfkFrame.BackgroundTransparency = 0.2
AntiAfkFrame.Active = true
AntiAfkFrame.Draggable = true
AntiAfkFrame.Visible = false
AntiAfkFrame.Parent = ScreenGui
Instance.new("UICorner", AntiAfkFrame).CornerRadius = UDim.new(0, 8)
local AfkStroke = Instance.new("UIStroke", AntiAfkFrame)
AfkStroke.Color = Color3.fromRGB(236, 72, 153)
AfkStroke.Thickness = 1.5

local AntiAfkLabel = Instance.new("TextLabel")
AntiAfkLabel.Size = UDim2.new(1, 0, 1, 0)
AntiAfkLabel.Text = "Anti-AFK (0s)"
AntiAfkLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiAfkLabel.Font = Enum.Font.GothamBold
AntiAfkLabel.TextSize = 10
AntiAfkLabel.BackgroundTransparency = 1
AntiAfkLabel.Parent = AntiAfkFrame

local afkSeconds = 0
LocalPlayer.Idled:Connect(function()
    if Flags.AntiAFK then
        VirtualUser:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if Flags.AntiAFK then
            afkSeconds = afkSeconds + 1
            AntiAfkLabel.Text = "Anti-AFK (" .. tostring(afkSeconds) .. "s)"
        end
    end
end)

-- Кнопки полета для мобилок
local MobileFlyFrame = Instance.new("Frame")
MobileFlyFrame.Size = UDim2.new(0, 50, 0, 95)
MobileFlyFrame.Position = UDim2.new(0.88, 0, 0.4, 0)
MobileFlyFrame.BackgroundTransparency = 1
MobileFlyFrame.Visible = false
MobileFlyFrame.Parent = ScreenGui

local FlyUpBtn = Instance.new("TextButton")
FlyUpBtn.Size = UDim2.new(1, 0, 0, 42)
FlyUpBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 38)
FlyUpBtn.Text = "▲\nUp"
FlyUpBtn.TextColor3 = Color3.fromRGB(236, 72, 153)
FlyUpBtn.Font = Enum.Font.GothamMedium
FlyUpBtn.TextSize = 10
FlyUpBtn.Parent = MobileFlyFrame
Instance.new("UICorner", FlyUpBtn).CornerRadius = UDim.new(0, 8)

local FlyDownBtn = Instance.new("TextButton")
FlyDownBtn.Size = UDim2.new(1, 0, 0, 42)
FlyDownBtn.Position = UDim2.new(0, 0, 0, 48)
FlyDownBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 38)
FlyDownBtn.Text = "▼\nDown"
FlyDownBtn.TextColor3 = Color3.fromRGB(236, 72, 153)
FlyDownBtn.Font = Enum.Font.GothamMedium
FlyDownBtn.TextSize = 10
FlyDownBtn.Parent = MobileFlyFrame
Instance.new("UICorner", FlyDownBtn).CornerRadius = UDim.new(0, 8)

FlyUpBtn.MouseButton1Down:Connect(function() MobileUp = true end)
FlyUpBtn.MouseButton1Up:Connect(function() MobileUp = false end)
FlyDownBtn.MouseButton1Down:Connect(function() MobileDown = true end)
FlyDownBtn.MouseButton1Up:Connect(function() MobileDown = false end)

-- ==========================================
-- 2. УДАРА, FLING И КАРМА ЛОГИКА
-- ==========================================
local function GetPunchTool()
    local char = LocalPlayer.Character
    if not char then return nil end
    local punch = char:FindFirstChild("Punch") or LocalPlayer.Backpack:FindFirstChild("Punch")
    if punch then
        if punch.Parent == LocalPlayer.Backpack then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum:EquipTool(punch) end
        end
        return punch
    end
    return nil
end

local function GetKarmaValue(p)
    if not p then return 0 end
    local lStats = p:FindFirstChild("leaderstats")
    if lStats then
        local k = lStats:FindFirstChild("Karma") or lStats:FindFirstChild("karma")
        if k then return k.Value end
        
        local g = lStats:FindFirstChild("Good Karma") or lStats:FindFirstChild("goodKarma")
        local e = lStats:FindFirstChild("Evil Karma") or lStats:FindFirstChild("evilKarma")
        if g and e then return g.Value - e.Value end
        if g then return g.Value end
        if e then return -e.Value end
    end
    return 0
end

local function ApplyFlingForce()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local bV = Instance.new("BodyAngularVelocity")
    bV.Name = "FlingForce"
    bV.AngularVelocity = Vector3.new(0, 99999, 0)
    bV.MaxTorque = Vector3.new(0, math.huge, 0)
    bV.P = math.huge
    bV.Parent = hrp

    task.delay(0.1, function()
        if bV and bV.Parent then bV:Destroy() end
    end)
end

local function ExecuteAttack(targetPart)
    local cd = Flags.FastPunch and 0.01 or 0.08
    if tick() - LastAttackTick < cd then return end
    LastAttackTick = tick()

    local punch = GetPunchTool()
    if punch then punch:Activate() end

    if Flags.FlingPunch and targetPart then ApplyFlingForce() end

    local muscleEvent = LocalPlayer:FindFirstChild("muscleEvent") or ReplicatedStorage:FindFirstChild("muscleEvent")
    if muscleEvent then
        muscleEvent:FireServer("punch", "RightHand")
        muscleEvent:FireServer("punch", "LeftHand")
    end

    local rEvents = ReplicatedStorage:FindFirstChild("rEvents")
    if rEvents then
        local pEvent = rEvents:FindFirstChild("punchEvent")
        if pEvent then pEvent:FireServer("punchAttack") end
        if targetPart and targetPart:IsA("BasePart") then
            local damageEv = rEvents:FindFirstChild("damageEvent")
            if damageEv then damageEv:FireServer(targetPart) end
        end
    end
end

-- ==========================================
-- 3. ПОИСК И ФАРМ КАМНЕЙ
-- ==========================================
local function FindRock()
    TargetRockInstance = nil
    local targetName = SelectedRock:lower():gsub("%s+", "")

    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("BasePart") then
            local oName = obj.Name:lower():gsub("%s+", "")
            
            if not obj:FindFirstChildOfClass("Humanoid") and not (obj.Parent and obj.Parent:FindFirstChildOfClass("Humanoid")) then
                if oName:find(targetName) or targetName:find(oName) then
                    if obj:IsA("BasePart") then
                        TargetRockInstance = obj
                        break
                    elseif obj:IsA("Model") then
                        local p = obj.PrimaryPart or obj:FindFirstChild("Rock") or obj:FindFirstChildWhichIsA("BasePart")
                        if p then
                            TargetRockInstance = p
                            break
                        end
                    end
                end
            end
        end
    end
end

task.spawn(function()
    while true do
        if Flags.AirRock then
            if not TargetRockInstance or not TargetRockInstance.Parent then
                FindRock()
            end

            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp and TargetRockInstance then
                hrp.CFrame = TargetRockInstance.CFrame * CFrame.new(0, TargetRockInstance.Size.Y / 2 + 2, 0)
                hrp.AssemblyLinearVelocity = Vector3.zero
                ExecuteAttack(TargetRockInstance)
            end
            task.wait(0.04)
        else
            task.wait(0.3)
        end
    end
end)

-- ==========================================
-- 4. ПОЛНОСТЬЮ ИСПРАВЛЕННЫЙ ПОЛЕТ (FLY)
-- ==========================================
local bodyVel, bodyGyro

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")

    if Flags.Fly and hrp and hum then
        hum.PlatformStand = true

        if not bodyVel or bodyVel.Parent ~= hrp then
            bodyVel = Instance.new("BodyVelocity")
            bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodyVel.Velocity = Vector3.zero
            bodyVel.Parent = hrp
        end

        if not bodyGyro or bodyGyro.Parent ~= hrp then
            bodyGyro = Instance.new("BodyGyro")
            bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bodyGyro.P = 10000
            bodyGyro.CFrame = hrp.CFrame
            bodyGyro.Parent = hrp
        end

        local cam = Workspace.CurrentCamera
        local moveVector = Vector3.zero

        -- ПК Управление
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveVector = moveVector + cam.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveVector = moveVector - cam.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveVector = moveVector - cam.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveVector = moveVector + cam.CFrame.RightVector
        end

        -- Управление с джойстика телефона
        if hum.MoveVector.Magnitude > 0 and moveVector == Vector3.zero then
            moveVector = (cam.CFrame.RightVector * hum.MoveVector.X) + (cam.CFrame.LookVector * -hum.MoveVector.Z)
        end

        -- Подъем и Спуск
        local vertical = 0
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) or MobileUp then
            vertical = vertical + 1
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or MobileDown then
            vertical = vertical - 1
        end

        local finalVelocity = Vector3.zero
        if moveVector.Magnitude > 0 then
            finalVelocity = moveVector.Unit * FlySpeed
        end
        finalVelocity = finalVelocity + Vector3.new(0, vertical * FlySpeed, 0)

        bodyVel.Velocity = finalVelocity
        bodyGyro.CFrame = cam.CFrame
    else
        if bodyVel then bodyVel:Destroy() bodyVel = nil end
        if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
        if hum and hum.PlatformStand and not Flags.AirRock then
            hum.PlatformStand = false
        end
    end
end)

-- ==========================================
-- 5. АВТО-УБИЙСТВО (БЕЗ ХИТБОКСОВ И ЛАГОВ)
-- ==========================================
task.spawn(function()
    while true do
        local myChar = LocalPlayer.Character
        local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")

        if myHrp then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    if Flags.IgnoreFriends and LocalPlayer:IsFriendsWith(p.UserId) then continue end

                    local tChar = p.Character
                    local tHrp = tChar:FindFirstChild("HumanoidRootPart")
                    local tHum = tChar:FindFirstChildOfClass("Humanoid")

                    if tHrp and tHum and tHum.Health > 0 and not tChar:FindFirstChildOfClass("ForceField") then
                        local tKarma = GetKarmaValue(p)
                        local isTarget = false

                        if Flags.AutoKillAir then 
                            isTarget = true
                        elseif Flags.FarmGoodKarma and tKarma < 0 then 
                            isTarget = true
                        elseif Flags.FarmEvilKarma and tKarma >= 0 then 
                            isTarget = true
                        elseif Flags.TargetKill and SelectedTargetPlayer == p then 
                            isTarget = true
                        end

                        if isTarget then
                            tHrp.CFrame = myHrp.CFrame * CFrame.new(0, 0, -2)
                            ExecuteAttack(tHrp)
                        end
                    end
                end
            end
        end
        task.wait(0.04)
    end
end)

-- ==========================================
-- 6. АНТИ-КНОКБЕК И АВТО-ПОЗИЦИЯ
-- ==========================================
task.spawn(function()
    while true do
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart

            if Flags.AntiKnockback and not Flags.Fly then
                for _, obj in pairs(hrp:GetChildren()) do
                    if (obj:IsA("BodyVelocity") or obj:IsA("BodyForce") or obj:IsA("VectorForce")) then
                        obj:Destroy()
                    end
                end
            end

            if Flags.AutoPosition and SavedPosition then
                if (hrp.Position - SavedPosition.Position).Magnitude > 5 then
                    hrp.CFrame = SavedPosition
                end
            end
        end
        task.wait(0.1)
    end
end)

-- ==========================================
-- 7. GUI СТРУКТУРА HUB
-- ==========================================
local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
ToggleBtn.Image = ANIME_GIRL_ICON
ToggleBtn.Visible = false
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Color = Color3.fromRGB(236, 72, 153)
ToggleStroke.Thickness = 2.5

-- ОКНО КЛЮЧА
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 300, 0, 200)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
KeyFrame.ClipsDescendants = true
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = ScreenGui
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 14)

local KeyBg = Instance.new("ImageLabel")
KeyBg.Size = UDim2.new(1, 0, 1, 0)
KeyBg.Image = ANIME_GIRL_BG
KeyBg.ImageTransparency = 0.45
KeyBg.ScaleType = Enum.ScaleType.Crop
KeyBg.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke", KeyFrame)
KeyStroke.Color = Color3.fromRGB(236, 72, 153)
KeyStroke.Thickness = 2

local KeyAvatar = Instance.new("ImageLabel")
KeyAvatar.Size = UDim2.new(0, 48, 0, 48)
KeyAvatar.Position = UDim2.new(0.5, -24, 0, 12)
KeyAvatar.Image = ANIME_GIRL_ICON
KeyAvatar.BackgroundTransparency = 1
KeyAvatar.Parent = KeyFrame
Instance.new("UICorner", KeyAvatar).CornerRadius = UDim.new(1, 0)

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 20)
KeyTitle.Position = UDim2.new(0, 0, 0, 64)
KeyTitle.Text = "🌸 KECUYA HUB  •  AUTHORIZATION 🌸"
KeyTitle.TextColor3 = Color3.fromRGB(255, 235, 245)
KeyTitle.TextSize = 10
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.BackgroundTransparency = 1
KeyTitle.Parent = KeyFrame

local KeyInputBox = Instance.new("Frame")
KeyInputBox.Size = UDim2.new(0.85, 0, 0, 34)
KeyInputBox.Position = UDim2.new(0.075, 0, 0.48, 0)
KeyInputBox.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
KeyInputBox.BackgroundTransparency = 0.2
KeyInputBox.Parent = KeyFrame
Instance.new("UICorner", KeyInputBox).CornerRadius = UDim.new(0, 8)
local KeyInputStroke = Instance.new("UIStroke", KeyInputBox)
KeyInputStroke.Color = Color3.fromRGB(147, 51, 234)

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -16, 1, 0)
KeyInput.Position = UDim2.new(0, 8, 0, 0)
KeyInput.PlaceholderText = "🔑 Введите ключ доступа..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.BackgroundTransparency = 1
KeyInput.Font = Enum.Font.GothamMedium
KeyInput.TextSize = 10
KeyInput.Parent = KeyInputBox

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.85, 0, 0, 32)
SubmitBtn.Position = UDim2.new(0.075, 0, 0.74, 0)
SubmitBtn.Text = "АВТОРИЗОВАТЬСЯ ✨"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(236, 72, 153)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 10
SubmitBtn.Parent = KeyFrame
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 8)

-- ГЛАВНОЕ ОКНО
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 390, 0, 250)
MainFrame.Position = UDim2.new(0.5, -195, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local MainBg = Instance.new("ImageLabel")
MainBg.Size = UDim2.new(1, 0, 1, 0)
MainBg.Image = ANIME_GIRL_BG
MainBg.ImageTransparency = 0.35
MainBg.ScaleType = Enum.ScaleType.Crop
MainBg.Parent = MainFrame

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(236, 72, 153)
MainStroke.Thickness = 2

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 34)
TopBar.BackgroundColor3 = Color3.fromRGB(16, 16, 26)
TopBar.BackgroundTransparency = 0.2
TopBar.Parent = MainFrame

local AnimeIcon = Instance.new("ImageLabel")
AnimeIcon.Size = UDim2.new(0, 24, 0, 24)
AnimeIcon.Position = UDim2.new(0, 8, 0, 5)
AnimeIcon.Image = ANIME_GIRL_ICON
AnimeIcon.BackgroundTransparency = 1
AnimeIcon.Parent = TopBar
Instance.new("UICorner", AnimeIcon).CornerRadius = UDim.new(1, 0)

-- РАДУЖНЫЙ ДИНАМИЧЕСКИЙ ЗАГОЛОВОК
local MainTitle = Instance.new("TextLabel")
MainTitle.Size = UDim2.new(0, 130, 1, 0)
MainTitle.Position = UDim2.new(0, 38, 0, 0)
MainTitle.Text = "Kecuya Hub 🌸"
MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTitle.TextSize = 12
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextXAlignment = Enum.TextXAlignment.Left
MainTitle.BackgroundTransparency = 1
MainTitle.Parent = TopBar

local RainbowGradient = Instance.new("UIGradient")
RainbowGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 128)),
    ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 100, 0)),
    ColorSequenceKeypoint.new(0.40, Color3.fromRGB(255, 230, 0)),
    ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 150)),
    ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 180, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(200, 0, 255))
})
RainbowGradient.Parent = MainTitle

task.spawn(function()
    while true do
        RainbowGradient.Rotation = (RainbowGradient.Rotation + 2) % 360
        task.wait(0.03)
    end
end)

local AuthorTag = Instance.new("TextLabel")
AuthorTag.Size = UDim2.new(0, 100, 1, 0)
AuthorTag.Position = UDim2.new(0, 150, 0, 0)
AuthorTag.Text = "@kecuya"
AuthorTag.TextColor3 = Color3.fromRGB(236, 72, 153)
AuthorTag.TextSize = 9
AuthorTag.Font = Enum.Font.GothamBold
AuthorTag.TextXAlignment = Enum.TextXAlignment.Left
AuthorTag.BackgroundTransparency = 1
AuthorTag.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -28, 0, 5)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(239, 68, 68)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
CloseBtn.Parent = TopBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
MinimizeBtn.Position = UDim2.new(1, -52, 0, 5)
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 230)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 12
MinimizeBtn.Parent = TopBar

local TabBar = Instance.new("ScrollingFrame")
TabBar.Size = UDim2.new(1, -16, 0, 28)
TabBar.Position = UDim2.new(0, 8, 0, 40)
TabBar.BackgroundTransparency = 1
TabBar.ScrollBarThickness = 0
TabBar.CanvasSize = UDim2.new(0, 0, 0, 0)
TabBar.AutomaticCanvasSize = Enum.AutomaticSize.X
TabBar.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout", TabBar)
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 6)

local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -16, 1, -78)
ContentContainer.Position = UDim2.new(0, 8, 0, 72)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

local function AnimateFrame(show)
    if show then
        MainFrame.Size = UDim2.new(0, 200, 0, 100)
        MainFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
        MainFrame.BackgroundTransparency = 1
        MainFrame.Visible = true

        TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 390, 0, 250),
            Position = UDim2.new(0.5, -195, 0.5, -125),
            BackgroundTransparency = 0
        }):Play()
    else
        local tw = TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 150, 0, 60),
            Position = UDim2.new(0.5, -75, 0.5, -30),
            BackgroundTransparency = 1
        })
        tw:Play()
        tw.Completed:Connect(function()
            if MainFrame.Size.X.Offset < 200 then MainFrame.Visible = false end
        end)
    end
end

-- Вкладки
local Pages, TabButtons = {}, {}
local function CreateTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 64, 1, 0)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(160, 160, 185)
    btn.BackgroundColor3 = Color3.fromRGB(22, 22, 34)
    btn.BackgroundTransparency = 0.2
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 9
    btn.Parent = TabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.Visible = false
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    scroll.ScrollBarThickness = 2
    scroll.ScrollBarImageColor3 = Color3.fromRGB(236, 72, 153)
    scroll.Parent = ContentContainer

    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0, 5)

    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, b in pairs(TabButtons) do 
            TweenService:Create(b, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(160, 160, 185), BackgroundColor3 = Color3.fromRGB(22, 22, 34)}):Play()
        end
        scroll.Visible = true
        TweenService:Create(btn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255), BackgroundColor3 = Color3.fromRGB(236, 72, 153)}):Play()
    end)

    table.insert(Pages, scroll)
    table.insert(TabButtons, btn)
    return scroll
end

local StatusPg = CreateTab("Статус")
local RockPg = CreateTab("Камни")
local BenchPg = CreateTab("Качалка")
local KillPg = CreateTab("Атака")
local RebirthPg = CreateTab("Ребирт")
local UtilityPg = CreateTab("Защита")

Pages[1].Visible = true
TabButtons[1].TextColor3 = Color3.fromRGB(255, 255, 255)
TabButtons[1].BackgroundColor3 = Color3.fromRGB(236, 72, 153)

local function CreateToggle(parent, name, defaultState, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -4, 0, 26)
    frame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
    frame.BackgroundTransparency = 0.3
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(0, 230, 1, 0)
    txt.Position = UDim2.new(0, 10, 0, 0)
    txt.Text = name
    txt.TextColor3 = defaultState and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 175)
    txt.Font = Enum.Font.Gotham
    txt.TextSize = 9
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.BackgroundTransparency = 1
    txt.Parent = frame

    local track = Instance.new("Frame")
    track.Size = UDim2.new(0, 32, 0, 16)
    track.Position = UDim2.new(1, -38, 0.5, -8)
    track.BackgroundColor3 = defaultState and Color3.fromRGB(236, 72, 153) or Color3.fromRGB(32, 32, 48)
    track.Parent = frame
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 12, 0, 12)
    knob.Position = defaultState and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.Parent = track
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local clickBtn = Instance.new("TextButton")
    clickBtn.Size = UDim2.new(1, 0, 1, 0)
    clickBtn.BackgroundTransparency = 1
    clickBtn.Text = ""
    clickBtn.Parent = frame

    local state = defaultState
    clickBtn.MouseButton1Click:Connect(function()
        state = not state
        local targetKnobPos = state and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
        local targetTrackColor = state and Color3.fromRGB(236, 72, 153) or Color3.fromRGB(32, 32, 48)
        local targetTextColor = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 175)

        TweenService:Create(knob, TweenInfo.new(0.2), {Position = targetKnobPos}):Play()
        TweenService:Create(track, TweenInfo.new(0.2), {BackgroundColor3 = targetTrackColor}):Play()
        TweenService:Create(txt, TweenInfo.new(0.2), {TextColor3 = targetTextColor}):Play()

        callback(state)
    end)
end

-- ==========================================
-- СТАТИСТИКА
-- ==========================================
local function CreateStatusCard(titleText, accentColor)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -4, 0, 32)
    card.BackgroundColor3 = Color3.fromRGB(16, 16, 26)
    card.BackgroundTransparency = 0.25
    card.Parent = StatusPg
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)

    local stroke = Instance.new("UIStroke", card)
    stroke.Color = accentColor
    stroke.Thickness = 1
    stroke.Transparency = 0.6

    local leftBar = Instance.new("Frame")
    leftBar.Size = UDim2.new(0, 4, 0, 18)
    leftBar.Position = UDim2.new(0, 6, 0.5, -9)
    leftBar.BackgroundColor3 = accentColor
    leftBar.Parent = card
    Instance.new("UICorner", leftBar).CornerRadius = UDim.new(1, 0)

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(0, 90, 1, 0)
    titleLbl.Position = UDim2.new(0, 16, 0, 0)
    titleLbl.Text = titleText
    titleLbl.TextColor3 = Color3.fromRGB(180, 180, 210)
    titleLbl.Font = Enum.Font.GothamMedium
    titleLbl.TextSize = 9
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.BackgroundTransparency = 1
    titleLbl.Parent = card

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(1, -116, 1, 0)
    valLbl.Position = UDim2.new(0, 106, 0, 0)
    valLbl.Text = "..."
    valLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextSize = 10
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.BackgroundTransparency = 1
    valLbl.Parent = card

    return valLbl
end

local StrengthValLbl = CreateStatusCard("⚡  Сила:", Color3.fromRGB(245, 158, 11))
local RebirthValLbl  = CreateStatusCard("🔄  Ребирты:", Color3.fromRGB(168, 85, 247))
local KarmaValLbl    = CreateStatusCard("😇  Карма:", Color3.fromRGB(59, 130, 246))
local TimeValLbl     = CreateStatusCard("⏱️  В игре:", Color3.fromRGB(236, 72, 153))

task.spawn(function()
    while task.wait(1) do
        local lStats = LocalPlayer:FindFirstChild("leaderstats")
        local str = lStats and (lStats:FindFirstChild("Strength") or lStats:FindFirstChild("strength"))
        StrengthValLbl.Text = str and tostring(str.Value) or "0"

        local reb = lStats and (lStats:FindFirstChild("Rebirths") or lStats:FindFirstChild("rebirths"))
        RebirthValLbl.Text = reb and tostring(reb.Value) or "0"

        local kv = GetKarmaValue(LocalPlayer)
        KarmaValLbl.Text = tostring(kv)

        local totalSecs = math.floor(tick() - StartTime)
        local hrs = math.floor(totalSecs / 3600)
        local mins = math.floor((totalSecs % 3600) / 60)
        local secs = totalSecs % 60
        TimeValLbl.Text = string.format("%02d:%02d:%02d", hrs, mins, secs)
    end
end)

-- НАСТРОЙКИ КАМНЕЙ
CreateToggle(RockPg, "ТП + Авто-Фарм Камня", Flags.AirRock, function(v) 
    Flags.AirRock = v 
    if v then FindRock() end
end)

local DropdownFrame = Instance.new("Frame")
DropdownFrame.Size = UDim2.new(1, -4, 0, 28)
DropdownFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
DropdownFrame.BackgroundTransparency = 0.3
DropdownFrame.ClipsDescendants = true
DropdownFrame.Parent = RockPg
Instance.new("UICorner", DropdownFrame).CornerRadius = UDim.new(0, 6)

local DropdownBtn = Instance.new("TextButton")
DropdownBtn.Size = UDim2.new(1, 0, 0, 28)
DropdownBtn.Text = "  Выбрать камень: " .. SelectedRock .. "  ▼"
DropdownBtn.TextColor3 = Color3.fromRGB(236, 72, 153)
DropdownBtn.Font = Enum.Font.GothamMedium
DropdownBtn.TextSize = 9
DropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
DropdownBtn.BackgroundTransparency = 1
DropdownBtn.Parent = DropdownFrame

local DropdownList = Instance.new("Frame")
DropdownList.Size = UDim2.new(1, 0, 0, #RockList * 22)
DropdownList.Position = UDim2.new(0, 0, 0, 28)
DropdownList.BackgroundTransparency = 1
DropdownList.Parent = DropdownFrame

Instance.new("UIListLayout", DropdownList).Padding = UDim.new(0, 2)

local isExpanded = false
DropdownBtn.MouseButton1Click:Connect(function()
    isExpanded = not isExpanded
    local targetSize = isExpanded and UDim2.new(1, -4, 0, 28 + (#RockList * 24)) or UDim2.new(1, -4, 0, 28)
    TweenService:Create(DropdownFrame, TweenInfo.new(0.25), {Size = targetSize}):Play()
end)

for _, rName in pairs(RockList) do
    local itemBtn = Instance.new("TextButton")
    itemBtn.Size = UDim2.new(1, -8, 0, 22)
    itemBtn.Position = UDim2.new(0, 4, 0, 0)
    itemBtn.Text = "   " .. rName
    itemBtn.TextColor3 = Color3.fromRGB(170, 170, 195)
    itemBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 36)
    itemBtn.Font = Enum.Font.Gotham
    itemBtn.TextSize = 8
    itemBtn.TextXAlignment = Enum.TextXAlignment.Left
    itemBtn.Parent = DropdownList
    Instance.new("UICorner", itemBtn).CornerRadius = UDim.new(0, 4)

    itemBtn.MouseButton1Click:Connect(function()
        SelectedRock = rName
        DropdownBtn.Text = "  Выбрать камень: " .. SelectedRock .. "  ▼"
        isExpanded = false
        TweenService:Create(DropdownFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, -4, 0, 28)}):Play()
        FindRock()
    end)
end

-- КАЧАЛКА
local function SafeTrain(toolPartialName)
    local char = LocalPlayer.Character
    if not char then return end
    
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool or not tool.Name:find(toolPartialName) then
        for _, t in pairs(LocalPlayer.Backpack:GetChildren()) do
            if t:IsA("Tool") and t.Name:find(toolPartialName) then 
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum:EquipTool(t) end
                tool = t
                break 
            end
        end
    end
    if tool then tool:Activate() end
end

task.spawn(function()
    while true do
        if Flags.AutoDumbbell then SafeTrain("Dumbbell") end
        if Flags.AutoPushups then SafeTrain("Pushups") end
        if Flags.AutoSitups then SafeTrain("Situps") end
        if Flags.AutoPunch then ExecuteAttack(nil) end
        task.wait(Flags.FastPunch and 0.02 or 0.1)
    end
end)

CreateToggle(BenchPg, "Гантели (Dumbbell)", Flags.AutoDumbbell, function(v) Flags.AutoDumbbell = v end)
CreateToggle(BenchPg, "Отжимания (Pushups)", Flags.AutoPushups, function(v) Flags.AutoPushups = v end)
CreateToggle(BenchPg, "Пресс (Situps)", Flags.AutoSitups, function(v) Flags.AutoSitups = v end)
CreateToggle(BenchPg, "Удары (Punch)", Flags.AutoPunch, function(v) Flags.AutoPunch = v end)
CreateToggle(BenchPg, "Быстрый клик", Flags.FastPunch, function(v) Flags.FastPunch = v end)

-- АТАКА & ТАРГЕТ СИСТЕМА
CreateToggle(KillPg, "Игнорировать друзей", Flags.IgnoreFriends, function(v) Flags.IgnoreFriends = v end)
CreateToggle(KillPg, "Флинг Удар (Fling Punch)", Flags.FlingPunch, function(v) Flags.FlingPunch = v end)
CreateToggle(KillPg, "Убивать всех (Авто-Атака)", Flags.AutoKillAir, function(v) Flags.AutoKillAir = v end)
CreateToggle(KillPg, "Фарм Good Karma (Убивать Evil)", Flags.FarmGoodKarma, function(v) Flags.FarmGoodKarma = v end)
CreateToggle(KillPg, "Фарм Evil Karma (Убивать Good)", Flags.FarmEvilKarma, function(v) Flags.FarmEvilKarma = v end)

local PlayerDropdownFrame = Instance.new("Frame")
PlayerDropdownFrame.Size = UDim2.new(1, -4, 0, 28)
PlayerDropdownFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
PlayerDropdownFrame.BackgroundTransparency = 0.3
PlayerDropdownFrame.ClipsDescendants = true
PlayerDropdownFrame.Parent = KillPg
Instance.new("UICorner", PlayerDropdownFrame).CornerRadius = UDim.new(0, 6)

local PlayerDropdownBtn = Instance.new("TextButton")
PlayerDropdownBtn.Size = UDim2.new(1, 0, 0, 28)
PlayerDropdownBtn.Text = "  🎯 Выберите цель: Не выбран  ▼"
PlayerDropdownBtn.TextColor3 = Color3.fromRGB(236, 72, 153)
PlayerDropdownBtn.Font = Enum.Font.GothamMedium
PlayerDropdownBtn.TextSize = 9
PlayerDropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
PlayerDropdownBtn.BackgroundTransparency = 1
PlayerDropdownBtn.Parent = PlayerDropdownFrame

local PlayerListContainer = Instance.new("ScrollingFrame")
PlayerListContainer.Size = UDim2.new(1, -8, 0, 100)
PlayerListContainer.Position = UDim2.new(0, 4, 0, 30)
PlayerListContainer.BackgroundTransparency = 1
PlayerListContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerListContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
PlayerListContainer.ScrollBarThickness = 2
PlayerListContainer.ScrollBarImageColor3 = Color3.fromRGB(236, 72, 153)
PlayerListContainer.Parent = PlayerDropdownFrame

local PlayerListLayout = Instance.new("UIListLayout", PlayerListContainer)
PlayerListLayout.Padding = UDim.new(0, 3)

local RefreshPlayersBtn = Instance.new("TextButton")
RefreshPlayersBtn.Size = UDim2.new(1, -8, 0, 22)
RefreshPlayersBtn.Text = "🔄 Обновить список игроков"
RefreshPlayersBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
RefreshPlayersBtn.TextColor3 = Color3.fromRGB(240, 240, 255)
RefreshPlayersBtn.Font = Enum.Font.GothamMedium
RefreshPlayersBtn.TextSize = 8
RefreshPlayersBtn.Parent = PlayerListContainer
Instance.new("UICorner", RefreshPlayersBtn).CornerRadius = UDim.new(0, 4)

local isPlayerExpanded = false
local function UpdatePlayerList()
    for _, child in pairs(PlayerListContainer:GetChildren()) do
        if child:IsA("TextButton") and child ~= RefreshPlayersBtn then child:Destroy() end
    end

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and not LocalPlayer:IsFriendsWith(p.UserId) then
            local pBtn = Instance.new("TextButton")
            pBtn.Size = UDim2.new(1, 0, 0, 22)
            pBtn.Text = "   " .. p.DisplayName .. " (@" .. p.Name .. ")"
            pBtn.TextColor3 = Color3.fromRGB(180, 180, 205)
            pBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 36)
            pBtn.Font = Enum.Font.Gotham
            pBtn.TextSize = 8
            pBtn.TextXAlignment = Enum.TextXAlignment.Left
            pBtn.Parent = PlayerListContainer
            Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 4)

            pBtn.MouseButton1Click:Connect(function()
                SelectedTargetPlayer = p
                PlayerDropdownBtn.Text = "  🎯 Цель: " .. p.DisplayName .. "  ▼"
                isPlayerExpanded = false
                TweenService:Create(PlayerDropdownFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, -4, 0, 28)}):Play()
            end)
        end
    end
end

RefreshPlayersBtn.MouseButton1Click:Connect(UpdatePlayerList)

PlayerDropdownBtn.MouseButton1Click:Connect(function()
    isPlayerExpanded = not isPlayerExpanded
    if isPlayerExpanded then UpdatePlayerList() end
    local targetSize = isPlayerExpanded and UDim2.new(1, -4, 0, 138) or UDim2.new(1, -4, 0, 28)
    TweenService:Create(PlayerDropdownFrame, TweenInfo.new(0.25), {Size = targetSize}):Play()
end)

CreateToggle(KillPg, "Убивать выбр. цель", Flags.TargetKill, function(v) Flags.TargetKill = v end)

-- РЕБИРТ
RebirthPg.AutomaticCanvasSize = Enum.AutomaticSize.Y

CreateToggle(RebirthPg, "Бесконечный Авто-Ребирт", Flags.InfiniteRebirth, function(v)
    Flags.InfiniteRebirth = v
    if v then
        task.spawn(function()
            while Flags.InfiniteRebirth do
                local rRemote = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("rebirthRemote")
                if rRemote then 
                    rRemote:InvokeServer("rebirthRequest") 
                end
                task.wait(0.3)
            end
        end)
    end
end)

local RebInput = Instance.new("TextBox")
RebInput.Size = UDim2.new(1, -4, 0, 24)
RebInput.PlaceholderText = "Лимит ребиртов (100)"
RebInput.Text = "100"
RebInput.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
RebInput.BackgroundTransparency = 0.3
RebInput.TextColor3 = Color3.fromRGB(240, 240, 255)
RebInput.Font = Enum.Font.Gotham
RebInput.TextSize = 9
RebInput.Parent = RebirthPg
Instance.new("UICorner", RebInput).CornerRadius = UDim.new(0, 6)

CreateToggle(RebirthPg, "Ребирт с лимитом", Flags.TargetRebirth, function(v)
    Flags.TargetRebirth = v
    TargetRebirthValue = tonumber(RebInput.Text) or 100
    if v then
        task.spawn(function()
            while Flags.TargetRebirth do
                local stats = LocalPlayer:FindFirstChild("leaderstats")
                local rebirths = stats and stats:FindFirstChild("Rebirths")
                if rebirths and rebirths.Value >= TargetRebirthValue then
                    Flags.TargetRebirth = false
                else
                    local rRemote = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("rebirthRemote")
                    if rRemote then rRemote:InvokeServer("rebirthRequest") end
                end
                task.wait(0.5)
            end
        end)
    end
end)

-- ЗАЩИТА И УТИЛИТЫ
CreateToggle(UtilityPg, "Anti-AFK (+Таймер)", Flags.AntiAFK, function(v) 
    Flags.AntiAFK = v 
    AntiAfkFrame.Visible = v
end)
CreateToggle(UtilityPg, "Anti-Knockback", Flags.AntiKnockback, function(v) Flags.AntiKnockback = v end)

local SavePosBtn = Instance.new("TextButton")
SavePosBtn.Size = UDim2.new(1, -4, 0, 24)
SavePosBtn.Text = "Сохранить позицию"
SavePosBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 36)
SavePosBtn.TextColor3 = Color3.fromRGB(236, 72, 153)
SavePosBtn.Font = Enum.Font.GothamMedium
SavePosBtn.TextSize = 9
SavePosBtn.Parent = UtilityPg
Instance.new("UICorner", SavePosBtn).CornerRadius = UDim.new(0, 6)

SavePosBtn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        SavedPosition = LocalPlayer.Character.HumanoidRootPart.CFrame
        SavePosBtn.Text = "✓ Точка сохранена!"
        task.wait(1)
        SavePosBtn.Text = "Сохранить позицию"
    end
end)

CreateToggle(UtilityPg, "Авто Позиция", Flags.AutoPosition, function(v) Flags.AutoPosition = v end)

local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(1, -4, 0, 24)
SpeedInput.PlaceholderText = "Скорость полета (60)"
SpeedInput.Text = "60"
SpeedInput.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
SpeedInput.BackgroundTransparency = 0.3
SpeedInput.TextColor3 = Color3.fromRGB(240, 240, 255)
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.TextSize = 9
SpeedInput.Parent = UtilityPg
Instance.new("UICorner", SpeedInput).CornerRadius = UDim.new(0, 6)
SpeedInput.FocusLost:Connect(function() FlySpeed = tonumber(SpeedInput.Text) or 60 end)

CreateToggle(UtilityPg, "Полет (Fly)", Flags.Fly, function(v) 
    Flags.Fly = v 
    MobileFlyFrame.Visible = v 
end)

-- АВТОРИЗАЦИЯ
local function AttemptLogin()
    local enteredKey = string.match(KeyInput.Text, "^%s*(.-)%s*$") or ""
    if enteredKey == CorrectKey then
        KeyFrame.Visible = false
        ToggleBtn.Visible = true
        AnimateFrame(true)
    else
        KeyInputStroke.Color = Color3.fromRGB(239, 68, 68)
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "❌ Неверный ключ!"
        task.wait(1)
        KeyInputStroke.Color = Color3.fromRGB(147, 51, 234)
        KeyInput.PlaceholderText = "🔑 Введите ключ доступа..."
    end
end

SubmitBtn.MouseButton1Click:Connect(AttemptLogin)
KeyInput.FocusLost:Connect(function(enterPressed) if enterPressed then AttemptLogin() end end)

CloseBtn.MouseButton1Click:Connect(function()
    AnimateFrame(false)
    task.wait(0.3)
    ScreenGui:Destroy()
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    AnimateFrame(false)
    ToggleBtn.Visible = true
end)

ToggleBtn.MouseButton1Click:Connect(function()
    if MainFrame.Visible then AnimateFrame(false) else AnimateFrame(true) end
end)
