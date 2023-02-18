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

plr = game:GetService("Players").LocalPlayer
character = plr.Character
hum = character:FindFirstChildWhichIsA("Humanoid")
root = character:FindFirstChild("HumanoidRootPart")

task.spawn(function()
    while task.wait() do
        character = plr.Character
        if character ~= nil and character:FindFirstChildWhichIsA("Humanoid") ~= nil then
            hum = character:FindFirstChildWhichIsA("Humanoid")
            root = character:FindFirstChild("HumanoidRootPart")
            if hum.Name ~= "XD" then
                hum.Name = "XD"
            end 
        end
    end
end)

----
--for i,connection in pairs(getconnections(game.RunService.Heartbeat)) do
--    connection:Disable()
--end



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
local theme = venyx:addPage("Theme", 5012544693)
local colors = theme:addSection("Colors")

for theme, color in pairs(themes) do -- all in one theme changer, i know, im cool
colors:addColorPicker(theme, color, function(color3)
venyx:setTheme(theme, color3)
end)
end

-- load
venyx:SelectPage(venyx.pages[1], true)
