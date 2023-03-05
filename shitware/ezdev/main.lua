if game.PlaceId == 12413160778 then
   -- init
    local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
    local venyx = library.new("shitware / Ez Dev", 5013109572)

    -- themes
    local themes = {
    Background = Color3.fromRGB(24, 24, 24),
    Glow = Color3.fromRGB(0, 0, 0),
    Accent = Color3.fromRGB(10, 10, 10),
    LightContrast = Color3.fromRGB(20, 20, 20),
    DarkContrast = Color3.fromRGB(14, 14, 14),  
    TextColor = Color3.fromRGB(255, 255, 255)
    }

    --------------

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
            end
        end
    end)

    --------------

    -- first page
    local localplayer_page = venyx:addPage("LocalPlayer", 5012544693)
    local character_sec = localplayer_page:addSection("Character")

    character_sec:addSlider("WalkSpeed", 0, 15, 500, function(value)
        hum.WalkSpeed = value
    end)

    character_sec:addSlider("JumpPower", 0, 50, 500, function(value)
        hum.JumpPower = value
    end)

    local plot_page = venyx:addPage("Plot", 5012544693)
    local mainplot_sec = plot_page:addSection("Main")

    local auto_fix_bugs_var = false
    local testsignal_af_var = false

    mainplot_sec:addToggle("Auto Fix Bugs", nil, function(value)
        auto_fix_bugs_var = value
    end)
    mainplot_sec:addToggle("Ping2.0 & TestSignal AutoFarm", nil, function(value)
        testsignal_af_var = value
    end)

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

    -- SCRIPTING

    local OldNameCall = nil
    OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
        local NamecallMethod = getnamecallmethod()

        if not checkcaller() and Self == plr and NamecallMethod == "Kick" then
            return wait(9e9)
        end

        return OldNameCall(Self, ...)
    end)

    local m = require(plr.PlayerScripts.COM)

    local function getPlot()
        return m.CurrentPLOT
    end

    task.spawn(function()
        local fixing = false
        game:GetService("RunService").Heartbeat:Connect(function()
            if testsignal_af_var == true then
                game:GetService("ReplicatedStorage").ZiNoy.Apps.TestSignal:FireServer(getPlot(), "Test Signal")
                game:GetService("ReplicatedStorage").ZiNoy.Apps.TestSignal:FireServer(getPlot(), "Ping 2.0")
            end
            if auto_fix_bugs_var == true then
                for _, obj in pairs(getPlot().Wires.Conduits:GetChildren()) do
                    if obj:FindFirstChild("BugFold") and fixing == false then
                        repeat task.wait() until character ~= nil
                        fixing = true
                        local oldcf = root.CFrame
                        local prompt = obj:FindFirstChild("BugFold"):FindFirstChildOfClass("Part"):FindFirstChildOfClass("ProximityPrompt")
                        root.CFrame = CFrame.new(obj:FindFirstChild("BugFold"):FindFirstChildOfClass("Part").CFrame.X+1.5,obj:FindFirstChild("BugFold"):FindFirstChildOfClass("Part").CFrame.Y,obj:FindFirstChild("BugFold"):FindFirstChildOfClass("Part").CFrame.Z)
                        fireproximityprompt(prompt, prompt.MaxActivationDistance)
                        wait(.2)
                        root.CFrame = oldcf
                        fixing = false
                    end
                end
            end
        end)
    end) 
end
