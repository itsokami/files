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

		for _, child in next, workspace:GetChildren() do
			if child:IsA("Model") and child.Name:Find("Dragon Ball") then
				for _, otherChild in pairs(child:Descendants()) do
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
