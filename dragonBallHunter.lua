warn("EXECUTED")
delay(45, function()
	warn("STARTING...")
	local webhook = "https://discordapp.com/api/webhooks/710268887895113799/gh0eBDGqTgavgaijm93cwrX9RdDfnQHJR6YC4VhQhpMoE1DP387gbOP1k1reIfpqsgc6"

	local players = game:GetService("Players")
	local httpService = game:GetService("HttpService")
	local teleportService = game:GetService("TeleportService")

	local placeId = game.PlaceId
	local jobId = game.JobId

	local player = players.LocalPlayer
	local character = player.Character
	if not character or not character.Parent then
		character = player.CharacterAdded:wait()
	end

	local servers = {}

	local dragonBall

	local function sendWebhook()
		local time = os.date("*t")
		time = string.format("%02d:%02d:%02d", time.hour, time.min, time.sec) or "00:00:00"
		local JSONTable = {
			["embeds"] = {
				{
					["title"] = dragonBall.." STAR DRAGON BALL FOUND",
					["description"] = "SCRIPT:\n```java\n// go onto a roblox page and paste this into the address bar | write 'javascript:' infront of the script\n"..teleportScript.."\n```",
					["fields"] = {},
					["footer"] = {
						["text"] = "SENT FROM "..string.upper(player.Name).." | "..time
					},
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
				else
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

	wait(1)

	for _, child in pairs(workspace:GetChildren()) do
		if child:IsA("Model") and child.Name:find("Dragon Ball") then
			print("DRAGON BALL IN SERVER!")
			for _, otherChild in pairs(child:GetDescendants()) do
				if otherChild:IsA("ClickDetector") then
					local foundDragonBall = string.match(child.Name, "%d+")
					dragonBall = foundDragonBall
					print(foundDragonBall)
					if not hasDragonBall(foundDragonBall) then
						print("not owned")
						fireclickdetector(otherChild)
					elseif hasDragonBall(foundDragonBall) then
						print("is own")
						sendWebhook()
					end
				end
			end
		end
	end

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

	wait(1)

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
