-- the script is fire


loadstring(game:HttpGet("https://raw.githubusercontent.com/Jenos2006/AllLuaScripts/refs/heads/main/Notify.lua"))()
 


local Players = game:GetService("Players")
local player = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MoneyGiverGUI"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Name = "MainFrame"
Frame.Size = UDim2.new(0, 300, 0, 400)
Frame.Position = UDim2.new(0.5, -150, 0.5, -200)
Frame.BackgroundColor3 = Color3.new(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.BackgroundTransparency = 0.2
Frame.Parent = ScreenGui
Frame.Active = true
Frame.Draggable = true
Frame.AnchorPoint = Vector2.new(0.5, 0.5)

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Text = "Money! v1.2 by Jenos2006"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Parent = Frame

local function createButton(name, text, position, callback)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Text = text
    Button.Size = UDim2.new(0.8, 0, 0, 40)
    Button.Position = UDim2.new(0.1, 0, position, 0)
    Button.Font = Enum.Font.SourceSansBold
    Button.TextSize = 18
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    Button.BorderSizePixel = 0
    Button.Parent = Frame

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = Button

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 0.1
    UIStroke.Color = Color3.new(1, 1, 1)
    UIStroke.Parent = Button

    Button.MouseButton1Click:Connect(callback)
end

local function sendMoney(amount)
    game.ReplicatedStorage.MoneyRequest:FireServer(false, amount, "Cash")
end

local infiniteGiving = false
local infiniteLoop
local function toggleInfinite()
    infiniteGiving = not infiniteGiving
    if infiniteGiving then
        infiniteLoop = task.spawn(function()
            while infiniteGiving do
                sendMoney(999e99) -- Unendliches Geld
                task.wait()
            end
        end)
    else
        task.cancel(infiniteLoop)
    end
end

createButton("Button100", "100$", 0.2, function() sendMoney(100) end)
createButton("Button1000", "1.000$", 0.35, function() sendMoney(1000) end)
createButton("Button100000", "100.000$", 0.5, function() sendMoney(100000) end)
createButton("Button1000000", "1.000.000$", 0.65, function() sendMoney(1000000) end)
createButton("ButtonInfinity", "Infinity (Press again to Stop)", 0.8, toggleInfinite)

notify("Script loaded!", "Script by Jenos2006!", 3)
