-- // MUSCLE LEGENDS ULTIMATE HUB (MOBILE FLY & KARMA EDITION)
-- // Key: Guest666

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local CorrectKey = "Guest666"

-- Очистка прошлых версий
local playerGui = LocalPlayer:WaitForChild("PlayerGui", 10)
if playerGui and playerGui:FindFirstChild("KecuyaUltimateHub") then
   playerGui.KecuyaUltimateHub:Destroy()
end

-- ==========================================
-- 1. ИНТЕРФЕЙС И МОБИЛЬНОЕ УПРАВЛЕНИЕ
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KecuyaUltimateHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

-- Мобильные кнопки для Полета (Fly Buttons)
local MobileFlyFrame = Instance.new("Frame")
MobileFlyFrame.Size = UDim2.new(0, 70, 0, 130)
MobileFlyFrame.Position = UDim2.new(0.85, 0, 0.4, 0)
MobileFlyFrame.BackgroundTransparency = 1
MobileFlyFrame.Visible = false
MobileFlyFrame.Parent = ScreenGui

local FlyUpBtn = Instance.new("TextButton")
FlyUpBtn.Size = UDim2.new(1, 0, 0, 55)
FlyUpBtn.Position = UDim2.new(0, 0, 0, 0)
FlyUpBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
FlyUpBtn.Text = "▲\nВВЕРХ"
FlyUpBtn.TextColor3 = Color3.fromRGB(168, 85, 247)
FlyUpBtn.Font = Enum.Font.GothamBold
FlyUpBtn.TextSize = 11
FlyUpBtn.Parent = MobileFlyFrame

local FlyUpCorner = Instance.new("UICorner")
FlyUpCorner.CornerRadius = UDim.new(0, 12)
FlyUpCorner.Parent = FlyUpBtn

local FlyDownBtn = Instance.new("TextButton")
FlyDownBtn.Size = UDim2.new(1, 0, 0, 55)
FlyDownBtn.Position = UDim2.new(0, 0, 0, 65)
FlyDownBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
FlyDownBtn.Text = "▼\nВНИЗ"
FlyDownBtn.TextColor3 = Color3.fromRGB(168, 85, 247)
FlyDownBtn.Font = Enum.Font.GothamBold
FlyDownBtn.TextSize = 11
FlyDownBtn.Parent = MobileFlyFrame

local FlyDownCorner = Instance.new("UICorner")
FlyDownCorner.CornerRadius = UDim.new(0, 12)
FlyDownCorner.Parent = FlyDownBtn

-- Переключатель открытия UI (Floating Button)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
ToggleBtn.Text = "⚡"
ToggleBtn.TextColor3 = Color3.fromRGB(168, 85, 247)
ToggleBtn.TextSize = 24
ToggleBtn.Visible = false
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 14)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(168, 85, 247)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

-- Окно Авторизации
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 340, 0, 200)
KeyFrame.Position = UDim2.new(0.5, -170, 0.5, -100)
KeyFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = ScreenGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 16)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(168, 85, 247)
KeyStroke.Thickness = 1.5
KeyStroke.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 45)
KeyTitle.Text = "⚡ KECUYA HUB | АВТОРИЗАЦИЯ"
KeyTitle.TextColor3 = Color3.fromRGB(240, 240, 255)
KeyTitle.TextSize = 13
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.BackgroundTransparency = 1
KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.85, 0, 0, 40)
KeyInput.Position = UDim2.new(0.075, 0, 0.32, 0)
KeyInput.PlaceholderText = "Введите ключ доступа..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 130)
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 11
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = KeyFrame

local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 8)
KeyInputCorner.Parent = KeyInput

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.85, 0, 0, 40)
SubmitBtn.Position = UDim2.new(0.075, 0, 0.64, 0)
SubmitBtn.Text = "ВОЙТИ В СИСТЕМУ"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 11
SubmitBtn.Parent = KeyFrame

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 8)
SubmitCorner.Parent = SubmitBtn

-- Главное Окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 18)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local TargetMainSize = UDim2.new(0, 520, 0, 360)
local TargetMainPos = UDim2.new(0.5, -260, 0.5, -180)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(168, 85, 247)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 42)
TopBar.BackgroundColor3 = Color3.fromRGB(15, 15, 26)
TopBar.Parent = MainFrame

local MainTitle = Instance.new("TextLabel")
MainTitle.Size = UDim2.new(0, 300, 1, 0)
MainTitle.Position = UDim2.new(0, 16, 0, 0)
MainTitle.Text = "⚡ KECUYA ULTIMATE HUB v3.7"
MainTitle.TextColor3 = Color3.fromRGB(168, 85, 247)
MainTitle.TextSize = 13
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextXAlignment = Enum.TextXAlignment.Left
MainTitle.BackgroundTransparency = 1
MainTitle.Parent = TopBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 28, 0, 28)
MinimizeBtn.Position = UDim2.new(1, -66, 0, 7)
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(180, 180, 210)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 14
MinimizeBtn.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0, 7)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(239, 68, 68)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 13
CloseBtn.Parent = TopBar

local TabBar = Instance.new("ScrollingFrame")
TabBar.Size = UDim2.new(1, -24, 0, 36)
TabBar.Position = UDim2.new(0, 12, 0, 48)
TabBar.BackgroundTransparency = 1
TabBar.ScrollBarThickness = 0
TabBar.CanvasSize = UDim2.new(0, 0, 0, 0)
TabBar.AutomaticCanvasSize = Enum.AutomaticSize.X
TabBar.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 8)
TabListLayout.Parent = TabBar

local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -24, 1, -96)
ContentContainer.Position = UDim2.new(0, 12, 0, 88)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

local function AnimateFrame(frame, show, targetSize, targetPos)
   if show then
      frame.Visible = true
      frame:TweenSizeAndPosition(targetSize, targetPos, Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.35, true)
   else
      frame:TweenSizeAndPosition(UDim2.new(0, 0, 0, 0), UDim2.new(0.5, 0, 0.5, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.25, true, function()
         frame.Visible = false
      end)
   end
end

-- ==========================================
-- 2. СОСТОЯНИЯ И ЛОГИКА ФАРМА
-- ==========================================
local Flags = {
   AirRock = false,
   AutoDumbbell = false,
   AutoPushups = false,
   AutoSitups = false,
   AutoPunch = false,
   FastPunch = false,
   TargetRebirth = false,
   AutoKillAir = false,
   TargetKillAir = false,
   FarmGoodKarma = false,
   FarmEvilKarma = false,
   AntiKnockback = false,
   AnchorPos = false,
   Fly = false,
   IgnoreFriends = true
}

local Whitelist = {}
local TargetPlayerName = ""
local SelectedRock = "Tiny Rock"
local TargetRebirthValue = 100
local SavedAnchorCF = nil
local FlySpeed = 50
local MobileUp, MobileDown = false, false

local RockList = {"Tiny Rock", "Small Rock", "Medium Rock", "Large Rock", "Huge Rock", "Legends Rock", "Jungle Rock", "Muscle King Rock"}

local function IsFriend(player)
   if not Flags.IgnoreFriends then return false end
   if player == LocalPlayer then return true end
   local success, result = pcall(function() return LocalPlayer:IsFriendsWith(player.UserId) end)
   return success and result
end

local function HitTarget(targetPlayer)
   pcall(function()
      if not targetPlayer or targetPlayer == LocalPlayer or Whitelist[targetPlayer.Name] or IsFriend(targetPlayer) then return end
      local targetChar = targetPlayer.Character
      if not targetChar then return end
      local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
      local targetHum = targetChar:FindFirstChildOfClass("Humanoid")
      if not targetHrp or not targetHum or targetHum.Health <= 0 then return end

      local myChar = LocalPlayer.Character
      if not myChar then return end

      local punch = myChar:FindFirstChild("Punch") or LocalPlayer.Backpack:FindFirstChild("Punch")
      if punch then
         punch.Parent = myChar
         punch:Activate()
         local punchRemote = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("punchEvent")
         if punchRemote then punchRemote:FireServer("punchAttack") end
         local rightHand = myChar:FindFirstChild("RightHand") or myChar:FindFirstChild("Right Arm")
         if rightHand then
            firetouchinterest(rightHand, targetHrp, 0)
            firetouchinterest(rightHand, targetHrp, 1)
         end
      end
   end)
end

-- Основной цикл Убийств и Фарма Кармы
task.spawn(function()
   while true do
      pcall(function()
         for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and not Whitelist[p.Name] and not IsFriend(p) then
               if Flags.AutoKillAir then
                  HitTarget(p)
               end

               -- Фарм Доброй Кармы (Атакуем игроков с отрицательной/злой кармой)
               if Flags.FarmGoodKarma then
                  local evilStat = p:FindFirstChild("evil") or (p:FindFirstChild("leaderstats") and p.leaderstats:FindFirstChild("Evil"))
                  local karmaStat = p:FindFirstChild("karma") or (p:FindFirstChild("leaderstats") and p.leaderstats:FindFirstChild("Karma"))
                  if (evilStat and evilStat.Value > 0) or (karmaStat and karmaStat.Value < 0) then
                     HitTarget(p)
                  end
               end

               -- Фарм Злой Кармы (Атакуем игроков с хорошей кармой)
               if Flags.FarmEvilKarma then
                  local goodStat = p:FindFirstChild("good") or (p:FindFirstChild("leaderstats") and p.leaderstats:FindFirstChild("Good"))
                  local karmaStat = p:FindFirstChild("karma") or (p:FindFirstChild("leaderstats") and p.leaderstats:FindFirstChild("Karma"))
                  if (goodStat and goodStat.Value > 0) or (karmaStat and karmaStat.Value >= 0) then
                     HitTarget(p)
                  end
               end
            end
         end
      end)
      task.wait(0.02)
   end
end)

task.spawn(function()
   while true do
      if Flags.TargetKillAir and TargetPlayerName ~= "" then
         local p = Players:FindFirstChild(TargetPlayerName)
         if p and not IsFriend(p) then HitTarget(p) end
      end
      task.wait(0.02)
   end
end)

local currentRockPart = nil
local function ResetRock()
   if currentRockPart then
      pcall(function()
         currentRockPart.Transparency = 0
         currentRockPart.CanCollide = true
      end)
      currentRockPart = nil
   end
end

task.spawn(function()
   while true do
      if Flags.AirRock then
         pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
               local hrp = char.HumanoidRootPart
               if not currentRockPart or not currentRockPart.Parent then
                  for _, v in pairs(Workspace:GetDescendants()) do
                     if v:IsA("BasePart") and (v.Name:lower():find(SelectedRock:lower()) or (v.Parent and v.Parent.Name:lower():find(SelectedRock:lower()))) then
                        currentRockPart = v
                        break
                     end
                  end
               end
               if currentRockPart then
                  currentRockPart.Transparency = 1
                  currentRockPart.CanCollide = false
                  currentRockPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -1.5)
                  local punch = char:FindFirstChild("Punch") or LocalPlayer.Backpack:FindFirstChild("Punch")
                  if punch then
                     punch.Parent = char
                     punch:Activate()
                     if char:FindFirstChild("LeftHand") then
                        firetouchinterest(char.LeftHand, currentRockPart, 0)
                        firetouchinterest(char.LeftHand, currentRockPart, 1)
                     end
                  end
               end
            end
         end)
      else
         ResetRock()
      end
      task.wait(0.01)
   end
end)

-- УПРАВЛЕНИЕ ПОЛЕТОМ (УНИВЕРСАЛЬНЫЙ FLY: ПК + ТЕЛЕФОН)
FlyUpBtn.MouseButton1Down:Connect(function() MobileUp = true end)
FlyUpBtn.MouseButton1Up:Connect(function() MobileUp = false end)
FlyDownBtn.MouseButton1Down:Connect(function() MobileDown = true end)
FlyDownBtn.MouseButton1Up:Connect(function() MobileDown = false end)

local flyBodyVel, flyBodyGyro
task.spawn(function()
   while true do
      pcall(function()
         local char = LocalPlayer.Character
         if Flags.Fly and char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local camera = Workspace.CurrentCamera
            local hum = char:FindFirstChildOfClass("Humanoid")
            
            if not flyBodyVel or flyBodyVel.Parent ~= hrp then
               flyBodyVel = Instance.new("BodyVelocity")
               flyBodyVel.MaxForce = Vector3.new(1, 1, 1) * 1e6
               flyBodyVel.Velocity = Vector3.zero
               flyBodyVel.Parent = hrp

               flyBodyGyro = Instance.new("BodyGyro")
               flyBodyGyro.MaxTorque = Vector3.new(1, 1, 1) * 1e6
               flyBodyGyro.CFrame = hrp.CFrame
               flyBodyGyro.Parent = hrp
            end

            local moveDir = Vector3.zero
            
            -- Движение джойстика/клавиатуры
            if hum and hum.MoveDirection.Magnitude > 0 then
               moveDir = hum.MoveDirection
            end

            -- Вверх / Вниз (ПК + Мобильные кнопки)
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) or MobileUp then 
               moveDir = moveDir + Vector3.new(0, 1, 0) 
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or MobileDown then 
               moveDir = moveDir - Vector3.new(0, 1, 0) 
            end

            flyBodyVel.Velocity = moveDir * FlySpeed
            flyBodyGyro.CFrame = camera.CFrame
         else
            if flyBodyVel then flyBodyVel:Destroy() flyBodyVel = nil end
            if flyBodyGyro then flyBodyGyro:Destroy() flyBodyGyro = nil end
         end
      end)
      task.wait(0.02)
   end
end)

-- ANTI-KNOCKBACK (СТЕНА)
RunService.RenderStepped:Connect(function()
   pcall(function()
      local char = LocalPlayer.Character
      if not char then return end
      local hrp = char:FindFirstChild("HumanoidRootPart")
      local humanoid = char:FindFirstChildOfClass("Humanoid")

      if hrp then
         if Flags.AntiKnockback then
            for _, v in pairs(hrp:GetChildren()) do
               if (v:IsA("BodyVelocity") or v:IsA("LinearVelocity") or v:IsA("VectorForce") or v:IsA("BodyThrust")) and v ~= flyBodyVel then
                  v:Destroy()
               end
            end
            
            for _, part in pairs(char:GetChildren()) do
               if part:IsA("BasePart") then
                  part.CustomPhysicalProperties = PhysicalProperties.new(100, 1, 0, 1, 1)
               end
            end

            if humanoid and humanoid.MoveDirection.Magnitude == 0 and not Flags.Fly then
               hrp.AssemblyLinearVelocity = Vector3.zero
            else
               local currentY = hrp.AssemblyLinearVelocity.Y
               if currentY > 50 or currentY < -50 then currentY = 0 end
               hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, currentY, hrp.AssemblyLinearVelocity.Z)
            end
            hrp.AssemblyAngularVelocity = Vector3.zero
         end

         if Flags.AnchorPos then
            if not SavedAnchorCF then SavedAnchorCF = hrp.CFrame end
            hrp.CFrame = SavedAnchorCF
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
         end
      end
   end)
end)

local function UseTool(toolName, fastMode)
   pcall(function()
      local char = LocalPlayer.Character
      if not char then return end
      local tool = char:FindFirstChild(toolName) or LocalPlayer.Backpack:FindFirstChild(toolName)
      if tool then
         tool.Parent = char
         tool:Activate()
         if fastMode then task.wait(0.01) else task.wait(0.1) end
      end
   end)
end

-- ==========================================
-- 3. ВЕРСТКА С ВКЛАДКАМИ И КНОПКАМИ
-- ==========================================
local Pages = {}
local TabButtons = {}

local function CreateTab(name)
   local btn = Instance.new("TextButton")
   btn.Size = UDim2.new(0, 92, 1, 0)
   btn.Text = name
   btn.TextColor3 = Color3.fromRGB(130, 130, 160)
   btn.BackgroundColor3 = Color3.fromRGB(16, 16, 26)
   btn.Font = Enum.Font.GothamMedium
   btn.TextSize = 10
   btn.Parent = TabBar

   local bCorner = Instance.new("UICorner")
   bCorner.CornerRadius = UDim.new(0, 6)
   bCorner.Parent = btn

   local indicator = Instance.new("Frame")
   indicator.Name = "Indicator"
   indicator.Size = UDim2.new(1, -12, 0, 2)
   indicator.Position = UDim2.new(0, 6, 1, -3)
   indicator.BackgroundColor3 = Color3.fromRGB(168, 85, 247)
   indicator.Visible = false
   indicator.Parent = btn

   local scroll = Instance.new("ScrollingFrame")
   scroll.Size = UDim2.new(1, 0, 1, 0)
   scroll.BackgroundTransparency = 1
   scroll.Visible = false
   scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
   scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
   scroll.ScrollBarThickness = 3
   scroll.ScrollBarImageColor3 = Color3.fromRGB(80, 50, 120)
   scroll.Parent = ContentContainer

   local layout = Instance.new("UIListLayout")
   layout.Padding = UDim.new(0, 6)
   layout.Parent = scroll

   btn.MouseButton1Click:Connect(function()
      for _, p in pairs(Pages) do p.Visible = false end
      for _, b in pairs(TabButtons) do 
         TweenService:Create(b, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(130, 130, 160), BackgroundColor3 = Color3.fromRGB(16, 16, 26)}):Play()
         local ind = b:FindFirstChild("Indicator")
         if ind then ind.Visible = false end
      end
      
      scroll.Visible = true
      TweenService:Create(btn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(240, 240, 255), BackgroundColor3 = Color3.fromRGB(28, 28, 45)}):Play()
      indicator.Visible = true
   end)

   table.insert(Pages, scroll)
   table.insert(TabButtons, btn)
   return scroll, btn
end

local RockPg = CreateTab("Камни")
local BenchPg = CreateTab("Качалка")
local KillPg = CreateTab("Атака")
local RebirthPg = CreateTab("Ребирт")
local UtilityPg = CreateTab("Защита")

Pages[1].Visible = true
TabButtons[1].TextColor3 = Color3.fromRGB(240, 240, 255)
TabButtons[1].BackgroundColor3 = Color3.fromRGB(28, 28, 45)
local firstInd = TabButtons[1]:FindFirstChild("Indicator")
if firstInd then firstInd.Visible = true end

local function CreateToggle(parent, name, defaultState, callback)
   local frame = Instance.new("Frame")
   frame.Size = UDim2.new(1, -6, 0, 34)
   frame.BackgroundColor3 = Color3.fromRGB(16, 16, 26)
   frame.Parent = parent

   local fCorner = Instance.new("UICorner")
   fCorner.CornerRadius = UDim.new(0, 8)
   fCorner.Parent = frame

   local txt = Instance.new("TextLabel")
   txt.Size = UDim2.new(0, 320, 1, 0)
   txt.Position = UDim2.new(0, 14, 0, 0)
   txt.Text = name
   txt.TextColor3 = Color3.fromRGB(200, 200, 225)
   txt.Font = Enum.Font.Gotham
   txt.TextSize = 11
   txt.TextXAlignment = Enum.TextXAlignment.Left
   txt.BackgroundTransparency = 1
   txt.Parent = frame

   local switch = Instance.new("TextButton")
   switch.Size = UDim2.new(0, 44, 0, 22)
   switch.Position = UDim2.new(1, -52, 0.5, -11)
   switch.BackgroundColor3 = defaultState and Color3.fromRGB(168, 85, 247) or Color3.fromRGB(30, 30, 48)
   switch.Text = ""
   switch.Parent = frame

   local sCorner = Instance.new("UICorner")
   sCorner.CornerRadius = UDim.new(1, 0)
   sCorner.Parent = switch

   local circle = Instance.new("Frame")
   circle.Size = UDim2.new(0, 16, 0, 16)
   circle.Position = defaultState and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
   circle.BackgroundColor3 = defaultState and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 170)
   circle.Parent = switch

   local cCorner = Instance.new("UICorner")
   cCorner.CornerRadius = UDim.new(1, 0)
   cCorner.Parent = circle

   local state = defaultState
   switch.MouseButton1Click:Connect(function()
      state = not state
      local targetPos = state and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
      local targetColor = state and Color3.fromRGB(168, 85, 247) or Color3.fromRGB(30, 30, 48)
      local circleColor = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 170)
      
      TweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetPos, BackgroundColor3 = circleColor}):Play()
      TweenService:Create(switch, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = targetColor}):Play()
      
      callback(state)
   end)
end

-- Вкладка: Камни
CreateToggle(RockPg, "Включить авто-фарм камня", Flags.AirRock, function(v)
   Flags.AirRock = v
   if not v then ResetRock() end
end)

local RockTitle = Instance.new("TextLabel")
RockTitle.Size = UDim2.new(1, -6, 0, 22)
RockTitle.Text = "ВЫБЕРИТЕ КАМЕНЬ ДЛЯ ФАРМА:"
RockTitle.TextColor3 = Color3.fromRGB(168, 85, 247)
RockTitle.Font = Enum.Font.GothamBold
RockTitle.TextSize = 10
RockTitle.BackgroundTransparency = 1
RockTitle.Parent = RockPg

for _, rName in pairs(RockList) do
   local b = Instance.new("TextButton")
   b.Size = UDim2.new(1, -6, 0, 26)
   b.Text = "  Камень: " .. rName
   b.TextColor3 = Color3.fromRGB(160, 160, 185)
   b.BackgroundColor3 = Color3.fromRGB(16, 16, 26)
   b.Font = Enum.Font.Gotham
   b.TextSize = 10
   b.TextXAlignment = Enum.TextXAlignment.Left
   b.Parent = RockPg

   local c = Instance.new("UICorner")
   c.CornerRadius = UDim.new(0, 6)
   c.Parent = b

   b.MouseButton1Click:Connect(function()
      SelectedRock = rName
      ResetRock()
      b.Text = "  ✓ ВЫБРАН: " .. rName
      TweenService:Create(b, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(168, 85, 247)}):Play()
      task.wait(0.8)
      b.Text = "  Камень: " .. rName
      TweenService:Create(b, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(160, 160, 185)}):Play()
   end)
end

-- Вкладка: Качалка
CreateToggle(BenchPg, "Авто-Гантели (Dumbbell)", Flags.AutoDumbbell, function(v)
   Flags.AutoDumbbell = v
   task.spawn(function() while Flags.AutoDumbbell do UseTool("Dumbbell", Flags.FastPunch) end end)
end)

CreateToggle(BenchPg, "Авто-Отжимания (Pushups)", Flags.AutoPushups, function(v)
   Flags.AutoPushups = v
   task.spawn(function() while Flags.AutoPushups do UseTool("Pushups", Flags.FastPunch) end end)
end)

CreateToggle(BenchPg, "Авто-Пресс (Situps)", Flags.AutoSitups, function(v)
   Flags.AutoSitups = v
   task.spawn(function() while Flags.AutoSitups do UseTool("Situps", Flags.FastPunch) end end)
end)

CreateToggle(BenchPg, "Авто-Панч (Punch)", Flags.AutoPunch, function(v)
   Flags.AutoPunch = v
   task.spawn(function() while Flags.AutoPunch do UseTool("Punch", Flags.FastPunch) end end)
end)

CreateToggle(BenchPg, "Ускоренный удар (Fast Punch)", Flags.FastPunch, function(v)
   Flags.FastPunch = v
end)

-- Вкладка: Атака (Килы и Карма)
CreateToggle(KillPg, "Не трогать друзей (Friend Whitelist)", Flags.IgnoreFriends, function(v)
   Flags.IgnoreFriends = v
end)

CreateToggle(KillPg, "Auto Kill All (Убивать всех)", Flags.AutoKillAir, function(v)
   Flags.AutoKillAir = v
end)

CreateToggle(KillPg, "Auto Farm Good Karma (Фарм Доброты)", Flags.FarmGoodKarma, function(v)
   Flags.FarmGoodKarma = v
   if v then Flags.FarmEvilKarma = false end
end)

CreateToggle(KillPg, "Auto Farm Evil Karma (Фарм Зла)", Flags.FarmEvilKarma, function(v)
   Flags.FarmEvilKarma = v
   if v then Flags.FarmGoodKarma = false end
end)

local TargetInput = Instance.new("TextBox")
TargetInput.Size = UDim2.new(1, -6, 0, 32)
TargetInput.PlaceholderText = "Введите ник игрока..."
TargetInput.PlaceholderColor3 = Color3.fromRGB(90, 90, 110)
TargetInput.Text = ""
TargetInput.BackgroundColor3 = Color3.fromRGB(16, 16, 26)
TargetInput.TextColor3 = Color3.fromRGB(240, 240, 255)
TargetInput.Font = Enum.Font.Gotham
TargetInput.TextSize = 10
TargetInput.ClearTextOnFocus = false
TargetInput.Parent = KillPg

local tIC = Instance.new("UICorner")
tIC.CornerRadius = UDim.new(0, 6)
tIC.Parent = TargetInput

TargetInput:GetPropertyChangedSignal("Text"):Connect(function()
   TargetPlayerName = TargetInput.Text
end)

CreateToggle(KillPg, "Target Kill (Точечный)", Flags.TargetKillAir, function(v)
   Flags.TargetKillAir = v
   TargetPlayerName = TargetInput.Text
end)

-- Вкладка: Ребирт
local RebInput = Instance.new("TextBox")
RebInput.Size = UDim2.new(1, -6, 0, 32)
RebInput.PlaceholderText = "Целевое кол-во ребиртов..."
RebInput.PlaceholderColor3 = Color3.fromRGB(90, 90, 110)
RebInput.Text = "100"
RebInput.BackgroundColor3 = Color3.fromRGB(16, 16, 26)
RebInput.TextColor3 = Color3.fromRGB(240, 240, 255)
RebInput.Font = Enum.Font.Gotham
RebInput.TextSize = 10
RebInput.ClearTextOnFocus = false
RebInput.Parent = RebirthPg

local rIC = Instance.new("UICorner")
rIC.CornerRadius = UDim.new(0, 6)
rIC.Parent = RebInput

CreateToggle(RebirthPg, "Target Rebirth (Авто-Ребирт)", Flags.TargetRebirth, function(v)
    Flags.TargetRebirth = v
    TargetRebirthValue = tonumber(RebInput.Text) or 100

    task.spawn(function()
        while Flags.TargetRebirth do
            pcall(function()
               local stats = LocalPlayer:FindFirstChild("leaderstats")
               local rebirths = stats and stats:FindFirstChild("Rebirths")
               local rb = rebirths and rebirths.Value or 0

               if rb >= TargetRebirthValue then
                   Flags.TargetRebirth = false
                   return
               else
                   ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
               end
            end)
            task.wait(0.5)
        end
    end)
end)

-- Вкладка: Защита
CreateToggle(UtilityPg, "Anti-Knockback (Стена от ударов)", Flags.AntiKnockback, function(v) 
   Flags.AntiKnockback = v 
end)

CreateToggle(UtilityPg, "Режим полета (Fly ПК/Тел)", Flags.Fly, function(v) 
   Flags.Fly = v 
   MobileFlyFrame.Visible = v
end)

CreateToggle(UtilityPg, "Зафиксировать позицию (Anchor)", Flags.AnchorPos, function(v) 
   Flags.AnchorPos = v 
   if v then
      pcall(function()
         local char = LocalPlayer.Character
         if char and char:FindFirstChild("HumanoidRootPart") then
            SavedAnchorCF = char.HumanoidRootPart.CFrame
         end
      end)
   else
      SavedAnchorCF = nil
   end
end)

-- ==========================================
-- 4. АВТОРИЗАЦИЯ И ОБРАБОТЧИКИ
-- ==========================================
local function AttemptLogin()
   local enteredKey = string.match(KeyInput.Text, "^%s*(.-)%s*$") or ""
   if enteredKey == CorrectKey then
      KeyFrame.Visible = false
      ToggleBtn.Visible = true
      AnimateFrame(MainFrame, true, TargetMainSize, TargetMainPos)
   else
      KeyInput.Text = "❌ Неверный ключ"
      KeyInput.TextColor3 = Color3.fromRGB(239, 68, 68)
      task.wait(1.2)
      KeyInput.Text = ""
      KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
   end
end

SubmitBtn.MouseButton1Click:Connect(AttemptLogin)
KeyInput.FocusLost:Connect(function(enterPressed) if enterPressed then AttemptLogin() end end)

CloseBtn.MouseButton1Click:Connect(function()
   ResetRock()
   AnimateFrame(MainFrame, false)
   task.wait(0.3)
   ScreenGui:Destroy()
end)

MinimizeBtn.MouseButton1Click:Connect(function()
   AnimateFrame(MainFrame, false)
   ToggleBtn.Visible = true
end)

ToggleBtn.MouseButton1Click:Connect(function()
   if MainFrame.Visible then
      AnimateFrame(MainFrame, false)
   else
      AnimateFrame(MainFrame, true, TargetMainSize, TargetMainPos)
   end
end)
