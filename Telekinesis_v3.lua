-- by Jenos2006

loadstring(game:HttpGet("https://raw.githubusercontent.com/Jenos2006/AllLuaScripts/refs/heads/main/Notify.lua"))()

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TabFrame = Instance.new("Frame")
local MainTab = Instance.new("TextButton")
local CreditsTab = Instance.new("TextButton")
local MainContent = Instance.new("Frame")
local CreditsContent = Instance.new("Frame")
local InfoLabel = Instance.new("TextLabel")
local ItemButton = Instance.new("TextButton")
local DescriptionLabel = Instance.new("TextLabel")
local DiscordButton = Instance.new("TextButton")
local DiscordImage = Instance.new("ImageLabel")
local DiscordText = Instance.new("TextLabel")

ScreenGui.Name = "TelekinesisGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0.4, 0, 0.5, 0)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundTransparency = 0
MainFrame.Active = true
MainFrame.Draggable = true

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0.1, 0)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Telekinesis v3 by Jenos2006"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true

TabFrame.Name = "TabFrame"
TabFrame.Parent = MainFrame
TabFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TabFrame.BorderSizePixel = 0
TabFrame.Position = UDim2.new(0, 0, 0.15, 0)
TabFrame.Size = UDim2.new(1, 0, 0.1, 0)

MainTab.Name = "MainTab"
MainTab.Parent = TabFrame
MainTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MainTab.Size = UDim2.new(0.5, 0, 1, 0)
MainTab.Font = Enum.Font.SourceSans
MainTab.Text = "Main"
MainTab.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTab.TextScaled = true

CreditsTab.Name = "CreditsTab"
CreditsTab.Parent = TabFrame
CreditsTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CreditsTab.Size = UDim2.new(0.5, 0, 1, 0)
CreditsTab.Position = UDim2.new(0.5, 0, 0, 0)
CreditsTab.Font = Enum.Font.SourceSans
CreditsTab.Text = "Credits"
CreditsTab.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditsTab.TextScaled = true

MainContent.Name = "MainContent"
MainContent.Parent = MainFrame
MainContent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainContent.BorderSizePixel = 0
MainContent.Position = UDim2.new(0, 0, 0.25, 0)
MainContent.Size = UDim2.new(1, 0, 0.75, 0)
MainContent.Visible = true

CreditsContent.Name = "CreditsContent"
CreditsContent.Parent = MainFrame
CreditsContent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CreditsContent.BorderSizePixel = 0
CreditsContent.Position = UDim2.new(0, 0, 0.25, 0)
CreditsContent.Size = UDim2.new(1, 0, 0.75, 0)
CreditsContent.Visible = false

InfoLabel.Name = "InfoLabel"
InfoLabel.Parent = CreditsContent
InfoLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
InfoLabel.BorderSizePixel = 0
InfoLabel.Size = UDim2.new(1, 0, 0.2, 0)
InfoLabel.Font = Enum.Font.SourceSans
InfoLabel.Text = "Script by Jenos2006\nThanks to MastersMZ for showcasing the script."
InfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoLabel.TextScaled = true

ItemButton.Name = "ItemButton"
ItemButton.Parent = MainContent
ItemButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ItemButton.Position = UDim2.new(0.3, 0, 0.3, 0)
ItemButton.Size = UDim2.new(0.4, 0, 0.4, 0)
ItemButton.Font = Enum.Font.SourceSans
ItemButton.Text = "Give Telekinesis"
ItemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ItemButton.TextScaled = true

DescriptionLabel.Name = "DescriptionLabel"
DescriptionLabel.Parent = MainContent
DescriptionLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
DescriptionLabel.BorderSizePixel = 0
DescriptionLabel.Position = UDim2.new(0.1, 0, 0.1, 0)
DescriptionLabel.Size = UDim2.new(0.8, 0, 0.2, 0)
DescriptionLabel.Font = Enum.Font.SourceSans
DescriptionLabel.Text = "Click once to select an object.\nLong press to fling the object.\nUnequip the item to deselect."
DescriptionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DescriptionLabel.TextScaled = true

DiscordButton.Name = "DiscordButton"
DiscordButton.Parent = CreditsContent
DiscordButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
DiscordButton.Position = UDim2.new(0.375, 0, 0.4, 0)
DiscordButton.Size = UDim2.new(0.25, 0, 0.35, 0)
DiscordButton.Font = Enum.Font.SourceSans
DiscordButton.Text = ""
DiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordButton.TextScaled = true

DiscordImage.Name = "DiscordImage"
DiscordImage.Parent = DiscordButton
DiscordImage.Size = UDim2.new(1, 0, 0.8, 0)
DiscordImage.Image = "rbxassetid://18810599545"
DiscordText.Name = "DiscordText"
DiscordText.Parent = DiscordButton
DiscordText.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
DiscordText.BorderSizePixel = 0
DiscordText.Position = UDim2.new(0, 0, 0.8, 0)
DiscordText.Size = UDim2.new(1, 0, 0.2, 0)
DiscordText.Font = Enum.Font.SourceSans
DiscordText.Text = "Also join my Discord"
DiscordText.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordText.TextScaled = true

local function roundify(element)
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = element
end

roundify(ScreenGui)
roundify(MainFrame)
roundify(Title)
roundify(TabFrame)
roundify(MainTab)
roundify(CreditsTab)
roundify(MainContent)
roundify(CreditsContent)
roundify(InfoLabel)
roundify(ItemButton)
roundify(DescriptionLabel)
roundify(DiscordButton)
roundify(DiscordImage)
roundify(DiscordText)

DiscordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.com/BNb2Fg7W9q")
    notify("Telekinesis v3", "Discord invitation link copied to clipboard.", 5)
end)

MainTab.MouseButton1Click:Connect(function()
    MainContent.Visible = true
    CreditsContent.Visible = false
end)

CreditsTab.MouseButton1Click:Connect(function()
    MainContent.Visible = false
    CreditsContent.Visible = true
end)

ItemButton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    if not player.Backpack:FindFirstChild("Telekinesis") then
        local h = Instance.new("Model", game:GetService("Lighting"))
        local i = Instance.new("Tool")
        local j = Instance.new("Part")
        local k = Instance.new("Script")
        local l = Instance.new("LocalScript")
        local function a(b, c)
            local d = getfenv(c)
            local e =
                setmetatable(
                {},
                {__index = function(self, f)
                        if f == "script" then
                            return b
                        else
                            return d[f]
                        end
                    end}
            )
            setfenv(c, e)
            return c
        end
        local power = 1000
        local usrinput = game:GetService("UserInputService")
        local g = {}
        i.Name = "Telekinesis"
        i.Parent = h
        i.Grip = CFrame.new(0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0)
        i.GripForward = Vector3.new(-0, -1, -0)
        i.GripRight = Vector3.new(0, 0, 1)
        i.GripUp = Vector3.new(1, 0, 0)
        j.Name = "Handle"
        j.Parent = i
        j.CFrame = CFrame.new(-17.2635937, 15.4915619, 46, 0, 1, 0, 1, 0, 0, 0, 0, -1)
        j.Orientation = Vector3.new(0, 180, 90)
        j.Position = Vector3.new(-17.2635937, 15.4915619, 46)
        j.Rotation = Vector3.new(-180, 0, -90)
        j.Color = Color3.new(0.0666667, 0.0666667, 0.0666667)
        j.Transparency = 1
        j.Size = Vector3.new(1, 1.20000005, 1)
        j.BottomSurface = Enum.SurfaceType.Weld
        j.BrickColor = BrickColor.new("Really black")
        j.Material = Enum.Material.Metal
        j.TopSurface = Enum.SurfaceType.Smooth
        j.brickColor = BrickColor.new("Really black")
        k.Name = "LineConnect"
        k.Parent = i
        table.insert(
            g,
            a(
                k,
                function()
                    wait()
                    local n = script.Part2
                    local o = script.Part1.Value
                    local p = script.Part2.Value
                    local q = script.Par.Value
                    local color = script.Color
                    local r = Instance.new("Part")
                    r.TopSurface = 0
                    r.BottomSurface = 0
                    r.Reflectance = .5
                    r.Name = "Laser"
                    r.Locked = true
                    r.CanCollide = false
                    r.Anchored = true
                    r.formFactor = 0
                    r.Size = Vector3.new(1, 1, 1)
                    local s = Instance.new("BlockMesh")
                    s.Parent = r
                    while true do
                        if n.Value == nil then
                            break
                        end
                        if o == nil or p == nil or q == nil then
                            break
                        end
                        if o.Parent == nil or p.Parent == nil then
                            break
                        end
                        if q.Parent == nil then
                            break
                        end
                        local t = CFrame.new(o.Position, p.Position)
                        local dist = (o.Position - p.Position).magnitude
                        r.Parent = q
                        r.BrickColor = color.Value.BrickColor
                        r.Reflectance = color.Value.Reflectance
                        r.Transparency = color.Value.Transparency
                        r.CFrame = CFrame.new(o.Position + t.lookVector * dist / 2)
                        r.CFrame = CFrame.new(r.Position, p.Position)
                        s.Scale = Vector3.new(.25, .25, dist)
                        wait()
                    end
                    r:remove()
                    script:remove()
                end
            )
        )
        k.Disabled = true
        l.Name = "MainScript"
        l.Parent = i
        table.insert(
            g,
            a(
                l,
                function()
                    wait()
                    tool = script.Parent
                    lineconnect = tool.LineConnect
                    object = nil
                    mousedown = false
                    found = false
                    BP = Instance.new("BodyPosition")
                    BP.maxForce = Vector3.new(math.huge * math.huge, math.huge * math.huge, math.huge * math.huge)
                    BP.P = BP.P * 2
                    dist = nil
                    point = Instance.new("Part")
                    point.Locked = true
                    point.Anchored = true
                    point.formFactor = 0
                    point.Shape = 0
                    point.BrickColor = BrickColor.Black()
                    point.Size = Vector3.new(1, 1, 1)
                    point.CanCollide = false
                    local s = Instance.new("SpecialMesh")
                    s.MeshType = "Sphere"
                    s.Scale = Vector3.new(.7, .7, .7)
                    s.Parent = point
                    handle = tool.Handle
                    front = tool.Handle
                    color = tool.Handle
                    objval = nil
                    local u = false
                    local v = BP:clone()
                    v.maxForce = Vector3.new(30000, 30000, 30000)
                    function LineConnect(o, p, q)
                        local w = Instance.new("ObjectValue")
                        w.Value = o
                        w.Name = "Part1"
                        local x = Instance.new("ObjectValue")
                        x.Value = p
                        x.Name = "Part2"
                        local y = Instance.new("ObjectValue")
                        y.Value = q
                        y.Name = "Par"
                        local z = Instance.new("ObjectValue")
                        z.Value = color
                        z.Name = "Color"
                        local A = lineconnect:clone()
                        A.Disabled = false
                        w.Parent = A
                        x.Parent = A
                        y.Parent = A
                        z.Parent = workspace
                        if p == object then
                            objval = x
                        end
                    end
                    function onButton1Down(B)
                        if mousedown == true then
                            return
                        end
                        mousedown = true
                        coroutine.resume(
                            coroutine.create(
                                function()
                                    local C = point:clone()
                                    C.Parent = tool
                                    LineConnect(front, C, workspace)
                                    while mousedown == true do
                                        C.Parent = tool
                                        if object == nil then
                                            if B.Target == nil then
                                                local t = CFrame.new(front.Position, B.Hit.p)
                                                C.CFrame = CFrame.new(front.Position + t.lookVector * 1000)
                                            else
                                                C.CFrame = CFrame.new(B.Hit.p)
                                            end
                                        else
                                            LineConnect(front, object, workspace)
                                            break
                                        end
                                        wait()
                                    end
                                    C:remove()
                                end
                            )
                        )
                        while mousedown == true do
                            if B.Target ~= nil then
                                local D = B.Target
                                if D.Anchored == false then
                                    object = D
                                    dist = (object.Position - front.Position).magnitude
                                    break
                                end
                            end
                            wait()
                        end
                        while mousedown == true do
                            if object.Parent == nil then
                                break
                            end
                            local t = CFrame.new(front.Position, B.Hit.p)
                            BP.Parent = object
                            BP.position = front.Position + t.lookVector * dist
                            wait()
                        end
                        BP:remove()
                        object = nil
                        objval.Value = nil
                    end
                    function onKeyDown(E, B)
                        local E = E:lower()
                        local F = false
                        if E == "q" then
                            if dist >= 5 then
                                dist = dist - 10
                            end
                        end
                        if E == "r" then
                            if object == nil then
                                return
                            end
                            for G, H in pairs(object:children()) do
                                if H.className == "BodyGyro" then
                                    return nil
                                end
                            end
                            BG = Instance.new("BodyGyro")
                            BG.maxTorque = Vector3.new(math.huge, math.huge, math.huge)
                            BG.cframe = CFrame.new(object.CFrame.p)
                            BG.Parent = object
                            repeat
                                wait()
                            until object.CFrame == CFrame.new(object.CFrame.p)
                            BG.Parent = nil
                            if object == nil then
                                return
                            end
                            for G, H in pairs(object:children()) do
                                if H.className == "BodyGyro" then
                                    H.Parent = nil
                                end
                            end
                            object.Velocity = Vector3.new(0, 0, 0)
                            object.RotVelocity = Vector3.new(0, 0, 0)
                            object.Orientation = Vector3.new(0, 0, 0)
                        end
                        if E == "e" then
                            dist = dist + 10
                        end
                        if E == "t" then
                            if dist ~= 10 then
                                dist = 10
                            end
                        end
                        if E == "y" then
                            if dist ~= 200 then
                                dist = 200
                            end
                        end
                        if E == "=" then
                            BP.P = BP.P * 1.5
                        end
                        if E == "-" then
                            BP.P = BP.P * 0.5
                        end
                    end
                    function onEquipped(B)
                        touched = false
                        uneq = false
                        keymouse = B
                        local I = tool.Parent
                        human = I.Humanoid
                        human.Changed:connect(
                            function()
                                if human.Health == 0 then
                                    mousedown = false
                                    uneq = true
                                    touched = false
                                    BP:remove()
                                    point:remove()
                                    tool:remove()
                                end
                            end
                        )
                        usrinput.TouchTapInWorld:connect(
                            function()
                                if uneq == false then
                                if touched == false then
                                onButton1Down(B)
                                touched = true
                                elseif touched == true then
                                touched = false
                                end
                                end
                            end
                        )
                        usrinput.TouchLongPress:connect(function()
                            if uneq == false then
                                if dist ~= power then
                                    dist = power
                                end
                            end
                        end)
                        B.KeyDown:connect(
                            function(E)
                                onKeyDown(E, B)
                            end
                        )
                        B.Icon = "rbxasset://textures\\GunCursor.png"
                    end
                    tool.Equipped:connect(onEquipped)
                    tool.Unequipped:connect(function() uneq = true touched = false mousedown = false end)
                end
            )
        )
        for J, H in pairs(h:GetChildren()) do
            H.Parent = game:GetService("Players").LocalPlayer.Backpack
            pcall(
                function()
                    H:MakeJoints()
                end
            )
        end
        h:Destroy()
        for J, H in pairs(g) do
            spawn(
                function()
                    pcall(H)
                end
            )
        end
        notify("Telekinesis v3", "Telekinesis tool added to your backpack.", 5)
    else
        notify("Telekinesis v3", "You already have the Telekinesis tool.", 5)
    end
end)
notify("Telekinesis v3", "Telekinesis script loaded successfully.", 5)
