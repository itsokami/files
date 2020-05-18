warn("LOADED INGREDIENT ADD-ON!")

if game:GetService("CoreGui"):FindFirstChild("ingredientHunter") then
	game:GetService("CoreGui"):FindFirstChild("ingredientHunter"):Destroy()
end

local interface = Instance.new("ScreenGui")
local ingredientsLabel = Instance.new("TextLabel")
local shadow_2 = Instance.new("TextLabel")

interface.Name = "ingredientHunter"
interface.IgnoreGuiInset = true
interface.Parent = game:GetService("CoreGui")

ingredientsLabel.Name = "ingredients"
ingredientsLabel.Parent = interface
ingredientsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ingredientsLabel.BackgroundTransparency = 1.000
ingredientsLabel.Position = UDim2.new(0, 0, 0.25, 0)
ingredientsLabel.Size = UDim2.new(1, 0, 1, 0)
ingredientsLabel.ZIndex = 2
ingredientsLabel.Font = Enum.Font.Antique
ingredientsLabel.Text = "INGREDIENTS FOUND: 0"
ingredientsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ingredientsLabel.TextSize = 50.000
ingredientsLabel.TextStrokeColor3 = Color3.fromRGB(112, 95, 67)
ingredientsLabel.TextStrokeTransparency = 0.000

shadow_2.Name = "shadow"
shadow_2.Parent = ingredientsLabel
shadow_2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
shadow_2.BackgroundTransparency = 1.000
shadow_2.Position = UDim2.new(0, 2, 0, 2)
shadow_2.Size = UDim2.new(1, 0, 1, 0)
shadow_2.Font = Enum.Font.Antique
shadow_2.Text = "INGREDIENTS FOUND: 0"
shadow_2.TextColor3 = Color3.fromRGB(0, 0, 0)
shadow_2.TextSize = 50.000
shadow_2.TextStrokeColor3 = Color3.fromRGB(72, 72, 72)

delay(12, function()
	pcall(function()
		local httpService = game:GetService("HttpService")
		local teleportService = game:GetService("TeleportService")

		local placeId = game.PlaceId
		local jobId = game.JobId
		local teleportScript = ("Roblox.GameLauncher.joinGameInstance(%s, '%s');"):format(placeId, jobId)

		local servers = {}
		local trinketSpawns = {}
		local ingredients = {}
		
		local ingredientsFound = 0

		local isIngredient = false

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
						["title"] = "INGREDIENTS FOUND",
						["description"] = "SCRIPT:\n```java\n// go onto a roblox page and paste this into the address bar | write 'javascript:' infront of the script\n"..teleportScript.."\n```",
						["fields"] = {},
						["footer"] = {
							["text"] = "SENT FROM "..string.upper(game:GetService("Players").LocalPlayer.Name).." | "..time
						},
						["color"] = 16758725
					}
				}
			}
			if isIngredient then
				JSONTable["content"] = "<@&709587165843161128>"
			end
			for location, items in next, ingredients do
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
				Url = _G.ingredientWebhook,
				Method = "POST",
				Headers = {
					["Content-Type"] = "application/json"
				},
				Body = httpService:JSONEncode(JSONTable)
			})
		end

		for _, child in next, workspace:GetChildren() do
			if child:IsA("Folder") and child:FindFirstChild("UnionOperation") and child:FindFirstChildOfClass("UnionOperation") and child.UnionOperation:FindFirstChildOfClass("ClickDetector") then
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

		local function checkTrinket(trinket)
			local found = false
			local ingredient = "unknown ingredient"
			if trinket:IsA("UnionOperation") then
				local specialInfo = getspecialinfo(trinket)
				if getId(specialInfo.AssetId, 3293218896) and trinket.Transparency ~= 1 then
					ingredient = "desert mist"
					found = true
				elseif getId(specialInfo.AssetId, 2773353559) and trinket.Transparency ~= 1 then
					ingredient = "bloodthorn"
					found = true
				elseif getId(specialInfo.AssetId, 2766925214) and trinket.Transparency ~= 1 then
					ingredient = "crown flower"
					found = true
				end
			end
			if found then
				local location = getLocation(trinket)
				isIngredient = true
				if not ingredients[location] then
					ingredients[location] = {}
					table.insert(ingredients[location], 1, ingredient)
				else
					table.insert(ingredients[location], #ingredients[location] + 1, ingredient)
				end
				wait()
				ingredientsFound = ingredientsFound + 1
				ingredientsLabel.Text = "INGREDIENTS FOUND: "..ingredientsFound
				shadow_2.Text = "INGREDIENTS FOUND: "..ingredientsFound
			end
		end

		for _, child in next, trinketSpawns do
			if child:IsA("BasePart") then
				checkTrinket(child)
			end
		end
		
		if tableLength(ingredients) >= 1 then
			sendWebhook()
		end
	end)
end)
