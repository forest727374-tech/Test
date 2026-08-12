-- // Muscle Legends Hub by @kecuya (с Key System)
-- // Roblox Script

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Muscle Legends | Hub by @kecuya",
   LoadingTitle = "Загрузка скрипта...",
   LoadingSubtitle = "by @kecuya",
   ConfigurationSaving = { Enabled = false },
   KeySystem = true, -- Включение системы ключа
   KeySettings = {
      Title = "Muscle Legends | Key System",
      Subtitle = "Система защиты by @kecuya",
      Note = "Введите ключ доступа чтобы продолжить",
      FileName = "KecuyaHubKey",
      SaveKey = true, -- Запоминает ключ, чтобы не вводить каждый раз
      GrabKeyFromSite = false,
      Key = {"Guest666"} -- Твой ключ доступа
   }
})

-- // Сервисы
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- // Переменные состояния
local SelectedCrystal = "Blue Crystal"
local AutoOpenCrystal = false
local SelectedRock = "Tiny Rock"
local AutoRockAir = false

local SelectedTargetPlayer = ""
local WhitelistedPlayers = {}
local DesiredPets = {
   ["Common"] = false,
   ["Uncommon"] = false,
   ["Rare"] = false,
   ["Epic"] = false,
   ["Legendary"] = true
}

local Flags = {
   AutoFarm = false,
   AutoPushups = false,
   AutoSitups = false,
   AutoRebirth = false,
   AutoPunch = false,
   FlingOnPunch = false,
   AutoKillAll = false,
   TargetKill = false
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

-- // Обновление списка игроков
local function GetPlayerNames()
   local names = {}
   for _, p in pairs(Players:GetPlayers()) do
      if p ~= LocalPlayer then
         table.insert(names, p.Name)
      end
   end
   if #names == 0 then table.insert(names, "Нет других игроков") end
   return names
end

-- // Рабочая функция Fling
local function ApplyFling(targetChar)
   if not targetChar then return end
   local hrp = targetChar:FindFirstChild("HumanoidRootPart")
   local hum = targetChar:FindFirstChildOfClass("Humanoid")
   
   if hrp and hum then
      hum.PlatformStand = true
      
      -- Импульс
      local bv = Instance.new("BodyVelocity")
      bv.Name = "FlingForce"
      bv.Velocity = Vector3.new(math.random(-20000, 20000), 200000, math.random(-20000, 20000))
      bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
      bv.P = 500000
      bv.Parent = hrp
      
      local bav = Instance.new("BodyAngularVelocity")
      bav.Name = "FlingSpin"
      bav.AngularVelocity = Vector3.new(99999, 99999, 99999)
      bav.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
      bav.Parent = hrp

      task.delay(0.25, function()
         bv:Destroy()
         bav:Destroy()
         hum.PlatformStand = false
      end)
   end
end

-- // Обработка Fling при ударе
RunService.Stepped:Connect(function()
   if Flags.FlingOnPunch and LocalPlayer.Character then
      local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
      if tool and (tool.Name:find("Punch") or tool.Name:find("Hand")) then
         for _, part in pairs(tool:GetChildren()) do
            if part:IsA("BasePart") then
               part.Touched:Connect(function(hit)
                  if Flags.FlingOnPunch and hit.Parent and hit.Parent:FindFirstChildOfClass("Humanoid") then
                     local targetPlayer = Players:GetPlayerFromCharacter(hit.Parent)
                     if targetPlayer and targetPlayer ~= LocalPlayer and not WhitelistedPlayers[targetPlayer.Name] then
                        ApplyFling(hit.Parent)
                     end
                  end
               end)
            end
         end
      end
   end
end)

-- // Проверка и продажа ненужных петов
local function FilterPets()
   local petsFolder = LocalPlayer:FindFirstChild("petsFolder")
   if not petsFolder then return end

   for _, folder in pairs(petsFolder:GetChildren()) do
      for _, pet in pairs(folder:GetChildren()) do
         local rarityObj = pet:FindFirstChild("Rarity") or pet:FindFirstChild("rarity")
         local petName = pet.Name
         
         local isDesired = false
         if rarityObj and DesiredPets[rarityObj.Value] then
            isDesired = true
         end
         if DesiredPets[petName] then
            isDesired = true
         end

         -- Если пет НЕ входит в список желаемых — продаем
         if not isDesired then
            ReplicatedStorage.rEvents.sellPetRemote:FireServer(pet)
         end
      end
   end
end

-- // Функция телепортации камня (Air Rock Farm)
local function ProcessAirRock()
   local rockToFarm = nil
   for _, obj in pairs(Workspace:GetChildren()) do
      if obj.Name:find(SelectedRock) or (obj:FindFirstChild("Rock") and obj.Name:find("Rock")) then
         rockToFarm = obj
         break
      end
   end

   if rockToFarm and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
      local hrp = LocalPlayer.Character.HumanoidRootPart
      
      -- Отключаем коллизию у камня
      for _, p in pairs(rockToFarm:GetDescendants()) do
         if p:IsA("BasePart") then
            p.CanCollide = false
         end
      end

      -- Позиционируем камень над/перед игроком
      local targetCFrame = hrp.CFrame * CFrame.new(0, 1.5, -2)

      if rockToFarm:IsA("Model") then
         if rockToFarm.PrimaryPart then
            rockToFarm:SetPrimaryPartCFrame(targetCFrame)
         else
            for _, part in pairs(rockToFarm:GetChildren()) do
               if part:IsA("BasePart") then
                  part.CFrame = targetCFrame
                  break
               end
            end
         end
      elseif rockToFarm:IsA("BasePart") then
         rockToFarm.CFrame = targetCFrame
      end

      -- Автоматический удар
      local punch = LocalPlayer.Backpack:FindFirstChild("Punch") or LocalPlayer.Character:FindFirstChild("Punch")
      if punch then
         punch.Parent = LocalPlayer.Character
         punch:Activate()
      end
   end
end

-- // ВКЛАДКИ GUI
local RockTab = Window:CreateTab("Фарм Камня", 4483362458)
local CrystalTab = Window:CreateTab("Кристаллы & Петы", 4483362458)
local CombatTab = Window:CreateTab("Бой & Килл", 4483362458)
local MainTab = Window:CreateTab("Авто Фарм", 4483362458)
local MiscTab = Window:CreateTab("Разное", 4483362458)

-- ==================== Вкладка Фарм Камня ====================
RockTab:CreateDropdown({
   Name = "Выбери Камень",
   Options = RockList,
   CurrentOption = "Tiny Rock",
   Callback = function(Option)
      SelectedRock = Option[1] or Option
   end,
})

RockTab:CreateToggle({
   Name = "🌪️ БИТЬ КАМЕНЬ ПО ВОЗДУХУ (Air Rock)",
   CurrentValue = false,
   Callback = function(Value)
      AutoRockAir = Value
      task.spawn(function()
         while AutoRockAir do
            ProcessAirRock()
            task.wait(0.03)
         end
      end)
   end,
})

-- ==================== Вкладка Кристаллы & Петы ====================
CrystalTab:CreateDropdown({
   Name = "Выбери Кристалл",
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
            FilterPets()
            task.wait(0.4)
         end
      end)
   end,
})

CrystalTab:CreateSection("Оставлять только выбранные редкости:")

CrystalTab:CreateToggle({
   Name = "Оставлять Common (Обычные)",
   CurrentValue = false,
   Callback = function(v) DesiredPets["Common"] = v end
})

CrystalTab:CreateToggle({
   Name = "Оставлять Uncommon (Необычные)",
   CurrentValue = false,
   Callback = function(v) DesiredPets["Uncommon"] = v end
})

CrystalTab:CreateToggle({
   Name = "Оставлять Rare (Редкие)",
   CurrentValue = false,
   Callback = function(v) DesiredPets["Rare"] = v end
})

CrystalTab:CreateToggle({
   Name = "Оставлять Epic (Эпические)",
   CurrentValue = false,
   Callback = function(v) DesiredPets["Epic"] = v end
})

CrystalTab:CreateToggle({
   Name = "Оставлять Legendary (Легендарные)",
   CurrentValue = true,
   Callback = function(v) DesiredPets["Legendary"] = v end
})

-- ==================== Вкладка Бой & Килл ====================
CombatTab:CreateToggle({
   Name = "🔥 PUNCH FLING (Улёт при ударе)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.FlingOnPunch = Value
   end,
})

CombatTab:CreateSection("Убийство игроков")

CombatTab:CreateToggle({
   Name = "☠️ AUTO KILL ALL (Убивать всех на сервере)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.AutoKillAll = Value
      task.spawn(function()
         while Flags.AutoKillAll do
            for _, target in pairs(Players:GetPlayers()) do
               if not Flags.AutoKillAll then break end
               if target ~= LocalPlayer and not WhitelistedPlayers[target.Name] then
                  if target.Character and target.Character:FindFirstChild("HumanoidRootPart") and target.Character:FindFirstChildOfClass("Humanoid") and target.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                     
                     local startTime = tick()
                     while tick() - startTime < 1.5 and target.Character and target.Character:FindFirstChildOfClass("Humanoid").Health > 0 and Flags.AutoKillAll do
                        LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                        
                        local punch = LocalPlayer.Backpack:FindFirstChild("Punch") or LocalPlayer.Character:FindFirstChild("Punch")
                        if punch then
                           punch.Parent = LocalPlayer.Character
                           punch:Activate()
                        end
                        task.wait(0.05)
                     end
                  end
               end
            end
            task.wait(0.1)
         end
      end)
   end,
})

local PlayerDropdown = CombatTab:CreateDropdown({
   Name = "Выбери игрока для отдельного убийства",
   Options = GetPlayerNames(),
   CurrentOption = GetPlayerNames()[1],
   Callback = function(Option)
      SelectedTargetPlayer = Option[1] or Option
   end,
})

CombatTab:CreateButton({
   Name = "🔄 Обновить список игроков",
   Callback = function()
      PlayerDropdown:Set(GetPlayerNames())
   end,
})

CombatTab:CreateToggle({
   Name = "🎯 TARGET KILL (Убивать только выбранного)",
   CurrentValue = false,
   Callback = function(Value)
      Flags.TargetKill = Value
      task.spawn(function()
         while Flags.TargetKill do
            local target = Players:FindFirstChild(SelectedTargetPlayer)
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and target.Character:FindFirstChildOfClass("Humanoid") and target.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
               LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
               
               local punch = LocalPlayer.Backpack:FindFirstChild("Punch") or LocalPlayer.Character:FindFirstChild("Punch")
               if punch then
                  punch.Parent = LocalPlayer.Character
                  punch:Activate()
               end
            end
            task.wait(0.05)
         end
      end)
   end,
})

CombatTab:CreateSection("Белый список (Whitelist)")

CombatTab:CreateInput({
   Name = "Имя игрока в Вайтлист",
   PlaceholderText = "Введите ник...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      if Text ~= "" then
         WhitelistedPlayers[Text] = true
         Rayfield:Notify({
            Title = "Вайтлист",
            Content = Text .. " добавлен в Белый Список!",
            Duration = 3,
         })
      end
   end,
})

-- ==================== Вкладка Авто Фарм ====================
MainTab:CreateToggle({
   Name = "Auto Weight (Гантели)",
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
   Name = "Auto Rebirth (Авто-Ребирт)",
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

-- ==================== Вкладка Разное ====================
MiscTab:CreateSlider({
   Name = "Скорость ходьбы (WalkSpeed)",
   Range = {16, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Callback = function(Value)
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
         LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Value
      end
   end,
})

MiscTab:CreateButton({
   Name = "Безопасная зона (Anti-PK)",
   Callback = function()
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
         LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 5000, 0)
         local platform = Instance.new("Part", workspace)
         platform.Size = Vector3.new(100, 5, 100)
         platform.CFrame = CFrame.new(0, 4995, 0)
         platform.Anchored = true
      end
   end,
})

Rayfield:Notify({
   Title = "Успешный вход!",
   Content = "Скрипт от @kecuya разблокирован!",
   Duration = 4,
})
