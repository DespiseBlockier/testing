local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Rayfield Example Window",
    LoadingTitle = "Rayfield Interface Suite",
    LoadingSubtitle = "by Sirius",
    Theme = "Amethyst", -- Check https://docs.sirius.menu/rayfield/configuration/themes
 
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
    ["Moosewood"] = {"Merchant", "Angler", "Shipwright", "Bait Crate"},
    ["Roslit"] = {"Merchant", "Shipwright", "Blacksmith", "Angler", "Orc"},
    ["Terrapin"] = {"Shipwright", "Angler", "Tempest Totem"},
    ["Snowcap"] = {"Merchant", "Shipwright", "Windset Totem"},
    ["Mushgrove"] = {"Shipwright", "Guard", "Smokescreen Totem"},
    ["Statue/Altar"] = {"Shipwright", "Altar", "Kings Rod"},
    ["Sunstone"] = {"Merchant", "Shipwright", "Angler", "Merlin", "Sundial Totem"},
    ["Forshaken"] = {"Merchant", "Shipwright", "Jack Marrow"},
    ["Desolate Deep"] = {"Merchant", "Aurora Totem", "Mirror"},
    ["Vertigo/Depths"] = {"Synph", "Merchant", "Angler", "Rod Of The Depths"}
}

local TpInfo = {
    ["Moosewood"] = {
        ["Merchant"] = Vector3.new(466, 152, 233),
        ["Angler"] = Vector3.new(482, 152, 292),
        ["Shipwright"] = Vector3.new(371.12579345703125, 134.5, 257.9131774902344),
        ["Bait Crate"] = Vector3.new(386.3650817871094, 136.994140625, 332.92950439453125),
    },
    ["Roslit"] = {
        ["Merchant"] = Vector3.new(-1461, 135, 687),
        ["Shipwright"] = Vector3.new(-1454, 135, 739),
        ["Blacksmith"] = Vector3.new(-1515.7818603515625, 141.53482055664062, 765.197998046875),
        ["Angler"] = Vector3.new(-1701.0369873046875, 148.00003051757812, 744.76171875),
        ["Orc"] = Vector3.new(-1847.8408203125, 165.71112060546875, 159.76864624023438),
    },
    ["Terrapin"] = {
        ["Shipwright"] = Vector3.new(-193.9357452392578, 132.50003051757812, 1923.2353515625),
        ["Angler"] = Vector3.new(-190.3231658935547, 135.73648071289062, 1961.044189453125),
        ["Tempest Totem"] = Vector3.new(34.79384231567383, 132.5, 1942.04296875),
    },
    ["Snowcap"] = {
        ["Merchant"] = Vector3.new(2703.533447265625, 156.33917236328125, 2380.538818359375),
        ["Shipwright"] = Vector3.new(2611.35888671875, 135.2838592529297, 2397.1083984375),
        ["Windset Totem"] = Vector3.new(2843.06640625, 178.52365112304688, 2700.76904296875),
    },
    ["Mushgrove"] = {
        ["Shipwright"] = Vector3.new(2453.16064453125, 130.67092895507812, -666.2625732421875),
        ["Guard"] = Vector3.new(2515.72265625, 135.27984619140625, -896.5731811523438),
        ["Smokescreen Totem"] = Vector3.new(2787.776611328125, 139.8306884765625, -623.9853515625),
    },
    ["Statue/Altar"] = {
        ["Shipwright"] = Vector3.new(41.72389602661133, 133.01937866210938, -1009.7996826171875),
        ["Altar"] = Vector3.new(1306.2451171875, -805.292236328125, -100.01531982421875),
        ["Kings Rod"] = Vector3.new(1384.31640625, -807.069580078125, -305.2335205078125)
    },
    ["Sunstone"] = {
        ["Merchant"] = Vector3.new(-926.9259033203125, 131.07879638671875, -1109.68408203125),
        ["Shipwright"] = Vector3.new(-942.0650024414062, 131.0788116455078, -1116.9296875),
        ["Angler"] = Vector3.new(-891.7228393554688, 133.57223510742188, -1112.3743896484375),
        ["Merlin"] = Vector3.new(-953.3898315429688, 222.27720642089844, -989.510498046875),
        ["Sundial Totem"] = Vector3.new(-1144.8116455078125, 134.49996948242188, -1071.2076416015625),
    },
    ["Forshaken"] = {
        ["Merchant"] = Vector3.new(-2507.628173828125, 135.79074096679688, 1575.7021484375),
        ["Shipwright"] = Vector3.new(-2484.51025390625, 132.75001525878906, 1545.2064208984375),
        ["Jack Marrow"] = Vector3.new(-2823.5517578125, 214.20547485351562, 1517.5596923828125),
    },
    ["Desolate Deep"] = {
        ["Merchant"] = Vector3.new(-1660.6583251953125, -213.97946166992188, -2825.622314453125),
        ["Aurora Totem"] = Vector3.new(-1804.5361328125, -140.42144775390625, -3299.8818359375),
        ["Mirror"] = Vector3.new(-1627.9610595703125, -206.72789001464844, -2785.255126953125),
    },
    ["Vertigo/Depths"] = {
        ["Synph"] = Vector3.new(-138.6369171142578, -515.2993774414062, 1146.8233642578125),
        ["Merchant"] = Vector3.new(948.9803466796875, -711.5711669921875, 1262.763671875),
        ["Angler"] = Vector3.new(977.3062133789062, -702.93115234375, 1234.608154296875),
        ["Rod Of The Depths"] = Vector3.new(1707.447021484375, -902.527099609375, 1437.1072998046875)
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

local function TpToNpc(Location, Npc)
    if Rayfield == nil then return end
    local V3 = TpInfo[Location][Npc]
    local Character = Player.Character
    local HumanoidRootPart = Character.HumanoidRootPart
    HumanoidRootPart.CFrame = CFrame.new(V3)
end

local function createInvisibleWalls()
    if Rayfield == nil then return end
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
    if Rayfield == nil then return end
    for _, wall in ipairs(walls) do
        wall:Destroy()
    end
    walls = {}
end



local function clientSideDetection()
    if Rayfield == nil then return end
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
    if Rayfield == nil then return end
    if connection then connection:Disconnect() end
    
    connection = RunService.RenderStepped:Connect(clientSideDetection)
end

local function stopTracking()
    if Rayfield == nil then return end
    if connection then
        connection:Disconnect()
        connection = nil
    end
end



local function rod()
    if Rayfield == nil then return end
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
    if Rayfield == nil then return end
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
    if Rayfield == nil then return end
    AutoCatchOn = not AutoCatchOn
      ShowNotification("Auto Catch" ,'Status: ' .. tostring(AutoCatchOn), 5)
  end

  function RealisticAutoCatch()
    if Rayfield == nil then return end
    RealisticAutoCatchOn = not RealisticAutoCatchOn
      ShowNotification("Realistic Auto Catch" ,'Status: ' .. tostring(RealisticAutoCatchOn), 5)
  end

  function AutoCast()
    if Rayfield == nil then return end
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
    if Rayfield == nil then return end
    CenterShakeOn = not CenterShakeOn
      ShowNotification("Center Shake" ,'Status: ' .. tostring(CenterShakeOn), 5)
  end

  function ToggleAFK()
    if Rayfield == nil then return end
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
    if Rayfield == nil then return end
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
    if Rayfield == nil then return end
    if descendant.Name == "playerbar" and descendant.Parent and descendant.Parent.Name == "bar" and RealisticAutoCatchOn == true then
        startTracking()
    end
end)

LocalPlayer.PlayerGui.DescendantRemoving:Connect(function(descendant)
    if Rayfield == nil then return end
    if descendant.Name == "playerbar" and descendant.Parent and descendant.Parent.Name == "bar" then
        stopTracking()
        if AutoCastOn then
            task.wait(1)
            remote()
        end
    end
end)

LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
    if Rayfield == nil then return end
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
local Other = Window:CreateTab("Other") -- Title, Image


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
        CurrentOption = "...",
        MultipleOptions = false,
        Flag = "Moosewood_Tps", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Options)
            local Selected = table.concat(Options, "")
            TpToNpc("Moosewood", Selected)
        end,
     })

     local Roslit_Tps = Teleports:CreateDropdown({
        Name = "Roslit Tps",
        Options = NpcTp["Roslit"],
        CurrentOption = "...",
        MultipleOptions = false,
        Flag = "Roslit_Tps", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Options)
            local Selected = table.concat(Options, "")
            TpToNpc("Roslit", Selected)
        end,
     })

     local Terrapin_Tps = Teleports:CreateDropdown({
        Name = "Terrapin Tps",
        Options = NpcTp["Terrapin"],
        CurrentOption = "...",
        MultipleOptions = false,
        Flag = "Terrapin_Tps", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Options)
            local Selected = table.concat(Options, "")
            TpToNpc("Terrapin", Selected)
        end,
     })

     local Snowcap_Tps = Teleports:CreateDropdown({
        Name = "Snowcap Tps",
        Options = NpcTp["Snowcap"],
        CurrentOption = "...",
        MultipleOptions = false,
        Flag = "Snowcap_Tps", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Options)
            local Selected = table.concat(Options, "")
            TpToNpc("Snowcap", Selected)
        end,
     })

     local Mushgrove_Tps = Teleports:CreateDropdown({
        Name = "Mushgrove Tps",
        Options = NpcTp["Mushgrove"],
        CurrentOption = "...",
        MultipleOptions = false,
        Flag = "Mushgrove_Tps", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Options)
            local Selected = table.concat(Options, "")
            TpToNpc("Mushgrove", Selected)
        end,
     })

     local Statue_Altar_Tps = Teleports:CreateDropdown({
        Name = "Statue/Altar Tps",
        Options = NpcTp["Statue/Altar"],
        CurrentOption = "...",
        MultipleOptions = false,
        Flag = "Statue_Altar_Tps", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Options)
            local Selected = table.concat(Options, "")
            TpToNpc("Statue/Altar", Selected)
        end,
     })

     local Sunstone_Tps = Teleports:CreateDropdown({
        Name = "Sunstone Tps",
        Options = NpcTp["Sunstone"],
        CurrentOption = "...",
        MultipleOptions = false,
        Flag = "Sunstone_Tps", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Options)
            local Selected = table.concat(Options, "")
            TpToNpc("Sunstone", Selected)
        end,
     })

     local Forshaken_Tps = Teleports:CreateDropdown({
        Name = "Forshaken Tps",
        Options = NpcTp["Forshaken"],
        CurrentOption = "...",
        MultipleOptions = false,
        Flag = "Forshaken_Tps", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Options)
            local Selected = table.concat(Options, "")
            TpToNpc("Forshaken", Selected)
        end,
     })

     local Desolate_Deep_Tps = Teleports:CreateDropdown({
        Name = "Desolate Deep Tps",
        Options = NpcTp["Desolate Deep"],
        CurrentOption = "...",
        MultipleOptions = false,
        Flag = "Desolate_Deep_Tps", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Options)
            local Selected = table.concat(Options, "")
            TpToNpc("Desolate Deep", Selected)
        end,
     })

     local Vertigo_Depths_Tps = Teleports:CreateDropdown({
        Name = "Vertigo/Depths Tps",
        Options = NpcTp["Vertigo/Depths"],
        CurrentOption = "...",
        MultipleOptions = false,
        Flag = "Vertigo_Depths_Tps", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Options)
            local Selected = table.concat(Options, "")
            TpToNpc("Vertigo/Depths", Selected)
        end,
     })



     local InfiniteYield = Other:CreateButton({
        Name = "Infinite Yield",
        Callback = function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        end,
     })

     local ReopenScript = Other:CreateButton({
        Name = "Reopen Script",
        Callback = function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/DespiseBlockier/testing/refs/heads/main/Fisch.lua'))()
        end,
     })
