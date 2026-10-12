getgenv().VzHub = getgenv().VzHub or {}
local Hub = getgenv().VzHub

Hub.CoreGui = game:GetService("CoreGui")
Hub.Players = game:GetService("Players")
Hub.TweenService = game:GetService("TweenService")
Hub.UserInputService = game:GetService("UserInputService")
Hub.SoundService = game:GetService("SoundService")
Hub.LocalPlayer = Hub.Players.LocalPlayer

if Hub.CoreGui:FindFirstChild("VzNamHubGui") then Hub.CoreGui.VzNamHubGui:Destroy() end
if Hub.CoreGui:FindFirstChild("VzNamBlackScreen") then Hub.CoreGui.VzNamBlackScreen:Destroy() end

Hub.LastSelectedScriptBtn, Hub.LastSelectedScriptStroke = nil, nil
Hub.RegisteredScripts = {}

function Hub.ApplyBlackTextWhiteOutline(textObj)
    textObj.TextColor3 = Color3.fromRGB(0, 0, 0)
    textObj.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    textObj.TextStrokeTransparency = 0
end

Hub.VzNamGui = Instance.new("ScreenGui", Hub.CoreGui)
Hub.VzNamGui.Name = "VzNamHubGui"
Hub.VzNamGui.DisplayOrder = 10
Hub.VzNamGui.ResetOnSpawn = false

Hub.BlackScreenGui = Instance.new("ScreenGui", Hub.CoreGui)
Hub.BlackScreenGui.Name = "VzNamBlackScreen"
Hub.BlackScreenGui.DisplayOrder = 5
Hub.BlackScreenGui.IgnoreGuiInset = true
Hub.BlackScreenGui.ResetOnSpawn = false
Hub.BlackScreenGui.Enabled = false

Hub.BlackFrame = Instance.new("Frame", Hub.BlackScreenGui)
Hub.BlackFrame.Size = UDim2.new(1, 0, 1, 0)
Hub.BlackFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

Hub.AvatarUrl = "rbxassetid://6031094678"
pcall(function() Hub.AvatarUrl = Hub.Players:GetUserThumbnailAsync(Hub.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420) end)

Hub.ToggleBtn = Instance.new("ImageButton", Hub.VzNamGui)
Hub.ToggleBtn.Name, Hub.ToggleBtn.BackgroundColor3, Hub.ToggleBtn.Position, Hub.ToggleBtn.Size, Hub.ToggleBtn.Active, Hub.ToggleBtn.Draggable, Hub.ToggleBtn.Image, Hub.ToggleBtn.ZIndex = "ToggleBtn", Color3.fromRGB(30, 30, 30), UDim2.new(0.05, 0, 0.2, 0), UDim2.new(0, 55, 0, 55), true, true, Hub.AvatarUrl, 10
Instance.new("UICorner", Hub.ToggleBtn).CornerRadius = UDim.new(1, 0)
Hub.ToggleStroke = Instance.new("UIStroke", Hub.ToggleBtn)
Hub.ToggleStroke.Color, Hub.ToggleStroke.Thickness = Color3.fromRGB(255, 255, 255), 2

Hub.MainFrame = Instance.new("Frame", Hub.VzNamGui)
Hub.MainFrame.Name, Hub.MainFrame.BackgroundColor3, Hub.MainFrame.Position, Hub.MainFrame.Size, Hub.MainFrame.ClipsDescendants, Hub.MainFrame.ZIndex = "MainFrame", Color3.fromRGB(255, 255, 255), UDim2.new(0.5, -170, 0.5, -150), UDim2.new(0, 370, 0, 310), true, 5
Instance.new("UICorner", Hub.MainFrame).CornerRadius = UDim.new(0, 12)

Hub.RainbowGradient = Instance.new("UIGradient", Hub.MainFrame)
Hub.RainbowGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 180, 180)), ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 220, 180)), ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 180)), ColorSequenceKeypoint.new(0.6, Color3.fromRGB(180, 255, 200)), ColorSequenceKeypoint.new(0.8, Color3.fromRGB(180, 220, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 180, 255))})
Hub.RainbowTween = Hub.TweenService:Create(Hub.RainbowGradient, TweenInfo.new(8, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false), {Rotation = 360})
Hub.RainbowTween:Play()

Hub.FrameStroke = Instance.new("UIStroke", Hub.MainFrame)
Hub.FrameStroke.Color, Hub.FrameStroke.Thickness = Color3.fromRGB(255, 255, 255), 2

Hub.TitleBar = Instance.new("Frame", Hub.MainFrame)
Hub.TitleBar.Name, Hub.TitleBar.Size, Hub.TitleBar.BackgroundColor3, Hub.TitleBar.BackgroundTransparency, Hub.TitleBar.ZIndex = "TitleBar", UDim2.new(1, 0, 0, 40), Color3.fromRGB(0, 0, 0), 0.6, 6
Instance.new("UICorner", Hub.TitleBar).CornerRadius = UDim.new(0, 12)

local dragging, dragInput, dragStart, startPos
Hub.TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging, dragStart, startPos = true, input.Position, Hub.MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
Hub.TitleBar.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
Hub.UserInputService.InputChanged:Connect(function(input) if input == dragInput and dragging then local delta = input.Position - dragStart Hub.MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)

Hub.HeaderAvatar = Instance.new("ImageLabel", Hub.TitleBar)
Hub.HeaderAvatar.Position, Hub.HeaderAvatar.Size, Hub.HeaderAvatar.BackgroundTransparency, Hub.HeaderAvatar.Image, Hub.HeaderAvatar.ZIndex = UDim2.new(0, 10, 0.5, -14), UDim2.new(0, 28, 0, 28), 1, Hub.AvatarUrl, 7
Instance.new("UICorner", Hub.HeaderAvatar).CornerRadius = UDim.new(1, 0)

Hub.TitleText = Instance.new("TextLabel", Hub.TitleBar)
Hub.TitleText.Position, Hub.TitleText.Size, Hub.TitleText.BackgroundTransparency, Hub.TitleText.Text, Hub.TitleText.TextSize, Hub.TitleText.Font, Hub.TitleText.TextXAlignment, Hub.TitleText.ZIndex = UDim2.new(0, 45, 0, 0), UDim2.new(1, -85, 1, 0), 1, "🌸TỔNG HỢP | 👑VzNam Hub v3👑 | 🌸", 13, Enum.Font.SourceSansBold, Enum.TextXAlignment.Left, 7
Hub.ApplyBlackTextWhiteOutline(Hub.TitleText)

Hub.CloseBtn = Instance.new("TextButton", Hub.TitleBar)
Hub.CloseBtn.Position, Hub.CloseBtn.Size, Hub.CloseBtn.BackgroundColor3, Hub.CloseBtn.BackgroundTransparency, Hub.CloseBtn.Text, Hub.CloseBtn.Font, Hub.CloseBtn.TextSize, Hub.CloseBtn.ZIndex = UDim2.new(1, -34, 0.5, -14), UDim2.new(0, 28, 0, 28), Color3.fromRGB(200, 50, 50), 0.2, "✖", Enum.Font.SourceSansBold, 14, 8
Instance.new("UICorner", Hub.CloseBtn).CornerRadius = UDim.new(0, 6)
Hub.ApplyBlackTextWhiteOutline(Hub.CloseBtn)
Hub.CloseBtn.MouseButton1Click:Connect(function()
    if Hub.SoundService:FindFirstChild("VzNamHubSound") then Hub.SoundService.VzNamHubSound:Destroy() end
    Hub.VzNamGui:Destroy()
    Hub.BlackScreenGui:Destroy()
end)

Hub.ResizeBtn = Instance.new("TextButton", Hub.MainFrame)
Hub.ResizeBtn.Position, Hub.ResizeBtn.Size, Hub.ResizeBtn.BackgroundColor3, Hub.ResizeBtn.BackgroundTransparency, Hub.ResizeBtn.Text, Hub.ResizeBtn.Font, Hub.ResizeBtn.TextSize, Hub.ResizeBtn.ZIndex = UDim2.new(1, -20, 1, -20), UDim2.new(0, 20, 0, 20), Color3.fromRGB(150, 150, 150), 0.5, "◢", Enum.Font.SourceSansBold, 11, 10
Instance.new("UICorner", Hub.ResizeBtn).CornerRadius = UDim.new(0, 4)
Hub.ApplyBlackTextWhiteOutline(Hub.ResizeBtn)

local resizing, resizeStart, startSize
Hub.ResizeBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing, resizeStart, startSize = true, input.Position, Hub.MainFrame.AbsoluteSize
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then resizing = false end end)
    end
end)
Hub.UserInputService.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and resizing then
        local delta = input.Position - resizeStart
        local newWidth = math.clamp(startSize.X + delta.X, 320, 600)
        local newHeight = math.clamp(startSize.Y + delta.Y, 260, 500)
        Hub.MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
    end
end)
local Hub = getgenv().VzHub

Hub.TabBarLeftScroll = Instance.new("ScrollingFrame", Hub.MainFrame)
Hub.TabBarLeftScroll.Position, Hub.TabBarLeftScroll.Size, Hub.TabBarLeftScroll.BackgroundTransparency, Hub.TabBarLeftScroll.CanvasSize, Hub.TabBarLeftScroll.ScrollBarThickness, Hub.TabBarLeftScroll.ZIndex = UDim2.new(0, 8, 0, 48), UDim2.new(0, 100, 1, -56), 1, UDim2.new(0, 0, 0, 0), 3, 25
Hub.TabBarLeftScroll.AutomaticCanvasSize = Enum.AutomaticCanvasSize.Y
local LeftLayout = Instance.new("UIListLayout", Hub.TabBarLeftScroll) LeftLayout.Padding = UDim.new(0, 8)

function Hub.CreateCategoryContainer(visible)
    local frame = Instance.new("Frame", Hub.MainFrame) frame.Position, frame.Size, frame.BackgroundTransparency, frame.Visible, frame.ZIndex = UDim2.new(0, 114, 0, 48), UDim2.new(1, -122, 1, -56), 1, visible, 6
    local subBar = Instance.new("Frame", frame) subBar.Size, subBar.BackgroundTransparency, subBar.ZIndex = UDim2.new(1, 0, 0, 28), 1, 7
    local subLayout = Instance.new("UIListLayout", subBar) subLayout.FillDirection, subLayout.Padding = Enum.FillDirection.Horizontal, UDim.new(0, 6)
    
    local noKeyBtn = Instance.new("TextButton", subBar) noKeyBtn.Size, noKeyBtn.BackgroundColor3, noKeyBtn.BackgroundTransparency, noKeyBtn.Text, noKeyBtn.Font, noKeyBtn.TextSize, noKeyBtn.ZIndex = UDim2.new(0.48, 0, 1, 0), Color3.fromRGB(0, 0, 0), 0.3, "no key", Enum.Font.SourceSansBold, 12, 8
    Instance.new("UICorner", noKeyBtn).CornerRadius = UDim.new(0, 6)
    local nkStroke = Instance.new("UIStroke", noKeyBtn) nkStroke.Color, nkStroke.Thickness = Color3.fromRGB(255, 50, 50), 2
    Hub.ApplyBlackTextWhiteOutline(noKeyBtn)
    
    local hasKeyBtn = Instance.new("TextButton", subBar) hasKeyBtn.Size, hasKeyBtn.BackgroundColor3, hasKeyBtn.BackgroundTransparency, hasKeyBtn.Text, hasKeyBtn.Font, hasKeyBtn.TextSize, hasKeyBtn.ZIndex = UDim2.new(0.48, 0, 1, 0), Color3.fromRGB(0, 0, 0), 0.7, "có key", Enum.Font.SourceSansBold, 12, 8
    Instance.new("UICorner", hasKeyBtn).CornerRadius = UDim.new(0, 6)
    local hkStroke = Instance.new("UIStroke", hasKeyBtn) hkStroke.Color, hkStroke.Thickness = Color3.fromRGB(255, 255, 255), 1
    Hub.ApplyBlackTextWhiteOutline(hasKeyBtn)
    
    local scrollNoKey = Instance.new("ScrollingFrame", frame) scrollNoKey.Position, scrollNoKey.Size, scrollNoKey.BackgroundTransparency, scrollNoKey.CanvasSize, scrollNoKey.ScrollBarThickness, scrollNoKey.Visible, scrollNoKey.ZIndex = UDim2.new(0, 0, 0, 34), UDim2.new(1, 0, 1, -34), 1, UDim2.new(0, 0, 0, 2000), 4, true, 7
    Instance.new("UIListLayout", scrollNoKey).Padding = UDim.new(0, 8)
    
    local scrollHasKey = Instance.new("ScrollingFrame", frame) scrollHasKey.Position, scrollHasKey.Size, scrollHasKey.BackgroundTransparency, scrollHasKey.CanvasSize, scrollHasKey.ScrollBarThickness, scrollHasKey.Visible, scrollHasKey.ZIndex = UDim2.new(0, 0, 0, 34), UDim2.new(1, 0, 1, -34), 1, UDim2.new(0, 0, 0, 2000), 4, false, 7
    Instance.new("UIListLayout", scrollHasKey).Padding = UDim.new(0, 8)
    
    noKeyBtn.MouseButton1Click:Connect(function()
        scrollNoKey.Visible, scrollHasKey.Visible = true, false
        noKeyBtn.BackgroundTransparency, nkStroke.Color, nkStroke.Thickness = 0.3, Color3.fromRGB(255, 50, 50), 2
        hasKeyBtn.BackgroundTransparency, hkStroke.Color, hkStroke.Thickness = 0.7, Color3.fromRGB(255, 255, 255), 1
    end)
    hasKeyBtn.MouseButton1Click:Connect(function()
        scrollNoKey.Visible, scrollHasKey.Visible = false, true
        hasKeyBtn.BackgroundTransparency, hkStroke.Color, hkStroke.Thickness = 0.3, Color3.fromRGB(255, 50, 50), 2
        noKeyBtn.BackgroundTransparency, nkStroke.Color, nkStroke.Thickness = 0.7, Color3.fromRGB(255, 255, 255), 1
    end)
    return frame, scrollNoKey, scrollHasKey
end

function Hub.CreateCustomContainer(visible)
    local frame = Instance.new("Frame", Hub.MainFrame) 
    frame.Position, frame.Size, frame.BackgroundTransparency, frame.Visible, frame.ZIndex, frame.ClipsDescendants = UDim2.new(0, 114, 0, 48), UDim2.new(1, -122, 1, -56), 1, visible, 6, true
    local scroll = Instance.new("ScrollingFrame", frame) 
    scroll.Position, scroll.Size, scroll.BackgroundTransparency, scroll.ScrollBarThickness, scroll.ZIndex, scroll.ClipsDescendants = UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 1, 0), 1, 4, 7, false
    scroll.AutomaticCanvasSize = Enum.AutomaticCanvasSize.Y
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    local scrollLayout = Instance.new("UIListLayout", scroll)
    scrollLayout.Padding = UDim.new(0, 8)
    scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
    return frame, scroll
end

Hub.TabContainers, Hub.MainTabButtons = {}, {}
local tabNames = {"🌸STEAL AN EGG🌸", "🌸BLOX FRUIT🌸", "🌸BREAK AN STEAL AN EGG🌸", "Tab 4", "Tab 5", "👾KHÁC👾"}

for i = 1, 6 do
    local isFirst = (i == 1)
    if i == 6 then
        local frame, scroll = Hub.CreateCustomContainer(false)
        Hub.TabContainers[i] = {Container = frame, Scroll = scroll}
    else
        local container, noKeyScroll, hasKeyScroll = Hub.CreateCategoryContainer(isFirst)
        Hub.TabContainers[i] = {Container = container, NoKeyScroll = noKeyScroll, HasKeyScroll = hasKeyScroll}
    end
    
    local btn = Instance.new("TextButton", Hub.TabBarLeftScroll)
    btn.Size, btn.BackgroundColor3, btn.BackgroundTransparency, btn.Text, btn.Font, btn.TextSize, btn.TextWrapped, btn.ZIndex = UDim2.new(1, 0, 0, 38), Color3.fromRGB(0, 0, 0), isFirst and 0.3 or 0.7, tabNames[i], Enum.Font.SourceSansBold, 12, true, 26
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", btn) stroke.Color, stroke.Thickness = isFirst and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 255, 255), isFirst and 2 or 1
    Hub.ApplyBlackTextWhiteOutline(btn)
    Hub.MainTabButtons[i] = {Button = btn, Stroke = stroke}
    
    btn.MouseButton1Click:Connect(function()
        for j = 1, 6 do
            local active = (i == j)
            Hub.TabContainers[j].Container.Visible = active
            Hub.MainTabButtons[j].Button.BackgroundTransparency = active and 0.3 or 0.7
            Hub.MainTabButtons[j].Stroke.Color, Hub.MainTabButtons[j].Stroke.Thickness = active and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 255, 255), active and 2 or 1
        end
    end)
end

function Hub.AddScriptButton(scrollParent, Name, Callback)
    local Btn = Instance.new("TextButton", scrollParent)
    Btn.Size, Btn.BackgroundColor3, Btn.BackgroundTransparency, Btn.Text, Btn.Font, Btn.TextSize, Btn.ZIndex = UDim2.new(1, 0, 0, 38), Color3.fromRGB(255, 255, 255), 0.25, Name, Enum.Font.SourceSansSemibold, 14, 8
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    local BtnStroke = Instance.new("UIStroke", Btn) BtnStroke.Color, BtnStroke.Thickness = Color3.fromRGB(255, 255, 255), 1
    Hub.ApplyBlackTextWhiteOutline(Btn)
    
    Btn.MouseButton1Click:Connect(function()
        if Hub.LastSelectedScriptStroke then Hub.LastSelectedScriptStroke.Color, Hub.LastSelectedScriptStroke.Thickness = Color3.fromRGB(255, 255, 255), 1 end
        BtnStroke.Color, BtnStroke.Thickness = Color3.fromRGB(255, 50, 50), 2.5
        Hub.LastSelectedScriptBtn, Hub.LastSelectedScriptStroke = Btn, BtnStroke
        Callback()
    end)

    table.insert(Hub.RegisteredScripts, {Name = Name, Callback = Callback})
end
local Hub = getgenv().VzHub
local tc = Hub.TabContainers

-- TAB 1: STEAL AN EGG
Hub.AddScriptButton(tc[1].NoKeyScroll, "1. Hop sv1 người(nokey)", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)
Hub.AddScriptButton(tc[1].NoKeyScroll, "2. FyyCommunity(lúc có key lúc no key)", function() loadstring(game:HttpGet("https://FyyCommunity.my.id"))() end)
Hub.AddScriptButton(tc[1].NoKeyScroll, "3. Chilli Hub V4(nokey)", function() loadstring(game:HttpGet("https://id.tomroblox.com/raw/kairoblox/chilli-hub-viet-hoa-v4"))() end)
Hub.AddScriptButton(tc[1].NoKeyScroll, "4. Night hub(nokey)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/StealAnEggs.luau"))() end)

Hub.AddScriptButton(tc[1].HasKeyScroll, "1. Lemon Hub v4(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/owenzeke99-tech/lennonhubv4/refs/heads/main/lennonhubkeyless.txt", true))() end)
Hub.AddScriptButton(tc[1].HasKeyScroll, "2. Hoshi hub(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/napun87/stealanegg/refs/heads/main/hosi.lua"))() end)
Hub.AddScriptButton(tc[1].HasKeyScroll, "3. Bigfroot(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua"))() end)
Hub.AddScriptButton(tc[1].HasKeyScroll, "4. Chữ A(ajjans)|(có key)", function() loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/359e97f8618e9008afe5f496184ebb7c.lua"))() end)
Hub.AddScriptButton(tc[1].HasKeyScroll, "5. Speed hub(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))() end)
Hub.AddScriptButton(tc[1].HasKeyScroll, "6. Neohub(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/neohubdev/script/main/script"))() end)
Hub.AddScriptButton(tc[1].HasKeyScroll, "7. Real kid(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/realkidhub/realkid/refs/heads/main/main.lua"))() end)
Hub.AddScriptButton(tc[1].HasKeyScroll, "8. Chilli v2(có key)", function() loadstring(game:HttpGet("https://gist.githubusercontent.com/ronnei/1fa67c56dd9af203b192d15e752928e5/raw/4e2d5105640e09a008b4ae6df23f9708cadfef06/chilliv2-stealanegg"))() end)

-- TAB 2: BLOX FRUIT
Hub.AddScriptButton(tc[2].NoKeyScroll, "1. RedzHub v2 (no key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/UCT-hub/main/refs/heads/main/redz-v2"))() end)
Hub.AddScriptButton(tc[2].NoKeyScroll, "2. Quantumx Hub(nokey)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))() end)

Hub.AddScriptButton(tc[2].HasKeyScroll, "1. Speed Hub(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))() end)
Hub.AddScriptButton(tc[2].HasKeyScroll, "2. Omg Hub(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))() end)
Hub.AddScriptButton(tc[2].HasKeyScroll, "3. TeddyHub(có key)", function() repeat task.wait() until game:IsLoaded() and game:GetService("Players") and game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui") loadstring(game:HttpGet("https://raw.githubusercontent.com/teddyhubdev/diepvy/refs/heads/main/TeddyHub.lua"))() end)
Hub.AddScriptButton(tc[2].HasKeyScroll, "4. Gravity Hub(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua"))() end)
Hub.AddScriptButton(tc[2].HasKeyScroll, "5. Realkid hub(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/realkidhub/realkid/refs/heads/main/main.lua"))() end)
Hub.AddScriptButton(tc[2].HasKeyScroll, "6. BananaHub(có key)", function() repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer getgenv().Team = "Marines" loadstring(game:HttpGet("https://raw.githubusercontent.com/obiyeueim/vthangsitink/main/BananaHub.lua"))() end)

-- TAB 3
Hub.AddScriptButton(tc[3].NoKeyScroll, "1. break and steal an egg(không sài dc nx)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua"))() end)
Hub.AddScriptButton(tc[3].HasKeyScroll, "1. Tên Script Có Key (Tab 3)", function() end)

-- TAB 4
Hub.AddScriptButton(tc[4].NoKeyScroll, "1. Tên Script No Key (Tab 4)", function() end)
Hub.AddScriptButton(tc[4].HasKeyScroll, "1. Tên Script Có Key (Tab 4)", function() end)

-- TAB 5
Hub.AddScriptButton(tc[5].NoKeyScroll, "1. Tên Script No Key (Tab 5)", function() end)
Hub.AddScriptButton(tc[5].HasKeyScroll, "1. Tên Script Có Key (Tab 5)", function() end)
local Hub = getgenv().VzHub
local t6 = Hub.TabContainers[6].Scroll
t6.ClipsDescendants = false
local selScript, isAuto = nil, false

local dropBtn = Instance.new("TextButton", t6)
dropBtn.LayoutOrder = 1
dropBtn.Size, dropBtn.BackgroundColor3, dropBtn.Text, dropBtn.Font, dropBtn.TextSize, dropBtn.TextXAlignment, dropBtn.ZIndex = UDim2.new(1,0,0,34), Color3.fromRGB(240,240,240), " 📜 Chọn Script Auto Load...", Enum.Font.SourceSansSemibold, 13, Enum.TextXAlignment.Left, 10
Instance.new("UICorner", dropBtn).CornerRadius = UDim.new(0, 6)
local dropStroke = Instance.new("UIStroke", dropBtn) dropStroke.Color = Color3.fromRGB(200,200,200)
Hub.ApplyBlackTextWhiteOutline(dropBtn)

local dropFrame = Instance.new("ScrollingFrame", t6)
dropFrame.LayoutOrder = 2
dropFrame.Size, dropFrame.BackgroundColor3, dropFrame.CanvasSize, dropFrame.ScrollBarThickness, dropFrame.Visible, dropFrame.ZIndex = UDim2.new(1,0,0,100), Color3.fromRGB(250,250,250), UDim2.new(0,0,0,0), 3, false, 30
Instance.new("UICorner", dropFrame).CornerRadius = UDim.new(0, 6)
Instance.new("UIListLayout", dropFrame).Padding = UDim.new(0, 4)

local clearBtn = Instance.new("TextButton", t6)
clearBtn.LayoutOrder = 3
clearBtn.Size, clearBtn.BackgroundColor3, clearBtn.Text, clearBtn.Font, clearBtn.TextSize, clearBtn.ZIndex = UDim2.new(1,0,0,28), Color3.fromRGB(150,150,150), "🚫 Hủy chọn Script ❌", Enum.Font.SourceSansBold, 12, 8
Instance.new("UICorner", clearBtn).CornerRadius = UDim.new(0, 6)
Hub.ApplyBlackTextWhiteOutline(clearBtn)

local toggleAuto = Instance.new("TextButton", t6)
toggleAuto.LayoutOrder = 4
toggleAuto.Size, toggleAuto.BackgroundColor3, toggleAuto.Text, toggleAuto.Font, toggleAuto.TextSize, toggleAuto.ZIndex = UDim2.new(1,0,0,32), Color3.fromRGB(200,50,50), "Auto Load Script Chạy: TẮT ❌", Enum.Font.SourceSansBold, 12, 8
Instance.new("UICorner", toggleAuto).CornerRadius = UDim.new(0, 6)
Hub.ApplyBlackTextWhiteOutline(toggleAuto)

local colorList = {
    {Name = "🌈 Màu Cầu Vồng (Gốc)", Color = nil},
    {Name = "🌸 Hồng Kẹo Đắng", Color = Color3.fromRGB(255, 105, 180)},
    {Name = "🔴 Đỏ Đậm", Color = Color3.fromRGB(220, 20, 60)},
    {Name = "🔵 Xanh Dương Neon", Color = Color3.fromRGB(0, 191, 255)},
    {Name = "🟢 Xanh Lá Cây", Color = Color3.fromRGB(50, 205, 50)},
    {Name = "🟡 Vàng Nổi Bật", Color = Color3.fromRGB(255, 215, 0)},
    {Name = "🟣 Tím Mộng Mơ", Color = Color3.fromRGB(138, 43, 226)},
    {Name = "⬛ Xám Tối Elegant", Color = Color3.fromRGB(50, 50, 50)}
}
local selectedColorObj = colorList[1]
local isColorApplied = false

local colorDropBtn = Instance.new("TextButton", t6)
colorDropBtn.LayoutOrder = 5
colorDropBtn.Size, colorDropBtn.BackgroundColor3, colorDropBtn.Text, colorDropBtn.Font, colorDropBtn.TextSize, colorDropBtn.TextXAlignment, colorDropBtn.ZIndex = UDim2.new(1,0,0,34), Color3.fromRGB(240,240,240), " 🎨 Chọn Màu Menu...", Enum.Font.SourceSansSemibold, 13, Enum.TextXAlignment.Left, 10
Instance.new("UICorner", colorDropBtn).CornerRadius = UDim.new(0, 6)
Hub.ApplyBlackTextWhiteOutline(colorDropBtn)

local colorDropFrame = Instance.new("ScrollingFrame", t6)
colorDropFrame.LayoutOrder = 6
colorDropFrame.Size, colorDropFrame.BackgroundColor3, colorDropFrame.CanvasSize, colorDropFrame.ScrollBarThickness, colorDropFrame.Visible, colorDropFrame.ZIndex = UDim2.new(1,0,0,110), Color3.fromRGB(250,250,250), UDim2.new(0,0,0,0), 3, false, 30
Instance.new("UICorner", colorDropFrame).CornerRadius = UDim.new(0, 6)
Instance.new("UIListLayout", colorDropFrame).Padding = UDim.new(0, 4)

local toggleColorBtn = Instance.new("TextButton", t6)
toggleColorBtn.LayoutOrder = 7
toggleColorBtn.Size, toggleColorBtn.BackgroundColor3, toggleColorBtn.Text, toggleColorBtn.Font, toggleColorBtn.TextSize, toggleColorBtn.ZIndex = UDim2.new(1,0,0,32), Color3.fromRGB(200,50,50), "Màu Menu Tùy Chỉnh: TẮT ❌", Enum.Font.SourceSansBold, 12, 8
Instance.new("UICorner", toggleColorBtn).CornerRadius = UDim.new(0, 6)
Hub.ApplyBlackTextWhiteOutline(toggleColorBtn)

local isFpsModeOn = false
local toggleFpsBtn = Instance.new("TextButton", t6)
toggleFpsBtn.LayoutOrder = 8
toggleFpsBtn.Size, toggleFpsBtn.BackgroundColor3, toggleFpsBtn.Text, toggleFpsBtn.Font, toggleFpsBtn.TextSize, toggleFpsBtn.ZIndex = UDim2.new(1,0,0,32), Color3.fromRGB(200,50,50), "Màn Hình Đen Giảm FPS: TẮT ❌", Enum.Font.SourceSansBold, 12, 8
Instance.new("UICorner", toggleFpsBtn).CornerRadius = UDim.new(0, 6)
Hub.ApplyBlackTextWhiteOutline(toggleFpsBtn)

local HubSound = Hub.SoundService:FindFirstChild("VzNamHubSound") or Instance.new("Sound", Hub.SoundService)
HubSound.Name = "VzNamHubSound"
HubSound.Looped = true
HubSound.Volume = 0.5

local presetMusics = {
    {Name = "🎵 Chill Lofi Music", Id = "1837879082"},
    {Name = "🎶 Phonk Beat", Id = "1843404008"},
    {Name = "🎵 Anime Relaxing", Id = "9043887091"},
    {Name = "🎶 EDM Hype", Id = "1837871000"}
}
local currentSoundId = presetMusics[1].Id

local customIdBox = Instance.new("TextBox", t6)
customIdBox.LayoutOrder = 9
customIdBox.Size, customIdBox.BackgroundColor3, customIdBox.PlaceholderText, customIdBox.Text, customIdBox.Font, customIdBox.TextSize, customIdBox.ZIndex = UDim2.new(1,0,0,32), Color3.fromRGB(240,240,240), "Nhập Sound ID tùy chỉnh...", "", Enum.Font.SourceSansSemibold, 12, 10
Instance.new("UICorner", customIdBox).CornerRadius = UDim.new(0, 6)
Hub.ApplyBlackTextWhiteOutline(customIdBox)

local musicDropBtn = Instance.new("TextButton", t6)
musicDropBtn.LayoutOrder = 10
musicDropBtn.Size, musicDropBtn.BackgroundColor3, musicDropBtn.Text, musicDropBtn.Font, musicDropBtn.TextSize, musicDropBtn.TextXAlignment, musicDropBtn.ZIndex = UDim2.new(1,0,0,34), Color3.fromRGB(240,240,240), " 🎵 Chọn Nhạc Nền...", Enum.Font.SourceSansSemibold, 13, Enum.TextXAlignment.Left, 10
Instance.new("UICorner", musicDropBtn).CornerRadius = UDim.new(0, 6)
Hub.ApplyBlackTextWhiteOutline(musicDropBtn)

local musicDropFrame = Instance.new("ScrollingFrame", t6)
musicDropFrame.LayoutOrder = 11
musicDropFrame.Size, musicDropFrame.BackgroundColor3, musicDropFrame.CanvasSize, musicDropFrame.ScrollBarThickness, musicDropFrame.Visible, musicDropFrame.ZIndex = UDim2.new(1,0,0,100), Color3.fromRGB(250,250,250), UDim2.new(0,0,0,0), 3, false, 30
Instance.new("UICorner", musicDropFrame).CornerRadius = UDim.new(0, 6)
Instance.new("UIListLayout", musicDropFrame).Padding = UDim.new(0, 4)

local musicControlRow = Instance.new("Frame", t6)
musicControlRow.LayoutOrder = 12
musicControlRow.Size = UDim2.new(1, 0, 0, 36)
musicControlRow.BackgroundTransparency = 1
musicControlRow.ZIndex = 10

local volFrame = Instance.new("Frame", musicControlRow)
volFrame.Size, volFrame.Position, volFrame.BackgroundColor3, volFrame.ZIndex = UDim2.new(0.5, -4, 1, 0), UDim2.new(0, 0, 0, 0), Color3.fromRGB(240, 240, 240), 10
volFrame.BorderSizePixel = 0
Instance.new("UICorner", volFrame).CornerRadius = UDim.new(0, 6)

local volumeLabel = Instance.new("TextLabel", volFrame)
volumeLabel.Size, volumeLabel.Position, volumeLabel.BackgroundTransparency, volumeLabel.Text, volumeLabel.Font, volumeLabel.TextSize, volumeLabel.TextXAlignment, volumeLabel.ZIndex = UDim2.new(0, 50, 1, 0), UDim2.new(0, 4, 0, 0), 1, "🔊 Vol:", Enum.Font.SourceSansSemibold, 11, Enum.TextXAlignment.Left, 11
Hub.ApplyBlackTextWhiteOutline(volumeLabel)

local volSliderBg = Instance.new("Frame", volFrame)
volSliderBg.Size, volSliderBg.Position, volSliderBg.BackgroundColor3, volSliderBg.ZIndex = UDim2.new(1, -56, 0, 8), UDim2.new(0, 52, 0.5, -4), Color3.fromRGB(200, 200, 200), 11
volSliderBg.BorderSizePixel = 0
Instance.new("UICorner", volSliderBg).CornerRadius = UDim.new(1, 0)

local volSliderFill = Instance.new("Frame", volSliderBg)
volSliderFill.Size, volSliderFill.BackgroundColor3, volSliderFill.ZIndex = UDim2.new(0.5, 0, 1, 0), Color3.fromRGB(50, 200, 50), 12
volSliderFill.BorderSizePixel = 0
Instance.new("UICorner", volSliderFill).CornerRadius = UDim.new(1, 0)

local isDraggingVol = false
volSliderBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isDraggingVol = true end
end)
Hub.UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isDraggingVol = false end
end)
Hub.UserInputService.InputChanged:Connect(function(input)
    if isDraggingVol and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local absPos, absSize = volSliderBg.AbsolutePosition.X, volSliderBg.AbsoluteSize.X
        local relX = math.clamp((input.Position.X - absPos) / absSize, 0, 1)
        volSliderFill.Size = UDim2.new(relX, 0, 1, 0)
        HubSound.Volume = relX
        volumeLabel.Text = "🔊 " .. math.floor(relX * 100) .. "%"
    end
end)

local timeFrame = Instance.new("Frame", musicControlRow)
timeFrame.Size, timeFrame.Position, timeFrame.BackgroundColor3, timeFrame.ZIndex = UDim2.new(0.5, -4, 1, 0), UDim2.new(0.5, 4, 0, 0), Color3.fromRGB(240, 240, 240), 10
timeFrame.BorderSizePixel = 0
Instance.new("UICorner", timeFrame).CornerRadius = UDim.new(0, 6)

local timeLabel = Instance.new("TextLabel", timeFrame)
timeLabel.Size, timeLabel.BackgroundTransparency, timeLabel.Text, timeLabel.Font, timeLabel.TextSize, timeLabel.TextXAlignment, timeLabel.ZIndex = UDim2.new(1, 0, 1, 0), 1, "⏱ 0:00 / 0:00", Enum.Font.SourceSansSemibold, 11, Enum.TextXAlignment.Center, 11
Hub.ApplyBlackTextWhiteOutline(timeLabel)

task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if HubSound.IsPlaying and HubSound.TimeLength > 0 then
                local cur, tot = math.floor(HubSound.TimePosition), math.floor(HubSound.TimeLength)
                timeLabel.Text = string.format("⏱ %d:%02d/%d:%02d", math.floor(cur/60), cur%60, math.floor(tot/60), tot%60)
            else
                timeLabel.Text = "⏱ 0:00 / 0:00"
            end
        end)
    end
end)

local isMusicPlaying = false
local toggleMusicBtn = Instance.new("TextButton", t6)
toggleMusicBtn.LayoutOrder = 13
toggleMusicBtn.Size, toggleMusicBtn.BackgroundColor3, toggleMusicBtn.Text, toggleMusicBtn.Font, toggleMusicBtn.TextSize, toggleMusicBtn.ZIndex = UDim2.new(1,0,0,32), Color3.fromRGB(200,50,50), "Phát Nhạc Background: TẮT ❌", Enum.Font.SourceSansBold, 12, 10
Instance.new("UICorner", toggleMusicBtn).CornerRadius = UDim.new(0, 6)
Hub.ApplyBlackTextWhiteOutline(toggleMusicBtn)

dropBtn.MouseButton1Click:Connect(function() 
    dropFrame.Visible = not dropFrame.Visible 
    colorDropFrame.Visible = false
    musicDropFrame.Visible = false
end)

local h = 0
for _, scr in ipairs(Hub.RegisteredScripts) do
    local item = Instance.new("TextButton", dropFrame)
    item.Size, item.BackgroundColor3, item.Text, item.Font, item.TextSize, item.TextXAlignment, item.ZIndex = UDim2.new(1,0,0,28), Color3.fromRGB(255,255,255), "  ▶ " .. scr.Name, Enum.Font.SourceSansSemibold, 12, Enum.TextXAlignment.Left, 31
    Instance.new("UICorner", item).CornerRadius = UDim.new(0, 4)
    Hub.ApplyBlackTextWhiteOutline(item)
    item.MouseButton1Click:Connect(function()
        selScript = scr
        dropBtn.Text = " 📜 Đã chọn: " .. scr.Name
        dropFrame.Visible = false
        dropStroke.Color = Color3.fromRGB(255,50,50)
    end)
    h = h + 32
end
dropFrame.CanvasSize = UDim2.new(0,0,0,h)

clearBtn.MouseButton1Click:Connect(function()
    selScript = nil
    dropBtn.Text = " 📜 Chọn Script Auto Load..."
    dropStroke.Color = Color3.fromRGB(200,200,200)
    if isAuto then
        isAuto = false
        toggleAuto.BackgroundColor3 = Color3.fromRGB(200,50,50)
        toggleAuto.Text = "Auto Load Script Chạy: TẮT ❌"
    end
end)

toggleAuto.MouseButton1Click:Connect(function()
    if not selScript then dropBtn.Text = " ⚠️ Bạn chưa chọn script!" return end
    isAuto = not isAuto
    if isAuto then
        toggleAuto.BackgroundColor3 = Color3.fromRGB(50,200,50)
        toggleAuto.Text = "Auto Load Script Chạy: BẬT ✅"
        pcall(selScript.Callback)
    else
        toggleAuto.BackgroundColor3 = Color3.fromRGB(200,50,50)
        toggleAuto.Text = "Auto Load Script Chạy: TẮT ❌"
    end
end)

colorDropBtn.MouseButton1Click:Connect(function() 
    colorDropFrame.Visible = not colorDropFrame.Visible 
    dropFrame.Visible = false
    musicDropFrame.Visible = false
end)

local ch = 0
for _, cItem in ipairs(colorList) do
    local cBtn = Instance.new("TextButton", colorDropFrame)
    cBtn.Size, cBtn.BackgroundColor3, cBtn.Text, cBtn.Font, cBtn.TextSize, cBtn.TextXAlignment, cBtn.ZIndex = UDim2.new(1,0,0,26), Color3.fromRGB(255,255,255), " " .. cItem.Name, Enum.Font.SourceSansSemibold, 12, Enum.TextXAlignment.Left, 31
    Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 4)
    Hub.ApplyBlackTextWhiteOutline(cBtn)
    cBtn.MouseButton1Click:Connect(function()
        selectedColorObj = cItem
        colorDropBtn.Text = " 🎨 Đã chọn: " .. cItem.Name
        colorDropFrame.Visible = false
    end)
    ch = ch + 30
end
colorDropFrame.CanvasSize = UDim2.new(0,0,0,ch)

toggleColorBtn.MouseButton1Click:Connect(function()
    isColorApplied = not isColorApplied
    if isColorApplied then
        toggleColorBtn.BackgroundColor3 = Color3.fromRGB(50,200,50)
        toggleColorBtn.Text = "Màu Menu Tùy Chỉnh: BẬT ✅"
        if selectedColorObj.Color then
            Hub.RainbowGradient.Enabled = false
            Hub.MainFrame.BackgroundColor3 = selectedColorObj.Color
        else
            Hub.RainbowGradient.Enabled = true
            Hub.MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        end
    else
        toggleColorBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
        toggleColorBtn.Text = "Màu Menu Tùy Chỉnh: TẮT ❌"
        Hub.RainbowGradient.Enabled = true
        Hub.MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    end
end)

toggleFpsBtn.MouseButton1Click:Connect(function()
    isFpsModeOn = not isFpsModeOn
    if isFpsModeOn then
        toggleFpsBtn.BackgroundColor3 = Color3.fromRGB(50,200,50)
        toggleFpsBtn.Text = "Màn Hình Đen Giảm FPS: BẬT ✅"
        Hub.BlackScreenGui.Enabled = true
    else
        toggleFpsBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
        toggleFpsBtn.Text = "Màn Hình Đen Giảm FPS: TẮT ❌"
        Hub.BlackScreenGui.Enabled = false
    end
end)

musicDropBtn.MouseButton1Click:Connect(function() 
    musicDropFrame.Visible = not musicDropFrame.Visible 
    dropFrame.Visible = false
    colorDropFrame.Visible = false
end)

local mh = 0
for _, mItem in ipairs(presetMusics) do
    local mBtn = Instance.new("TextButton", musicDropFrame)
    mBtn.Size, mBtn.BackgroundColor3, mBtn.Text, mBtn.Font, mBtn.TextSize, mBtn.TextXAlignment, mBtn.ZIndex = UDim2.new(1,0,0,26), Color3.fromRGB(255,255,255), " " .. mItem.Name, Enum.Font.SourceSansSemibold, 12, Enum.TextXAlignment.Left, 31
    Instance.new("UICorner", mBtn).CornerRadius = UDim.new(0, 4)
    Hub.ApplyBlackTextWhiteOutline(mBtn)
    mBtn.MouseButton1Click:Connect(function()
        currentSoundId = mItem.Id
        musicDropBtn.Text = " 🎵 Đã chọn: " .. mItem.Name
        musicDropFrame.Visible = false
        if HubSound.IsPlaying then
            HubSound.SoundId = "rbxassetid://" .. currentSoundId
            HubSound:Play()
        end
    end)
    mh = mh + 30
end
musicDropFrame.CanvasSize = UDim2.new(0,0,0,mh)

customIdBox.FocusLost:Connect(function()
    if customIdBox.Text ~= "" and tonumber(customIdBox.Text) then
        currentSoundId = customIdBox.Text
        musicDropBtn.Text = " 🎵 ID Custom: " .. currentSoundId
        if HubSound.IsPlaying then
            HubSound.SoundId = "rbxassetid://" .. currentSoundId
            HubSound:Play()
        end
    end
end)

toggleMusicBtn.MouseButton1Click:Connect(function()
    isMusicPlaying = not isMusicPlaying
    if isMusicPlaying then
        toggleMusicBtn.BackgroundColor3 = Color3.fromRGB(50,200,50)
        toggleMusicBtn.Text = "Phát Nhạc Background: BẬT ✅"
        HubSound.SoundId = "rbxassetid://" .. currentSoundId
        HubSound:Play()
    else
        toggleMusicBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
        toggleMusicBtn.Text = "Phát Nhạc Background: TẮT ❌"
        HubSound:Stop()
    end
end)

Hub.ToggleBtn.MouseButton1Click:Connect(function() Hub.MainFrame.Visible = not Hub.MainFrame.Visible end)
