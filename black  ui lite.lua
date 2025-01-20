local DiscordLib = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HttpService = game:GetService("HttpService")

local function MakeDraggable(topbarobject, object)
    local Dragging = nil
    local DragInput = nil
    local DragStart = nil
    local StartPosition = nil

    local function Update(input)
        local Delta = input.Position - DragStart
        local pos =
            UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
        object.Position = pos
    end

    topbarobject.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                DragStart = input.Position
                StartPosition = object.Position

                input.Changed:Connect(
                    function()
                        if input.UserInputState == Enum.UserInputState.End then
                            Dragging = false
                        end
                    end
                )
            end
        end
    )

    topbarobject.InputChanged:Connect(
        function(input)
            if
                input.UserInputType == Enum.UserInputType.MouseMovement or
                    input.UserInputType == Enum.UserInputType.Touch
             then
                DragInput = input
            end
        end
    )

    UserInputService.InputChanged:Connect(
        function(input)
            if input == DragInput and Dragging then
                Update(input)
            end
        end
    )
end

local Discord = Instance.new("ScreenGui")
Discord.Name = "Discord"
Discord.Parent = game.CoreGui
Discord.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

function DiscordLib:Window(text)
    local currentservertoggled = ""
    local minimized = false
    local fs = false
    local settingsopened = false
    local MainFrame = Instance.new("Frame")
    local TopFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local CloseBtn = Instance.new("TextButton")
    local CloseIcon = Instance.new("ImageLabel")
    local MinimizeBtn = Instance.new("TextButton")
    local MinimizeIcon = Instance.new("ImageLabel")
    local ServersHolder = Instance.new("Folder")
    local ServersHoldFrame = Instance.new("Frame")
    local ServersHold = Instance.new("ScrollingFrame")
    local ServersHoldLayout = Instance.new("UIListLayout")
    local ServersHoldPadding = Instance.new("UIPadding")
    local TopFrameHolder = Instance.new("Frame")

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = Discord
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, 681, 0, 396)

    TopFrame.Name = "TopFrame"
    TopFrame.Parent = MainFrame
    TopFrame.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
    TopFrame.BackgroundTransparency = 1
    TopFrame.BorderSizePixel = 0
    TopFrame.Position = UDim2.new(-0.000658480625, 0, 0, 0)
    TopFrame.Size = UDim2.new(0, 681, 0, 22)

    TopFrameHolder.Name = "TopFrameHolder"
    TopFrameHolder.Parent = TopFrame
    TopFrameHolder.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
    TopFrameHolder.BackgroundTransparency = 1
    TopFrameHolder.BorderSizePixel = 0
    TopFrameHolder.Position = UDim2.new(-0.000658480625, 0, 0, 0)
    TopFrameHolder.Size = UDim2.new(0, 681, 0, 22)

    Title.Name = "Title"
    Title.Parent = TopFrame
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0.0102790017, 0, 0, 0)
    Title.Size = UDim2.new(0, 192, 0, 23)
    Title.Font = Enum.Font.Gotham
    Title.Text = text
    Title.TextColor3 = Color3.fromRGB(191, 191, 191)
    Title.TextSize = 13.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    CloseBtn.Name = "CloseBtn"
    CloseBtn.Parent = TopFrame
    CloseBtn.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
    CloseBtn.BackgroundTransparency = 0
    CloseBtn.Position = UDim2.new(0.959063113, 0, -0.0169996787, 0)
    CloseBtn.Size = UDim2.new(0, 28, 0, 22)
    CloseBtn.Font = Enum.Font.Gotham
    CloseBtn.Text = ""
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 14.000
    CloseBtn.BorderSizePixel = 0
    CloseBtn.AutoButtonColor = false

    CloseIcon.Name = "CloseIcon"
    CloseIcon.Parent = CloseBtn
    CloseIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseIcon.BackgroundTransparency = 1.000
    CloseIcon.Position = UDim2.new(0.189182192, 0, 0.128935531, 0)
    CloseIcon.Size = UDim2.new(0, 17, 0, 17)
    CloseIcon.Image = "http://www.roblox.com/asset/?id=6035047409"
    CloseIcon.ImageColor3 = Color3.fromRGB(220, 221, 222)

    MinimizeBtn.Name = "MinimizeButton"
    MinimizeBtn.Parent = TopFrame
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
    MinimizeBtn.BackgroundTransparency = 0
    MinimizeBtn.Position = UDim2.new(0.917947114, 0, -0.0169996787, 0)
    MinimizeBtn.Size = UDim2.new(0, 28, 0, 22)
    MinimizeBtn.Font = Enum.Font.Gotham
    MinimizeBtn.Text = ""
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.TextSize = 14.000
    MinimizeBtn.BorderSizePixel = 0
    MinimizeBtn.AutoButtonColor = false

    MinimizeIcon.Name = "MinimizeLabel"
    MinimizeIcon.Parent = MinimizeBtn
    MinimizeIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeIcon.BackgroundTransparency = 1.000
    MinimizeIcon.Position = UDim2.new(0.189182192, 0, 0.128935531, 0)
    MinimizeIcon.Size = UDim2.new(0, 17, 0, 17)
    MinimizeIcon.Image = "http://www.roblox.com/asset/?id=6035067836"
    MinimizeIcon.ImageColor3 = Color3.fromRGB(220, 221, 222)

    ServersHolder.Name = "ServersHolder"
    ServersHolder.Parent = TopFrameHolder

    ServersHoldFrame.Name = "ServersHoldFrame"
    ServersHoldFrame.Parent = MainFrame
    ServersHoldFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ServersHoldFrame.BackgroundTransparency = 1
    ServersHoldFrame.BorderColor3 = Color3.fromRGB(27, 42, 53)
    ServersHoldFrame.Size = UDim2.new(0, 71, 0, 396)

    ServersHold.Name = "ServersHold"
    ServersHold.Parent = ServersHoldFrame
    ServersHold.Active = true
    ServersHold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ServersHold.BackgroundTransparency = 1
    ServersHold.BorderSizePixel = 0
    ServersHold.Position = UDim2.new(-0.000359333731, 0, 0.0580808073, 0)
    ServersHold.Size = UDim2.new(0, 71, 0, 373)
    ServersHold.ScrollBarThickness = 1
    ServersHold.ScrollBarImageTransparency = 1
    ServersHold.CanvasSize = UDim2.new(0, 0, 0, 0)

    ServersHoldLayout.Name = "ServersHoldLayout"
    ServersHoldLayout.Parent = ServersHold
    ServersHoldLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ServersHoldLayout.Padding = UDim.new(0, 7)

    ServersHoldPadding.Name = "ServersHoldPadding"
    ServersHoldPadding.Parent = ServersHold

    CloseBtn.MouseButton1Click:Connect(
        function()
            MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)

            -- Делаем проверку только один раз
            local SYPHIX = game.CoreGui:FindFirstChild("SYPHIX")
            if SYPHIX then
                SYPHIX:Destroy() -- Удаляем объект, если найден
            end
        end
    )

    CloseBtn.MouseEnter:Connect(
        function()
            CloseBtn.BackgroundColor3 = Color3.fromRGB(240, 71, 71)
        end
    )

    CloseBtn.MouseLeave:Connect(
        function()
            CloseBtn.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
        end
    )

    MinimizeBtn.MouseEnter:Connect(
        function()
            MinimizeBtn.BackgroundColor3 = Color3.fromRGB(41, 40, 40)
        end
    )

    MinimizeBtn.MouseLeave:Connect(
        function()
            MinimizeBtn.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
        end
    )

    MinimizeBtn.MouseButton1Click:Connect(
        function()
            if minimized == false then
                MainFrame:TweenSize(
                    UDim2.new(0, 681, 0, 22),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .3,
                    true
                )
            else
                MainFrame:TweenSize(
                    UDim2.new(0, 681, 0, 396),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .3,
                    true
                )
            end
            minimized = not minimized
        end
    )

    function DiscordLib:Notification(titletext, desctext, btntext)
        local NotificationHolderMain = Instance.new("TextButton")
        local Notification = Instance.new("Frame")
        local NotificationCorner = Instance.new("UICorner")
        local UnderBar = Instance.new("Frame")
        local UnderBarCorner = Instance.new("UICorner")
        local UnderBarFrame = Instance.new("Frame")
        local Text1 = Instance.new("TextLabel")
        local Text2 = Instance.new("TextLabel")
        local AlrightBtn = Instance.new("TextButton")
        local AlrightCorner = Instance.new("UICorner")

        NotificationHolderMain.Name = "NotificationHolderMain"
        NotificationHolderMain.Parent = MainFrame
        NotificationHolderMain.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        NotificationHolderMain.BackgroundTransparency = 1
        NotificationHolderMain.BorderSizePixel = 0
        NotificationHolderMain.Position = UDim2.new(0, 0, 0.0560000017, 0)
        NotificationHolderMain.Size = UDim2.new(0, 681, 0, 374)
        NotificationHolderMain.AutoButtonColor = false
        NotificationHolderMain.Font = Enum.Font.SourceSans
        NotificationHolderMain.Text = ""
        NotificationHolderMain.TextColor3 = Color3.fromRGB(0, 0, 0)
        NotificationHolderMain.TextSize = 14.000
        TweenService:Create(
            NotificationHolderMain,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.2}
        ):Play()

        Notification.Name = "Notification"
        Notification.Parent = NotificationHolderMain
        Notification.AnchorPoint = Vector2.new(0.5, 0.5)
        Notification.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
        Notification.ClipsDescendants = true
        Notification.Position = UDim2.new(0.524819076, 0, 0.469270051, 0)
        Notification.Size = UDim2.new(0, 0, 0, 0)
        Notification.BackgroundTransparency = 1

        Notification:TweenSize(UDim2.new(0, 346, 0, 176), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)

        TweenService:Create(
            Notification,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0}
        ):Play()

        NotificationCorner.CornerRadius = UDim.new(0, 5)
        NotificationCorner.Name = "NotificationCorner"
        NotificationCorner.Parent = Notification

        UnderBar.Name = "UnderBar"
        UnderBar.Parent = Notification
        UnderBar.BackgroundColor3 = Color3.fromRGB(51, 50, 50)
        UnderBar.Position = UDim2.new(-0.000297061284, 0, 0.945048928, 0)
        UnderBar.Size = UDim2.new(0, 346, 0, 10)

        UnderBarCorner.CornerRadius = UDim.new(0, 5)
        UnderBarCorner.Name = "UnderBarCorner"
        UnderBarCorner.Parent = UnderBar

        UnderBarFrame.Name = "UnderBarFrame"
        UnderBarFrame.Parent = UnderBar
        UnderBarFrame.BackgroundColor3 = Color3.fromRGB(51, 50, 50)
        UnderBarFrame.BorderSizePixel = 0
        UnderBarFrame.Position = UDim2.new(-0.000297061284, 0, -3.76068449, 0)
        UnderBarFrame.Size = UDim2.new(0, 346, 0, 40)

        Text1.Name = "Text1"
        Text1.Parent = Notification
        Text1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Text1.BackgroundTransparency = 1.000
        Text1.Position = UDim2.new(-0.000594122568, 0, 0.0202020202, 0)
        Text1.Size = UDim2.new(0, 346, 0, 68)
        Text1.Font = Enum.Font.GothamSemibold
        Text1.Text = titletext
        Text1.TextColor3 = Color3.fromRGB(255, 255, 255)
        Text1.TextSize = 20.000

        Text2.Name = "Text2"
        Text2.Parent = Notification
        Text2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Text2.BackgroundTransparency = 1.000
        Text2.Position = UDim2.new(0.106342293, 0, 0.317724228, 0)
        Text2.Size = UDim2.new(0, 272, 0, 63)
        Text2.Font = Enum.Font.Gotham
        Text2.Text = desctext
        Text2.TextColor3 = Color3.fromRGB(171, 172, 176)
        Text2.TextSize = 14.000
        Text2.TextWrapped = true

        AlrightBtn.Name = "AlrightBtn"
        AlrightBtn.Parent = Notification
        AlrightBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
        AlrightBtn.Position = UDim2.new(0.0332369953, 0, 0.789141417, 0)
        AlrightBtn.Size = UDim2.new(0, 322, 0, 27)
        AlrightBtn.Font = Enum.Font.Gotham
        AlrightBtn.Text = btntext
        AlrightBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        AlrightBtn.TextSize = 13.000
        AlrightBtn.AutoButtonColor = false

        AlrightCorner.CornerRadius = UDim.new(0, 4)
        AlrightCorner.Name = "AlrightCorner"
        AlrightCorner.Parent = AlrightBtn

        AlrightBtn.MouseButton1Click:Connect(
            function()
                TweenService:Create(
                    NotificationHolderMain,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 1}
                ):Play()
                Notification:TweenSize(
                    UDim2.new(0, 0, 0, 0),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .2,
                    true
                )
                TweenService:Create(
                    Notification,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 1}
                ):Play()
                wait(.2)
                NotificationHolderMain:Destroy()
            end
        )

        AlrightBtn.MouseEnter:Connect(
            function()
                TweenService:Create(
                    AlrightBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(28, 28, 28)}
                ):Play()
            end
        )

        AlrightBtn.MouseLeave:Connect(
            function()
                TweenService:Create(
                    AlrightBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(28, 28, 28)}
                ):Play()
            end
        )
    end

    MakeDraggable(TopFrame, MainFrame)
    ServersHoldPadding.PaddingLeft = UDim.new(0, 14)
    local ServerHold = {}
    function ServerHold:Server(text, img)
        local fc = false
        local currentchanneltoggled = ""
        local Server = Instance.new("TextButton")
        local ServerBtnCorner = Instance.new("UICorner")
        local ServerIco = Instance.new("ImageLabel")
        local ServerWhiteFrame = Instance.new("Frame")
        local ServerWhiteFrameCorner = Instance.new("UICorner")

        Server.Name = text .. "Server"
        Server.Parent = ServersHold
        Server.BackgroundColor3 = Color3.fromRGB(51, 50, 50)
        Server.Position = UDim2.new(0.125, 0, 0, 0)
        Server.Size = UDim2.new(0, 47, 0, 47)
        Server.AutoButtonColor = false
        Server.Font = Enum.Font.Gotham
        Server.Text = ""
        Server.TextColor3 = Color3.fromRGB(255, 255, 255)
        Server.TextSize = 18.000

        ServerBtnCorner.CornerRadius = UDim.new(1, 0)
        ServerBtnCorner.Name = "ServerCorner"
        ServerBtnCorner.Parent = Server

        ServerIco.Name = "ServerIco"
        ServerIco.Parent = Server
        ServerIco.AnchorPoint = Vector2.new(0.5, 0.5)
        ServerIco.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ServerIco.BackgroundTransparency = 1.000
        ServerIco.Position = UDim2.new(0.489361703, 0, 0.489361703, 0)
        ServerIco.Size = UDim2.new(0, 26, 0, 26)
        ServerIco.Image = ""

        ServerWhiteFrame.Name = "ServerWhiteFrame"
        ServerWhiteFrame.Parent = Server
        ServerWhiteFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        ServerWhiteFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ServerWhiteFrame.Position = UDim2.new(-0.347378343, 0, 0.502659559, 0)
        ServerWhiteFrame.Size = UDim2.new(0, 11, 0, 10)

        ServerWhiteFrameCorner.CornerRadius = UDim.new(1, 0)
        ServerWhiteFrameCorner.Name = "ServerWhiteFrameCorner"
        ServerWhiteFrameCorner.Parent = ServerWhiteFrame
        ServersHold.CanvasSize = UDim2.new(0, 0, 0, ServersHoldLayout.AbsoluteContentSize.Y)

        local ServerFrame = Instance.new("Frame")
        local ServerFrame1 = Instance.new("Frame")
        local ServerFrame2 = Instance.new("Frame")
        local ServerTitleFrame = Instance.new("Frame")
        local ServerTitle = Instance.new("TextLabel")
        local GlowFrame = Instance.new("Frame")
        local Glow = Instance.new("ImageLabel")
        local ServerContentFrame = Instance.new("Frame")
        local ServerCorner = Instance.new("UICorner")
        local ChannelTitleFrame = Instance.new("Frame")
        local Hashtag = Instance.new("TextLabel")
        local ChannelTitle = Instance.new("TextLabel")
        local ChannelContentFrame = Instance.new("Frame")
        local GlowChannel = Instance.new("ImageLabel")
        local ServerChannelHolder = Instance.new("ScrollingFrame")
        local ServerChannelHolderLayout = Instance.new("UIListLayout")
        local ServerChannelHolderPadding = Instance.new("UIPadding")

        ServerFrame.Name = "ServerFrame"
        ServerFrame.Parent = ServersHolder
        ServerFrame.BackgroundColor3 = Color3.fromRGB(51, 50, 50)
        ServerFrame.BorderSizePixel = 0
        ServerFrame.ClipsDescendants = true
        ServerFrame.Position = UDim2.new(0.105726875, 0, 1.01262593, 0)
        ServerFrame.Size = UDim2.new(0, 609, 0, 373)
        ServerFrame.Visible = false

        ServerFrame1.Name = "ServerFrame1"
        ServerFrame1.Parent = ServerFrame
        ServerFrame1.BackgroundColor3 = Color3.fromRGB(51, 50, 50)
        ServerFrame1.BorderSizePixel = 0
        ServerFrame1.Position = UDim2.new(0, 0, 0.972290039, 0)
        ServerFrame1.Size = UDim2.new(0, 12, 0, 10)

        ServerFrame2.Name = "ServerFrame2"
        ServerFrame2.Parent = ServerFrame
        ServerFrame2.BackgroundColor3 = Color3.fromRGB(51, 50, 50)
        ServerFrame2.BorderSizePixel = 0
        ServerFrame2.Position = UDim2.new(0.980295539, 0, 0.972290039, 0)
        ServerFrame2.Size = UDim2.new(0, 12, 0, 9)

        ServerTitleFrame.Name = "ServerTitleFrame"
        ServerTitleFrame.Parent = ServerFrame
        ServerTitleFrame.BackgroundColor3 = Color3.fromRGB(51, 50, 50)
        ServerTitleFrame.BackgroundTransparency = 1.000
        ServerTitleFrame.BorderSizePixel = 0
        ServerTitleFrame.Position = UDim2.new(-0.0010054264, 0, -0.000900391256, 0)
        ServerTitleFrame.Size = UDim2.new(0, 180, 0, 40)

        ServerTitle.Name = "ServerTitle"
        ServerTitle.Parent = ServerTitleFrame
        ServerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ServerTitle.BackgroundTransparency = 1.000
        ServerTitle.BorderSizePixel = 0
        ServerTitle.Position = UDim2.new(0.0751359761, 0, 0, 0)
        ServerTitle.Size = UDim2.new(0, 97, 0, 39)
        ServerTitle.Font = Enum.Font.GothamSemibold
        ServerTitle.Text = text
        ServerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        ServerTitle.TextSize = 15.000
        ServerTitle.TextXAlignment = Enum.TextXAlignment.Left

        GlowFrame.Name = "GlowFrame"
        GlowFrame.Parent = ServerFrame
        GlowFrame.BackgroundColor3 = Color3.fromRGB(51, 50, 50)
        GlowFrame.BackgroundTransparency = 1.000
        GlowFrame.BorderSizePixel = 0
        GlowFrame.Position = UDim2.new(-0.0010054264, 0, -0.000900391256, 0)
        GlowFrame.Size = UDim2.new(0, 609, 0, 40)

        Glow.Name = "Glow"
        Glow.Parent = GlowFrame
        Glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Glow.BackgroundTransparency = 1.000
        Glow.BorderSizePixel = 0
        Glow.Position = UDim2.new(0, -15, 0, -15)
        Glow.Size = UDim2.new(1, 30, 1, 30)
        Glow.ZIndex = 0
        Glow.Image = "rbxassetid://4996891970"
        Glow.ImageColor3 = Color3.fromRGB(10, 1, 28)
        Glow.ScaleType = Enum.ScaleType.Slice
        Glow.SliceCenter = Rect.new(20, 20, 280, 280)

        ServerContentFrame.Name = "ServerContentFrame"
        ServerContentFrame.Parent = ServerFrame
        ServerContentFrame.BackgroundColor3 = Color3.fromRGB(51, 50, 50)
        ServerContentFrame.BackgroundTransparency = 1.000
        ServerContentFrame.BorderSizePixel = 0
        ServerContentFrame.Position = UDim2.new(-0.0010054264, 0, 0.106338218, 0)
        ServerContentFrame.Size = UDim2.new(0, 180, 0, 333)

        ServerCorner.CornerRadius = UDim.new(0, 9)
        ServerCorner.Name = "ServerCorner"
        ServerCorner.Parent = ServerFrame

        ChannelTitleFrame.Name = "ChannelTitleFrame"
        ChannelTitleFrame.Parent = ServerFrame
        ChannelTitleFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
        ChannelTitleFrame.BorderSizePixel = 0
        ChannelTitleFrame.Position = UDim2.new(0.294561088, 0, -0.000900391256, 0)
        ChannelTitleFrame.Size = UDim2.new(0, 429, 0, 40)

        Hashtag.Name = "Hashtag"
        Hashtag.Parent = ChannelTitleFrame
        Hashtag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Hashtag.BackgroundTransparency = 1.000
        Hashtag.BorderSizePixel = 0
        Hashtag.Position = UDim2.new(0.0279720277, 0, 0, 0)
        Hashtag.Size = UDim2.new(0, 19, 0, 39)
        Hashtag.Font = Enum.Font.Gotham
        Hashtag.Text = "#"
        Hashtag.TextColor3 = Color3.fromRGB(191, 191, 191)
        Hashtag.TextSize = 25.000

        ChannelTitle.Name = "ChannelTitle"
        ChannelTitle.Parent = ChannelTitleFrame
        ChannelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ChannelTitle.BackgroundTransparency = 1.000
        ChannelTitle.BorderSizePixel = 0
        ChannelTitle.Position = UDim2.new(0.0862470865, 0, 0, 0)
        ChannelTitle.Size = UDim2.new(0, 95, 0, 39)
        ChannelTitle.Font = Enum.Font.GothamSemibold
        ChannelTitle.Text = ""
        ChannelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        ChannelTitle.TextSize = 15.000
        ChannelTitle.TextXAlignment = Enum.TextXAlignment.Left

        ChannelContentFrame.Name = "ChannelContentFrame"
        ChannelContentFrame.Parent = ServerFrame
        ChannelContentFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
        ChannelContentFrame.BorderSizePixel = 0
        ChannelContentFrame.ClipsDescendants = true
        ChannelContentFrame.Position = UDim2.new(0.294561088, 0, 0.106338218, 0)
        ChannelContentFrame.Size = UDim2.new(0, 429, 0, 333)

        GlowChannel.Name = "GlowChannel"
        GlowChannel.Parent = ChannelContentFrame
        GlowChannel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        GlowChannel.BackgroundTransparency = 1.000
        GlowChannel.BorderSizePixel = 0
        GlowChannel.Position = UDim2.new(0, -33, 0, -91)
        GlowChannel.Size = UDim2.new(1.06396091, 30, 0.228228226, 30)
        GlowChannel.ZIndex = 0
        GlowChannel.Image = "rbxassetid://4996891970"
        GlowChannel.ImageColor3 = Color3.fromRGB(10, 1, 28)
        GlowChannel.ScaleType = Enum.ScaleType.Slice
        GlowChannel.SliceCenter = Rect.new(20, 20, 280, 280)

        ServerChannelHolder.Name = "ServerChannelHolder"
        ServerChannelHolder.Parent = ServerContentFrame
        ServerChannelHolder.Active = true
        ServerChannelHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ServerChannelHolder.BackgroundTransparency = 1.000
        ServerChannelHolder.BorderSizePixel = 0
        ServerChannelHolder.Position = UDim2.new(0.00535549596, 0, 0.0241984241, 0)
        ServerChannelHolder.Selectable = false
        ServerChannelHolder.Size = UDim2.new(0, 179, 0, 320)
        ServerChannelHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
        ServerChannelHolder.ScrollBarThickness = 4
        ServerChannelHolder.ScrollBarImageColor3 = Color3.fromRGB(14, 1, 36)
        ServerChannelHolder.ScrollBarImageTransparency = 1

        ServerChannelHolderLayout.Name = "ServerChannelHolderLayout"
        ServerChannelHolderLayout.Parent = ServerChannelHolder
        ServerChannelHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ServerChannelHolderLayout.Padding = UDim.new(0, 4)

        ServerChannelHolderPadding.Name = "ServerChannelHolderPadding"
        ServerChannelHolderPadding.Parent = ServerChannelHolder
        ServerChannelHolderPadding.PaddingLeft = UDim.new(0, 9)

        ServerChannelHolder.MouseEnter:Connect(
            function()
                ServerChannelHolder.ScrollBarImageTransparency = 0
            end
        )

        ServerChannelHolder.MouseLeave:Connect(
            function()
                ServerChannelHolder.ScrollBarImageTransparency = 1
            end
        )

        Server.MouseEnter:Connect(
            function()
                if currentservertoggled ~= Server.Name then
                    TweenService:Create(
                        Server,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(28, 28, 28)}
                    ):Play()
                    TweenService:Create(
                        ServerBtnCorner,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {CornerRadius = UDim.new(0, 15)}
                    ):Play()
                    ServerWhiteFrame:TweenSize(
                        UDim2.new(0, 11, 0, 27),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .3,
                        true
                    )
                end
            end
        )

        Server.MouseLeave:Connect(
            function()
                if currentservertoggled ~= Server.Name then
                    TweenService:Create(
                        Server,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(51, 50, 50)}
                    ):Play()
                    TweenService:Create(
                        ServerBtnCorner,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {CornerRadius = UDim.new(1, 0)}
                    ):Play()
                    ServerWhiteFrame:TweenSize(
                        UDim2.new(0, 11, 0, 10),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .3,
                        true
                    )
                end
            end
        )

        Server.MouseButton1Click:Connect(
            function()
                currentservertoggled = Server.Name
                for i, v in next, ServersHolder:GetChildren() do
                    if v.Name == "ServerFrame" then
                        v.Visible = false
                    end
                    ServerFrame.Visible = true
                end
                for i, v in next, ServersHold:GetChildren() do
                    if v.ClassName == "TextButton" then
                        TweenService:Create(
                            v,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(51, 50, 50)}
                        ):Play()
                        TweenService:Create(
                            Server,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(28, 28, 28)}
                        ):Play()
                        TweenService:Create(
                            v.ServerCorner,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {CornerRadius = UDim.new(1, 0)}
                        ):Play()
                        TweenService:Create(
                            ServerBtnCorner,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {CornerRadius = UDim.new(0, 15)}
                        ):Play()
                        v.ServerWhiteFrame:TweenSize(
                            UDim2.new(0, 11, 0, 10),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .3,
                            true
                        )
                        ServerWhiteFrame:TweenSize(
                            UDim2.new(0, 11, 0, 46),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .3,
                            true
                        )
                    end
                end
            end
        )

        if img == "" then
            Server.Text = string.sub(text, 1, 1)
        else
            ServerIco.Image = img
        end

        if fs == false then
            TweenService:Create(
                Server,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(28, 28, 28)}
            ):Play()
            TweenService:Create(
                ServerBtnCorner,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {CornerRadius = UDim.new(0, 15)}
            ):Play()
            ServerWhiteFrame:TweenSize(
                UDim2.new(0, 11, 0, 46),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quart,
                .3,
                true
            )
            ServerFrame.Visible = true
            Server.Name = text .. "Server"
            currentservertoggled = Server.Name
            fs = true
        end

        local ChannelHold = {}
        function ChannelHold:Channel(text)
            local ChannelBtn = Instance.new("TextButton")
            local ChannelBtnCorner = Instance.new("UICorner")
            local ChannelBtnHashtag = Instance.new("TextLabel")
            local ChannelBtnTitle = Instance.new("TextLabel")

            ChannelBtn.Name = text .. "ChannelBtn"
            ChannelBtn.Parent = ServerChannelHolder
            ChannelBtn.BackgroundColor3 = Color3.fromRGB(51, 50, 50)
            ChannelBtn.BorderSizePixel = 0
            ChannelBtn.Position = UDim2.new(0.24118948, 0, 0.578947365, 0)
            ChannelBtn.Size = UDim2.new(0, 160, 0, 30)
            ChannelBtn.AutoButtonColor = false
            ChannelBtn.Font = Enum.Font.SourceSans
            ChannelBtn.Text = ""
            ChannelBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ChannelBtn.TextSize = 14.000

            ChannelBtnCorner.CornerRadius = UDim.new(0, 6)
            ChannelBtnCorner.Name = "ChannelBtnCorner"
            ChannelBtnCorner.Parent = ChannelBtn

            ChannelBtnHashtag.Name = "ChannelBtnHashtag"
            ChannelBtnHashtag.Parent = ChannelBtn
            ChannelBtnHashtag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ChannelBtnHashtag.BackgroundTransparency = 1.000
            ChannelBtnHashtag.BorderSizePixel = 0
            ChannelBtnHashtag.Position = UDim2.new(0.0279720314, 0, 0, 0)
            ChannelBtnHashtag.Size = UDim2.new(0, 24, 0, 30)
            ChannelBtnHashtag.Font = Enum.Font.Gotham
            ChannelBtnHashtag.Text = "#"
            ChannelBtnHashtag.TextColor3 = Color3.fromRGB(191, 191, 191)
            ChannelBtnHashtag.TextSize = 21.000

            ChannelBtnTitle.Name = "ChannelBtnTitle"
            ChannelBtnTitle.Parent = ChannelBtn
            ChannelBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ChannelBtnTitle.BackgroundTransparency = 1.000
            ChannelBtnTitle.BorderSizePixel = 0
            ChannelBtnTitle.Position = UDim2.new(0.173747092, 0, -0.166666672, 0)
            ChannelBtnTitle.Size = UDim2.new(0, 95, 0, 39)
            ChannelBtnTitle.Font = Enum.Font.Gotham
            ChannelBtnTitle.Text = text
            ChannelBtnTitle.TextColor3 = Color3.fromRGB(191, 191, 191)
            ChannelBtnTitle.TextSize = 14.000
            ChannelBtnTitle.TextXAlignment = Enum.TextXAlignment.Left
            ServerChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ServerChannelHolderLayout.AbsoluteContentSize.Y)

            local ChannelHolder = Instance.new("ScrollingFrame")
            local ChannelHolderLayout = Instance.new("UIListLayout")

            ChannelHolder.Name = "ChannelHolder"
            ChannelHolder.Parent = ChannelContentFrame
            ChannelHolder.Active = true
            ChannelHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ChannelHolder.BackgroundTransparency = 1.000
            ChannelHolder.BorderSizePixel = 0
            ChannelHolder.Position = UDim2.new(0.0360843192, 0, 0.0241984241, 0)
            ChannelHolder.Size = UDim2.new(0, 412, 0, 314)
            ChannelHolder.ScrollBarThickness = 6
            ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
            ChannelHolder.ScrollBarImageTransparency = 0
            ChannelHolder.ScrollBarImageColor3 = Color3.fromRGB(14, 1, 36)
            ChannelHolder.Visible = false
            ChannelHolder.ClipsDescendants = false

            ChannelHolderLayout.Name = "ChannelHolderLayout"
            ChannelHolderLayout.Parent = ChannelHolder
            ChannelHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ChannelHolderLayout.Padding = UDim.new(0, 6)

            ChannelBtn.MouseEnter:Connect(
                function()
                    if currentchanneltoggled ~= ChannelBtn.Name then
                        ChannelBtn.BackgroundColor3 = Color3.fromRGB(51, 50, 50)
                        ChannelBtnTitle.TextColor3 = Color3.fromRGB(220, 221, 222)
                    end
                end
            )

            ChannelBtn.MouseLeave:Connect(
                function()
                    if currentchanneltoggled ~= ChannelBtn.Name then
                        ChannelBtn.BackgroundColor3 = Color3.fromRGB(51, 50, 50)
                        ChannelBtnTitle.TextColor3 = Color3.fromRGB(191, 191, 191)
                    end
                end
            )

            ChannelBtn.MouseButton1Click:Connect(
                function()
                    for i, v in next, ChannelContentFrame:GetChildren() do
                        if v.Name == "ChannelHolder" then
                            v.Visible = false
                        end
                        ChannelHolder.Visible = true
                    end
                    for i, v in next, ServerChannelHolder:GetChildren() do
                        if v.ClassName == "TextButton" then
                            v.BackgroundColor3 = Color3.fromRGB(51, 50, 50)
                            v.ChannelBtnTitle.TextColor3 = Color3.fromRGB(191, 191, 191)
                        end
                        ServerFrame.Visible = true
                    end
                    ChannelTitle.Text = text
                    ChannelBtn.BackgroundColor3 = Color3.fromRGB(31, 30, 30)
                    ChannelBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                    currentchanneltoggled = ChannelBtn.Name
                end
            )

            if fc == false then
                fc = true
                ChannelTitle.Text = text
                ChannelBtn.BackgroundColor3 = Color3.fromRGB(31, 30, 30)
                ChannelBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                currentchanneltoggled = ChannelBtn.Name
                ChannelHolder.Visible = true
            end
            local ChannelContent = {}
            function ChannelContent:Button(text, callback)
                local Button = Instance.new("TextButton")
                local ButtonCorner = Instance.new("UICorner")

                Button.Name = "Button"
                Button.Parent = ChannelHolder
                Button.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
                Button.Size = UDim2.new(0, 401, 0, 30)
                Button.AutoButtonColor = false
                Button.Font = Enum.Font.Gotham
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.TextSize = 14.000
                Button.Text = text

                ButtonCorner.CornerRadius = UDim.new(0, 4)
                ButtonCorner.Name = "ButtonCorner"
                ButtonCorner.Parent = Button

                Button.MouseEnter:Connect(
                    function()
                        TweenService:Create(
                            Button,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(28, 28, 28)}
                        ):Play()
                    end
                )

                Button.MouseButton1Click:Connect(
                    function()
                        pcall(callback)
                        Button.TextSize = 0
                        TweenService:Create(
                            Button,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextSize = 14}
                        ):Play()
                    end
                )

                Button.MouseLeave:Connect(
                    function()
                        TweenService:Create(
                            Button,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(28, 28, 28)}
                        ):Play()
                    end
                )
                ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
            end

            function ChannelContent:Seperator()
                local Seperator1 = Instance.new("Frame")
                local Seperator2 = Instance.new("Frame")

                Seperator1.Name = "Seperator1"
                Seperator1.Parent = ChannelHolder
                Seperator1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Seperator1.BackgroundTransparency = 1.000
                Seperator1.Position = UDim2.new(0, 0, 0.350318581, 0)
                Seperator1.Size = UDim2.new(0, 100, 0, 8)

                Seperator2.Name = "Seperator2"
                Seperator2.Parent = Seperator1
                Seperator2.BackgroundColor3 = Color3.fromRGB(31, 30, 30)
                Seperator2.BorderSizePixel = 0
                Seperator2.Position = UDim2.new(0, 0, 0, 4)
                Seperator2.Size = UDim2.new(0, 401, 0, 1)
                ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
            end

            function ChannelContent:Label(text)
                local Label = Instance.new("TextButton")
                local LabelTitle = Instance.new("TextLabel")

                Label.Name = "Label"
                Label.Parent = ChannelHolder
                Label.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
                Label.BorderSizePixel = 0
                Label.Position = UDim2.new(0.261979163, 0, 0.190789461, 0)
                Label.Size = UDim2.new(0, 401, 0, 30)
                Label.AutoButtonColor = false
                Label.Font = Enum.Font.Gotham
                Label.Text = ""
                Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                Label.TextSize = 14.000

                LabelTitle.Name = "LabelTitle"
                LabelTitle.Parent = Label
                LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelTitle.BackgroundTransparency = 1.000
                LabelTitle.Position = UDim2.new(0, 5, 0, 0)
                LabelTitle.Size = UDim2.new(0, 200, 0, 30)
                LabelTitle.Font = Enum.Font.Gotham
                LabelTitle.Text = text
                LabelTitle.TextColor3 = Color3.fromRGB(191, 191, 191)
                LabelTitle.TextSize = 14.000
                LabelTitle.TextXAlignment = Enum.TextXAlignment.Left

                ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
            end

            function ChannelContent:Textbox(text, placetext, disapper, callback)
                local Textbox = Instance.new("Frame")
                local TextboxTitle = Instance.new("TextLabel")
                local TextboxFrameOutline = Instance.new("Frame")
                local TextboxFrameOutlineCorner = Instance.new("UICorner")
                local TextboxFrame = Instance.new("Frame")
                local TextboxFrameCorner = Instance.new("UICorner")
                local TextBox = Instance.new("TextBox")

                Textbox.Name = "Textbox"
                Textbox.Parent = ChannelHolder
                Textbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Textbox.BackgroundTransparency = 1.000
                Textbox.Position = UDim2.new(0.0796874985, 0, 0.445175439, 0)
                Textbox.Size = UDim2.new(0, 403, 0, 73)

                TextboxTitle.Name = "TextboxTitle"
                TextboxTitle.Parent = Textbox
                TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextboxTitle.BackgroundTransparency = 1.000
                TextboxTitle.Position = UDim2.new(0, 5, 0, 0)
                TextboxTitle.Size = UDim2.new(0, 200, 0, 29)
                TextboxTitle.Font = Enum.Font.Gotham
                TextboxTitle.Text = text
                TextboxTitle.TextColor3 = Color3.fromRGB(191, 191, 191)
                TextboxTitle.TextSize = 14.000
                TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

                TextboxFrameOutline.Name = "TextboxFrameOutline"
                TextboxFrameOutline.Parent = TextboxTitle
                TextboxFrameOutline.AnchorPoint = Vector2.new(0.5, 0.5)
                TextboxFrameOutline.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
                TextboxFrameOutline.Position = UDim2.new(0.988442957, 0, 1.6197437, 0)
                TextboxFrameOutline.Size = UDim2.new(0, 396, 0, 36)

                TextboxFrameOutlineCorner.CornerRadius = UDim.new(0, 3)
                TextboxFrameOutlineCorner.Name = "TextboxFrameOutlineCorner"
                TextboxFrameOutlineCorner.Parent = TextboxFrameOutline

                TextboxFrame.Name = "TextboxFrame"
                TextboxFrame.Parent = TextboxTitle
                TextboxFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
                TextboxFrame.ClipsDescendants = true
                TextboxFrame.Position = UDim2.new(0.00999999978, 0, 1.06638527, 0)
                TextboxFrame.Selectable = true
                TextboxFrame.Size = UDim2.new(0, 392, 0, 32)

                TextboxFrameCorner.CornerRadius = UDim.new(0, 3)
                TextboxFrameCorner.Name = "TextboxFrameCorner"
                TextboxFrameCorner.Parent = TextboxFrame

                TextBox.Parent = TextboxFrame
                TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.BackgroundTransparency = 1.000
                TextBox.Position = UDim2.new(0.0178571437, 0, 0, 0)
                TextBox.Size = UDim2.new(0, 377, 0, 32)
                TextBox.Font = Enum.Font.Gotham
                TextBox.PlaceholderColor3 = Color3.fromRGB(191, 191, 191)
                TextBox.PlaceholderText = placetext
                TextBox.Text = ""
                TextBox.TextColor3 = Color3.fromRGB(193, 195, 197)
                TextBox.TextSize = 14.000
                TextBox.TextXAlignment = Enum.TextXAlignment.Left

                TextBox.Focused:Connect(
                    function()
                        TweenService:Create(
                            TextboxFrameOutline,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(28, 28, 28)}
                        ):Play()
                    end
                )

                TextBox.FocusLost:Connect(
                    function(ep)
                        TweenService:Create(
                            TextboxFrameOutline,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(46, 46, 46)}
                        ):Play()
                        if ep then
                            if #TextBox.Text > 0 then
                                pcall(callback, TextBox.Text)
                                if disapper then
                                    TextBox.Text = ""
                                end
                            end
                        end
                    end
                )

                ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
            end

            return ChannelContent
        end

        return ChannelHold
    end
    return ServerHold
end
return DiscordLib
