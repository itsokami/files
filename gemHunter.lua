warn("LOADED GEM ADD-ON!")

if game:GetService("CoreGui"):FindFirstChild("gemHunter") then
	game:GetService("CoreGui"):FindFirstChild("gemHunter"):Destroy()
end

local interface = Instance.new("ScreenGui")
local gemsLabel = Instance.new("TextLabel")
local shadow_2 = Instance.new("TextLabel")

interface.Name = "gemHunter"
interface.IgnoreGuiInset = true
interface.Parent = game:GetService("CoreGui")

gemsLabel.Name = "gems"
gemsLabel.Parent = interface
gemsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
gemsLabel.BackgroundTransparency = 1.000
gemsLabel.Position = UDim2.new(0, 0, 0.3, 0)
gemsLabel.Size = UDim2.new(1, 0, 1, 0)
gemsLabel.ZIndex = 2
gemsLabel.Font = Enum.Font.Antique
gemsLabel.Text = "GEMS FOUND: 0"
gemsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
gemsLabel.TextSize = 50.000
gemsLabel.TextStrokeColor3 = Color3.fromRGB(112, 95, 67)
gemsLabel.TextStrokeTransparency = 0.000

shadow_2.Name = "shadow"
shadow_2.Parent = gemsLabel
shadow_2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
shadow_2.BackgroundTransparency = 1.000
shadow_2.Position = UDim2.new(0, 2, 0, 2)
shadow_2.Size = UDim2.new(1, 0, 1, 0)
shadow_2.Font = Enum.Font.Antique
shadow_2.Text = "GEMS FOUND: 0"
shadow_2.TextColor3 = Color3.fromRGB(0, 0, 0)
shadow_2.TextSize = 50.000
shadow_2.TextStrokeColor3 = Color3.fromRGB(72, 72, 72)

delay(10, function()
	pcall(function()
		local webhook = "https://discordapp.com/api/webhooks/709278075774435349/Bgg6Uzx-bnMw4hYeUE6933J0lkzJvemW2ZPiehOAkAsF7hR6XArRrr74AwVTI-goBXjP"

		local httpService = game:GetService("HttpService")
		local teleportService = game:GetService("TeleportService")

		local placeId = game.PlaceId
		local jobId = game.JobId
		local teleportScript = ("Roblox.GameLauncher.joinGameInstance(%s, '%s');"):format(placeId, jobId)

		local servers = {}
		local trinketSpawns = {}
		local gems = {}
		
		local gemsFound = 0

		local isGem = false

		teleportService:SetTeleportSetting("Teleport", false)

		local function tableLength(table)
			local count = 0
			for _ in pairs(table) do
				count = count + 1
			end
			return count
		end

		local function sendWebhook()
			local time = os.date("*t")
			time = string.format("%02d:%02d:%02d", time.hour, time.min, time.sec) or "00:00:00"
			local JSONTable = {
				["embeds"] = {
					{
						["title"] = "GEMS FOUND",
						["description"] = "SCRIPT:\n```java\n// go onto a roblox page and paste this into the address bar | write 'javascript:' infront of the script\n"..teleportScript.."\n```",
						["fields"] = {},
						["footer"] = {
							["text"] = "SENT FROM "..string.upper(game:GetService("Players").LocalPlayer.Name).." | "..time
						},
						["color"] = 16758725
					}
				}
			}
			if isGem then
				JSONTable["content"] = "<@&709265976457166869>"
			end
			for location, items in next, gems do
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
			local gem = "unknown gem"
			if trinket.Name == "Part" then
				if trinket:IsA("Part") then
					if trinket.Transparency ~= 0 and trinket.BrickColor == BrickColor.new("Forest green") and trinket:FindFirstChildOfClass("SpecialMesh") and getId(trinket:FindFirstChildOfClass("SpecialMesh").MeshId, 2877143560) and checkTrinketSpawn(trinket) then
						gem = "emerald"
						found = true
					elseif trinket.Transparency ~= 0 and trinket.BrickColor == BrickColor.new("Lapis") and trinket:FindFirstChildOfClass("SpecialMesh") and getId(trinket:FindFirstChildOfClass("SpecialMesh").MeshId, 2877143560) and checkTrinketSpawn(trinket) then
						gem = "sapphire"
						found = true
					elseif trinket.Transparency ~= 0 and trinket.BrickColor ~= BrickColor.new("Hot pink") and trinket.BrickColor ~= BrickColor.new("Forest green") and trinket.BrickColor ~= BrickColor.new("Lapis") and trinket.BrickColor ~= BrickColor.new("Cadet blue") and trinket:FindFirstChildOfClass("SpecialMesh") and getId(trinket:FindFirstChildOfClass("SpecialMesh").MeshId, 2877143560) and checkTrinketSpawn(trinket) then
						gem = "ruby"
						found = true
					elseif trinket.Transparency ~= 0 and trinket.BrickColor == BrickColor.new("Cadet blue") and trinket:FindFirstChildOfClass("SpecialMesh") and getId(trinket:FindFirstChildOfClass("SpecialMesh").MeshId, 2877143560) and checkTrinketSpawn(trinket) then
						gem = "diamond"
						found = true
					end
					if trinket.Transparency ~= 0 and trinket.BrickColor == BrickColor.new("Forest green") and trinket:FindFirstChildOfClass("SpecialMesh") and getId(trinket:FindFirstChildOfClass("SpecialMesh").MeshId, 2877143560) and not checkTrinketSpawn(trinket) then
						gem = "emerald (bait)"
						found = true
					elseif trinket.Transparency ~= 0 and trinket.BrickColor == BrickColor.new("Lapis") and trinket:FindFirstChildOfClass("SpecialMesh") and getId(trinket:FindFirstChildOfClass("SpecialMesh").MeshId, 2877143560) and not checkTrinketSpawn(trinket) then
						gem = "sapphire (bait)"
						found = true
					elseif trinket.Transparency ~= 0 and trinket.BrickColor ~= BrickColor.new("Hot pink") and trinket.BrickColor ~= BrickColor.new("Forest green") and trinket.BrickColor ~= BrickColor.new("Lapis") and trinket.BrickColor ~= BrickColor.new("Cadet blue") and trinket:FindFirstChildOfClass("SpecialMesh") and getId(trinket:FindFirstChildOfClass("SpecialMesh").MeshId, 2877143560) and not checkTrinketSpawn(trinket) then
						gem = "ruby (bait)"
						found = true
					elseif trinket.Transparency ~= 0 and trinket.BrickColor == BrickColor.new("Cadet blue") and trinket:FindFirstChildOfClass("SpecialMesh") and getId(trinket:FindFirstChildOfClass("SpecialMesh").MeshId, 2877143560) and not checkTrinketSpawn(trinket) then
						gem = "diamond (bait)"
						found = true
					end
				end
			end
			if found then
				local location = getLocation(trinket)
				if location == "???" then
					location = "Castle in the Sky"
				end
				isGem = (not (gem == "emerald (bait)" or gem == "sapphire (bait)" or gem == "ruby (bait)" or gem == "diamond (bait)"))
				if not gems[location] then
					gems[location] = {}
					table.insert(gems[location], 1, gem)
				else
					table.insert(gems[location], #gems[location] + 1, gem)
				end
				wait(0.25)
				gemsFound = gemsFound + 1
				gemsLabel.Text = "GEMS FOUND: "..gemsFound
				shadow_2.Text = "GEMS FOUND: "..gemsFound
			end
		end

		for _, child in next, workspace:GetChildren() do
			if child:IsA("BasePart") then
				checkTrinket(child)
			end
		end
		
		if tableLength(gems) >= 1 then
			sendWebhook()
		end
	end)
end)
