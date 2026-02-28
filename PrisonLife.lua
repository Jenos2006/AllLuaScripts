repeat task.wait() until game:IsLoaded()
task.wait(2)

-- Venora - Custom GUI Silent Aim + AutoShoot

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Teams = game:GetService("Teams")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")

-- Teams
local guardsTeam = Teams:FindFirstChild("Guards")
local inmatesTeam = Teams:FindFirstChild("Inmates")
local criminalsTeam = Teams:FindFirstChild("Criminals")

-- Configuration
local cfg = {
    enabled = true,
    teamcheck = true,
    wallcheck = true,
    deathcheck = true,
    ffcheck = true,
    vehiclecheck = true,
    criminalsnoinnmates = true,
    inmatesnocriminals = true,
    shieldbreaker = true,
    hitchance = 100,
    fov = 150,
    showfov = true,
    aimpart = "Head",
    randomparts = false,
    partslist = {"Head", "Torso", "Left Arm", "Right Arm"},
    missspread = 5,
    autoshoot = true,
    autoshootdelay = 0.12,
    autoshootstartdelay = 0.2,
    prioritizeclosest = true,
    targetstickiness = true,
    targetstickinessduration = 0.6,
    esp = true,
    espteamcheck = true,
    watermark = true,
}

-- Variables
local currentGun = nil
local rng = Random.new()
local lastShotTime = 0
local lastShotResult = false
local shotCooldown = 0.15
local currentTarget = nil
local targetSwitchTime = 0
local ESPObjects = {}
local origCastRay = nil
local hooked = false
local lastAutoShoot = 0
local targetAcquiredTime = 0
local lastAutoTarget = nil
local cachedBulletsLabel = nil
local guiOpen = true
local dragging = {false = false, false = false}
local dragOffset = Vector2.new(0, 0)

-- FOV Circle
local FOVCircle
local drawingSupported = pcall(function()
    local test = Drawing.new("Circle")
    test:Remove()
end)

if drawingSupported then
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Color = Color3.fromRGB(255, 255, 255)
    FOVCircle.Radius = cfg.fov
    FOVCircle.Transparency = 0.8
    FOVCircle.Filled = false
    FOVCircle.NumSides = 64
    FOVCircle.Thickness = 2
    FOVCircle.Visible = false
end

-- Watermark
local Watermark
if drawingSupported then
    Watermark = Drawing.new("Text")
    Watermark.Text = "Venora | Prison Life"
    Watermark.Color = Color3.fromRGB(0, 200, 255)
    Watermark.Size = 18
    Watermark.Outline = true
    Watermark.OutlineColor = Color3.fromRGB(0, 0, 0)
    Watermark.Position = Vector2.new(10, 10)
    Watermark.Center = false
    Watermark.Visible = true
end

-- Wall Check Params
local wallParams = RaycastParams.new()
wallParams.FilterType = Enum.RaycastFilterType.Exclude
wallParams.IgnoreWater = true

-- GUI Elements
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VenoraGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Protect GUI
if syn and syn.protect_gui then
    syn.protect_gui(screenGui)
end

screenGui.Parent = game:GetService("CoreGui")

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 500)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = false
mainFrame.Parent = screenGui

-- Drop Shadow
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 40, 1, 40)
shadow.Position = UDim2.new(0, -20, 0, -20)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://6015897843"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(1, -40, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "VENORA"
titleText.TextColor3 = Color3.fromRGB(0, 200, 255)
titleText.TextSize = 18
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0.5, -12.5)
closeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

-- Tab Buttons
local tabFrame = Instance.new("Frame")
tabFrame.Name = "TabFrame"
tabFrame.Size = UDim2.new(1, 0, 0, 40)
tabFrame.Position = UDim2.new(0, 0, 0, 35)
tabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
tabFrame.BorderSizePixel = 0
tabFrame.Parent = mainFrame

local combatTabBtn = Instance.new("TextButton")
combatTabBtn.Name = "CombatTab"
combatTabBtn.Size = UDim2.new(0.5, -2, 1, -8)
combatTabBtn.Position = UDim2.new(0, 4, 0, 4)
combatTabBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
combatTabBtn.Text = "COMBAT"
combatTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
combatTabBtn.TextSize = 14
combatTabBtn.Font = Enum.Font.GothamBold
combatTabBtn.Parent = tabFrame

local visualsTabBtn = Instance.new("TextButton")
visualsTabBtn.Name = "VisualsTab"
visualsTabBtn.Size = UDim2.new(0.5, -2, 1, -8)
visualsTabBtn.Position = UDim2.new(0.5, 2, 0, 4)
visualsTabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
visualsTabBtn.Text = "VISUALS"
visualsTabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
visualsTabBtn.TextSize = 14
visualsTabBtn.Font = Enum.Font.GothamBold
visualsTabBtn.Parent = tabFrame

-- Content Container
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -20, 1, -115)
contentFrame.Position = UDim2.new(0, 10, 0, 85)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.ScrollBarThickness = 4
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 200, 255)
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
contentFrame.Parent = mainFrame

-- Utility Functions
local function createToggle(parent, name, default, callback)
    local yPos = #parent:GetChildren() * 35
    
    local frame = Instance.new("Frame")
    frame.Name = name .. "Toggle"
    frame.Size = UDim2.new(1, 0, 0, 30)
    frame.Position = UDim2.new(0, 0, 0, yPos)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(0, 200, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Name = "Button"
    btn.Size = UDim2.new(0, 50, 0, 20)
    btn.Position = UDim2.new(1, -55, 0.5, -10)
    btn.BackgroundColor3 = default and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(60, 60, 70)
    btn.Text = default and "ON" or "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.Parent = frame
    
    local enabled = default
    
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.BackgroundColor3 = enabled and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(60, 60, 70)
        btn.Text = enabled and "ON" or "OFF"
        callback(enabled)
    end)
    
    return btn
end

local function createSlider(parent, name, min, max, default, suffix, callback)
    local yPos = #parent:GetChildren() * 45
    
    local frame = Instance.new("Frame")
    frame.Name = name .. "Slider"
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.Position = UDim2.new(0, 0, 0, yPos)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, -60, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = name .. ": " .. default .. suffix
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Name = "SliderBg"
    sliderBg.Size = UDim2.new(1, -20, 0, 4)
    sliderBg.Position = UDim2.new(0, 10, 0, 25)
    sliderBg.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = frame
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "SliderFill"
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg
    
    local value = default
    local dragging = false
    
    local function updateSlider(input)
        local pos = input.Position.X
        local bgPos = sliderBg.AbsolutePosition.X
        local bgSize = sliderBg.AbsoluteSize.X
        local relative = math.clamp((pos - bgPos) / bgSize, 0, 1)
        value = min + (max - min) * relative
        value = math.floor(value / 0.01 + 0.5) * 0.01
        sliderFill.Size = UDim2.new(relative, 0, 1, 0)
        label.Text = name .. ": " .. string.format("%.2f", value) .. suffix
        callback(value)
    end
    
    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateSlider(input)
        end
    end)
    
    sliderBg.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)
    
    return sliderBg
end

local function createDropdown(parent, name, options, default, callback)
    local yPos = #parent:GetChildren() * 45
    
    local frame = Instance.new("Frame")
    frame.Name = name .. "Dropdown"
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.Position = UDim2.new(0, 0, 0, yPos)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, -60, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local dropdownBtn = Instance.new("TextButton")
    dropdownBtn.Name = "DropdownBtn"
    dropdownBtn.Size = UDim2.new(1, -20, 0, 20)
    dropdownBtn.Position = UDim2.new(0, 10, 0, 20)
    dropdownBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    dropdownBtn.Text = default
    dropdownBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    dropdownBtn.TextSize = 12
    dropdownBtn.Font = Enum.Font.Gotham
    dropdownBtn.Parent = frame
    
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Name = "DropdownFrame"
    dropdownFrame.Size = UDim2.new(1, -20, 0, 0)
    dropdownFrame.Position = UDim2.new(0, 10, 0, 42)
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    dropdownFrame.BorderSizePixel = 0
    dropdownFrame.ClipsDescendants = true
    dropdownFrame.Visible = false
    dropdownFrame.Parent = frame
    
    local open = false
    
    for i, option in ipairs(options) do
        local optionBtn = Instance.new("TextButton")
        optionBtn.Name = option
        optionBtn.Size = UDim2.new(1, 0, 0, 25)
        optionBtn.Position = UDim2.new(0, 0, 0, (i-1) * 25)
        optionBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        optionBtn.Text = option
        optionBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        optionBtn.TextSize = 12
        optionBtn.Font = Enum.Font.Gotham
        optionBtn.Parent = dropdownFrame
        
        optionBtn.MouseButton1Click:Connect(function()
            dropdownBtn.Text = option
            dropdownFrame.Visible = false
            open = false
            dropdownFrame.Size = UDim2.new(1, -20, 0, 0)
            callback(option)
        end)
    end
    
    dropdownFrame.Size = UDim2.new(1, -20, 0, #options * 25)
    
    dropdownBtn.MouseButton1Click:Connect(function()
        open = not open
        dropdownFrame.Visible = open
    end)
    
    return dropdownBtn
end

local function createButton(parent, name, callback)
    local yPos = #parent:GetChildren() * 35
    
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Btn"
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.TextSize = 14
    btn.Font = Enum.Font.Gotham
    btn.Parent = parent
    
    btn.MouseButton1Click:Connect(callback)
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    end)
    
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    end)
    
    return btn
end

local function createSection(parent, title)
    local yPos = #parent:GetChildren() * 25
    
    local label = Instance.new("TextLabel")
    label.Name = title .. "Section"
    label.Size = UDim2.new(1, -10, 0, 20)
    label.Position = UDim2.new(0, 5, 0, yPos)
    label.BackgroundTransparency = 1
    label.Text = "─── " .. title .. " ───"
    label.TextColor3 = Color3.fromRGB(0, 200, 255)
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.Parent = parent
    
    return label
end

-- Build Combat Tab
local combatContent = Instance.new("Frame")
combatContent.Name = "CombatContent"
combatContent.Size = UDim2.new(1, 0, 0, 0)
combatContent.BackgroundTransparency = 1
combatContent.Visible = true
combatContent.Parent = contentFrame

local combatItems = Instance.new("Frame")
combatItems.Name = "Items"
combatItems.Size = UDim2.new(1, 0, 0, 0)
combatItems.BackgroundTransparency = 1
combatItems.Parent = combatContent

createSection(combatItems, "Silent Aim")
createToggle(combatItems, "Enable Silent Aim", true, function(v) cfg.enabled = v end)
createToggle(combatItems, "Auto Shoot", true, function(v) cfg.autoshoot = v end)
createToggle(combatItems, "Team Check", true, function(v) cfg.teamcheck = v end)
createToggle(combatItems, "Wall Check", true, function(v) cfg.wallcheck = v end)
createToggle(combatItems, "Shield Breaker", true, function(v) cfg.shieldbreaker = v end)
createSlider(combatItems, "Hit Chance", 0, 100, 100, "%", function(v) cfg.hitchance = v end)

createSection(combatItems, "FOV Settings")
createSlider(combatItems, "FOV Radius", 30, 500, 150, "px", function(v) cfg.fov = v end)
createToggle(combatItems, "Show FOV Circle", true, function(v) cfg.showfov = v end)

createSection(combatItems, "AutoShoot Settings")
createSlider(combatItems, "AutoShoot Delay", 0.05, 0.5, 0.12, "s", function(v) cfg.autoshootdelay = v end)
createSlider(combatItems, "Reaction Time", 0, 1, 0.2, "s", function(v) cfg.autoshootstartdelay = v end)
createDropdown(combatItems, "Target Part", {"Head", "Torso", "Left Arm", "Right Arm"}, "Head", function(v) cfg.aimpart = v end)

-- Build Visuals Tab
local visualsContent = Instance.new("Frame")
visualsContent.Name = "VisualsContent"
visualsContent.Size = UDim2.new(1, 0, 0, 0)
visualsContent.BackgroundTransparency = 1
visualsContent.Visible = false
visualsContent.Parent = contentFrame

local visualsItems = Instance.new("Frame")
visualsItems.Name = "Items"
visualsItems.Size = UDim2.new(1, 0, 0, 0)
visualsItems.BackgroundTransparency = 1
visualsItems.Parent = visualsContent

createSection(visualsItems, "ESP Configuration")
createToggle(visualsItems, "Enable ESP", true, function(v) cfg.esp = v end)
createToggle(visualsItems, "ESP Team Check", true, function(v) cfg.espteamcheck = v end)
createToggle(visualsItems, "Show Watermark", true, function(v) 
    cfg.watermark = v
    if Watermark then Watermark.Visible = v end
end)

createSection(visualsItems, "ESP Colors")
local colorsLabel = Instance.new("TextLabel")
colorsLabel.Size = UDim2.new(1, -10, 0, 60)
colorsLabel.Position = UDim2.new(0, 5, 0, #visualsItems:GetChildren() * 25)
colorsLabel.BackgroundTransparency = 1
colorsLabel.Text = "🔵 Blue = Guards\n🟠 Orange = Inmates\n🔴 Red = Criminals"
colorsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
colorsLabel.TextSize = 12
colorsLabel.Font = Enum.Font.Gotham
colorsLabel.TextXAlignment = Enum.TextXAlignment.Left
colorsLabel.Parent = visualsItems

-- Build Info Tab
local infoContent = Instance.new("Frame")
infoContent.Name = "InfoContent"
infoContent.Size = UDim2.new(1, 0, 0, 0)
infoContent.BackgroundTransparency = 1
infoContent.Visible = false
infoContent.Parent = contentFrame

local infoItems = Instance.new("Frame")
infoItems.Name = "Items"
infoItems.Size = UDim2.new(1, 0, 0, 0)
infoItems.BackgroundTransparency = 1
infoItems.Parent = infoContent

createSection(infoItems, "About")
local aboutLabel = Instance.new("TextLabel")
aboutLabel.Size = UDim2.new(1, -10, 0, 80)
aboutLabel.Position = UDim2.new(0, 5, 0, #infoItems:GetChildren() * 25)
aboutLabel.BackgroundTransparency = 1
aboutLabel.Text = "Venora v1.0\nSilent Aim + AutoShoot + ESP\nCreated for Prison Life"
aboutLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
aboutLabel.TextSize = 14
aboutLabel.Font = Enum.Font.Gotham
aboutLabel.TextXAlignment = Enum.TextXAlignment.Left
aboutLabel.Parent = infoItems

createSection(infoItems, "Features")
local featuresLabel = Instance.new("TextLabel")
featuresLabel.Size = UDim2.new(1, -10, 0, 150)
featuresLabel.Position = UDim2.new(0, 5, 0, #infoItems:GetChildren() * 25 + 20)
featuresLabel.BackgroundTransparency = 1
featuresLabel.Text = "• Silent Aim - Auto lock onto enemies\n• AutoShoot - Automatic firing\n• ESP - Player boxes with team colors\n• Shield Breaker - Aim at shields\n• Wall Check - Don't shoot through walls\n• Custom FOV - Adjustable aim area"
featuresLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
featuresLabel.TextSize = 12
featuresLabel.Font = Enum.Font.Gotham
featuresLabel.TextXAlignment = Enum.TextXAlignment.Left
featuresLabel.Parent = infoItems

createSection(infoItems, "Hotkeys")
local hotkeysLabel = Instance.new("TextLabel")
hotkeysLabel.Size = UDim2.new(1, -10, 0, 50)
hotkeysLabel.Position = UDim2.new(0, 5, 0, #infoItems:GetChildren() * 25 + 20)
hotkeysLabel.BackgroundTransparency = 1
hotkeysLabel.Text = "• Right Shift - Toggle GUI\n• No other hotkeys - Everything automatic!"
hotkeysLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
hotkeysLabel.TextSize = 12
hotkeysLabel.Font = Enum.Font.Gotham
hotkeysLabel.TextXAlignment = Enum.TextXAlignment.Left
hotkeysLabel.Parent = infoItems

createButton(infoItems, "Destroy GUI", function()
    screenGui:Destroy()
    if FOVCircle then FOVCircle:Remove() end
    if Watermark then Watermark:Remove() end
    for _, box in pairs(ESPObjects) do
        for _, line in ipairs(box) do
            line:Remove()
        end
    end
end)

-- Update canvas sizes
local function updateCanvasSize(frame)
    local totalHeight = 0
    for _, child in ipairs(frame:GetChildren()) do
        totalHeight = totalHeight + child.AbsoluteSize.Y + 10
    end
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight + 20)
end

combatContent.ChildAdded:Connect(function() updateCanvasSize(combatItems) end)
visualsContent.ChildAdded:Connect(function() updateCanvasSize(visualsItems) end)
infoContent.ChildAdded:Connect(function() updateCanvasSize(infoItems) end)

-- Tab switching
combatTabBtn.MouseButton1Click:Connect(function()
    combatTabBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    combatTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    visualsTabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    visualsTabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    combatContent.Visible = true
    visualsContent.Visible = false
    infoContent.Visible = false
    updateCanvasSize(combatItems)
end)

visualsTabBtn.MouseButton1Click:Connect(function()
    visualsTabBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    visualsTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    combatTabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    combatTabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    combatContent.Visible = false
    visualsContent.Visible = true
    infoContent.Visible = false
    updateCanvasSize(visualsItems)
end)

-- Drag functionality
local function startDrag(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragOffset = Vector2.new(input.Position.X - mainFrame.AbsolutePosition.X, input.Position.Y - mainFrame.AbsolutePosition.Y)
    end
end

local function stopDrag(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end

local function onDrag(input)
    if dragging then
        local newPos = Vector2.new(input.Position.X - dragOffset.X, input.Position.Y - dragOffset.Y)
        mainFrame.Position = UDim2.new(0, newPos.X, 0, newPos.Y)
    end
end

titleBar.InputBegan:Connect(startDrag)
titleBar.InputEnded:Connect(stopDrag)
titleBar.InputChanged:Connect(onDrag)

-- Close button
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    if FOVCircle then FOVCircle:Remove() end
    if Watermark then Watermark:Remove() end
    for _, box in pairs(ESPObjects) do
        for _, line in ipairs(box) do
            line:Remove()
        end
    end
end)

-- Toggle GUI with Right Shift
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        guiOpen = not guiOpen
        mainFrame.Visible = guiOpen
    end
end)

-- Part mapping for target parts
local partMap = {
    ["Torso"] = {"Torso", "UpperTorso", "LowerTorso"},
    ["Left Arm"] = {"Left Arm", "LeftUpperArm", "LeftLowerArm"},
    ["Right Arm"] = {"Right Arm", "RightUpperArm", "RightLowerArm"},
    ["Left Leg"] = {"Left Leg", "LeftUpperLeg", "LeftLowerLeg"},
    ["Right Leg"] = {"Right Leg", "RightUpperLeg", "RightLowerLeg"}
}

local function getPart(char, name)
    if not char then return nil end
    local p = char:FindFirstChild(name)
    if p then return p end
    
    local maps = partMap[name]
    if maps then
        for _, n in ipairs(maps) do
            local part = char:FindFirstChild(n)
            if part then return part end
        end
    end
    return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head")
end

local function getTargetPart(char)
    if not char then return nil end
    
    if cfg.shieldbreaker then
        local shield = char:FindFirstChild("RiotShieldPart")
        if shield and shield:IsA("BasePart") then
            local hp = shield:GetAttribute("Health")
            if hp and hp > 0 then
                return shield
            end
        end
    end
    
    local partName
    if cfg.randomparts then
        local list = cfg.partslist
        partName = (list and #list > 0) and list[rng:NextInteger(1, #list)] or "Head"
    else
        partName = cfg.aimpart
    end
    return getPart(char, partName)
end

local function isDead(player)
    if not player or not player.Character then return true end
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    return not humanoid or humanoid.Health <= 0
end

local function hasForceField(player)
    if not player or not player.Character then return false end
    return player.Character:FindFirstChildOfClass("ForceField") ~= nil
end

local function isInVehicle(player)
    if not player or not player.Character then return false end
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return false end
    return humanoid.SeatPart ~= nil
end

local function wallBetween(startPos, endPos, targetChar)
    local myChar = LocalPlayer.Character
    if not myChar then return true end
    
    local filter = {myChar}
    if targetChar then table.insert(filter, targetChar) end
    wallParams.FilterDescendantsInstances = filter
    
    local direction = endPos - startPos
    local result = Workspace:Raycast(startPos, direction, wallParams)
    
    if not result then return false end
    
    local hitPart = result.Instance
    return not (hitPart and hitPart:IsDescendantOf(targetChar))
end

local function quickCheck(player)
    if not player or player == LocalPlayer or not player.Character then return false end
    if not getTargetPart(player.Character) then return false end
    if cfg.deathcheck and isDead(player) then return false end
    if cfg.ffcheck and hasForceField(player) then return false end
    if cfg.vehiclecheck and isInVehicle(player) then return false end
    if cfg.teamcheck and player.Team == LocalPlayer.Team then return false end
    
    if cfg.criminalsnoinnmates then
        if LocalPlayer.Team == criminalsTeam and player.Team == inmatesTeam then return false end
    end
    if cfg.inmatesnocriminals then
        if LocalPlayer.Team == inmatesTeam and player.Team == criminalsTeam then return false end
    end
    
    return true
end

local function fullCheck(player)
    if not quickCheck(player) then return false end
    
    if cfg.wallcheck then
        local myChar = LocalPlayer.Character
        local myHead = myChar and myChar:FindFirstChild("Head")
        local targetPart = getTargetPart(player.Character)
        if myHead and targetPart then
            if wallBetween(myHead.Position, targetPart.Position, player.Character) then
                return false
            end
        end
    end
    return true
end

local function rollHit()
    local now = os.clock()
    if now - lastShotTime > shotCooldown then
        lastShotTime = now
        local chance = cfg.hitchance
        if chance >= 100 then
            lastShotResult = true
        elseif chance <= 0 then
            lastShotResult = false
        else
            lastShotResult = rng:NextInteger(1, 100) <= chance
        end
    end
    return lastShotResult
end

local function getMissPos(targetPos)
    local spread = cfg.missspread
    local angle = rng:NextNumber() * math.pi * 2
    local d = rng:NextNumber() * spread
    local yOffset = (rng:NextNumber() - 0.5) * spread
    return targetPos + Vector3.new(math.cos(angle) * d, yOffset, math.sin(angle) * d)
end

local function getClosest(fovRadius)
    fovRadius = fovRadius or cfg.fov
    local camera = Camera
    if not camera then return nil, nil end
    
    local lastInput = UserInputService:GetLastInputType()
    local locked = (lastInput == Enum.UserInputType.Touch) or (UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter)
    
    local aimPos
    if locked then
        local viewportSize = camera.ViewportSize
        aimPos = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    else
        aimPos = UserInputService:GetMouseLocation()
    end
    
    local now = os.clock()
    
    if cfg.targetstickiness and currentTarget and (now - targetSwitchTime) < cfg.targetstickinessduration then
        if fullCheck(currentTarget) then
            local part = getTargetPart(currentTarget.Character)
            if part then
                local screenPos, onScreen = camera:WorldToViewportPoint(part.Position)
                if onScreen and screenPos.Z > 0 then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - aimPos).Magnitude
                    if dist < fovRadius then
                        return currentTarget, part.Position
                    end
                end
            end
        end
    end
    
    local candidates = {}
    
    for _, player in ipairs(Players:GetPlayers()) do
        if quickCheck(player) then
            local part = getTargetPart(player.Character)
            if part then
                local screenPos, onScreen = camera:WorldToViewportPoint(part.Position)
                if onScreen and screenPos.Z > 0 then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - aimPos).Magnitude
                    if dist < fovRadius then
                        candidates[#candidates + 1] = {player = player, dist = dist, part = part}
                    end
                end
            end
        end
    end
    
    if cfg.prioritizeclosest then
        table.sort(candidates, function(a, b) return a.dist < b.dist end)
    end
    
    for _, candidate in ipairs(candidates) do
        if fullCheck(candidate.player) then
            if candidate.player ~= currentTarget then
                currentTarget = candidate.player
                targetSwitchTime = now
            end
            return candidate.player, candidate.part.Position
        end
    end
    
    currentTarget = nil
    return nil, nil
end

-- Hook castRay
local function noUpvals(fn)
    return function(...) return fn(...) end
end

local function setupHook()
    local success, castRayFunc = pcall(function()
        for _, v in pairs(getgc()) do
            if type(v) == "function" and getfenv(v).script and getfenv(v).script.Name == "GunScript" then
                local upvals = debug.getupvalues(v)
                for _, upval in ipairs(upvals) do
                    if type(upval) == "function" and debug.getinfo(upval).name == "castRay" then
                        return upval
                    end
                end
            end
        end
        return nil
    end)
    
    if not success or not castRayFunc then 
        return false 
    end
    
    origCastRay = hookfunction(castRayFunc, noUpvals(function(startPos, targetPos, ...)
        if not cfg.enabled then return origCastRay(startPos, targetPos, ...) end
        
        local closest, closestPos = getClosest(cfg.fov)
        
        if closest and closest.Character then
            local shouldHit = rollHit()
            
            if shouldHit then
                local targetPart = getTargetPart(closest.Character)
                if targetPart then
                    return targetPart, targetPart.Position
                end
            else
                if cfg.missspread > 0 then
                    local targetPart = getTargetPart(closest.Character)
                    if targetPart then
                        local missPos = getMissPos(targetPart.Position)
                        return origCastRay(startPos, missPos, ...)
                    end
                end
            end
        end
        
        return origCastRay(startPos, targetPos, ...)
    end))
    
    hooked = true
    return true
end

-- Try to hook
task.spawn(function()
    for i = 1, 10 do
        task.wait(0.5)
        if setupHook() then
            break
        end
    end
end)

-- AutoShoot System
local ShootEvent = ReplicatedStorage:FindFirstChild("GunRemotes") and ReplicatedStorage.GunRemotes:FindFirstChild("ShootEvent")

local function getGun()
    local char = LocalPlayer.Character
    if not char then return nil end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") and tool:GetAttribute("ToolType") == "Gun" then
            return tool
        end
    end
    return nil
end

local function createBulletTrail(startPos, endPos, isTaser)
    local distance = (endPos - startPos).Magnitude
    local trail = Instance.new("Part")
    trail.Name = "BulletTrail"
    trail.Anchored = true
    trail.CanCollide = false
    trail.CanQuery = false
    trail.CanTouch = false
    trail.Material = Enum.Material.Neon
    trail.Size = Vector3.new(0.1, 0.1, distance)
    trail.CFrame = CFrame.new(startPos, endPos) * CFrame.new(0, 0, -distance / 2)
    trail.Transparency = 0.5
    
    if isTaser then
        trail.BrickColor = BrickColor.new("Cyan")
        trail.Size = Vector3.new(0.2, 0.2, distance)
    else
        trail.BrickColor = BrickColor.Yellow()
    end
    
    trail.Parent = workspace
    Debris:AddItem(trail, isTaser and 0.8 or 0.1)
end

local function autoShoot()
    if not cfg.autoshoot or not cfg.enabled or not currentGun or not ShootEvent then return end
    
    local now = os.clock()
    local fireRate = currentGun:GetAttribute("FireRate") or cfg.autoshootdelay
    if now - lastAutoShoot < fireRate then return end
    
    local myChar = LocalPlayer.Character
    if not myChar then return end
    local myHead = myChar:FindFirstChild("Head")
    if not myHead then return end
    
    local muzzle = currentGun:FindFirstChild("Muzzle")
    local startPos = muzzle and muzzle.Position or myHead.Position
    
    local target, targetPos = getClosest(cfg.fov)
    if not target or not fullCheck(target) then 
        lastAutoTarget = nil
        return 
    end
    
    if target ~= lastAutoTarget then
        targetAcquiredTime = now
        lastAutoTarget = target
    end
    
    if now - targetAcquiredTime < cfg.autoshootstartdelay then return end
    
    local targetPart = getTargetPart(target.Character)
    if not targetPart then return end
    
    local ammo = currentGun:GetAttribute("Local_CurrentAmmo") or currentGun:GetAttribute("CurrentAmmo") or 0
    if ammo <= 0 then return end
    
    lastAutoShoot = now
    
    local isTaser = currentGun:GetAttribute("Projectile") == "Taser"
    local shouldHit = rollHit()
    
    local projectileCount = currentGun:GetAttribute("ProjectileCount") or 1
    local shots = {}
    
    for i = 1, projectileCount do
        local finalPos
        if shouldHit then
            finalPos = targetPart.Position
        else
            if cfg.missspread > 0 then
                finalPos = getMissPos(targetPart.Position)
            else
                return
            end
        end
        shots[i] = {myHead.Position, finalPos, shouldHit and targetPart or nil}
        createBulletTrail(startPos, finalPos, isTaser)
    end
    
    ShootEvent:FireServer(shots)
    
    local newAmmo = ammo - 1
    currentGun:SetAttribute("Local_CurrentAmmo", newAmmo)
    
    if not cachedBulletsLabel then
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        if playerGui then
            local home = playerGui:FindFirstChild("Home")
            if home then
                local hud = home:FindFirstChild("hud")
                if hud then
                    local br = hud:FindFirstChild("BottomRightFrame")
                    if br then
                        local gf = br:FindFirstChild("GunFrame")
                        if gf then
                            cachedBulletsLabel = gf:FindFirstChild("BulletsLabel")
                        end
                    end
                end
            end
        end
    end
    
    if cachedBulletsLabel then
        cachedBulletsLabel.Text = newAmmo .. "/" .. (currentGun:GetAttribute("MaxAmmo") or 30)
    end
    
    local handle = currentGun:FindFirstChild("Handle")
    if handle then
        local shootSound = handle:FindFirstChild("ShootSound")
        if shootSound then
            local sound = shootSound:Clone()
            sound.Parent = handle
            sound:Play()
            Debris:AddItem(sound, 2)
        end
    end
end

local lastGun = nil

RunService.Heartbeat:Connect(function()
    currentGun = getGun()
    if currentGun ~= lastGun then
        lastAutoShoot = 0
        lastGun = currentGun
    end
    autoShoot()
end)

-- ESP System
local function GetTeamColor(player)
    if not player or not player.Team then
        return Color3.fromRGB(255, 255, 255)
    end
    
    local team = player.Team
    if team == guardsTeam then
        return Color3.fromRGB(0, 150, 255)
    elseif team == inmatesTeam then
        return Color3.fromRGB(255, 150, 0)
    elseif team == criminalsTeam then
        return Color3.fromRGB(255, 0, 0)
    end
    
    return Color3.fromRGB(200, 200, 200)
end

local function CreateESP(player)
    if not drawingSupported or player == LocalPlayer or ESPObjects[player] then return end
    
    local box = {}
    for i = 1, 4 do
        local line = Drawing.new("Line")
        line.Thickness = 2
        line.Transparency = 1
        line.Visible = false
        table.insert(box, line)
    end
    
    ESPObjects[player] = box
end

local function UpdateESP()
    if not drawingSupported or not cfg.esp then
        for _, box in pairs(ESPObjects) do
            for _, line in ipairs(box) do
                line.Visible = false
            end
        end
        return
    end
    
    for player, box in pairs(ESPObjects) do
        if not player or not player.Parent or not player.Character then
            for _, line in ipairs(box) do
                line.Visible = false
            end
            continue
        end
        
        if cfg.espteamcheck and player.Team == LocalPlayer.Team then
            for _, line in ipairs(box) do
                line.Visible = false
            end
            continue
        end
        
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        
        if not hrp or not hum or hum.Health <= 0 then
            for _, line in ipairs(box) do
                line.Visible = false
            end
            continue
        end
        
        local corners = {
            Vector3.new(-1.5, 2.5, 0),
            Vector3.new(1.5, 2.5, 0),
            Vector3.new(-1.5, -2.5, 0),
            Vector3.new(1.5, -2.5, 0)
        }
        
        local screenCorners = {}
        local allVisible = true
        
        for i, offset in ipairs(corners) do
            local worldPos = hrp.Position + offset
            local screenPos, onScreen = Camera:WorldToViewportPoint(worldPos)
            
            if not onScreen then
                allVisible = false
                break
            end
            
            screenCorners[i] = Vector2.new(screenPos.X, screenPos.Y)
        end
        
        if allVisible then
            local color = GetTeamColor(player)
            
            box[1].From = screenCorners[1]
            box[1].To = screenCorners[2]
            box[1].Color = color
            box[1].Visible = true
            
            box[2].From = screenCorners[3]
            box[2].To = screenCorners[4]
            box[2].Color = color
            box[2].Visible = true
            
            box[3].From = screenCorners[1]
            box[3].To = screenCorners[3]
            box[3].Color = color
            box[3].Visible = true
            
            box[4].From = screenCorners[2]
            box[4].To = screenCorners[4]
            box[4].Color = color
            box[4].Visible = true
        else
            for _, line in ipairs(box) do
                line.Visible = false
            end
        end
    end
end

-- Initialize ESP
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        CreateESP(player)
        player.CharacterAdded:Connect(function()
            task.wait(0.5)
            CreateESP(player)
        end)
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(0.5)
        CreateESP(player)
    end)
end)

-- Update FOV Circle
local function UpdateFOVCircle()
    if not FOVCircle then return end
    
    pcall(function()
        local lastInput = UserInputService:GetLastInputType()
        local locked = (lastInput == Enum.UserInputType.Touch) or (UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter)
        
        local aimPos
        if locked then
            local viewportSize = Camera.ViewportSize
            aimPos = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
        else
            aimPos = UserInputService:GetMouseLocation()
        end
        
        FOVCircle.Position = aimPos
        FOVCircle.Radius = cfg.fov
        FOVCircle.Visible = cfg.showfov and cfg.enabled
        
        local target = getClosest()
        if target then
            FOVCircle.Color = Color3.fromRGB(255, 100, 100)
        else
            FOVCircle.Color = Color3.fromRGB(255, 255, 255)
        end
    end)
end

-- Main Loop
RunService.RenderStepped:Connect(function()
    UpdateESP()
    UpdateFOVCircle()
end)
