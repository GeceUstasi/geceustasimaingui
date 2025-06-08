# 🌌 GeceUstasi Roblox Lua GUI Framework

This framework is a custom-built GUI (Graphical User Interface) system designed specifically for use in Roblox exploit environments. It provides a clean, modular, and extendable structure for creating user interfaces in Roblox scripts.

## 🚀 Features

* **Easy to Use:** Intuitive API for quickly building UIs.
* **Modular Design:** Tabs, sections, and components for organized interfaces.
* **Advanced Components:** Includes color pickers, sliders, ESP system, and more.
* **Configuration Saving:** Save GUI settings and auto-load on next run.

---

## 📥 Installation

```lua
local Framework = loadstring(game:HttpGet("https://raw.githubusercontent.com/GeceUstasi/geceustasimaingui/refs/heads/main/maingui.lua"))()
```

---

## 🪟 Creating the Main Window

```lua
local Window = Framework:CreateWindow({
    Name = "My GUI",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MyGUI",
        FileName = "Config"
    }
})
```

---

## 🗂️ Creating Tabs and Sections

```lua
local Tab = Window:CreateTab({
    Name = "Main Tab",
    Icon = "🏠"
})

Tab:CreateSection({Name = "Player Features"})
```

---

## 🧩 Available Components

### 🔘 Button

```lua
Tab:CreateButton({
    Name = "Speed Hack",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
    end
})
```

### 🔁 Toggle

```lua
Tab:CreateToggle({
    Name = "Speed Toggle",
    Default = false,
    Callback = function(Value)
        if Value then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
        else
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
})
```

### 🎚 Slider

```lua
Tab:CreateSlider({
    Name = "Speed Amount",
    Min = 16,
    Max = 200,
    Default = 50,
    Increment = 1,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})
```

### ✏️ Textbox

```lua
Tab:CreateTextbox({
    Name = "Teleport To",
    Default = "Spawn",
    Callback = function(Value)
        print("Teleport to:", Value)
    end
})
```

### 🔽 Dropdown

```lua
Tab:CreateDropdown({
    Name = "Team Selector",
    Options = {"Red", "Blue", "Green"},
    Default = "Red",
    Callback = function(Value)
        print("Team selected:", Value)
    end
})
```

### 🎮 Keybind

```lua
Tab:CreateKeybind({
    Name = "Fly Toggle",
    Default = Enum.KeyCode.F,
    Callback = function()
        print("Fly toggled!")
    end
})
```

### 🎨 ColorPicker

```lua
Tab:CreateColorPicker({
    Name = "ESP Color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(Color)
        print("New color:", Color)
    end
})
```

### 🏷 Label

```lua
Tab:CreateLabel({
    Name = "FPS Boost Enabled"
})
```

### 📄 Paragraph

```lua
Tab:CreateParagraph({
    Title = "Information",
    Content = "This script works only in specific games."
})
```

---

## 🧠 ESP System

### Example Usage:

```lua
local EspTab = Window:CreateTab({
    Name = "ESP",
    Icon = "🔍"
})

local espEnabled = false
local espColor = Color3.fromRGB(255, 0, 0)

EspTab:CreateToggle({
    Name = "Enable ESP",
    Default = false,
    Callback = function(Value)
        espEnabled = Value
    end
})

EspTab:CreateColorPicker({
    Name = "ESP Color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(Color)
        espColor = Color
    end
})

-- Draw ESP every frame
game:GetService("RunService").RenderStepped:Connect(function()
    if espEnabled then
        for _, model in ipairs(workspace:WaitForChild("Loot"):GetChildren()) do
            local handle = model:FindFirstChild("Handle")
            if handle and not handle:FindFirstChild("ESPBox") then
                local box = Instance.new("BoxHandleAdornment")
                box.Name = "ESPBox"
                box.Adornee = handle
                box.Size = handle.Size
                box.Color3 = espColor
                box.AlwaysOnTop = true
                box.ZIndex = 1
                box.Transparency = 0.3
                box.Parent = handle

                local name = Instance.new("BillboardGui")
                name.Name = "ESPName"
                name.AlwaysOnTop = true
                name.Size = UDim2.new(0, 100, 0, 30)
                name.Adornee = handle

                local text = Instance.new("TextLabel")
                text.Text = model.Name
                text.Size = UDim2.new(1, 0, 1, 0)
                text.TextColor3 = espColor
                text.BackgroundTransparency = 1
                text.TextScaled = true
                text.Parent = name

                name.Parent = handle
            end
        end
    end
end)
```

---

## 🔔 Notifications

```lua
Window:CreateNotification({
    Title = "GUI Loaded!",
    Content = "Framework successfully loaded.",
    Duration = 5
})
```

---

## 📎 License

This framework is publicly available for educational and personal use. Commercial or malicious use is discouraged.

> Developed by [GeceUstasi](https://github.com/GeceUstasi) – happy scripting!
