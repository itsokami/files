_G.DraggerCircleColor = Color3.fromRGB(255, 150, 255)
_G.SliderColor = Color3.fromRGB(255, 150, 255)
_G.ToggleColor = Color3.fromRGB(255, 150, 255)
_G.ButtonColor = Color3.fromRGB(255, 150, 255)

_G.itemFarm = true
_G.foundItem = false
_G.grabbingItem = false

local players = game:GetService("Players")

local player = players.LocalPlayer
local character = player.Character

local mouse = player:GetMouse()

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AikaV3rm/UiLib/master/Lib.lua"))()

local window = library:CreateWindow("ITEM UTILITY")

local folder = window:CreateFolder("MAIN")

local whitelist = window:CreateFolder("WHITELIST")

local itemWhitelist = {
    ["Ancient Scroll"] = false,
    ["Deo's Diary"] = false,
    ["Diamond"] = false,
    ["Gold Coin"] = false,
    ["Lucky Arrow"] = false,
    ["Mysterious Arrow"] = false,
    ["Pure Rokakaka"] = false,
    ["Quinton's Glove"] = false,
    ["Rib Cage of The Saint's Corpse"] = false,
    ["Rokakaka"] = false,
    ["Steel Ball"] = false,
    ["Stone Mask"] = false,
    ["Zepellin's Headband"] = false,
}

whitelist:Toggle("ANCIENT SCROLL", function(bool)
    shared.scrollToggle = bool
    itemWhitelist["Ancient Scroll"] = bool
end)

whitelist:Toggle("DEO'S DIARY", function(bool)
    shared.diaryToggle = bool
    itemWhitelist["Deo's Diary"] = bool
end)

whitelist:Toggle("DIAMOND", function(bool)
    shared.diamondToggle = bool
    itemWhitelist["Diamond"] = bool
end)

whitelist:Toggle("GOLD COIN", function(bool)
    shared.coinToggle = bool
    itemWhitelist["Gold Coin"] = bool
end)

whitelist:Toggle("LUCKY ARROW", function(bool)
    shared.luckyToggle = bool
    itemWhitelist["Lucky Arrow"] = bool
end)

whitelist:Toggle("MYSTERIOUS ARROW", function(bool)
    shared.arrowToggle = bool
    itemWhitelist["Mysterious Arrow"] = bool
end)

whitelist:Toggle("PURE ROKAKAKA", function(bool)
    shared.pureToggle = bool
    itemWhitelist["Pure Rokakaka"] = bool
end)

whitelist:Toggle("QUINTON'S GLOVE", function(bool)
    shared.gloveToggle = bool
    itemWhitelist["Quinton's Glove"] = bool
end)

whitelist:Toggle("RIB CAGE OF THE SAINT'S CORPSE", function(bool)
    shared.ribcageToggle = bool
    itemWhitelist["Rib Cage of The Saint's Corpse"] = bool
end)

whitelist:Toggle("ROKAKAKA", function(bool)
    shared.rokakakaToggle = bool
    itemWhitelist["Rokakaka"] = bool
end)

whitelist:Toggle("STEEL BALL", function(bool)
    shared.ballToggle = bool
    itemWhitelist["Steel Ball"] = bool
end)

whitelist:Toggle("STONE MASK", function(bool)
    shared.maskToggle = bool
    itemWhitelist["Stone Mask"] = bool
end)

whitelist:Toggle("ZEPELLIN'S HEADBAND", function(bool)
    shared.headbandToggle = bool
    itemWhitelist["Zepellin's Headband"] = bool
end)

folder:Toggle("AUTO ITEM FARM", function(bool)
    shared.toggle = bool
end)

folder:Toggle("AUTO ARCADE", function(bool)
    shared.arcadeToggle = bool
end)

folder:Toggle("AUTO SELL ITEMS", function(bool)
    shared.sellToggle = bool
end)

folder:Button("CLICK TELEPORT", function()
    if not player.Backpack:FindFirstChild("Click Teleport") then
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "CLICK TELEPORT"
        tool.Activated:connect(function()
            local position = mouse.Hit + Vector3.new(0, 2.5, 0)
            position = CFrame.new(position.X, position.Y, position.Z)
            character.HumanoidRootPart.CFrame = position
        end)
        tool.Parent = player.Backpack
    end
end)

local speed = 0.25

folder:Slider("SPEED", {
    min = 0.125,
    max = 1,
    precise = true,
}, function(value)
    speed = value
end)

function searchTable(t, index)
    local temp = {}
    for i, v in pairs(t) do
        table.insert(temp, tostring(v))
    end
    if table.find(temp, index) then
        temp = nil
        return true
    end
    return false
end

local gc = getgc(true)
local key = nil
for i = #gc, 1, -1 do
    if type(gc[i]) == "table" then
        if rawget(gc[i], "A") and type(rawget(gc[i], "A")) == "table" and #(rawget(gc[i], "A")) > 2 then
            key = rawget(gc[i], "A")[2]
            break
        end
    end
end

local oldNamecall;
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {
        ...
    }
    if not checkcaller() and getnamecallmethod() == "InvokeServer" and tostring(self) == "Returner" and args[1] == "idklolbrah2de" then
        if key then
            return key
        else
            return "  ___XP DE KEY";
        end
    end
    if not checkcaller() and getnamecallmethod() == "InvokeServer" and args[1] == "Reset" then
        return
    end
    if not checkcaller() and getnamecallmethod() == "FireServer" and args[1] == "Reset" then
        return
    end
    if not checkcaller() and getnamecallmethod() == "Kick" then
        return
    end
    return oldNamecall(self, ...);
end)

for _, connection in pairs(getconnections(player.Idled)) do
    connection:Disable()
end

for i, v in pairs(getgc()) do
    if type(v) == "function" and tostring(getfenv(v).script) == 'Client' and #debug.getprotos(v) == 7 and searchTable(debug.getupvalues(v), "RemoteEvent") then
        hookfunction(v, function()
            return wait(9e9);
        end);
        break;
    end
end
wait(0.5)

local itemSpawns = 
    {
    CFrame.new(-413.53112792969, 827.54278564453, 42.011169433594),
    CFrame.new(-191.24629211426, 827.0869140625, -10.055070877075),
    CFrame.new(-282.28414916992, 826.04718017578, -26.729415893555),
    CFrame.new(-205.62605285645, 829.04846191406, -67.532608032227),
    CFrame.new(-154.98663330078, 829.00830078125, -52.219764709473),
    CFrame.new(-89.047630310059, 830.90832519531, -66.026138305664),
    CFrame.new(826.30889892578, 803.84655761719, -226.66427612305),
    CFrame.new(699.22119140625, 803.84655761719, -208.68244934082),
    CFrame.new(776.76434326172, 807.17486572266, -355.8134765625),
    CFrame.new(1050.7122802734, 803.84729003906, -296.76510620117),
    CFrame.new(809.83520507812, 803.84655761719, -81.491226196289),
    CFrame.new(796.341796875, 810.68719482422, -40.994129180908),
    CFrame.new(836.11309814453, 810.33142089844, -41.200565338135),
    CFrame.new(1051.7955322266, 815.47772216797, -25.381820678710001),
    CFrame.new(1915.4926757812, 822.24658203125, -39.561851501465),
    CFrame.new(1985.0435791016, 819.84655761719, -189.87425231934),
    CFrame.new(2341.68359375, 819.84655761719, -228.87698364258),
    CFrame.new(305.22045898438, 803.84655761719, -185.82682800293),
    CFrame.new(339.23501586914, 826.84722900391, -110.79901123047),
    CFrame.new(409.59423828125, 826.64733886719, -89.112976074219),
    CFrame.new(453.85363769531, 826.64733886719, 115.3904876709),
    CFrame.new(428.88458251953, 861.05114746094, -175.99559020996),
    CFrame.new(124.43515014648, 826.84722900391, -153.63478088379),
    CFrame.new(222.72418212891, 827.80584716797, -85.74934387207),
    CFrame.new(130.63851928711, 826.84704589844, -49.86185836792),
    CFrame.new(46.80810546875, 826.84698486328, -98.422576904297),
    CFrame.new(27.974872589111, 861.29296875, -10.053286552429),
    CFrame.new(375.23657226562, 826.84704589844, -162.12173461914),
    CFrame.new(341.62973022461, 826.84704589844, -131.64344787598),
    CFrame.new(479.29449462891, 826.84716796875, 254.90055847168),
    CFrame.new(452.22775268555, 826.84716796875, 302.7751159668),
    CFrame.new(315.51916503906, 826.84716796875, 261.26873779297),
    CFrame.new(518.22473144531, 826.24731445312, 360.57772827148),
    CFrame.new(429.50021362305, 875.04724121094, 387.19262695312),
    CFrame.new(129.19146728516, 826.84704589844, 379.81701660156),
    CFrame.new(32.098743438721, 828.24719238281, 302.8957824707),
    CFrame.new(171.77783203125, 826.84710693359, 255.28721618652),
    CFrame.new(199.16697692871, 857.84704589844, 258.2873840332),
    CFrame.new(21.905725479126, 870.04718017578, 280.63858032227),
    CFrame.new(-74.956695556641, 828.34704589844, 386.41787719727),
    CFrame.new(-152.78285217285, 830.97821044922, 413.20315551758),
    CFrame.new(-99.575782775879, 827.62579345703, 429.30065917969),
    CFrame.new(-118.483543396, 835.71136474609, 402.61944580078),
    CFrame.new(-196.11956787109, 826.84704589844, 408.80563354492),
    CFrame.new(-192.16874694824, 803.84710693359, 458.53912353516),
    CFrame.new(-228.64126586914, 826.84704589844, 309.07147216797),
    CFrame.new(-334.5627746582, 827.84716796875, 382.34112548828),
    CFrame.new(-295.66107177734, 827.7548828125, 260.44488525390001),
    CFrame.new(-243.06549072266, 826.84704589844, 97.641380310059),
    CFrame.new(145.40446472168, 827.79797363281, 106.12605285645),
    CFrame.new(84.441474914551, 826.84704589844, 104.43872070312),
    CFrame.new(43.941471099854, 826.84704589844, 268.90521240234),
    CFrame.new(172.65376281738, 826.84704589844, 278.38635253906),
    CFrame.new(236.93182373047, 826.84704589844, 430.49688720703),
    CFrame.new(210.55850219727, 803.84710693359, 460.701171875),
    CFrame.new(448.04244995117, 803.87713623047, 438.78884887695),
    CFrame.new(126.77220153809, 803.84710693359, 560.0048828125),
    CFrame.new(-206.2195892334, 890.84716796875, 440.22219848633),
    CFrame.new(-470.92459106445, 803.84710693359, 381.17669677734),
    CFrame.new(-434.47100830078, 803.84710693359, 235.62271118164),
    CFrame.new(-442.24462890625, 803.84710693359, -198.76741027832),
    CFrame.new(-101.06670379639, 743.8486328125, 8.9106760025024),
    CFrame.new(-355.35842895508, 743.84289550781, 204.35467529297),
    CFrame.new(-178.44441223145, 720.17205810547, 264.23211669922),
    CFrame.new(196.2378692627, 671.93670654297, 83.881690979004),
    CFrame.new(107.51532745361, 749.04711914062, 359.88635253906),
    CFrame.new(11.99014377594, 744.07873535156, 530.36346435547),
    CFrame.new(138.86274719238, 743.84521484375, 493.1076965332),
    CFrame.new(-38.685668945312, 729.07989501953, 365.58688354492),
    CFrame.new(13.609048843384, 733.42077636719, 267.63186645508),
    CFrame.new(-228.36434936523, 751.04052734375, 528.87542724609),
    CFrame.new(-426.47561645508, 743.84716796875, 460.21655273438),
    CFrame.new(-311.52005004883, 722.84790039062, 438.1628112793),
    CFrame.new(-475.11709594727, 738.84729003906, 212.75103759766)
}

local function grabItem()
    for i, v in pairs(workspace.Item_Spawns.Items:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChildWhichIsA("MeshPart") or v:FindFirstChildWhichIsA("Part") and v:FindFirstChildWhichIsA("ClickDetector") then
            local mp
            for i2, val in pairs(v:GetChildren()) do
                if ((val:IsA("Part") or val:IsA("MeshPart")) and val.Transparency ~= 1) then
                    mp = val
                    break
                end
            end
            if mp and (mp.Position - player.Character.HumanoidRootPart.Position).magnitude <= 5 then
                if mp.Transparency ~= 1 then
                    _G.grabbingItem = true
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(mp.Position) * CFrame.new(0, 3, 0)
                    wait(0.5)
                    if v:FindFirstChildWhichIsA("ClickDetector") then
                        fireclickdetector(v:FindFirstChildWhichIsA("ClickDetector"))
                        for i = 1, 8 do
                            wait() 
                            if (player.PlayerGui:FindFirstChild("Message") and player.PlayerGui.Message:FindFirstChild("TextLabel")) then
                                if string.match(player.PlayerGui.Message.TextLabel.Text, "You can't have more than") then
                                    v:Destroy()
                                end
                            end
                        end
                    end
                    wait(speed)
                    _G.grabbingItem = false
                end
            end
        end
    end
end

local function grabFoundItem(v)
    if v:IsA("Model") and v:FindFirstChildWhichIsA("MeshPart") or v:FindFirstChildWhichIsA("Part") and v:FindFirstChildWhichIsA("ClickDetector") then
        local mp
        for i, val in pairs(v:GetChildren()) do
            if ((val:IsA("Part") or val:IsA("MeshPart")) and val.Transparency ~= 1) then
                mp = val
                break
            end
        end
        if mp and mp.Transparency ~= 1 then
            _G.grabbingItem = true
            player.Character.HumanoidRootPart.CFrame = CFrame.new(mp.Position) * CFrame.new(0, 3, 0)
            wait(0.5)
            if v:FindFirstChildWhichIsA("ClickDetector") then
                fireclickdetector(v:FindFirstChildWhichIsA("ClickDetector"))
                for i = 1, 8 do
                    wait() 
                    if (player.PlayerGui:FindFirstChild("Message") and player.PlayerGui.Message:FindFirstChild("TextLabel")) then
                        if string.match(player.PlayerGui.Message.TextLabel.Text, "You can't have more than") then
                            v:Destroy()
                        end
                    end
                end
            end
            wait(speed)
            _G.grabbingItem = false
        end
    end
end

local function giveWorthiness()
    character.RemoteFunction:InvokeServer("LearnSkill", {
        Skill = "Vitality I",
        SkillTreeType = "Character"
    }
    )
    character.RemoteFunction:InvokeServer("LearnSkill", {
        Skill = "Vitality II",
        SkillTreeType = "Character"
    }
    )
    character.RemoteFunction:InvokeServer("LearnSkill", {
        Skill = "Vitality III",
        SkillTreeType = "Character"
    }
    )
    character.RemoteFunction:InvokeServer("LearnSkill", {
        Skill = "Worthiness I",
        SkillTreeType = "Character"
    }
    )
    character.RemoteFunction:InvokeServer("LearnSkill", {
        Skill = "Worthiness II",
        SkillTreeType = "Character"
    }
    )
    character.RemoteFunction:InvokeServer("LearnSkill", {
        Skill = "Worthiness III",
        SkillTreeType = "Character"
    }
    )
    character.RemoteFunction:InvokeServer("LearnSkill", {
        Skill = "Worthiness IV",
        SkillTreeType = "Character"
    }
    )
    character.RemoteFunction:InvokeServer("LearnSkill", {
        Skill = "Worthiness V",
        SkillTreeType = "Character"
    }
    )
end

spawn(function()
    while true do
        wait()
        if shared.toggle then
            if _G.itemFarm and #(workspace.Item_Spawns.Items:GetChildren()) >= 1 then
                if _G.grabbingItem then
                    repeat
                        wait()
                    until not _G.grabbingItem
                end
                _G.foundItem = true
                for i, v in pairs(workspace.Item_Spawns.Items:GetChildren()) do
                    if (player.Character and player.Character:FindFirstChild("HumanoidRootPart")) then
                        grabFoundItem(v)
                        wait(speed)
                        _G.foundItem = false
                        wait(speed)
                    end
                end
            end
        end
    end
end)

spawn(function()
    while true do
        wait()
        if shared.toggle then
            if _G.itemFarm then
                for i, v in ipairs(itemSpawns) do
                    if _G.foundItem then
                        repeat
                            wait()
                        until not _G.foundItem
                    end
                    if _G.grabbingItem then
                        repeat
                            wait()
                        until not _G.grabbingItem
                    end
                    if not shared.toggle then
                        repeat
                            wait()
                        until shared.toggle
                    end
                    if (player.Character and player.Character:FindFirstChild("HumanoidRootPart")) then
                        player.Character.HumanoidRootPart.CFrame = v
                        wait(speed)
                        grabItem()
                        wait(speed)
                    end
                end
            end
        end
    end
end)

spawn(function()
    while true do
        wait()
        if shared.sellToggle then
            for _, child in pairs(player.Backpack:GetChildren()) do
                if itemWhitelist[child.Name] then
                    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
                    humanoid:EquipTool(child)
                    character.RemoteEvent:FireServer("EndDialogue", {
                        NPC = "Merchant",
                        Dialogue = "Dialogue5",
                        Option = "Option2"
                    }
                    )
                end
            end
        end
        if shared.arcadeToggle then
            character.RemoteEvent:FireServer("EndDialogue", {
                NPC = "Item Machine",
                Dialogue = "Dialogue1",
                Option = "Option1"
            }
            )
        end
    end
end)
