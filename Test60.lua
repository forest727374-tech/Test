if _G.MainScriptLoaded then
    warn("🚫 Main script already loaded. Preventing duplicate execution.")
    return
end

-- ============================================================================
-- 🔑 КРАСИВАЯ ANIME-INSPIRED СИСТЕМА ДОСТУПА
-- ============================================================================
local CORRECT_PASSWORD = "@kecuya"

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KecuyaAuthGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui:FindFirstChild("RobloxGui") or CoreGui

-- Тёмный фон-затемнение
local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
Overlay.BackgroundTransparency = 1
Overlay.Parent = ScreenGui

-- Главная карточка авторизации
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 340, 0, 240)
Frame.Position = UDim2.new(0.5, -170, 0.5, -110)
Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Frame.BorderSizePixel = 0
Frame.BackgroundTransparency = 1
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = Frame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(180, 80, 255)
UIStroke.Transparency = 0.6
UIStroke.Thickness = 1.2
UIStroke.Parent = Frame

-- Верхняя акцентная неоновая полоса
local AccentLine = Instance.new("Frame")
AccentLine.Size = UDim2.new(0.6, 0, 0, 2)
AccentLine.Position = UDim2.new(0.2, 0, 0, 0)
AccentLine.BackgroundColor3 = Color3.fromRGB(200, 100, 255)
AccentLine.BorderSizePixel = 0
AccentLine.Parent = Frame

local LineCorner = Instance.new("UICorner")
LineCorner.CornerRadius = UDim.new(1, 0)
LineCorner.Parent = AccentLine

-- Заголовок KECUYA HUB
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 32)
Title.Position = UDim2.new(0, 0, 0, 18)
Title.BackgroundTransparency = 1
Title.Text = "KECUYA HUB"
Title.TextColor3 = Color3.fromRGB(245, 245, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

-- Subtitle Private Access
local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, 0, 0, 18)
Subtitle.Position = UDim2.new(0, 0, 0, 50)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "✧ PRIVATE ACCESS ✧"
Subtitle.TextColor3 = Color3.fromRGB(180, 80, 255)
Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.GothamBold
Subtitle.Parent = Frame

-- Поле ввода пароля
local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0.82, 0, 0, 42)
TextBox.Position = UDim2.new(0.09, 0, 0.38, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 34)
TextBox.TextColor3 = Color3.fromRGB(240, 240, 255)
TextBox.PlaceholderText = "Enter Access Key..."
TextBox.PlaceholderColor3 = Color3.fromRGB(110, 110, 130)
TextBox.Text = ""
TextBox.TextSize = 13
TextBox.Font = Enum.Font.GothamMedium
TextBox.ClearTextOnFocus = false
TextBox.Parent = Frame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 8)
BoxCorner.Parent = TextBox

local BoxStroke = Instance.new("UIStroke")
BoxStroke.Color = Color3.fromRGB(45, 45, 60)
BoxStroke.Thickness = 1
BoxStroke.Parent = TextBox

-- Кнопка LOGIN
local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.82, 0, 0, 42)
SubmitBtn.Position = UDim2.new(0.09, 0, 0.65, 0)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(180, 80, 255)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Text = "LOGIN"
SubmitBtn.TextSize = 13
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.AutoButtonColor = false
SubmitBtn.Parent = Frame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = SubmitBtn

local BtnGradient = Instance.new("UIGradient")
BtnGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(190, 90, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 50, 220))
}
BtnGradient.Parent = SubmitBtn

-- Подсказка / Ошибки
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0.82, 0, 0, 18)
StatusLabel.Position = UDim2.new(0.09, 0, 0.87, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = Frame

-- Анимации для кнопки
SubmitBtn.MouseEnter:Connect(function()
    TweenService:Create(SubmitBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 110, 255)}):Play()
end)

SubmitBtn.MouseLeave:Connect(function()
    TweenService:Create(SubmitBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(180, 80, 255)}):Play()
end)

-- Плавное появление (Fade In)
TweenService:Create(Overlay, TweenInfo.new(0.4), {BackgroundTransparency = 0.4}):Play()
TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()

local authenticated = false

local function verifyPassword()
    -- Анимация клика
    local scaleDown = TweenService:Create(SubmitBtn, TweenInfo.new(0.08), {Size = UDim2.new(0.78, 0, 0, 38), Position = UDim2.new(0.11, 0, 0.66, 0)})
    local scaleUp = TweenService:Create(SubmitBtn, TweenInfo.new(0.08), {Size = UDim2.new(0.82, 0, 0, 42), Position = UDim2.new(0.09, 0, 0.65, 0)})
    scaleDown:Play()
    scaleDown.Completed:Wait()
    scaleUp:Play()

    if TextBox.Text == CORRECT_PASSWORD then
        authenticated = true
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 160)
        StatusLabel.Text = "Access Granted! Loading..."
        
        -- Плавное исчезновение (Fade Out)
        TweenService:Create(Overlay, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        local fadeOut = TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {BackgroundTransparency = 1})
        fadeOut:Play()
        fadeOut.Completed:Wait()
        
        ScreenGui:Destroy()
    else
        TextBox.Text = ""
        BoxStroke.Color = Color3.fromRGB(255, 70, 70)
        StatusLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
        StatusLabel.Text = "Invalid Passcode. Try again."
        
        -- Лёгкое покачивание поля при ошибке
        task.spawn(function()
            local origPos = UDim2.new(0.09, 0, 0.38, 0)
            for _, offset in ipairs({-6, 6, -4, 4, -2, 2, 0}) do
                TextBox.Position = UDim2.new(0.09, offset, 0.38, 0)
                task.wait(0.03)
            end
            TextBox.Position = origPos
            task.wait(1.5)
            BoxStroke.Color = Color3.fromRGB(45, 45, 60)
        end)
    end
end

SubmitBtn.MouseButton1Click:Connect(verifyPassword)
TextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        verifyPassword()
    end
end)

repeat task.wait(0.1) until authenticated
_G.MainScriptLoaded = true

-- ============================================================================
-- 📚 ИНИЦИАЛИЗА БИБЛИОТЕК И ИНТЕРФЕЙСА
-- ============================================================================
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/main/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/main/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/main/Addons/InterfaceManager.lua"))()

local Window = Library:CreateWindow{
    Title = "Private Script of SLH",
    SubTitle = "By SLH_YAMO",
    TabWidth = 125,
    Size = UDim2.fromOffset(830, 525),
    Resize = true,
    MinSize = Vector2.new(470, 380),
    Acrylic = true,
    Theme = "DuoTone Dark Sea",
    MinimizeKey = Enum.KeyCode.RightControl
}

local Tabs = {
    Main = Window:CreateTab{ Title = "Main", Icon = "phosphor-house-bold" },
    AutoBuy = Window:CreateTab{ Title = "Auto Buy", Icon = "phosphor-shopping-cart-bold" },
    AutoStuff = Window:CreateTab{ Title = "Auto Stuff", Icon = "phosphor-gear-bold" },
    AutoFarm = Window:CreateTab{ Title = "Auto Farm", Icon = "phosphor-robot-bold" },
    Rebirth = Window:CreateTab{ Title = "Rebirth", Icon = "phosphor-arrows-clockwise-bold" },
    Killer = Window:CreateTab{ Title = "Killer", Icon = "phosphor-sword-bold" },
    Crystals = Window:CreateTab{ Title = "Crystals", Icon = "phosphor-diamond-bold" },
    Teleport = Window:CreateTab{ Title = "Teleport", Icon = "phosphor-dog-bold" },
    Stats = Window:CreateTab{ Title = "Stats", Icon = "phosphor-sparkle-bold" },
    Misc = Window:CreateTab{ Title = "Misc", Icon = "phosphor-map-pin-bold" },
    Settings = Window:CreateTab{ Title = "Settings", Icon = "phosphor-sliders-bold" }
}

local Options = Library.Options  
local MainSection = Tabs.Main:CreateSection("Basic Controls")
local selectedSize = "2"
local selectedSpeed = "125"
local targetPlayer = ""
local selectedCrystal1 = "Blue Crystal"
local selectedCrystal2 = "Legend Crystal"
local selecttreadmill = "Tiny Island"

-- Вспомогательная функция экипировки Punch
function gettool()
    local p = game.Players.LocalPlayer
    if not p then return end
    local backpack = p:FindFirstChild("Backpack")
    local char = p.Character
    if backpack and char and char:FindFirstChild("Humanoid") then
        local punch = backpack:FindFirstChild("Punch")
        if punch then
            char.Humanoid:EquipTool(punch)
        end
    end
    if p:FindFirstChild("muscleEvent") then
        p.muscleEvent:FireServer("punch", "leftHand")
        p.muscleEvent:FireServer("punch", "rightHand")
    end
end

-- ============================================================================
-- 🏠 TAB: MAIN
-- ============================================================================
MainSection:AddInput("SizeChanger", {
    Title = "Size Changer",
    Description = "Enter Size",
    Default = "2",
    Placeholder = "Type here...",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        selectedSize = Value
        if _G.AutoSize then
            pcall(function()
                game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", tonumber(selectedSize))
            end)
        end
    end
})

Tabs.Main:CreateToggle("AutoSize", {
    Title = "Auto Set Size",
    Description = "Auto Set ur Choosed Size",
    Default = false,
    Callback = function(Value)
        _G.AutoSize = Value
        if Value then
            task.spawn(function()
                while _G.AutoSize do
                    pcall(function()
                        game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", tonumber(selectedSize))
                    end)
                    task.wait(0.1)
                end
            end)
        end
    end
})

Tabs.Main:CreateInput("SpeedChanger", {
    Title = "Speed Changer",
    Description = "Enter Speed",
    Default = "125",
    Placeholder = "Enter Speed",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        selectedSpeed = Value
        if _G.AutoSpeed then
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = tonumber(selectedSpeed) or 16
            end
        end
    end
})

Tabs.Main:CreateToggle("AutoSpeed", {
    Title = "Auto Set Speed",
    Description = "Auto Set ur Choosed Speed",
    Default = false,
    Callback = function(Value)
        _G.AutoSpeed = Value
        if Value then
            task.spawn(function()
                while _G.AutoSpeed do
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("Humanoid") then
                        char.Humanoid.WalkSpeed = tonumber(selectedSpeed) or 16
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})

Tabs.Main:CreateButton{
    Title = "Free AutoLift Gamepass",
    Callback = function()
        pcall(function()
            local gamepassFolder = game:GetService("ReplicatedStorage"):FindFirstChild("gamepassIds")
            local plr = game:GetService("Players").LocalPlayer
            if gamepassFolder and plr:FindFirstChild("ownedGamepasses") then
                for _, gamepass in pairs(gamepassFolder:GetChildren()) do
                    local value = Instance.new("IntValue")
                    value.Name = gamepass.Name
                    value.Value = gamepass.Value
                    value.Parent = plr.ownedGamepasses
                end
            end
        end)
    end
}

local waterPart = nil
local function createParts()
    if not waterPart then
        waterPart = Instance.new("Part")
        waterPart.Name = "WaterWalkPlatform"
        waterPart.Size = Vector3.new(2000, 1, 2000)
        waterPart.Position = Vector3.new(0, 2, 0)
        waterPart.Anchored = true
        waterPart.Transparency = 0.5
        waterPart.Material = Enum.Material.SmoothPlastic
        waterPart.Parent = workspace
    end
end

local function makePartsWalkthrough()
    if waterPart then
        waterPart:Destroy()
        waterPart = nil
    end
end

Tabs.Main:CreateToggle("WalkOnWater", {
    Title = "Walk on Water",
    Description = "",
    Default = false,
    Callback = function(Value)
        if Value then
            createParts()
        else
            makePartsWalkthrough()
        end
    end
})

-- ============================================================================
-- 🌾 TAB: AUTO FARM
-- ============================================================================
Tabs.AutoFarm:CreateToggle("Weight", {
    Title = "Auto Weight",
    Description = "Auto Lift Weight",
    Default = false,
    Callback = function(Value)
        _G.AutoWeight = Value
        if Value then
            task.spawn(function()
                local plr = game.Players.LocalPlayer
                local weightTool = plr.Backpack:FindFirstChild("Weight")
                if weightTool and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                    plr.Character.Humanoid:EquipTool(weightTool)
                end
                while _G.AutoWeight do
                    if plr:FindFirstChild("muscleEvent") then
                        plr.muscleEvent:FireServer("rep")
                    end
                    task.wait(0.01)
                end
            end)
        else
            local char = game.Players.LocalPlayer.Character
            if char then
                local equipped = char:FindFirstChild("Weight")
                if equipped then
                    equipped.Parent = game.Players.LocalPlayer.Backpack
                end
            end
        end
    end
})

Tabs.AutoFarm:CreateToggle("Pushups", {
    Title = "Auto Pushups",
    Description = "Auto Lift Pushups",
    Default = false,
    Callback = function(Value)
        _G.AutoPushups = Value
        if Value then
            task.spawn(function()
                local plr = game.Players.LocalPlayer
                local pushupsTool = plr.Backpack:FindFirstChild("Pushups")
                if pushupsTool and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                    plr.Character.Humanoid:EquipTool(pushupsTool)
                end
                while _G.AutoPushups do
                    if plr:FindFirstChild("muscleEvent") then
                        plr.muscleEvent:FireServer("rep")
                    end
                    task.wait(0.01)
                end
            end)
        else
            local char = game.Players.LocalPlayer.Character
            if char then
                local equipped = char:FindFirstChild("Pushups")
                if equipped then
                    equipped.Parent = game.Players.LocalPlayer.Backpack
                end
            end
        end
    end
})

Tabs.AutoFarm:CreateToggle("Handstands", {
    Title = "Auto Handstands",
    Description = "Auto Lift Handstands",
    Default = false,
    Callback = function(Value)
        _G.AutoHandstands = Value
        if Value then
            task.spawn(function()
                local plr = game.Players.LocalPlayer
                local tool = plr.Backpack:FindFirstChild("Handstands")
                if tool and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                    plr.Character.Humanoid:EquipTool(tool)
                end
                while _G.AutoHandstands do
                    if plr:FindFirstChild("muscleEvent") then
                        plr.muscleEvent:FireServer("rep")
                    end
                    task.wait(0.01)
                end
            end)
        else
            local char = game.Players.LocalPlayer.Character
            if char then
                local equipped = char:FindFirstChild("Handstands")
                if equipped then
                    equipped.Parent = game.Players.LocalPlayer.Backpack
                end
            end
        end
    end
})

Tabs.AutoFarm:CreateToggle("Situps", {
    Title = "Auto Situps",
    Description = "Auto Lift Situps",
    Default = false,
    Callback = function(Value)
        _G.AutoSitups = Value
        if Value then
            task.spawn(function()
                local plr = game.Players.LocalPlayer
                local tool = plr.Backpack:FindFirstChild("Situps")
                if tool and plr.Character and plr.Character:FindFirstChild("Humanoid") then
                    plr.Character.Humanoid:EquipTool(tool)
                end
                while _G.AutoSitups do
                    if plr:FindFirstChild("muscleEvent") then
                        plr.muscleEvent:FireServer("rep")
                    end
                    task.wait(0.01)
                end
            end)
        else
            local char = game.Players.LocalPlayer.Character
            if char then
                local equipped = char:FindFirstChild("Situps")
                if equipped then
                    equipped.Parent = game.Players.LocalPlayer.Backpack
                end
            end
        end
    end
})

Tabs.AutoFarm:CreateToggle("Punch", {
    Title = "Auto Punch",
    Description = "Auto Punch",
    Default = false,
    Callback = function(Value)
        _G.fastHitActive = Value
        if Value then
            task.spawn(function()
                while _G.fastHitActive do
                    local player = game.Players.LocalPlayer
                    local punch = player.Backpack:FindFirstChild("Punch")
                    if punch and player.Character then
                        punch.Parent = player.Character
                        if punch:FindFirstChild("attackTime") then
                            punch.attackTime.Value = 0
                        end
                    end
                    task.wait(0.1)
                end
            end)
            task.spawn(function()
                while _G.fastHitActive do
                    local player = game.Players.LocalPlayer
                    if player:FindFirstChild("muscleEvent") then
                        player.muscleEvent:FireServer("punch", "rightHand")
                        player.muscleEvent:FireServer("punch", "leftHand")
                    end
                    local character = player.Character
                    if character then
                        local punchTool = character:FindFirstChild("Punch")
                        if punchTool then
                            punchTool:Activate()
                        end
                    end
                    task.wait(0.01)
                end
            end)
        else
            local character = game.Players.LocalPlayer.Character
                    if character then
                local equipped = character:FindFirstChild("Punch")
                if equipped then
                    equipped.Parent = game.Players.LocalPlayer.Backpack
                end
            end
        end
    end
})

Tabs.AutoFarm:CreateToggle("ToolSpeed", {
    Title = "Fast Tools",
    Description = "Fast Tools..., What u didn't get.",
    Default = false,
    Callback = function(Value)
        _G.FastTools = Value
        local defaultSpeeds = {
            {"Punch", "attackTime", Value and 0 or 0.35},
            {"Ground Slam", "attackTime", Value and 0 or 6},
            {"Stomp", "attackTime", Value and 0 or 7},
            {"Handstands", "repTime", Value and 0 or 1},
            {"Pushups", "repTime", Value and 0 or 1},
            {"Weight", "repTime", Value and 0 or 1},
            {"Situps", "repTime", Value and 0 or 1}
        }
        local player = game.Players.LocalPlayer
        local backpack = player:WaitForChild("Backpack")
        for _, toolInfo in ipairs(defaultSpeeds) do
            local tool = backpack:FindFirstChild(toolInfo[1])
            if tool and tool:FindFirstChild(toolInfo[2]) then
                tool[toolInfo[2]].Value = toolInfo[3]
            end
            local equippedTool = player.Character and player.Character:FindFirstChild(toolInfo[1])
            if equippedTool and equippedTool:FindFirstChild(toolInfo[2]) then
                equippedTool[toolInfo[2]].Value = toolInfo[3]
            end
        end
    end
})

-- ROCK FARM SECTION
local RockSection = Tabs.AutoFarm:CreateSection("Rock Farm")
local selectrock = ""

local function farmRockLogic(requiredDurability, rockName)
    selectrock = rockName
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait(0.05)
            local plr = game:GetService("Players").LocalPlayer
            local durability = plr:FindFirstChild("Durability")
            if durability and durability.Value >= requiredDurability then
                local machines = workspace:FindFirstChild("machinesFolder")
                if machines then
                    for _, v in pairs(machines:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == requiredDurability and plr.Character then
                            local leftHand = plr.Character:FindFirstChild("LeftHand")
                            local rightHand = plr.Character:FindFirstChild("RightHand")
                            local rock = v.Parent:FindFirstChild("Rock")
                            if rock and leftHand and rightHand then
                                firetouchinterest(rock, rightHand, 0)
                                firetouchinterest(rock, rightHand, 1)
                                firetouchinterest(rock, leftHand, 0)
                                firetouchinterest(rock, leftHand, 1)
                                gettool()
                            end
                        end
                    end
                end
            end
        end
    end)
end

Tabs.AutoFarm:CreateToggle("TinyIslandRock", {
    Title = "Farm Tiny Island Rock",
    Default = false,
    Callback = function(Value)
        getgenv().autoFarm = Value
        if Value then farmRockLogic(0, "Tiny Island Rock") end
    end
})

Tabs.AutoFarm:CreateToggle("StarterIslandRock", {
    Title = "Farm Starter Island Rock",
    Default = false,
    Callback = function(Value)
        getgenv().autoFarm = Value
        if Value then farmRockLogic(100, "Starter Island Rock") end
    end
})

Tabs.AutoFarm:CreateToggle("LegendBeachRock", {
    Title = "Farm Legend Beach Rock",
    Default = false,
    Callback = function(Value)
        getgenv().autoFarm = Value
        if Value then farmRockLogic(5000, "Legend Beach Rock") end
    end
})

Tabs.AutoFarm:CreateToggle("FrostGymRock", {
    Title = "Farm Frost Gym Rock",
    Default = false,
    Callback = function(Value)
        getgenv().autoFarm = Value
        if Value then farmRockLogic(150000, "Frost Gym Rock") end
    end
})

Tabs.AutoFarm:CreateToggle("MythicalGymRock", {
    Title = "Farm Mythical Gym Rock",
    Default = false,
    Callback = function(Value)
        getgenv().autoFarm = Value
        if Value then farmRockLogic(400000, "Mythical Gym Rock") end
    end
})

Tabs.AutoFarm:CreateToggle("EternalGymRock", {
    Title = "Farm Eternal Gym Rock",
    Default = false,
    Callback = function(Value)
        getgenv().autoFarm = Value
        if Value then farmRockLogic(750000, "Eternal Gym Rock") end
    end
})

Tabs.AutoFarm:CreateToggle("LegendGymRock", {
    Title = "Farm Legend Gym Rock",
    Default = false,
    Callback = function(Value)
        getgenv().autoFarm = Value
        if Value then farmRockLogic(1000000, "Legend Gym Rock") end
    end
})

Tabs.AutoFarm:CreateToggle("MuscleKingGymRock", {
    Title = "Farm Muscle King Gym Rock",
    Default = false,
    Callback = function(Value)
        getgenv().autoFarm = Value
        if Value then farmRockLogic(5000000, "Muscle King Gym Rock") end
    end
})

Tabs.AutoFarm:CreateToggle("AncientJungleRock", {
    Title = "Farm Ancient Jungle Rock",
    Default = false,
    Callback = function(Value)
        getgenv().autoFarm = Value
        if Value then farmRockLogic(10000000, "Ancient Jungle Rock") end
    end
})

-- ============================================================================
-- 🔄 TAB: REBIRTH
-- ============================================================================
local SectionRebirth = Tabs.Rebirth:CreateSection("AutoRebirth")

local targetRebirthValue = 1
local initialRebirths = 0
local plrLeaderstats = game.Players.LocalPlayer:FindFirstChild("leaderstats")
if plrLeaderstats and plrLeaderstats:FindFirstChild("Rebirths") then
    initialRebirths = plrLeaderstats.Rebirths.Value
end

local Paragraph = Tabs.Rebirth:CreateParagraph("RebirthStats", {
    Title = "Rebirth Statistics",
    Content = "Loading stats...",
    TitleAlignment = "Left",
    ContentAlignment = Enum.TextXAlignment.Left
})

local function updateStats()
    local ls = game.Players.LocalPlayer:FindFirstChild("leaderstats")
    local currentRebirths = (ls and ls:FindFirstChild("Rebirths")) and ls.Rebirths.Value or 0
    local gained = currentRebirths - initialRebirths
    Paragraph:SetContent(string.format("Target Rebirth: %d\nCurrent Rebirths: %d\nRebirths Gained: %d", targetRebirthValue, currentRebirths, gained))
end

if plrLeaderstats and plrLeaderstats:FindFirstChild("Rebirths") then
    plrLeaderstats.Rebirths.Changed:Connect(updateStats)
end
updateStats()

Tabs.Rebirth:CreateInput("TargetRebirth", {
    Title = "Target Rebirth Amount",
    Description = "Enter your target rebirth goal",
    Default = "1",
    Placeholder = "Enter amount...",
    Numeric = true,
    Finished = true,
    Callback = function(Value)
        targetRebirthValue = tonumber(Value) or 1
        updateStats()
    end
})

local targetRebirthLoop = nil
local targetToggle = Tabs.Rebirth:CreateToggle("AutoRebirthTarget", {
    Title = "Auto Rebirth (Target)",
    Description = "Automatically rebirth until target is reached",
    Default = false,
    Callback = function(Value)
        if Value then
            targetRebirthLoop = task.spawn(function()
                while task.wait(0.1) do
                    local ls = game.Players.LocalPlayer:FindFirstChild("leaderstats")
                    local cur = (ls and ls:FindFirstChild("Rebirths")) and ls.Rebirths.Value or 0
                    if cur >= targetRebirthValue then
                        targetToggle:SetValue(false)
                        break
                    end
                    pcall(function()
                        game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                    end)
                end
            end)
        else
            if targetRebirthLoop then
                task.cancel(targetRebirthLoop)
                targetRebirthLoop = nil
            end
        end
    end
})

local infiniteRebirthLoop = nil
Tabs.Rebirth:CreateToggle("AutoRebirthInfinite", {
    Title = "Auto Rebirth (Infinite)",
    Description = "Continuously rebirth without stopping",
    Default = false,
    Callback = function(Value)
        if Value then
            infiniteRebirthLoop = task.spawn(function()
                while task.wait(0.1) do
                    pcall(function()
                        game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                    end)
                end
            end)
        else
            if infiniteRebirthLoop then
                task.cancel(infiniteRebirthLoop)
                infiniteRebirthLoop = nil
            end
        end
    end
})

local autoSizeLoop = nil
Tabs.Rebirth:CreateToggle("AutoSize1", {
    Title = "Auto Size 1",
    Description = "Sets character size to 1 continuously",
    Default = false,
    Callback = function(Value)
        if Value then
            autoSizeLoop = task.spawn(function()
                while task.wait(0.2) do
                    pcall(function()
                        game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 1)
                    end)
                end
            end)
        else
            if autoSizeLoop then
                task.cancel(autoSizeLoop)
                autoSizeLoop = nil
            end
        end
    end
})

local teleportLoop = nil
Tabs.Rebirth:CreateToggle("KingTeleport", {
    Title = "Auto Teleport to King",
    Description = "Continuously teleport to Muscle King",
    Default = false,
    Callback = function(Value)
        if Value then
            teleportLoop = task.spawn(function()
                while task.wait(0.1) do
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CFrame = CFrame.new(-8646, 17, -5738)
                    end
                end
            end)
        else
            if teleportLoop then
                task.cancel(teleportLoop)
                teleportLoop = nil
            end
        end
    end
})

Tabs.Rebirth:CreateToggle("FrameToggle", {
    Title = "Hide All Frames",
    Description = "Toggle ON to hide all game frames",
    Default = false,
    Callback = function(Value)
        local rSto = game:GetService("ReplicatedStorage")
        for _, obj in pairs(rSto:GetChildren()) do
            if obj.Name:match("Frame$") and obj:IsA("GuiObject") then
                obj.Visible = not Value
            end
        end
    end
})

-- ============================================================================
-- ⚔️ TAB: KILLER
-- ============================================================================
local SectionKiller = Tabs.Killer:CreateSection("Auto Kill")

local function checkCharacter()
    local char = game.Players.LocalPlayer.Character
    if not char then
        char = game.Players.LocalPlayer.CharacterAdded:Wait()
    end
    return char
end

local function killPlayer(target)
    local character = checkCharacter()
    if character and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local leftHand = character:FindFirstChild("LeftHand")
        if leftHand then
            firetouchinterest(target.Character.HumanoidRootPart, leftHand, 0)
            firetouchinterest(target.Character.HumanoidRootPart, leftHand, 1)
            gettool()
        end
    end
end

Tabs.Killer:AddToggle("Kill v2 Player", {
    Title = "Start Killing",
    Default = false,
    Callback = function(v)
        getgenv().killallv2 = v
        task.spawn(function()
            while getgenv().killallv2 do
                for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                    if player ~= game.Players.LocalPlayer then
                        if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                            killPlayer(player)
                        end
                    end
                end
                task.wait(0.05)
            end
        end)
    end
})

local PlayerDropdown = Tabs.Killer:CreateDropdown("PlayerList", {
    Title = "Select Target",
    Description = "Choose player to target",
    Values = {},
    Multi = false,
    Default = nil,
    Callback = function(Value)
        if Value then
            local username = string.match(Value, "(.+) |")
            targetPlayer = username or Value
        end
    end
})

local function updatePlayerList()
    local playerInfo = {}
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(playerInfo, player.Name .. " | " .. player.DisplayName)
        end
    end
    PlayerDropdown:SetValues(playerInfo)
end

task.spawn(function()
    while task.wait(2) do
        updatePlayerList()
    end
end)

game:GetService("Players").PlayerAdded:Connect(updatePlayerList)
game:GetService("Players").PlayerRemoving:Connect(updatePlayerList)

-- ============================================================================
-- 💎 TAB: CRYSTALS
-- ============================================================================
Tabs.Crystals:CreateDropdown("Crystals1", {
    Title = "Select Crystal",
    Description = "Click one to Auto",
    Values = {"Blue Crystal", "Green Crystal", "Frost Crystal", "Mythical Crystal", "Inferno Crystal"},
    Multi = false,
    Default = 1,
    Callback = function(Value)
        selectedCrystal1 = Value
    end
})

Tabs.Crystals:CreateToggle("AutoOpen1", {
    Title = "Auto Open Crystal",
    Description = "Automatically opens selected crystal",
    Default = false,
    Callback = function(Value)
        _G.AutoOpen1 = Value
        if Value then
            task.spawn(function()
                while _G.AutoOpen1 do
                    pcall(function()
                        game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", selectedCrystal1)
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})

Tabs.Crystals:CreateDropdown("Crystals2", {
    Title = "Select Crystal",
    Description = "Click one to Auto",
    Values = {"Legend Crystal", "Muscle Elite Crystal", "Galaxy Oracle Crystal", "Jungle Crystal"},
    Multi = false,
    Default = 1,
    Callback = function(Value)
        selectedCrystal2 = Value
    end
})

Tabs.Crystals:CreateToggle("AutoOpen2", {
    Title = "Auto Open Crystal",
    Description = "Automatically opens selected crystal",
    Default = false,
    Callback = function(Value)
        _G.AutoOpen2 = Value
        if Value then
            task.spawn(function()
                while _G.AutoOpen2 do
                    pcall(function()
                        game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", selectedCrystal2)
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})

-- ============================================================================
-- 🌀 TAB: TELEPORT
-- ============================================================================
local teleports = {
    {"Spawn", CFrame.new(2, 8, 115)},
    {"Secret", CFrame.new(1947, 2, 6191)},
    {"Tiny", CFrame.new(-34, 7, 1903)},
    {"Frozen", CFrame.new(-2600, 4, -404)},
    {"Mythical", CFrame.new(2255, 7, 1071)},
    {"Inferno", CFrame.new(-6768, 7, -1287)},
    {"Legend", CFrame.new(4604, 991, -3887)},
    {"Muscle King", CFrame.new(-8646, 17, -5738)},
    {"Jungle", CFrame.new(-8659, 6, 2384)},
    {"Lava Brawl", CFrame.new(4471, 119, -8836)},
    {"Desert Brawl", CFrame.new(960, 17, -7398)},
    {"Beach Brawl", CFrame.new(-1849, 20, -6335)}
}

for _, tp in ipairs(teleports) do
    Tabs.Teleport:CreateButton{
        Title = tp[1],
        Description = "Teleport to " .. tp[1],
        Callback = function()
            local plr = game.Players.LocalPlayer
            local char = plr.Character or plr.CharacterAdded:Wait()
            local root = char:WaitForChild("HumanoidRootPart")
            root.CFrame = tp[2]
        end
    }
end

-- ============================================================================
-- 📊 TAB: STATS
-- ============================================================================
local IntSection = Tabs.Stats:CreateSection("Player Stats")
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer

local startTime = 0
local sessionStartTime = os.time()
local timerRunning = false

local strengthGained = 0; local lastStrengthValue = nil
local rebirthsGained = 0; local lastRebirthsValue = nil
local killsGained = 0; local lastKillsValue = nil
local brawlsGained = 0; local lastBrawlsValue = nil
local goodKarmaGained = 0; local lastGoodKarmaValue = nil
local evilKarmaGained = 0; local lastEvilKarmaValue = nil
local durabilityGained = 0; local lastDurabilityValue = nil
local agilityGained = 0; local lastAgilityValue = nil
local muscleKingTimeGained = 0; local lastMuscleKingTimeValue = nil

local TimerParagraph = Tabs.Stats:CreateParagraph("SessionTimer", {
    Title = "⏱️ Session Time", Content = "0d 0h 0m 0s",
    TitleAlignment = "Left", ContentAlignment = Enum.TextXAlignment.Left
})

local CustomTimerParagraph = Tabs.Stats:CreateParagraph("CustomTimer", {
    Title = "⏱️ Custom Timer", Content = "Timer not started",
    TitleAlignment = "Left", ContentAlignment = Enum.TextXAlignment.Left
})

local LeaderParagraph = Tabs.Stats:CreateParagraph("LeaderStats", {
    Title = "📊 Leaderboard Stats", Content = "Loading stats...",
    TitleAlignment = "Left", ContentAlignment = Enum.TextXAlignment.Left
})

local IntParagraph = Tabs.Stats:CreateParagraph("IntStats", {
    Title = "💪 Player Stats", Content = "Loading stats...",
    TitleAlignment = "Left", ContentAlignment = Enum.TextXAlignment.Left
})

Tabs.Stats:CreateButton{
    Title = "Start/Stop Timer",
    Description = "Track your training sessions",
    Callback = function()
        if not timerRunning then
            startTime = os.time()
            timerRunning = true
            CustomTimerParagraph:SetContent("Timer running...")
        else
            timerRunning = false
            CustomTimerParagraph:SetContent("Timer stopped")
        end
    end
}

local function formatNumber(number)
    local formatted = tostring(math.floor(number or 0))
    local k
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end

local function formatTime(seconds)
    local days = math.floor(seconds / 86400)
    local hours = math.floor((seconds % 86400) / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    return string.format("%dd %dh %dm %ds", days, hours, minutes, secs)
end

RunService.RenderStepped:Connect(function()
    local sessionTime = os.time() - sessionStartTime
    TimerParagraph:SetContent(formatTime(sessionTime))
    if timerRunning then
        local elapsed = os.time() - startTime
        CustomTimerParagraph:SetContent(formatTime(elapsed))
    end
    
    local ls = player:FindFirstChild("leaderstats")
    if not ls then return end
    
    local cStr = ls:FindFirstChild("Strength") and ls.Strength.Value or 0
    local cReb = ls:FindFirstChild("Rebirths") and ls.Rebirths.Value or 0
    local cKil = ls:FindFirstChild("Kills") and ls.Kills.Value or 0
    local cBra = ls:FindFirstChild("Brawls") and ls.Brawls.Value or 0
    
    local cGK = player:FindFirstChild("goodKarma") and player.goodKarma.Value or 0
    local cEK = player:FindFirstChild("evilKarma") and player.evilKarma.Value or 0
    local cDur = player:FindFirstChild("Durability") and player.Durability.Value or 0
    local cAgi = player:FindFirstChild("Agility") and player.Agility.Value or 0
    local cMKT = player:FindFirstChild("muscleKingTime") and player.muscleKingTime.Value or 0
    
    if lastStrengthValue == nil then lastStrengthValue = cStr elseif cStr > lastStrengthValue then strengthGained += (cStr - lastStrengthValue) end
    lastStrengthValue = cStr
    
    if lastRebirthsValue == nil then lastRebirthsValue = cReb elseif cReb > lastRebirthsValue then rebirthsGained += (cReb - lastRebirthsValue) end
    lastRebirthsValue = cReb
    
    if lastKillsValue == nil then lastKillsValue = cKil elseif cKil > lastKillsValue then killsGained += (cKil - lastKillsValue) end
    lastKillsValue = cKil
    
    if lastBrawlsValue == nil then lastBrawlsValue = cBra elseif cBra > lastBrawlsValue then brawlsGained += (cBra - lastBrawlsValue) end
    lastBrawlsValue = cBra
    
    if lastGoodKarmaValue == nil then lastGoodKarmaValue = cGK elseif cGK > lastGoodKarmaValue then goodKarmaGained += (cGK - lastGoodKarmaValue) end
    lastGoodKarmaValue = cGK
    
    if lastEvilKarmaValue == nil then lastEvilKarmaValue = cEK elseif cEK > lastEvilKarmaValue then evilKarmaGained += (cEK - lastEvilKarmaValue) end
    lastEvilKarmaValue = cEK
    
    if lastDurabilityValue == nil then lastDurabilityValue = cDur elseif cDur > lastDurabilityValue then durabilityGained += (cDur - lastDurabilityValue) end
    lastDurabilityValue = cDur
    
    if lastAgilityValue == nil then lastAgilityValue = cAgi elseif cAgi > lastAgilityValue then agilityGained += (cAgi - lastAgilityValue) end
    lastAgilityValue = cAgi
    
    if lastMuscleKingTimeValue == nil then lastMuscleKingTimeValue = cMKT elseif cMKT > lastMuscleKingTimeValue then muscleKingTimeGained += (cMKT - lastMuscleKingTimeValue) end
    lastMuscleKingTimeValue = cMKT
    
    LeaderParagraph:SetContent(string.format("Strength: %s     Gained: %s\nRebirths: %s     Gained: %s\nKills: %s     Gained: %s\nBrawls: %s     Gained: %s", formatNumber(cStr), formatNumber(strengthGained), formatNumber(cReb), formatNumber(rebirthsGained), formatNumber(cKil), formatNumber(killsGained), formatNumber(cBra), formatNumber(brawlsGained)))
    IntParagraph:SetContent(string.format("Good Karma: %s     Gained: %s\nEvil Karma: %s     Gained: %s\nDurability: %s     Gained: %s\nAgility: %s     Gained: %s\nMuscle King Time: %s     Gained: %s", formatNumber(cGK), formatNumber(goodKarmaGained), formatNumber(cEK), formatNumber(evilKarmaGained), formatNumber(cDur), formatNumber(durabilityGained), formatNumber(cAgi), formatNumber(agilityGained), formatNumber(cMKT), formatNumber(muscleKingTimeGained)))
end)

local TrackingParagraph = Tabs.Stats:CreateParagraph("TrackingStats", {
    Title = "Player Tracking Stats", Content = "No player selected",
    TitleAlignment = "Left", ContentAlignment = Enum.TextXAlignment.Left
})

Tabs.Stats:CreateInput("PlayerTracker", {
    Title = "Track Player Stats",
    Description = "Enter username or display name",
    Default = "", Placeholder = "Enter player name...", Finished = true,
    Callback = function(Value) targetPlayer = Value end
})

Tabs.Stats:CreateButton{
    Title = "Track Player",
    Description = "Start tracking selected player's stats",
    Callback = function()
        local foundPlayer = nil
        for _, p in pairs(game.Players:GetPlayers()) do
            if targetPlayer ~= "" and (p.Name:lower():find(targetPlayer:lower()) or p.DisplayName:lower():find(targetPlayer:lower())) then
                foundPlayer = p
                break
            end
        end
        if foundPlayer then
            local ls = foundPlayer:FindFirstChild("leaderstats")
            local content = string.format("Strength: %s\nRebirths: %s\nKills: %s\nBrawls: %s\nGood Karma: %s\nEvil Karma: %s\nDurability: %s\nAgility: %s",
                formatNumber(ls and ls:FindFirstChild("Strength") and ls.Strength.Value or 0),
                formatNumber(ls and ls:FindFirstChild("Rebirths") and ls.Rebirths.Value or 0),
                formatNumber(ls and ls:FindFirstChild("Kills") and ls.Kills.Value or 0),
                formatNumber(ls and ls:FindFirstChild("Brawls") and ls.Brawls.Value or 0),
                formatNumber(foundPlayer:FindFirstChild("goodKarma") and foundPlayer.goodKarma.Value or 0),
                formatNumber(foundPlayer:FindFirstChild("evilKarma") and foundPlayer.evilKarma.Value or 0),
                formatNumber(foundPlayer:FindFirstChild("Durability") and foundPlayer.Durability.Value or 0),
                formatNumber(foundPlayer:FindFirstChild("Agility") and foundPlayer.Agility.Value or 0)
            )
            TrackingParagraph:SetContent(content)
            TrackingParagraph:SetTitle("📊 Tracking: " .. foundPlayer.Name)
        end
    end
}

-- ============================================================================
-- 📌 TAB: MISC
-- ============================================================================
Tabs.Misc:CreateToggle("Rejoin", {
    Title = "Auto Rejoin",
    Description = "Auto's Rejoin for u",
    Default = false,
    Callback = function(Value)
        _G.AutoRejoin = Value
        if Value then
            task.spawn(function()
                while _G.AutoRejoin do
                    pcall(function()
                        if game:GetService("CoreGui").RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt") then
                            game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
                        end
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})

Tabs.Misc:CreateButton{
    Title = "Less Lag",
    Description = "Optimize game performance",
    Callback = function()
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                v.Enabled = false
            end
        end
        local lighting = game:GetService("Lighting")
        lighting.GlobalShadows = false
        lighting.FogEnd = 9e9
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
                v.Material = Enum.Material.SmoothPlastic
                if v:IsA("Texture") then v:Destroy() end
            end
        end
        settings().Rendering.QualityLevel = 1
    end
}

Tabs.Misc:CreateButton{
    Title = "Rejoin",
    Description = "Instantly rejoin the same server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    end
}

Tabs.Misc:CreateButton{
    Title = "ServerHop",
    Description = "Join a different server",
    Callback = function()
        local PlaceID = game.PlaceId
        pcall(function()
            local Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
            if Site and Site.data then
                for _, v in pairs(Site.data) do
                    if tonumber(v.maxPlayers) > tonumber(v.playing) and v.id ~= game.JobId then
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, v.id, game.Players.LocalPlayer)
                        break
                    end
                end
            end
        end)
    end
}

Tabs.Misc:CreateButton{
    Title = "Join Small Server",
    Description = "Find lowest player count server",
    Callback = function()
        local PlaceID = game.PlaceId
        pcall(function()
            local AllServers = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
            local LowestPlayers = math.huge
            local ServerID
            for _, server in pairs(AllServers.data) do
                if server.playing < LowestPlayers and server.playing > 0 and server.id ~= game.JobId then
                    LowestPlayers = server.playing
                    ServerID = server.id
                end
            end
            if ServerID then
                game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ServerID, game.Players.LocalPlayer)
            end
        end)
    end
}

Tabs.Misc:AddButton({
    Title = "Anti Rebirth",
    Callback = function()
        local OldNameCall = nil
        OldNameCall = hookmetamethod(game, "__namecall", function(self, ...)
            local Args = {...}
            if getnamecallmethod() == "InvokeServer" and self.Name == "rebirthRemote" and Args[1] == "rebirthRequest" then
                return
            end
            return OldNameCall(self, ...)
        end)
    end
})

Tabs.Misc:AddButton({
    Title = "Anti Accept Trade",
    Callback = function()
        local OldNameCall = nil
        OldNameCall = hookmetamethod(game, "__namecall", function(self, ...)
            local Args = {...}
            if getnamecallmethod() == "FireServer" and self.Name == "tradingEvent" and Args[1] == "acceptTrade" then
                return
            end
            return OldNameCall(self, ...)
        end)
    end
})

-- ============================================================================
-- ⚙️ TAB: SETTINGS & ADDITIONAL CONTROLS
-- ============================================================================
Tabs.Settings:CreateToggle("ToggleName", {
    Title = "Lock Pos",
    Description = "This Freezes u",
    Default = false,
    Callback = function(Value)
        if Value then
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local currentPos = char.HumanoidRootPart.CFrame
                getgenv().posLock = game:GetService("RunService").Heartbeat:Connect(function()
                    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = currentPos
                    end
                end)
            end
        else
            if getgenv().posLock then
                getgenv().posLock:Disconnect()
                getgenv().posLock = nil
            end
        end
    end
})

Tabs.Settings:CreateToggle("NoClip", {
    Title = "NoClip",
    Description = "Be able to walk through anything",
    Default = false,
    Callback = function(Value)
        if Value then
            getgenv().noclipConnection = game:GetService("RunService").Stepped:Connect(function()
                local char = game.Players.LocalPlayer.Character
                if char then
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if getgenv().noclipConnection then
                getgenv().noclipConnection:Disconnect()
                getgenv().noclipConnection = nil
            end
        end
    end
})

Tabs.Settings:CreateToggle("InfiniteJump", {
    Title = "Infinite Jump",
    Description = "Jump Infinite",
    Default = false,
    Callback = function(Value)
        _G.InfiniteJump = Value
        if Value and not _G.InfiniteJumpConnected then
            _G.InfiniteJumpConnected = true
            game:GetService('UserInputService').JumpRequest:Connect(function()
                if _G.InfiniteJump then
                    local char = game:GetService('Players').LocalPlayer.Character
                    if char and char:FindFirstChildOfClass('Humanoid') then
                        char:FindFirstChildOfClass('Humanoid'):ChangeState('Jumping')
                    end
                end
            end)
        end
    end
})

Tabs.Settings:CreateToggle("AntiPortal", {
    Title = "Remove Portals",
    Description = "Removes all portal",
    Default = false,
    Callback = function(Value)
        if Value then
            for _, portal in pairs(game:GetDescendants()) do
                if portal.Name == "RobloxForwardPortals" then
                    portal:Destroy()
                end
            end
        end
    end
})

Tabs.Settings:CreateToggle("BackgroundMusic", {
    Title = "Music",
    Description = "Toggle background music",
    Default = false,
    Callback = function(Value)
        if Value then
            local sound = Instance.new("Sound")
            sound.Name = "BackgroundMusic"
            sound.SoundId = "rbxassetid://5410083226"
            sound.Volume = 1
            sound.Looped = true
            sound.Parent = workspace
            sound:Play()
        else
            local snd = workspace:FindFirstChild("BackgroundMusic")
            if snd then snd:Destroy() end
        end
    end
})

Tabs.Settings:CreateDropdown("TimeControl", {
    Title = "Time Changer",
    Description = "Change time of day",
    Values = {"Morning", "Day", "Night"},
    Multi = false,
    Default = "Day",
    Callback = function(Value)
        local times = { ["Morning"] = 7, ["Day"] = 14, ["Night"] = 0 }
        if times[Value] then
            game:GetService("Lighting").ClockTime = times[Value]
        end
    end
})

-- SPECTATE & EXTRA KILLER
Tabs.Killer:CreateInput("SpectatePlayer", {
    Title = "Spectate Player",
    Placeholder = "Player name...",
    Numeric = false,
    Finished = true,
    Callback = function(Value)
        local target
        for _, p in pairs(game.Players:GetPlayers()) do
            if p.Name:lower() == Value:lower() or p.DisplayName:lower() == Value:lower() then
                target = p
                break
            end
        end
        if target and target.Character and target.Character:FindFirstChild("Humanoid") then
            workspace.CurrentCamera.CameraSubject = target.Character.Humanoid
        end
    end
})

Tabs.Killer:CreateButton{
    Title = "Stop Spying",
    Description = "Switch camera back to your character",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            workspace.CurrentCamera.CameraSubject = char.Humanoid
        end
    end
}

-- AUTO EGG & BRAWL & BUY
local function useOneEgg()
    local plr = game.Players.LocalPlayer
    local protein = plr.Backpack:FindFirstChild("Protein Egg")
    if protein and plr.Character and plr.Character:FindFirstChild("Humanoid") then
        plr.Character.Humanoid:EquipTool(protein)
        task.wait(0.1)
        pcall(function()
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
            task.wait(0.2)
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
        end)
        return true
    end
    return false
end

Tabs.Main:CreateToggle("AutoEgg", {
    Title = "Auto Use Protein Egg",
    Description = "Automatically uses egg at 25 seconds remaining",
    Default = false,
    Callback = function(Value)
        _G.AutoEgg = Value
        if Value then
            task.spawn(function()
                while _G.AutoEgg do
                    local plr = game.Players.LocalPlayer
                    local boostFolder = plr:FindFirstChild("boostTimersFolder")
                    if not boostFolder or not boostFolder:FindFirstChild("Protein Egg") then
                        useOneEgg()
                    else
                        local timer = boostFolder["Protein Egg"]
                        if tonumber(timer.Value) <= 25 then
                            useOneEgg()
                        end
                    end
                    task.wait(2)
                end
            end)
        end
    end
})

Tabs.AutoStuff:AddToggle("Auto Join Brawl Toggle", {
    Title = "Auto Join Brawl",
    Default = false,
    Callback = function(v)
        getgenv().joinbrawl = v
        if v then
            task.spawn(function()
                while getgenv().joinbrawl do
                    pcall(function()
                        game:GetService("ReplicatedStorage").rEvents.brawlEvent:FireServer("joinBrawl")
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})

-- AUTO BUY ULTIMATES
local function createUltimateUpgrade(name, title, description)
    return Tabs.AutoBuy:AddToggle(name, {
        Title = title,
        Default = false,
        Callback = function(v)
            if v then
                Window:Dialog{
                    Title = "Confirm " .. title,
                    Content = "Are you sure you want to activate " .. description .. "?",
                    Buttons = {
                        {
                            Title = "Confirm",
                            Callback = function()
                                game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer("upgradeUltimate", name)
                            end
                        },
                        {
                            Title = "Cancel",
                            Callback = function()
                                -- reset
                            end
                        }
                    }
                }
            end
        end
    })
end

local ultimateUpgrades = {
    {name = "RepSpeed", title = "+5% Rep Speed", description = "+5% Rep Speed"},
    {name = "PetSlot", title = "+1 Pet Slot", description = "+1 Pet Slot"},
    {name = "ItemCapacity", title = "+10 Item Capacity", description = "+10 Item Capacity"},
    {name = "DailySpin", title = "+1 Daily Spin", description = "+1 Daily Spin"},
    {name = "ChestRewards", title = "x2 Chest Rewards", description = "x2 Chest Rewards"},
    {name = "QuestRewards", title = "x2 Quest Rewards", description = "x2 Quest Rewards"},
    {name = "MuscleMind", title = "Muscle Mind", description = "Muscle Mind"},
    {name = "JungleSwift", title = "Jungle Swift", description = "Jungle Swift"},
    {name = "InfernalHealth", title = "Infernal Health", description = "Infernal Health"},
    {name = "GalaxyGains", title = "Galaxy Gains", description = "Galaxy Gains"},
    {name = "DemonDamage", title = "Demon Damage", description = "Demon Damage"},
    {name = "GoldenRebirth", title = "Golden Rebirth", description = "Golden Rebirth"}
}

for _, upgrade in ipairs(ultimateUpgrades) do
    createUltimateUpgrade(upgrade.name, upgrade.title, upgrade.description)
end

Tabs.AutoBuy:AddToggle("AutoWheel", {
    Title = "Auto Spin Wheel",
    Default = false,
    Callback = function(v)
        if v then
            task.spawn(function()
                while v do
                    pcall(function()
                        game:GetService("ReplicatedStorage").rEvents.openFortuneWheelRemote:InvokeServer("openFortuneWheel", game:GetService("ReplicatedStorage").fortuneWheelChances["Fortune Wheel"])
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})

Tabs.AutoBuy:AddToggle("AutoGifts", {
    Title = "Auto Claim Gifts",
    Default = false,
    Callback = function(v)
        if v then
            task.spawn(function()
                while v do
                    for i = 1, 8 do
                        pcall(function()
                            game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer("claimGift", i)
                        end)
                    end
                    task.wait(2)
                end
            end)
        end
    end
})

-- WORKOUTS & TREADMILLS IN AUTOSTUFF
local locationsList = {"Starter Island", "Legend Beach", "Frost Gym", "Mythical Gym", "Eternal Gym", "Legend Gym", "Muscle King Gym", "Jungle Gym"}

local workoutPositions = {
    ["Bench Press"] = {
        ["Starter Island"] = CFrame.new(-17, 3, -2), ["Legend Beach"] = CFrame.new(470, 3, -321),
        ["Frost Gym"] = CFrame.new(-3013, 39, -335), ["Mythical Gym"] = CFrame.new(2371, 39, 1246),
        ["Eternal Gym"] = CFrame.new(-7176, 45, -1106), ["Legend Gym"] = CFrame.new(4111, 1020, -3799),
        ["Muscle King Gym"] = CFrame.new(-8590, 46, -6043), ["Jungle Gym"] = CFrame.new(-8173, 64, 1898)
    },
    ["Squat"] = {
        ["Starter Island"] = CFrame.new(-48, 3, -11), ["Legend Beach"] = CFrame.new(470, 3, -321),
        ["Frost Gym"] = CFrame.new(-2933, 29, -579), ["Mythical Gym"] = CFrame.new(2489, 3, 849),
        ["Eternal Gym"] = CFrame.new(-7176, 45, -1106), ["Legend Gym"] = CFrame.new(4304, 987, -4124),
        ["Muscle King Gym"] = CFrame.new(-8940, 13, -5699), ["Jungle Gym"] = CFrame.new(-8352, 34, 2878)
    },
    ["Deadlift"] = {
        ["Starter Island"] = CFrame.new(-48, 3, -11), ["Legend Beach"] = CFrame.new(470, 3, -321),
        ["Frost Gym"] = CFrame.new(-2933, 29, -579), ["Mythical Gym"] = CFrame.new(2489, 3, 849),
        ["Eternal Gym"] = CFrame.new(-7176, 45, -1106), ["Legend Gym"] = CFrame.new(4304, 987, -4124),
        ["Muscle King Gym"] = CFrame.new(-8940, 13, -5699)
    },
    ["Pull Up"] = {
        ["Starter Island"] = CFrame.new(-33, 3, -11), ["Legend Beach"] = CFrame.new(470, 3, -321),
        ["Frost Gym"] = CFrame.new(-2933, 29, -579), ["Mythical Gym"] = CFrame.new(2489, 3, 849),
        ["Eternal Gym"] = CFrame.new(-7176, 45, -1106), ["Legend Gym"] = CFrame.new(4304, 987, -4124),
        ["Muscle King Gym"] = CFrame.new(-8940, 13, -5699), ["Jungle Gym"] = CFrame.new(-8666, 34, 2070)
    },
    ["Boulder"] = {
        ["Starter Island"] = CFrame.new(-33, 3, -11), ["Legend Beach"] = CFrame.new(470, 3, -321),
        ["Frost Gym"] = CFrame.new(-2933, 29, -579), ["Mythical Gym"] = CFrame.new(2489, 3, 849),
        ["Eternal Gym"] = CFrame.new(-7176, 45, -1106), ["Legend Gym"] = CFrame.new(4304, 987, -4124),
        ["Muscle King Gym"] = CFrame.new(-8940, 13, -5699), ["Jungle Gym"] = CFrame.new(-8621, 34, 2684)
    }
}

local workoutTypes = {"Bench Press", "Squat", "Deadlift", "Pull Up", "Boulder"}
for _, workoutType in ipairs(workoutTypes) do
    Tabs.AutoStuff:CreateDropdown(workoutType .. " dropdown", {
        Title = "Select " .. workoutType,
        Description = "Choose Your Training Location",
        Values = locationsList,
        Multi = false,
        Default = 1,
        Callback = function(Value)
            _G["select" .. string.lower(string.gsub(workoutType, " ", ""))] = Value
        end
    })
    
    Tabs.AutoStuff:CreateToggle(workoutType .. " Toggle", {
        Title = "Farm " .. workoutType,
        Description = "Auto Trains " .. workoutType,
        Default = false,
        Callback = function(Value)
            getgenv().working = Value
            if Value then
                task.spawn(function()
                    local selected = _G["select" .. string.lower(string.gsub(workoutType, " ", ""))]
                    if workoutPositions[workoutType] and workoutPositions[workoutType][selected] then
                        local char = game.Players.LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = workoutPositions[workoutType][selected]
                            task.wait(0.5)
                            pcall(function()
                                game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                                task.wait(0.1)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
                            end)
                            while getgenv().working do
                                if game.Players.LocalPlayer:FindFirstChild("muscleEvent") then
                                    game.Players.LocalPlayer.muscleEvent:FireServer("rep")
                                end
                                task.wait(0.01)
                            end
                        end
                    end
                end)
            end
        end
    })
end

local treadmillPositions = {
    ["Tiny Island"] = {pos = CFrame.new(-31, 6, 2087), req = 0},
    ["Starter Island"] = {pos = CFrame.new(226, 8, 219), req = 600},
    ["Legend Beach"] = {pos = CFrame.new(-365, 44, -501), req = 3000},
    ["Frost Gym"] = {pos = CFrame.new(-2933, 29, -579), req = 3000},
    ["Mythical Gym"] = {pos = CFrame.new(2659, 21, 934), req = 3000},
    ["Eternal Gym"] = {pos = CFrame.new(-7176, 45, -1106), req = 3500},
    ["Legend Gym"] = {pos = CFrame.new(4446, 1004, -3983), req = 0},
    ["Jungle Gym"] = {pos = CFrame.new(-8137, 28, 2820), req = 0}
}

local treadmillDropdown = Tabs.AutoStuff:CreateDropdown("Tread Dropdown", {
    Title = "Select TreadMill",
    Values = {"Tiny Island", "Starter Island", "Legend Beach", "Frost Gym", "Mythical Gym", "Eternal Gym", "Legend Gym", "Jungle Gym"},
    Multi = false,
    Default = "Tiny Island",
    Callback = function(Value) selecttreadmill = Value end
})

Tabs.AutoStuff:CreateToggle("Tread Toggle", {
    Title = "Farm TreadMill",
    Default = false,
    Callback = function(Value)
        getgenv().tread = Value
        if Value then
            task.spawn(function()
                while getgenv().tread do
                    local char = game.Players.LocalPlayer.Character
                    local agi = game.Players.LocalPlayer:FindFirstChild("Agility")
                    local info = treadmillPositions[selecttreadmill]
                    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") and info and agi then
                        if agi.Value >= info.req then
                            char.Humanoid:Move(Vector3.new(0, 0, 100))
                            char.HumanoidRootPart.CFrame = info.pos
                            char.Humanoid.WalkSpeed = 16
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})

-- FINALIZATION
Window:SelectTab(1)
Library:Notify{
    Title = "Muscle Legends Script",
    Content = "Ui Loaded Successfully!",
    Duration = 3
}

pcall(function()
    SaveManager:LoadAutoloadConfig()
end)
