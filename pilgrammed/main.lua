-- init
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("ShitWare / Pilgrammed", 5013109572)

-- themes
local themes = {
Background = Color3.fromRGB(24, 24, 24),
Glow = Color3.fromRGB(0, 0, 0),
Accent = Color3.fromRGB(10, 10, 10),
LightContrast = Color3.fromRGB(20, 20, 20),
DarkContrast = Color3.fromRGB(14, 14, 14),  
TextColor = Color3.fromRGB(255, 255, 255)
}

-- first page
local lpPage = venyx:addPage("LocalPlayer", 5012544693)
local section1 = lpPage:addSection("Client")
local section2 = lpPage:addSection("Character Customization")

players_service = game:GetService("Players")
players = {}
plr = players_service.LocalPlayer
character = plr.Character
hum = character:FindFirstChildWhichIsA("Humanoid")
root = character:FindFirstChild("HumanoidRootPart")

task.spawn(function()
    while task.wait() do
        character = plr.Character
        if character ~= nil and character:FindFirstChildWhichIsA("Humanoid") ~= nil then
            hum = character:FindFirstChildWhichIsA("Humanoid")
            root = character:FindFirstChild("HumanoidRootPart")
            --if hum.Name ~= "XD" then
            --    hum.Name = "XD"
            --end 
        end
    end
end)

----

----
for i,connection in pairs(getconnections(game.RunService.Heartbeat)) do
    connection:Disable()
end

local jp = nil
jp = hookmetamethod(game, "__index", newcclosure(function(Self, Key)
    if not checkcaller() and tostring(Self) == "RunService" and Key == "Heartbeat" then
        return nil
    end

    return jp(Self, Key)
end))

local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
    local Args = {...}
    local NamecallMethod = getnamecallmethod()

    if not checkcaller() and Self == game and NamecallMethod == "GetService" and Args[1] == "RunService" then
        return nil
    end

    return OldNameCall(Self, ...)
end)

if character then
    character:BreakJoints() -- so ControlScript is added again to player's character and RunService is hooked so it cant run the loop
end

----

----

section1:addButton("Reset", function()
    character:BreakJoints()
end)

section1:addSlider("WalkSpeed", 0, 18, 500, function(value)
    hum.WalkSpeed = value
end)

section1:addSlider("JumpPower", 0, 50, 500, function(value)
    hum.JumpPower = value
end)

_G.rainbow = false
coroutine.resume(coroutine.create(function()
    while task.wait(0.05) do
        if _G.rainbow == true then
            local chosen = Color3.fromHSV(math.random(0,255),math.random(0,255),math.random(0,255))
            game:GetService("ReplicatedStorage").Remotes.Hair:FireServer(11, chosen)
            game:GetService("ReplicatedStorage").Remotes.Hair:FireServer(1, chosen)
        end
    end
end))
section2:addToggle("Rainbow hair", nil, function(value)
    _G.rainbow = value
end)
section2:addButton("Blank character", function()
    for i=0,10,1 do
        if i == 0 or i == 10 then
            game:GetService("ReplicatedStorage").Remotes.Hair:FireServer(i,"Bald")
        else
           game:GetService("ReplicatedStorage").Remotes.Hair:FireServer(i,"None") 
        end
    end
end)

--[[
section1:addToggle("Toggle", nil, function(value)
    print("Toggled", value)
    end)
section1:addButton("Button", function()
print("Clicked")
end)
section1:addTextbox("Notification", "Default", function(value, focusLost)
print("Input", value)

if focusLost then
venyx:Notify("Title", value)
end
end)

section2:addKeybind("Toggle Keybind", Enum.KeyCode.One, function()
print("Activated Keybind")
venyx:toggle()
end, function()
print("Changed Keybind")
end)
section2:addColorPicker("ColorPicker", Color3.fromRGB(50, 50, 50))
section2:addColorPicker("ColorPicker2")
section2:addSlider("Slider", 0, -100, 100, function(value)
print("Dragged", value)
end)
section2:addDropdown("Dropdown", {"Hello", "World", "Hello World", "Word", 1, 2, 3})
section2:addDropdown("Dropdown", {"Hello", "World", "Hello World", "Word", 1, 2, 3}, function(text)
print("Selected", text)
end)
section2:addButton("Button")
]]

-- second page
local espPage = venyx:addPage("ESP", 5012544693)
local section3 = espPage:addSection("ESP")
local section4 = espPage:addSection("ESP Customization")

local esp_config = {
    player = Color3.fromRGB(16, 172, 16),
    chest = Color3.fromRGB(172, 16, 16),
    mob = Color3.fromRGB(16, 16, 172)
}

_G.player_ESP = false
_G.mob_ESP = false
_G.chest_ESP = false

function create_ESP(typ, objetive)
	if typ == "player" then
        local folder = Instance.new("Folder", game.CoreGui)
        folder.Name = objetive.Name

        local BillboardGui = Instance.new("BillboardGui")
        local TextLabel2 = Instance.new("TextLabel")

        BillboardGui.Parent = folder
        BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        BillboardGui.Active = true
        BillboardGui.Adornee = objetive
        BillboardGui.AlwaysOnTop = true
        BillboardGui.ExtentsOffset = Vector3.new(0, 1.649999976158142, 0)
        BillboardGui.LightInfluence = 1.000
        BillboardGui.Size = UDim2.new(5, 0, 1, 0)

        --[[]]
        TextLabel2.Parent = BillboardGui
        TextLabel2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel2.BackgroundTransparency = 1.000
        TextLabel2.Position = UDim2.new(0, 0, 0.5, 0)
        TextLabel2.Size = UDim2.new(1, 0, 0.5, 0)
        TextLabel2.Font = Enum.Font.Arcade
        TextLabel2.Text = objetive.Name
        TextLabel2.TextColor3 = Color3.fromRGB(255, 0, 0)
        TextLabel2.TextScaled = true
        TextLabel2.TextSize = 14.000
        TextLabel2.TextStrokeTransparency = 0.000
        TextLabel2.TextWrapped = true

        local dist = Instance.new("BillboardGui")
        local TextLabel = Instance.new("TextLabel")

        dist.Name = "dist"
        dist.Parent = folder
        dist.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        dist.Active = true
        dist.Adornee = objetive
        dist.AlwaysOnTop = true
        dist.LightInfluence = 1.000
        dist.Size = UDim2.new(4, 0, 1, 0)

        TextLabel.Parent = dist
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.BackgroundTransparency = 1.000
        TextLabel.BorderColor3 = Color3.fromRGB(27, 42, 53)
        TextLabel.Size = UDim2.new(1, 0, 1, 0)
        TextLabel.Font = Enum.Font.SourceSans
        TextLabel.Text = "0 studs"
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.TextScaled = true
        TextLabel.TextSize = 14.000
        TextLabel.TextStrokeTransparency = 0.000
        TextLabel.TextWrapped = true

        local hitbox = Instance.new("Highlight", folder)
        hitbox.Adornee = objetive
        hitbox.OutlineColor = Color3.new(0, 0, 0)
        hitbox.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hitbox.FillColor = esp_config["player"]
        hitbox.FillTransparency = .4

        task.spawn(function()
            local hah
            hah = game:GetService("RunService").Heartbeat:Connect(function(step)
                if hitbox.FillColor ~= esp_config["player"] then
                    hitbox.FillColor = esp_config["player"]
                end
                if objetive == nil or _G.player_ESP == false or objetive:FindFirstChildWhichIsA("Humanoid").Health == 0 then
                    folder:Destroy()
                    hah:Disconnect()
                end
                local dist = (game:GetService("Workspace").CurrentCamera.CFrame.p - objetive.HumanoidRootPart.CFrame.p).Magnitude
                TextLabel.Text = string.format("%.1f", dist) .. " studs"
            end)
        end)
    elseif typ == "chest" then
        local folder = Instance.new("Folder", game.CoreGui)
        folder.Name = objetive.Name

        local BillboardGui = Instance.new("BillboardGui")
        local TextLabel2 = Instance.new("TextLabel")

        BillboardGui.Parent = folder
        BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        BillboardGui.Active = true
        BillboardGui.Adornee = objetive
        BillboardGui.AlwaysOnTop = true
        BillboardGui.ExtentsOffset = Vector3.new(0, 1.649999976158142, 0)
        BillboardGui.LightInfluence = 1.000
        BillboardGui.Size = UDim2.new(5, 0, 1, 0)

        --[[]]
        TextLabel2.Parent = BillboardGui
        TextLabel2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel2.BackgroundTransparency = 1.000
        TextLabel2.Position = UDim2.new(0, 0, 0.5, 0)
        TextLabel2.Size = UDim2.new(1, 0, 0.5, 0)
        TextLabel2.Font = Enum.Font.Arcade
        TextLabel2.Text = objetive.Name
        TextLabel2.TextColor3 = Color3.fromRGB(255, 0, 0)
        TextLabel2.TextScaled = true
        TextLabel2.TextSize = 14.000
        TextLabel2.TextStrokeTransparency = 0.000
        TextLabel2.TextWrapped = true

        local dist = Instance.new("BillboardGui")
        local TextLabel = Instance.new("TextLabel")

        dist.Name = "dist"
        dist.Parent = folder
        dist.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        dist.Active = true
        dist.Adornee = objetive
        dist.AlwaysOnTop = true
        dist.LightInfluence = 1.000
        dist.Size = UDim2.new(4, 0, 1, 0)

        TextLabel.Parent = dist
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.BackgroundTransparency = 1.000
        TextLabel.BorderColor3 = Color3.fromRGB(27, 42, 53)
        TextLabel.Size = UDim2.new(1, 0, 1, 0)
        TextLabel.Font = Enum.Font.SourceSans
        TextLabel.Text = "0 studs"
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.TextScaled = true
        TextLabel.TextSize = 14.000
        TextLabel.TextStrokeTransparency = 0.000
        TextLabel.TextWrapped = true

        local hitbox = Instance.new("Highlight", folder)
        hitbox.Adornee = objetive
        hitbox.OutlineColor = Color3.new(0, 0, 0)
        hitbox.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hitbox.FillColor = esp_config["chest"]
        hitbox.FillTransparency = .4

        task.spawn(function()
            local hah
            hah = game:GetService("RunService").Heartbeat:Connect(function(step)
                if hitbox.FillColor ~= esp_config["chest"] then
                    hitbox.FillColor = esp_config["chest"]
                end
                if objetive == nil or _G.chest_ESP == false then
                    folder:Destroy()
                    hah:Disconnect()
                end
                local dist = (game:GetService("Workspace").CurrentCamera.CFrame.p - objetive.Root.CFrame.p).Magnitude
                TextLabel.Text = string.format("%.1f", dist) .. " studs"
            end)
        end)
    elseif typ == "mob" then
        local folder = Instance.new("Folder", game.CoreGui)
        folder.Name = objetive.Name

        local BillboardGui = Instance.new("BillboardGui")
        local TextLabel2 = Instance.new("TextLabel")

        BillboardGui.Parent = folder
        BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        BillboardGui.Active = true
        BillboardGui.Adornee = objetive
        BillboardGui.AlwaysOnTop = true
        BillboardGui.ExtentsOffset = Vector3.new(0, 1.649999976158142, 0)
        BillboardGui.LightInfluence = 1.000
        BillboardGui.Size = UDim2.new(5, 0, 1, 0)

        --[[]]
        TextLabel2.Parent = BillboardGui
        TextLabel2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel2.BackgroundTransparency = 1.000
        TextLabel2.Position = UDim2.new(0, 0, 0.5, 0)
        TextLabel2.Size = UDim2.new(1, 0, 0.5, 0)
        TextLabel2.Font = Enum.Font.Arcade
        TextLabel2.Text = objetive.Name
        TextLabel2.TextColor3 = Color3.fromRGB(255, 0, 0)
        TextLabel2.TextScaled = true
        TextLabel2.TextSize = 14.000
        TextLabel2.TextStrokeTransparency = 0.000
        TextLabel2.TextWrapped = true

        local dist = Instance.new("BillboardGui")
        local TextLabel = Instance.new("TextLabel")

        dist.Name = "dist"
        dist.Parent = folder
        dist.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        dist.Active = true
        dist.Adornee = objetive
        dist.AlwaysOnTop = true
        dist.LightInfluence = 1.000
        dist.Size = UDim2.new(4, 0, 1, 0)

        TextLabel.Parent = dist
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.BackgroundTransparency = 1.000
        TextLabel.BorderColor3 = Color3.fromRGB(27, 42, 53)
        TextLabel.Size = UDim2.new(1, 0, 1, 0)
        TextLabel.Font = Enum.Font.SourceSans
        TextLabel.Text = "0 studs"
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.TextScaled = true
        TextLabel.TextSize = 14.000
        TextLabel.TextStrokeTransparency = 0.000
        TextLabel.TextWrapped = true

        local hitbox = Instance.new("Highlight", folder)
        hitbox.Adornee = objetive
        hitbox.OutlineColor = Color3.new(0, 0, 0)
        hitbox.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hitbox.FillColor = esp_config["mob"]
        hitbox.FillTransparency = .4

        task.spawn(function()
            local hah
            hah = game:GetService("RunService").Heartbeat:Connect(function(step)
                if hitbox.FillColor ~= esp_config["mob"] then
                    hitbox.FillColor = esp_config["mob"]
                end
                if objetive == nil or _G.mob_ESP == false then
                    folder:Destroy()
                    hah:Disconnect()
                end
                local dist = (game:GetService("Workspace").CurrentCamera.CFrame.p - objetive.HumanoidRootPart.CFrame.p).Magnitude
                TextLabel.Text = string.format("%.1f", dist) .. " studs"
            end)
        end)
    end
end

section3:addToggle("Player ESP", nil, function(value)
    _G.player_ESP = value
    if _G.player_ESP == true then
        for _, playerr in pairs(players) do
            create_ESP("player", playerr.Character)
        end
    end
end)

section3:addToggle("Mob ESP", nil, function(value)
    _G.mob_ESP = value
    if _G.mob_ESP == true then
        for _, mobFolder in pairs(game:GetService("Workspace"):FindFirstChild("Mobs"):GetChildren()) do
            if #mobFolder:GetChildren() > 0 then
               for _, mob in pairs(mobFolder:GetChildren()) do
                    create_ESP("mob", mob)
               end 
            end
        end
    end
end)

section3:addToggle("Chest ESP", nil, function(value)
    _G.chest_ESP = value
    if _G.chest_ESP == true then
        for _, chest in pairs(game:GetService("Workspace"):FindFirstChild("Chests"):GetChildren()) do
            create_ESP("chest", chest)
        end
    end
end)

for namexd, color in pairs(esp_config) do
    section4:addColorPicker(namexd, color, function(color3)
        esp_config[namexd] = color3
    end)
end

-- THIRD PAGE
local theme = venyx:addPage("Theme", 5012544693)
local colors = theme:addSection("Colors")

for theme, color in pairs(themes) do -- all in one theme changer, i know, im cool
colors:addColorPicker(theme, color, function(color3)
venyx:setTheme(theme, color3)
end)
end

for _, playerloop in pairs(players_service:GetPlayers()) do
    if playerloop ~= plr then
        players[playerloop] = playerloop
        if _G.player_ESP == true then
           create_ESP("player", playerloop)
        end
    end
end

players_service.PlayerAdded:Connect(function(playeradd)
    players[playeradd] = playeradd
    if _G.player_ESP == true then
        create_ESP("player", playeradd)
    end
end)

players_service.PlayerRemoving:Connect(function(playerremove)
    if table.find(players, playerremove) then
        table.remove(players, table.find(players, playerremove))
    end
end)

-- load
venyx:SelectPage(venyx.pages[1], true)
