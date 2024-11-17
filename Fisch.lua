local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Rayfield Example Window",
    LoadingTitle = "Rayfield Interface Suite",
    LoadingSubtitle = "by Sirius",
    Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes
 
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface
 
    ConfigurationSaving = {
       Enabled = false,
       FolderName = "Bagrogi Hub", -- Create a custom folder for your hub/game
       FileName = "Fisch"
    },
 
    Discord = {
       Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
 
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
})


-- Variables

local Players = game:GetService('Players')
local Player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local VirtualInputManager = game:GetService('VirtualInputManager')
local LocalPlayer = Players.LocalPlayer
local RealisticAutoCatchOn = false
local AutoCatchOn = false
local AutoCastOn = false
local ToggleAFKOn = false
local CenterShakeOn = false
local connection

local NpcTp = {
    ["Moosewood"] = {"Merchant", "Angler"},
    ["Roslit"] = {"Merchant", "Shipwright"}
}

local TpInfo = {
    ["Moosewood"] = {
        ["Merchant"] = Vector3.new(466, 152, 233),
        ["Angler"] = Vector3.new(482, 152, 292)
    },
    ["Roslit"] = {
        ["Merchant"] = Vector3.new(-1461, 135, 687),
        ["Shipwright"] = Vector3.new(-1454, 135, 739)
    }
}

local walls = {}
local wallHeight = 10
local wallThickness = 2
local wallLength = 4.5

function ShowNotification(title, msg, dura)
    Rayfield:Notify({
        Title = tostring(title),
        Content = tostring(msg),
        Duration = tonumber(dura),
        Image = 4483362458,
     })
end

-- Local Functions

local function createInvisibleWalls()
    local character = Player.Character
    if not character then return end

    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end

    local playerPos = rootPart.Position

    for i = 1, 4 do
        local wallPart = Instance.new("Part")
        wallPart.Size = Vector3.new(wallLength, wallHeight, wallThickness)
        wallPart.Anchored = true
        wallPart.CanCollide = true
        wallPart.Transparency = 1
        wallPart.Parent = workspace
        walls[i] = wallPart
    end

    walls[1].Position = playerPos + Vector3.new(-wallLength / 2, 0, 0)
    walls[2].Position = playerPos + Vector3.new(0, 0, wallLength / 2)
    walls[3].Position = playerPos + Vector3.new(wallLength / 2, 0, 0)
    walls[4].Position = playerPos + Vector3.new(0, 0, -wallLength / 2)

    walls[1].Orientation = Vector3.new(0, 90, 0)
    walls[2].Orientation = Vector3.new(0, 180, 0)
    walls[3].Orientation = Vector3.new(0, -90, 0)
    walls[4].Orientation = Vector3.new(0, 0, 0)
end

local function removeInvisibleWalls()
    for _, wall in ipairs(walls) do
        wall:Destroy()
    end
    walls = {}
end



local function clientSideDetection()
    local reel = LocalPlayer.PlayerGui:FindFirstChild("reel")
    if not reel then return end

    local bar = reel:FindFirstChild("bar")
    if not bar then return end

    local playerbar = bar:FindFirstChild("playerbar")
    local fish = bar:FindFirstChild("fish")
    
    if playerbar and fish then
        playerbar.Position = fish.Position
    end
end

local function startTracking()
    if connection then connection:Disconnect() end
    
    connection = RunService.RenderStepped:Connect(clientSideDetection)
end

local function stopTracking()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end



local function rod()
    if game:GetService("Players").LocalPlayer.Character:WaitForChild(game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool"), 5) then
        local rod = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool")
        rod.Parent = game:GetService("Players").LocalPlayer.Backpack
        repeat
            task.wait()
        until rod.Parent == game:GetService("Players").LocalPlayer.Backpack
        game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(rod)
    end
end

local function remote()
    local args = {
        [1] = 100
    }

    local remote = Player.Character and Player.Character:FindFirstChildOfClass("Tool") and Player.Character:FindFirstChildOfClass("Tool").events.cast
    if remote then
        remote:FireServer(unpack(args))
        rod()
    else
        warn("Unable to find the casting remote.")
    end
end

-- Toggles  

  function ToggleCatch()
    AutoCatchOn = not AutoCatchOn
      ShowNotification("Auto Catch" ,'Status: ' .. tostring(AutoCatchOn), 5)
  end

  function RealisticAutoCatch()
    RealisticAutoCatchOn = not RealisticAutoCatchOn
      ShowNotification("Realistic Auto Catch" ,'Status: ' .. tostring(RealisticAutoCatchOn), 5)
  end

  function AutoCast()
    AutoCastOn = not AutoCastOn
      ShowNotification("Auto Cast" ,'Status: ' .. tostring(AutoCastOn), 5)
      if AutoCastOn then
        createInvisibleWalls()
        remote()
    else
        removeInvisibleWalls()
    end
  end

  function CenterShake()
    CenterShakeOn = not CenterShakeOn
      ShowNotification("Center Shake" ,'Status: ' .. tostring(CenterShakeOn), 5)
  end

  function ToggleAFK()
    ToggleAFKOn = not ToggleAFKOn
    if ToggleAFKOn == true then
        game:GetService("ReplicatedStorage").events.afk.Name = "afk1"
    else
        game:GetService("ReplicatedStorage").events.afk1.Name = "afk"
    end
    ShowNotification("Toggle AFK" ,'Status: ' .. tostring(ToggleAFKOn), 5)
end



-- Connects

  LocalPlayer.PlayerGui.DescendantAdded:Connect(function(Descendant)
    if not AutoCatchOn then return end
    if Descendant.Name == 'button' and Descendant.Parent.Name == 'safezone' then
      task.wait(0.1)
      local ButtonPosition, ButtonSize = Descendant.AbsolutePosition, Descendant.AbsoluteSize
      VirtualInputManager:SendMouseButtonEvent(
        ButtonPosition.X + (ButtonSize.X / 2),
        ButtonPosition.Y + (ButtonSize.Y / 2),
        Enum.UserInputType.MouseButton1.Value,
        true,
        LocalPlayer.PlayerGui, 1
      )
      VirtualInputManager:SendMouseButtonEvent(
        ButtonPosition.X + (ButtonSize.X / 2),
        ButtonPosition.Y + (ButtonSize.Y / 2),
        Enum.UserInputType.MouseButton1.Value,
        false,
        LocalPlayer.PlayerGui, 1
      )
    elseif Descendant.Name == 'playerbar' and Descendant.Parent.Name == 'bar' then
      Descendant:GetPropertyChangedSignal('Position'):Wait()
      ReplicatedStorage.events.reelfinished:FireServer(100, true)
    end
end)

LocalPlayer.PlayerGui.DescendantAdded:Connect(function(descendant)
    if descendant.Name == "playerbar" and descendant.Parent and descendant.Parent.Name == "bar" and RealisticAutoCatchOn == true then
        startTracking()
    end
end)

LocalPlayer.PlayerGui.DescendantRemoving:Connect(function(descendant)
    if descendant.Name == "playerbar" and descendant.Parent and descendant.Parent.Name == "bar" then
        stopTracking()
        if AutoCastOn then
            task.wait(1)
            remote()
        end
    end
end)

LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
    if child.Name == "shakeui" and CenterShakeOn == true then
        child:WaitForChild("safezone").ChildAdded:Connect(function(c)
            if c.Name == "button" and CenterShakeOn == true then
                c.Position = UDim2.new(0.5, 0, 0.5, 0)
            end
        end)
    end
end)


-- Rayfield Tabs

local Main = Window:CreateTab("Main", 4483362458) -- Title, Image
local Teleports = Window:CreateTab("Tps") -- Title, Image


-- Rayfield Elements



local Auto_Catch = Main:CreateToggle({
    Name = "Auto Catch",
    CurrentValue = AutoCatchOn,
    Flag = "Auto_Catch",
    Callback = function(Value)
        ToggleCatch()
    end,
 })

 local Realistic_Auto_Catch = Main:CreateToggle({
    Name = "Realistic Auto Catch",
    CurrentValue = RealisticAutoCatchOn,
    Flag = "Realistic_Auto_Catch",
    Callback = function(Value)
        RealisticAutoCatch()
    end,
 })

 local Auto_Cast = Main:CreateToggle({
    Name = "Auto Cast",
    CurrentValue = AutoCastOn,
    Flag = "Auto_Cast",
    Callback = function(Value)
        AutoCast()
    end,
 })

 local Center_Shake = Main:CreateToggle({
    Name = "Center Shake",
    CurrentValue = CenterShakeOn,
    Flag = "Center_Shake",
    Callback = function(Value)
        CenterShake()
    end,
 })

 local Toggle_AFK = Main:CreateToggle({
    Name = "Toggle AFK",
    CurrentValue = ToggleAFKOn,
    Flag = "Toggle_AFK",
    Callback = function(Value)
        ToggleAFK()
    end,
 })

    
    local Moosewood_Tps = Teleports:CreateDropdown({
        Name = "Moosewood Tps",
        Options = NpcTp["Moosewood"],
        CurrentOption = NpcSelected,
        MultipleOptions = false,
        Flag = "Moosewood_Tps", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Options)
            local Selected = table.concat(Options, "")
        end,
     })

     local Roslit_Tps = Teleports:CreateDropdown({
        Name = "Roslit Tps",
        Options = NpcTp["Roslit"],
        CurrentOption = NpcSelected,
        MultipleOptions = false,
        Flag = "Roslit_Tps", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Options)
            local Selected = table.concat(Options, "")
        end,
     })
