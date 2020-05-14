if game:GetService("CoreGui"):FindFirstChild("dragonBallHunter") then
	game:GetService("CoreGui"):FindFirstChild("dragonBallHunter"):Destroy()
end

local dragonBallHunter = Instance.new("ScreenGui")
local notice = Instance.new("TextLabel")
local shadow = Instance.new("TextLabel")

dragonBallHunter.Name = "dragonBallHunter"
dragonBallHunter.Parent = game:GetService("CoreGui")

notice.Name = "notice"
notice.Parent = dragonBallHunter
notice.BackgroundColor3 = Color3.fromRGB(170, 170, 127)
notice.BackgroundTransparency = 0.750
notice.Size = UDim2.new(1, 0, 1, 0)
notice.ZIndex = 2
notice.Font = Enum.Font.SourceSansBold
notice.Text = "LOADING..."
notice.TextColor3 = Color3.fromRGB(255, 255, 255)
notice.TextSize = 50.000
notice.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
notice.TextStrokeTransparency = 0.75

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

spawn(function()
	while wait(1) do
		for _, child in pairs(game:GetDescendants()) do
			if child:IsA("Sound") then
				child.Volume = 0
				child:Stop()
			end
		end
	end
end)

delay(30, function()
	notice.Text = "STARTING..."
	shadow.Text = "STARTING..."

	local webhook = "https://discordapp.com/api/webhooks/710268887895113799/gh0eBDGqTgavgaijm93cwrX9RdDfnQHJR6YC4VhQhpMoE1DP387gbOP1k1reIfpqsgc6"

	local players = game:GetService("Players")
	local httpService = game:GetService("HttpService")
	local teleportService = game:GetService("TeleportService")
	local tweenService = game:GetService("TweenService")

	local placeId = game.PlaceId
	local jobId = game.JobId
	local teleportScript = ("Roblox.GameLauncher.joinGameInstance(%s, '%s');"):format(placeId, jobId)

	local player = players.LocalPlayer
	local character = player.Character
	if not character or not character.Parent then
		character = player.CharacterAdded:wait()
	end

	local servers = {}

	local dragonBall

	local function sendWebhook()
		local JSONTable = {
			["embeds"] = {
				{
					["title"] = dragonBall.." STAR DRAGON BALL FOUND",
					["description"] = "SCRIPT:\n```java\n// go onto a roblox page and paste this into the address bar | write 'javascript:' infront of the script\n"..teleportScript.."\n```",
					["fields"] = {},
					["color"] = 16758725
				}
			}
		}
		return syn.request({
			Url = webhook,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json"
			},
			Body = httpService:JSONEncode(JSONTable)
		})
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

	local function hasDragonBall(value)
		for _, child in pairs(player.PlayerValues:GetChildren()) do
			if child.Name == "DragonBall"..value then
				if child.Value == false then
					return false
				elseif child.Value == true then
					return true
				end
			end
		end
	end

	for _, child in pairs(player.PlayerValues:GetChildren()) do
		if child.Name:find("DragonBall") then
			print(child.Name, child.Value)
		end
	end

	game.ReplicatedStorage.RemoteEvents.PlayerFirstJoinedRemote:FireServer()

	notice.Text = "LOADING CHARACTER..."
	shadow.Text = "LOADING CHARACTER..."

	wait(5)

	notice.Text = "CHECKING FOR DRAGON BALLS..."
	shadow.Text = "CHECKING FOR DRAGON BALLS..."

	for _, child in pairs(workspace:GetChildren()) do
        if child:IsA("Model") and child.Name:find("Dragon Ball") and child.Part:FindFirstChildOfClass("ClickDetector") then
			local foundDragonBall = string.match(child.Name, "%d+")
			dragonBall = foundDragonBall
			notice.Text = foundDragonBall.." STAR DRAGON BALL IN SERVER!"
			shadow.Text = foundDragonBall.." STAR DRAGON BALL IN SERVER!"
			wait(1)
			if not hasDragonBall(foundDragonBall) then
				notice.Text = "GRABBING..."
				shadow.Text = "GRABBING..."
				repeat
					wait()
				until character:FindFirstChild("HumanoidRootPart")
				spawn(function()
					while wait() do
						fireclickdetector(child.Part:FindFirstChildOfClass("ClickDetector"))
					end
				end)
				wait(1)
				local tweenInfo = TweenInfo.new(10)
				local goal = {}
				goal.CFrame = child.Part.CFrame
				local tween = tweenService:Create(character.HumanoidRootPart, tweenInfo, goal)
				tween:Play()
				wait(10)
				notice.Text = "GRABBED!"
				shadow.Text = "GRABBED!"
			elseif hasDragonBall(foundDragonBall) then
				notice.Text = "SENDING WEBHOOK..."
				shadow.Text = "SENDING WEBHOOK..."
				sendWebhook()
			end
		end
	end

	wait(1)

	notice.Text = "TELEPORTING..."
	shadow.Text = "TELEPORTING..."

	wait(1)

	if not syn_io_isfile("projectXServerList.JSON") then
		servers = refresh()
		table.remove(servers, 1)
	else
		servers = httpService:JSONDecode(syn_io_read("projectXServerList.JSON"))
		if #servers < 1 then
			servers = refresh()
			table.remove(servers, 1)
		end
	end

	syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/itsokami/files/master/dragonBallHunter.lua', true))()")

	local function joinNextServer()
		local nextServer = table.remove(servers, 1)
		syn_io_write("projectXServerList.JSON", httpService:JSONEncode(servers))
		teleportService:TeleportToPlaceInstance(placeId, nextServer)
	end

	local function teleportFailed(playerArgument, teleportResult, errorMessage)
		if playerArgument == player then
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

	joinNextServer()
end)
