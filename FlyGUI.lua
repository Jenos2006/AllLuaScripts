local main = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local onof = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local plus = Instance.new("TextButton")
local speed = Instance.new("TextLabel")
local mine = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local DragFrame = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")

main.Name = "main"
main.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
main.IgnoreGuiInset = true

Frame.Parent = main
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BackgroundTransparency = 0.05
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.5, -85, 0.5, -60)
Frame.Size = UDim2.new(0, 170, 0, 125)
Frame.ClipsDescendants = true

UICorner.Parent = Frame
UICorner.CornerRadius = UDim.new(0, 12)

UIGradient.Parent = Frame
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
})

local Glow = Instance.new("Frame")
Glow.Parent = Frame
Glow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Glow.BorderSizePixel = 0
Glow.Position = UDim2.new(-0.05, 0, -0.05, 0)
Glow.Size = UDim2.new(1.1, 0, 1.1, 0)
Glow.BackgroundTransparency = 0.8
local GlowCorner = Instance.new("UICorner")
GlowCorner.Parent = Glow
GlowCorner.CornerRadius = UDim.new(0, 16)

TextLabel.Parent = Frame
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0, 0, 0.05, 0)
TextLabel.Size = UDim2.new(1, 0, 0, 25)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.Text = "VENORA FLY"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 14
TextLabel.TextScaled = true

local line = Instance.new("Frame")
line.Parent = Frame
line.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
line.BorderSizePixel = 0
line.Position = UDim2.new(0.05, 0, 0.28, 0)
line.Size = UDim2.new(0.9, 0, 0, 1)

plus.Parent = Frame
plus.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
plus.BorderSizePixel = 0
plus.Position = UDim2.new(0.05, 0, 0.36, 0)
plus.Size = UDim2.new(0, 45, 0, 35)
plus.Font = Enum.Font.GothamBold
plus.Text = "+"
plus.TextColor3 = Color3.fromRGB(255, 255, 255)
plus.TextSize = 20
local plusCorner = Instance.new("UICorner")
plusCorner.Parent = plus
plusCorner.CornerRadius = UDim.new(0, 8)

speed.Parent = Frame
speed.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
speed.BorderSizePixel = 0
speed.Position = UDim2.new(0.35, 0, 0.36, 0)
speed.Size = UDim2.new(0, 50, 0, 35)
speed.Font = Enum.Font.GothamBold
speed.Text = "1"
speed.TextColor3 = Color3.fromRGB(255, 215, 0)
speed.TextSize = 18
speed.TextXAlignment = Enum.TextXAlignment.Center
local speedCorner = Instance.new("UICorner")
speedCorner.Parent = speed
speedCorner.CornerRadius = UDim.new(0, 8)

mine.Parent = Frame
mine.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mine.BorderSizePixel = 0
mine.Position = UDim2.new(0.68, 0, 0.36, 0)
mine.Size = UDim2.new(0, 45, 0, 35)
mine.Font = Enum.Font.GothamBold
mine.Text = "-"
mine.TextColor3 = Color3.fromRGB(255, 255, 255)
mine.TextSize = 20
local mineCorner = Instance.new("UICorner")
mineCorner.Parent = mine
mineCorner.CornerRadius = UDim.new(0, 8)

onof.Parent = Frame
onof.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
onof.BorderSizePixel = 0
onof.Position = UDim2.new(0.05, 0, 0.66, 0)
onof.Size = UDim2.new(0.9, 0, 0, 35)
onof.Font = Enum.Font.GothamBold
onof.Text = "FLY"
onof.TextColor3 = Color3.fromRGB(255, 255, 255)
onof.TextSize = 16
local onofCorner = Instance.new("UICorner")
onofCorner.Parent = onof
onofCorner.CornerRadius = UDim.new(0, 8)

DragFrame.Parent = Frame
DragFrame.BackgroundTransparency = 1
DragFrame.Size = UDim2.new(1, 0, 0.28, 0)
DragFrame.Position = UDim2.new(0, 0, 0, 0)

local dragging = false
local dragStartPos
local frameStartPos
local originalSize = Frame.Size
local enlargedSize = UDim2.new(0, 180, 0, 133)

DragFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStartPos = input.Position
        frameStartPos = Frame.Position
        Frame:TweenSize(enlargedSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
    end
end)

DragFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
        Frame:TweenSize(originalSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartPos
        Frame.Position = UDim2.new(frameStartPos.X.Scale, frameStartPos.X.Offset + delta.X, frameStartPos.Y.Scale, frameStartPos.Y.Offset + delta.Y)
    end
end)

speeds = 1
local speaker = game:GetService("Players").LocalPlayer
nowe = false

local function updateFlyState()
    if nowe == true then
        onof.Text = "STOP"
        onof.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    else
        onof.Text = "FLY"
        onof.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end
end

onof.MouseButton1Down:connect(function()
    if nowe == true then
        nowe = false
        updateFlyState()
        
        for _, state in pairs(Enum.HumanoidStateType:GetEnumItems()) do
            speaker.Character.Humanoid:SetStateEnabled(state, true)
        end
        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
    else 
        nowe = true
        updateFlyState()
        
        for i = 1, speeds do
            spawn(function()
                local hb = game:GetService("RunService").Heartbeat    
                tpwalking = true
                local chr = game.Players.LocalPlayer.Character
                local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                    if hum.MoveDirection.Magnitude > 0 then
                        chr:TranslateBy(hum.MoveDirection)
                    end
                end
            end)
        end
        
        if game.Players.LocalPlayer.Character:FindFirstChild("Animate") then
            game.Players.LocalPlayer.Character.Animate.Disabled = true
        end
        
        for _, state in pairs(Enum.HumanoidStateType:GetEnumItems()) do
            speaker.Character.Humanoid:SetStateEnabled(state, false)
        end
        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
    end
    
    local plr = game.Players.LocalPlayer
    if not plr.Character then return end
    
    local rigType = plr.Character:FindFirstChildOfClass("Humanoid").RigType
    local bodyPart = rigType == Enum.HumanoidRigType.R6 and plr.Character:FindFirstChild("Torso") or plr.Character:FindFirstChild("UpperTorso")
    
    if not bodyPart then return end
    
    local bg = Instance.new("BodyGyro", bodyPart)
    bg.P = 9e4
    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.cframe = bodyPart.CFrame
    local bv = Instance.new("BodyVelocity", bodyPart)
    bv.velocity = Vector3.new(0,0.1,0)
    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
    
    if nowe == true then
        plr.Character.Humanoid.PlatformStand = true
    end
    
    local ctrl = {f = 0, b = 0, l = 0, r = 0}
    local lastctrl = {f = 0, b = 0, l = 0, r = 0}
    local maxspeed = 50
    local speedVal = 0
    
    local moveConnection1
    local moveConnection2
    
    moveConnection1 = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local key = input.KeyCode
            if key == Enum.KeyCode.W then ctrl.f = 1
            elseif key == Enum.KeyCode.S then ctrl.b = -1
            elseif key == Enum.KeyCode.A then ctrl.l = -1
            elseif key == Enum.KeyCode.D then ctrl.r = 1
            end
        end
    end)
    
    moveConnection2 = game:GetService("UserInputService").InputEnded:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local key = input.KeyCode
            if key == Enum.KeyCode.W then ctrl.f = 0
            elseif key == Enum.KeyCode.S then ctrl.b = 0
            elseif key == Enum.KeyCode.A then ctrl.l = 0
            elseif key == Enum.KeyCode.D then ctrl.r = 0
            end
        end
    end)
    
    while nowe == true and plr.Character and plr.Character.Humanoid and plr.Character.Humanoid.Health > 0 do
        game:GetService("RunService").RenderStepped:Wait()
        
        if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
            speedVal = math.min(speedVal + 0.5 + (speedVal/maxspeed), maxspeed)
        elseif speedVal ~= 0 then
            speedVal = math.max(speedVal - 1, 0)
        end
        
        if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
            bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speedVal
            lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
        elseif speedVal ~= 0 then
            bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speedVal
        else
            bv.velocity = Vector3.new(0,0,0)
        end
        
        bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speedVal/maxspeed),0,0)
    end
    
    moveConnection1:Disconnect()
    moveConnection2:Disconnect()
    bg:Destroy()
    bv:Destroy()
    if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
        plr.Character.Humanoid.PlatformStand = false
    end
    if plr.Character and plr.Character:FindFirstChild("Animate") then
        plr.Character.Animate.Disabled = false
    end
    tpwalking = false
end)

game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
    wait(0.7)
    if char and char:FindFirstChildOfClass("Humanoid") then
        char.Humanoid.PlatformStand = false
    end
    if char and char:FindFirstChild("Animate") then
        char.Animate.Disabled = false
    end
    nowe = false
    updateFlyState()
end)

plus.MouseButton1Down:connect(function()
    speeds = speeds + 1
    speed.Text = speeds
    if nowe == true then
        tpwalking = false
        for i = 1, speeds do
            spawn(function()
                local hb = game:GetService("RunService").Heartbeat    
                tpwalking = true
                local chr = game.Players.LocalPlayer.Character
                local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                    if hum.MoveDirection.Magnitude > 0 then
                        chr:TranslateBy(hum.MoveDirection)
                    end
                end
            end)
        end
    end
end)

mine.MouseButton1Down:connect(function()
    if speeds == 1 then
        speed.Text = "MIN"
        wait(0.8)
        speed.Text = speeds
    else
        speeds = speeds - 1
        speed.Text = speeds
        if nowe == true then
            tpwalking = false
            for i = 1, speeds do
                spawn(function()
                    local hb = game:GetService("RunService").Heartbeat    
                    tpwalking = true
                    local chr = game.Players.LocalPlayer.Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                    while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                        if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection)
                        end
                    end
                end)
            end
        end
    end
end)

for _, button in pairs({plus, mine, onof}) do
    button.AutoButtonColor = true
end
