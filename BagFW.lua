local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
local Window = Rayfield:CreateWindow({
    Name = "Bagrogi hub",
    LoadingTitle = "Script by blockier & sancticious",
    LoadingSubtitle = "thanks to sancticious",
    ConfigurationSaving = {
       Enabled = false,
       FolderName = "Bagrogi", -- Create a custom folder for your hub/game
       FileName = "ArcaneLineage"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided",
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })

 Rayfield:Notify({
    Title = "Bagrogi",
    Content = "Thanks for using Bagrogi",
    Duration = 2.5,
    
 })
 local player = game.Players.LocalPlayer
 local Crash = false

 local Tab1 = Window:CreateTab("Main", 4483362458) -- Title, Image

 function CrashServer()
    if Crash == false then return end
    for i = 1, 20 do task.wait(0.001)
      game:GetService("Players").LocalPlayer.Character.Gear.Events.GearEvent:InvokeServer()
      if Crash == false then return end
      end
      for i,v in pairs(game:GetService("Players").LocalPlayer.Character.UpperTorso:GetChildren()) do
      if v.Name == "3dmg" then v:Destroy() end
      if v.Name == "3dmgInside" then v:Destroy()  end
      if v.Name == "3dmgShadowing" then v:Destroy()  end
      if v.Name == "Grappler" then v:Destroy()  end
      if v.Name == "GrapplerHolder" then v:Destroy()  end
      if v.Name == "GrapplerPins" then v:Destroy()  end
      if v.Name == "GrapplerShadows" then v:Destroy()  end
      if v.Name == "Main" then v:Destroy()  end
      if v.Name == "StrapHolder" then v:Destroy()  end
      if v.Name == "LBRop1" then v:Destroy()  end
      if v.Name == "RBRop1" then v:Destroy()  end
      if v.Name == "SHolderL" then v:Destroy()  end
      if v.Name == "SHolderR" then v:Destroy()  end
      if v.Name == "UpperCenter" then v:Destroy()  end
      end
      for i,v in pairs(game:GetService("Players").LocalPlayer.Character.LowerTorso:GetChildren()) do
      if v.Name == "Blade1" then v:Destroy() end
      if v.Name == "Blade2" then v:Destroy()  end
      if v.Name == "Blade3" then v:Destroy()  end
      if v.Name == "Blade4" then v:Destroy()  end
      if v.Name == "Blade5" then v:Destroy()  end
      if v.Name == "Blade6" then v:Destroy()  end
      if v.Name == "Blade7" then v:Destroy()  end
      if v.Name == "Blade8" then v:Destroy()  end
      if v.Name == "LeftStrapHolder" then v:Destroy()  end
      if v.Name == "Meshes/Scabbard (3)" then v:Destroy()  end
      if v.Name == "Meshes/Scabbard (4)" then v:Destroy()  end
      if v.Name == "Meshes/TankHolder (2)" then v:Destroy()  end
      if v.Name == "Meshes/TankHolder(1)" then v:Destroy()  end
      if v.Name == "Meshes/mechanism (7)" then v:Destroy()  end
      if v.Name == "Meshes/mechanism(6)" then v:Destroy()  end
      if v.Name == "Meshes/spring (3)" then v:Destroy()  end
      if v.Name == "Meshes/spring (4)" then v:Destroy()  end
      if v.Name == "RightStrapHolder" then v:Destroy()  end
      if v.Name == "TankL" then v:Destroy()  end
      if v.Name == "TankR" then v:Destroy()  end
      if v.Name == "LowerCenter" then v:Destroy()  end
      if v.Name == "Main" then v:Destroy()  end
      end
      for i,v in pairs(game:GetService("Players").LocalPlayer.Character.RightHand:GetChildren()) do
      if v.Name == "Blade" then v:Destroy() end
      if v.Name == "Main" then v:Destroy()  end
      if v.Name == "Meshes/Blade ejector (3)" then v:Destroy()  end
      if v.Name == "Meshes/Grip2 (3)" then v:Destroy()  end
      if v.Name == "Meshes/Tab (3)" then v:Destroy()  end
      if v.Name == "Meshes/release (3)" then v:Destroy()  end
      if v.Name == "Meshes/screws (3)" then v:Destroy()  end
      if v.Name == "Meshes/trigger (3)" then v:Destroy()  end
      if v.Name == "Meshes/triggers (3)" then v:Destroy()  end
      if v.Name == "Meshes/wire (3)" then v:Destroy()  end
      if v.Name == "Pommel" then v:Destroy()  end
      end
      for i,v in pairs(game:GetService("Players").LocalPlayer.Character.LeftHand:GetChildren()) do
      if v.Name == "Blade" then v:Destroy() end
      if v.Name == "Main" then v:Destroy()  end
      if v.Name == "Meshes/Blade ejector (2)" then v:Destroy()  end
      if v.Name == "Meshes/grip2 (2)" then v:Destroy()  end
      if v.Name == "Meshes/tab (2)" then v:Destroy()  end
      if v.Name == "Meshes/release (2)" then v:Destroy()  end
      if v.Name == "Meshes/screws (2)" then v:Destroy()  end
      if v.Name == "Meshes/trigger (2)" then v:Destroy()  end
      if v.Name == "Meshes/triggers (2)" then v:Destroy()  end
      if v.Name == "Meshes/Wire (2)" then v:Destroy()  end
      if v.Name == "Pommel" then v:Destroy()  end
      end
      return CrashServer()
 end

 local Toggle = Tab1:CreateToggle({
    Name = "Crash",
    CurrentValue = false,
    Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
      Crash = Value
      CrashServer()
    end,
 })

 local ShifterGui = game:GetService("Players").LocalPlayer.PlayerGui.ShiftersLogGui.ShiftersLogFrame.Holder.ScrollingFrame
 local shifterpath = workspace.WarriorsCandidatesFolder.ShifterHolders
 local Button = Tab1:CreateButton({
   Name = "Reveal Titans",
   Callback = function()
      Rayfield:Notify({
         Title = "Warriors Title",
         Content = 
            "Armored Titen is: ".. shifterpath.Armored.Value ..
            "\nFemale Titen is: ".. shifterpath.Female.Value..
            "\nColossal Titen is: ".. shifterpath.Colossal.Value,
         Duration = 6.5,
      })
      ShifterGui.Armored.State.Text = shifterpath.Armored.Value
      ShifterGui.Female.State.Text = shifterpath.Female.Value
      ShifterGui.Colossal.State.Text = shifterpath.Colossal.Value
      ShifterGui.Attack.State.Text = shifterpath.Attack.Value
      ShifterGui.Jaw.State.Text = shifterpath.Jaw.Value
   end,
})
