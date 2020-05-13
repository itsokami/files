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
	local httpService = game:GetService("HttpService")
	local teleportService = game:GetService("TeleportService")
	local runService = game:GetService("RunService")

	local placeId = game.PlaceId
	local jobId = game.JobId

	local player = players.LocalPlayer
	local character = player.Character

	local jobInfo = player.PlayerGui.Mission.Frame.Desc

	_G.enabled = true
	local disableLongJobs = true

	syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/itsokami/files/master/kenOmegaAutoFarm.lua', true))()")

	for _, child in pairs(character:GetDescendants()) do
		if child:IsA("Humanoid") and child.Name == character.Name then
			child:Destroy()
		end
	end

	notice.Text = "STARTING..."
	shadow.Text = "STARTING..."

	local baseplate = Instance.new("Part", workspace)
	baseplate.Anchored = true
	baseplate.CanCollide = true
	baseplate.Size = Vector3.new(1271.67, 12.82, 1136.51)
	baseplate.Position = Vector3.new(-1934.121, 76.019, 22.889)

	if workspace:FindFirstChild("Map") then
		workspace.Map:Destroy()
		for _, child in pairs(workspace:GetChildren()) do
			if child:IsA("Model") then
				child:Destroy()
			end
		end
	end

	local function refresh()
		local collectionSize = math.floor(httpService:JSONDecode(game:HttpGet("https://www.roblox.com/games/getgameinstancesjson?placeId=" .. placeId .. "&startindex=0")).TotalCollectionSize / 10) * 10
		local queue = {}
		for i = 0, collectionSize / 10 do
			local gameInstance = httpService:JSONDecode(game:HttpGet("https://www.roblox.com/games/getgameinstancesjson?placeId=" .. placeId .. "&startindex="..i * 10))
			for _, instance in next, gameInstance.Collection do
				local flag = false
				for _, nextUp in next, queue do
					if instance.Guid == nextUp then
						flag = true
					end
				end
				if instance.Guid ~= jobId and not flag then
					table.insert(queue, instance.Guid)
				end
				flag = false
			end
		end
		return queue
	end

	local function goto(x, y, z)
		local increment = 3.5
		moving = true
		if x < character.HumanoidRootPart.Position.X then
			while x < character.HumanoidRootPart.Position.X do
				wait()
				character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(character.HumanoidRootPart.Position.X - increment, character.HumanoidRootPart.Position.Y, character.HumanoidRootPart.Position.Z))
			end
		end
		if z < character.HumanoidRootPart.Position.Z then
			while z < character.HumanoidRootPart.Position.Z do
				wait()
				character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(character.HumanoidRootPart.Position.X, character.HumanoidRootPart.Position.Y, character.HumanoidRootPart.Position.Z - increment))
			end
		end
		if x > character.HumanoidRootPart.Position.X then
			while x > character.HumanoidRootPart.Position.X do
				wait()
				character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(character.HumanoidRootPart.Position.X + increment, character.HumanoidRootPart.Position.Y, character.HumanoidRootPart.Position.Z))
			end
		end
		if z > character.HumanoidRootPart.Position.Z then
			while z > character.HumanoidRootPart.Position.Z do
				wait()
				character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(character.HumanoidRootPart.Position.X, character.HumanoidRootPart.Position.Y, character.HumanoidRootPart.Position.Z + increment))
			end
		end
		if y < character.HumanoidRootPart.Position.Y then
			while y < character.HumanoidRootPart.Position.Y do
				wait()
				character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(character.HumanoidRootPart.Position.X, character.HumanoidRootPart.Position.Y - increment, character.HumanoidRootPart.Position.Z))
			end
		end
		if y > character.HumanoidRootPart.Position.Y then
			while y > character.HumanoidRootPart.Position.Y do
				wait()
				character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(character.HumanoidRootPart.Position.X, character.HumanoidRootPart.Position.Y + increment, character.HumanoidRootPart.Position.Z))
			end
		end
		moving = false
	end

	if not syn_io_isfile("kenOmegaServerList.JSON") then
		servers = refresh()
		table.remove(servers, 1)
	else
		servers = httpService:JSONDecode(syn_io_read("kenOmegaServerList.JSON"))
		if #servers < 1 then
			servers = refresh()
			table.remove(servers, 1)
		end
	end

	local function joinNextServer()
		local nextServer = table.remove(servers, 1)
		syn_io_write("kenOmegaServerList.JSON", httpService:JSONEncode(servers))
		teleportService:TeleportToPlaceInstance(placeId, nextServer)
	end

	local function teleportFailed(player, teleportResult, errorMessage)
		if player == game:GetService("Players").LocalPlayer then
			delay(1, function()
				if #servers < 1 then
					servers = refresh()
					table.remove(servers, 1)
				end
				joinNextServer()
			end)
		end
	end
	teleportService.TeleportInitFailed:Connect(teleportFailed)

	spawn(function()
		local function makeLookupTable(table)
			for i = 1, #table do
				table[table[i]] = true
			end
			return table
		end
		
		local scaryPeople = makeLookupTable({"80804680", "47557163", "3520967", "36891856", "20116884", "7292275", "30735230", "50599889", "77145788", "13089713", "14712827", "83543693", "17972598", "35387995", "36288212"})
		
		while wait() do
			for _, player in ipairs(players:GetPlayers()) do
				if scaryPeople[player.UserId] then
					joinNextServer()
					break
				end
			end
		end
	end)

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

	local function checkJob()
		if player.PlayerGui.Mission.Frame.Visible == true then
			if getCurrentJob() == "boulder" then
				local boulder
				if workspace:FindFirstChild("Rusted Rock") then 
					for _, child in pairs(workspace:GetChildren()) do
					if child.Name == "Rusted Rock" and child:FindFirstChildOfClass("ObjectValue") and child:FindFirstChildOfClass("ObjectValue").Value.Name == player.Name then 
							boulder = child
						end
					end
					goto(boulder.Position.X, boulder.Position.Y - 5, boulder.Position.Z)
					wait(0.25)
					fireclickdetector(boulder.ClickDetector)
					wait(0.25)
					goto(workspace.Delivery.Part3.Position.X, workspace.Delivery.Part3.Position.Y, workspace.Delivery.Part3.Position.Z)
				end
			elseif getCurrentJob() == "posters" then
				repeat 
					for _, child in pairs(workspace.Posters:GetChildren()) do
						goto(child.Position.X, child.Position.Y, child.Position.Z)
						wait(0.25)
						fireclickdetector(child.ClickDetector)
						repeat
							wait()
						until child.Decal.Transparency == 0 or player.PlayerGui.Mission.Frame.Visible == false
					end
				until player.PlayerGui.Mission.Frame.Visible == false
			elseif getCurrentJob() == "dirt" then
				if disableLongJobs then
					joinNextServer()
				else
					repeat 
						for _, child in pairs(workspace.Dirt:GetChildren()) do
							goto(child.Position.X, child.Position.Y, child.Position.Z)
							wait(0.25)
							fireclickdetector(child.ClickDetector)
							repeat
								wait()
							until child.Decal.Transparency == 1 or player.PlayerGui.Mission.Frame.Visible == false
						end
					until player.PlayerGui.Mission.Frame.Visible == false
				end
			elseif getCurrentJob() == "groceries" then
				wait(1)
				goto(workspace.Delivery.Part.Position.X, workspace.Delivery.Part.Position.Y, workspace.Delivery.Part.Position.Z)
			end
			wait(2.5)
			jobInfo.Text = ""
		else
			notice.Text = "GRABBING JOB..."
			shadow.Text = "GRABBING JOB..."
			goto(workspace.Corkboard.Board["Color this to paint the board"].Position.X, workspace.Corkboard.Board["Color this to paint the board"].Position.Y - 5, workspace.Corkboard.Board["Color this to paint the board"].Position.Z)
			wait(0.25)
			fireclickdetector(workspace.Corkboard.Board["Color this to paint the board"].ClickDetector)
		end
	end

	local function jobChanged()
		checkJob()
	end
	jobInfo.Changed:Connect(jobChanged)
end)
