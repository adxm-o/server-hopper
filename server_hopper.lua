local UILibrary = {}
do
local players = game:GetService("Players")
local player = players.LocalPlayer
if not player then
player = players.PlayerAdded:Wait()
end
local tweenService = game:GetService("TweenService")
local teleportService = game:GetService("TeleportService")
local coreGui = game:GetService("CoreGui")
local runService = game:GetService("RunService")
local userInput = game:GetService("UserInputService")
local placeId, currentJobId = game.PlaceId, game.JobId
local settingsFile = "LULU_HopSettings.json"
local uiVisible = true
local keybind = nil
local awaitingKey = false
 
if game.PlaceId ~= 109983668079237 then return end
 
local function getAvatarUrl(userId)
return "https://www.roblox.com/headshot-thumbnail/image?userId="..userId.."&width=48&height=48&format=png"
end
 
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ServerHop"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.ResetOnSpawn = false
screenGui.Parent = coreGui
 
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 300, 0, 280)
frame.Position = UDim2.new(0.5, -150, 0.5, -140)
frame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
frame.BackgroundTransparency = 0.08
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
 
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundColor3 = Color3.fromRGB(0, 110, 0)
topBar.BorderSizePixel = 0
topBar.Parent = frame
 
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, -80, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Server Hopper - adxm.o"
titleLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
titleLabel.Font = Enum.Font.SourceSansSemibold
titleLabel.TextSize = 20
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar
 
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -70, 0, 5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(20, 70, 20)
minimizeButton.BackgroundTransparency = 0.2
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(0, 255, 0)
minimizeButton.TextSize = 28
minimizeButton.Font = Enum.Font.SourceSansBold
minimizeButton.BorderSizePixel = 0
minimizeButton.Parent = topBar
 
local settingsButton = Instance.new("TextButton")
settingsButton.Name = "SettingsButton"
settingsButton.Size = UDim2.new(0, 30, 0, 30)
settingsButton.Position = UDim2.new(1, -35, 0, 5)
settingsButton.BackgroundColor3 = Color3.fromRGB(20, 70, 20)
settingsButton.BackgroundTransparency = 0.2
settingsButton.Text = "⚙"
settingsButton.TextColor3 = Color3.fromRGB(100, 255, 255)
settingsButton.TextSize = 28
settingsButton.Font = Enum.Font.SourceSansBold
settingsButton.BorderSizePixel = 0
settingsButton.Parent = topBar
 
local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, -20, 1, -60)
contentFrame.Position = UDim2.new(0, 10, 0, 50)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = frame
 
local avatarImage = Instance.new("ImageLabel")
avatarImage.Name = "Avatar"
avatarImage.Size = UDim2.new(0, 48, 0, 48)
avatarImage.Position = UDim2.new(0, 0, 0, 0)
avatarImage.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
avatarImage.BorderSizePixel = 0
avatarImage.Image = getAvatarUrl(player.UserId)
avatarImage.Parent = contentFrame
 
local usernameLabel = Instance.new("TextLabel")
usernameLabel.Name = "Username"
usernameLabel.Size = UDim2.new(1, -58, 0, 26)
usernameLabel.Position = UDim2.new(0, 58, 0, 2)
usernameLabel.BackgroundTransparency = 1
usernameLabel.Text = player.Name
usernameLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
usernameLabel.Font = Enum.Font.SourceSansBold
usernameLabel.TextSize = 22
usernameLabel.TextXAlignment = Enum.TextXAlignment.Left
usernameLabel.Parent = contentFrame
 
local pingFpsLabel = Instance.new("TextLabel")
pingFpsLabel.Name = "PingFps"
pingFpsLabel.Size = UDim2.new(1, -58, 0, 24)
pingFpsLabel.Position = UDim2.new(0, 58, 0, 28)
pingFpsLabel.BackgroundTransparency = 1
pingFpsLabel.Text = "📶 0ms  |  🎮 0 FPS"
pingFpsLabel.TextColor3 = Color3.fromRGB(180, 240, 180)
pingFpsLabel.Font = Enum.Font.SourceSans
pingFpsLabel.TextSize = 17
pingFpsLabel.TextXAlignment = Enum.TextXAlignment.Left
pingFpsLabel.Parent = contentFrame
 
local divider = Instance.new("Frame")
divider.Name = "Divider"
divider.Size = UDim2.new(1, 0, 0, 1)
divider.Position = UDim2.new(0, 0, 0, 58)
divider.BackgroundColor3 = Color3.fromRGB(0, 90, 0)
divider.BorderSizePixel = 0
divider.Parent = contentFrame
 
local serverInfoFrame = Instance.new("Frame")
serverInfoFrame.Name = "ServerInfo"
serverInfoFrame.Size = UDim2.new(1, 0, 0, 40)
serverInfoFrame.Position = UDim2.new(0, 0, 0, 68)
serverInfoFrame.BackgroundTransparency = 1
serverInfoFrame.Parent = contentFrame
 
local jobIdLabel = Instance.new("TextLabel")
jobIdLabel.Name = "JobId"
jobIdLabel.Size = UDim2.new(0.6, -10, 0, 30)
jobIdLabel.Position = UDim2.new(0, 0, 0, 5)
jobIdLabel.BackgroundTransparency = 1
jobIdLabel.Text = "🆔 "..string.sub(currentJobId, 1, 12).."..."
jobIdLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
jobIdLabel.Font = Enum.Font.SourceSans
jobIdLabel.TextSize = 16
jobIdLabel.TextXAlignment = Enum.TextXAlignment.Left
jobIdLabel.Parent = serverInfoFrame
 
local copyButton = Instance.new("TextButton")
copyButton.Name = "CopyButton"
copyButton.Size = UDim2.new(0, 60, 0, 28)
copyButton.Position = UDim2.new(0.6, 5, 0, 6)
copyButton.BackgroundColor3 = Color3.fromRGB(0, 70, 0)
copyButton.BorderSizePixel = 0
copyButton.Text = "Copy"
copyButton.TextColor3 = Color3.fromRGB(200, 255, 200)
copyButton.Font = Enum.Font.SourceSansSemibold
copyButton.TextSize = 16
copyButton.Parent = serverInfoFrame
 
local hopButton = Instance.new("TextButton")
hopButton.Name = "HopButton"
hopButton.Size = UDim2.new(1, 0, 0, 45)
hopButton.Position = UDim2.new(0, 0, 1, -75)
hopButton.BackgroundColor3 = Color3.fromRGB(0, 95, 0)
hopButton.BorderSizePixel = 0
hopButton.Text = "⏩ HOP SERVER"
hopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hopButton.Font = Enum.Font.SourceSansBold
hopButton.TextSize = 22
hopButton.Parent = contentFrame
 
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "Status"
statusLabel.Size = UDim2.new(1, 0, 0, 25)
statusLabel.Position = UDim2.new(0, 0, 1, -25)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "● Ready"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextSize = 18
statusLabel.Parent = contentFrame
 
local settingsFrame = Instance.new("Frame")
settingsFrame.Name = "Settings"
settingsFrame.Size = UDim2.new(1, 0, 1, 0)
settingsFrame.BackgroundTransparency = 1
settingsFrame.Visible = false
settingsFrame.Parent = contentFrame
 
local settingsTitle = Instance.new("TextLabel")
settingsTitle.Size = UDim2.new(1, 0, 0, 30)
settingsTitle.Position = UDim2.new(0, 0, 0, 10)
settingsTitle.BackgroundTransparency = 1
settingsTitle.Text = "Keybind Settings"
settingsTitle.TextColor3 = Color3.fromRGB(0, 255, 0)
settingsTitle.Font = Enum.Font.SourceSansBold
settingsTitle.TextSize = 22
settingsTitle.Parent = settingsFrame
 
local keybindLabel = Instance.new("TextLabel")
keybindLabel.Size = UDim2.new(1, -20, 0, 25)
keybindLabel.Position = UDim2.new(0, 10, 0, 45)
keybindLabel.BackgroundTransparency = 1
keybindLabel.Text = "Current keybind: None"
keybindLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
keybindLabel.Font = Enum.Font.SourceSans
keybindLabel.TextSize = 18
keybindLabel.TextXAlignment = Enum.TextXAlignment.Left
keybindLabel.Parent = settingsFrame
 
local toggleLabel = Instance.new("TextLabel")
toggleLabel.Size = UDim2.new(1, -20, 0, 20)
toggleLabel.Position = UDim2.new(0, 10, 0, 70)
toggleLabel.BackgroundTransparency = 1
toggleLabel.Text = "(Toggle UI)"
toggleLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
toggleLabel.Font = Enum.Font.SourceSans
toggleLabel.TextSize = 16
toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
toggleLabel.Parent = settingsFrame
 
local setKeyButton = Instance.new("TextButton")
setKeyButton.Size = UDim2.new(0, 120, 0, 35)
setKeyButton.Position = UDim2.new(0, 10, 0, 100)
setKeyButton.BackgroundColor3 = Color3.fromRGB(0, 70, 0)
setKeyButton.BorderSizePixel = 0
setKeyButton.Text = "Set Keybind"
setKeyButton.TextColor3 = Color3.fromRGB(200, 255, 200)
setKeyButton.Font = Enum.Font.SourceSansSemibold
setKeyButton.TextSize = 18
setKeyButton.Parent = settingsFrame
 
local backButton = Instance.new("TextButton")
backButton.Size = UDim2.new(0, 80, 0, 35)
backButton.Position = UDim2.new(0, 140, 0, 100)
backButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
backButton.BorderSizePixel = 0
backButton.Text = "Back"
backButton.TextColor3 = Color3.fromRGB(255, 255, 255)
backButton.Font = Enum.Font.SourceSansSemibold
backButton.TextSize = 18
backButton.Parent = settingsFrame
 
local setKeyCorner = Instance.new("UICorner")
setKeyCorner.CornerRadius = UDim.new(0, 8)
setKeyCorner.Parent = setKeyButton
 
local backCorner = Instance.new("UICorner")
backCorner.CornerRadius = UDim.new(0, 8)
backCorner.Parent = backButton
 
local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 1.2
uiStroke.Color = Color3.fromRGB(0, 130, 0)
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uiStroke.Parent = frame
 
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = frame
 
local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 10)
topCorner.Parent = topBar
 
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = hopButton
 
local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 6)
copyCorner.Parent = copyButton
 
local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 24)
avatarCorner.Parent = avatarImage
 
local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 8)
minimizeCorner.Parent = minimizeButton
 
local settingsCorner = Instance.new("UICorner")
settingsCorner.CornerRadius = UDim.new(0, 8)
settingsCorner.Parent = settingsButton
 
local fps = 0
runService.RenderStepped:Connect(function()
fps = fps + 1
end)
spawn(function()
while true do
wait(1)
    
local ping = math.floor(player:GetNetworkPing() * 1000)
pingFpsLabel.Text = "📶 "..ping.."ms  |  🎮 "..fps.." FPS"
fps = 0
end
end)
copyButton.MouseButton1Click:Connect(function()
setclipboard(currentJobId)
statusLabel.Text = "● Job ID copied"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
wait(2)
statusLabel.Text = "● Ready"
end)
 
local minimized = false
local inSettings = false
local fullHeight = 280
 
local function expandIfMinimized()
if minimized then
minimized = false
local tween = tweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 300, 0, fullHeight)})
tween:Play()
contentFrame.Visible = true
end
end
 
local function hideAllFrames()
avatarImage.Visible = false
usernameLabel.Visible = false
pingFpsLabel.Visible = false
divider.Visible = false
serverInfoFrame.Visible = false
hopButton.Visible = false
statusLabel.Visible = false
settingsFrame.Visible = false
end
 
local function showMain()
hideAllFrames()
avatarImage.Visible = true
usernameLabel.Visible = true
pingFpsLabel.Visible = true
divider.Visible = true
serverInfoFrame.Visible = true
hopButton.Visible = true
statusLabel.Visible = true
inSettings = false
end
 
minimizeButton.MouseButton1Click:Connect(function()
minimized = not minimized
local targetHeight = minimized and 40 or fullHeight
local tween = tweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 300, 0, targetHeight)})
tween:Play()
contentFrame.Visible = not minimized
if minimized then
inSettings = false
else
showMain()
end
end)
 
settingsButton.MouseButton1Click:Connect(function()
expandIfMinimized()
inSettings = not inSettings
if inSettings then
hideAllFrames()
settingsFrame.Visible = true
else
showMain()
end
end)
 
backButton.MouseButton1Click:Connect(function()
showMain()
end)
 
local function updateKeybindLabel()
keybindLabel.Text = "Current keybind: "..(keybind or "None")
end
local function saveSettings()
local data = {
Position = {
X = frame.Position.X.Scale,
XOffset = frame.Position.X.Offset,
Y = frame.Position.Y.Scale,
YOffset = frame.Position.Y.Offset
},
Keybind = keybind
}
writefile(settingsFile, game:GetService("HttpService"):JSONEncode(data))
end
local function loadSettings()
if isfile(settingsFile) then
local success, data = pcall(function()
return game:GetService("HttpService"):JSONDecode(readfile(settingsFile))
end)
if success then
frame.Position = UDim2.new(data.Position.X, data.Position.XOffset, data.Position.Y, data.Position.YOffset)
keybind = data.Keybind
updateKeybindLabel()
end
end
end
setKeyButton.MouseButton1Click:Connect(function()
awaitingKey = true
setKeyButton.Text = "Press any key..."
setKeyButton.BackgroundColor3 = Color3.fromRGB(100, 100, 0)
end)
local function onInputBegan(input, gameProcessed)
if gameProcessed then return end
if awaitingKey and input.UserInputType == Enum.UserInputType.Keyboard then
awaitingKey = false
keybind = input.KeyCode.Name
setKeyButton.Text = "Set Keybind"
setKeyButton.BackgroundColor3 = Color3.fromRGB(0, 70, 0)
updateKeybindLabel()
saveSettings()
elseif not awaitingKey and keybind and input.KeyCode.Name == keybind then
uiVisible = not uiVisible
screenGui.Enabled = uiVisible
end
end
userInput.InputBegan:Connect(onInputBegan)
 
hopButton.MouseButton1Click:Connect(function()
statusLabel.Text = "● Hopping to random server..."
statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
wait(1.5)
teleportService:Teleport(placeId)
end)
 
local dragging, dragInput, dragStart, startPos
frame.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = true
dragStart = input.Position
startPos = frame.Position
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)
end
end)
frame.InputChanged:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseMovement then
dragInput = input
end
end)
userInput.InputChanged:Connect(function(input)
if input == dragInput and dragging then
local delta = input.Position - dragStart
local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
frame:TweenPosition(newPos, Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.1, true)
end
end)
runService.Stepped:Connect(saveSettings)
loadSettings()

end

--it's lwk ahh i'm just testing
--couldn't figure out how to blacklist servers that you have already joined :/
