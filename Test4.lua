-- // Muscle Legends Premium Hub by @kecuya
-- // Key: Guest666

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- ==========================================
-- 1. СИСТЕМА КЛЮЧА И ИНТЕРФЕЙС
-- ==========================================
local KeyVerified = false
local CorrectKey = "Guest666"

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KecuyaHub_Gui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Окно ввода ключа
local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.new(0, 350, 0, 220)
KeyFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
KeyFrame.BorderSizePixel = 0
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = ScreenGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 10)
KeyCorner.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.Text = "Muscle Legends Hub | @kecuya"
KeyTitle.TextColor3 = Color3.fromRGB(0, 170, 255)
KeyTitle.TextSize = 18
KeyTitle.Font = Enum.Font.SourceSansBold
KeyTitle.BackgroundTransparency = 1
KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.8, 0, 0, 40)
KeyInput.Position = UDim2.new(0.1, 0, 0.3, 0)
KeyInput.PlaceholderText = "Введите ключ..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
KeyInput.BorderSizePixel = 0
KeyInput.TextSize = 16
KeyInput.Font = Enum.Font.SourceSans
KeyInput.Parent = KeyFrame

local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 6)
KeyInputCorner.Parent = KeyInput

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 40)
SubmitBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
SubmitBtn.Text = "Submit / Подтвердить"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 230)
SubmitBtn.BorderSizePixel = 0
SubmitBtn.TextSize = 16
SubmitBtn.Font = Enum.Font.SourceSansBold
SubmitBtn.Parent = KeyFrame

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 6)
SubmitCorner.Parent = SubmitBtn

-- Главное Меню (Скрыто до ввода ключа)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 380)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 10)
TopBarCorner.Parent = TopBar

local MainTitle = Instance.new("TextLabel")
MainTitle.Size = UDim2.new(1, -20, 1, 0)
MainTitle.Position = UDim2.new(0, 15, 0, 0)
MainTitle.Text = "🔥 Muscle Legends Hub | Author: @kecuya"
MainTitle.TextColor3 = Color3.fromRGB(0, 185, 255)
MainTitle.TextSize = 17
MainTitle.Font = Enum.Font.SourceSansBold
MainTitle.TextXAlignment = Enum.TextXAlignment.Left
MainTitle.BackgroundTransparency = 1
MainTitle.Parent = TopBar

-- Панель вкладок (Слева)
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(0, 130, 1, -40)
TabBar.Position = UDim2.new(0, 0, 0, 40)
TabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -140, 1, -50)
Container.Position = UDim2.new(0, 135, 0, 45)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

-- ==========================================
-- 2. ПЕРЕМЕННЫЕ И ЛОГИКА СКРИПТА
-- ==========================================
local Flags = {
   AirRock = false,
   Fling = false,
   AutoKillAir = false,
   AutoRebirthTarget = false,
   AutoOpenPet = false
}

local SelectedRock = "Tiny Rock"
local TargetRebirths = 0
local TargetPetName = "Cyber Dragon"
local SelectedCrystal = "Blue Crystal"

local RockList = {
   "Tiny Rock", "Small Rock", "Medium Rock", 
   "Large Rock", "Huge Rock", "Legends Rock", 
   "Jungle Rock", "Muscle King Rock"
}

local CrystalList = {
   "Blue Crystal", "Green Crystal", "Frost Crystal", 
   "Mythical Crystal", "Inferno Crystal", "Legends Crystal", "Muscle King Crystal"
}

-- ==========================================
-- 3. ОСНОВНЫЕ ФУНКЦИИ
-- ==========================================

-- 1) AIR ROCK FARM (Спавн строго спереди)
local function ProcessAirRock()
   local char = LocalPlayer.Character
   if not char or not char:FindFirstChild("HumanoidRootPart") then return end
   local hrp = char.HumanoidRootPart

   local rockModel = nil
   for _, v in pairs(Workspace:GetChildren()) do
      if v.Name:lower():find(SelectedRock:lower()) or (v:FindFirstChild("Rock") and v.Name:find("Rock")) then
         rockModel = v
         break
      end
   end

   if rockModel then
      -- Отключаем коллизию у частей камня, чтобы он не сталкивал игрока
      for _, part in pairs(rockModel:GetDescendants()) do
         if part:IsA("BasePart") then
            part.CanCollide = false
         end
      end

      -- Телепортируем строго впереди персонажа на 2.5 единицы
      local frontCFrame = hrp.CFrame * CFrame.new(0, 0, -2.5)

      if rockModel:IsA("Model") then
         if rockModel.PrimaryPart then
            rockModel:SetPrimaryPartCFrame(frontCFrame)
         else
            for _, p in pairs(rockModel:GetChildren()) do
               if p:IsA("BasePart") then
                  p.CFrame = frontCFrame
                  break
               end
            end
         end
      elseif rockModel:IsA("BasePart") then
         rockModel.CFrame = frontCFrame
      end

      -- Удар
      local punch = LocalPlayer.Backpack:FindFirstChild("Punch") or char:FindFirstChild("Punch")
      if punch then
         punch.Parent = char
         punch:Activate()
      end
   end
end

-- 2) PUNCH FLING
local function ApplyFling(targetChar)
   if not targetChar then return end
   local hrp = targetChar:FindFirstChild("HumanoidRootPart")
   if hrp then
      local bvl = Instance.new("BodyVelocity")
      bvl.Name = "FlingForce"
      bvl.Velocity = Vector3.new(math.random(-50000, 50000), 250000, math.random(-50000, 50000))
      bvl.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
      bvl.P = 1000000
      bvl.Parent = hrp

      local bav = Instance.new("BodyAngularVelocity")
      bav.AngularVelocity = Vector3.new(999999, 999999, 999999)
      bav.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
      bav.Parent = hrp

      task.delay(0.2, function()
         bvl:Destroy()
         bav:Destroy()
      end)
   end
end

RunService.Stepped:Connect(function()
   if Flags.Fling and LocalPlayer.Character then
      local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
      if tool and (tool.Name:find("Punch") or tool.Name:find("Hand")) then
         for _, part in pairs(tool:GetChildren()) do
            if part:IsA("BasePart") then
               part.Touched:Connect(function(hit)
                  if Flags.Fling and hit.Parent and hit.Parent:FindFirstChildOfClass("Humanoid") then
                     local targetPlayer = Players:GetPlayerFromCharacter(hit.Parent)
                     if targetPlayer and targetPlayer ~= LocalPlayer then
                        ApplyFling(hit.Parent)
                     end
                  end
               end)
            end
         end
      end
   end
end)

-- 3) AUTO KILL ПО ВОЗДУХУ (Бьем дальнобойными событиями)
local function ProcessAutoKillAir()
   local char = LocalPlayer.Character
   if not char then return end
   
   local punch = LocalPlayer.Backpack:FindFirstChild("Punch") or char:FindFirstChild("Punch")
   if punch then
      punch.Parent = char
      punch:Activate()
   end

   for _, p in pairs(Players:GetPlayers()) do
      if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
         -- Посылаем физический импульс кастомного урона через вызов тула
         if char:FindFirstChild("Punch") and char.Punch:FindFirstChild("LeftHand") then
            firetouchinterest(char.Punch.LeftHand, p.Character.HumanoidRootPart, 0)
            firetouchinterest(char.Punch.LeftHand, p.Character.HumanoidRootPart, 1)
         end
      end
   end
end

-- 4) АВТО КРИСТАЛЛЫ + УДАЛЕНИЕ ВСЕХ ПЕТОВ, КРОМЕ ВЫБРАННОГО
local function ProcessPetOpening()
   ReplicatedStorage.rEvents.openCrystalRemote:InvokeServer("openCrystal", SelectedCrystal)
   
   local petsFolder = LocalPlayer:FindFirstChild("petsFolder")
   if petsFolder then
      for _, folder in pairs(petsFolder:GetChildren()) do
         for _, pet in pairs(folder:GetChildren()) do
            -- Если имя пета НЕ совпадает с выбранным — удаляем
            if pet.Name:lower() ~= TargetPetName:lower() then
               ReplicatedStorage.rEvents.sellPetRemote:FireServer(pet)
            end
         end
      end
   end
end

-- ==========================================
-- 4. ПОДТВЕРЖДЕНИЕ КЛЮЧА И ВКЛАДКИ
-- ==========================================
SubmitBtn.MouseButton1Click:Connect(function()
   if KeyInput.Text == CorrectKey then
      KeyVerified = true
      KeyFrame:Destroy()
      MainFrame.Visible = true
   else
      KeyInput.Text = ""
      KeyInput.PlaceholderText = "НЕВЕРНЫЙ КЛЮЧ!"
   end
end)

-- Создание функциональных кнопок UI
local Pages = {}

local function CreateTab(name)
   local btn = Instance.new("TextButton")
   btn.Size = UDim2.new(1, 0, 0, 35)
   btn.Text = name
   btn.TextColor3 = Color3.fromRGB(180, 180, 190)
   btn.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
   btn.BorderSizePixel = 0
   btn.Font = Enum.Font.SourceSansBold
   btn.TextSize = 14
   btn.Parent = TabBar

   local page = Instance.new("ScrollingFrame")
   page.Size = UDim2.new(1, 0, 1, 0)
   page.BackgroundTransparency = 1
   page.Visible = false
   page.CanvasSize = UDim2.new(0, 0, 2, 0)
   page.ScrollBarThickness = 3
   page.Parent = Container

   local layout = Instance.new("UIListLayout")
   layout.Padding = UDim.new(0, 8)
   layout.Parent = page

   btn.MouseButton1Click:Connect(function()
      for _, p in pairs(Pages) do p.Visible = false end
      page.Visible = true
   end)

   table.insert(Pages, page)
   return page
end

local RockPage = CreateTab("Камни")
local CombatPage = CreateTab("Бой & Fling")
local RebirthPage = CreateTab("Ребирт Target")
local PetPage = CreateTab("Пет открывание")

Pages[1].Visible = true

-- --- ВКЛАДКА: КАМНИ ---
local function CreateToggle(parent, text, callback)
   local tBtn = Instance.new("TextButton")
   tBtn.Size = UDim2.new(1, -10, 0, 35)
   tBtn.Text = text .. " [ВЫКЛ]"
   tBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
   tBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
   tBtn.BorderSizePixel = 0
   tBtn.Font = Enum.Font.SourceSans
   tBtn.TextSize = 15
   tBtn.Parent = parent

   local c = Instance.new("UICorner")
   c.CornerRadius = UDim.new(0, 6)
   c.Parent = tBtn

   local enabled = false
   tBtn.MouseButton1Click:Connect(function()
      enabled = not enabled
      tBtn.Text = text .. (enabled and " [ВКЛ]" or " [ВЫКЛ]")
      tBtn.BackgroundColor3 = enabled and Color3.fromRGB(0, 150, 220) or Color3.fromRGB(30, 30, 40)
      callback(enabled)
   end)
end

-- Выбор камня
for _, rockName in pairs(RockList) do
   local rBtn = Instance.new("TextButton")
   rBtn.Size = UDim2.new(1, -10, 0, 30)
   rBtn.Text = "Выбрать: " .. rockName
   rBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
   rBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 33)
   rBtn.BorderSizePixel = 0
   rBtn.Parent = RockPage

   rBtn.MouseButton1Click:Connect(function()
      SelectedRock = rockName
      rBtn.Text = " ВЫБРАНО: " .. rockName
      task.wait(1)
      rBtn.Text = "Выбрать: " .. rockName
   end)
end

CreateToggle(RockPage, "🌪️ БИТЬ КАМЕНЬ СПЕРЕДИ (Air Rock)", function(val)
   Flags.AirRock = val
   task.spawn(function()
      while Flags.AirRock do
         ProcessAirRock()
         task.wait(0.03)
      end
   end)
end)

-- --- ВКЛАДКА: БОЙ & FLING ---
CreateToggle(CombatPage, "💥 PUNCH FLING (Улёт при ударе)", function(val)
   Flags.Fling = val
end)

CreateToggle(CombatPage, "☠️ AUTO KILL ПО ВОЗДУХУ (Без телепортов)", function(val)
   Flags.AutoKillAir = val
   task.spawn(function()
      while Flags.AutoKillAir do
         ProcessAutoKillAir()
         task.wait(0.1)
      end
   end)
end)

-- --- ВКЛАДКА: РЕБИРТ TARGET ---
local RebirthInput = Instance.new("TextBox")
RebirthInput.Size = UDim2.new(1, -10, 0, 35)
RebirthInput.PlaceholderText = "Введи нужное кол-во ребиртов (Число)..."
RebirthInput.Text = ""
RebirthInput.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
RebirthInput.TextColor3 = Color3.fromRGB(255, 255, 255)
RebirthInput.Parent = RebirthPage

CreateToggle(RebirthPage, "🔄 AUTO REBIRTH ДО ЦЕЛИ", function(val)
   Flags.AutoRebirthTarget = val
   TargetRebirths = tonumber(RebirthInput.Text) or 0
   
   task.spawn(function()
      while Flags.AutoRebirthTarget do
         local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
         local currentRebirths = leaderstats and leaderstats:FindFirstChild("Rebirths") and leaderstats.Rebirths.Value or 0
         
         if currentRebirths >= TargetRebirths then
            Flags.AutoRebirthTarget = false
            break
         end
         
         ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
         task.wait(1)
      end
   end)
end)

-- --- ВКЛАДКА: ПЕТЫ ---
local PetInput = Instance.new("TextBox")
PetInput.Size = UDim2.new(1, -10, 0, 35)
PetInput.PlaceholderText = "Введи ТОЧНОЕ имя нужного пета..."
PetInput.Text = ""
PetInput.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
PetInput.TextColor3 = Color3.fromRGB(255, 255, 255)
PetInput.Parent = PetPage

CreateToggle(PetPage, "🔮 АВТО-ОТКРЫТИЕ (Оставлять ТОЛЬКО выбранного)", function(val)
   Flags.AutoOpenPet = val
   if PetInput.Text ~= "" then TargetPetName = PetInput.Text end

   task.spawn(function()
      while Flags.AutoOpenPet do
         ProcessPetOpening()
         task.wait(0.4)
      end
   end)
end)
