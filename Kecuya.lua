-- // Muscle Legends Galaxy Hub (Full & Stable) by @kecuya
-- // Key: Guest666

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local CorrectKey = "Guest666"

-- Очистка старой версии GUI
if LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("KecuyaGalaxyHub_Ultimate") then
   LocalPlayer.PlayerGui.KecuyaGalaxyHub_Ultimate:Destroy()
end

-- ==========================================
-- 1. ГАЛАКТИЧЕСКИЙ GUI
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KecuyaGalaxyHub_Ultimate"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Кнопка Сворачивания
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 48, 0, 48)
ToggleBtn.Position = UDim2.new(0, 15, 0.5, -24)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 10, 30)
ToggleBtn.Text = "🌌"
ToggleBtn.TextSize = 22
ToggleBtn.Visible = false
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(140, 0, 255)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleBtn

-- Ввод Ключа
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 320, 0, 200)
KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -100)
KeyFrame.BackgroundColor3 = Color3.fromRGB(12, 8, 24)
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = ScreenGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 12)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(130, 60, 255)
KeyStroke.Thickness = 2
KeyStroke.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 45)
KeyTitle.Text = "🌌 GALAXY HUB | @kecuya"
KeyTitle.TextColor3 = Color3.fromRGB(200, 160, 255)
KeyTitle.TextSize = 16
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.BackgroundTransparency = 1
KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.8, 0, 0, 38)
KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyInput.PlaceholderText = "Введите ключ..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.BackgroundColor3 = Color3.fromRGB(22, 15, 40)
KeyInput.TextSize = 14
KeyInput.Font = Enum.Font.Gotham
KeyInput.Parent = KeyFrame

local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 8)
KeyInputCorner.Parent = KeyInput

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 38)
SubmitBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
SubmitBtn.Text = "SUBMIT / ВХОД"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 220)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 14
SubmitBtn.Parent = KeyFrame

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 8)
SubmitCorner.Parent = SubmitBtn

-- Главное Меню
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 560, 0, 380)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 6, 20)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(120, 40, 230)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- Шапка
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 12, 35)
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 12)
TopBarCorner.Parent = TopBar

local MainTitle = Instance.new("TextLabel")
MainTitle.Size = UDim2.new(1, -50, 1, 0)
MainTitle.Position = UDim2.new(0, 15, 0, 0)
MainTitle.Text = "✨ MUSCLE LEGENDS GALAXY HUB | @kecuya"
MainTitle.TextColor3 = Color3.fromRGB(210, 170, 255)
MainTitle.TextSize = 14
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextXAlignment = Enum.TextXAlignment.Left
MainTitle.BackgroundTransparency = 1
MainTitle.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.Parent = TopBar

-- Навигация
local Nav = Instance.new("Frame")
Nav.Size = UDim2.new(0, 130, 1, -40)
Nav.Position = UDim2.new(0, 0, 0, 40)
Nav.BackgroundColor3 = Color3.fromRGB(14, 9, 28)
Nav.Parent = MainFrame

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -140, 1, -50)
Content.Position = UDim2.new(0, 135, 0, 45)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- ==========================================
-- 2. СИСТЕМНЫЕ ПЕРЕМЕННЫЕ И ЛОГИКА
-- ==========================================
local Flags = {
   AirRock = false,
   Fling = false,
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
local SelectedTargetPlayer = ""
local SelectedRock = "Tiny Rock"
local SelectedPet = "Cyber Dragon"
local SelectedCrystal = "Blue Crystal"
local TargetRebirthValue = 100
local SavedAnchorCF = nil
local FlySpeed = 60

local RockList = {
   "Tiny Rock", "Small Rock", "Medium Rock", 
   "Large Rock", "Huge Rock", "Legends Rock", 
   "Jungle Rock", "Muscle King Rock"
}

local PetList = {
   "Cyber Dragon", "Dark Star", "Demon Hydra",
   "Gold Master", "Ice Monster", "King Beast",
   "Fire Aura", "Ultra Bird", "Muscle Doge"
}

-- 1) AIR ROCK FARM
local function ProcessAirRock()
   pcall(function()
      local char = LocalPlayer.Character
      if not char or not char:FindFirstChild("HumanoidRootPart") then return end
      local hrp = char.HumanoidRootPart

      local rock = nil
      for _, v in pairs(Workspace:GetChildren()) do
         if v.Name:lower():find(SelectedRock:lower()) or (v:FindFirstChild("Rock") and v.Name:find("Rock")) then
            rock = v
            break
         end
      end

      if rock then
         for _, p in pairs(rock:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
         end

         local targetCF = hrp.CFrame * CFrame.new(0, 0, -3)

         if rock:IsA("Model") then
            if rock.PrimaryPart then rock:SetPrimaryPartCFrame(targetCF)
            else
               for _, p in pairs(rock:GetChildren()) do
                  if p:IsA("BasePart") then p.CFrame = targetCF break end
               end
            end
         elseif rock:IsA("BasePart") then
            rock.CFrame = targetCF
         end

         local punch = LocalPlayer.Backpack:FindFirstChild("Punch") or char:FindFirstChild("Punch")
         if punch then
            punch.Parent = char
            punch:Activate()
         end
      end
   end)
end

-- 2) SKY FLING (В НЕБЕСА)
local function ApplySkyFling(targetChar)
   pcall(function()
      if not targetChar then return end
      local hrp = targetChar:FindFirstChild("HumanoidRootPart")
      if hrp then
         local bv = Instance.new("BodyVelocity")
         bv.Velocity = Vector3.new(0, 500000, 0)
         bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
         bv.Parent = hrp

         local bav = Instance.new("BodyAngularVelocity")
         bav.AngularVelocity = Vector3.new(50000, 50000, 50000)
         bav.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
         bav.Parent = hrp

         task.delay(0.15, function()
            bv:Destroy()
            bav:Destroy()
         end)
      end
   end)
end

RunService.Stepped:Connect(function()
   if Flags.Fling and LocalPlayer.Character then
      pcall(function()
         local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
         if tool and tool.Name:find("Punch") then
            for _, part in pairs(tool:GetChildren()) do
               if part:IsA("BasePart") then
                  part.Touched:Connect(function(hit)
                     if Flags.Fling and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
                        local p = Players:GetPlayerFromCharacter(hit.Parent)
                        if p and p ~= LocalPlayer and not Whitelist[p.Name] then
                           ApplySkyFling(hit.Parent)
                        end
                     end
                  end)
               end
            end
         end
      end)
   end
end)

-- 3) FLY (WASD)
local bodyGyro, bodyVelocity
local function ToggleFly(state)
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
               local camera = Workspace.CurrentCamera
               local moveDir = Vector3.zero

               if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camera.CFrame.LookVector end
               if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camera.CFrame.LookVector end
               if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camera.CFrame.RightVector end
               if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camera.CFrame.RightVector end

               bodyGyro.CFrame = camera.CFrame
               bodyVelocity.Velocity = moveDir * FlySpeed
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

-- 4) AUTO KILL AIR
local function HitTargetAir(targetPlayer)
   pcall(function()
      local char = LocalPlayer.Character
      if not char or not targetPlayer or not targetPlayer.Character then return end
      local targetHrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
      
      local punch = LocalPlayer.Backpack:FindFirstChild("Punch") or char:FindFirstChild("Punch")
      if punch then
         punch.Parent = char
         punch:Activate()
         if punch:FindFirstChild("LeftHand") and targetHrp then
            firetouchinterest(punch.LeftHand, targetHrp, 0)
            firetouchinterest(punch.LeftHand, targetHrp, 1)
         end
      end
   end)
end

-- 5) ANTI-KNOCKBACK & ANCHOR
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

-- 6) ANTI-AFK
LocalPlayer.Idled:Connect(function()
   if Flags.AntiAFK then
      pcall(function()
         VirtualUser:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
         task.wait(1)
         VirtualUser:Button2Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
      end)
   end
end)

-- 7) PETS
local function ProcessPetOpen()
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
end

-- ==========================================
-- 3. ВКЛАДКИ И КНОПКИ
-- ==========================================
local Pages = {}

local function AddTab(name)
   local b = Instance.new("TextButton")
   b.Size = UDim2.new(1, 0, 0, 34)
   b.Text = name
   b.TextColor3 = Color3.fromRGB(170, 160, 200)
   b.BackgroundColor3 = Color3.fromRGB(14, 9, 28)
   b.Font = Enum.Font.Gotham
   b.TextSize = 11
   b.Parent = Nav

   local p = Instance.new("ScrollingFrame")
   p.Size = UDim2.new(1, 0, 1, 0)
   p.BackgroundTransparency = 1
   p.Visible = false
   p.CanvasSize = UDim2.new(0, 0, 2, 0)
   p.ScrollBarThickness = 2
   p.Parent = Content

   local layout = Instance.new("UIListLayout")
   layout.Padding = UDim.new(0, 6)
   layout.Parent = p

   b.MouseButton1Click:Connect(function()
      for _, pg in pairs(Pages) do pg.Visible = false end
      p.Visible = true
   end)

   table.insert(Pages, p)
   return p
end

local RockPg = AddTab("🔨 Камень")
local BenchPg = AddTab("🏋️ Подъемник")
local KillPg = AddTab("⚔️ Килл & Fling")
local ProtectPg = AddTab("🛡️ Защита & Fly")
local RebirthPg = AddTab("🔄 Ребирт")
local PetPg = AddTab("💎 Петы")

Pages[1].Visible = true

local function AddToggle(parent, text, callback)
   local btn = Instance.new("TextButton")
   btn.Size = UDim2.new(1, -10, 0, 34)
   btn.Text = text .. " [ВЫКЛ]"
   btn.TextColor3 = Color3.fromRGB(255, 255, 255)
   btn.BackgroundColor3 = Color3.fromRGB(22, 16, 42)
   btn.Font = Enum.Font.Gotham
   btn.TextSize = 11
   btn.Parent = parent

   local c = Instance.new("UICorner")
   c.CornerRadius = UDim.new(0, 6)
   c.Parent = btn

   local state = false
   btn.MouseButton1Click:Connect(function()
      state = not state
      btn.Text = text .. (state and " [ВКЛ]" or " [ВЫКЛ]")
      btn.BackgroundColor3 = state and Color3.fromRGB(120, 40, 220) or Color3.fromRGB(22, 16, 42)
      callback(state)
   end)
end

-- КАМНИ
for _, rName in pairs(RockList) do
   local btn = Instance.new("TextButton")
   btn.Size = UDim2.new(1, -10, 0, 26)
   btn.Text = "Камень: " .. rName
   btn.TextColor3 = Color3.fromRGB(200, 200, 200)
   btn.BackgroundColor3 = Color3.fromRGB(18, 12, 32)
   btn.Font = Enum.Font.Gotham
   btn.TextSize = 10
   btn.Parent = RockPg

   btn.MouseButton1Click:Connect(function()
      SelectedRock = rName
      btn.Text = "✓ ВЫБРАН: " .. rName
      task.wait(1)
      btn.Text = "Камень: " .. rName
   end)
end

AddToggle(RockPg, "🌪️ БИТЬ КАМЕНЬ С ПЕРЕДИ (Air Rock)", function(v)
   Flags.AirRock = v
   task.spawn(function()
      while Flags.AirRock do
         ProcessAirRock()
         task.wait(0.03)
      end
   end)
end)

-- ПОДЪЕМНИК
AddToggle(BenchPg, "🏋️ АВТО-ПОДЪЕМНИК (Bench Farm)", function(v)
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

-- АТАКА & FLING
AddToggle(KillPg, "🚀 SKY FLING (Удар в небеса)", function(v) Flags.Fling = v end)

AddToggle(KillPg, "☠️ AUTO KILL ALL (Атака всех)", function(v)
   Flags.AutoKillAir = v
   task.spawn(function()
      while Flags.AutoKillAir do
         for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and not Whitelist[p.Name] then
               HitTargetAir(p)
            end
         end
         task.wait(0.05)
      end
   end)
end)

local TargetInput = Instance.new("TextBox")
TargetInput.Size = UDim2.new(1, -10, 0, 30)
TargetInput.PlaceholderText = "Введите ник цели..."
TargetInput.Text = ""
TargetInput.BackgroundColor3 = Color3.fromRGB(22, 16, 42)
TargetInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetInput.Font = Enum.Font.Gotham
TargetInput.TextSize = 11
TargetInput.Parent = KillPg

AddToggle(KillPg, "🎯 TARGET KILL (Только выбранный)", function(v)
   Flags.TargetKillAir = v
   SelectedTargetPlayer = TargetInput.Text
   task.spawn(function()
      while Flags.TargetKillAir do
         local p = Players:FindFirstChild(SelectedTargetPlayer)
         if p then HitTargetAir(p) end
         task.wait(0.05)
      end
   end)
end)

local WLInput = Instance.new("TextBox")
WLInput.Size = UDim2.new(1, -10, 0, 30)
WLInput.PlaceholderText = "Ник для WhiteList..."
WLInput.Text = ""
WLInput.BackgroundColor3 = Color3.fromRGB(22, 16, 42)
WLInput.TextColor3 = Color3.fromRGB(255, 255, 255)
WLInput.Font = Enum.Font.Gotham
WLInput.TextSize = 11
WLInput.Parent = KillPg

local WLBtn = Instance.new("TextButton")
WLBtn.Size = UDim2.new(1, -10, 0, 28)
WLBtn.Text = "➕ Добавить в WhiteList"
WLBtn.BackgroundColor3 = Color3.fromRGB(40, 30, 70)
WLBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
WLBtn.Font = Enum.Font.Gotham
WLBtn.TextSize = 11
WLBtn.Parent = KillPg

WLBtn.MouseButton1Click:Connect(function()
   if WLInput.Text ~= "" then
      Whitelist[WLInput.Text] = true
      WLBtn.Text = "✓ Добавлен!"
      task.wait(1)
      WLBtn.Text = "➕ Добавить в WhiteList"
   end
end)

-- ЗАЩИТА & FLY
AddToggle(ProtectPg, "🛸 FLY (Полёт WASD)", function(v)
   Flags.Fly = v
   ToggleFly(v)
end)

AddToggle(ProtectPg, "🛡️ ANTI-KNOCKBACK (Анти-отбрасывание)", function(v) Flags.AntiKnockback = v end)
AddToggle(ProtectPg, "📌 ЗАКРЕПИТЬСЯ НА ПОЗИЦИИ (Anchor)", function(v) Flags.AnchorPos = v end)
AddToggle(ProtectPg, "⚡ ANTI-AFK (Защита от вылета)", function(v) Flags.AntiAFK = v end)

-- РЕБИРТ
local RebInput = Instance.new("TextBox")
RebInput.Size = UDim2.new(1, -10, 0, 32)
RebInput.PlaceholderText = "Нужное кол-во ребиртов..."
RebInput.Text = "100"
RebInput.BackgroundColor3 = Color3.fromRGB(22, 16, 42)
RebInput.TextColor3 = Color3.fromRGB(255, 255, 255)
RebInput.Font = Enum.Font.Gotham
RebInput.TextSize = 11
RebInput.Parent = RebirthPg

AddToggle(RebirthPg, "🔄 АВТО-РЕБИРТ ДО ЦЕЛИ", function(v)
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
         task.wait(1)
      end
   end)
end)

-- ПЕТЫ
for _, petName in pairs(PetList) do
   local btn = Instance.new("TextButton")
   btn.Size = UDim2.new(1, -10, 0, 26)
   btn.Text = "Пет: " .. petName
 
