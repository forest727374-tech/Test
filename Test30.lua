-- // KECUYA HUB (ANIME EDITION)
-- // Author: @kecuya | Key: Guest666

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

local CorrectKey = "Guest666"

-- ИЗОБРАЖЕНИЯ (Asset ID)
local ANIME_CHARACTER_IMAGE = "rbxassetid://6071575925" -- Иконка/тянка
local ANIME_BACKGROUND_IMAGE = "rbxassetid://6071579140" -- Аниме фон

-- Очистка старых UI
local playerGui = LocalPlayer:WaitForChild("PlayerGui")
if playerGui and playerGui:FindFirstChild("KecuyaSmoothHub") then
   playerGui.KecuyaSmoothHub:Destroy()
end

-- ==========================================
-- 1. ФЛАГИ И НАСТРОЙКИ
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

local SelectedRock = "Medium Rock"
local TargetRebirthValue = 100
local FlySpeed = 50
local SelectedTargetPlayer = nil
local MobileUp, MobileDown = false, false
local StartTime = tick()
local SavedPosition = nil

local RockList = {"Medium Rock", "Large Rock", "Huge Rock", "Legends Rock", "Jungle Rock", "Muscle King Rock"}

-- ==========================================
-- 2. ИНТЕРФЕЙС
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KecuyaSmoothHub"
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
FlyUpBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 38)
FlyUpBtn.Text = "▲\nUp"
FlyUpBtn.TextColor3 = Color3.fromRGB(192, 132, 252)
FlyUpBtn.Font = Enum.Font.GothamMedium
FlyUpBtn.TextSize = 10
FlyUpBtn.Parent = MobileFlyFrame
Instance.new("UICorner", FlyUpBtn).CornerRadius = UDim.new(0, 8)

local FlyDownBtn = Instance.new("TextButton")
FlyDownBtn.Size = UDim2.new(1, 0, 0, 42)
FlyDownBtn.Position = UDim2.new(0, 0, 0, 48)
FlyDownBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 38)
FlyDownBtn.Text = "▼\nDown"
FlyDownBtn.TextColor3 = Color3.fromRGB(192, 132, 252)
FlyDownBtn.Font = Enum.Font.GothamMedium
FlyDownBtn.TextSize = 10
FlyDownBtn.Parent = MobileFlyFrame
Instance.new("UICorner", FlyDownBtn).CornerRadius = UDim.new(0, 8)

FlyUpBtn.MouseButton1Down:Connect(function() MobileUp = true end)
FlyUpBtn.MouseButton1Up:Connect(function() MobileUp = false end)
FlyDownBtn.MouseButton1Down:Connect(function() MobileDown = true end)
FlyDownBtn.MouseButton1Up:Connect(function() MobileDown = false end)

-- Плавающая кнопка
local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(16, 16, 26)
ToggleBtn.Image = ANIME_CHARACTER_IMAGE
ToggleBtn.Visible = false
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Color = Color3.fromRGB(192, 132, 252)
ToggleStroke.Thickness = 2

-- Окно Входа (Key System)
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 280, 0, 180)
KeyFrame.Position = UDim2.new(0.5, -140, 0.5, -90)
KeyFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
KeyFrame.ClipsDescendants = true
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = ScreenGui
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 14)

local KeyBg = Instance.new("ImageLabel")
KeyBg.Size = UDim2.new(1, 0, 1, 0)
KeyBg.Image = ANIME_BACKGROUND_IMAGE
KeyBg.ImageTransparency = 0.65
KeyBg.ScaleType = Enum.ScaleType.Crop
KeyBg.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke", KeyFrame)
KeyStroke.Color = Color3.fromRGB(168, 85, 247)
KeyStroke.Thickness = 1.5

-- Аниме аватарка на меню входа
local KeyAvatar = Instance.new("ImageLabel")
KeyAvatar.Size = UDim2.new(0, 40, 0, 40)
KeyAvatar.Position = UDim2.new(0.5, -20, 0, 10)
KeyAvatar.Image = ANIME_CHARACTER_IMAGE
KeyAvatar.BackgroundTransparency = 1
KeyAvatar.Parent = KeyFrame
Instance.new("UICorner", KeyAvatar).CornerRadius = UDim.new(1, 0)

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 20)
KeyTitle.Position = UDim2.new(0, 0, 0, 52)
KeyTitle.Text = "KECUYA HUB  •  ACCESS"
KeyTitle.TextColor3 = Color3.fromRGB(240, 240, 255)
KeyTitle.TextSize = 10
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.BackgroundTransparency = 1
KeyTitle.Parent = KeyFrame

local KeyInputBox = Instance.new("Frame")
KeyInputBox.Size = UDim2.new(0.85, 0, 0, 32)
KeyInputBox.Position = UDim2.new(0.075, 0, 0.45, 0)
KeyInputBox.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
KeyInputBox.Parent = KeyFrame
Instance.new("UICorner", KeyInputBox).CornerRadius = UDim.new(0, 8)
local KeyInputStroke = Instance.new("UIStroke", KeyInputBox)
KeyInputStroke.Color = Color3.fromRGB(60, 60, 80)
KeyInputStroke.Thickness = 1

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -16, 1, 0)
KeyInput.Position = UDim2.new(0, 8, 0, 0)
KeyInput.PlaceholderText = "🔑 Введите пароль..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.BackgroundTransparency = 1
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 10
KeyInput.Parent = KeyInputBox

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.85, 0, 0, 30)
SubmitBtn.Position = UDim2.new(0.075, 0, 0.72, 0)
SubmitBtn.Text = "Авторизоваться"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 10
SubmitBtn.Parent = KeyFrame
Instance.new("UICorner", SubmitBtn).CornerRadius = UDim.new(0, 8)

-- Главное Меню
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 370, 0, 240)
MainFrame.Position = UDim2.new(0.5, -185, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local MainBg = Instance.new("ImageLabel")
MainBg.Size = UDim2.new(1, 0, 1, 0)
MainBg.Image = ANIME_BACKGROUND_IMAGE
MainBg.ImageTransparency = 0.75
MainBg.ScaleType = Enum.ScaleType.Crop
MainBg.Parent = MainFrame

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(168, 85, 247)
MainStroke.Thickness = 1.5

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 32)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
TopBar.BackgroundTransparency = 0.2
TopBar.Parent = MainFrame

local AnimeIcon = Instance.new("ImageLabel")
AnimeIcon.Size = UDim2.new(0, 22, 0, 22)
AnimeIcon.Position = UDim2.new(0, 8, 0, 5)
AnimeIcon.Image = ANIME_CHARACTER_IMAGE
AnimeIcon.BackgroundTransparency = 1
AnimeIcon.Parent = TopBar
Instance.new("UICorner", AnimeIcon).CornerRadius = UDim.new(1, 0)

local MainTitle = Instance.new("TextLabel")
MainTitle.Size = UDim2.new(0, 120, 1, 0)
MainTitle.Position = UDim2.new(0, 36, 0, 0)
MainTitle.Text = "Kecuya Hub"
MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTitle.TextSize = 11
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextXAlignment = Enum.TextXAlignment.Left
MainTitle.BackgroundTransparency = 1
MainTitle.Parent = TopBar

local AuthorTag = Instance.new("TextLabel")
AuthorTag.Size = UDim2.new(0, 100, 1, 0)
AuthorTag.Position = UDim2.new(0, 105, 0, 0)
AuthorTag.Text = "@kecuya"
AuthorTag.TextColor3 = Color3.fromRGB(192, 132, 252)
AuthorTag.TextSize = 9
AuthorTag.Font = Enum.Font.GothamBold
AuthorTag.TextXAlignment = Enum.TextXAlignment.Left
AuthorTag.BackgroundTransparency = 1
AuthorTag.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -28, 0, 4)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(239, 68, 68)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
CloseBtn.Parent = TopBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
MinimizeBtn.Position = UDim2.new(1, -52, 0, 4)
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(180, 180, 210)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 12
MinimizeBtn.Parent = TopBar

local TabBar = Instance.new("ScrollingFrame")
TabBar.Size = UDim2.new(1, -16, 0, 26)
TabBar.Position = UDim2.new(0, 8, 0, 38)
TabBar.BackgroundTransparency = 1
TabBar.ScrollBarThickness = 0
TabBar.CanvasSize = UDim2.new(0, 0, 0, 0)
TabBar.AutomaticCanvasSize = Enum.AutomaticSize.X
TabBar.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout", TabBar)
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.Padding = UDim.new(0, 5)

local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -16, 1, -74)
ContentContainer.Position = UDim2.new(0, 8, 0, 68)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

local function AnimateFrame(show)
   if show then
      MainFrame.Size = UDim2.new(0, 200, 0, 100)
      MainFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
      MainFrame.BackgroundTransparency = 1
      MainFrame.Visible = true

      TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
         Size = UDim2.new(0, 370, 0, 240),
         Position = UDim2.new(0.5, -185, 0.5, -120),
         BackgroundTransparency = 0
      }):Play()
   else
      local tw = TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
         Size = UDim2.new(0, 150, 0, 60),
         Position = UDim2.new(0.5, -75, 0.5, -30),
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
-- 3. ВКЛАДКИ И ПЕРЕКЛЮЧАТЕЛИ
-- ==========================================
local Pages, TabButtons = {}, {}

local function CreateTab(name)
   local btn = Instance.new("TextButton")
   btn.Size = UDim2.new(0, 60, 1, 0)
   btn.Text = name
   btn.TextColor3 = Color3.fromRGB(140, 140, 165)
   btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
   btn.BackgroundTransparency = 0.3
   btn.Font = Enum.Font.GothamMedium
   btn.TextSize = 9
   btn.Parent = TabBar
   Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

   local scroll = Instance.new("ScrollingFrame")
   scroll.Size = UDim2.new(1, 0, 1, 0)
   scroll.BackgroundTransparency = 1
   scroll.Visible = false
   scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
   scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
   scroll.ScrollBarThickness = 2
   scroll.ScrollBarImageColor3 = Color3.fromRGB(168, 85, 247)
   scroll.Parent = ContentContainer

   local layout = Instance.new("UIListLayout", scroll)
   layout.Padding = UDim.new(0, 5)

   btn.MouseButton1Click:Connect(function()
      for _, p in pairs(Pages) do p.Visible = false end
      for _, b in pairs(TabButtons) do 
         TweenService:Create(b, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(140, 140, 165), BackgroundColor3 = Color3.fromRGB(20, 20, 30)}):Play()
      end
      scroll.Visible = true
      TweenService:Create(btn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255), BackgroundColor3 = Color3.fromRGB(147, 51, 234)}):Play()
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
   frame.Size = UDim2.new(1, -4, 0, 26)
   frame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
   frame.BackgroundTransparency = 0.2
   frame.Parent = parent
   Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

   local txt = Instance.new("TextLabel")
   txt.Size = UDim2.new(0, 220, 1, 0)
   txt.Position = UDim2.new(0, 10, 0, 0)
   txt.Text = name
   txt.TextColor3 = defaultState and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 175)
   txt.Font = Enum.Font.Gotham
   txt.TextSize = 9
   txt.TextXAlignment = Enum.TextXAlignment.Left
   txt.BackgroundTransparency = 1
   txt.Parent = frame

   local track = Instance.new("Frame")
   track.Size = UDim2.new(0, 32, 0, 16)
   track.Position = UDim2.new(1, -38, 0.5, -8)
   track.BackgroundColor3 = defaultState and Color3.fromRGB(147, 51, 234) or Color3.fromRGB(32, 32, 48)
   track.Parent = frame
   Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

   local knob = Instance.new("Frame")
   knob.Size = UDim2.new(0, 12, 0, 12)
   knob.Position = defaultState and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
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
      local targetKnobPos = state and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
      local targetTrackColor = state and Color3.fromRGB(147, 51, 234) or Color3.fromRGB(32, 32, 48)
      local targetTextColor = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 175)

      TweenService:Create(knob, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetKnobPos}):Play()
      TweenService:Create(track, TweenInfo.new(0.2), {BackgroundColor3 = targetTrackColor}):Play()
      TweenService:Create(txt, TweenInfo.new(0.2), {TextColor3 = targetTextColor}):Play()

      callback(state)
   end)
end

-- ==========================================
-- 4. СТАТУС И КАРМА
-- ==========================================
local function GetKarmaValues(p)
   local goodVal, evilVal = 0, 0
   if not p then return 0, 0 end
   
   local lStats = p:FindFirstChild("leaderstats")
   if lStats then
      for _, stat in pairs(lStats:GetChildren()) do
         local n = stat.Name:lower()
         if n:find("good") then goodVal = stat.Value
         elseif n:find("evil") then evilVal = stat.Value end
      end
   end
   
   if goodVal == 0 and evilVal == 0 then
      if p:FindFirstChild("goodKarma") then goodVal = p.goodKarma.Value end
      if p:FindFirstChild("evilKarma") then evilVal = p.evilKarma.Value end
   end

   return goodVal, evilVal
end

local function CreateStatusLabel(text)
   local lbl = Instance.new("TextLabel")
   lbl.Size = UDim2.new(1, -4, 0, 24)
   lbl.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
   lbl.BackgroundTransparency = 0.2
   lbl.Text = "  " .. text
   lbl.TextColor3 = Color3.fromRGB(220, 220, 245)
   lbl.Font = Enum.Font.Gotham
   lbl.TextSize = 9
   lbl.TextXAlignment = Enum.TextXAlignment.Left
   lbl.Parent = StatusPg
   Instance.new("UICorner", lbl).CornerRadius = UDim.new(0, 6)
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

         local good, evil = GetKarmaValues(LocalPlayer)
         KarmaLabel.Text = "  😇 Карма: Добро [" .. good .. "] | Зло [" .. evil .. "]"

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
-- 5. ФИКС ФАРМА И ПОЛЕТА
-- ==========================================
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
      task.wait(Flags.FastPunch and 0.05 or 0.2)
   end
end)

local function GetRockPart(rockName)
   local nameLower = rockName:lower()
   for _, obj in pairs(Workspace:GetDescendants()) do
      if obj.Name:lower():find(nameLower) or (obj.Parent and obj.Parent.Name:lower():find(nameLower)) then
         if obj:IsA("BasePart") then
            return obj
         elseif obj:IsA("Model") then
            return obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
         end
      end
   end
   return nil
end

RunService.RenderStepped:Connect(function()
   if Flags.AirRock then
      pcall(function()
         local char = LocalPlayer.Character
         if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local rockPart = GetRockPart(SelectedRock)

            if rockPart then
               rockPart.CanCollide = false
               rockPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -5)

               local punch = char:FindFirstChild("Punch") or LocalPlayer.Backpack:FindFirstChild("Punch")
               if punch then
                  punch.Parent = char
                  punch:Activate()
               end

               local pEvent = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("punchEvent")
               if pEvent then
                  pEvent:FireServer("punchAttack")
               end
            end
          end
      end)
   end
end)

RunService.RenderStepped:Connect(function(dt)
   pcall(function()
      local char = LocalPlayer.Character
      if not char or not char:FindFirstChild("HumanoidRootPart") then return end
      local hrp = char.HumanoidRootPart
      local hum = char:FindFirstChildOfClass("Humanoid")
      local cam = Workspace.CurrentCamera

      if Flags.Fly then
         hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
         hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

         local moveDir = Vector3.zero
         if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
         if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
         if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
         if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
         if UserInputService:IsKeyDown(Enum.KeyCode.Space) or MobileUp then moveDir = moveDir + Vector3.new(0, 1, 0) end
         if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or MobileDown then moveDir = moveDir - Vector3.new(0, 1, 0) end

         if moveDir.Magnitude > 0 then
            moveDir = moveDir.Unit
            hrp.CFrame = CFrame.new(hrp.Position + (moveDir * FlySpeed * dt), hrp.Position + cam.CFrame.LookVector)
         else
            hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + cam.CFrame.LookVector)
         end
      end
   end)
end)

-- ==========================================
-- 6. АТАКА И ЦЕЛИ
-- ==========================================
local function IsFriend(p)
   if not Flags.IgnoreFriends then return false end
   if p == LocalPlayer then return true end
   local ok, res = pcall(function() return LocalPlayer:IsFriendsWith(p.UserId) end)
   return ok and res
end

local function ExecuteAttack(targetPlayer)
   pcall(function()
      if not targetPlayer or targetPlayer == LocalPlayer or IsFriend(targetPlayer) then return end
      local tChar = targetPlayer.Character
      if not tChar or not tChar:FindFirstChild("HumanoidRootPart") or not tChar:FindFirstChildOfClass("Humanoid") then return end
      if tChar:FindFirstChildOfClass("Humanoid").Health <= 0 then return end

      local myChar = LocalPlayer.Character
      if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end

      local punch = myChar:FindFirstChild("Punch") or LocalPlayer.Backpack:FindFirstChild("Punch")
      if punch then
         punch.Parent = myChar
         punch:Activate()
      end

      local rEvents = ReplicatedStorage:FindFirstChild("rEvents")
      if rEvents then
         local pEvent = rEvents:FindFirstChild("punchEvent")
         if pEvent then pEvent:FireServer("punchAttack") end
      end

      if punch and punch:FindFirstChild("punchHit") then
         punch.punchHit:FireServer(tChar.HumanoidRootPart)
      end
   end)
end

task.spawn(function()
   while true do
      pcall(function()
         for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and not IsFriend(p) then
               local good, evil = GetKarmaValues(p)
               
               if Flags.AutoKillAir then
                  ExecuteAttack(p)
               elseif Flags.FarmGoodKarma and evil > 0 then
                  ExecuteAttack(p)
               elseif Flags.FarmEvilKarma and (good > 0 or evil == 0) then
                  ExecuteAttack(p)
               elseif Flags.TargetKill and SelectedTargetPlayer then
                  if p == SelectedTargetPlayer then
                     ExecuteAttack(p)
                  end
               end
            end
         end
      end)
      task.wait(0.01)
   end
end)

-- ANTI-KNOCKBACK & AUTO POSITION
task.spawn(function()
   while true do
      pcall(function()
         local char = LocalPlayer.Character
         if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            
            if Flags.AntiKnockback then
               for _, v in pairs(hrp:GetChildren()) do
                  if v:IsA("BodyVelocity") or v:IsA("BodyForce") or v:IsA("VectorForce") then
                     v:Destroy()
                  end
               end
            end
            
            if Flags.AutoPosition and SavedPosition then
               if (hrp.Position - SavedPosition.Position).Magnitude > 5 then
                  hrp.CFrame = SavedPosition
               end
            end
         end
      end)
      task.wait(0.1)
   end
end)

-- ==========================================
-- 7. НАСТРОЙКИ UI
-- ==========================================
CreateToggle(RockPg, "Авто-Фарм Камня (Хитбокс)", Flags.AirRock, function(v) Flags.AirRock = v end)

local DropdownFrame = Instance.new("Frame")
DropdownFrame.Size = UDim2.new(1, -4, 0, 28)
DropdownFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
DropdownFrame.BackgroundTransparency = 0.2
DropdownFrame.ClipsDescendants = true
DropdownFrame.Parent = RockPg
Instance.new("UICorner", DropdownFrame).CornerRadius = UDim.new(0, 6)

local DropdownBtn = Instance.new("TextButton")
DropdownBtn.Size = UDim2.new(1, 0, 0, 28)
DropdownBtn.Text = "  Выбрать камень: " .. SelectedRock .. "  ▼"
DropdownBtn.TextColor3 = Color3.fromRGB(192, 132, 252)
DropdownBtn.Font = Enum.Font.GothamMedium
DropdownBtn.TextSize = 9
DropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
DropdownBtn.BackgroundTransparency = 1
DropdownBtn.Parent = DropdownFrame

local DropdownList = Instance.new("Frame")
DropdownList.Size = UDim2.new(1, 0, 0, #RockList * 22)
DropdownList.Position = UDim2.new(0, 0, 0, 28)
DropdownList.BackgroundTransparency = 1
DropdownList.Parent = DropdownFrame

Instance.new("UIListLayout", DropdownList).Padding = UDim.new(0, 2)

local isExpanded = false
DropdownBtn.MouseButton1Click:Connect(function()
   isExpanded = not isExpanded
   local targetSize = isExpanded and UDim2.new(1, -4, 0, 28 + (#RockList * 24)) or UDim2.new(1, -4, 0, 28)
   TweenService:Create(DropdownFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize}):Play()
end)

for _, rName in pairs(RockList) do
   local itemBtn = Instance.new("TextButton")
   itemBtn.Size = UDim2.new(1, -8, 0, 22)
   itemBtn.Position = UDim2.new(0, 4, 0, 0)
   itemBtn.Text = "   " .. rName
   itemBtn.TextColor3 = Color3.fromRGB(160, 160, 185)
   itemBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 36)
   itemBtn.Font = Enum.Font.Gotham
   itemBtn.TextSize = 8
   itemBtn.TextXAlignment = Enum.TextXAlignment.Left
   itemBtn.Parent = DropdownList
   Instance.new("UICorner", itemBtn).CornerRadius = UDim.new(0, 4)

   itemBtn.MouseButton1Click:Connect(function()
      SelectedRock = rName
      DropdownBtn.Text = "  Выбрать камень: " .. SelectedRock .. "  ▼"
      isExpanded = false
      TweenService:Create(DropdownFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, -4, 0, 28)}):Play()
   end)
end

-- Вкладка Качалка
CreateToggle(BenchPg, "Гантели (Dumbbell)", Flags.AutoDumbbell, function(v) Flags.AutoDumbbell = v end)
CreateToggle(BenchPg, "Отжимания (Pushups)", Flags.AutoPushups, function(v) Flags.AutoPushups = v end)
CreateToggle(BenchPg, "Пресс (Situps)", Flags.AutoSitups, function(v) Flags.AutoSitups = v end)
CreateToggle(BenchPg, "Удары (Punch)", Flags.AutoPunch, function(v) Flags.AutoPunch = v end)
CreateToggle(BenchPg, "Быстрый клик", Flags.FastPunch, function(v) Flags.FastPunch = v end)

-- Вкладка Атака
CreateToggle(KillPg, "Игнорировать друзей", Flags.IgnoreFriends, function(v) Flags.IgnoreFriends = v end)
CreateToggle(KillPg, "Убивать всех (Auto Kill)", Flags.AutoKillAir, function(v) Flags.AutoKillAir = v end)
CreateToggle(KillPg, "Фарм Good Karma", Flags.FarmGoodKarma, function(v) Flags.FarmGoodKarma = v end)
CreateToggle(KillPg, "Фарм Evil Karma", Flags.FarmEvilKarma, function(v) Flags.FarmEvilKarma = v end)

-- ВЫБОР ИГРОКОВ (TARGET SELECTOR)
local PlayerDropdownFrame = Instance.new("Frame")
PlayerDropdownFrame.Size = UDim2.new(1, -4, 0, 28)
PlayerDropdownFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
PlayerDropdownFrame.BackgroundTransparency = 0.2
PlayerDropdownFrame.ClipsDescendants = true
PlayerDropdownFrame.Parent = KillPg
Instance.new("UICorner", PlayerDropdownFrame).CornerRadius = UDim.new(0, 6)

local PlayerDropdownBtn = Instance.new("TextButton")
PlayerDropdownBtn.Size = UDim2.new(1, 0, 0, 28)
PlayerDropdownBtn.Text = "  🎯 Выберите цель: Не выбран  ▼"
PlayerDropdownBtn.TextColor3 = Color3.fromRGB(192, 132, 252)
PlayerDropdownBtn.Font = Enum.Font.GothamMedium
PlayerDropdownBtn.TextSize = 9
PlayerDropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
PlayerDropdownBtn.BackgroundTransparency = 1
PlayerDropdownBtn.Parent = PlayerDropdownFrame

local PlayerListContainer = Instance.new("ScrollingFrame")
PlayerListContainer.Size = UDim2.new(1, -8, 0, 100)
PlayerListContainer.Position = UDim2.new(0, 4, 0, 30)
PlayerListContainer.BackgroundTransparency = 1
PlayerListContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerListContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
PlayerListContainer.ScrollBarThickness = 2
PlayerListContainer.ScrollBarImageColor3 = Color3.fromRGB(168, 85, 247)
PlayerListContainer.Parent = PlayerDropdownFrame

local PlayerListLayout = Instance.new("UIListLayout", PlayerListContainer)
PlayerListLayout.Padding = UDim.new(0, 3)

local RefreshPlayersBtn = Instance.new("TextButton")
RefreshPlayersBtn.Size = UDim2.new(1, -8, 0, 22)
RefreshPlayersBtn.Text = "🔄 Обновить список игроков"
RefreshPlayersBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
RefreshPlayersBtn.TextColor3 = Color3.fromRGB(240, 240, 255)
RefreshPlayersBtn.Font = Enum.Font.GothamMedium
RefreshPlayersBtn.TextSize = 8
RefreshPlayersBtn.Parent = PlayerListContainer
Instance.new("UICorner", RefreshPlayersBtn).CornerRadius = UDim.new(0, 4)

local isPlayerExpanded = false

local function UpdatePlayerList()
   for _, child in pairs(PlayerListContainer:GetChildren()) do
      if child:IsA("TextButton") and child ~= RefreshPlayersBtn then
         child:Destroy()
      end
   end

   for _, p in pairs(Players:GetPlayers()) do
      if p ~= LocalPlayer and not IsFriend(p) then
         local pBtn = Instance.new("TextButton")
         pBtn.Size = UDim2.new(1, 0, 0, 22)
         pBtn.Text = "   " .. p.DisplayName .. " (@" .. p.Name .. ")"
         pBtn.TextColor3 = Color3.fromRGB(180, 180, 205)
         pBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 36)
         pBtn.Font = Enum.Font.Gotham
         pBtn.TextSize = 8
         pBtn.TextXAlignment = Enum.TextXAlignment.Left
         pBtn.Parent = PlayerListContainer
         Instance.new("UICorner", pBtn).CornerRadius = UDim.new(0, 4)

         pBtn.MouseButton1Click:Connect(function()
            SelectedTargetPlayer = p
            PlayerDropdownBtn.Text = "  🎯 Цель: " .. p.DisplayName .. "  ▼"
            isPlayerExpanded = false
            TweenService:Create(PlayerDropdownFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, -4, 0, 28)}):Play()
         end)
      end
   end
end

RefreshPlayersBtn.MouseButton1Click:Connect(UpdatePlayerList)

PlayerDropdownBtn.MouseButton1Click:Connect(function()
   isPlayerExpanded = not isPlayerExpanded
   if isPlayerExpanded then
      UpdatePlayerList()
   end
   local targetSize = isPlayerExpanded and UDim2.new(1, -4, 0, 138) or UDim2.new(1, -4, 0, 28)
   TweenService:Create(PlayerDropdownFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize}):Play()
end)

CreateToggle(KillPg, "Убивать выбр. цель (Target Kill)", Flags.TargetKill, function(v) Flags.TargetKill = v end)

-- Вкладка Ребирт
local RebInput = Instance.new("TextBox")
RebInput.Size = UDim2.new(1, -4, 0, 24)
RebInput.PlaceholderText = "Лимит ребиртов (100)"
RebInput.Text = "100"
RebInput.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
RebInput.BackgroundTransparency = 0.2
RebInput.TextColor3 = Color3.fromRGB(240, 240, 255)
RebInput.Font = Enum.Font.Gotham
RebInput.TextSize = 9
RebInput.Parent = RebirthPg
Instance.new("UICorner", RebInput).CornerRadius = UDim.new(0, 6)

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
               local rRemote = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("rebirthRemote")
               if rRemote then
                  rRemote:InvokeServer("rebirthRequest")
               end
            end
         end)
         task.wait(0.5)
      end
   end)
end)

-- Вкладка Защита / Полет
CreateToggle(UtilityPg, "Anti-Knockback", Flags.AntiKnockback, function(v) Flags.AntiKnockback = v end)

local SavePosBtn = Instance.new("TextButton")
SavePosBtn.Size = UDim2.new(1, -4, 0, 24)
SavePosBtn.Text = "Сохранить позицию"
SavePosBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 36)
SavePosBtn.TextColor3 = Color3.fromRGB(192, 132, 252)
SavePosBtn.Font = Enum.Font.GothamMedium
SavePosBtn.TextSize = 9
SavePosBtn.Parent = UtilityPg
Instance.new("UICorner", SavePosBtn).CornerRadius = UDim.new(0, 6)

SavePosBtn.MouseButton1Click:Connect(function()
   pcall(function()
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
         SavedPosition = LocalPlayer.Character.HumanoidRootPart.CFrame
         SavePosBtn.Text = "✓ Точка сохранена!"
         task.wait(1)
         SavePosBtn.Text = "Сохранить позицию"
      end
   end)
end)

CreateToggle(UtilityPg, "Авто Позиция", Flags.AutoPosition, function(v) Flags.AutoPosition = v end)

local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(1, -4, 0, 24)
SpeedInput.PlaceholderText = "Скорость полета (50)"
SpeedInput.Text = "50"
SpeedInput.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
SpeedInput.BackgroundTransparency = 0.2
SpeedInput.TextColor3 = Color3.fromRGB(240, 240, 255)
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.TextSize = 9
SpeedInput.Parent = UtilityPg
Instance.new("UICorner", SpeedInput).CornerRadius = UDim.new(0, 6)

SpeedInput.FocusLost:Connect(function() FlySpeed = tonumber(SpeedInput.Text) or 50 end)
CreateToggle(UtilityPg, "Полет (Fly)", Flags.Fly, function(v) 
   Flags.Fly = v 
   MobileFlyFrame.Visible = v 
end)

-- ==========================================
-- 8. ЛОГИКА АВТОРИЗАЦИИ
-- ==========================================
local function AttemptLogin()
   local enteredKey = string.match(KeyInput.Text, "^%s*(.-)%s*$") or ""
   if enteredKey == CorrectKey then
      KeyFrame.Visible = false
      ToggleBtn.Visible = true
      AnimateFrame(true)
   else
      KeyInputStroke.Color = Color3.fromRGB(239, 68, 68)
      KeyInput.Text = ""
      KeyInput.PlaceholderText = "❌ Неверный пароль!"
      task.wait(1)
      KeyInputStroke.Color = Color3.fromRGB(60, 60, 80)
      KeyInput.PlaceholderText = "🔑 Введите пароль..."
   end
end

SubmitBtn.MouseButton1Click:Connect(AttemptLogin)
KeyInput.FocusLost:Connect(function(enterPressed) if enterPressed then AttemptLogin() end end)

CloseBtn.MouseButton1Click:Connect(function()
   AnimateFrame(false)
   task.wait(0.3)
   ScreenGui:Destroy()
end)

MinimizeBtn.MouseButton1Click:Connect(function()
   AnimateFrame(false)
   ToggleBtn.Visible = true
end)

ToggleBtn.MouseButton1Click:Connect(function()
   if MainFrame.Visible then AnimateFrame(false) else AnimateFrame(true) end
end)
