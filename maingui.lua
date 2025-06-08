
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")


local Framework = {}
Framework.__index = Framework


local Theme = {
    Background = Color3.fromRGB(15, 15, 15),
    SecondaryBackground = Color3.fromRGB(20, 20, 20),
    TertiaryBackground = Color3.fromRGB(25, 25, 25),
    Accent = Color3.fromRGB(0, 162, 255),
    AccentHover = Color3.fromRGB(30, 180, 255),
    Text = Color3.fromRGB(240, 240, 240),
    SecondaryText = Color3.fromRGB(180, 180, 180),
    TertiaryText = Color3.fromRGB(120, 120, 120),
    Success = Color3.fromRGB(0, 200, 100),
    Warning = Color3.fromRGB(255, 165, 0),
    Error = Color3.fromRGB(255, 50, 50)
}


function Framework:CreateWindow(config)
    config = config or {}
    local WindowName = config.Name or "Framework GUI"
    local ConfigurationSaving = config.ConfigurationSaving or {}
    
    local window = {
        Name = WindowName,
        Tabs = {},
        Elements = {},
        Config = ConfigurationSaving
    }

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FrameworkGUI"
    screenGui.Parent = playerGui
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 100
    

    local mainContainer = Instance.new("Frame")
    mainContainer.Name = "MainContainer"
    mainContainer.Size = UDim2.new(0, 900, 0, 550)
    mainContainer.Position = UDim2.new(0.5, -450, 0.5, -275)
    mainContainer.BackgroundColor3 = Theme.Background
    mainContainer.BorderSizePixel = 0
    mainContainer.Parent = screenGui
    

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = mainContainer
    
    local shadowFrame = Instance.new("Frame")
    shadowFrame.Name = "Shadow"
    shadowFrame.Size = UDim2.new(1, 30, 1, 30)
    shadowFrame.Position = UDim2.new(0, -15, 0, -15)
    shadowFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    shadowFrame.BackgroundTransparency = 0.7
    shadowFrame.ZIndex = -1
    shadowFrame.Parent = mainContainer
    
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 12)
    shadowCorner.Parent = shadowFrame
    
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.BackgroundColor3 = Theme.SecondaryBackground
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainContainer
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = titleBar
    
    local titleFix = Instance.new("Frame")
    titleFix.Size = UDim2.new(1, 0, 0, 12)
    titleFix.Position = UDim2.new(0, 0, 1, -12)
    titleFix.BackgroundColor3 = Theme.SecondaryBackground
    titleFix.BorderSizePixel = 0
    titleFix.Parent = titleBar
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -100, 1, 0)
    titleLabel.Position = UDim2.new(0, 20, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = WindowName
    titleLabel.TextColor3 = Theme.Text
    titleLabel.TextSize = 18
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar
    
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    minimizeBtn.Position = UDim2.new(1, -70, 0, 10)
    minimizeBtn.BackgroundColor3 = Theme.TertiaryBackground
    minimizeBtn.Text = "_"
    minimizeBtn.TextColor3 = Theme.Text
    minimizeBtn.TextSize = 16
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.BorderSizePixel = 0
    minimizeBtn.Parent = titleBar
    
    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, 6)
    minCorner.Parent = minimizeBtn
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 10)
    closeBtn.BackgroundColor3 = Theme.Error
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Color3.new(1, 1, 1)
    closeBtn.TextSize = 18
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = titleBar
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeBtn
    
    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Size = UDim2.new(0, 220, 1, -60)
    tabContainer.Position = UDim2.new(0, 10, 0, 55)
    tabContainer.BackgroundColor3 = Theme.SecondaryBackground
    tabContainer.BorderSizePixel = 0
    tabContainer.Parent = mainContainer
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tabContainer
    
    local tabScroll = Instance.new("ScrollingFrame")
    tabScroll.Size = UDim2.new(1, -10, 1, -10)
    tabScroll.Position = UDim2.new(0, 5, 0, 5)
    tabScroll.BackgroundTransparency = 1
    tabScroll.ScrollBarThickness = 4
    tabScroll.ScrollBarImageColor3 = Theme.Accent
    tabScroll.BorderSizePixel = 0
    tabScroll.Parent = tabContainer
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 5)
    tabLayout.Parent = tabScroll
    
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "ContentContainer"
    contentContainer.Size = UDim2.new(0, 650, 1, -60)
    contentContainer.Position = UDim2.new(0, 240, 0, 55)
    contentContainer.BackgroundColor3 = Theme.SecondaryBackground
    contentContainer.BorderSizePixel = 0
    contentContainer.Parent = mainContainer
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 8)
    contentCorner.Parent = contentContainer
    
    local contentScroll = Instance.new("ScrollingFrame")
    contentScroll.Size = UDim2.new(1, -20, 1, -20)
    contentScroll.Position = UDim2.new(0, 10, 0, 10)
    contentScroll.BackgroundTransparency = 1
    contentScroll.ScrollBarThickness = 4
    contentScroll.ScrollBarImageColor3 = Theme.Accent
    contentScroll.BorderSizePixel = 0
    contentScroll.Parent = contentContainer
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 10)
    contentLayout.Parent = contentScroll
    
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainContainer.Position
        end
    end)
    
    titleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainContainer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    local function addHoverEffect(button, normalColor, hoverColor)
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = normalColor}):Play()
        end)
    end
    
    addHoverEffect(minimizeBtn, Theme.TertiaryBackground, Theme.Accent)
    addHoverEffect(closeBtn, Theme.Error, Color3.fromRGB(255, 70, 70))
    
    local minimized = false
    
    minimizeBtn.MouseButton1Click:Connect(function()
        if not minimized then
            TweenService:Create(mainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0, 900, 0, 50)
            }):Play()
            minimized = true
            minimizeBtn.Text = "□"
        else
            TweenService:Create(mainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0, 900, 0, 550)
            }):Play()
            minimized = false
            minimizeBtn.Text = "_"
        end
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        TweenService:Create(mainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        
        wait(0.3)
        screenGui:Destroy()
    end)
    
    local selectedTab = nil
    local currentContent = nil
    
    function window:CreateTab(config)
        config = config or {}
        local TabName = config.Name or "Tab"
        local Icon = config.Icon or "📄"
        
        local tab = {
            Name = TabName,
            Icon = Icon,
            Elements = {}
        }
        
        local tabButton = Instance.new("TextButton")
        tabButton.Name = TabName .. "Tab"
        tabButton.Size = UDim2.new(1, 0, 0, 45)
        tabButton.BackgroundColor3 = Theme.TertiaryBackground
        tabButton.Text = "  " .. Icon .. "  " .. TabName
        tabButton.TextColor3 = Theme.SecondaryText
        tabButton.TextSize = 14
        tabButton.Font = Enum.Font.Gotham
        tabButton.TextXAlignment = Enum.TextXAlignment.Left
        tabButton.BorderSizePixel = 0
        tabButton.Parent = tabScroll
        
        local tabButtonCorner = Instance.new("UICorner")
        tabButtonCorner.CornerRadius = UDim.new(0, 8)
        tabButtonCorner.Parent = tabButton
        
        local tabContent = Instance.new("Frame")
        tabContent.Name = TabName .. "Content"
        tabContent.Size = UDim2.new(1, 0, 0, 0)
        tabContent.BackgroundTransparency = 1
        tabContent.Visible = false
        tabContent.Parent = contentScroll
        
        local tabContentLayout = Instance.new("UIListLayout")
        tabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        tabContentLayout.Padding = UDim.new(0, 8)
        tabContentLayout.Parent = tabContent
        
        local function selectTab()
            if selectedTab then
                TweenService:Create(selectedTab, TweenInfo.new(0.2), {
                    BackgroundColor3 = Theme.TertiaryBackground,
                    TextColor3 = Theme.SecondaryText
                }):Play()
                if currentContent then
                    currentContent.Visible = false
                end
            end
            
            selectedTab = tabButton
            currentContent = tabContent
            
            TweenService:Create(tabButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Theme.Accent,
                TextColor3 = Theme.Text
            }):Play()
            
            tabContent.Visible = true
        end
        
        tabButton.MouseButton1Click:Connect(selectTab)
        
        tabButton.MouseEnter:Connect(function()
            if selectedTab ~= tabButton then
                TweenService:Create(tabButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
            end
        end)
        
        tabButton.MouseLeave:Connect(function()
            if selectedTab ~= tabButton then
                TweenService:Create(tabButton, TweenInfo.new(0.2), {BackgroundColor3 = Theme.TertiaryBackground}):Play()
            end
        end)
        
        function tab:CreateSection(config)
            config = config or {}
            local SectionName = config.Name or "Section"
            
            local sectionFrame = Instance.new("Frame")
            sectionFrame.Size = UDim2.new(1, 0, 0, 35)
            sectionFrame.BackgroundTransparency = 1
            sectionFrame.Parent = tabContent
            
            local sectionLabel = Instance.new("TextLabel")
            sectionLabel.Size = UDim2.new(1, 0, 1, 0)
            sectionLabel.BackgroundTransparency = 1
            sectionLabel.Text = SectionName
            sectionLabel.TextColor3 = Theme.Text
            sectionLabel.TextSize = 16
            sectionLabel.Font = Enum.Font.GothamBold
            sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            sectionLabel.Parent = sectionFrame
            
            local underline = Instance.new("Frame")
            underline.Size = UDim2.new(0, 50, 0, 2)
            underline.Position = UDim2.new(0, 0, 1, -5)
            underline.BackgroundColor3 = Theme.Accent
            underline.BorderSizePixel = 0
            underline.Parent = sectionFrame
            
            return {}
        end
        
        function tab:CreateButton(config)
            config = config or {}
            local ButtonName = config.Name or "Button"
            local ButtonCallback = config.Callback or function() end
            
            local buttonFrame = Instance.new("Frame")
            buttonFrame.Size = UDim2.new(1, 0, 0, 45)
            buttonFrame.BackgroundColor3 = Theme.TertiaryBackground
            buttonFrame.BorderSizePixel = 0
            buttonFrame.Parent = tabContent
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 8)
            buttonCorner.Parent = buttonFrame
            
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, -10, 1, -10)
            button.Position = UDim2.new(0, 5, 0, 5)
            button.BackgroundTransparency = 1
            button.Text = ButtonName
            button.TextColor3 = Theme.Text
            button.TextSize = 14
            button.Font = Enum.Font.Gotham
            button.Parent = buttonFrame
            
            button.MouseEnter:Connect(function()
                TweenService:Create(buttonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Accent}):Play()
            end)
            
            button.MouseLeave:Connect(function()
                TweenService:Create(buttonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Theme.TertiaryBackground}):Play()
            end)
            
            button.MouseButton1Click:Connect(function()
                TweenService:Create(buttonFrame, TweenInfo.new(0.1), {BackgroundColor3 = Theme.AccentHover}):Play()
                wait(0.1)
                TweenService:Create(buttonFrame, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Accent}):Play()
                ButtonCallback()
            end)
            
            return {
                SetText = function(text)
                    button.Text = text
                end,
                SetCallback = function(callback)
                    ButtonCallback = callback
                end
            }
        end
        
        function tab:CreateToggle(config)
            config = config or {}
            local ToggleName = config.Name or "Toggle"
            local DefaultValue = config.Default or false
            local ToggleCallback = config.Callback or function() end
            
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Size = UDim2.new(1, 0, 0, 45)
            toggleFrame.BackgroundColor3 = Theme.TertiaryBackground
            toggleFrame.BorderSizePixel = 0
            toggleFrame.Parent = tabContent
            
            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 8)
            toggleCorner.Parent = toggleFrame
            
            local toggleLabel = Instance.new("TextLabel")
            toggleLabel.Size = UDim2.new(1, -60, 1, 0)
            toggleLabel.Position = UDim2.new(0, 15, 0, 0)
            toggleLabel.BackgroundTransparency = 1
            toggleLabel.Text = ToggleName
            toggleLabel.TextColor3 = Theme.Text
            toggleLabel.TextSize = 14
            toggleLabel.Font = Enum.Font.Gotham
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            toggleLabel.Parent = toggleFrame
            
            local toggleButton = Instance.new("TextButton")
            toggleButton.Size = UDim2.new(0, 40, 0, 20)
            toggleButton.Position = UDim2.new(1, -50, 0.5, -10)
            toggleButton.BackgroundColor3 = DefaultValue and Theme.Success or Color3.fromRGB(60, 60, 60)
            toggleButton.Text = ""
            toggleButton.BorderSizePixel = 0
            toggleButton.Parent = toggleFrame
            
            local toggleButtonCorner = Instance.new("UICorner")
            toggleButtonCorner.CornerRadius = UDim.new(0, 10)
            toggleButtonCorner.Parent = toggleButton
            
            local toggleCircle = Instance.new("Frame")
            toggleCircle.Size = UDim2.new(0, 16, 0, 16)
            toggleCircle.Position = DefaultValue and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
            toggleCircle.BackgroundColor3 = Color3.new(1, 1, 1)
            toggleCircle.BorderSizePixel = 0
            toggleCircle.Parent = toggleButton
            
            local circleCorner = Instance.new("UICorner")
            circleCorner.CornerRadius = UDim.new(0, 8)
            circleCorner.Parent = toggleCircle
            
            local currentValue = DefaultValue
            
            toggleButton.MouseButton1Click:Connect(function()
                currentValue = not currentValue
                
                TweenService:Create(toggleButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = currentValue and Theme.Success or Color3.fromRGB(60, 60, 60)
                }):Play()
                
                TweenService:Create(toggleCircle, TweenInfo.new(0.2), {
                    Position = currentValue and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                }):Play()
                
                ToggleCallback(currentValue)
            end)
            
            return {
                SetValue = function(value)
                    currentValue = value
                    TweenService:Create(toggleButton, TweenInfo.new(0.2), {
                        BackgroundColor3 = currentValue and Theme.Success or Color3.fromRGB(60, 60, 60)
                    }):Play()
                    
                    TweenService:Create(toggleCircle, TweenInfo.new(0.2), {
                        Position = currentValue and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                    }):Play()
                end,
                GetValue = function()
                    return currentValue
                end
            }
        end
        
        function tab:CreateSlider(config)
            config = config or {}
            local SliderName = config.Name or "Slider"
            local Min = config.Min or 0
            local Max = config.Max or 100
            local DefaultValue = config.Default or Min
            local Increment = config.Increment or 1
            local SliderCallback = config.Callback or function() end
            
            local sliderFrame = Instance.new("Frame")
            sliderFrame.Size = UDim2.new(1, 0, 0, 60)
            sliderFrame.BackgroundColor3 = Theme.TertiaryBackground
            sliderFrame.BorderSizePixel = 0
            sliderFrame.Parent = tabContent
            
            local sliderCorner = Instance.new("UICorner")
            sliderCorner.CornerRadius = UDim.new(0, 8)
            sliderCorner.Parent = sliderFrame
            
            local sliderLabel = Instance.new("TextLabel")
            sliderLabel.Size = UDim2.new(1, -80, 0, 25)
            sliderLabel.Position = UDim2.new(0, 15, 0, 5)
            sliderLabel.BackgroundTransparency = 1
            sliderLabel.Text = SliderName
            sliderLabel.TextColor3 = Theme.Text
            sliderLabel.TextSize = 14
            sliderLabel.Font = Enum.Font.Gotham
            sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            sliderLabel.Parent = sliderFrame
            
            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0, 60, 0, 25)
            valueLabel.Position = UDim2.new(1, -70, 0, 5)
            valueLabel.BackgroundTransparency = 1
            valueLabel.Text = tostring(DefaultValue)
            valueLabel.TextColor3 = Theme.Accent
            valueLabel.TextSize = 14
            valueLabel.Font = Enum.Font.GothamBold
            valueLabel.TextXAlignment = Enum.TextXAlignment.Right
            valueLabel.Parent = sliderFrame
            
            local sliderBar = Instance.new("Frame")
            sliderBar.Size = UDim2.new(1, -30, 0, 6)
            sliderBar.Position = UDim2.new(0, 15, 1, -20)
            sliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            sliderBar.BorderSizePixel = 0
            sliderBar.Parent = sliderFrame
            
            local sliderBarCorner = Instance.new("UICorner")
            sliderBarCorner.CornerRadius = UDim.new(0, 3)
            sliderBarCorner.Parent = sliderBar
            
            local sliderFill = Instance.new("Frame")
            sliderFill.Size = UDim2.new((DefaultValue - Min) / (Max - Min), 0, 1, 0)
            sliderFill.BackgroundColor3 = Theme.Accent
            sliderFill.BorderSizePixel = 0
            sliderFill.Parent = sliderBar
            
            local sliderFillCorner = Instance.new("UICorner")
            sliderFillCorner.CornerRadius = UDim.new(0, 3)
            sliderFillCorner.Parent = sliderFill
            
            local sliderHandle = Instance.new("Frame")
            sliderHandle.Size = UDim2.new(0, 16, 0, 16)
            sliderHandle.Position = UDim2.new((DefaultValue - Min) / (Max - Min), -8, 0.5, -8)
            sliderHandle.BackgroundColor3 = Theme.Text
            sliderHandle.BorderSizePixel = 0
            sliderHandle.Parent = sliderBar
            
            local handleCorner = Instance.new("UICorner")
            handleCorner.CornerRadius = UDim.new(0, 8)
            handleCorner.Parent = sliderHandle
            
            local currentValue = DefaultValue
            local dragging = false
            
            local function updateSlider(value)
                value = math.clamp(value, Min, Max)
                value = math.floor((value / Increment) + 0.5) * Increment
                
                currentValue = value
                valueLabel.Text = tostring(value)
                
                local percent = (value - Min) / (Max - Min)
                
                TweenService:Create(sliderFill, TweenInfo.new(0.1), {
                    Size = UDim2.new(percent, 0, 1, 0)
                }):Play()
                
                TweenService:Create(sliderHandle, TweenInfo.new(0.1), {
                    Position = UDim2.new(percent, -8, 0.5, -8)
                }):Play()
                
                SliderCallback(value)
            end
            
            sliderBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    local percent = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
                    local value = Min + (Max - Min) * percent
                    updateSlider(value)
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local percent = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
                    local value = Min + (Max - Min) * percent
                    updateSlider(value)
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            return {
                SetValue = function(value)
                    updateSlider(value)
                end,
                GetValue = function()
                    return currentValue
                end
            }
        end
        
        function tab:CreateTextbox(config)
            config = config or {}
            local TextboxName = config.Name or "Textbox"
            local DefaultText = config.Default or ""
            local PlaceholderText = config.PlaceholderText or "Enter text..."
            local TextboxCallback = config.Callback or function() end
            
            local textboxFrame = Instance.new("Frame")
            textboxFrame.Size = UDim2.new(1, 0, 0, 70)
            textboxFrame.BackgroundColor3 = Theme.TertiaryBackground
            textboxFrame.BorderSizePixel = 0
            textboxFrame.Parent = tabContent
            
            local textboxCorner = Instance.new("UICorner")
            textboxCorner.CornerRadius = UDim.new(0, 8)
            textboxCorner.Parent = textboxFrame
            
            local textboxLabel = Instance.new("TextLabel")
            textboxLabel.Size = UDim2.new(1, -20, 0, 25)
            textboxLabel.Position = UDim2.new(0, 15, 0, 5)
            textboxLabel.BackgroundTransparency = 1
            textboxLabel.Text = TextboxName
            textboxLabel.TextColor3 = Theme.Text
            textboxLabel.TextSize = 14
            textboxLabel.Font = Enum.Font.Gotham
            textboxLabel.TextXAlignment = Enum.TextXAlignment.Left
            textboxLabel.Parent = textboxFrame
            
            local textbox = Instance.new("TextBox")
            textbox.Size = UDim2.new(1, -30, 0, 30)
            textbox.Position = UDim2.new(0, 15, 1, -35)
            textbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            textbox.Text = DefaultText
            textbox.PlaceholderText = PlaceholderText
            textbox.TextColor3 = Theme.Text
            textbox.PlaceholderColor3 = Theme.TertiaryText
            textbox.TextSize = 14
            textbox.Font = Enum.Font.Gotham
            textbox.BorderSizePixel = 0
            textbox.ClearButtonFromCenter = true
            textbox.Parent = textboxFrame
            
            local textboxInputCorner = Instance.new("UICorner")
            textboxInputCorner.CornerRadius = UDim.new(0, 6)
            textboxInputCorner.Parent = textbox
            
            textbox.FocusEntered:Connect(function()
                TweenService:Create(textbox, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
            end)
            
            textbox.FocusLost:Connect(function()
                TweenService:Create(textbox, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
                TextboxCallback(textbox.Text)
            end)
            
            return {
                SetText = function(text)
                    textbox.Text = text
                end,
                GetText = function()
                    return textbox.Text
                end
            }
        end
        
        function tab:CreateDropdown(config)
            config = config or {}
            local DropdownName = config.Name or "Dropdown"
            local Options = config.Options or {"Option 1", "Option 2"}
            local DefaultOption = config.Default or Options[1]
            local DropdownCallback = config.Callback or function() end
            
            local dropdownFrame = Instance.new("Frame")
            dropdownFrame.Size = UDim2.new(1, 0, 0, 45)
            dropdownFrame.BackgroundColor3 = Theme.TertiaryBackground
            dropdownFrame.BorderSizePixel = 0
            dropdownFrame.Parent = tabContent
            
            local dropdownCorner = Instance.new("UICorner")
            dropdownCorner.CornerRadius = UDim.new(0, 8)
            dropdownCorner.Parent = dropdownFrame
            
            local dropdownLabel = Instance.new("TextLabel")
            dropdownLabel.Size = UDim2.new(0.4, 0, 1, 0)
            dropdownLabel.Position = UDim2.new(0, 15, 0, 0)
            dropdownLabel.BackgroundTransparency = 1
            dropdownLabel.Text = DropdownName
            dropdownLabel.TextColor3 = Theme.Text
            dropdownLabel.TextSize = 14
            dropdownLabel.Font = Enum.Font.Gotham
            dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
            dropdownLabel.Parent = dropdownFrame
            
            local dropdownButton = Instance.new("TextButton")
            dropdownButton.Size = UDim2.new(0.55, -15, 0, 30)
            dropdownButton.Position = UDim2.new(0.45, 0, 0.5, -15)
            dropdownButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            dropdownButton.Text = DefaultOption .. " ▼"
            dropdownButton.TextColor3 = Theme.Text
            dropdownButton.TextSize = 13
            dropdownButton.Font = Enum.Font.Gotham
            dropdownButton.BorderSizePixel = 0
            dropdownButton.Parent = dropdownFrame
            
            local dropdownButtonCorner = Instance.new("UICorner")
            dropdownButtonCorner.CornerRadius = UDim.new(0, 6)
            dropdownButtonCorner.Parent = dropdownButton
            
            local dropdownList = Instance.new("Frame")
            dropdownList.Size = UDim2.new(0.55, -15, 0, 0)
            dropdownList.Position = UDim2.new(0.45, 0, 1, 5)
            dropdownList.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            dropdownList.BorderSizePixel = 0
            dropdownList.Visible = false
            dropdownList.ZIndex = 10
            dropdownList.Parent = dropdownFrame
            
            local dropdownListCorner = Instance.new("UICorner")
            dropdownListCorner.CornerRadius = UDim.new(0, 6)
            dropdownListCorner.Parent = dropdownList
            
            local dropdownListLayout = Instance.new("UIListLayout")
            dropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            dropdownListLayout.Parent = dropdownList
            
            local currentValue = DefaultOption
            local isOpen = false
            
            for i, option in ipairs(Options) do
                local optionButton = Instance.new("TextButton")
                optionButton.Size = UDim2.new(1, 0, 0, 30)
                optionButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                optionButton.Text = option
                optionButton.TextColor3 = Theme.Text
                optionButton.TextSize = 13
                optionButton.Font = Enum.Font.Gotham
                optionButton.BorderSizePixel = 0
                optionButton.Parent = dropdownList
                
                if i == 1 then
                    local topCorner = Instance.new("UICorner")
                    topCorner.CornerRadius = UDim.new(0, 6)
                    topCorner.Parent = optionButton
                elseif i == #Options then
                    local bottomCorner = Instance.new("UICorner")
                    bottomCorner.CornerRadius = UDim.new(0, 6)
                    bottomCorner.Parent = optionButton
                end
                
                optionButton.MouseEnter:Connect(function()
                    TweenService:Create(optionButton, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Accent}):Play()
                end)
                
                optionButton.MouseLeave:Connect(function()
                    TweenService:Create(optionButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                end)
                
                optionButton.MouseButton1Click:Connect(function()
                    currentValue = option
                    dropdownButton.Text = option .. " ▼"
                    
                    TweenService:Create(dropdownList, TweenInfo.new(0.2), {
                        Size = UDim2.new(0.55, -15, 0, 0)
                    }):Play()
                    
                    wait(0.2)
                    dropdownList.Visible = false
                    isOpen = false
                    
                    DropdownCallback(option)
                end)
            end
            
            dropdownButton.MouseButton1Click:Connect(function()
                if not isOpen then
                    dropdownList.Visible = true
                    TweenService:Create(dropdownList, TweenInfo.new(0.2), {
                        Size = UDim2.new(0.55, -15, 0, #Options * 30)
                    }):Play()
                    dropdownButton.Text = string.gsub(dropdownButton.Text, "▼", "▲")
                    isOpen = true
                else
                    TweenService:Create(dropdownList, TweenInfo.new(0.2), {
                        Size = UDim2.new(0.55, -15, 0, 0)
                    }):Play()
                    dropdownButton.Text = string.gsub(dropdownButton.Text, "▲", "▼")
                    wait(0.2)
                    dropdownList.Visible = false
                    isOpen = false
                end
            end)
            
            return {
                SetValue = function(value)
                    currentValue = value
                    dropdownButton.Text = value .. " ▼"
                end,
                GetValue = function()
                    return currentValue
                end,
                SetOptions = function(newOptions)
                    Options = newOptions
                    -- Yeniden oluştur
                end
            }
        end
        
        function tab:CreateKeybind(config)
            config = config or {}
            local KeybindName = config.Name or "Keybind"
            local DefaultKey = config.Default or Enum.KeyCode.Q
            local KeybindCallback = config.Callback or function() end
            
            local keybindFrame = Instance.new("Frame")
            keybindFrame.Size = UDim2.new(1, 0, 0, 45)
            keybindFrame.BackgroundColor3 = Theme.TertiaryBackground
            keybindFrame.BorderSizePixel = 0
            keybindFrame.Parent = tabContent
            
            local keybindCorner = Instance.new("UICorner")
            keybindCorner.CornerRadius = UDim.new(0, 8)
            keybindCorner.Parent = keybindFrame
            
            local keybindLabel = Instance.new("TextLabel")
            keybindLabel.Size = UDim2.new(0.6, 0, 1, 0)
            keybindLabel.Position = UDim2.new(0, 15, 0, 0)
            keybindLabel.BackgroundTransparency = 1
            keybindLabel.Text = KeybindName
            keybindLabel.TextColor3 = Theme.Text
            keybindLabel.TextSize = 14
            keybindLabel.Font = Enum.Font.Gotham
            keybindLabel.TextXAlignment = Enum.TextXAlignment.Left
            keybindLabel.Parent = keybindFrame
            
            local keybindButton = Instance.new("TextButton")
            keybindButton.Size = UDim2.new(0, 80, 0, 25)
            keybindButton.Position = UDim2.new(1, -90, 0.5, -12.5)
            keybindButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            keybindButton.Text = DefaultKey.Name
            keybindButton.TextColor3 = Theme.Text
            keybindButton.TextSize = 12
            keybindButton.Font = Enum.Font.GothamBold
            keybindButton.BorderSizePixel = 0
            keybindButton.Parent = keybindFrame
            
            local keybindButtonCorner = Instance.new("UICorner")
            keybindButtonCorner.CornerRadius = UDim.new(0, 6)
            keybindButtonCorner.Parent = keybindButton
            
            local currentKey = DefaultKey
            local listening = false
            
            keybindButton.MouseButton1Click:Connect(function()
                if not listening then
                    listening = true
                    keybindButton.Text = "..."
                    keybindButton.BackgroundColor3 = Theme.Accent
                end
            end)
            
            UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                    currentKey = input.KeyCode
                    keybindButton.Text = input.KeyCode.Name
                    keybindButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    listening = false
                elseif not gameProcessed and input.KeyCode == currentKey then
                    KeybindCallback()
                end
            end)
            
            return {
                SetKey = function(key)
                    currentKey = key
                    keybindButton.Text = key.Name
                end,
                GetKey = function()
                    return currentKey
                end
            }
        end
        
        function tab:CreateColorPicker(config)
            config = config or {}
            local ColorPickerName = config.Name or "Color Picker"
            local DefaultColor = config.Default or Color3.fromRGB(255, 255, 255)
            local ColorCallback = config.Callback or function() end
            
            local colorFrame = Instance.new("Frame")
            colorFrame.Size = UDim2.new(1, 0, 0, 45)
            colorFrame.BackgroundColor3 = Theme.TertiaryBackground
            colorFrame.BorderSizePixel = 0
            colorFrame.Parent = tabContent
            
            local colorCorner = Instance.new("UICorner")
            colorCorner.CornerRadius = UDim.new(0, 8)
            colorCorner.Parent = colorFrame
            
            local colorLabel = Instance.new("TextLabel")
            colorLabel.Size = UDim2.new(0.7, 0, 1, 0)
            colorLabel.Position = UDim2.new(0, 15, 0, 0)
            colorLabel.BackgroundTransparency = 1
            colorLabel.Text = ColorPickerName
            colorLabel.TextColor3 = Theme.Text
            colorLabel.TextSize = 14
            colorLabel.Font = Enum.Font.Gotham
            colorLabel.TextXAlignment = Enum.TextXAlignment.Left
            colorLabel.Parent = colorFrame
            
            local colorDisplay = Instance.new("Frame")
            colorDisplay.Size = UDim2.new(0, 60, 0, 25)
            colorDisplay.Position = UDim2.new(1, -70, 0.5, -12.5)
            colorDisplay.BackgroundColor3 = DefaultColor
            colorDisplay.BorderSizePixel = 0
            colorDisplay.Parent = colorFrame
            
            local colorDisplayCorner = Instance.new("UICorner")
            colorDisplayCorner.CornerRadius = UDim.new(0, 6)
            colorDisplayCorner.Parent = colorDisplay
            
            local colorButton = Instance.new("TextButton")
            colorButton.Size = UDim2.new(1, 0, 1, 0)
            colorButton.BackgroundTransparency = 1
            colorButton.Text = ""
            colorButton.Parent = colorDisplay
            
            local currentColor = DefaultColor
            
            colorButton.MouseButton1Click:Connect(function()
                -- Basit renk seçici (RGB rastgele)
                local newColor = Color3.fromRGB(
                    math.random(0, 255),
                    math.random(0, 255),
                    math.random(0, 255)
                )
                currentColor = newColor
                colorDisplay.BackgroundColor3 = newColor
                ColorCallback(newColor)
            end)
            
            return {
                SetColor = function(color)
                    currentColor = color
                    colorDisplay.BackgroundColor3 = color
                end,
                GetColor = function()
                    return currentColor
                end
            }
        end
        
        function tab:CreateLabel(config)
            config = config or {}
            local LabelText = config.Text or "Label"
            
            local labelFrame = Instance.new("Frame")
            labelFrame.Size = UDim2.new(1, 0, 0, 35)
            labelFrame.BackgroundTransparency = 1
            labelFrame.Parent = tabContent
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -20, 1, 0)
            label.Position = UDim2.new(0, 10, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = LabelText
            label.TextColor3 = Theme.SecondaryText
            label.TextSize = 14
            label.Font = Enum.Font.Gotham
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextWrapped = true
            label.Parent = labelFrame
            
            return {
                SetText = function(text)
                    label.Text = text
                end,
                SetColor = function(color)
                    label.TextColor3 = color
                end
            }
        end
        
        function tab:CreateParagraph(config)
            config = config or {}
            local Title = config.Title or "Paragraph"
            local Content = config.Content or "Content"
            
            local paragraphFrame = Instance.new("Frame")
            paragraphFrame.Size = UDim2.new(1, 0, 0, 80)
            paragraphFrame.BackgroundColor3 = Theme.TertiaryBackground
            paragraphFrame.BorderSizePixel = 0
            paragraphFrame.Parent = tabContent
            
            local paragraphCorner = Instance.new("UICorner")
            paragraphCorner.CornerRadius = UDim.new(0, 8)
            paragraphCorner.Parent = paragraphFrame
            
            local titleLabel = Instance.new("TextLabel")
            titleLabel.Size = UDim2.new(1, -20, 0, 25)
            titleLabel.Position = UDim2.new(0, 10, 0, 5)
            titleLabel.BackgroundTransparency = 1
            titleLabel.Text = Title
            titleLabel.TextColor3 = Theme.Text
            titleLabel.TextSize = 16
            titleLabel.Font = Enum.Font.GothamBold
            titleLabel.TextXAlignment = Enum.TextXAlignment.Left
            titleLabel.Parent = paragraphFrame
            
            local contentLabel = Instance.new("TextLabel")
            contentLabel.Size = UDim2.new(1, -20, 0, 45)
            contentLabel.Position = UDim2.new(0, 10, 0, 30)
            contentLabel.BackgroundTransparency = 1
            contentLabel.Text = Content
            contentLabel.TextColor3 = Theme.SecondaryText
            contentLabel.TextSize = 13
            contentLabel.Font = Enum.Font.Gotham
            contentLabel.TextXAlignment = Enum.TextXAlignment.Left
            contentLabel.TextWrapped = true
            contentLabel.Parent = paragraphFrame
            
            return {
                SetTitle = function(title)
                    titleLabel.Text = title
                end,
                SetContent = function(content)
                    contentLabel.Text = content
                end
            }
        end
        
        -- İlk tab seçili yap
        if not selectedTab then
            selectTab()
        end
        
        table.insert(window.Tabs, tab)
        return tab
    end
    
    local function updateCanvasSize()
        tabScroll.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y + 10)
        if currentContent then
            local contentLayout = currentContent:FindFirstChild("UIListLayout")
            if contentLayout then
                contentScroll.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
            end
        end
    end
    
    tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)
    
    -- Bildirim sistemi
    function window:CreateNotification(config)
        config = config or {}
        local Title = config.Title or "Notification"
        local Content = config.Content or "Content"
        local Duration = config.Duration or 3
        local Image = config.Image or nil
        
        local notificationFrame = Instance.new("Frame")
        notificationFrame.Size = UDim2.new(0, 300, 0, 80)
        notificationFrame.Position = UDim2.new(1, -320, 0, 20)
        notificationFrame.BackgroundColor3 = Theme.SecondaryBackground
        notificationFrame.BorderSizePixel = 0
        notificationFrame.Parent = screenGui
        
        local notificationCorner = Instance.new("UICorner")
        notificationCorner.CornerRadius = UDim.new(0, 10)
        notificationCorner.Parent = notificationFrame
        
        local notificationTitle = Instance.new("TextLabel")
        notificationTitle.Size = UDim2.new(1, -20, 0, 25)
        notificationTitle.Position = UDim2.new(0, 10, 0, 5)
        notificationTitle.BackgroundTransparency = 1
        notificationTitle.Text = Title
        notificationTitle.TextColor3 = Theme.Text
        notificationTitle.TextSize = 14
        notificationTitle.Font = Enum.Font.GothamBold
        notificationTitle.TextXAlignment = Enum.TextXAlignment.Left
        notificationTitle.Parent = notificationFrame
        
        local notificationContent = Instance.new("TextLabel")
        notificationContent.Size = UDim2.new(1, -20, 0, 45)
        notificationContent.Position = UDim2.new(0, 10, 0, 30)
        notificationContent.BackgroundTransparency = 1
        notificationContent.Text = Content
        notificationContent.TextColor3 = Theme.SecondaryText
        notificationContent.TextSize = 12
        notificationContent.Font = Enum.Font.Gotham
        notificationContent.TextXAlignment = Enum.TextXAlignment.Left
        notificationContent.TextWrapped = true
        notificationContent.Parent = notificationFrame
        
        notificationFrame:TweenPosition(
            UDim2.new(1, -320, 0, 20),
            "Out",
            "Quad",
            0.3,
            true
        )
        
        wait(Duration)
        notificationFrame:TweenPosition(
            UDim2.new(1, 0, 0, 20),
            "In",
            "Quad",
            0.3,
            true,
            function()
                notificationFrame:Destroy()
            end
        )
    end
    
    return window
end

return Framework
