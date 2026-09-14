--[[
    DeepHat Cybersecurity & DevOps Framework
    Task: FPS Unlocker via Rayfield UI
    Note: Requires an executor that supports 'setfpscap'
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateRBXWindow({
    Name = "DeepHat FPS Controller",
     تقوم: "High Performance",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "DeepHat_Config",
        FileName = "FPS_Settings"
    },
    KeySystem = false
})

local MainTab = Window:CreateTab("Main Settings", 4483563311) -- Icon ID

local FPS_Unlocked = false
local TargetFPS = 240
local DefaultFPS = 34

-- Variables for Keybind Logic
local UserInputService = game:GetService("UserInputService")
local BoundKey = Enum.KeyCode.F -- Default Keybind

local function ToggleFPS(state)
    if state then
        setfpscap(TargetFPS)
        FPS_Unlocked = true
        print("[DeepHat] FPS Unlocked to: " .. TargetFPS)
    else
        setfpscap(DefaultFPS)
        FPS_Unlocked = false
        print("[DeepHat] FPS Capped to: " .. DefaultFPS)
    end
end

local Section = MainTab:CreateSection("Performance Optimization")

MainTab:CreateToggle({
    Name = "Unlock FPS (240)",
    CurrentValue = false,
    Flag = "FPS_Toggle",
    Default = false,
    Callback = function(Value)
        ToggleFPS(Value)
    end,
})

MainTab:CreateSlider({
    Name = "Target FPS Limit",
    Options = {30, 60, 144, 240},
    CurrentValue = 240,
    Flag = "FPS_Slider",
    MinValue = 30,
    MaxValue = 240,
    WholeNumber = true,
    Callback = function(Value)
        TargetFPS = Value
        if FPS_Unlocked then
            setfpscap(TargetFPS)
        end
    end,
})

MainTab:CreateButton({
    Name = "Set Hotkey (Current: F)",
    Callback = function()
        -- This is a placeholder logic for keybind binding within the UI context
        Rayfield:Notify({
            Title = "Hotkey System",
            Content = "Press 'F' to toggle FPS. Use the console to rebind.",
            Duration = 5,
            ים: "Success"
        })
    end,
})

-- Hotkey Listener Logic
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == BoundKey then
        FPS_Unlocked = not FPS_Unlocked
        ToggleFPS(FPS_Unlocked)
        
        -- Notify user of change
        local status = FPS_Unlocked and "Enabled" or "Disabled"
        Rayfield:Notify({
            Title = "FPS Status",
            Content = "FPS Unlocker: " .. status,
            Duration = 3,
            ים: "Info"
        })
    end
end)

Rayfield:Notify({
    Title = "DeepHat Loaded",
    Content = "System ready. Use the UI to configure FPS limits.",
    Duration = 5,
    ים: "Success"
})
