-- // KECUYA HUB (FULL FIXED & COMPLETE EDITION)
-- // Creator: @kecuya | Key: Guest666

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

local CorrectKey = "Guest666"

-- Очистка старых версий
local playerGui = LocalPlayer:WaitForChild("PlayerGui", 10)
if playerGui and playerGui:FindFirstChild("KecuyaCompactHub") then
   playerGui.KecuyaCompactHub:Destroy()
end

-- ==========================================
-- 1. ANTI-AFK И СИСТЕМА ФЛАГОВ
-- ==========================================
LocalPlayer.Idled:Connect(function()
   VirtualUser:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
   task.wait(1)
   VirtualUser:Button2Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
end)

local Flags = {
   AirRock = false,
   AutoDumbbell = false,
   AutoPushups = false,
   AutoSitups = false,
   AutoPunch = false,
   FastPunch = false,
   TargetRebirth = false,
   AutoKillAir = false,
   FarmGoodKarma = false,
   FarmEvilKarma = false,
   TargetKill = false,
   AntiKnockback = false,
   Fly = false,
   AutoPosition = false,
   IgnoreFriends = true
}

local SelectedRock = "Tiny Rock"
local TargetRebirthValue = 100
local FlySpeed = 50
local TargetPlayerName = ""
local MobileUp, MobileDown = false, false
local StartTime = tick()
local SavedPosition = nil

local RockList = {"Tiny Rock", "Small Rock", "Medium Rock", "Large Rock", "Huge Rock", "Legends Rock", "Jungle Rock", "Muscle King Rock"}

-- ==========================================
-- 2. ИНТЕРФЕЙС (360x230)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KecuyaCompactHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = playerGui

-- Мобильные кнопки Полета
local MobileFlyFrame = Instance.new("Frame")
MobileFlyFrame.Size = UDim2.new(0, 50, 0, 95)
MobileFlyFrame.Position = UDim2.new(0.88, 0, 0.4, 0)
MobileFlyFrame.BackgroundTransparency = 1
MobileFlyFrame.Visible = false
MobileFlyFrame.Parent = ScreenGui

local FlyUpBtn = Instance.new("TextButton")
FlyUpBtn.Size = UDim2.new(1, 0, 0, 42)
FlyUpBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
FlyUpBtn.Text = "▲\nUp"
FlyUpBtn.TextColor3 = Color3.fromRGB(168, 85, 247)
FlyUpBtn.Font = Enum.Font.GothamMedium
FlyUpBtn.TextSize = 10
FlyUpBtn.Parent = MobileFlyFrame
Instance.new("UICorner", FlyUpBtn).CornerRadius = UDim.new(0, 8)

local FlyDownBtn = Instance.new("TextButton")
FlyDownBtn.Size = UDim2.new(1, 0, 0, 42)
FlyDownBtn.Position = UDim2.new(0, 0, 0, 48)
FlyDownBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
FlyDownBtn.Text = "▼\nDown"
FlyDownBtn.TextColor3 = Color3.fromRGB(168, 85, 247)
FlyDownBtn.Font = Enum.Font.GothamMedium
FlyDownBtn.TextSize = 10
FlyDownBtn.Parent = MobileFlyFrame
Instance.new("UICorner", FlyDownBtn).CornerRadius = UDim.new(0, 8)

FlyUpBtn.MouseButton1Down:Connect(function() MobileUp = true end)
FlyUpBtn.MouseButton1Up:Connect(function() MobileUp = false end)
FlyDownBtn.MouseButton1Down:Connect(function() MobileDown = true end)
FlyDownBtn.MouseButton1Up:Connect(function() MobileDown = false end)

-- Плавающая кнопка
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 38, 0, 38)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
ToggleBtn.Text = "⚡"
ToggleBtn.TextColor3 = Color3.fromRGB(168, 85, 247)
ToggleBtn.TextSize = 18
ToggleBtn.Visible = false
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 10)
local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Color = Color3.fromRGB(168, 85, 247)
ToggleStroke.Thickness = 1.2

-- Окно Входа (Key)
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 240, 0, 140)
KeyFrame.Position = UDim2.new(0.5, -120, 0.5, -70)
KeyFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 22)
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = ScreenGui
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 10)
local KeyStroke = Instance.new("UIStroke", KeyFrame)
KeyStroke.Color = Color3.fromRGB(168, 85, 247)

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 30)
KeyTitle.Text = "Kecuya Hub  •  Access"
KeyTitle.TextColor3 = Color3.fromRGB(240, 240, 255)
KeyTitle.TextSize = 11
KeyTitle.Font = Enum.Font.GothamMedium
KeyTitle.BackgroundTransparency = 1
KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.85, 0, 0, 28)
KeyInput.Position = UDim2.new(0.075, 0, 0.32, 0)
KeyInput.PlaceholderText = "Введите ключ..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.BackgroundColor3 = Color3.fromRGB(22, 22, 34)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 10
KeyInput.Parent = KeyFrame
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 6)

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.85, 0, 0, 28)
SubmitBtn.Position = UDim2.new(0.075, 0, 0.65, 0)
SubmitBtn.Text = "Войти"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
SubmitBtn.Font = Enum.Font.GothamMedium
SubmitBtn.TextSize = 10
SubmitBtn.Parent = KeyFrame
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 6)

-- Главное Окно
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 360, 0, 230)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -115)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(147, 51, 234)
MainStroke.Thickness = 1.2

-- Шапка
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(16, 16, 26)
TopBar.Parent = MainFrame

local MainTitle = Instance.new("TextLabel")
MainTitle.Size = UDim2.new(0, 180, 1, 0)
MainTitle.Position = UDim2.new(0, 10, 0, 0)
MainTitle.Text = "Kecuya Hub"
MainTitle.TextColor3 = Color3.fromRGB(240, 240, 255)
MainTitle.TextSize = 11
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextXAlignment = Enum.TextXAlignment.Left
MainTitle.BackgroundTransparency = 1
MainTitle.Parent = TopBar

local AuthorLabel = Instance.new("TextLabel")
AuthorLabel.Size = UDim2.new(0, 100, 1, 0)
AuthorLabel.Position = UDim2.new(0, 80, 0, 0)
AuthorLabel.Text = "by @kecuya"
AuthorLabel.TextColor3 = Color3.fromRGB(168, 85, 247)
AuthorLabel.TextSize = 9
AuthorLabel.Font = Enum.Font.GothamMedium
AuthorLabel.TextXAlignment = Enum.TextXAlignment.Left
AuthorLabel.BackgroundTransparency = 1
AuthorLabel.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 22, 0, 22)
CloseBtn.Position = UDim2.new(1, -26, 0, 4)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(239, 68, 68)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 11
CloseBtn.Parent = TopBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 22, 0, 22)
MinimizeBtn.Position = UDim2.new(1, -50, 0, 4)
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(180, 180, 210)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 11
MinimizeBtn.Parent = TopBar

-- Навигация Вкладок
local TabBar = Instance.new("ScrollingFrame")
TabBar.Size = UDim2.new(1, -12, 0, 24)
TabBar.Position = UDim2.new(0, 6, 0, 34)
TabBar.BackgroundTransparency = 1
TabBar.ScrollBarThickness = 0
TabBar.CanvasSize = UDim2.new(0, 0, 0, 0)
TabBar.AutomaticCanvasSize = Enum.AutomaticSize.X
TabBar.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout", TabBar)
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 4)

local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -12, 1, -66)
ContentContainer.Position = UDim2.new(0, 6, 0, 62)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

-- Анимация
local function AnimateFrame(show)
   if show then
      MainFrame.Size = UDim2.new(0, 200, 0, 120)
      MainFrame.Position = UDim2.new(0.5, -100, 0.5, -60)
      MainFrame.BackgroundTransparency = 1
      MainFrame.Visible = true

      TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
         Size = UDim2.new(0, 360, 0, 230),
         Position = UDim2.new(0.5, -180, 0.5, -115),
         BackgroundTransparency = 0
      }):Play()
   else
      local tw = TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
         Size = UDim2.new(0, 150, 0, 80),
         Position = UDim2.new(0.5, -75, 0.5, -40),
         BackgroundTransparency = 1
      })
      tw:Play()
      tw.Completed:Connect(function()
         if MainFrame.Size.X.Offset < 200 then
            MainFrame.Visible = false
         end
      end)
   end
end

-- ==========================================
-- 3. СОЗДАНИЕ ВКЛАДОК
-- ==========================================
local Pages, TabButtons = {}, {}

local function CreateTab(name)
   local btn = Instance.new("TextButton")
   btn.Size = UDim2.new(0, 58, 1, 0)
   btn.Text = name
   btn.TextColor3 = Color3.fromRGB(140, 140, 165)
   btn.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
   btn.Font = Enum.Font.GothamMedium
   btn.TextSize = 9
   btn.Parent = TabBar
   Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)

   local scroll = Instance.new("ScrollingFrame")
   scroll.Size = UDim2.new(1, 0, 1, 0)
   scroll.BackgroundTransparency = 1
   scroll.Visible = false
   scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
   scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
   scroll.ScrollBarThickness = 2
   scroll.ScrollBarImageColor3 = Color3.fromRGB(147, 51, 234)
   scroll.Parent = ContentContainer

   local layout = Instance.new("UIListLayout", scroll)
   layout.Padding = UDim.new(0, 4)

   btn.MouseButton1Click:Connect(function()
      for _, p in pairs(Pages) do p.Visible = false end
      for _, b in pairs(TabButtons) do 
         TweenService:Create(b, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(140, 140, 165), BackgroundColor3 = Color3.fromRGB(18, 18, 28)}):Play()
      end
      scroll.Visible = true
      TweenService:Create(btn, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255, 255, 255), BackgroundColor3 = Color3.fromRGB(147, 51, 234)}):Play()
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
TabButtons[1].BackgroundColor3 = Color3.fromRGB(147, 51, 234)

local function CreateToggle(parent, name, defaultState, callback)
   local frame = Instance.new("Frame")
   frame.Size = UDim2.new(1, -4, 0, 24)
   frame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
   frame.Parent = parent
   Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 5)

   local txt = Instance.new("TextLabel")
   txt.Size = UDim2.new(0, 220, 1, 0)
   txt.Position = UDim2.new(0, 8, 0, 0)
   txt.Text = name
   txt.TextColor3 = defaultState and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 175)
   txt.Font = Enum.Font.Gotham
   txt.TextSize = 9
   txt.TextXAlignment = Enum.TextXAlignment.Left
   txt.BackgroundTransparency = 1
   txt.Parent = frame

   local track = Instance.new("Frame")
   track.Size = UDim2.new(0, 30, 0, 14)
   track.Position = UDim2.new(1, -34, 0.5, -7)
   track.BackgroundColor3 = defaultState and Color3.fromRGB(147, 51, 234) or Color3.fromRGB(32, 32, 48)
   track.Parent = frame
   Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

   local knob = Instance.new("Frame")
   knob.Size = UDim2.new(0, 10, 0, 10)
   knob.Position = defaultState and UDim2.new(1, -12, 0.5, -5) or UDim2.new(0, 2, 0.5, -5)
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
      local targetKnobPos = state and UDim2.new(1, -12, 0.5, -5) or UDim2.new(0, 2, 0.5, -5)
      local targetTrackColor = state and Color3.fromRGB(147, 51, 234) or Color3.fromRGB(32, 32, 48)
      local targetTextColor = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 175)

      TweenService:Create(knob, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetKnobPos}):Play()
      TweenService:Create(track, TweenInfo.new(0.18), {BackgroundColor3 = targetTrackColor}):Play()
      TweenService:Create(txt, TweenInfo.new(0.18), {TextColor3 = targetTextColor}):Play()

      callback(state)
   end)
end

-- ==========================================
-- 4. ВКЛАДКА «СТАТУС»
-- ==========================================
local function CreateStatusLabel(text)
   local lbl = Instance.new("TextLabel")
   lbl.Size = UDim2.new(1, -4, 0, 22)
   lbl.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
   lbl.Text = "  " .. text
   lbl.TextColor3 = Color3.fromRGB(220, 220, 245)
   lbl.Font = Enum.Font.Gotham
   lbl.TextSize = 9
   lbl.TextXAlignment = Enum.TextXAlignment.Left
   lbl.Parent = StatusPg
   Instance.new("UICorner", lbl).CornerRadius = UDim.new(0, 5)
   return lbl
end

local StrengthLabel = CreateStatusLabel("⚡ Сила: Загрузка...")
local RebirthLabel = CreateStatusLabel("🔄 Ребирты: Загрузка...")
local KarmaLabel = CreateStatusLabel("😇 Карма: Загрузка...")
local TimeLabel = CreateStatusLabel("⏱️ В игре: 00:00:00")

task.spawn(function()
   while true do
      pcall(function()
         local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
         
         local str = leaderstats and (leaderstats:FindFirstChild("Strength") or leaderstats:FindFirstChild("strength"))
         StrengthLabel.Text = "  ⚡ Сила: " .. (str and tostring(str.Value) or "0")

         local reb = leaderstats and (leaderstats:FindFirstChild("Rebirths") or leaderstats:FindFirstChild("rebirths"))
         RebirthLabel.Text = "  🔄 Ребирты: " .. (reb and tostring(reb.Value) or "0")

         local good = leaderstats and leaderstats:FindFirstChild("Good")
         local evil = leaderstats and leaderstats:FindFirstChild("Evil")
         KarmaLabel.Text = "  😇 Карма: Добро [" .. (good and good.Value or 0) .. "] | Зло [" .. (evil and evil.Value or 0) .. "]"

         local totalSecs = math.floor(tick() - StartTime)
         local hrs = math.floor(totalSecs / 3600)
         local mins = math.floor((totalSecs % 3600) / 60)
         local secs = totalSecs % 60
         TimeLabel.Text = string.format("  ⏱️ В игре: %02d:%02d:%02d", hrs, mins, secs)
      end)
      task.wait(1)
   end
end)

-- ==========================================
-- 5. ИСПОЛНИТЕЛЬНЫЕ ИСПРАВЛЕННЫЕ ФУНКЦИИ
-- ==========================================

-- Тренировки
local function SafeTrain(toolName)
   pcall(function()
      local char = LocalPlayer.Character
      if not char then return end
      local tool = char:FindFirstChild(toolName) or LocalPlayer.Backpack:FindFirstChild(toolName)
      if tool then
         if tool.Parent ~= char then tool.Parent = char end
         tool:Activate()
      end
   end)
end

task.spawn(function()
   while true do
      if Flags.AutoDumbbell then SafeTrain("Dumbbell") end
      if Flags.AutoPushups then SafeTrain("Pushups") end
      if Flags.AutoSitups then SafeTrain("Situps") end
      if Flags.AutoPunch then SafeTrain("Punch") end
      task.wait(Flags.FastPunch and 0.05 or 0.22)
   end
end)

-- УНИВЕРСАЛЬНЫЙ ПОИСК И АВТО-ФАРМ ВСЕХ КАМНЕЙ
local function GetRockPart(rockName)
   local nameLower = rockName:lower()
   for _, obj in pairs(Workspace:GetDescendants()) do
      if obj:IsA("BasePart") or obj:IsA("Model") then
         local n = obj.Name:lower()
         if n:find(nameLower) or (obj.Parent and obj.Parent.Name:lower():find(nameLower)) then
            if obj:IsA("BasePart") then
               return obj
            elseif obj:IsA("Model") and obj.PrimaryPart then
               return obj.PrimaryPart
            elseif obj:IsA("Model") and obj:FindFirstChildWhichIsA("BasePart") then
               return obj:FindFirstChildWhichIsA("BasePart")
            end
         end
      end
   end
   return nil
end

task.spawn(function()
   while true do
      if Flags.AirRock then
         pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
               local hrp = char.HumanoidRootPart
               local targetRock = GetRockPart(SelectedRock)

               if targetRock then
                  -- Подлет и зависание прямо над камнем
                  hrp.CFrame = targetRock.CFrame * CFrame.new(0, (targetRock.Size.Y / 2) + 3.5, 0)
                  
                  local punch = char:FindFirstChild("Punch") or LocalPlayer.Backpack:FindFirstChild("Punch")
                  if punch then
                     punch.Parent = char
                     punch:Activate()
                  end

                  local pRemote = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("punchEvent")
                  if pRemote then
                     pRemote:FireServer("punchAttack")
                  end
               end
            end
         end)
      end
      task.wait(0.08)
   end
end)

-- АТАКА / КИЛЛ / ИСПРАВЛЕННАЯ КАРМА / ТАРГЕТ
local function IsFriend(p)
   if not Flags.IgnoreFriends then return false end
   if p == LocalPlayer then return true end
   local ok, res = pcall(function() return LocalPlayer:IsFriendsWith(p.UserId) end)
   return ok and res
end

local function HitPlayer(p)
   pcall(function()
      if not p or p == LocalPlayer or IsFriend(p) then return end
      local c = p.Character
      if not c or not c:FindFirstChild("HumanoidRootPart") or not c:FindFirstChildOfClass("Humanoid") then return end
      if c:FindFirstChildOfClass("Humanoid").Health <= 0 then return end

      local myChar = LocalPlayer.Character
      if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end

      -- Телепортируемся за спину врагу и бьем
      myChar.HumanoidRootPart.CFrame = c.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)

      local punch = myChar:FindFirstChild("Punch") or LocalPlayer.Backpack:FindFirstChild("Punch")
      if punch then
         punch.Parent = myChar
         punch:Activate()
         local r = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("punchEvent")
         if r then r:FireServer("punchAttack") end
      end
   end)
end

task.spawn(function()
   while true do
      pcall(function()
         if Flags.AutoKillAir then
            for _, p in pairs(Players:GetPlayers()) do
               if p ~= LocalPlayer and not IsFriend(p) then HitPlayer(p) end
            end
         elseif Flags.FarmGoodKarma then
            -- ХОРОШАЯ КАРМА: бьем злодеев (Evil > 0)
               for _, p in pairs(Players:GetPlayers()) do
               if p ~= LocalPlayer and not IsFriend(p) then
                  local evil = p:FindFirstChild("leaderstats") and p.leaderstats:FindFirstChild("Evil")
                  if evil and evil.Value > 0 then HitPlayer(p) end
               end
            end
         elseif Flags.FarmEvilKarma then
            -- ПЛОХАЯ КАРМА: бьем добрых людей (Good > 0)
            for _, p in pairs(Players:GetPlayers()) do
               if p ~= LocalPlayer and not IsFriend(p) then
                  local good = p:FindFirstChild("leaderstats") and p.leaderstats:FindFirstChild("Good")
                  if good and good.Value > 0 then HitPlayer(p) end
               end
            end
         elseif Flags.TargetKill and TargetPlayerName ~= "" then
            for _, p in pairs(Players:GetPlayers()) do
               if p.Name:lower():find(TargetPlayerName:lower()) or p.DisplayName:lower():find(TargetPlayerName:lower()) then
                  HitPlayer(p)
                  break
               end
            end
         end
      end)
      task.wait(0.08)
   end
end)

-- РАБОЧИЙ ПОЛЕТ (НА LinearVelocity + Attachments)
local flyAttachment, flyLinearVelocity
task.spawn(function()
   while true do
      pcall(function()
         local char = LocalPlayer.Character
         if Flags.Fly and char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local camera = Workspace.CurrentCamera
            local hum = char:FindFirstChildOfClass("Humanoid")

            if not flyAttachment or flyAttachment.Parent ~= hrp then
               flyAttachment = Instance.new("Attachment", hrp)
               
               flyLinearVelocity = Instance.new("LinearVelocity")
               flyLinearVelocity.MaxForce = 9e9
               flyLinearVelocity.VectorVelocity = Vector3.zero
               flyLinearVelocity.Attachment0 = flyAttachment
               flyLinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
               flyLinearVelocity.Parent = hrp
            end

            hum.PlatformStand = true

            local moveDir = Vector3.zero
            if hum and hum.MoveDirection.Magnitude > 0 then 
               moveDir = hum.MoveDirection 
            end

            if UserInputService:IsKeyDown(Enum.KeyCode.Space) or MobileUp then 
               moveDir = moveDir + Vector3.new(0, 1, 0) 
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or MobileDown then 
               moveDir = moveDir - Vector3.new(0, 1, 0) 
            end

            flyLinearVelocity.VectorVelocity = moveDir * FlySpeed
         else
            if flyAttachment then flyAttachment:Destroy() flyAttachment = nil end
            if flyLinearVelocity then flyLinearVelocity:Destroy() flyLinearVelocity = nil end
            if char and char:FindFirstChildOfClass("Humanoid") then
               char:FindFirstChildOfClass("Humanoid").PlatformStand = false
            end
         end
      end)
      task.wait(0.02)
   end
end)

-- АВТО-ПОЗИЦИЯ
task.spawn(function()
   while true do
      if Flags.AutoPosition and SavedPosition then
         pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
               char.HumanoidRootPart.CFrame = SavedPosition
            end
         end)
      end
      task.wait(0.1)
   end
end)

-- ==========================================
-- 6. ВКЛАДКИ НАСТРОЕК
-- ==========================================

-- Вкладка: Камни
CreateToggle(RockPg, "Авто-Фарм Камня", Flags.AirRock, function(v) Flags.AirRock = v end)

local RockLabel = Instance.new("TextLabel")
RockLabel.Size = UDim2.new(1, 0, 0, 16)
RockLabel.Text = "Выберите камень:"
RockLabel.TextColor3 = Color3.fromRGB(168, 85, 247)
RockLabel.Font = Enum.Font.GothamMedium
RockLabel.TextSize = 9
RockLabel.BackgroundTransparency = 1
RockLabel.Parent = RockPg

for _, rName in pairs(RockList) do
   local btn = Instance.new("TextButton")
   btn.Size = UDim2.new(1, -4, 0, 18)
   btn.Text = "  " .. rName
   btn.TextColor3 = Color3.fromRGB(150, 150, 175)
   btn.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
   btn.Font = Enum.Font.Gotham
   btn.TextSize = 8
   btn.TextXAlignment = Enum.TextXAlignment.Left
   btn.Parent = RockPg
   Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

   btn.MouseButton1Click:Connect(function()
      SelectedRock = rName
      btn.Text = "  ✓ Выбран: " .. rName
      btn.TextColor3 = Color3.fromRGB(168, 85, 247)
      task.wait(0.5)
      btn.Text = "  " .. rName
      btn.TextColor3 = Color3.fromRGB(150, 150, 175)
   end)
end

-- Вкладка: Качалка
CreateToggle(BenchPg, "Гантели (Dumbbell)", Flags.AutoDumbbell, function(v) Flags.AutoDumbbell = v end)
CreateToggle(BenchPg, "Отжимания (Pushups)", Flags.AutoPushups, function(v) Flags.AutoPushups = v end)
CreateToggle(BenchPg, "Пресс (Situps)", Flags.AutoSitups, function(v) Flags.AutoSitups = v end)
CreateToggle(BenchPg, "Удары (Punch)", Flags.AutoPunch, function(v) Flags.AutoPunch = v end)
CreateToggle(BenchPg, "Быстрый клик", Flags.FastPunch, function(v) Flags.FastPunch = v end)

-- Вкладка: Атака
CreateToggle(KillPg, "Игнорировать друзей", Flags.IgnoreFriends, function(v) Flags.IgnoreFriends = v end)
CreateToggle(KillPg, "Убивать всех (Auto Kill)", Flags.AutoKillAir, function(v) Flags.AutoKillAir = v end)
CreateToggle(KillPg, "Фарм Good Karma", Flags.FarmGoodKarma, function(v) Flags.FarmGoodKarma = v end)
CreateToggle(KillPg, "Фарм Evil Karma", Flags.FarmEvilKarma, function(v) Flags.FarmEvilKarma = v end)

local TargetInput = Instance.new("TextBox")
TargetInput.Size = UDim2.new(1, -4, 0, 22)
TargetInput.PlaceholderText = "Введите ник цели..."
TargetInput.Text = ""
TargetInput.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
TargetInput.TextColor3 = Color3.fromRGB(240, 240, 255)
TargetInput.Font = Enum.Font.Gotham
TargetInput.TextSize = 9
TargetInput.Parent = KillPg
Instance.new("UICorner", TargetInput).CornerRadius = UDim.new(0, 5)

TargetInput.FocusLost:Connect(function()
   TargetPlayerName = TargetInput.Text
end)

CreateToggle(KillPg, "Убивать цель (Target)", Flags.TargetKill, function(v) Flags.TargetKill = v end)

-- Вкладка: Ребирт
local RebInput = Instance.new("TextBox")
RebInput.Size = UDim2.new(1, -4, 0, 22)
RebInput.PlaceholderText = "Лимит ребиртов (100)"
RebInput.Text = "100"
RebInput.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
RebInput.TextColor3 = Color3.fromRGB(240, 240, 255)
RebInput.Font = Enum.Font.Gotham
RebInput.TextSize = 9
RebInput.Parent = RebirthPg
Instance.new("UICorner", RebInput).CornerRadius = UDim.new(0, 5)

CreateToggle(RebirthPg, "Авто-Ребирт", Flags.TargetRebirth, function(v)
   Flags.TargetRebirth = v
   TargetRebirthValue = tonumber(RebInput.Text) or 100
   task.spawn(function()
      while Flags.TargetRebirth do
         pcall(function()
            local stats = LocalPlayer:FindFirstChild("leaderstats")
            local rebirths = stats and stats:FindFirstChild("Rebirths")
            if rebirths and rebirths.Value >= TargetRebirthValue then
               Flags.TargetRebirth = false
            else
               ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
         end)
         task.wait(0.5)
      end
   end)
end)

-- Вкладка: Защита
CreateToggle(UtilityPg, "Anti-Knockback", Flags.AntiKnockback, function(v) Flags.AntiKnockback = v end)

local SavePosBtn = Instance.new("TextButton")
SavePosBtn.Size = UDim2.new(1, -4, 0, 22)
SavePosBtn.Text = "Сохранить точку"
SavePosBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 36)
SavePosBtn.TextColor3 = Color3.fromRGB(168, 85, 247)
SavePosBtn.Font = Enum.Font.GothamMedium
SavePosBtn.TextSize = 9
SavePosBtn.Parent = UtilityPg
Instance.new("UICorner", SavePosBtn).CornerRadius = UDim.new(0, 5)

SavePosBtn.MouseButton1Click:Connect(function()
   pcall(function()
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
         SavedPosition = LocalPlayer.Character.HumanoidRootPart.CFrame
         SavePosBtn.Text = "✓ Точка сохранена!"
         task.wait(1)
         SavePosBtn.Text = "Сохранить точку"
      end
   end)
end)

CreateToggle(UtilityPg, "Авто Позиция", Flags.AutoPosition, function(v) Flags.AutoPosition = v end)

local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(1, -4, 0, 22)
SpeedInput.PlaceholderText = "Скорость полета (Fly Speed)"
SpeedInput.Text = "50"
SpeedInput.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
SpeedInput.TextColor3 = Color3.fromRGB(240, 240, 255)
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.TextSize = 9
SpeedInput.Parent = UtilityPg
Instance.new("UICorner", SpeedInput).CornerRadius = UDim.new(0, 5)

SpeedInput.FocusLost:Connect(function()
   FlySpeed = tonumber(SpeedInput.Text) or 50
end)

CreateToggle(UtilityPg, "Полет (Fly)", Flags.Fly, function(v) 
   Flags.Fly = v 
   MobileFlyFrame.Visible = v 
end)

-- ==========================================
-- 7. АВТОРИЗАЦИЯ
-- ==========================================
local function AttemptLogin()
   local enteredKey = string.match(KeyInput.Text, "^%s*(.-)%s*$") or ""
   if enteredKey == CorrectKey then
      KeyFrame.Visible = false
      ToggleBtn.Visible = true
      AnimateFrame(true)
   else
      KeyInput.Text = "❌ Неверно"
      task.wait(0.8)
      KeyInput.Text = ""
   end
end

SubmitBtn.MouseButton1Click:Connect(AttemptLogin)
KeyInput.FocusLost:Connect(function(enterPressed) if enterPressed then AttemptLogin() end end)

CloseBtn.MouseButton1Click:Connect(function()
   AnimateFrame(false)
   task.wait(0.25)
   ScreenGui:Destroy()
end)

MinimizeBtn.MouseButton1Click:Connect(function()
   AnimateFrame(false)
   ToggleBtn.Visible = true
end)

ToggleBtn.MouseButton1Click:Connect(function()
   if MainFrame.Visible then
      AnimateFrame(false)
   else
      AnimateFrame(true)
   end
end)
