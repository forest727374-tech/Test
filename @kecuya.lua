-- Упрощенный GUI от @kecuya (Работает абсолютно на всех эксплойтах)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleLift = Instance.new("TextButton")
local ToggleRebirth = Instance.new("TextButton")
local TogglePunch = Instance.new("TextButton")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Parent = game.CoreGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 210)
MainFrame.Active = true
MainFrame.Draggable = true -- Можно перетаскивать мышкой/пальцем

Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "@kecuya Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

UIListLayout.Parent = MainFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim me and UDim.new(0, 5) or UDim.new(0, 5)

-- Функция для создания красивых кнопок
local function createButton(text, order)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.Font = Enum.Font.SourceSans
    btn.Text = text .. ": ВЫКЛ"
    btn.TextColor3 = Color3.fromRGB(255, 100, 100)
    btn.TextSize = 16
    btn.LayoutOrder = order
    return btn
end

ToggleLift = createButton("Авто Подъемник", 1)
TogglePunch = createButton("Авто Удар", 2)
ToggleRebirth = createButton("Авто Ребирт", 3)

-- Переменные
local autoLift = false
local autoPunch = false
local autoRebirth = false

-- Логика кнопок
ToggleLift.MouseButton1Click:Connect(function()
    autoLift = not autoLift
    ToggleLift.Text = "Авто Подъемник: " .. (autoLift and "ВКЛ" or "ВЫКЛ")
    ToggleLift.TextColor3 = autoLift and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    
    task.spawn(function()
        while autoLift do
            local p = game.Players.LocalPlayer
            local c = p.Character
            local tool = p.Backpack:FindFirstChild("Weight") or (c and c:FindFirstChild("Weight"))
            if tool then
                if tool.Parent == p.Backpack then c.Humanoid:EquipTool(tool) end
                tool:Activate()
            end
            task.wait(0.1)
        end
    end)
end)

TogglePunch.MouseButton1Click:Connect(function()
    autoPunch = not autoPunch
    TogglePunch.Text = "Авто Удар: " .. (autoPunch and "ВКЛ" or "ВЫКЛ")
    TogglePunch.TextColor3 = autoPunch and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    
    task.spawn(function()
        while autoPunch do
            local p = game.Players.LocalPlayer
            local c = p.Character
            local tool = p.Backpack:FindFirstChild("Punch") or (c and c:FindFirstChild("Punch"))
            if tool then
                if tool.Parent == p.Backpack then c.Humanoid:EquipTool(tool) end
                tool:Activate()
            end
            task.wait(0.05)
        end
    end)
end)

ToggleRebirth.MouseButton1Click:Connect(function()
    autoRebirth = not autoRebirth
    ToggleRebirth.Text = "Авто Ребирт: " .. (autoRebirth and "ВКЛ" or "ВЫКЛ")
    ToggleRebirth.TextColor3 = autoRebirth and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    
    task.spawn(function()
        while autoRebirth do
            local rEvents = game:GetService("ReplicatedStorage"):FindFirstChild("rEvents")
            if rEvents and rEvents:FindFirstChild("rebirthRemote") then
                rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
            task.wait(1)
        end
    end)
end)
