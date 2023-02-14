if game.PlaceId == 11676335670 then
    _G.Settings = {
    ["AutoPushups"] = false,
    }

local LocalPlayer = game.Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

function AutoPushups()
    while task.wait(1) do
        if _G.Settings.AutoPushups == false then break end
        
        if not LocalPlayer.PlayerGui:FindFirstChild("PushupsGui") then
            Character.Character.input:FireServer("J", false)
        end
        
        

if game:GetService("Players").LocalPlayer.PlayerGui.PushupsGui.Pushups.Button.Text == 'A' then
   game:GetService('VirtualInputManager'):SendKeyEvent(true,'A',false,fool)
end
if game:GetService("Players").LocalPlayer.PlayerGui.PushupsGui.Pushups.Button.Text == 'T' then
   game:GetService('VirtualInputManager'):SendKeyEvent(true,'T',false,fool)
end
if game:GetService("Players").LocalPlayer.PlayerGui.PushupsGui.Pushups.Button.Text == 'Z' then
   game:GetService('VirtualInputManager'):SendKeyEvent(true,'Z',false,fool)
end
if game:GetService("Players").LocalPlayer.PlayerGui.PushupsGui.Pushups.Button.Text == 'S' then
   game:GetService('VirtualInputManager'):SendKeyEvent(true,'S',false,fool)
end
if game:GetService("Players").LocalPlayer.PlayerGui.PushupsGui.Pushups.Button.Text == 'W' then
   game:GetService('VirtualInputManager'):SendKeyEvent(true,'W',false,fool)
end
if game:GetService("Players").LocalPlayer.PlayerGui.PushupsGui.Pushups.Button.Text == 'D' then
   game:GetService('VirtualInputManager'):SendKeyEvent(true,'D',false,fool)
end
if game:GetService("Players").LocalPlayer.PlayerGui.PushupsGui.Pushups.Button.Text == 'Q' then
   game:GetService('VirtualInputManager'):SendKeyEvent(true,'Q',false,fool)
end
wait(0.5)
end
    end






local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/miroeramaa/TurtleLib/main/TurtleUiLib.lua"))()

local win = library:Window("Main - Made by blockier - V1")

win:Toggle("Auto Pushups", false, function(state)
    _G.Settings.AutoPushups = state
    
    if state then
        AutoPushups() 
    end
end)

else 
    print("join Hunter X Athena")
    
    end
