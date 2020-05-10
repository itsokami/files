if game:GetService("CoreGui"):FindFirstChild("kenOmegaAutoFarm") then
	game:GetService("CoreGui"):FindFirstChild("kenOmegaAutoFarm"):Destroy()
end

local kenOmegaAutoFarm = Instance.new("ScreenGui")
local notice = Instance.new("TextLabel")
local shadow = Instance.new("TextLabel")

kenOmegaAutoFarm.Name = "kenOmegaAutoFarm"
kenOmegaAutoFarm.Parent = game:GetService("CoreGui")

notice.Name = "notice"
notice.Parent = kenOmegaAutoFarm
notice.BackgroundColor3 = Color3.fromRGB(170, 170, 127)
notice.BackgroundTransparency = 0.750
notice.Size = UDim2.new(1, 0, 1, 0)
notice.ZIndex = 2
notice.Font = Enum.Font.SourceSansBold
notice.Text = "LOADING..."
notice.TextColor3 = Color3.fromRGB(255, 255, 255)
notice.TextSize = 50.000
notice.TextStrokeColor3 = Color3.fromRGB(170, 170, 127)
notice.TextStrokeTransparency = 0.000

shadow.Name = "shadow"
shadow.Parent = notice
shadow.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
shadow.BackgroundTransparency = 1.000
shadow.Position = UDim2.new(0, 2, 0, 2)
shadow.Size = UDim2.new(1, 0, 1, 0)
shadow.Font = Enum.Font.SourceSansBold
shadow.Text = "LOADING..."
shadow.TextColor3 = Color3.fromRGB(0, 0, 0)
shadow.TextSize = 50.000
shadow.TextStrokeColor3 = Color3.fromRGB(72, 72, 72)

notice.Text = "EXECUTED!"
shadow.Text = "EXECUTED!"

wait(1)

notice.Text = "LOADING..."
shadow.Text = "LOADING..."

delay(8, function()
	local players = game:GetService("Players")
	local teleportService = game:GetService("TeleportService")

	local player = players.LocalPlayer
	local character = player.Character

	local jobInfo = player.PlayerGui.Mission.Frame.Desc

	_G.enabled = true
	_G.disableLongJobs = true

	syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/itsokami/files/master/kenOmegaAutoFarm.lua', true))()")

	for _, child in pairs(character:GetDescendants()) do
		if child:IsA("Humanoid") and child.Name == character.Name then
			child:Destroy()
		end
	end

	notice.Text = "STARTING..."
	shadow.Text = "STARTING..."

	local function getCurrentJob()
		local currentJob
		if string.lower(jobInfo.Text):find("boulder") then
			currentJob = "boulder"
		elseif string.lower(jobInfo.Text):find("posters") then
			currentJob = "posters"
		elseif string.lower(jobInfo.Text):find("dirt") then
			currentJob = "dirt"
		elseif string.lower(jobInfo.Text):find("groceries") then
			currentJob = "groceries"
		end
		notice.Text = "CURRENT JOB: "..string.upper(currentJob)
		shadow.Text = "CURRENT JOB: "..string.upper(currentJob)
		return currentJob
	end

	while _G.enabled do
		wait()
		if player.PlayerGui.Mission.Frame.Visible == true then
			if getCurrentJob() == "boulder" then
				character.HumanoidRootPart.Anchored = false
				local boulder
				if workspace:FindFirstChild("Rusted Rock") then 
					for _, child in pairs(workspace:GetChildren()) do
					if child.Name == "Rusted Rock" and child:FindFirstChildOfClass("ObjectValue") and child:FindFirstChildOfClass("ObjectValue").Value.Name == player.Name then 
							boulder = child
						end
					end
					character.HumanoidRootPart.CFrame = boulder.CFrame * CFrame.new(0, -5, 0)
					wait(0.25)
					fireclickdetector(boulder.ClickDetector)
					wait(0.25)
					character.HumanoidRootPart.CFrame = workspace.Delivery.Part3.CFrame
				end
			elseif getCurrentJob() == "posters" then
				if _G.disableLongJobs then
					notice.Text = "RESPAWNING..."
					shadow.Text = "RESPAWNING..."
					wait(0.25)
					character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.new(0, -800, 0)
				else
					character.HumanoidRootPart.Anchored = false
					repeat 
						for _, child in pairs(workspace.Posters:GetChildren()) do
							character.HumanoidRootPart.CFrame = child.CFrame * CFrame.new(-2, 0, 0)
							wait(0.25)
							fireclickdetector(child.ClickDetector)
							repeat
								wait()
							until child.Decal.Transparency == 0 or player.PlayerGui.Mission.Frame.Visible == false
						end
					until player.PlayerGui.Mission.Frame.Visible == false
				end
			elseif getCurrentJob() == "dirt" then
				if _G.disableLongJobs then
					notice.Text = "RESPAWNING..."
					shadow.Text = "RESPAWNING..."
					wait(0.25)
					character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.new(0, -800, 0)
				else
					character.HumanoidRootPart.Anchored = false
					repeat 
						for _, child in pairs(workspace.Dirt:GetChildren()) do
							character.HumanoidRootPart.Anchored = false
							character.HumanoidRootPart.CFrame = child.CFrame * CFrame.new(0, -2, 0)
							wait(0.25)
							character.HumanoidRootPart.Anchored = true
							fireclickdetector(child.ClickDetector)
							repeat
								wait()
							until child.Decal.Transparency == 1 or player.PlayerGui.Mission.Frame.Visible == false
						end
					until player.PlayerGui.Mission.Frame.Visible == false
					character.HumanoidRootPart.Anchored = false
				end
			elseif getCurrentJob() == "groceries" then
				character.HumanoidRootPart.Anchored = false
				wait(1)
				character.HumanoidRootPart.CFrame = workspace.Delivery.Part.CFrame
			end
			wait(1)
			jobInfo.Text = ""
		else
			notice.Text = "GRABBING JOB..."
			shadow.Text = "GRABBING JOB..."
			character.HumanoidRootPart.Anchored = true
			character.HumanoidRootPart.CFrame = workspace.Corkboard.Board["Color this to paint the board"].CFrame * CFrame.new(0, -8, 0)
			wait(0.25)
			fireclickdetector(workspace.Corkboard.Board["Color this to paint the board"].ClickDetector)
		end
	end
end)
