local local MyUILibrary = {}

-- Criando a UI Principal
function MyUILibrary:CreateWindow(Title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 250, 0, 300)
    Frame.Position = UDim2.new(0.5, -125, 0.3, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui

    local TitleBar = Instance.new("TextLabel")
    TitleBar.Size = UDim2.new(1, 0, 0, 25)
    TitleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TitleBar.Text = Title or "UI Library"
    TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleBar.Font = Enum.Font.SourceSansBold
    TitleBar.TextSize = 16
    TitleBar.Parent = Frame

    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 1, -30)
    Container.Position = UDim2.new(0, 0, 0, 30)
    Container.BackgroundTransparency = 1
    Container.Parent = Frame

    -- Sistema de arrastar
    local UIS = game:GetService("UserInputService")
    local Dragging, DragStart, StartPos

    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            DragStart = input.Position
            StartPos = Frame.Position
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local Delta = input.Position - DragStart
            Frame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = false
        end
    end)

    local Window = {Container = Container}

    function Window:CreateButton(Text, Callback)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, 0, 0, 40)
        Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        Button.Text = Text
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Font = Enum.Font.SourceSansBold
        Button.TextSize = 14
        Button.Parent = Container

        Button.MouseButton1Click:Connect(Callback)
    end

    function Window:CreateToggle(Text, Callback)
        local Toggle = Instance.new("TextButton")
        Toggle.Size = UDim2.new(1, 0, 0, 40)
        Toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        Toggle.Text = Text .. ": OFF"
        Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.Font = Enum.Font.SourceSansBold
        Toggle.TextSize = 14
        Toggle.Parent = Container

        local isOn = false
        Toggle.MouseButton1Click:Connect(function()
            isOn = not isOn
            Toggle.Text = Text .. ": " .. (isOn and "ON" or "OFF")
            Callback(isOn)
        end)
    end

    function Window:CreateSlider(Text, Min, Max, Callback)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, 0, 0, 40)
        Frame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        Frame.Parent = Container

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 0.5, 0)
        Label.Text = Text .. ": " .. Min
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.Font = Enum.Font.SourceSansBold
        Label.TextSize = 14
        Label.Parent = Frame

        local Slider = Instance.new("TextButton")
        Slider.Size = UDim2.new(1, 0, 0.5, 0)
        Slider.Position = UDim2.new(0, 0, 0.5, 0)
        Slider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        Slider.Text = "Arraste"
        Slider.TextColor3 = Color3.fromRGB(255, 255, 255)
        Slider.Font = Enum.Font.SourceSansBold
        Slider.TextSize = 14
        Slider.Parent = Frame

        local UIS = game:GetService("UserInputService")
        local Dragging = false

        Slider.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                Dragging = true
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local Pos = math.clamp((input.Position.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X, 0, 1)
                local Value = math.floor(Min + (Max - Min) * Pos)
                Label.Text = Text .. ": " .. Value
                Callback(Value)
            end
        end)

        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                Dragging = false
            end
        end)
    end

    function Window:CreateTextBox(Placeholder, Callback)
        local TextBox = Instance.new("TextBox")
        TextBox.Size = UDim2.new(1, 0, 0, 40)
        TextBox.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        TextBox.Text = ""
        TextBox.PlaceholderText = Placeholder
        TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextBox.Font = Enum.Font.SourceSansBold
        TextBox.TextSize = 14
        TextBox.Parent = Container

        TextBox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                Callback(TextBox.Text)
            end
        end)
    end

    return Window
end

return MyUILibrary
 = {}

-- Criando a UI Principal
function MyUILibrary:CreateWindow(Title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 250, 0, 300)
    Frame.Position = UDim2.new(0.5, -125, 0.3, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui

    local TitleBar = Instance.new("TextLabel")
    TitleBar.Size = UDim2.new(1, 0, 0, 25)
    TitleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TitleBar.Text = Title or "UI Library"
    TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleBar.Font = Enum.Font.SourceSansBold
    TitleBar.TextSize = 16
    TitleBar.Parent = Frame

    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 1, -30)
    Container.Position = UDim2.new(0, 0, 0, 30)
    Container.BackgroundTransparency = 1
    Container.Parent = Frame

    -- Sistema de arrastar
    local UIS = game:GetService("UserInputService")
    local Dragging, DragStart, StartPos

    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            DragStart = input.Position
            StartPos = Frame.Position
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local Delta = input.Position - DragStart
            Frame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = false
        end
    end)

    local Window = {Container = Container}

    function Window:CreateButton(Text, Callback)
        local Button = Instance.new("TextButton")
        Button.Size = UDim2.new(1, 0, 0, 40)
        Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        Button.Text = Text
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Font = Enum.Font.SourceSansBold
        Button.TextSize = 14
        Button.Parent = Container

        Button.MouseButton1Click:Connect(Callback)
    end

    function Window:CreateToggle(Text, Callback)
        local Toggle = Instance.new("TextButton")
        Toggle.Size = UDim2.new(1, 0, 0, 40)
        Toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        Toggle.Text = Text .. ": OFF"
        Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.Font = Enum.Font.SourceSansBold
        Toggle.TextSize = 14
        Toggle.Parent = Container

        local isOn = false
        Toggle.MouseButton1Click:Connect(function()
            isOn = not isOn
            Toggle.Text = Text .. ": " .. (isOn and "ON" or "OFF")
            Callback(isOn)
        end)
    end

    function Window:CreateSlider(Text, Min, Max, Callback)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, 0, 0, 40)
        Frame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        Frame.Parent = Container

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 0.5, 0)
        Label.Text = Text .. ": " .. Min
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.Font = Enum.Font.SourceSansBold
        Label.TextSize = 14
        Label.Parent = Frame

        local Slider = Instance.new("TextButton")
        Slider.Size = UDim2.new(1, 0, 0.5, 0)
        Slider.Position = UDim2.new(0, 0, 0.5, 0)
        Slider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        Slider.Text = "Arraste"
        Slider.TextColor3 = Color3.fromRGB(255, 255, 255)
        Slider.Font = Enum.Font.SourceSansBold
        Slider.TextSize = 14
        Slider.Parent = Frame

        local UIS = game:GetService("UserInputService")
        local Dragging = false

        Slider.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                Dragging = true
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local Pos = math.clamp((input.Position.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X, 0, 1)
                local Value = math.floor(Min + (Max - Min) * Pos)
                Label.Text = Text .. ": " .. Value
                Callback(Value)
            end
        end)

        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                Dragging = false
            end
        end)
    end

    function Window:CreateTextBox(Placeholder, Callback)
        local TextBox = Instance.new("TextBox")
        TextBox.Size = UDim2.new(1, 0, 0, 40)
        TextBox.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        TextBox.Text = ""
        TextBox.PlaceholderText = Placeholder
        TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextBox.Font = Enum.Font.SourceSansBold
        TextBox.TextSize = 14
        TextBox.Parent = Container

        TextBox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                Callback(TextBox.Text)
            end
        end)
    end

    return Window
end

return MyUILibrary
