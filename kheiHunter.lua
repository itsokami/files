warn("EXECUTED!")

delay(1, function()
	pcall(function()
		while wait(1) do
			local webhook = "https://discordapp.com/api/webhooks/711327628283346984/OthJfgHIZ0NdTEpTfqLhGajKJ8fb9yp22rv5nji_lRLAnrndISbhjijvGirzwyAjI_33"

			local replicatedStorage = game:GetService("ReplicatedStorage")
			local httpService = game:GetService("HttpService")
			local teleportService = game:GetService("TeleportService")
			local scriptContext = game:GetService("ScriptContext")

			local placeId = game.PlaceId
			local jobId = game.JobId
			local serverInfo = replicatedStorage.ServerInfo[jobId]

			local servers = {}
			local trinketSpawns = {}
			local artifacts = {}
			
			local isArtifact = false

			spawn(function()
				while wait() do
					for _, connection in next, getconnections(scriptContext.Error) do
						connection:Disable()
						warn("DISABLED SCRIPTCONTEXT.ERROR")
					end
				end
			end)

			local function toDHMS(seconds)
				return ("%02i:%02i:%02i:%02i"):format(seconds/86400, seconds/60^2%24, seconds/60%60, seconds%60)
			end

			local function tableLength(table)
				local count = 0
				for _ in pairs(table) do
					count = count + 1
				end
				return count
			end

			local function sendWebhook()
				local JSONTable = {
					["embeds"] = {
						{
							["title"] = "ARTIFACTS/COLLECTOR FOUND",
							["description"] = "**SERVER INFO**\nNAME: "..string.upper(serverInfo.ServerName.Value).."\nUP TIME: "..string.upper(toDHMS(serverInfo.Lifespan.Value)).."\nPLAYERS: "..tostring(#game.Players:GetPlayers()),
							["fields"] = {},
							["footer"] = {
								["text"] = "SENT FROM "..string.upper(game:GetService("Players").LocalPlayer.Name)
							},
							["color"] = 16758725
						}
					}
				}
				if isArtifact then
					JSONTable["content"] = "@everyone"
				end
				for location, items in next, artifacts do
					local item = ""
					for _, value in next, items do
						item = item..value.."\n"
					end
					table.insert(JSONTable["embeds"][1]["fields"], #JSONTable["embeds"][1]["fields"] + 1, {
						["name"] = string.upper(location),
						["value"] = string.upper(item)
					})
				end
				return syn.request({
					Url = webhook,
					Method = "POST",
					Headers = {
						["Content-Type"] = "application/json"
					},
					Body = httpService:JSONEncode(JSONTable)
				})
			end

			for _, child in next, workspace:GetChildren() do
				if child:IsA("Folder") and child:FindFirstChild("Part") and child:FindFirstChildOfClass("Part") and child.Part:FindFirstChildOfClass("ClickDetector") then
					for i, v in next, child:GetChildren() do
						table.insert(trinketSpawns, v)
					end
				end
			end

			local customLocations = {
				[1] = {
					Name = "Collector [Beach]",
					Position = Vector3.new(-834.72, 318, 272.73),
					Size = Vector3.new(250, 1, 250)
				},
				[2] = {
					Name = "Collector [Desert]",
					Position = Vector3.new(-1546.472, 433.75, 2445.547),
					Size = Vector3.new(250, 1, 250)
				},
				[3] = {
					Name = "Collector [Jungle]",
					Position = Vector3.new(-2604.726, 1178.824, 1475.935),
					Size = Vector3.new(250, 1, 250)
				},
				[4] = {
					Name = "Collector [Plains]",
					Position = Vector3.new(-1283.071, 1361.824, -2338.983),
					Size = Vector3.new(250, 1, 250)
				}
			}

			local function getLocation(object)
				local objectX = object.Position.X
				local objectY = object.Position.Y
				local objectZ = object.Position.Z
				local current = nil
				for _, area in next, workspace.AreaMarkers:GetChildren() do
					if objectZ < (area.Position.Z + area.Size.X / 2) and objectZ > (area.Position.Z - area.Size.X / 2) and objectX < (area.Position.X + area.Size.Z / 2) and objectX > (area.Position.X - area.Size.Z / 2) then
						if not current or math.abs(current.Position.Y - objectY) > math.abs(area.Position.Y - objectY) then
							current = area
						end
					end
				end
				for _, area in next, customLocations do
					if objectZ < (area.Position.Z + area.Size.X / 2) and objectZ > (area.Position.Z - area.Size.X / 2) and objectX < (area.Position.X + area.Size.Z / 2) and objectX > (area.Position.X - area.Size.Z / 2) then
						if not current or math.abs(current.Position.Y - objectY) > math.abs(area.Position.Y - objectY) then
							current = area.Name
						end
					end
				end
				return (type(current) == "string" and current) or (current and current.Name) or "???"
			end

			local function getId(idDirectory, id)
				local idDirectoryString = tostring(idDirectory)
				if idDirectoryString:find(tostring(id)) then
					return true
				end
				return false
			end

			local function checkTrinketSpawn(object)
				for _, trinketSpawn in next, trinketSpawns do
					local distance = (object.Position - trinketSpawn.Position).magnitude
					if trinketSpawn.Size == Vector3.new(1, 2, 1) and distance <= 2 then
						return true
					end
				end
				return false
			end

			local function check(trinket)
				local found = false
				local artifact = "unknown artifact"
				if trinket.Name == "Part" then
					if trinket:IsA("Part") then
						if trinket.Transparency == 1 and trinket:FindFirstChildOfClass("Attachment") and trinket:FindFirstChildOfClass("Attachment"):FindFirstChildOfClass("ParticleEmitter") and getId(trinket:FindFirstChildOfClass("Attachment"):FindFirstChildOfClass("ParticleEmitter").Texture, 1536547385) and checkTrinketSpawn(trinket) then
							artifact = "phoenix flower"
							found = true
						elseif trinket.Transparency ~= 0 and trinket.BrickColor == BrickColor.new("Hot pink") and trinket:FindFirstChildOfClass("SpecialMesh") and getId(trinket:FindFirstChildOfClass("SpecialMesh").MeshId, 2877143560) and checkTrinketSpawn(trinket) then
							artifact = "rift gem"
							found = true
						end
					elseif trinket:IsA("MeshPart") then
						if trinket.Transparency ~= 0 and trinket.BrickColor == BrickColor.new("Hot pink") and getId(trinket.MeshId, 2877143560) and checkTrinketSpawn(trinket) then
							artifact = "rift gem"
							found = true
						end
					end
				elseif trinket.Name == "DevilRoom" then
					if trinket.Transparency ~= 0 then
						artifact = "open"
						found = true
					--[[elseif trinket.Transparency == 0 then
						artifact = "closed"
						found = true]]
					end
				end
				if found then
					local location = getLocation(trinket)
					isArtifact = true --(not(artifact == "closed"))
					if not artifacts[location] then
						artifacts[location] = {}
						table.insert(artifacts[location], 1, artifact)
					else
						table.insert(artifacts[location], #artifacts[location] + 1, artifact)
					end
				end
			end
			for _, child in pairs(workspace:GetChildren()) do
				if child:IsA("BasePart") then
					check(child)
				end
			end
			
			if tableLength(artifacts) >= 1 then
				sendWebhook()
			end
		end
	end)
end)
