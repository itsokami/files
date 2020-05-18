pcall(function()
	local players = game:GetService("Players")
	local coreGui = game:GetService("CoreGui")

	local camera = workspace.CurrentCamera

	local localPlayer = players.LocalPlayer

	local folder = Instance.new("Folder", coreGui)
	folder.Name = "rogueEsp"

	local function round(number)
		return math.floor(number + 0.5)
	end

	local function createBillboard(player)
		local name = Instance.new("BillboardGui")
		local nameLabel = Instance.new("TextLabel")
		local healthLabel = Instance.new("TextLabel")
		local distanceLabel = Instance.new("TextLabel")
		name.Name = "name"
		name.Parent = folder
		name.Active = true
		name.AlwaysOnTop = true
		name.Size = UDim2.new(0, 500, 0, 75)
		name.StudsOffset = Vector3.new(0, -4, 0)
		nameLabel.Name = "nameLabel"
		nameLabel.Parent = name
		nameLabel.AnchorPoint = Vector2.new(0.5, 0)
		nameLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		nameLabel.BackgroundTransparency = 1.000
		nameLabel.Position = UDim2.new(0.5, 0, 0, 0)
		nameLabel.Size = UDim2.new(0, 200, 0, 50)
		nameLabel.Font = Enum.Font.SourceSansBold
		nameLabel.Text = "NAME [CHARACTER]"
		nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		nameLabel.TextSize = 20.000
		nameLabel.TextStrokeTransparency = 0.800
		healthLabel.Name = "healthLabel"
		healthLabel.Parent = name
		healthLabel.AnchorPoint = Vector2.new(0.5, 0)
		healthLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		healthLabel.BackgroundTransparency = 1.000
		healthLabel.Position = UDim2.new(0.5, 0, 0, 15)
		healthLabel.Size = UDim2.new(0, 200, 0, 50)
		healthLabel.Font = Enum.Font.SourceSansSemibold
		healthLabel.Text = "[888/888]"
		healthLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		healthLabel.TextSize = 20.000
		healthLabel.TextStrokeTransparency = 0.800
		distanceLabel.Name = "distanceLabel"
		distanceLabel.Parent = name
		distanceLabel.AnchorPoint = Vector2.new(0.5, 0)
		distanceLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		distanceLabel.BackgroundTransparency = 1.000
		distanceLabel.Position = UDim2.new(0.5, 0, 0, 30)
		distanceLabel.Size = UDim2.new(0, 200, 0, 50)
		distanceLabel.Font = Enum.Font.SourceSansSemibold
		distanceLabel.Text = "[888]"
		distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		distanceLabel.TextSize = 20.000
		distanceLabel.TextStrokeTransparency = 0.800
		if player and player.Character then
			name.Name = player.Name
			local playerInfo = player.leaderstats
			--[[local class
			if player.Backpack:FindFirstChild("Observe") then
				nameLabel.TextColor3 = Color3.fromRGB(85, 170, 127)
				healthLabel.TextColor3 = Color3.fromRGB(85, 170, 127)
				distanceLabel.TextColor3 = Color3.fromRGB(85, 170, 127)
			end]]
			if playerInfo.LastName ~= "" then
				nameLabel.Text = string.upper(player.Name.." ["..playerInfo.FirstName.Value.." "..playerInfo.LastName.Value.."]")
			else
				nameLabel.Text = string.upper(player.Name.." ["..playerInfo.FirstName.Value.."]")
			end
			nameLabel.Text = string.upper(player.Name.." ["..playerInfo.FirstName.Value.." "..playerInfo.LastName.Value.."]")
			healthLabel.Text = "["..round(player.Character.Humanoid.Health).."/"..round(player.Character.Humanoid.MaxHealth).."]"
			local function healthChanged(health)
				healthLabel.Text = "["..round(health).."/"..round(player.Character.Humanoid.MaxHealth).."]"
			end
			player.Character.Humanoid.HealthChanged:Connect(healthChanged)
			local function cameraChanged(property)
				if property == "CFrame" then
					if player.Character then
						local distance = (camera.CFrame.p - player.Character.HumanoidRootPart.Position).magnitude
						distanceLabel.Text = "["..round(distance).."]"
					end
				end
			end
			camera.Changed:Connect(cameraChanged)
			name.Adornee = player.Character.HumanoidRootPart
		end
	end

	for _, player in pairs(players:GetPlayers()) do
		if player ~= localPlayer and player.Character then
			createBillboard(player)
		end
	end

	local function playerAdded(player)
		local function characterAdded(character)
			createBillboard(player)
		end
		player.CharacterAdded:Connect(characterAdded)
	end
	players.PlayerAdded:Connect(playerAdded)

	local function playerRemoving(player)
		if folder:FindFirstChild(player.Name) then
			folder[player.Name]:Destroy()
		end
	end
	players.PlayerRemoving:Connect(playerRemoving)
end)
