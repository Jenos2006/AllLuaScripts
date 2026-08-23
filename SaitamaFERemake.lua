print('Saitama Remaked by TrockenerTisch')
--Saitama
--Remaked by TrockenerTisch
--For The Script To Execute You Need:
--https://web.roblox.com/catalog/6470135113/Fan-Hand-Sign-Why-Dont-We-WDW
--R - Main Idle
--E - Barrage
--Click - Punch
for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
game:GetService("RunService").Heartbeat:connect(function()
v.Velocity = Vector3.new(0,35,0)
wait(0.5)
end)
end
end

game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "Notification";
	Text = "Netless activated";
	Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"})
Duration = 16;
local player = game.Players.LocalPlayer
local HatChar = player.Character
if not HatChar then
    HatChar = player.CharacterAdded:Wait()
end

local humanoid = HatChar:FindFirstChildOfClass("Humanoid")
if not humanoid or humanoid.RigType ~= Enum.HumanoidRigType.R6 then
    game.StarterGui:SetCore("SendNotification", {
        Title = "Saitama Remaked";
        Text = "R6 required to use this script.";
        Duration = 5;
    })
    return
end

local Hat = HatChar:FindFirstChild("WDW_FoamFinger")
if not Hat or not Hat:FindFirstChild("Handle") then
    game.StarterGui:SetCore("SendNotification", {
        Title = "Saitama Remaked";
        Text = "Accessory WDW_FoamFinger not equipped.";
        Duration = 5;
    })
    return
end

Hat.Handle.SpecialMesh:Destroy()




HumanDied = false
local reanim
function noplsmesh(hat)
_G.OldCF=workspace.Camera.CFrame
oldchar=game.Players.LocalPlayer.Character
game.Players.LocalPlayer.Character=workspace[game.Players.LocalPlayer.Name]
for i,v in next, workspace[game.Players.LocalPlayer.Name][hat]:GetDescendants() do
if v:IsA('Mesh') or v:IsA('SpecialMesh') then
v:Remove()
end
end
game.Players.LocalPlayer.Character=oldchar
wait()
workspace.Camera.CFrame=_G.OldCF
game.Players.LocalPlayer.Character=oldchar
end

_G.ClickFling=false -- Set this to true if u want.
-----------------------------------------------------------------------------------------------------------------------------------------
plr = game.Players.LocalPlayer
char=game.Players.LocalPlayer.Character
ct={}
te=table.insert

HumanDied=false

for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
if v:IsA("BasePart") then 
te(ct,game:GetService("RunService").Heartbeat:connect(function()
pcall(function()
v.Velocity = Vector3.new(0,-30,0)
sethiddenproperty(game.Players.LocalPlayer,"MaximumSimulationRadius",math.huge)
sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",999999999)
game.Players.LocalPlayer.ReplicationFocus = workspace
end)
end))
end
end

function notify(t,tex,dur)
game.StarterGui:SetCore("SendNotification", {
    Title = t; 
    Text = tex; 
    Duration = dur or 5;
})
end

local srv= game:GetService("RunService")

fl=Instance.new('Folder',char);fl.Name='CWExtra'

char.Archivable = true
local reanim = char:Clone()
reanim.Name='NexoPD'

for i,v in next, reanim:GetDescendants() do
if v:IsA('BasePart') or v:IsA('Decal') then
v.Transparency = 1 
end 
end

--flinge = false

penis=5.65
plr.Character=nil
plr.Character=char
char.Humanoid.AutoRotate=false
char.Humanoid.WalkSpeed=0
char.Humanoid.JumpPower=0
char.Torso.Anchored = true
notify('Saitama Remaked','Reanimating...\nPlease wait '..penis..' seconds.')
wait(penis)
char.Torso.Anchored=false
notify('Saitama Remaked','Reanimated..')
char.Humanoid.Health=0
--reanim.Humanoid.AutoRotate=false
reanim.Animate.Disabled = true
reanim.Parent = fl
reanim.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame*CFrame.new(0,5,0)

function create(part, parent, p, r)
Instance.new("Attachment",part)
Instance.new("AlignPosition",part)
Instance.new("AlignOrientation",part)
Instance.new("Attachment",parent)
part.Attachment.Name = part.Name
parent.Attachment.Name = part.Name
part.AlignPosition.Attachment0 = part[part.Name]
part.AlignOrientation.Attachment0 = part[part.Name]
part.AlignPosition.Attachment1 = parent[part.Name]
part.AlignOrientation.Attachment1 = parent[part.Name]
parent[part.Name].Position = p or Vector3.new()
part[part.Name].Orientation = r or Vector3.new()
part.AlignPosition.MaxForce = 999999999
part.AlignPosition.MaxVelocity = math.huge
part.AlignPosition.ReactionForceEnabled = false
part.AlignPosition.Responsiveness = math.huge
part.AlignOrientation.Responsiveness = math.huge
part.AlignPosition.RigidityEnabled = false
part.AlignOrientation.MaxTorque = 999999999
part.Massless=true
end

function Pos(part, parent, p)
Instance.new("Attachment",part)
Instance.new("AlignPosition",part)
Instance.new("Attachment",parent)
part.Attachment.Name = part.Name
parent.Attachment.Name = part.Name
part.AlignPosition.Attachment0 = part[part.Name]
--part.AlignOrientation.Attachment0 = part[part.Name]
part.AlignPosition.Attachment1 = parent[part.Name]
--part.AlignOrientation.Attachment1 = parent[part.Name]
parent[part.Name].Position = p or Vector3.new()
part.AlignPosition.MaxForce = 999999999
part.AlignPosition.MaxVelocity = math.huge
part.AlignPosition.ReactionForceEnabled = false
part.AlignPosition.Responsiveness = math.huge
--part.AlignOrientation.Responsiveness = math.huge
--part.AlignPosition.RigidityEnabled = false
--part.AlignOrientation.MaxTorque = 999999999
part.Massless=true
end

for i,part in next, char:GetDescendants() do
if part:IsA('BasePart') then
te(ct,srv.RenderStepped:Connect(function()
part.CanCollide=false
end))
end
end

for i,part in next, char:GetDescendants() do
if part:IsA('BasePart') then
te(ct,srv.Stepped:Connect(function()
part.CanCollide=false
end))
end
end

for i,part in next, reanim:GetDescendants() do
if part:IsA('BasePart') then
te(ct,srv.RenderStepped:Connect(function()
part.CanCollide=false
end))
end
end

for i,part in next, reanim:GetDescendants() do
if part:IsA('BasePart') then
te(ct,srv.Stepped:Connect(function()
part.CanCollide=false
end))
end
end

for i,v in next, char:GetDescendants() do
if v:IsA('Accessory') then
create(v.Handle,reanim[v.Name].Handle)
end
end

--Pos(fhrp,reanim['Torso'])
create(char['Head'],reanim['Head'])
create(char['Torso'],reanim['Torso'])
Pos(char['HumanoidRootPart'],reanim['Torso'],Vector3.new(0,0,0))
create(char['Right Arm'],reanim['Right Arm'])
create(char['Left Arm'],reanim['Left Arm'])
create(char['Right Leg'],reanim['Right Leg'])
create(char['Left Leg'],reanim['Left Leg'])

m = plr:GetMouse()

local LVecPart = Instance.new("Part", fl)
LVecPart.CanCollide = false
LVecPart.Transparency = 1
LVecPart.Anchored = true

wdown=false
sdown=false
adown=false
ddown=false
spacedown=false

local function UpdateMoveDirection()
    local camera = workspace.CurrentCamera
    local root = reanim and reanim:FindFirstChild("HumanoidRootPart")
    if not camera or not root then return end

    local forward = (camera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
    local right = (camera.CFrame.RightVector * Vector3.new(1, 0, 1)).Unit
    local moveVector = Vector3.new(0, 0, 0)

    if wdown then
        moveVector += forward
    end
    if sdown then
        moveVector -= forward
    end
    if adown then
        moveVector -= right
    end
    if ddown then
        moveVector += right
    end

    LVecPart.Position = root.Position
    if moveVector.Magnitude > 0 then
        reanim.Humanoid.WalkToPoint = root.Position + moveVector * 12
    else
        reanim.Humanoid.WalkToPoint = root.Position
    end
end

te(ct,srv.RenderStepped:Connect(function()
    local camera = workspace.CurrentCamera
    local root = reanim and reanim:FindFirstChild("HumanoidRootPart")
    if camera and root then
        LVecPart.Position = root.Position
        LVecPart.CFrame = CFrame.new(root.Position, root.Position + camera.CFrame.LookVector)
    end

    if spacedown then
        reanim.Humanoid.Jump = true
    end

    UpdateMoveDirection()
end))

--reanim.HumanoidRootPart.RootJoint.Part0=nil

function flinger(p)
f=Instance.new('BodyAngularVelocity',p)
f.AngularVelocity = Vector3.new(9e9,9e9,9e9)
f.MaxTorque=Vector3.new(9e9,9e9,9e9)
end

flinger(char.HumanoidRootPart)

m=plr:GetMouse()

--char.HumanoidRootPart.Transparency = 0

bp=Instance.new('BodyPosition',char.HumanoidRootPart)
bp.P = 9e9
bp.D = 9e9
bp.MaxForce=Vector3.new(99999,99999,99999)

local click

te(ct,srv.Heartbeat:Connect(function()
if click == true then
bp.Position=m.Hit.p
char.HumanoidRootPart.Position=m.Hit.p
else
bp.Position=reanim.Torso.Position
char.HumanoidRootPart.Position=reanim.Torso.Position
end
end))

local Highlight = Instance.new("SelectionBox")
Highlight.Adornee = char.HumanoidRootPart
Highlight.LineThickness=0.05
Highlight.Color3 = Color3.fromRGB(30,255,30)
Highlight.Parent = char.HumanoidRootPart
Highlight.Name = "RAINBOW"

hrp = Highlight

spawn(function()
while true do
srv.Stepped:Wait()
if ded then break end
hrp.Color3 = Color3.new(255/255,0/255,0/255)
for i = 0,255,10 do
wait()
hrp.Color3 = Color3.new(255/255,i/255,0/255)
end
for i = 255,0,-10 do
wait()
hrp.Color3 = Color3.new(i/255,255/255,0/255)
end
for i = 0,255,10 do
wait()
hrp.Color3 = Color3.new(0/255,255/255,i/255)
end
for i = 255,0,-10 do
wait()
hrp.Color3 = Color3.new(0/255,i/255,255/255)
end
for i = 0,255,10 do
wait()
hrp.Color3 = Color3.new(i/255,0/255,255/255)
end
for i = 255,0,-10 do
wait()
hrp.Color3 = Color3.new(255/255,0/255,i/255)
end
end
end)

te(ct,m.Button1Down:Connect(function()
click=true
end))

te(ct,m.Button1Up:Connect(function()
click=false
end))

te(ct,m.KeyDown:Connect(function(e)
if e ==' ' then
spacedown=true end
if e =='w' then
wdown=true end
if e =='s' then
sdown=true end
if e =='a' then
adown=true end
if e =='d' then
ddown=true
end
end))

te(ct,m.KeyUp:Connect(function(e)
if e ==' ' then
spacedown=false end
if e =='w' then
wdown=false end
if e =='s' then
sdown=false end
if e =='a' then
adown=false end
if e =='d' then
ddown=false
end
end))

-- Bewegung läuft jetzt relativ zur aktuellen Kamera.
-- Kein MoveClone mehr nötig.

--reanim.HumanoidRootPart.RootJoint.Part1=nil

workspace.CurrentCamera.CameraSubject = reanim.Humanoid

reset=Instance.new('BindableEvent')
te(ct,reset.Event:Connect(function()
reanim:Destroy()
HumanDied=true
reanimated=false
for i,v in next, char:GetDescendants() do if v:IsA('BasePart') then v.Anchored=true end end
hc=char.Humanoid:Clone()
char.Humanoid:Destroy()
hc.Parent=char
game.Players:Chat('-re')
for i,v in pairs(ct) do v:Disconnect() end
game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
reset:Remove()
end))

game:GetService("StarterGui"):SetCore("ResetButtonCallback", reset)
------------------------------------------------------------------------------------------------------------------------------------

IT = Instance.new
CF = CFrame.new
VT = Vector3.new
RAD = math.rad
C3 = Color3.new
UD2 = UDim2.new
BRICKC = BrickColor.new
ANGLES = CFrame.Angles
EULER = CFrame.fromEulerAnglesXYZ
COS = math.cos
ACOS = math.acos
SIN = math.sin
ASIN = math.asin
ABS = math.abs
MRANDOM = math.random
FLOOR = math.floor

speed = 1
sine = 1
srv = game:GetService('RunService')

function hatset(yes,part,c1,c0,nm)
reanim[yes].Handle.AccessoryWeld.Part1=reanim[part]
reanim[yes].Handle.AccessoryWeld.C1=c1 or CFrame.new()
reanim[yes].Handle.AccessoryWeld.C0=c0 or CFrame.new()--3bbb322dad5929d0d4f25adcebf30aa5
if nm==true then
noplsmesh(yes)
end
end

--put the hat script converted below

reanim = game.Players.LocalPlayer.Character.CWExtra.NexoPD
RJ = reanim.HumanoidRootPart.RootJoint
RS = reanim.Torso['Right Shoulder']
LS = reanim.Torso['Left Shoulder']
RH = reanim.Torso['Right Hip']
LH = reanim.Torso['Left Hip']
Root = reanim.HumanoidRootPart
NECK = reanim.Torso.Neck
NECK.C0 = CF(0,1,0)*ANGLES(RAD(0),RAD(0),RAD(0))
NECK.C1 = CF(0,-0.5,0)*ANGLES(RAD(0),RAD(0),RAD(0))
RJ.C1 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
RJ.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
RS.C1 = CF(-0.5,0.5,0)*ANGLES(RAD(0),RAD(0),RAD(0))
LS.C1 = CF(0.5,0.5,0)*ANGLES(RAD(0),RAD(0),RAD(0))
RH.C1 = CF(0,1,0)*ANGLES(RAD(0),RAD(0),RAD(0))
LH.C1 = CF(0,1,0)*ANGLES(RAD(0),RAD(0),RAD(0))
RH.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
LH.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
RS.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))
LS.C0 = CF(0,0,0)*ANGLES(RAD(0),RAD(0),RAD(0))

Mode='1'
local heldKey = nil
local mouseHeld = false

local mouse = game.Players.LocalPlayer:GetMouse()

mousechanger = mouse.KeyDown:Connect(function(k)
    if k == 'r' then
        heldKey = 'r'
        Mode = '1'
    elseif k == 'e' then
        heldKey = 'e'
        Mode = '2'
    elseif k == 'urkeybind' then
        heldKey = 'urkeybind'
        Mode = '3'
    end
end)

mouse.KeyUp:Connect(function(k)
    if (k == 'r' and heldKey == 'r') or (k == 'e' and heldKey == 'e') or (k == 'urkeybind' and heldKey == 'urkeybind') then
        heldKey = nil
        Mode = '1'
    end
end)

mouse.Button1Down:Connect(function()
    if Mode == '2' then return end
    mouseHeld = true
    Mode = 'Attack0'
end)

mouse.Button1Up:Connect(function()
    if mouseHeld then
        mouseHeld = false
        Mode = '1'
    end
end)



coroutine.wrap(function()
while true do -- anim changer
if HumanDied then mousechanger:Disconnect() break end
sine = sine + speed
local rlegray = Ray.new(reanim["Right Leg"].Position + Vector3.new(0, 0.5, 0), Vector3.new(0, -2, 0))
local rlegpart, rlegendPoint = workspace:FindPartOnRay(rlegray, char)
local llegray = Ray.new(reanim["Left Leg"].Position + Vector3.new(0, 0.5, 0), Vector3.new(0, -2, 0))
local llegpart, llegendPoint = workspace:FindPartOnRay(llegray, char)
local rightvector = (Root.Velocity * Root.CFrame.rightVector).X + (Root.Velocity * Root.CFrame.rightVector).Z
local lookvector = (Root.Velocity * Root.CFrame.lookVector).X + (Root.Velocity * Root.CFrame.lookVector).Z
if lookvector > reanim.Humanoid.WalkSpeed then
lookvector = reanim.Humanoid.WalkSpeed
end
if lookvector < -reanim.Humanoid.WalkSpeed then
lookvector = -reanim.Humanoid.WalkSpeed
end
if rightvector > reanim.Humanoid.WalkSpeed then
rightvector = reanim.Humanoid.WalkSpeed
end
if rightvector < -reanim.Humanoid.WalkSpeed then
rightvector = -reanim.Humanoid.WalkSpeed
end
local lookvel = lookvector / reanim.Humanoid.WalkSpeed
local rightvel = rightvector / reanim.Humanoid.WalkSpeed
if Mode == '1' then
if Root.Velocity.y > 1 then -- jump
--jump clerp here
elseif Root.Velocity.y < -1 then -- fall
--fall clerp here
elseif Root.Velocity.Magnitude < 2 then -- idle
NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/13),0+0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
RS.C0 = RS.C0:Lerp(CF(1+0*math.cos(sine/13),0.5+0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+10*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
LS.C0 = LS.C0:Lerp(CF(-1+0*math.cos(sine/13),0.5+0.2*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+10.4*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
RH.C0 = RH.C0:Lerp(CF(0.5+0*math.cos(sine/13),-1+-0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(-33+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.cos(sine/13),-1+-0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
reanim['WDW_FoamFinger'].Handle.AccessoryWeld.C0 = reanim['WDW_FoamFinger'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),0.5+0*math.cos(sine/13),-0.3+0*math.cos(sine/13))*ANGLES(RAD(0+3*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
elseif Root.Velocity.Magnitude < 20 then -- walk
NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/13),0+0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
RS.C0 = RS.C0:Lerp(CF(1+0*math.cos(sine/13),0.5+0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+10*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
LS.C0 = LS.C0:Lerp(CF(-1+0*math.cos(sine/13),0.5+0.2*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+-10.4*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
RH.C0 = RH.C0:Lerp(CF(0.5+0*math.cos(sine/13),-1+-0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+-30*math.cos(sine/13)),RAD(-6+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.cos(sine/13),-1+-0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+20*math.cos(sine/13)),RAD(3+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
reanim['WDW_FoamFinger'].Handle.AccessoryWeld.C0 = reanim['WDW_FoamFinger'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/13),0.5+0*math.cos(sine/13),-0.4+0*math.cos(sine/13))*ANGLES(RAD(34+15*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
elseif Root.Velocity.Magnitude > 20 then -- run
--run clerp here
end
elseif Mode == '2' then
if Root.Velocity.y > 1 then -- jump
--jump clerp here
elseif Root.Velocity.y < -1 then -- fall
--fall clerp here
elseif Root.Velocity.Magnitude < 2 then -- idle
NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(21+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/13),-0.5+0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(-37+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
RS.C0 = RS.C0:Lerp(CF(0+3*math.cos(sine/1),1+-2*math.cos(sine/1),0+8*math.cos(sine/1))*ANGLES(RAD(130+10*math.cos(sine/1)),RAD(32+0*math.cos(sine/1)),RAD(-26+0*math.cos(sine/1))),.3)
LS.C0 = LS.C0:Lerp(CF(0+5*math.cos(sine/1),0.5+4*math.cos(sine/1),0+-7*math.cos(sine/1))*ANGLES(RAD(94+0*math.cos(sine/1)),RAD(0+0*math.cos(sine/1)),RAD(0+0*math.cos(sine/1))),.3)
RH.C0 = RH.C0:Lerp(CF(0.5+0*math.cos(sine/13),0+-0.1*math.cos(sine/13),-1+0*math.cos(sine/13))*ANGLES(RAD(1+0*math.cos(sine/13)),RAD(-6+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.cos(sine/13),-1+-0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(3+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
reanim['WDW_FoamFinger'].Handle.AccessoryWeld.C0 = reanim['WDW_FoamFinger'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/2),0.5+0*math.cos(sine/2),-0.6+0*math.cos(sine/2))*ANGLES(RAD(36+15*math.cos(sine/2)),RAD(0+0*math.cos(sine/2)),RAD(0+0*math.cos(sine/2))),.3)
elseif Root.Velocity.Magnitude < 20 then -- walk
NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(21+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/13),-0.5+0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(-37+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
RS.C0 = RS.C0:Lerp(CF(0+3*math.cos(sine/1),1+-2*math.cos(sine/1),0+8*math.cos(sine/1))*ANGLES(RAD(130+10*math.cos(sine/1)),RAD(32+0*math.cos(sine/1)),RAD(-26+0*math.cos(sine/1))),.3)
LS.C0 = LS.C0:Lerp(CF(0+5*math.cos(sine/1),0.5+4*math.cos(sine/1),0+-7*math.cos(sine/1))*ANGLES(RAD(94+0*math.cos(sine/1)),RAD(0+0*math.cos(sine/1)),RAD(0+0*math.cos(sine/1))),.3)
RH.C0 = RH.C0:Lerp(CF(0.5+0*math.cos(sine/13),0+-0.1*math.cos(sine/13),-1+0*math.cos(sine/13))*ANGLES(RAD(1+0*math.cos(sine/13)),RAD(-6+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.cos(sine/13),-1+-0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(3+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
reanim['WDW_FoamFinger'].Handle.AccessoryWeld.C0 = reanim['WDW_FoamFinger'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/2),0.5+0*math.cos(sine/2),-0.6+0*math.cos(sine/2))*ANGLES(RAD(36+15*math.cos(sine/2)),RAD(0+0*math.cos(sine/2)),RAD(0+0*math.cos(sine/2))),.3)
elseif Root.Velocity.Magnitude > 20 then -- run
--run clerp here
end
elseif Mode == '3' then
if Root.Velocity.y > 1 then -- jump
--jump clerp here
elseif Root.Velocity.y < -1 then -- fall
--fall clerp here
elseif Root.Velocity.Magnitude < 2 then -- idle
--idle clerp here
elseif Root.Velocity.Magnitude < 20 then -- walk
--walk clerp here
elseif Root.Velocity.Magnitude > 20 then -- run
--run clerp here
end
elseif Mode == 'Attack0' then
NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(5+0*math.cos(sine/13)),RAD(-37+0*math.cos(sine/13)),RAD(1+0*math.cos(sine/13))),.3)
RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/13),0+0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(-13+0*math.cos(sine/13)),RAD(30+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
RS.C0 = RS.C0:Lerp(CF(1+0*math.cos(sine/13),0.5+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(105+0*math.cos(sine/13)),RAD(18+0*math.cos(sine/13)),RAD(30+0*math.cos(sine/13))),.3)
LS.C0 = LS.C0:Lerp(CF(-1+0*math.cos(sine/13),0+0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(101+0*math.cos(sine/13)),RAD(18+0*math.cos(sine/13)),RAD(-44+0*math.cos(sine/13))),.3)
RH.C0 = RH.C0:Lerp(CF(0.5+0*math.cos(sine/13),-1+-0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(18+0*math.cos(sine/13)),RAD(-51+0*math.cos(sine/13)),RAD(12+0*math.cos(sine/13))),.3)
LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.cos(sine/13),-1+-0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(3+0*math.cos(sine/13)),RAD(-2+0*math.cos(sine/13)),RAD(-4+0*math.cos(sine/13))),.3)
reanim['WDW_FoamFinger'].Handle.AccessoryWeld.C0 = reanim['WDW_FoamFinger'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/2),0.6+0*math.cos(sine/2),-0.5+0*math.cos(sine/2))*ANGLES(RAD(0+0*math.cos(sine/2)),RAD(0+0*math.cos(sine/2)),RAD(0+0*math.cos(sine/2))),.3)
elseif Mode == 'Attack1' then
NECK.C0 = NECK.C0:Lerp(CF(0+0*math.cos(sine/13),1+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
RJ.C0 = RJ.C0:Lerp(CF(0+0*math.cos(sine/13),0+0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(-13+0*math.cos(sine/13)),RAD(-30+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
RS.C0 = RS.C0:Lerp(CF(1+0*math.cos(sine/13),0+0*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(101+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(14+0*math.cos(sine/13))),.3)
LS.C0 = LS.C0:Lerp(CF(-1+0*math.cos(sine/13),0.5+0.1*math.cos(sine/13),-1+0*math.cos(sine/13))*ANGLES(RAD(105+0*math.cos(sine/13)),RAD(-15+0*math.cos(sine/13)),RAD(-15+0*math.cos(sine/13))),.3)
RH.C0 = RH.C0:Lerp(CF(0.5+0*math.cos(sine/13),-1+-0.1*math.cos(sine/13),0+0*math.cos(sine/13))*ANGLES(RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13)),RAD(0+0*math.cos(sine/13))),.3)
LH.C0 = LH.C0:Lerp(CF(-0.5+0*math.cos(sine/13),-1+-0.1*math.cos(sine/13),-0.2+0*math.cos(sine/13))*ANGLES(RAD(21+0*math.cos(sine/13)),RAD(30+0*math.cos(sine/13)),RAD(-11+0*math.cos(sine/13))),.3)
reanim['WDW_FoamFinger'].Handle.AccessoryWeld.C0 = reanim['WDW_FoamFinger'].Handle.AccessoryWeld.C0:Lerp(CF(0+0*math.cos(sine/2),0.6+0*math.cos(sine/2),-0.5+0*math.cos(sine/2))*ANGLES(RAD(21+2*math.cos(sine/2)),RAD(0+0*math.cos(sine/2)),RAD(0+0*math.cos(sine/2))),.3)
end
srv.RenderStepped:Wait()
end
end)()

--Remaked by TrockenerTisch
local muter = false
local ORGID = 335167645
local ORVOL = 1.15
local ORPIT = 1.01
local kan = Instance.new("Sound",char)
kan.Volume = 0
if not NoSound then
	kan.Volume = 1.15
end
kan.TimePosition = 0
kan.PlaybackSpeed = 1.01
kan.Pitch = 1.01
kan.SoundId = "rbxassetid://335167645"
kan.Name = "Saitama"
kan.Looped = true
kan:Play()
--Created using Nexo Animator
