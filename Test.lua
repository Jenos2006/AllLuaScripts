local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

local function playSound(soundId)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. soundId
    sound.Parent = SoundService
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end
playSound("2865227271")

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Venora - Unanchored Ring",
    Icon = 0,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "VenoraRing",
        FileName = "Config"
    },
    KeySystem = false
})

local MainTab = Window:CreateTab("Tornado")
local SettingsTab = Window:CreateTab("Settings")
local CreditTab = Window:CreateTab("Credit")

local config = {
    radius = 50,
    height = 100,
    rotationSpeed = 10,
    attractionStrength = 1000,
}

local function saveConfig()
    local configStr = HttpService:JSONEncode(config)
    writefile("VenoraRingConfig.txt", configStr)
end

local function loadConfig()
    if isfile("VenoraRingConfig.txt") then
        local success, result = pcall(function()
            local configStr = readfile("VenoraRingConfig.txt")
            return HttpService:JSONDecode(configStr)
        end)
        if success and result then
            for k, v in pairs(result) do
                config[k] = v
            end
        end
    end
end
loadConfig()

local ringPartsEnabled = false

if not getgenv().Network then
    getgenv().Network = {
        BaseParts = {},
        Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424)
    }

    Network.RetainPart = function(Part)
        if typeof(Part) == "Instance" and Part:IsA("BasePart") and Part:IsDescendantOf(Workspace) then
            table.insert(Network.BaseParts, Part)
            Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
            Part.CanCollide = false
        end
    end

    local function EnablePartControl()
        LocalPlayer.ReplicationFocus = Workspace
        RunService.Heartbeat:Connect(function()
            sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
            for _, Part in pairs(Network.BaseParts) do
                if Part:IsDescendantOf(Workspace) then
                    Part.Velocity = Network.Velocity
                end
            end
        end)
    end
    EnablePartControl()
end

local parts = {}

local function RetainPart(Part)
    if Part:IsA("BasePart") and not Part.Anchored and Part:IsDescendantOf(Workspace) then
        if Part.Parent == LocalPlayer.Character or Part:IsDescendantOf(LocalPlayer.Character) then
            return false
        end
        Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
        Part.CanCollide = false
        return true
    end
    return false
end

local function addPart(part)
    if RetainPart(part) and not table.find(parts, part) then
        table.insert(parts, part)
    end
end

local function removePart(part)
    local index = table.find(parts, part)
    if index then
        table.remove(parts, index)
    end
end

for _, part in pairs(Workspace:GetDescendants()) do
    addPart(part)
end

Workspace.DescendantAdded:Connect(addPart)
Workspace.DescendantRemoving:Connect(removePart)

local Folder = Instance.new("Folder", Workspace)
local RefPart = Instance.new("Part", Folder)
local Attachment1 = Instance.new("Attachment", RefPart)
RefPart.Anchored = true
RefPart.CanCollide = false
RefPart.Transparency = 1

RunService.Heartbeat:Connect(function()
    if not ringPartsEnabled then return end
    
    local character = LocalPlayer.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        local tornadoCenter = humanoidRootPart.Position
        for _, part in pairs(parts) do
            if part and part.Parent and not part.Anchored then
                local pos = part.Position
                local distance = (Vector3.new(pos.X, tornadoCenter.Y, pos.Z) - tornadoCenter).Magnitude
                local angle = math.atan2(pos.Z - tornadoCenter.Z, pos.X - tornadoCenter.X)
                local newAngle = angle + math.rad(config.rotationSpeed)
                local targetPos = Vector3.new(
                    tornadoCenter.X + math.cos(newAngle) * math.min(config.radius, distance),
                    tornadoCenter.Y + (config.height * (math.abs(math.sin((pos.Y - tornadoCenter.Y) / config.height)))),
                    tornadoCenter.Z + math.sin(newAngle) * math.min(config.radius, distance)
                )
                local directionToTarget = (targetPos - part.Position).unit
                part.Velocity = directionToTarget * config.attractionStrength
            end
        end
    end
end)

MainTab:CreateToggle({
    Name = "Enable Tornado",
    CurrentValue = false,
    Flag = "TornadoToggle",
    Callback = function(Value)
        ringPartsEnabled = Value
        playSound("12221967")
    end
})

SettingsTab:CreateSlider({
    Name = "Radius",
    Range = {10, 150},
    Increment = 5,
    Suffix = "Studs",
    CurrentValue = config.radius,
    Flag = "RadiusSlider",
    Callback = function(Value)
        config.radius = Value
        saveConfig()
    end
})

SettingsTab:CreateSlider({
    Name = "Height",
    Range = {20, 250},
    Increment = 5,
    Suffix = "Studs",
    CurrentValue = config.height,
    Flag = "HeightSlider",
    Callback = function(Value)
        config.height = Value
        saveConfig()
    end
})

SettingsTab:CreateSlider({
    Name = "Rotation Speed",
    Range = {0, 50},
    Increment = 1,
    Suffix = "deg/s",
    CurrentValue = config.rotationSpeed,
    Flag = "SpeedSlider",
    Callback = function(Value)
        config.rotationSpeed = Value
        saveConfig()
    end
})

SettingsTab:CreateSlider({
    Name = "Attraction Strength",
    Range = {100, 5000},
    Increment = 50,
    Suffix = "Force",
    CurrentValue = config.attractionStrength,
    Flag = "StrengthSlider",
    Callback = function(Value)
        config.attractionStrength = Value
        saveConfig()
    end
})

CreditTab:CreateLabel("Made with Love by the Venora Team")

CreditTab:CreateLabel("@Jenos2006")

CreditTab:CreateLabel("@traubenschlecker")

CreditTab:CreateButton({
    Name = "Discord Server",
    Callback = function()
        setclipboard("https://discord.gg/4WcYz2pp45")
    end
})

local ExtraTab = Window:CreateTab("Extras")

ExtraTab:CreateButton({
    Name = "No Fall Damage",
    Callback = function()
        local runsvc = game:GetService("RunService")
        local heartbeat = runsvc.Heartbeat
        local rstepped = runsvc.RenderStepped
        local lp = game.Players.LocalPlayer
        local novel = Vector3.zero

        local function nofalldamage(chr)
            local root = chr:WaitForChild("HumanoidRootPart")
            if root then
                local con
                con = heartbeat:Connect(function()
                    if not root.Parent then con:Disconnect() end
                    local oldvel = root.AssemblyLinearVelocity
                    root.AssemblyLinearVelocity = novel
                    rstepped:Wait()
                    root.AssemblyLinearVelocity = oldvel
                end)
            end
        end

        nofalldamage(lp.Character)
        lp.CharacterAdded:Connect(nofalldamage)
        playSound("12221967")
    end
})

ExtraTab:CreateButton({
    Name = "Noclip",
    Callback = function()
        local Noclip = nil
        local Clip = false
        local function noclip()
            Clip = false
            local function Nocl()
                if Clip == false and game.Players.LocalPlayer.Character ~= nil then
                    for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if v:IsA('BasePart') and v.CanCollide then
                            v.CanCollide = false
                        end
                    end
                end
                wait(0.21)
            end
            Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
        end
        noclip()
        playSound("12221967")
    end
})

ExtraTab:CreateButton({
    Name = "Infinite Jump",
    Callback = function()
        local InfiniteJumpEnabled = true
        game:GetService("UserInputService").JumpRequest:connect(function()
            if InfiniteJumpEnabled then
                game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
            end
        end)
        playSound("12221967")
    end
})

ExtraTab:CreateButton({
    Name = "Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        playSound("12221967")
    end
})

playSound("12221967")
