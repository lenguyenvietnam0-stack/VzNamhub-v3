-- =========================================================================
-- PHẦN 1: KHỞI TẠO GIAO DIỆN VÀ TẠO CHỮ ĐEN VIỀN TRẮNG
-- =========================================================================
local CoreGui, Players, TweenService, UserInputService, TeleportService, GuiService = game:GetService("CoreGui"), game:GetService("Players"), game:GetService("TweenService"), game:GetService("UserInputService"), game:GetService("TeleportService"), game:GetService("GuiService")
local localPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("VzNamHubGui") then CoreGui.VzNamHubGui:Destroy() end

local LastSelectedScriptBtn, LastSelectedScriptStroke = nil, nil
local RegisteredScripts = {}

-- Hàm tự động cài Chữ Đen Viền Trắng nổi bật
local function ApplyBlackTextWhiteOutline(textObj)
    textObj.TextColor3 = Color3.fromRGB(0, 0, 0)
    textObj.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    textObj.TextStrokeTransparency = 0
end

getgenv().AutoRejoinActive = getgenv().AutoRejoinActive or false
if not getgenv().RejoinConnection then
    getgenv().RejoinConnection = GuiService.ErrorMessageChanged:Connect(function()
        if getgenv().AutoRejoinActive then
            task.wait(3)
            if #Players:GetPlayers() <= 1 then
                TeleportService:Teleport(game.PlaceId, localPlayer)
            else
                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer)
            end
        end
    end)
end

local VzNamGui = Instance.new("ScreenGui", CoreGui) VzNamGui.Name = "VzNamHubGui" VzNamGui.ResetOnSpawn = false

local avatarUrl = "rbxassetid://6031094678"
pcall(function() avatarUrl = Players:GetUserThumbnailAsync(localPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420) end)

local ToggleBtn = Instance.new("ImageButton", VzNamGui)
ToggleBtn.Name, ToggleBtn.BackgroundColor3, ToggleBtn.Position, ToggleBtn.Size, ToggleBtn.Active, ToggleBtn.Draggable, ToggleBtn.Image = "ToggleBtn", Color3.fromRGB(30, 30, 30), UDim2.new(0.05, 0, 0.2, 0), UDim2.new(0, 55, 0, 55), true, true, avatarUrl
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local ToggleStroke = Instance.new("UIStroke", ToggleBtn) ToggleStroke.Color, ToggleStroke.Thickness = Color3.fromRGB(255, 255, 255), 2

local MainFrame = Instance.new("Frame", VzNamGui)
MainFrame.Name, MainFrame.BackgroundColor3, MainFrame.Position, MainFrame.Size, MainFrame.ClipsDescendants = "MainFrame", Color3.fromRGB(255, 255, 255), UDim2.new(0.5, -170, 0.5, -150), UDim2.new(0, 370, 0, 310), true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local RainbowGradient = Instance.new("UIGradient", MainFrame)
RainbowGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 180, 180)), ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 220, 180)), ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 180)), ColorSequenceKeypoint.new(0.6, Color3.fromRGB(180, 255, 200)), ColorSequenceKeypoint.new(0.8, Color3.fromRGB(180, 220, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 180, 255))})
TweenService:Create(RainbowGradient, TweenInfo.new(8, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false), {Rotation = 360}):Play()
local FrameStroke = Instance.new("UIStroke", MainFrame) FrameStroke.Color, FrameStroke.Thickness = Color3.fromRGB(255, 255, 255), 2

local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Name, TitleBar.Size, TitleBar.BackgroundColor3, TitleBar.BackgroundTransparency = "TitleBar", UDim2.new(1, 0, 0, 40), Color3.fromRGB(0, 0, 0), 0.6
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

local dragging, dragInput, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging, dragStart, startPos = true, input.Position, MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
TitleBar.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
UserInputService.InputChanged:Connect(function(input) if input == dragInput and dragging then local delta = input.Position - dragStart MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)

local HeaderAvatar = Instance.new("ImageLabel", TitleBar) HeaderAvatar.Position, HeaderAvatar.Size, HeaderAvatar.BackgroundTransparency, HeaderAvatar.Image = UDim2.new(0, 10, 0.5, -14), UDim2.new(0, 28, 0, 28), 1, avatarUrl
Instance.new("UICorner", HeaderAvatar).CornerRadius = UDim.new(1, 0)

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Position, TitleText.Size, TitleText.BackgroundTransparency, TitleText.Text, TitleText.TextSize, TitleText.Font, TitleText.TextXAlignment = UDim2.new(0, 45, 0, 0), UDim2.new(1, -50, 1, 0), 1, "🌸TỔNG HỢP | 👑VzNam Hub v3👑 | 🌸", 13, Enum.Font.SourceSansBold, Enum.TextXAlignment.Left
ApplyBlackTextWhiteOutline(TitleText)

local TabBarLeftScroll = Instance.new("ScrollingFrame", MainFrame)
TabBarLeftScroll.Position, TabBarLeftScroll.Size, TabBarLeftScroll.BackgroundTransparency, TabBarLeftScroll.CanvasSize, TabBarLeftScroll.ScrollBarThickness = UDim2.new(0, 8, 0, 48), UDim2.new(0, 100, 1, -56), 1, UDim2.new(0, 0, 0, 340), 3
local LeftLayout = Instance.new("UIListLayout", TabBarLeftScroll) LeftLayout.Padding = UDim.new(0, 8)

local function CreateCategoryContainer(visible)
    local frame = Instance.new("Frame", MainFrame) frame.Position, frame.Size, frame.BackgroundTransparency, frame.Visible = UDim2.new(0, 114, 0, 48), UDim2.new(1, -122, 1, -56), 1, visible
    local subBar = Instance.new("Frame", frame) subBar.Size, subBar.BackgroundTransparency = UDim2.new(1, 0, 0, 28), 1
    local subLayout = Instance.new("UIListLayout", subBar) subLayout.FillDirection, subLayout.Padding = Enum.FillDirection.Horizontal, UDim.new(0, 6)
    
    local noKeyBtn = Instance.new("TextButton", subBar) noKeyBtn.Size, noKeyBtn.BackgroundColor3, noKeyBtn.BackgroundTransparency, noKeyBtn.Text, noKeyBtn.Font, noKeyBtn.TextSize = UDim2.new(0.48, 0, 1, 0), Color3.fromRGB(0, 0, 0), 0.3, "no key", Enum.Font.SourceSansBold, 12
    Instance.new("UICorner", noKeyBtn).CornerRadius = UDim.new(0, 6)
    local nkStroke = Instance.new("UIStroke", noKeyBtn) nkStroke.Color, nkStroke.Thickness = Color3.fromRGB(255, 50, 50), 2
    ApplyBlackTextWhiteOutline(noKeyBtn)
    
    local hasKeyBtn = Instance.new("TextButton", subBar) hasKeyBtn.Size, hasKeyBtn.BackgroundColor3, hasKeyBtn.BackgroundTransparency, hasKeyBtn.Text, hasKeyBtn.Font, hasKeyBtn.TextSize = UDim2.new(0.48, 0, 1, 0), Color3.fromRGB(0, 0, 0), 0.7, "có key", Enum.Font.SourceSansBold, 12
    Instance.new("UICorner", hasKeyBtn).CornerRadius = UDim.new(0, 6)
    local hkStroke = Instance.new("UIStroke", hasKeyBtn) hkStroke.Color, hkStroke.Thickness = Color3.fromRGB(255, 255, 255), 1
    ApplyBlackTextWhiteOutline(hasKeyBtn)
    
    local scrollNoKey = Instance.new("ScrollingFrame", frame) scrollNoKey.Position, scrollNoKey.Size, scrollNoKey.BackgroundTransparency, scrollNoKey.CanvasSize, scrollNoKey.ScrollBarThickness, scrollNoKey.Visible = UDim2.new(0, 0, 0, 34), UDim2.new(1, 0, 1, -34), 1, UDim2.new(0, 0, 0, 2000), 4, true
    Instance.new("UIListLayout", scrollNoKey).Padding = UDim.new(0, 8)
    
    local scrollHasKey = Instance.new("ScrollingFrame", frame) scrollHasKey.Position, scrollHasKey.Size, scrollHasKey.BackgroundTransparency, scrollHasKey.CanvasSize, scrollHasKey.ScrollBarThickness, scrollHasKey.Visible = UDim2.new(0, 0, 0, 34), UDim2.new(1, 0, 1, -34), 1, UDim2.new(0, 0, 0, 2000), 4, false
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

local function CreateCustomContainer(visible)
    local frame = Instance.new("Frame", MainFrame) 
    frame.Position, frame.Size, frame.BackgroundTransparency, frame.Visible = UDim2.new(0, 114, 0, 48), UDim2.new(1, -122, 1, -56), 1, visible
    local scroll = Instance.new("ScrollingFrame", frame) 
    scroll.Position, scroll.Size, scroll.BackgroundTransparency, scroll.CanvasSize, scroll.ScrollBarThickness = UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 1, 0), 1, UDim2.new(0, 0, 0, 1000), 4
    Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 8)
    return frame, scroll
end

local tabContainers, mainTabButtons = {}, {}
local tabNames = {"🌸STEAL AN EGG🌸", "🌸BLOX FRUIT🌸", "🌸BREAK AN STEAL AN EGG🌸", "Tab 4", "Tab 5", "👾KHÁC👾"}

for i = 1, 6 do
    local isFirst = (i == 1)
    if i == 6 then
        local frame, scroll = CreateCustomContainer(false)
        tabContainers[i] = {Container = frame, Scroll = scroll}
    else
        local container, noKeyScroll, hasKeyScroll = CreateCategoryContainer(isFirst)
        tabContainers[i] = {Container = container, NoKeyScroll = noKeyScroll, HasKeyScroll = hasKeyScroll}
    end
    
    local btn = Instance.new("TextButton", TabBarLeftScroll)
    btn.Size, btn.BackgroundColor3, btn.BackgroundTransparency, btn.Text, btn.Font, btn.TextSize, btn.TextWrapped = UDim2.new(1, 0, 0, 38), Color3.fromRGB(0, 0, 0), isFirst and 0.3 or 0.7, tabNames[i], Enum.Font.SourceSansBold, 12, true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    local stroke = Instance.new("UIStroke", btn) stroke.Color, stroke.Thickness = isFirst and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 255, 255), isFirst and 2 or 1
    ApplyBlackTextWhiteOutline(btn)
    mainTabButtons[i] = {Button = btn, Stroke = stroke}
    
    btn.MouseButton1Click:Connect(function()
        for j = 1, 6 do
            local active = (i == j)
            tabContainers[j].Container.Visible = active
            mainTabButtons[j].Button.BackgroundTransparency = active and 0.3 or 0.7
            mainTabButtons[j].Stroke.Color, mainTabButtons[j].Stroke.Thickness = active and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 255, 255), active and 2 or 1
        end
    end)
end

local function AddScriptButton(scrollParent, Name, Callback)
    local Btn = Instance.new("TextButton", scrollParent)
    Btn.Size, Btn.BackgroundColor3, Btn.BackgroundTransparency, Btn.Text, Btn.Font, Btn.TextSize = UDim2.new(1, 0, 0, 38), Color3.fromRGB(255, 255, 255), 0.25, Name, Enum.Font.SourceSansSemibold, 14
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    local BtnStroke = Instance.new("UIStroke", Btn) BtnStroke.Color, BtnStroke.Thickness = Color3.fromRGB(255, 255, 255), 1
    ApplyBlackTextWhiteOutline(Btn)
    
    Btn.MouseButton1Click:Connect(function()
        if LastSelectedScriptStroke then LastSelectedScriptStroke.Color, LastSelectedScriptStroke.Thickness = Color3.fromRGB(255, 255, 255), 1 end
        BtnStroke.Color, BtnStroke.Thickness = Color3.fromRGB(255, 50, 50), 2.5
        LastSelectedScriptBtn, LastSelectedScriptStroke = Btn, BtnStroke
        Callback()
    end)

    table.insert(RegisteredScripts, {Name = Name, Callback = Callback})
end
-- =========================================================================
-- PHẦN 2: DANH SÁCH SCRIPT TỪ TAB 1 ĐẾN TAB 5
-- =========================================================================
-- TAB 1: STEAL AN EGG
AddScriptButton(tabContainers[1].NoKeyScroll, "1. Hop sv1 người(nokey)", function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)
AddScriptButton(tabContainers[1].NoKeyScroll, "2. FyyCommunity(lúc có key lúc no key)", function() loadstring(game:HttpGet("https://FyyCommunity.my.id"))() end)
AddScriptButton(tabContainers[1].NoKeyScroll, "3. Chilli Hub V4(nokey)", function() loadstring(game:HttpGet("https://id.tomroblox.com/raw/kairoblox/chilli-hub-viet-hoa-v4"))() end)
AddScriptButton(tabContainers[1].NoKeyScroll, "4. Night hub(nokey)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/StealAnEggs.luau"))() end)

AddScriptButton(tabContainers[1].HasKeyScroll, "1. Lemon Hub v4(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/owenzeke99-tech/lennonhubv4/refs/heads/main/lennonhubkeyless.txt", true))() end)
AddScriptButton(tabContainers[1].HasKeyScroll, "2. Hoshi hub(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/napun87/stealanegg/refs/heads/main/hosi.lua"))() end)
AddScriptButton(tabContainers[1].HasKeyScroll, "3. Bigfroot(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua"))() end)
AddScriptButton(tabContainers[1].HasKeyScroll, "4. Chữ A(ajjans)|(có key)", function() loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/359e97f8618e9008afe5f496184ebb7c.lua"))() end)
AddScriptButton(tabContainers[1].HasKeyScroll, "5. Speed hub(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))() end)
AddScriptButton(tabContainers[1].HasKeyScroll, "6. Neohub(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/neohubdev/script/main/script"))() end)
AddScriptButton(tabContainers[1].HasKeyScroll, "7. Real kid(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/realkidhub/realkid/refs/heads/main/main.lua"))() end)
AddScriptButton(tabContainers[1].HasKeyScroll, "8. Chilli v2(có key)", function() loadstring(game:HttpGet("https://gist.githubusercontent.com/ronnei/1fa67c56dd9af203b192d15e752928e5/raw/4e2d5105640e09a008b4ae6df23f9708cadfef06/chilliv2-stealanegg"))() end)

-- TAB 2: BLOXKID
AddScriptButton(tabContainers[2].NoKeyScroll, "1. RedzHub v2 (no key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/UCT-hub/main/refs/heads/main/redz-v2"))() end)
AddScriptButton(tabContainers[2].NoKeyScroll, "2. Quantumx Hub(nokey)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))() end)

AddScriptButton(tabContainers[2].HasKeyScroll, "1. Speed Hub(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))() end)
AddScriptButton(tabContainers[2].HasKeyScroll, "2. Omg Hub(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua"))() end)
AddScriptButton(tabContainers[2].HasKeyScroll, "3. TeddyHub(có key)", function() repeat task.wait() until game:IsLoaded() and game:GetService("Players") and game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui") loadstring(game:HttpGet("https://raw.githubusercontent.com/teddyhubdev/diepvy/refs/heads/main/TeddyHub.lua"))() end)
AddScriptButton(tabContainers[2].HasKeyScroll, "4. Gravity Hub(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua"))() end)
AddScriptButton(tabContainers[2].HasKeyScroll, "5. Realkid hub(có key)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/realkidhub/realkid/refs/heads/main/main.lua"))() end)
AddScriptButton(tabContainers[2].HasKeyScroll, "6. BananaHub(có key)", function() repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer getgenv().Team = "Marines" loadstring(game:HttpGet("https://raw.githubusercontent.com/obiyeueim/vthangsitink/main/BananaHub.lua"))() end)

-- TAB 3: BREAK AND STEAL AN EGG
AddScriptButton(tabContainers[3].NoKeyScroll, "1. break and steal an egg(không sài dc nx)", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua"))() end)
AddScriptButton(tabContainers[3].HasKeyScroll, "1. Tên Script Có Key (Tab 3)", function() end)

-- TAB 4 (Thêm script vào đây)
AddScriptButton(tabContainers[4].NoKeyScroll, "1. Tên Script No Key (Tab 4)", function() end)
AddScriptButton(tabContainers[4].HasKeyScroll, "1. Tên Script Có Key (Tab 4)", function() end)

-- TAB 5 (Thêm script vào đây)
AddScriptButton(tabContainers[5].NoKeyScroll, "1. Tên Script No Key (Tab 5)", function() end)
AddScriptButton(tabContainers[5].HasKeyScroll, "1. Tên Script Có Key (Tab 5)", function() end)
Instance.new("UICorner", colorDropBtn).CornerRadius = UDim.new(0, 6)
ApplyBlackTextWhiteOutline(colorDropBtn)

local colorDropFrame = Instance.new("ScrollingFrame", t6)
colorDropFrame.Size, colorDropFrame.BackgroundColor3, colorDropFrame.CanvasSize, colorDropFrame.ScrollBarThickness, colorDropFrame.Visible = UDim2.new(1,0,0,100), Color3.fromRGB(250,250,250), UDim2.new(0,0,0,0), 3, false
Instance.new("UICorner", colorDropFrame).CornerRadius = UDim.new(0, 6)
Instance.new("UIListLayout", colorDropFrame).Padding = UDim.new(0, 4)

colorDropBtn.MouseButton1Click:Connect(function() colorDropFrame.Visible = not colorDropFrame.Visible end)

local ch = 0
for _, cItem in ipairs(colorList) do
    local cBtn = Instance.new("TextButton", colorDropFrame)
    cBtn.Size, cBtn.BackgroundColor3, cBtn.Text, cBtn.Font, cBtn.TextSize, cBtn.TextXAlignment = UDim2.new(1,0,0,26), Color3.fromRGB(255,255,255), " " .. cItem.Name, Enum.Font.SourceSansSemibold, 12, Enum.TextXAlignment.Left
    Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 4)
    ApplyBlackTextWhiteOutline(cBtn)
    cBtn.MouseButton1Click:Connect(function()
-- =========================================================================
-- PHẦN 3: TAB 6 (KHÁC) - AUTO LOAD, CHỌN MÀU MENU, GIẢM FPS & PHÁT NHẠC
-- =========================================================================
local RegisteredScripts = RegisteredScripts or {}
local tabContainers = tabContainers or {}

if not tabContainers[6] or not tabContainers[6].Scroll then
    return
end

local t6 = tabContainers[6].Scroll
local selScript, isAuto = nil, false

-- -------------------------------------------------------------------------
-- 1. CHỌN SCRIPT AUTO LOAD
-- -------------------------------------------------------------------------
local dropBtn = Instance.new("TextButton", t6)
dropBtn.Size, dropBtn.BackgroundColor3, dropBtn.Text, dropBtn.Font, dropBtn.TextSize, dropBtn.TextXAlignment = UDim2.new(1,0,0,34), Color3.fromRGB(240,240,240), " 📜 Chọn Script Auto Load...", Enum.Font.SourceSansSemibold, 13, Enum.TextXAlignment.Left
Instance.new("UICorner", dropBtn).CornerRadius = UDim.new(0, 6)
local dropStroke = Instance.new("UIStroke", dropBtn) dropStroke.Color = Color3.fromRGB(200,200,200)
if ApplyBlackTextWhiteOutline then ApplyBlackTextWhiteOutline(dropBtn) end

local dropFrame = Instance.new("ScrollingFrame", t6)
dropFrame.Size, dropFrame.BackgroundColor3, dropFrame.CanvasSize, dropFrame.ScrollBarThickness, dropFrame.Visible = UDim2.new(1,0,0,90), Color3.fromRGB(250,250,250), UDim2.new(0,0,0,0), 3, false
Instance.new("UICorner", dropFrame).CornerRadius = UDim.new(0, 6)
Instance.new("UIListLayout", dropFrame).Padding = UDim.new(0, 4)

local clearBtn = Instance.new("TextButton", t6)
clearBtn.Size, clearBtn.BackgroundColor3, clearBtn.Text, clearBtn.Font, clearBtn.TextSize = UDim2.new(1,0,0,28), Color3.fromRGB(150,150,150), "🚫 Hủy chọn Script ❌", Enum.Font.SourceSansBold, 12
Instance.new("UICorner", clearBtn).CornerRadius = UDim.new(0, 6)
if ApplyBlackTextWhiteOutline then ApplyBlackTextWhiteOutline(clearBtn) end

local toggleAuto = Instance.new("TextButton", t6)
toggleAuto.Size, toggleAuto.BackgroundColor3, toggleAuto.Text, toggleAuto.Font, toggleAuto.TextSize = UDim2.new(1,0,0,32), Color3.fromRGB(200,50,50), "Auto Load Script Chạy: TẮT ❌", Enum.Font.SourceSansBold, 12
Instance.new("UICorner", toggleAuto).CornerRadius = UDim.new(0, 6)
if ApplyBlackTextWhiteOutline then ApplyBlackTextWhiteOutline(toggleAuto) end

dropBtn.MouseButton1Click:Connect(function() dropFrame.Visible = not dropFrame.Visible end)

local h = 0
for _, scr in ipairs(RegisteredScripts) do
    local item = Instance.new("TextButton", dropFrame)
    item.Size, item.BackgroundColor3, item.Text, item.Font, item.TextSize, item.TextXAlignment = UDim2.new(1,0,0,28), Color3.fromRGB(255,255,255), "  ▶ " .. scr.Name, Enum.Font.SourceSansSemibold, 12, Enum.TextXAlignment.Left
    Instance.new("UICorner", item).CornerRadius = UDim.new(0, 4)
    if ApplyBlackTextWhiteOutline then ApplyBlackTextWhiteOutline(item) end
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

-- -------------------------------------------------------------------------
-- 2. TÍNH NĂNG CHỌN MÀU MENU
-- -------------------------------------------------------------------------
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
colorDropBtn.Size, colorDropBtn.BackgroundColor3, colorDropBtn.Text, colorDropBtn.Font, colorDropBtn.TextSize, colorDropBtn.TextXAlignment = UDim2.new(1,0,0,34), Color3.fromRGB(240,240,240), " 🎨 Chọn Màu Menu...", Enum.Font.SourceSansSemibold, 13, Enum.TextXAlignment.Left
Instance.new("UICorner", colorDropBtn).CornerRadius = UDim.new(0, 6)
if ApplyBlackTextWhiteOutline then ApplyBlackTextWhiteOutline(colorDropBtn) end

local colorDropFrame = Instance.new("ScrollingFrame", t6)
colorDropFrame.Size, colorDropFrame.BackgroundColor3, colorDropFrame.CanvasSize, colorDropFrame.ScrollBarThickness, colorDropFrame.Visible = UDim2.new(1,0,0,100), Color3.fromRGB(250,250,250), UDim2.new(0,0,0,0), 3, false
Instance.new("UICorner", colorDropFrame).CornerRadius = UDim.new(0, 6)
Instance.new("UIListLayout", colorDropFrame).Padding = UDim.new(0, 4)

colorDropBtn.MouseButton1Click:Connect(function() colorDropFrame.Visible = not colorDropFrame.Visible end)

local ch = 0
for _, cItem in ipairs(colorList) do
    local cBtn = Instance.new("TextButton", colorDropFrame)
    cBtn.Size, cBtn.BackgroundColor3, cBtn.Text, cBtn.Font, cBtn.TextSize, cBtn.TextXAlignment = UDim2.new(1,0,0,26), Color3.fromRGB(255,255,255), " " .. cItem.Name, Enum.Font.SourceSansSemibold, 12, Enum.TextXAlignment.Left
    Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 4)
    if ApplyBlackTextWhiteOutline then ApplyBlackTextWhiteOutline(cBtn) end
    cBtn.MouseButton1Click:Connect(function()
        selectedColorObj = cItem
        colorDropBtn.Text = " 🎨 Đã chọn: " .. cItem.Name
        colorDropFrame.Visible = false
    end)
    ch = ch + 30
end
colorDropFrame.CanvasSize = UDim2.new(0,0,0,ch)

local toggleColorBtn = Instance.new("TextButton", t6)
toggleColorBtn.Size, toggleColorBtn.BackgroundColor3, toggleColorBtn.Text, toggleColorBtn.Font, toggleColorBtn.TextSize = UDim2.new(1,0,0,32), Color3.fromRGB(200,50,50), "Màu Menu Tùy Chỉnh: TẮT ❌", Enum.Font.SourceSansBold, 12
Instance.new("UICorner", toggleColorBtn).CornerRadius = UDim.new(0, 6)
if ApplyBlackTextWhiteOutline then ApplyBlackTextWhiteOutline(toggleColorBtn) end

toggleColorBtn.MouseButton1Click:Connect(function()
    isColorApplied = not isColorApplied
    if isColorApplied then
        toggleColorBtn.BackgroundColor3 = Color3.fromRGB(50,200,50)
        toggleColorBtn.Text = "Màu Menu Tùy Chỉnh: BẬT ✅"
        if selectedColorObj.Color then
            if RainbowGradient then RainbowGradient.Enabled = false end
            if MainFrame then MainFrame.BackgroundColor3 = selectedColorObj.Color end
        else
            if RainbowGradient then RainbowGradient.Enabled = true end
            if MainFrame then MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) end
        end
    else
        toggleColorBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
        toggleColorBtn.Text = "Màu Menu Tùy Chỉnh: TẮT ❌"
        if RainbowGradient then RainbowGradient.Enabled = true end
        if MainFrame then MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) end
    end
end)

-- -------------------------------------------------------------------------
-- 3. TÍNH NĂNG MÀN HÌNH ĐEN GIẢM FPS (ĐÃ FIX PHỦ KHẮP MÀN HÌNH)
-- -------------------------------------------------------------------------
local CoreGui = game:GetService("CoreGui")
local BlackScreenGui = CoreGui:FindFirstChild("VzNamBlackScreen")

if not BlackScreenGui then
    BlackScreenGui = Instance.new("ScreenGui", CoreGui)
    BlackScreenGui.Name = "VzNamBlackScreen"
    BlackScreenGui.DisplayOrder = 999999
    BlackScreenGui.ResetOnSpawn = false
    BlackScreenGui.Enabled = false

    local BlackFrame = Instance.new("Frame", BlackScreenGui)
    BlackFrame.Size = UDim2.new(1, 0, 1, 0)
    BlackFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BlackFrame.BackgroundTransparency = 0
    BlackFrame.BorderSizePixel = 0

    local FpsInfoText = Instance.new("TextLabel", BlackFrame)
    FpsInfoText.Size = UDim2.new(1, 0, 0, 50)
    FpsInfoText.Position = UDim2.new(0, 0, 0.5, -25)
    FpsInfoText.BackgroundTransparency = 1
    FpsInfoText.Text = "🖥️ Đang bật Màn hình đen Giảm FPS...\nBấm lại nút trong Hub để mở lại màn hình."
    FpsInfoText.TextColor3 = Color3.fromRGB(255, 255, 255)
    FpsInfoText.Font = Enum.Font.SourceSansBold
    FpsInfoText.TextSize = 16
end

local isFpsModeOn = false
local toggleFpsBtn = Instance.new("TextButton", t6)
toggleFpsBtn.Size, toggleFpsBtn.BackgroundColor3, toggleFpsBtn.Text, toggleFpsBtn.Font, toggleFpsBtn.TextSize = UDim2.new(1,0,0,32), Color3.fromRGB(200,50,50), "Màn Hình Đen Giảm FPS: TẮT ❌", Enum.Font.SourceSansBold, 12
Instance.new("UICorner", toggleFpsBtn).CornerRadius = UDim.new(0, 6)
if ApplyBlackTextWhiteOutline then ApplyBlackTextWhiteOutline(toggleFpsBtn) end

toggleFpsBtn.MouseButton1Click:Connect(function()
    isFpsModeOn = not isFpsModeOn
    if isFpsModeOn then
        toggleFpsBtn.BackgroundColor3 = Color3.fromRGB(50,200,50)
        toggleFpsBtn.Text = "Màn Hình Đen Giảm FPS: BẬT ✅"
        BlackScreenGui.Enabled = true
    else
        toggleFpsBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
        toggleFpsBtn.Text = "Màn Hình Đen Giảm FPS: TẮT ❌"
        BlackScreenGui.Enabled = false
    end
end)

-- -------------------------------------------------------------------------
-- 4. TÍNH NĂNG PHÁT NHẠC BACKGROUND
-- -------------------------------------------------------------------------
local SoundService = game:GetService("SoundService")
local HubSound = SoundService:FindFirstChild("VzNamHubSound")
if not HubSound then
    HubSound = Instance.new("Sound", SoundService)
    HubSound.Name = "VzNamHubSound"
    HubSound.Looped = true
    HubSound.Volume = 0.5
end

local presetMusics = {
    {Name = "🎵 Chill Lofi Music", Id = "1837879082"},
    {Name = "🎶 Phonk Beat", Id = "1843404008"},
    {Name = "🎵 Anime Relaxing", Id = "9043887091"},
    {Name = "🎶 EDM Hype", Id = "1837871000"}
}

local currentSoundId = presetMusics[1].Id

local musicDropBtn = Instance.new("TextButton", t6)
musicDropBtn.Size, musicDropBtn.BackgroundColor3, musicDropBtn.Text, musicDropBtn.Font, musicDropBtn.TextSize, musicDropBtn.TextXAlignment = UDim2.new(1,0,0,34), Color3.fromRGB(240,240,240), " 🎵 Chọn Nhạc Nền...", Enum.Font.SourceSansSemibold, 13, Enum.TextXAlignment.Left
Instance.new("UICorner", musicDropBtn).CornerRadius = UDim.new(0, 6)
if ApplyBlackTextWhiteOutline then ApplyBlackTextWhiteOutline(musicDropBtn) end

local musicDropFrame = Instance.new("ScrollingFrame", t6)
musicDropFrame.Size, musicDropFrame.BackgroundColor3, musicDropFrame.CanvasSize, musicDropFrame.ScrollBarThickness, musicDropFrame.Visible = UDim2.new(1,0,0,90), Color3.fromRGB(250,250,250), UDim2.new(0,0,0,0), 3, false
Instance.new("UICorner", musicDropFrame).CornerRadius = UDim.new(0, 6)
Instance.new("UIListLayout", musicDropFrame).Padding = UDim.new(0, 4)

musicDropBtn.MouseButton1Click:Connect(function() musicDropFrame.Visible = not musicDropFrame.Visible end)

local mh = 0
for _, mItem in ipairs(presetMusics) do
    local mBtn = Instance.new("TextButton", musicDropFrame)
    mBtn.Size, mBtn.BackgroundColor3, mBtn.Text, mBtn.Font, mBtn.TextSize, mBtn.TextXAlignment = UDim2.new(1,0,0,26), Color3.fromRGB(255,255,255), " " .. mItem.Name, Enum.Font.SourceSansSemibold, 12, Enum.TextXAlignment.Left
    Instance.new("UICorner", mBtn).CornerRadius = UDim.new(0, 4)
    if ApplyBlackTextWhiteOutline then ApplyBlackTextWhiteOutline(mBtn) end
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

local customIdBox = Instance.new("TextBox", t6)
customIdBox.Size, customIdBox.BackgroundColor3, customIdBox.PlaceholderText, customIdBox.Text, customIdBox.Font, customIdBox.TextSize = UDim2.new(1,0,0,30), Color3.fromRGB(240,240,240), "Nhập Sound ID tùy chỉnh...", "", Enum.Font.SourceSansSemibold, 12
Instance.new("UICorner", customIdBox).CornerRadius = UDim.new(0, 6)
if ApplyBlackTextWhiteOutline then ApplyBlackTextWhiteOutline(customIdBox) end

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

local isMusicPlaying = false
local toggleMusicBtn = Instance.new("TextButton", t6)
toggleMusicBtn.Size, toggleMusicBtn.BackgroundColor3, toggleMusicBtn.Text, toggleMusicBtn.Font, toggleMusicBtn.TextSize = UDim2.new(1,0,0,32), Color3.fromRGB(200,50,50), "Phát Nhạc Background: TẮT ❌", Enum.Font.SourceSansBold, 12
Instance.new("UICorner", toggleMusicBtn).CornerRadius = UDim.new(0, 6)
if ApplyBlackTextWhiteOutline then ApplyBlackTextWhiteOutline(toggleMusicBtn) end

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

if ToggleBtn and MainFrame then
    ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
            end
      
