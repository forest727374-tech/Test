-- // MUSCLE LEGENDS ULTIMATE HUB (FULL EXPANDED EDITION)
-- // Key: Guest666

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local CorrectKey = "Guest666"

-- Очистка старой версии GUI
local playerGui = LocalPlayer:WaitForChild("PlayerGui", 10)
if playerGui and playerGui:FindFirstChild("KecuyaUltimateHub") then
   playerGui.KecuyaUltimateHub:Destroy()
end

-- ==========================================
-- 1. СТРУКТУРА ИНТЕРФЕЙСА (CYBER DARK GLASS)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KecuyaUltimateHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

-- Кнопка разворачивания (Toggle Button)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
ToggleBtn.Text = "⚡"
ToggleBtn.TextColor3 = Color3.fromRGB(168, 85, 247)
ToggleBtn.TextSize = 22
ToggleBtn.Visible = false
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 12)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(168, 85, 247)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

-- Окно Авторизации
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 300, 0, 180)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
KeyFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = ScreenGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 12)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(168, 85, 247)
KeyStroke.Thickness = 1.5
KeyStroke.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.Text = "KECUYA HUB | АВТОРИЗАЦИЯ"
KeyTitle.TextColor3 = Color3.fromRGB(240, 240, 255)
KeyTitle.TextSize = 12
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.BackgroundTransparency = 1
KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.85, 0, 0, 36)
KeyInput.Position = UDim2.new(0.075, 0, 0.32, 0)
KeyInput.PlaceholderText = "Введите ключ доступа..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 11
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = KeyFrame

local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 8)
KeyInputCorner.Parent = KeyInput

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.85, 0, 0, 36)
SubmitBtn.Position = UDim2.new(0.075, 0, 0.62, 0)
SubmitBtn.Text = "ВОЙТИ"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 12
SubmitBtn.Parent = KeyFrame

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 8)
SubmitCorner.Parent = SubmitBtn

-- Главное Окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 290)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -145)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(45, 45, 65)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Шапка (TopBar)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 36)
TopBar.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
TopBar.Parent = MainFrame

local MainTitle = Instance.new("TextLabel")
MainTitle.Size = UDim2.new(0, 220, 1, 0)
MainTitle.Position = UDim2.new(0, 12, 0, 0)
MainTitle.Text = "⚡ KECUYA ULTIMATE HUB"
MainTitle.TextColor3 = Color3.fromRGB(168, 85, 247)
MainTitle.TextSize = 12
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextXAlignment = Enum.TextXAlignment.Left
MainTitle.BackgroundTransparency = 1
MainTitle.Parent = TopBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 26, 0, 26)
MinimizeBtn.Position = UDim2.new(1, -58, 0, 5)
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 14
MinimizeBtn.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(239, 68, 68)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
CloseBtn.Parent = TopBar

-- Панель Вкладок
local TabBar = Instance.new("ScrollingFrame")
TabBar.Size = UDim2.new(1, -16, 0, 30)
TabBar.Position = UDim2.new(0, 8, 0, 42)
TabBar.BackgroundTransparency = 1
TabBar.ScrollBarThickness = 0
TabBar.CanvasSize = UDim2.new(0, 0, 0, 0)
TabBar.AutomaticCanvasSize = Enum.AutomaticSize.X
TabBar.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 6)
TabListLayout.Parent = TabBar

-- Контейнер Контента
local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -16, 1, -82)
ContentContainer.Position = UDim2.new(0, 8, 0, 76)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

-- ==========================================
-- 2. СОСТОЯНИЯ И ПЕРЕМЕННЫЕ
-- ==========================================
local Flags = {
   AirRock = false,
   AutoDumbbell = false,
   AutoPushups = false,
   AutoSitups = false,
   AutoPunch = false,
   FastPunch = false,
   AutoMachine = false,
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
local SelectedLocation = "Spawn Zone"
local SelectedMachineType = "Bench Press"
local TargetRebirthValue = 100
local SavedAnchorCF = nil
local FlySpeed = 60

local RockList = {"Tiny Rock", "Small Rock", "Medium Rock", "Large Rock", "Huge Rock", "Legends Rock", "Jungle Rock", "Muscle King Rock"}
local LocationList = {"Spawn Zone", "Beach Zone", "Frost Zone", "Mythical Zone", "Inferno Zone", "Legends Zone"}
local MachineTypes = {"Bench Press", "Squat Rack", "Pullup Bar", "Treadmill"}

-- ==========================================
-- 3. ОСНОВНЫЕ ФУНКЦИИ И ЯДРО
-- ==========================================

-- Функция использования предмета из инвентаря (Гантели, Отжимания, Пресс, Удар)
local function UseTool(toolName, fastMode)
   pcall(function()
      local char = LocalPlayer.Character
      if not char then return end
      local tool = char:FindFirstChild(toolName) or LocalPlayer.Backpack:FindFirstChild(toolName)
      if tool then
         tool.Parent = char
         tool:Activate()
         if fastMode then
            task.wait(0.01)
         else
            task.wait(0.1)
         end
      end
   end)
end

-- Обработка камней
local function ProcessAirRock()
   pcall(function()
      local char = LocalPlayer.Character
      if not char or not char:FindFirstChild("HumanoidRootPart") then return end
      local punch = char:FindFirstChild("Punch") or LocalPlayer.Backpack:FindFirstChild("Punch")
      if punch then
         punch.Parent = char
         punch:Activate()
      end
      
      for _, v in pairs(Workspace:GetChildren()) do
         if v.Name:lower():find(SelectedRock:lower()) or (v:FindFirstChild("Rock") and v.Name:find("Rock")) then
            local rockPart = v:IsA("BasePart") and v or v:FindFirstChildOfClass("BasePart")
            if rockPart and char:FindFirstChild("LeftHand") then
               firetouchinterest(char.LeftHand, rockPart, 0)
               firetouchinterest(char.LeftHand, rockPart, 1)
            end
            break
         end
      end
   end)
end

-- Взаимодействие со стационарными тренажерами
local function ProcessMachine()
   pcall(function()
      for _, v in pairs(Workspace:GetDescendants()) do
         if v:IsA("Model") or v:IsA("BasePart") then
            if v.Name:lower():find(SelectedMachineType:lower():gsub(" ", "")) or v.Name:lower():find(SelectedMachineType:lower()) then
               ReplicatedStorage.rEvents.machineInteractRemote:InvokeServer("useMachine", v)
               break
            end
         end
      end
   end)
end

-- Атака
local function HitTarget(targetPlayer)
   pcall(function()
      local char = LocalPlayer.Character
      if not char or not targetPlayer or not targetPlayer.Character then return end
      local targetHrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
      local punch = char:FindFirstChild("Punch") or LocalPlayer.Backpack:FindFirstChild("Punch")
      if punch and targetHrp then
         punch.Parent = char
         punch:Activate()
         if char:FindFirstChild("LeftHand") then
            firetouchinterest(char.LeftHand, targetHrp, 0)
            firetouchinterest(char.LeftHand, targetHrp, 1)
         end
      end
   end)
end

-- Полет
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

-- Физический цикл
RunService.Heartbeat:Connect(function()
   pcall(function()
      local char = LocalPlayer.Character
      if not char then return end
      local hrp = char:FindFirstChild("HumanoidRootPart")
      local humanoid = char:FindFirstChildOfClass("Humanoid")

      if hrp then
         if Flags.AntiKnockback then
            hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
            hrp.AssemblyAngularVelocity = Vector3.zero
            for _, obj in pairs(hrp:GetChildren()) do
               if obj:IsA("BodyVelocity") or obj:IsA("LinearVelocity") or obj:IsA("VectorForce") then
                  obj:Destroy()
               end
            end
         end

         if Flags.AnchorPos then
            if not SavedAnchorCF then 
               SavedAnchorCF = hrp.CFrame 
            end
            hrp.CFrame = SavedAnchorCF
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero

            if humanoid then
               humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            end
         else
            if SavedAnchorCF then
               SavedAnchorCF = nil
               if humanoid then
                  humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
               end
            end
         end
      end
   end)
end)

-- Anti-AFK
task.spawn(function()
   while task.wait(60) do
      if Flags.AntiAFK then
         pcall(function()
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            task.wait(0.1)
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
         end)
      end
   end
end)

-- ==========================================
-- 4. ВЕРСТКА И ИНТЕРФЕЙС
-- ==========================================
local Pages = {}
local TabButtons = {}

local function CreateTab(name)
   local btn = Instance.new("TextButton")
   btn.Size = UDim2.new(0, 72, 1, 0)
   btn.Text = name
   btn.TextColor3 = Color3.fromRGB(130, 130, 150)
   btn.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
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
   scroll.ScrollBarThickness = 2
   scroll.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 70)
   scroll.Parent = ContentContainer

   local layout = Instance.new("UIListLayout")
   layout.Padding = UDim.new(0, 6)
   layout.Parent = scroll

   btn.MouseButton1Click:Connect(function()
      for _, p in pairs(Pages) do p.Visible = false end
      for _, b in pairs(TabButtons) do 
         b.TextColor3 = Color3.fromRGB(130, 130, 150)
         b.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
         local ind = b:FindFirstChild("Indicator")
         if ind then ind.Visible = false end
      end
      
      scroll.Visible = true
      btn.TextColor3 = Color3.fromRGB(240, 240, 255)
      btn.BackgroundColor3 = Color3.fromRGB(24, 24, 36)
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

-- Активация первой вкладки
Pages[1].Visible = true
TabButtons[1].TextColor3 = Color3.fromRGB(240, 240, 255)
TabButtons[1].BackgroundColor3 = Color3.fromRGB(24, 24, 36)
local firstInd = TabButtons[1]:FindFirstChild("Indicator")
if firstInd then firstInd.Visible = true end

local function CreateToggle(parent, name, callback)
   local frame = Instance.new("Frame")
   frame.Size = UDim2.new(1, -4, 0, 30)
   frame.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
   frame.Parent = parent

   local fCorner = Instance.new("UICorner")
   fCorner.CornerRadius = UDim.new(0, 6)
   fCorner.Parent = frame

   local txt = Instance.new("TextLabel")
   txt.Size = UDim2.new(0, 220, 1, 0)
   txt.Position = UDim2.new(0, 10, 0, 0)
   txt.Text = name
   txt.TextColor3 = Color3.fromRGB(200, 200, 220)
   txt.Font = Enum.Font.Gotham
   txt.TextSize = 10
   txt.TextXAlignment = Enum.TextXAlignment.Left
   txt.BackgroundTransparency = 1
   txt.Parent = frame

   local switch = Instance.new("TextButton")
   switch.Size = UDim2.new(0, 36, 0, 18)
   switch.Position = UDim2.new(1, -42, 0.5, -9)
   switch.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
   switch.Text = ""
   switch.Parent = frame

   local sCorner = Instance.new("UICorner")
   sCorner.CornerRadius = UDim.new(1, 0)
   sCorner.Parent = switch

   local circle = Instance.new("Frame")
   circle.Size = UDim2.new(0, 14, 0, 14)
   circle.Position = UDim2.new(0, 2, 0.5, -7)
   circle.BackgroundColor3 = Color3.fromRGB(150, 150, 170)
   circle.Parent = switch

   local cCorner = Instance.new("UICorner")
   cCorner.CornerRadius = UDim.new(1, 0)
   cCorner.Parent = circle

   local state = false
   switch.MouseButton1Click:Connect(function()
      state = not state
      local targetPos = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
      local targetColor = state and Color3.fromRGB(168, 85, 247) or Color3.fromRGB(30, 30, 45)
      local circleColor = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 170)
      
      TweenService:Create(circle, TweenInfo.new(0.15), {Position = targetPos, BackgroundColor3 = circleColor}):Play()
      TweenService:Create(switch, TweenInfo.new(0.15), {BackgroundColor3 = targetColor}):Play()
      
      callback(state)
   end)
end

-- Вкладка: Камни
for _, rName in pairs(RockList) do
   local b = Instance.new("TextButton")
   b.Size = UDim2.new(1, -4, 0, 24)
   b.Text = "  Камень: " .. rName
   b.TextColor3 = Color3.fromRGB(160, 160, 180)
   b.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
   b.Font = Enum.Font.Gotham
   b.TextSize = 9
   b.TextXAlignment = Enum.TextXAlignment.Left
   b.Parent = RockPg

   local c = Instance.new("UICorner")
   c.CornerRadius = UDim.new(0, 5)
   c.Parent = b

   b.MouseButton1Click:Connect(function()
      SelectedRock = rName
      b.Text = "  ✓ ВЫБРАН: " .. rName
      b.TextColor3 = Color3.fromRGB(168, 85, 247)
      task.wait(0.8)
      b.Text = "  Камень: " .. rName
      b.TextColor3 = Color3.fromRGB(160, 160, 180)
   end)
end

CreateToggle(RockPg, "Авто-Удар по камню", function(v)
   Flags.AirRock = v
   task.spawn(function()
      while Flags.AirRock do
         ProcessAirRock()
         task.wait(0.02)
      end
   end)
end)

-- Вкладка: Качалка
CreateToggle(BenchPg, "Авто-Гантели (Dumbbell)", function(v)
   Flags.AutoDumbbell = v
   task.spawn(function()
      while Flags.AutoDumbbell do
         UseTool("Dumbbell", Flags.FastPunch)
      end
   end)
end)

CreateToggle(BenchPg, "Авто-Отжимания (Pushups)", function(v)
   Flags.AutoPushups = v
   task.spawn(function()
      while Flags.AutoPushups do
         UseTool("Pushups", Flags.FastPunch)
      end
   end)
end)

CreateToggle(BenchPg, "Авто-Пресс (Situps)", function(v)
   Flags.AutoSitups = v
   task.spawn(function()
      while Flags.AutoSitups do
         UseTool("Situps", Flags.FastPunch)
      end
   end)
end)

CreateToggle(BenchPg, "Авто-Панч (Punch)", function(v)
   Flags.AutoPunch = v
   task.spawn(function()
      while Flags.AutoPunch do
         UseTool("Punch", Flags.FastPunch)
      end
   end)
end)

CreateToggle(BenchPg, "Ускоренный удар (Fast Punch)", function(v)
   Flags.FastPunch = v
end)

-- Раздел стационарных тренажеров по локациям
local LocTitle = Instance.new("TextLabel")
LocTitle.Size = UDim2.new(1, -4, 0, 20)
LocTitle.Text = "ВЫБОР ЛОКАЦИИ И ТРЕНАЖЕРА:"
LocTitle.TextColor3 = Color3.fromRGB(168, 85, 247)
LocTitle.Font = Enum.Font.GothamBold
LocTitle.TextSize = 10
LocTitle.BackgroundTransparency = 1
LocTitle.Parent = BenchPg

for _, loc in pairs(LocationList) do
   local b = Instance.new("TextButton")
   b.Size = UDim2.new(1, -4, 0, 22)
   b.Text = "  Локация: " .. loc
   b.TextColor3 = Color3.fromRGB(140, 140, 160)
   b.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
   b.Font = Enum.Font.Gotham
   b.TextSize = 9
   b.TextXAlignment = Enum.TextXAlignment.Left
   b.Parent = BenchPg

   local c = Instance.new("UICorner")
   c.CornerRadius = UDim.new(0, 4)
   c.Parent = b

   b.MouseButton1Click:Connect(function()
      SelectedLocation = loc
      b.Text = "  ✓ ВЫБРАНО: " .. loc
      b.TextColor3 = Color3.fromRGB(168, 85, 247)
      task.wait(0.8)
      b.Text = "  Локация: " .. loc
      b.TextColor3 = Color3.fromRGB(140, 140, 160)
   end)
end

for _, mType in pairs(MachineTypes) do
   local b = Instance.new("TextButton")
   b.Size = UDim2.new(1, -4, 0, 22)
   b.Text = "  Тренажер: " .. mType
   b.TextColor3 = Color3.fromRGB(140, 140, 160)
   b.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
   b.Font = Enum.Font.Gotham
   b.TextSize = 9
   b.TextXAlignment = Enum.TextXAlignment.Left
   b.Parent = BenchPg

   local c = Instance.new("UICorner")
   c.CornerRadius = UDim.new(0, 4)
   c.Parent = b

   b.MouseButton1Click:Connect(function()
      SelectedMachineType = mType
      b.Text = "  ✓ ВЫБРАН: " .. mType
      b.TextColor3 = Color3.fromRGB(168, 85, 247)
      task.wait(0.8)
      b.Text = "  Тренажер: " .. mType
      b.TextColor3 = Color3.fromRGB(140, 140, 160)
   end)
end

CreateToggle(BenchPg, "Авто-Подъемник тренажеров", function(v)
   Flags.AutoMachine = v
   task.spawn(function()
      while Flags.AutoMachine do
         ProcessMachine()
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
TargetInput.Size = UDim2.new(1, -4, 0, 28)
TargetInput.PlaceholderText = "Введите ник игрока..."
TargetInput.PlaceholderColor3 = Color3.fromRGB(90, 90, 110)
TargetInput.Text = ""
TargetInput.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
TargetInput.TextColor3 = Color3.fromRGB(240, 240, 255)
TargetInput.Font = Enum.Font.Gotham
TargetInput.TextSize = 10
TargetInput.ClearTextOnFocus = false
TargetInput.Parent = KillPg

local tIC = Instance.new("UICorner")
tIC.CornerRadius = UDim.new(0, 6)
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
RebInput.Size = UDim2.new(1, -4, 0, 28)
RebInput.PlaceholderText = "Целевое кол-во ребиртов..."
RebInput.PlaceholderColor3 = Color3.fromRGB(90, 90, 110)
RebInput.Text = "100"
RebInput.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
RebInput.TextColor3 = Color3.fromRGB(240, 240, 255)
RebInput.Font = Enum.Font.Gotham
RebInput.TextSize = 10
RebInput.ClearTextOnFocus = false
RebInput.Parent = RebirthPg

local rIC = Instance.new("UICorner")
rIC.CornerRadius = UDim.new(0, 6)
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
-- 5. АВТОРИЗАЦИЯ И УПРАВЛЕНИЕ
-- ==========================================

local function AttemptLogin()
   local enteredKey = string.match(KeyInput.Text, "^%s*(.-)%s*$") or ""
   
   if enteredKey == CorrectKey then
      KeyFrame.Visible = false
      MainFrame.Visible = true
      ToggleBtn.Visible = true
   else
      KeyInput.Text = "❌ Неверный ключ"
      KeyInput.TextColor3 = Color3.fromRGB(239, 68, 68)
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

-- Обработка возрождения
LocalPlayer.CharacterAdded:Connect(function(newChar)
   SavedAnchorCF = nil
   if Flags.Fly then
      task.wait(0.5)
      SetFly(true)
   end
end)
