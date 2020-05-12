if game:GetService("CoreGui"):FindFirstChild("artifactHunter") then
	game:GetService("CoreGui"):FindFirstChild("artifactHunter"):Destroy()
end

local interface = Instance.new("ScreenGui")
local notice = Instance.new("TextLabel")
local shadow = Instance.new("TextLabel")
local artifactsLabel = Instance.new("TextLabel")
local shadow_2 = Instance.new("TextLabel")

interface.Name = "artifactHunter"
interface.IgnoreGuiInset = true
interface.Parent = game:GetService("CoreGui")

notice.Name = "notice"
notice.Parent = interface
notice.BackgroundColor3 = Color3.fromRGB(112, 95, 67)
notice.BackgroundTransparency = 0.750
notice.Size = UDim2.new(1, 0, 1, 0)
notice.ZIndex = 2
notice.Font = Enum.Font.Antique
notice.Text = "LOADING..."
notice.TextColor3 = Color3.fromRGB(255, 255, 255)
notice.TextSize = 50.000
notice.TextStrokeColor3 = Color3.fromRGB(112, 95, 67)
notice.TextStrokeTransparency = 0.000

shadow.Name = "shadow"
shadow.Parent = notice
shadow.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
shadow.BackgroundTransparency = 1.000
shadow.Position = UDim2.new(0, 2, 0, 2)
shadow.Size = UDim2.new(1, 0, 1, 0)
shadow.Font = Enum.Font.Antique
shadow.Text = "LOADING..."
shadow.TextColor3 = Color3.fromRGB(0, 0, 0)
shadow.TextSize = 50.000
shadow.TextStrokeColor3 = Color3.fromRGB(72, 72, 72)

artifactsLabel.Name = "artifacts"
artifactsLabel.Parent = interface
artifactsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
artifactsLabel.BackgroundTransparency = 1.000
artifactsLabel.Position = UDim2.new(0, 0, 0.15, 0)
artifactsLabel.Size = UDim2.new(1, 0, 1, 0)
artifactsLabel.ZIndex = 2
artifactsLabel.Font = Enum.Font.Antique
artifactsLabel.Text = "ARTIFACTS FOUND: 0"
artifactsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
artifactsLabel.TextSize = 50.000
artifactsLabel.TextStrokeColor3 = Color3.fromRGB(112, 95, 67)
artifactsLabel.TextStrokeTransparency = 0.000

shadow_2.Name = "shadow"
shadow_2.Parent = artifactsLabel
shadow_2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
shadow_2.BackgroundTransparency = 1.000
shadow_2.Position = UDim2.new(0, 2, 0, 2)
shadow_2.Size = UDim2.new(1, 0, 1, 0)
shadow_2.Font = Enum.Font.Antique
shadow_2.Text = "ARTIFACTS FOUND: 0"
shadow_2.TextColor3 = Color3.fromRGB(0, 0, 0)
shadow_2.TextSize = 50.000
shadow_2.TextStrokeColor3 = Color3.fromRGB(72, 72, 72)

notice.Text = "EXECUTED!"
shadow.Text = "EXECUTED!"

wait(1)

notice.Text = "LOADING ADD-ONS..."
shadow.Text = "LOADING ADD-ONS..."

pcall(function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/itsokami/files/master/gemHunter.lua', true))()
end)

pcall(function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/itsokami/files/master/ingredientHunter.lua', true))()
end)

wait(1)

notice.Text = "WAITING FOR GAME..."
shadow.Text = "WAITING FOR GAME..."

delay(10, function()
	pcall(function()
		local webhook = "https://discordapp.com/api/webhooks/706296789170388992/34HlmzyT16NEDGxGoz_RZgU6yLW2wyYtsd2GSexCKnbmaas0yn0jT5cGBc6sWMKrktvS"

		local httpService = game:GetService("HttpService")
		local teleportService = game:GetService("TeleportService")
		local scriptContext = game:GetService("ScriptContext")

		local placeId = game.PlaceId
		local jobId = game.JobId
		local teleportScript = ("Roblox.GameLauncher.joinGameInstance(%s, '%s');"):format(placeId, jobId)

		local servers = {}
		local trinketSpawns = {}
		local artifacts = {}
		
		local artifactsFound = 0

		local isArtifact = false
		local isPhoenixDown = false

		spawn(function()
			while wait() do
				for _, connection in next, getconnections(scriptContext.Error) do
					connection:Disable()
					warn("DISABLED SCRIPTCONTEXT.ERROR")
				end
			end
		end)

		notice.Text = "STARTING..."
		shadow.Text = "STARTING..."

		local function tableLength(table)
			local count = 0
			for _ in pairs(table) do
				count = count + 1
			end
			return count
		end

		local function sendWebhook()
			notice.Text = "SENDING WEBHOOK..."
			shadow.Text = "SENDING WEBHOOK..."
			local time = os.date("*t")
			time = string.format("%02d:%02d:%02d", time.hour, time.min, time.sec) or "00:00:00"
			local JSONTable = {
				["embeds"] = {
					{
						["title"] = "ARTIFACTS FOUND",
						["description"] = "SCRIPT:\n```java\n// go onto a roblox page and paste this into the address bar | write 'javascript:' infront of the script\n"..teleportScript.."\n```",
						["fields"] = {},
						["footer"] = {
							["text"] = "SENT FROM "..string.upper(game:GetService("Players").LocalPlayer.Name).." | "..time
						},
						["color"] = 16758725
					}
				}
			}
			if isArtifact then
				JSONTable["content"] = "@everyone"
			elseif isPhoenixDown then
				JSONTable["content"] = "<@&708888760648990751>"
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
			wait(1)
			notice.Text = "WEBHOOK SENT!"
			shadow.Text = "WEBHOOK SENT!"
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
		
		for _, child in next, workspace:GetChildren() do
			if child:IsA("Folder") and child:FindFirstChild("Part") and child:FindFirstChildOfClass("Part") and child.Part:FindFirstChildOfClass("ClickDetector") then
				for i, v in next, child:GetChildren() do
					table.insert(trinketSpawns, v)
				end
			end
		end

		local customLocations = {
			[1] = {
				Name = "The Snowfields [Dragon's Pit]",
				Position = Vector3.new(4581.53, 951.794, 1553.19),
				Size = Vector3.new(997, 1, 535.5)
			},
			[2] = {
				Name = "The Snowfields [Snap Tower]",
				Position = Vector3.new(3840.531, 662.794, -41.31),
				Size = Vector3.new(274, 1, 139.5)
			},
			[3] = {
				Name = "The Snowfields [Yeti]",
				Position = Vector3.new(6560.631, 1016.994, -872.109),
				Size = Vector3.new(467.2, 1, 682.6)
			},
			[4] = {
				Name = "Temple of Fire [Serpent's Cave]",
				Position = Vector3.new(3971.392, 628.794, -1009.217),
				Size = Vector3.new(190, 1, 341.5)
			},
			[5] = {
				Name = "Sea of Dust [Sewer]",
				Position = Vector3.new(-2674.305, 665.555, 138.061),
				Size = Vector3.new(278, 1, 326)
			},
			[6] = {
				Name = "Bait Area",
				Position = Vector3.new(958.5, 135.966, -666),
				Size = Vector3.new(345, 1, 346)
			},
			[7] = {
				Name = "Castle Sanctuary",
				Position = Vector3.new(6500.03, 1822.294, -45.31),
				Size = Vector3.new(714, 1, 961)
			},
			[8] = {
				Name = "Castle Sanctuary [Sigil Tower]",
				Position = Vector3.new(6585.03, 1496.794, 470.19),
				Size = Vector3.new(137, 1, 129)
			},
			[9] = {
				Name = "The Sleeping Snail [Rooftop]",
				Position = Vector3.new(5772.53, 1441.794, 875.69),
				Size = Vector3.new(24, 1, 19.5)
			},
			[10] = {
				Name = "Mount Gelu [Ragash's Den]",
				Position = Vector3.new(5848.03, 1367.294, -707.31),
				Size = Vector3.new(312, 1, 197)
			},
			[11] = {
				Name = "Dragon's Pit [Above Campfire]",
				Position = Vector3.new(4898.03, 1027.794, 1373.19),
				Size = Vector3.new(89, 1, 94.5)
			},
			[12] = {
				Name = "The Snowfields [Necromancer Church]",
				Position = Vector3.new(4228.03, 761.794, -51.31),
				Size = Vector3.new(134, 1, 152.5)
			},
			[13] = {
				Name = "The Snowfields [Tree Closest to Necromancer Church]",
				Position = Vector3.new(4182.53, 836.794, -171.31),
				Size = Vector3.new(40, 1, 37.5)
			},
			[14] = {
				Name = "Sea of Dust [Ruins]",
				Position = Vector3.new(-1893.309, 392.543, 581.618),
				Size = Vector3.new(368.75, 1, 425.24)
			},
			[15] = {
				Name = "Sea of Dust [Necromancer Church]",
				Position = Vector3.new(-2582.146, 697.174, -116.128),
				Size = Vector3.new(353, 1, 272.4)
			},
			[16] = {
				Name = "The Burial Grounds [Tower]",
				Position = Vector3.new(-1170.858, 905.174, 2640.583),
				Size = Vector3.new(169, 1, 175.4)
			},
			[17] = {
				Name = "The Burial Grounds [Front Set of Bones]",
				Position = Vector3.new(-1353.353, 522.759, 1330.553),
				Size = Vector3.new(423.32, 0.05, 313.85)
			},
			[18] = {
				Name = "The Burial Grounds [Back Set of Bones]",
				Position = Vector3.new(-867.559, 470.349, 2088.947),
				Size = Vector3.new(423.32, 0.05, 313.85)
			},
			[19] = {
				Name = "The Sunken Passage [Acorn Cave]",
				Position = Vector3.new(1228.495, 219.153, -3714.536),
				Size = Vector3.new(105.99, 1, 148.42)
			},
			[20] = {
				Name = "The Sunken Passage [Evil Eye Pit]",
				Position = Vector3.new(1103.537, 233.551, -3483.626),
				Size = Vector3.new(146.61, 1, 148.42)
			},
			[21] = {
				Name = "Royal Wood [Treehouse]",
				Position = Vector3.new(2408.157, 354.931, 859.099),
				Size = Vector3.new(200.5, 1, 224.91)
			},
			[22] = {
				Name = "Castle Rock [Lab]",
				Position = Vector3.new(5787.864, 430.589, 622.816),
				Size = Vector3.new(293.34, 1, 226.25)
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
				if trinketSpawn.Size == Vector3.new(2, 2, 2) and distance <= 2 then
					return true
				end
				if trinketSpawn.Size == Vector3.new(1, 2, 1) and distance <= 2 then
					return false
				end
			end
			return false
		end

		local function checkTrinket(trinket)
			local found = false
			local artifact = "unknown artifact"
			if trinket.Name == "Part" then
				if trinket:IsA("Part") then
					if trinket.Transparency == 1 and trinket:FindFirstChildOfClass("Attachment") and trinket:FindFirstChildOfClass("Attachment"):FindFirstChildOfClass("ParticleEmitter") and getId(trinket:FindFirstChildOfClass("Attachment"):FindFirstChildOfClass("ParticleEmitter").Texture, 1536547385) and checkTrinketSpawn(trinket) then
						artifact = "phoenix down"
						isPhoenixDown = true
						found = true
					elseif trinket.Transparency == 1 and trinket:FindFirstChildOfClass("PointLight") and trinket:FindFirstChildOfClass("PointLight").Color == Color3.fromRGB(132, 255, 0) and checkTrinketSpawn(trinket) then
						artifact = "ice essence"
						found = true
					elseif trinket.Transparency == 0 and trinket:FindFirstChild("coldpart") and trinket:FindFirstChildOfClass("SpecialMesh") and trinket:FindFirstChildOfClass("SpecialMesh").MeshType == Enum.MeshType.Sphere and checkTrinketSpawn(trinket) then
						artifact = "fairfrozen"
						found = true
					elseif trinket.Transparency ~= 0 and trinket.BrickColor == BrickColor.new("Hot pink") and trinket:FindFirstChildOfClass("SpecialMesh") and getId(trinket:FindFirstChildOfClass("SpecialMesh").MeshId, 2877143560) and checkTrinketSpawn(trinket) then
						artifact = "rift gem"
						found = true
					end
					if trinket.Transparency == 1 and trinket:FindFirstChildOfClass("Attachment") and trinket:FindFirstChildOfClass("Attachment"):FindFirstChildOfClass("ParticleEmitter") and getId(trinket:FindFirstChildOfClass("Attachment"):FindFirstChildOfClass("ParticleEmitter").Texture, 1536547385) and not checkTrinketSpawn(trinket) then
						artifact = "phoenix down (bait)"
						found = true
					elseif trinket.Transparency == 1 and trinket:FindFirstChildOfClass("PointLight") and trinket:FindFirstChildOfClass("PointLight").Color == Color3.fromRGB(132, 255, 0) and not trinket:FindFirstChildOfClass("SpecialMesh") and not checkTrinketSpawn(trinket) then
						artifact = "ice essence (bait)"
						found = true
					elseif trinket.Transparency == 0 and trinket:FindFirstChild("coldpart") and trinket:FindFirstChildOfClass("SpecialMesh") and trinket:FindFirstChildOfClass("SpecialMesh").MeshType == Enum.MeshType.Sphere and not checkTrinketSpawn(trinket) then
						artifact = "fairfrozen (bait)"
						found = true
					elseif trinket.Transparency ~= 0 and trinket.BrickColor == BrickColor.new("Hot pink") and trinket:FindFirstChildOfClass("SpecialMesh") and getId(trinket:FindFirstChildOfClass("SpecialMesh").MeshId, 2877143560) and not checkTrinketSpawn(trinket) then
						artifact = "rift gem (bait)"
						found = true
					end
				elseif trinket:IsA("UnionOperation") then
					local specialInfo = getspecialinfo(trinket)
					if getId(specialInfo.AssetId, 2784136660) and trinket.Transparency == 1 and checkTrinketSpawn(trinket) then
						artifact = "spider cloak"
						found = true
					elseif getId(specialInfo.AssetId, 2784136660) and trinket.Transparency == 0 and trinket.BrickColor ~= BrickColor.new("Persimmon") and checkTrinketSpawn(trinket) then
						artifact = "nightstone"
						found = true
					elseif getId(specialInfo.AssetId, 2784136660) and trinket.Transparency == 0 and trinket.BrickColor == BrickColor.new("Persimmon") and checkTrinketSpawn(trinket) then
						artifact = "philosopher's stone"
						found = true
					elseif getId(specialInfo.AssetId, 2998499856) and checkTrinketSpawn(trinket) then
						artifact = "lannis amulet"
						found = true
					elseif getId(specialInfo.AssetId, 3158350180) and checkTrinketSpawn(trinket) then
						artifact = "amulet of the white king"
						found = true
					elseif getId(specialInfo.AssetId, 3173538928) and checkTrinketSpawn(trinket) then
						artifact = "scroom key"
						found = true
					end
					if getId(specialInfo.AssetId, 2784136660) and trinket.Transparency == 1 and not checkTrinketSpawn(trinket) then
						artifact = "spider cloak (bait)"
						found = true
					elseif getId(specialInfo.AssetId, 2784136660) and trinket.Transparency == 0 and trinket.BrickColor ~= BrickColor.new("Persimmon") and not checkTrinketSpawn(trinket) then
						artifact = "nightstone (bait)"
						found = true
					elseif getId(specialInfo.AssetId, 2784136660) and trinket.Transparency == 0 and trinket.BrickColor == BrickColor.new("Persimmon") and not checkTrinketSpawn(trinket) then
						artifact = "philosopher's stone (bait)"
						found = true
					elseif getId(specialInfo.AssetId, 2998499856) and not checkTrinketSpawn(trinket) then
						artifact = "lannis amulet (bait)"
						found = true
					elseif getId(specialInfo.AssetId, 3158350180) and not checkTrinketSpawn(trinket) then
						artifact = "amulet of the white king (bait)"
						found = true
					elseif getId(specialInfo.AssetId, 3173538928) and not checkTrinketSpawn(trinket) then
						artifact = "scroom key (bait)"
						found = true
					end
				elseif trinket:IsA("MeshPart") then
					if getId(trinket.MeshId, 2520762076) and checkTrinketSpawn(trinket) then
						artifact = "howler friend"
						found = true
					end
					if getId(trinket.MeshId, 2520762076) and not checkTrinketSpawn(trinket) then
						artifact = "howler friend (bait)"
						found = true
					end
				end
			end
			if found then
				local location = getLocation(trinket)
				if location == "???" then
					location = "Castle in the Sky"
				end
				isArtifact = (not (artifact == "phoenix down" or artifact == "phoenix down (bait)" or artifact == "ice essence (bait)" or artifact == "fairfrozen (bait)" or artifact == "rift gem (bait)" or artifact == "spider cloak (bait)" or artifact == "nightstone (bait)" or artifact == "philosopher's stone (bait)" or artifact == "lannis amulet (bait)" or artifact == "amulet of the white king (bait)" or artifact == "scroom key (bait)" or artifact == "howler friend (bait)"))
				if not artifacts[location] then
					artifacts[location] = {}
					table.insert(artifacts[location], 1, artifact)
				else
					table.insert(artifacts[location], #artifacts[location] + 1, artifact)
				end
				wait(0.25)
				artifactsFound = artifactsFound + 1
				artifactsLabel.Text = "ARTIFACTS FOUND: "..artifactsFound
				shadow_2.Text = "ARTIFACTS FOUND: "..artifactsFound
			end
		end

		if not syn_io_isfile("rogueLineageServerList.JSON") then
			servers = refresh()
			table.remove(servers, 1)
		else
			servers = httpService:JSONDecode(syn_io_read("rogueLineageServerList.JSON"))
			if #servers < 1 then
				servers = refresh()
				table.remove(servers, 1)
			end
		end

		wait(1)

		notice.Text = "CHECKING TRINKET SPAWNS..."
		shadow.Text = "CHECKING TRINKET SPAWNS..."

		for _, child in next, workspace:GetChildren() do
			if child:IsA("BasePart") then
				checkTrinket(child)
			end
		end

		wait(1)

		notice.Text = "TRINKET SPAWNS CHECKED!"
		shadow.Text = "TRINKET SPAWNS CHECKED!"
		
		if tableLength(artifacts) >= 1 then
			sendWebhook()
		end

		wait(1)

		notice.Text = "CHECKING SERVERS..."
		shadow.Text = "CHECKING SERVERS..."

		wait(1)

		notice.Text = "TELEPORTING TO NEXT SERVER..."
		shadow.Text = "TELEPORTING TO NEXT SERVER..."

		syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/itsokami/files/master/artifactHunter.lua', true))()")

		local function joinNextServer()
			warn("UPDATING SERVERS...")
			local nextServer = table.remove(servers, 1)
			syn_io_write("rogueLineageServerList.JSON", httpService:JSONEncode(servers))
			teleportService:TeleportToPlaceInstance(3016661674, nextServer)
			warn("SERVERS UPDATED!")
		end

		local function teleportFailed(player, teleportResult, errorMessage)
			if player == game:GetService("Players").LocalPlayer then
				warn("TELEPORT FAILED!")
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
