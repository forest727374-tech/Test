-- // Muscle Legends Galaxy Hub - Complete & Refined Edition
-- // Key: Guest666

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")

local CorrectKey = "Guest666"

-- Очистка старой версии GUI
if LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("GalaxyUltimateHub") then
   LocalPlayer.PlayerGui.GalaxyUltimateHub:Destroy()
end

-- ==========================================
-- 1. КОМПАКТНЫЙ ТЁМНЫЙ GUI
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GalaxyUltimateHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Кнопка Сворачивания
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 38, 0, 38)
ToggleBtn.Position = UDim2.new(0, 15, 0.5, -19)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
ToggleBtn.Text = "🌌"
ToggleBtn.TextSize = 18
ToggleBtn.Visible = false
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(130, 50, 230)
ToggleStroke.Thickness = 1.5
ToggleStroke.Parent = ToggleBtn

-- Ввод Ключа
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 300, 0, 180)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
KeyFrame.BackgroundColor3 = Color3.fromRGB(12, 9, 20)
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = ScreenGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 10)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(120, 40, 220)
KeyStroke.Thickness = 1.5
KeyStroke.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.Text = "🌌 GALAXY HUB | АВТОРИЗАЦИЯ"
KeyTitle.TextColor3 = Color3.fromRGB(190, 150, 255)
KeyTitle.TextSize = 13
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.BackgroundTransparency = 1
KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.85, 0, 0, 34)
KeyInput.Position = UDim2.new(0.075, 0, 0.35, 0)
KeyInput.PlaceholderText = "Введите ключ..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.BackgroundColor3 = Color3.fromRGB(20, 15, 32)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 12
KeyInput.Parent = KeyFrame

local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 6)
KeyInputCorner.Parent = KeyInput

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.85, 0, 0, 34)
SubmitBtn.Position = UDim2.new(0.075, 0, 0.65, 0)
SubmitBtn.Text = "ВХОД"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(110, 35, 200)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 12
SubmitBtn.Parent = KeyFrame

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 6)
SubmitCorner.Parent = SubmitBtn

-- Главное Окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 480, 0, 310)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -155)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 8, 16)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(110, 40, 210)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Шапка
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 34)
TopBar.BackgroundColor3 = Color3.fromRGB(16, 12, 26)
TopBar.Parent = MainFrame

local MainTitle = Instance.new("TextLabel")
MainTitle.Size = UDim2.new(1, -40, 1, 0)
MainTitle.Position = UDim2.new(0, 12, 0, 0)
MainTitle.Text = "✨ MUSCLE LEGENDS GALAXY HUB"
MainTitle.TextColor3 = Color3.fromRGB(200, 160, 255)
MainTitle.TextSize = 13
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextXAlignment = Enum.TextXAlignment.Left
MainTitle.BackgroundTransparency = 1
MainTitle.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -30, 0, 3)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TopBar

-- Навигация
local Nav = Instance.new("Frame")
Nav.Size = UDim2.new(0, 120, 1, -34)
Nav.Position = UDim2.new(0, 0, 0, 34)
Nav.BackgroundColor3 = Color3.fromRGB(13, 10, 20)
Nav.Parent = MainFrame

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -130, 1, -42)
Content.Position = UDim2.new(0, 125, 0, 38)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- ==========================================
-- 2. ФУНКЦИОНАЛ И СОСТОЯНИЯ
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

-- 1) AIR ROCK FARM (Оптимизированный безопасный метод)
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

-- 2) AUTO KILL / TARGET KILL
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

-- 3) FLY (Полёт WASD)
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

-- 4) АНТИ-ОТБРАСЫВАНИЕ & ANCHOR
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

-- 5) ANTI-AFK
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
-- 3. ВКЛАДКИ И КНОПКИ
-- ==========================================
local Pages = {}

local function CreateTab(name)
   local btn = Instance.new("TextButton")
   btn.Size = UDim2.new(1, 0, 0, 30)
   btn.Text = name
   btn.TextColor3 = Color3.fromRGB(160, 150, 185)
   btn.BackgroundColor3 = Color3.fromRGB(13, 10, 20)
   btn.Font = Enum.Font.Gotham
   btn.TextSize = 10
   btn.Parent = Nav

   local scroll = Instance.new("ScrollingFrame")
   scroll.Size = UDim2.new(1, 0, 1, 0)
   scroll.BackgroundTransparency = 1
   scroll.Visible = false
   scroll.CanvasSize = UDim2.new(0, 0, 2, 0)
   scroll.ScrollBarThickness = 2
   scroll.Parent = Content

   local layout = Instance.new("UIListLayout")
   layout.Padding = UDim.new(0, 5)
   layout.Parent = scroll

   btn.MouseButton1Click:Connect(function()
      for _, p in pairs(Pages) do p.Visible = false end
      scroll.Visible = true
   end)

   table.insert(Pages, scroll)
   return scroll
end

local RockPg = CreateTab("🔨 Камень")
local BenchPg = CreateTab("🏋️ Подъемник")
local KillPg = CreateTab("⚔️ Атака")
local UtilityPg = CreateTab("🛡️ Защита & Fly")
local RebirthPg = CreateTab("🔄 Ребирт")
local PetPg = CreateTab("💎 Петы")

Pages[1].Visible = true

local function CreateToggle(parent, name, callback)
   local btn = Instance.new("TextButton")
   btn.Size = UDim2.new(1, -10, 0, 28)
   btn.Text = name .. " [ВЫКЛ]"
   btn.TextColor3 = Color3.fromRGB(240, 240, 240)
   btn.BackgroundColor3 = Color3.fromRGB(22, 18, 32)
   btn.Font = Enum.Font.Gotham
   btn.TextSize = 10
   btn.Parent = parent

   local corner = Instance.new("UICorner")
   corner.CornerRadius = UDim.new(0, 5)
   corner.Parent = btn

   local active = false
   btn.MouseButton1Click:Connect(function()
      active = not active
      btn.Text = name .. (active and " [ВКЛ]" or " [ВЫКЛ]")
      btn.BackgroundColor3 = active and Color3.fromRGB(110, 35, 200) or Color3.fromRGB(22, 18, 32)
      callback(active)
   end)
end

-- --- 1. КАМНИ ---
for _, rName in pairs(RockList) do
   local b = Instance.new("TextButton")
   b.Size = UDim2.new(1, -10, 0, 22)
   b.Text = "Камень: " .. rName
   b.TextColor3 = Color3.fromRGB(180, 180, 180)
   b.BackgroundColor3 = Color3.fromRGB(16, 12, 24)
   b.Font = Enum.Font.Gotham
   b.TextSize = 9
   b.Parent = RockPg

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

-- --- 2. ПОДЪЕМНИК ---
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

-- --- 3. АТАКА ---
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
TargetInput.Size = UDim2.new(1, -10, 0, 26)
TargetInput.PlaceholderText = "Ник цели (Target)..."
TargetInput.Text = ""
TargetInput.BackgroundColor3 = Color3.fromRGB(20, 16, 28)
TargetInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetInput.Font = Enum.Font.Gotham
TargetInput.TextSize = 10
TargetInput.Parent = KillPg

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
WLInput.Size = UDim2.new(1, -10, 0, 26)
WLInput.PlaceholderText = "Ник для WhiteList..."
WLInput.Text = ""
WLInput.BackgroundColor3 = Color3.fromRGB(20, 16, 28)
WLInput.TextColor3 = Color3.fromRGB(255, 255, 255)
WLInput.Font = Enum.Font.Gotham
WLInput.TextSize = 10
WLInput.Parent = KillPg

local WLBtn = Instance.new("TextButton")
WLBtn.Size = UDim2.new(1, -10, 0, 24)
WLBtn.Text = "➕ Добавить в WhiteList"
WLBtn.BackgroundColor3 = Color3.fromRGB(35, 25, 55)
WLBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
WLBtn.Font = Enum.Font.Gotham
WLBtn.TextSize = 10
WLBtn.Parent = KillPg

WLBtn.MouseButton1Click:Connect(function()
   if WLInput.Text ~= "" then
      Whitelist[WLInput.Text] = true
      WLBtn.Text = "✓ Добавлен!"
      task.wait(0.8)
      WLBtn.Text = "➕ Добавить в WhiteList"
   end
end)

-- --- 4. ЗАЩИТА & FLY ---
CreateToggle(UtilityPg, "🛸 FLY (WASD Полёт)", function(v)
   Flags.Fly = v
   SetFly(v)
end)

CreateToggle(UtilityPg, "🛡️ ANTI-KNOCKBACK", function(v) Flags.AntiKnockback = v end)
CreateToggle(UtilityPg, "📌 ЗАКРЕПИТЬСЯ (Anchor)", function(v) Flags.AnchorPos = v end)
CreateToggle(UtilityPg, "⚡ ANTI-AFK", function(v) Flags.AntiAFK = v end)

-- --- 5. РЕБИРТ ---
local RebInput = Instance.new("TextBox")
RebInput.Size = UDim2.new(1, -10, 0, 26)
RebInput.PlaceholderText = "Цель ребиртов..."
RebInput.Text = "100"
RebInput.BackgroundColor3 = Color3.fromRGB(20, 16, 28)
RebInput.TextColor3 = Color3.fromRGB(255, 255, 255)
RebInput.Font = Enum.Font.Gotham
RebInput.TextSize = 10
RebInput.Parent = RebirthPg

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

-- --- 6. ПЕТЫ ---
for _, petName in pairs(PetList) do
   local b = Instance.new("TextButton")
   b.Size = UDim2.new(1, -10, 0, 22)
   b.Text = "Пет: " .. petName
   b.TextColor3 = Color3.fromRGB(180, 180, 180)
   b.BackgroundColor3 = Color3.fromRGB(16, 12, 24)
   b.Font = Enum.Font.Gotham
   b.TextSize = 9
   b.Parent = PetPg

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
            if folder then
               for _, f in pairs(folder:GetChildren()) do
                  for _, pet in pairs(f:GetChildren()) do
                     if pet.Name:lower() ~= SelectedPet:lower() then
                        ReplicatedStorage.rEvents.sellPetRemote:FireServer(pet)
                     end
                  end
               end
            end
         end)
         task.wait(0.5)
      end
   end)
end)

-- --- КНОПКИ АВТОРИЗАЦИИ И СВОРАЧИВАНИЯ ---
SubmitBtn.MouseButton1Click:Connect(function()
   if KeyInput.Text == CorrectKey then
      KeyFrame:Destroy()
      MainFrame.Visible = true
      ToggleBtn.Visible = true
   else
      KeyInput.Text = ""
      KeyInput.PlaceholderText = "НЕВЕРНЫЙ КЛЮЧ!"
   end
end)

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
