-- script: loadstring(game:HttpGet("https://raw.githubusercontent.com/Jenos2006/AllLuaScripts/refs/heads/main/Notify.lua"))()
-- example: notify("Notification by Jenos2006", "Notification script made by Jenos2006", 5)

-- NOTIFY v2 by TrockenerTisch
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")
local guiParent = playerGui

if type(gethui) == "function" then
	guiParent = gethui()
elseif type(syn) == "table" and type(syn.protect_gui) == "function" then
	guiParent = CoreGui
end

local notifications = {}
local maxNotifications = 5
local notificationSize = UDim2.fromOffset(420, 92)
local notificationGap = 10

local existingGui = guiParent:FindFirstChild("NotifyV2")
if existingGui then

	existingGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NotifyV2"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
if guiParent == CoreGui and type(syn) == "table" and type(syn.protect_gui) == "function" then
	syn.protect_gui(screenGui)
end

screenGui.Parent = guiParent

local container = Instance.new("Frame")
container.Name = "Container"
container.AnchorPoint = Vector2.new(1, 1)
container.Position = UDim2.new(1, -24, 1, -24)
container.Size = UDim2.fromOffset(440, 500)
container.BackgroundTransparency = 1
container.Parent = screenGui

local function removeNotification(notification)
	for index, current in ipairs(notifications) do
		if current == notification then
			table.remove(notifications, index)
			break
		end
	end

	if notification.frame then
		local fade = TweenService:Create(notification.frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Position = UDim2.new(1, 30, 1, notification.offset),
			BackgroundTransparency = 1,
		})
		fade:Play()
		fade.Completed:Once(function()
			if notification.frame then
				notification.frame:Destroy()
			end
		end)
	end
end

local function updatePositions(animated)
	for index, notification in ipairs(notifications) do
		local offset = -((index - 1) * (notificationSize.Y.Offset + notificationGap))
		notification.offset = offset
		local target = UDim2.new(1, -10, 1, offset)

		if animated then
			TweenService:Create(notification.frame, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				Position = target,
			}):Play()
		else
			notification.frame.Position = target
		end
	end
end

function notify(title, text, duration)
	title = tostring(title or "Notification")
	text = tostring(text or "")
	duration = tonumber(duration) or 5
	duration = math.max(duration, 0.1)

	local notification = {}
	local frame = Instance.new("Frame")
	frame.Name = "Notification"
	frame.AnchorPoint = Vector2.new(1, 1)
	frame.Position = UDim2.new(1, 30, 1, 0)
	frame.Size = notificationSize
	frame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0
	frame.Parent = container
	notification.frame = frame

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 12)
	corner.Parent = frame

	local accent = Instance.new("Frame")
	accent.Name = "Accent"
	accent.Position = UDim2.fromOffset(0, 14)
	accent.Size = UDim2.fromOffset(3, 64)
	accent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	accent.BorderSizePixel = 0
	accent.Parent = frame

	local accentCorner = Instance.new("UICorner")
	accentCorner.CornerRadius = UDim.new(1, 0)
	accentCorner.Parent = accent

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "Title"
	titleLabel.Position = UDim2.fromOffset(20, 11)
	titleLabel.Size = UDim2.new(1, -34, 0, 26)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.Text = title
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.TextSize = 17
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.TextTruncate = Enum.TextTruncate.AtEnd
	titleLabel.Parent = frame

	local textLabel = Instance.new("TextLabel")
	textLabel.Name = "Text"
	textLabel.Position = UDim2.fromOffset(20, 41)
	textLabel.Size = UDim2.new(1, -34, 0, 28)
	textLabel.BackgroundTransparency = 1
	textLabel.Font = Enum.Font.Gotham
	textLabel.Text = text
	textLabel.TextColor3 = Color3.fromRGB(205, 205, 205)
	textLabel.TextSize = 14
	textLabel.TextWrapped = true
	textLabel.TextXAlignment = Enum.TextXAlignment.Left
	textLabel.TextYAlignment = Enum.TextYAlignment.Top
	textLabel.Parent = frame

	local progressBackground = Instance.new("Frame")
	progressBackground.Name = "ProgressBackground"
	progressBackground.Position = UDim2.new(0, 20, 1, -9)
	progressBackground.Size = UDim2.new(1, -40, 0, 3)
	progressBackground.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	progressBackground.BorderSizePixel = 0
	progressBackground.Parent = frame

	local progressCorner = Instance.new("UICorner")
	progressCorner.CornerRadius = UDim.new(1, 0)
	progressCorner.Parent = progressBackground

	local progress = Instance.new("Frame")
	progress.Name = "Progress"
	progress.Size = UDim2.fromScale(1, 1)
	progress.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	progress.BorderSizePixel = 0
	progress.Parent = progressBackground

	local progressCorner = Instance.new("UICorner")
	progressCorner.CornerRadius = UDim.new(1, 0)
	progressCorner.Parent = progress

	table.insert(notifications, 1, notification)
	if #notifications > maxNotifications then
		removeNotification(notifications[#notifications])
	end

	updatePositions(true)

	TweenService:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Position = UDim2.new(1, -10, 1, 0),
		BackgroundTransparency = 0,
	}):Play()

	local progressTween = TweenService:Create(progress, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
		Size = UDim2.fromScale(0, 1),
	})
	progressTween:Play()

	task.delay(duration, function()
		for _, current in ipairs(notifications) do
			if current == notification then
				removeNotification(notification)
				updatePositions(true)
				break
			end
		end
	end)
end

_G.notify = notify

if type(getgenv) == "function" then
	getgenv().notify = notify
end
