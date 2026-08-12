-- // MUSCLE LEGENDS ULTRA GALAXY HUB (FIXED EDITION)
-- // Created by @kecuya | All Rights Reserved
-- // Key: Guest666

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local CorrectKey = "Guest666"

-- Очистка старого GUI
if LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("KecuyaPrivateHub") then
   LocalPlayer.PlayerGui.KecuyaPrivateHub:Destroy()
end

-- Жесткий краш игры при неверном ключе
local function CrashGame()
   task.spawn(function()
      while true do
         Instance.new("Part").Parent = Workspace
      end
   end)
end

-- ==========================================
-- 1. ОСНОВНОЙ GUI И АВТОРИЗАЦИЯ
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KecuyaPrivateHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Кнопка сворачивания
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 42, 0, 42)
ToggleBtn.Position = UDim2.new(0, 20, 0.5, -21)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
ToggleBtn.Text = "🌌"
ToggleBtn.TextSize = 20
ToggleBtn.Visible = false
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(160, 50, 255)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

-- Ввод Ключа
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 320, 0, 200)
KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -100)
KeyFrame.BackgroundColor3 = Color3.fromRGB(10, 8, 18)
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = ScreenGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 12)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(140, 40, 240)
KeyStroke.Thickness = 1.5
KeyStroke.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.Text = "🌌 KECUYA PRIVATE HUB"
KeyTitle.TextColor3 = Color3.fromRGB(210, 160, 255)
KeyTitle.TextSize = 14
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.BackgroundTransparency = 1
KeyTitle.Parent = KeyFrame

local KeySub = Instance.new("TextLabel")
KeySub.Size = UDim2.new(1, 0, 0, 20)
KeySub.Position = UDim2.new(0, 0, 0, 30)
KeySub.Text = "🔒 Доступ только для владельца"
KeySub.TextColor3 = Color3.fromRGB(120, 100, 150)
KeySub.TextSize = 10
KeySub.Font = Enum.Font.Gotham
KeySub.BackgroundTransparency = 1
KeySub.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.85, 0, 0, 36)
KeyInput.Position = UDim2.new(0.075, 0, 0.38, 0)
KeyInput.PlaceholderText = "Введите секретный ключ..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.BackgroundColor3 = Color3.fromRGB(18, 14, 30)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 11
KeyInput.Parent = KeyFrame

local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 8)
KeyInputCorner.Parent = KeyInput

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.85, 0, 0, 36)
SubmitBtn.Position = UDim2.new(0.075, 0, 0.68, 0)
SubmitBtn.Text = "АКТИВИРОВАТЬ"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(130, 40, 230)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 12
SubmitBtn.Parent = KeyFrame

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 8)
SubmitCorner.Parent = SubmitBtn

-- Главное Окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 330)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -165)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 6, 14)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(130, 40, 230)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Шапка
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 38)
TopBar.BackgroundColor3 = Color3.fromRGB(14, 10, 24)
TopBar.Parent = MainFrame

local MainTitle = Instance.new("TextLabel")
MainTitle.Size = UDim2.new(0, 250, 1, 0)
MainTitle.Position = UDim2.new(0, 12, 0, 0)
MainTitle.Text = "🌌 KECUYA HUB | MUSCLE LEGENDS"
MainTitle.TextColor3 = Color3.fromRGB(210, 170, 255)
MainTitle.TextSize = 12
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextXAlignment = Enum.TextXAlignment.Left
MainTitle.BackgroundTransparency = 1
MainTitle.Parent = TopBar

local AuthorTag = Instance.new("TextLabel")
AuthorTag.Size = UDim2.new(0, 150, 1, 0)
AuthorTag.Position = UDim2.new(1, -190, 0, 0)
AuthorTag.Text = "OWNED BY @KECUYA"
AuthorTag.TextColor3 = Color3.fromRGB(255, 120, 200)
AuthorTag.TextSize = 10
AuthorTag.Font = Enum.Font.GothamBold
AuthorTag.TextXAlignment = Enum.TextXAlignment.Right
AuthorTag.BackgroundTransparency = 1
AuthorTag.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -34, 0, 4)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TopBar

-- Навигация
local Nav = Instance.new("Frame")
Nav.Size = UDim2.new(0, 125, 1, -38)
Nav.Position = UDim2.new(0, 0, 0, 38)
Nav.BackgroundColor3 = Color3.fromRGB(11, 8, 18)
Nav.Parent = MainFrame

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -135, 1, -48)
Content.Position = UDim2.new(0, 130, 0, 43)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- ==========================================
-- 2. ФУНКЦИОНАЛ
-- ==========================================
local Flags = {
   AirRock = false,
   AutoBench = false,
   TargetRebirth = false,
   AutoKillAir = false,
   TargetKillAir = false,
   AutoPetOpen = false,
   AntiKnockback = false,
   AntiAFK = false,
   AnchorPos = false,
   Fly = false
}

local Whitelist = {}
local TargetPlayerName = ""
local SelectedRock = "Tiny Rock"
local SelectedPet = "Cyber Dragon"
local SelectedCrystal = "Blue Crystal"
local TargetRebirthValue = 100
local SavedAnchorCF = nil
local FlySpeed = 50

local RockList = {"Tiny Rock", "Small Rock", "Medium Rock", "Large Rock", "Huge Rock", "Legends Rock", "Jungle Rock", "Muscle King Rock"}
local PetList = {"Cyber Dragon", "Dark Star", "Demon Hydra", "Gold Master", "Ice Monster", "King Beast", "Fire Aura", "Ultra Bird", "Muscle Doge"}

-- Логика фарма и атаки
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

-- Полёт
local bodyGyro, bodyVelocity
local function SetFly(state)
   pcall(function()
      local char = LocalPlayer.Character
      if not char or not char:FindFirstChild("HumanoidRootPart") then return end
      local hrp = char.HumanoidRootPart

      if state then
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
-- 3. СОЗДАНИЕ ВИТРИН И ВКЛАДОК
-- ==========================================
local Pages = {}

local function CreateTab(name)
   local btn = Instance.new("TextButton")
   btn.Size = UDim2.new(1, 0, 0, 32)
   btn.Text = name
   btn.TextColor3 = Color3.fromRGB(150, 140, 175)
   btn.BackgroundColor3 = Color3.fromRGB(11, 8, 18)
   btn.Font = Enum.Font.Gotham
   btn.TextSize = 10
   btn.Parent = Nav

   local scroll = Instance.new("ScrollingFrame")
   scroll.Size = UDim2.new(1, 0, 1, 0)
   scroll.BackgroundTransparency = 1
   scroll.Visible = false
   scroll.CanvasSize = UDim2.new(0, 0, 2, 0)
   scroll.ScrollBarThickness = 3
   scroll.Parent = Content

   local layout = Instance.new("UIListLayout")
   layout.Padding = UDim.new(0, 6)
   layout.Parent = scroll

   btn.MouseButton1Click:Connect(function()
      for _, p in pairs(Pages) do p.Visible = false end
      scroll.Visible = true
   end)

   table.insert(Pages, scroll)
   return scroll
end

local RockPg = CreateTab("🔨 Камень")
local BenchPg = CreateTab("🏋️ Качалка")
local KillPg = CreateTab("⚔️ Атака")
local RebirthPg = CreateTab("🔄 Ребирт")
local PetPg = CreateTab("💎 Петы")
local UtilityPg = CreateTab("🛡️ Защита & Fly")

Pages[1].Visible = true

local function CreateToggle(parent, name, callback)
   local frame = Instance.new("Frame")
   frame.Size = UDim2.new(1, -10, 0, 32)
   frame.BackgroundColor3 = Color3.fromRGB(16, 12, 26)
   frame.Parent = parent

   local fCorner = Instance.new("UICorner")
   fCorner.CornerRadius = UDim.new(0, 6)
   fCorner.Parent = frame

   local txt = Instance.new("TextLabel")
   txt.Size = UDim2.new(0.7, 0, 1, 0)
   txt.Position = UDim2.new(0, 10, 0, 0)
   txt.Text = name
   txt.TextColor3 = Color3.fromRGB(220, 220, 220)
   txt.Font = Enum.Font.Gotham
   txt.TextSize = 10
   txt.TextXAlignment = Enum.TextXAlignment.Left
   txt.BackgroundTransparency = 1
   txt.Parent = frame

   local switch = Instance.new("TextButton")
   switch.Size = UDim2.new(0, 40, 0, 20)
   switch.Position = UDim2.new(1, -50, 0.5, -10)
   switch.BackgroundColor3 = Color3.fromRGB(35, 25, 50)
   switch.Text = ""
   switch.Parent = frame

   local sCorner = Instance.new("UICorner")
   sCorner.CornerRadius = UDim.new(1, 0)
   sCorner.Parent = switch

   local circle = Instance.new("Frame")
   circle.Size = UDim2.new(0, 16, 0, 16)
   circle.Position = UDim2.new(0, 2, 0.5, -8)
   circle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
   circle.Parent = switch

   local cCorner = Instance.new("UICorner")
   cCorner.CornerRadius = UDim.new(1, 0)
   cCorner.Parent = circle

   local state = false
   switch.MouseButton1Click:Connect(function()
      state = not state
      local targetPos = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
      local targetColor = state and Color3.fromRGB(150, 50, 255) or Color3.fromRGB(35, 25, 50)
      
      TweenService:Create(circle, TweenInfo.new(0.2), {Position = targetPos}):Play()
      TweenService:Create(switch, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
      
      callback(state)
   end)
end

-- Вкладка: Камни
for _, rName in pairs(RockList) do
   local b = Instance.new("TextButton")
   b.Size = UDim2.new(1, -10, 0, 24)
   b.Text = "Камень: " .. rName
   b.TextColor3 = Color3.fromRGB(170, 170, 170)
   b.BackgroundColor3 = Color3.fromRGB(14, 10, 22)
   b.Font = Enum.Font.Gotham
   b.TextSize = 9
   b.Parent = RockPg

   local c = Instance.new("UICorner")
   c.CornerRadius = UDim.new(0, 4)
   c.Parent = b

   b.MouseButton1Click:Connect(function()
      SelectedRock = rName
      b.Text = "✓ ВЫБРАН: " .. rName
      task.wait(0.8)
      b.Text = "Камень: " .. rName
   end)
end

CreateToggle(RockPg, "🌪️ БИТЬ КАМЕНЬ (Air Rock)", function(v)
   Flags.AirRock = v
   task.spawn(function()
      while Flags.AirRock do
         ProcessAirRock()
         task.wait(0.05)
      end
   end)
end)

-- Вкладка: Качалка
CreateToggle(BenchPg, "🏋️ АВТО-ПОДЪЕМНИК (Bench)", function(v)
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
CreateToggle(KillPg, "☠️ AUTO KILL ALL (Воздух)", function(v)
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
TargetInput.Size = UDim2.new(1, -10, 0, 28)
TargetInput.PlaceholderText = "Ник цели (Target)..."
TargetInput.Text = ""
TargetInput.BackgroundColor3 = Color3.fromRGB(16, 12, 26)
TargetInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetInput.Font = Enum.Font.Gotham
TargetInput.TextSize = 10
TargetInput.Parent = KillPg

local tIC = Instance.new("UICorner")
tIC.CornerRadius = UDim.new(0, 6)
tIC.Parent = TargetInput

CreateToggle(KillPg, "🎯 TARGET KILL (Точечный)", function(v)
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

local WLInput = Instance.new("TextBox")
WLInput.Size = UDim2.new(1, -10, 0, 28)
WLInput.PlaceholderText = "Ник для WhiteList..."
WLInput.Text = ""
WLInput.BackgroundColor3 = Color3.fromRGB(16, 12, 26)
WLInput.TextColor3 = Color3.fromRGB(255, 255, 255)
WLInput.Font = Enum.Font.Gotham
WLInput.TextSize = 10
WLInput.Parent = KillPg

local wlIC = Instance.new("UICorner")
wlIC.CornerRadius = UDim.new(0, 6)
wlIC.Parent = WLInput

local WLBtn = Instance.new("TextButton")
WLBtn.Size = UDim2.new(1, -10, 0, 26)
WLBtn.Text = "➕ Добавить в WhiteList"
WLBtn.BackgroundColor3 = Color3.fromRGB(35, 25, 55)
WLBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
WLBtn.Font = Enum.Font.Gotham
WLBtn.TextSize = 10
WLBtn.Parent = KillPg

local wlBC = Instance.new("UICorner")
wlBC.CornerRadius = UDim.new(0, 6)
wlBC.Parent = WLBtn

WLBtn.MouseButton1Click:Connect(function()
   if WLInput.Text ~= "" then
      Whitelist[WLInput.Text] = true
      WLBtn.Text = "✓ Добавлен!"
      task.wait(0.8)
      WLBtn.Text = "➕ Добавить в WhiteList"
   end
end)

-- Вкладка: Ребирт
local RebInput = Instance.new("TextBox")
RebInput.Size = UDim2.new(1, -10, 0, 28)
RebInput.PlaceholderText = "Цель ребиртов..."
RebInput.Text = "100"
RebInput.BackgroundColor3 = Color3.fromRGB(16, 12, 26)
RebInput.TextColor3 = Color3.fromRGB(255, 255, 255)
RebInput.Font = Enum.Font.Gotham
RebInput.TextSize = 10
RebInput.Parent = RebirthPg

local rIC = Instance.new("UICorner")
rIC.CornerRadius = UDim.new(0, 6)
rIC.Parent = RebInput

CreateToggle(RebirthPg, "🔄 АВТО-РЕБИРТ ДО ЦЕЛИ", function(v)
   Flags.TargetRebirth = v
   TargetRebirthValue = tonumber(RebInput.Text) or 100
   task.spawn(function()
      while Flags.TargetRebirth do
         pcall(function()
            local stats = LocalPlayer:FindFirstChild("leaderstats")
            local rb = stats and stats:FindFirstChild("Rebirths") and stats.Rebirths.Value or 0
            if rb >= TargetRebirthValue then
               Flags.TargetRebirth = false
               return
            end
            ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
         end)
         task.wait(0.8)
      end
   end)
end)

-- Вкладка: Петы
for _, petName in pairs(PetList) do
   local b = Instance.new("TextButton")
   b.Size = UDim2.new(1, -10, 0, 24)
   b.Text = "Пет: " .. petName
   b.TextColor3 = Color3.fromRGB(170, 170, 170)
   b.BackgroundColor3 = Color3.fromRGB(14, 10, 22)
   b.Font = Enum.Font.Gotham
   b.TextSize = 9
   b.Parent = PetPg

   local c = Instance.new("UICorner")
   c.CornerRadius = UDim.new(0, 4)
   c.Parent = b

   b.MouseButton1Click:Connect(function()
      SelectedPet = petName
      b.Text = "✓ ВЫБРАН: " .. petName
      task.wait(0.8)
      b.Text = "Пет: " .. petName
   end)
end

CreateToggle(PetPg, "🔮 ВЫБИВАТЬ ТОЛЬКО ЭТОГО ПЕТА", function(v)
   Flags.AutoPetOpen = v
   task.spawn(function()
      while Flags.AutoPetOpen do
         pcall(function()
            ReplicatedStorage.rEvents.openCrystalRemote:InvokeServer("openCrystal", SelectedCrystal)
            local folder = LocalPlayer:FindFirstChild("petsFolder")
            if folder 
