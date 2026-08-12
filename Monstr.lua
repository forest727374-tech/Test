-- // Muscle Legends Ultimate Hub + Air Rock Farm + Crystal Auto-Delete
-- // Разработано для всех инжекторов (Krampus, Solara, Wave, Delta и др.)

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Muscle Legends | Ultimate Hub",
   LoadingTitle = "Загрузка скрипта...",
   LoadingSubtitle = "by Assistant",
   ConfigurationSaving = { Enabled = false }
})

-- // Переменные
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local SelectedCrystal = "Blue Crystal"
local AutoOpenCrystal = false
local SelectedRock = "Tiny Rock"
local AutoRockAir = false

local AutoDeleteRarities = {
   Common = false,
   Uncommon = false,
   Rare = false,
   Epic = false
}

local Flags = {
   AutoFarm = false,
   AutoPushups = false,
   AutoSitups = false,
   AutoRebirth = false,
   AutoPunch = false,
   FlingOnPunch = false
}

-- // Списки
local CrystalList = {
   "Blue Crystal", "Green Crystal", "Frost Crystal", 
   "Mythical Crystal", "Inferno Crystal", "Legends Crystal", "Muscle King Crystal"
}

local RockList = {
   "Tiny Rock", "Small Rock", "Medium Rock", 
   "Large Rock", "Huge Rock", "Legends Rock"
}

-- // Функция Fling при ударе
local function ApplyFling(targetChar)
   if not targetChar then return end
   local hrp = targetChar:FindFirstChild("HumanoidRootPart")
   if hrp then
      local bvl = Instance.new("BodyVelocity")
      bvl.Name = "FlingForce"
      bvl.Velocity = Vector3.new(math.random(-10000, 10000), 100000, math.random(-10000, 10000))
      bvl.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
      bvl.P = 125000
      bvl.Parent = hrp
      
      local bav = Instance.new("BodyAngularVelocity")
      bav.Name = "FlingSpin"
      bav.AngularVelocity = Vector3.new(0, 99999, 0)
      bav.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
      bav.Parent = hrp

      task.delay(0.2, function()
         bvl:Destroy()
         bav:Destroy()
      end)
   end
end

-- Хук на удар (Punch Fling)
RunService.Stepped:Connect(function()
   if Flags.FlingOnPunch and LocalPlayer.Character then
      local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
      if tool and (tool.Name:find("Punch") or tool.Name:find("Hand")) then
         for _, part in pairs(tool:GetChildren()) do
            if part:IsA("BasePart") then
               part.Touched:Connect(function(hit)
                  if Flags.FlingOnPunch and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
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

-- Авто-удаление ненужных петов
local function CheckAndAutoDeletePets()
   local petsFolder = LocalPlayer:FindFirstChild("petsFolder")
   if not petsFolder then return end

   for _, petFolder in pairs(petsFolder:GetChildren()) do
      for _, pet in pairs(petFolder:GetChildren()) do
         local rarity = pet:FindFirstChild("Rarity") or pet:FindFirstChild("rarity")
         if rarity and AutoDeleteRarities[rarity.Value] then
            ReplicatedStorage.rEvents.sellPetRemote:FireServer(pet)
         end
      end
   end
end

-- Поиск и подтяжка камня
local function FarmAirRock()
   local rockToFarm = nil
   for _, obj in pairs(Workspace:GetChildren()) do
      if obj.Name:find(SelectedRock) or (obj:FindFirstChild("Rock") and obj.Name:find("Rock")) then
         rockToFarm = obj
         break
      end
   end

   if rockToFarm and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
      local hrp = LocalPlayer.Character.HumanoidRootPart
      
      -- Делаем так, чтобы удары засчитывались по серверу (Бьем в воздухе)
      if rockToFarm:IsA("Model") and rockToFarm.PrimaryPart then
         rockToFarm:SetPrimaryPartCFrame(hrp.CFrame * CFrame.new(0, 0, -2))
      elseif rockToFarm:IsA("BasePart") then
         rockToFarm.CFrame = hrp.CFrame * CFrame.new(0, 0, -2)
      end

      -- Авто-удар по камню
      local punch = LocalPlayer.Backpack:FindFirstChild("Punch") or LocalPlayer.Character:FindFirstChild("Punch")
      if punch then
         punch.Parent = LocalPlayer.Character
         punch:Activate()
      end
   end
end

-- // ВКЛАДКИ
local MainTab = Window:CreateTab("Фарм Камней & Воздух", 4483362458)
local CrystalTab = Window:CreateTab("Кристаллы & Петы", 4483362458)
local CombatTab = Window:CreateTab("Бой & Fling", 4483362458)
local TeleportTab = Window:CreateTab("Телепорты", 4483362458)
local MiscTab = Window:CreateTab("Разное", 4483362458)

-- // MAIN TAB
MainTab:CreateDropdown({
   Name = "Выбери Камень для Битья",
   Options = RockList,
   CurrentOption = "Tiny Rock",
   Callback = function(Option)
      SelectedRock = Option[1] or Option
   end,
})

MainTab:CreateToggle({
   Name = "🌪️ БИТЬ КАМЕНЬ ПО ВОЗДУХУ (Air Rock Farm)",
   CurrentValue = false,
   Callback = function(Value)
      AutoRockAir = Value
      task.spawn(function()
         while AutoRockAir do
            FarmAirRock()
            task.wait(0.05)
         end
      end)
   end,
})

MainTab:CreateSection("Классический фарм")

MainTab:CreateToggle({
   Name = "Auto Weight (Качать силу)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.AutoFarm = Value
      task.spawn(function()
         while Flags.AutoFarm do
            local weight = LocalPlayer.Backpack:FindFirstChild("Weight") or LocalPlayer.Character:FindFirstChild("Weight")
            if weight then
               weight.Parent = LocalPlayer.Character
               weight:Activate()
            end
            task.wait(0.1)
         end
      end)
   end,
})

MainTab:CreateToggle({
   Name = "Auto Pushups (Отжимания)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.AutoPushups = Value
      task.spawn(function()
         while Flags.AutoPushups do
            local pushups = LocalPlayer.Backpack:FindFirstChild("Pushups") or LocalPlayer.Character:FindFirstChild("Pushups")
            if pushups then
               pushups.Parent = LocalPlayer.Character
               pushups:Activate()
            end
            task.wait(0.1)
         end
      end)
   end,
})

MainTab:CreateToggle({
   Name = "Auto Rebirth (Авто-Перерождение)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.AutoRebirth = Value
      task.spawn(function()
         while Flags.AutoRebirth do
            ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            task.wait(1)
         end
      end)
   end,
})

-- // CRYSTAL TAB
CrystalTab:CreateDropdown({
   Name = "Выбери Кристалл для открытия",
   Options = CrystalList,
   CurrentOption = "Blue Crystal",
   Callback = function(Option)
      SelectedCrystal = Option[1] or Option
   end,
})

CrystalTab:CreateToggle({
   Name = "Auto Open Crystal (Авто-Открытие)",
   CurrentValue = false,
   Callback = function(Value)
      AutoOpenCrystal = Value
      task.spawn(function()
         while AutoOpenCrystal do
            ReplicatedStorage.rEvents.openCrystalRemote:InvokeServer("openCrystal", SelectedCrystal)
            CheckAndAutoDeletePets()
            task.wait(0.5)
         end
      end)
   end,
})

CrystalTab:CreateSection("Фильтр Авто-Удаления (Продавать ненужных)")

CrystalTab:CreateToggle({
   Name = "Удалять Common (Обычные)",
   CurrentValue = false,
   Callback = function(Value)
      AutoDeleteRarities.Common = Value
   end,
})

CrystalTab:CreateToggle({
   Name = "Удалять Uncommon (Необычные)",
   CurrentValue = false,
   Callback = function(Value)
      AutoDeleteRarities.Uncommon = Value
   end,
})

CrystalTab:CreateToggle({
   Name = "Удалять Rare (Редкие)",
   CurrentValue = false,
   Callback = function(Value)
      AutoDeleteRarities.Rare = Value
   end,
})

CrystalTab:CreateToggle({
   Name = "Удалять Epic (Эпические)",
   CurrentValue = false,
   Callback = function(Value)
      AutoDeleteRarities.Epic = Value
   end,
})

-- // COMBAT TAB
CombatTab:CreateToggle({
   Name = "🔥 PUNCH FLING (Улёт при ударе)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.FlingOnPunch = Value
   end,
})

CombatTab:CreateToggle({
   Name = "Auto Punch (Авто-Удар)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.AutoPunch = Value
      task.spawn(function()
         while Flags.AutoPunch do
            local punch = LocalPlayer.Backpack:FindFirstChild("Punch") or LocalPlayer.Character:FindFirstChild("Punch")
            if punch then
               punch.Parent = LocalPlayer.Character
               punch:Activate()
            end
            task.wait(0.1)
         end
      end)
   end,
})

-- // TELEPORT TAB
TeleportTab:CreateButton({
   Name = "Спавн (Main Island)",
   Callback = function()
      LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2, 8, 115)
   end,
})

TeleportTab:CreateButton({
   Name = "Frost Gym (5 Rebirths)",
   Callback = function()
      LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2600, 15, -600)
   end,
})

-- // MISC TAB
MiscTab:CreateSlider({
   Name = "Скорость ходьбы (WalkSpeed)",
   Range = {16, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Callback = function(Value)
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
         LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

MiscTab:CreateButton({
   Name = "Безопасная зона (Anti-PK)",
   Callback = function()
      LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 5000, 0)
      local platform = Instance.new("Part", workspace)
      platform.Size = Vector3.new(100, 5, 100)
      platform.CFrame = CFrame.new(0, 4995, 0)
      platform.Anchored = true
   end,
})

Rayfield:Notify({
   Title = "Успешно!",
   Content = "Скрипт загружен! Вкладка 'Фарм Камней' готова.",
   Duration = 4,
})
