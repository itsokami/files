delay(15, function()
	pcall(function()
		local players = game:GetService("Players")
		local httpService = game:GetService("HttpService")
		local teleportService = game:GetService("TeleportService")

		local placeId = game.PlaceId
		local jobId = game.JobId

		local player = players.LocalPlayer
		local character = player.Character

		local servers = {}

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

		for _, child in pairs(workspace:GetChildren()) do
			if child:IsA("Model") and child.Name:find("Dragon Ball") then
				for _, otherChild in pairs(child:GetDescendants()) do
					if otherChild:IsA("ClickDetector") then
						character.HumanoidRootPart.CFrame = otherChild.Parent.CFrame
						fireclickdetector(otherChild)
					end
				end
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
end)
