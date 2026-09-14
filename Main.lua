--[[
    DeepHat FPS Cycle Controller
    Cycles through: 60 -> 34 -> 240 -> 60...
    Hotkey: 'F'
]]

local UserInputService = game:GetService("UserInputService")

-- Configuration
local FPS_MODES = {60, 34, 240} -- The sequence of FPS caps
local HOTKEY = Enum.KeyCode.F   -- The key to trigger the cycle
local DEBUG_MODE = true        -- Set to false to hide console logs

-- State Tracking
local currentModeIndex = 1

local function CycleFPS()
    -- Update the index (moves to next, or resets to 1 if at the end)
    currentModeIndex = currentModeIndex + 1
    if currentModeIndex > #FPS_MODES then
        currentModeIndex = 1
    end

    local targetFPS = FPS_MODES[currentModeIndex]
    
    -- Apply the FPS cap
    local success, err = pcall(function()
        setfpscap(targetFPS)
    end)

    if success then
        if DEBUG_MODE then
            print("[DeepHat] FPS Cycled to: " .. targetFPS)
        end
    else
        warn("[DeepHat] Failed to set FPS: " .. tostring(err))
    end
end

-- Input Listener
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    -- gameProcessed prevents the cycle from triggering while typing in chat
    if not gameProcessed and input.KeyCode == HOTKEY then
        CycleFPS()
    end
end)

-- Initial Setup
setfpscap(FPS_MODES[1]) -- Starts at 60
if DEBUG_MODE then
    print("[DeepHat] System Ready.")
    print("[DeepHat] Press '" .. HOTKEY.Name .. "' to cycle: " .. table.concat(FPS_MODES, " -> "))
end
