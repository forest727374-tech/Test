-- // MUSCLE LEGENDS ULTRA GALAXY HUB (DARK MINIMAL EDITION - FULLY FIXED)
-- // Created by @kecuya | Key: Guest666

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local CorrectKey = "Guest666"

-- Очистка старой версии GUI
local playerGui = LocalPlayer:WaitForChild("PlayerGui", 10)
if playerGui and playerGui:FindFirstChild("KecuyaPrivateHub") then
   playerGui.KecuyaPrivateHub:Destroy()
end

-- ==========================================
-- 1. СТРУКТУРА ИНТЕРФЕЙСА (MODERN DARK)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KecuyaPrivateHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

-- Маленькая плавающая кнопка разворачивания
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 40, 0, 40)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
ToggleBtn.Text = "🌌"
ToggleBtn.TextSize = 18
ToggleBtn.Visible = false
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(138, 43, 226)
ToggleStroke.Thickness = 1.5
ToggleStroke.Parent = ToggleBtn

-- Окно Авторизации (Key System)
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 280, 0, 160)
KeyFrame.Position = UDim2.new(0.5, -140, 0.5, -80)
KeyFrame.BackgroundColor3 = Color3.fromRGB(14, 16, 22)
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = ScreenGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 10)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(35, 38, 50)
KeyStroke.Thickness = 1
KeyStroke.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 35)
KeyTitle.Text = "KECUYA HUB | АВТОРИЗАЦИЯ"
KeyTitle.TextColor3 = Color3.fromRGB(240, 240, 245)
KeyTitle.TextSize = 11
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.BackgroundTransparency = 1
KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.85, 0, 0, 32)
KeyInput.Position = UDim2.new(0.075, 0, 0.32, 0)
KeyInput.PlaceholderText = "Введите ключ доступа..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(100, 105, 120)
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.BackgroundColor3 = Color3.fromRGB(22, 25, 35)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 11
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = KeyFrame

local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 6)
KeyInputCorner.Parent = KeyInput

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.85, 0, 0, 32)
SubmitBtn.Position = UDim2.new(0.075, 0, 0.62, 0)
SubmitBtn.Text = "Войти"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 11
SubmitBtn.Parent = KeyFrame

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 6)
SubmitCorner.Parent = SubmitBtn

-- Главное Окно (Компактное и стильное)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 360, 0, 250)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(13, 14, 18)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(30, 33, 45)
MainStroke.Thickness = 1
MainStroke.Parent = MainFrame

-- Шапка
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 32)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
TopBar.Parent = MainFrame

local MainTitle = Instance.new("TextLabel")
MainTitle.Size = UDim2.new(0, 180, 1, 0)
MainTitle.Position = UDim2.new(0, 10, 0, 0)
MainTitle.Text = "KECUYA HUB"
MainTitle.TextColor3 = Color3.fromRGB(220, 225, 240)
MainTitle.TextSize = 11
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextXAlignment = Enum.TextXAlignment.Left
MainTitle.BackgroundTransparency = 1
MainTitle.Parent = TopBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
MinimizeBtn.Position = UDim2.new(1, -52, 0, 4)
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(160, 165, 180)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 12
MinimizeBtn.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -26, 0, 4)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(220, 80, 80)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 11
CloseBtn.Parent = TopBar

-- Панель вкладок (Горизонтальная сверху)
local TabBar = Instance.new("ScrollingFrame")
TabBar.Size = UDim2.new(1, -16, 0, 26)
TabBar.Position = UDim2.new(0, 8, 0, 36)
TabBar.BackgroundTransparency = 1
TabBar.ScrollBarThickness = 0
TabBar.CanvasSize = UDim2.new(0, 0, 0, 0)
TabBar.AutomaticCanvasSize = Enum.AutomaticSize.X
TabBar.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 4)
TabListLayout.Parent = TabBar

-- Контейнер содержимого
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -16, 1, -72)
ContentContainer.Position = UDim2.new(0, 8, 0, 66)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

-- ==========================================
-- 2. СОСТОЯНИЯ И ПЕРЕМЕННЫЕ
-- ==========================================
local Flags = {
   AirRock = false,
   AutoBench = false,
   TargetRebirth = false,
   AutoKillAir = false,
   TargetKillAir = false,
   AntiKnockback = false,
   AntiAFK = false,
   AnchorPos = false,
   Fly = false
}

local Whitelist = {}
local TargetPlayerName = ""
local SelectedRock = "Tiny Rock"
local TargetRebirthValue = 100
local SavedAnchorCF = nil
local FlySpeed = 50

local RockList = {"Tiny Rock", "Small Rock", "Medium Rock", "Large Rock", "Huge Rock", "Legends Rock", "Jungle Rock", "Muscle King Rock"}

-- ==========================================
-- 3. ОСНОВНЫЕ ФУНКЦИИ МОДУЛЕЙ
-- ==========================================

local function ProcessAirRock()
   pcall(function()
      local char = LocalPlayer.Character
      if not char or not char:FindFirstChild("HumanoidRootPart") then return end
      local punch = LocalPlayer.Backpack:FindFirstChild("Punch") or char:FindFirstChild("Punch")
      if punch then
         punch.Parent = char
         punch:Activate()
      end
      for _, v in pairs(Workspace:GetChildren()) do
         if v.Name:lower():find(SelectedRock:lower()) or (v:FindFirstChild("Rock") and v.Name:find("Rock")) then
            local rockPart = v:IsA("BasePart") and v or v:FindFirstChildOfClass("BasePart")
            if rockPart and punch and punch:FindFirstChild("LeftHand") then
               firetouchinterest(punch.LeftHand, rockPart, 0)
               firetouchinterest(punch.LeftHand, rockPart, 1)
            end
            break
         end
      end
   end)
end

local function HitTarget(targetPlayer)
   pcall(function()
      local char = LocalPlayer.Character
      if not char or not targetPlayer or not targetPlayer.Character then return end
      local targetHrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
      local punch = LocalPlayer.Backpack:FindFirstChild("Punch") or char:FindFirstChild("Punch")
      if punch and targetHrp then
         punch.Parent = char
         punch:Activate()
         if punch:FindFirstChild("LeftHand") then
            firetouchinterest(punch.LeftHand, targetHrp, 0)
            firetouchinterest(punch.LeftHand, targetHrp, 1)
         end
      end
   end)
end

local bodyGyro, bodyVelocity
local function SetFly(state)
   pcall(function()
      local char = LocalPlayer.Character
      if not char or not char:FindFirstChild("HumanoidRootPart") then return end
      local hrp = char.HumanoidRootPart

      if state then
         if bodyGyro then bodyGyro:Destroy() end
         if bodyVelocity then bodyVelocity:Destroy() end

         bodyGyro = Instance.new("BodyGyro")
         bodyGyro.P = 9e4
         bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
         bodyGyro.CFrame = hrp.CFrame
         bodyGyro.Parent = hrp

         bodyVelocity = Instance.new("BodyVelocity")
         bodyVelocity.Velocity = Vector3.zero
         bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
         bodyVelocity.Parent = hrp

         task.spawn(function()
            while Flags.Fly and char and char:FindFirstChild("Humanoid") do
               local cam = Workspace.CurrentCamera
               local dir = Vector3.zero

               if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
               if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
               if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
               if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end

               bodyGyro.CFrame = cam.CFrame
               bodyVelocity.Velocity = dir * FlySpeed
               task.wait()
            end
            if bodyGyro then bodyGyro:Destroy() end
            if bodyVelocity then bodyVelocity:Destroy() end
         end)
      else
         if bodyGyro then bodyGyro:Destroy() end
         if bodyVelocity then bodyVelocity:Destroy() end
      end
   end)
end

RunService.Heartbeat:Connect(function()
   pcall(function()
      local char = LocalPlayer.Character
      if char and char:FindFirstChild("HumanoidRootPart") then
         local hrp = char.HumanoidRootPart
         if Flags.AntiKnockback then
            hrp.Velocity = Vector3.new(0, hrp.Velocity.Y, 0)
            hrp.RotVelocity = Vector3.zero
         end
         if Flags.AnchorPos then
            if not SavedAnchorCF then SavedAnchorCF = hrp.CFrame end
            hrp.CFrame = SavedAnchorCF
            hrp.Velocity = Vector3.zero
         else
            SavedAnchorCF = nil
         end
      end
   end)
end)

LocalPlayer.Idled:Connect(function()
   if Flags.AntiAFK then
      pcall(function()
         VirtualUser:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
         task.wait(1)
         VirtualUser:Button2Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
      end)
   end
end)

-- ==========================================
-- 4. СОЗДАНИЕ ВЕРСТКИ И ВКЛАДОК
-- ==========================================
local Pages = {}
local TabButtons = {}

local function CreateTab(name)
   local btn = Instance.new("TextButton")
   btn.Size = UDim2.new(0, 68, 1, 0)
   btn.Text = name
   btn.TextColor3 = Color3.fromRGB(120, 125, 140)
   btn.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
   btn.Font = Enum.Font.GothamMedium
   btn.TextSize = 10
   btn.Parent = TabBar

   local bCorner = Instance.new("UICorner")
   bCorner.CornerRadius = UDim.new(0, 5)
   bCorner.Parent = btn

   local indicator = Instance.new("Frame")
   indicator.Name = "Indicator"
   indicator.Size = UDim2.new(1, -12, 0, 2)
   indicator.Position = UDim2.new(0, 6, 1, -3)
   indicator.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
   indicator.Visible = false
   indicator.Parent = btn

   local scroll = Instance.new("ScrollingFrame")
   scroll.Size = UDim2.new(1, 0, 1, 0)
   scroll.BackgroundTransparency = 1
   scroll.Visible = false
   scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
   scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
   scroll.ScrollBarThickness = 2
   scroll.ScrollBarImageColor3 = Color3.fromRGB(40, 45, 60)
   scroll.Parent = ContentContainer

   local layout = Instance.new("UIListLayout")
   layout.Padding = UDim.new(0, 5)
   layout.Parent = scroll

   btn.MouseButton1Click:Connect(function()
      for _, p in pairs(Pages) do p.Visible = false end
      for _, b in pairs(TabButtons) do 
         b.TextColor3 = Color3.fromRGB(120, 125, 140)
         b.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
         local ind = b:FindFirstChild("Indicator")
         if ind then ind.Visible = false end
      end
      
      scroll.Visible = true
      btn.TextColor3 = Color3.fromRGB(240, 240, 250)
      btn.BackgroundColor3 = Color3.fromRGB(24, 27, 36)
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

-- Активация первой вкладки по умолчанию
Pages[1].Visible = true
TabButtons[1].TextColor3 = Color3.fromRGB(240, 240, 250)
TabButtons[1].BackgroundColor3 = Color3.fromRGB(24, 27, 36)
local firstInd = TabButtons[1]:FindFirstChild("Indicator")
if firstInd then firstInd.Visible = true end

local function CreateToggle(parent, name, callback)
   local frame = Instance.new("Frame")
   frame.Size = UDim2.new(1, -4, 0, 28)
   frame.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
   frame.Parent = parent

   local fCorner = Instance.new("UICorner")
   fCorner.CornerRadius = UDim.new(0, 5)
   fCorner.Parent = frame

   local txt = Instance.new("TextLabel")
   txt.Size = UDim2.new(0, 180, 1, 0)
   txt.Position = UDim2.new(0, 8, 0, 0)
   txt.Text = name
   txt.TextColor3 = Color3.fromRGB(200, 205, 220)
   txt.Font = Enum.Font.Gotham
   txt.TextSize = 10
   txt.TextXAlignment = Enum.TextXAlignment.Left
   txt.BackgroundTransparency = 1
   txt.Parent = frame

   local switch = Instance.new("TextButton")
   switch.Size = UDim2.new(0, 32, 0, 16)
   switch.Position = UDim2.new(1, -38, 0.5, -8)
   switch.BackgroundColor3 = Color3.fromRGB(28, 31, 42)
   switch.Text = ""
   switch.Parent = frame

   local sCorner = Instance.new("UICorner")
   sCorner.CornerRadius = UDim.new(1, 0)
   sCorner.Parent = switch

   local circle = Instance.new("Frame")
   circle.Size = UDim2.new(0, 12, 0, 12)
   circle.Position = UDim2.new(0, 2, 0.5, -6)
   circle.BackgroundColor3 = Color3.fromRGB(140, 145, 160)
   circle.Parent = switch

   local cCorner = Instance.new("UICorner")
   cCorner.CornerRadius = UDim.new(1, 0)
   cCorner.Parent = circle

   local state = false
   switch.MouseButton1Click:Connect(function()
      state = not state
      local targetPos = state and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
      local targetColor = state and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(28, 31, 42)
      local circleColor = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(140, 145, 160)
      
      TweenService:Create(circle, TweenInfo.new(0.15), {Position = targetPos, BackgroundColor3 = circleColor}):Play()
      TweenService:Create(switch, TweenInfo.new(0.15), {BackgroundColor3 = targetColor}):Play()
      
      callback(state)
   end)
end

-- Вкладка: Камни
for _, rName in pairs(RockList) do
   local b = Instance.new("TextButton")
   b.Size = UDim2.new(1, -4, 0, 22)
   b.Text = "  Камень: " .. rName
   b.TextColor3 = Color3.fromRGB(150, 155, 170)
   b.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
   b.Font = Enum.Font.Gotham
   b.TextSize = 9
   b.TextXAlignment = Enum.TextXAlignment.Left
   b.Parent = RockPg

   local c = Instance.new("UICorner")
   c.CornerRadius = UDim.new(0, 4)
   c.Parent = b

   b.MouseButton1Click:Connect(function()
      SelectedRock = rName
      b.Text = "  ✓ ВЫБРАН: " .. rName
      b.TextColor3 = Color3.fromRGB(138, 43, 226)
      task.wait(0.8)
      b.Text = "  Камень: " .. rName
      b.TextColor3 = Color3.fromRGB(150, 155, 170)
   end)
end

CreateToggle(RockPg, "Бить выбранный камень", function(v)
   Flags.AirRock = v
   task.spawn(function()
      while Flags.AirRock do
         ProcessAirRock()
         task.wait(0.05)
      end
   end)
end)

-- Вкладка: Качалка
CreateToggle(BenchPg, "Авто-скамья (Bench)", function(v)
   Flags.AutoBench = v
   task.spawn(function()
      while Flags.AutoBench do
         pcall(function()
            local bench = Workspace:FindFirstChild("BenchPress") or Workspace:FindFirstChild("Bench")
            if bench then
               ReplicatedStorage.rEvents.benchInteractRemote:InvokeServer("useBench", bench)
            end
         end)
         task.wait(0.2)
      end
   end)
end)

-- Вкладка: Атака
CreateToggle(KillPg, "Auto Kill All (Воздух)", function(v)
   Flags.AutoKillAir = v
   task.spawn(function()
      while Flags.AutoKillAir do
         for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and not Whitelist[p.Name] then
               HitTarget(p)
            end
         end
         task.wait(0.05)
      end
   end)
end)

local TargetInput = Instance.new("TextBox")
TargetInput.Size = UDim2.new(1, -4, 0, 26)
TargetInput.PlaceholderText = "Введите ник игрока..."
TargetInput.PlaceholderColor3 = Color3.fromRGB(90, 95, 110)
TargetInput.Text = ""
TargetInput.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
TargetInput.TextColor3 = Color3.fromRGB(240, 240, 250)
TargetInput.Font = Enum.Font.Gotham
TargetInput.TextSize = 10
TargetInput.ClearTextOnFocus = false
TargetInput.Parent = KillPg

local tIC = Instance.new("UICorner")
tIC.CornerRadius = UDim.new(0, 5)
tIC.Parent = TargetInput

CreateToggle(KillPg, "Target Kill (Точечный)", function(v)
   Flags.TargetKillAir = v
   TargetPlayerName = TargetInput.Text
   task.spawn(function()
      while Flags.TargetKillAir do
         local p = Players:FindFirstChild(TargetPlayerName)
         if p then HitTarget(p) end
         task.wait(0.05)
      end
   end)
end)

-- Вкладка: Ребирт
local RebInput = Instance.new("TextBox")
RebInput.Size = UDim2.new(1, -4, 0, 26)
RebInput.PlaceholderText = "Целевое кол-во ребиртов..."
RebInput.PlaceholderColor3 = Color3.fromRGB(90, 95, 110)
RebInput.Text = "100"
RebInput.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
RebInput.TextColor3 = Color3.fromRGB(240, 240, 250)
RebInput.Font = Enum.Font.Gotham
RebInput.TextSize = 10
RebInput.ClearTextOnFocus = false
RebInput.Parent = RebirthPg

local rIC = Instance.new("UICorner")
rIC.CornerRadius = UDim.new(0, 5)
rIC.Parent = RebInput

CreateToggle(RebirthPg, "Target Rebirth (Авто-Ребирт)", function(v)
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
CreateToggle(UtilityPg, "Fly (WASD / Мобильный)", function(v)
   Flags.Fly = v
   SetFly(v)
end)

CreateToggle(UtilityPg, "Anti-Knockback (Без отбрасывания)", function(v) 
   Flags.AntiKnockback = v 
end)

CreateToggle(UtilityPg, "Закрепить позицию (Anchor)", function(v) 
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

CreateToggle(UtilityPg, "Anti-AFK (Защита от вылета)", function(v) 
   Flags.AntiAFK = v 
end)

-- ==========================================
-- 5. АВТОРИЗАЦИЯ, УПРАВЛЕНИЕ И СБРОС
-- ==========================================

local function AttemptLogin()
   local enteredKey = string.match(KeyInput.Text, "^%s*(.-)%s*$") or ""
   
   if enteredKey == CorrectKey then
      KeyFrame.Visible = false
      MainFrame.Visible = true
      ToggleBtn.Visible = true
   else
      KeyInput.Text = "❌ Неверный ключ"
      KeyInput.TextColor3 = Color3.fromRGB(255, 90, 90)
      task.wait(1.2)
      KeyInput.Text = ""
      KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
   end
end

SubmitBtn.MouseButton1Click:Connect(AttemptLogin)

KeyInput.FocusLost:Connect(function(enterPressed)
   if enterPressed then
      AttemptLogin()
   end
end)

CloseBtn.MouseButton1Click:Connect(function()
   ScreenGui:Destroy()
end)

MinimizeBtn.MouseButton1Click:Connect(function()
   MainFrame.Visible = false
   ToggleBtn.Visible = true
end)

ToggleBtn.MouseButton1Click:Connect(function()
   MainFrame.Visible = not MainFrame.Visible
end)

-- Обработка респавна персонажа
LocalPlayer.CharacterAdded:Connect(function(newChar)
   SavedAnchorCF = nil
   if Flags.Fly then
      task.wait(0.5)
      SetFly(true)
   end
end)
