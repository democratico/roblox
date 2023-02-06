if game.PlaceId == 11295176104 then
    -- AC BYPASS
    if not game.CoreGui:FindFirstChild("AC_BYPASSED") then
        game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(character)
            character.Core:Destroy()
        end)
        if game:IsLoaded() then
            game:GetService("Players").LocalPlayer.Character.Core:Destroy()
        else
            game.Loaded:Wait()
            game:GetService("Players").LocalPlayer.Character.Core:Destroy()
        end
        if game:GetService("StarterPlayer").StarterCharacterScripts:FindFirstChild("Core") then
            game:GetService("StarterPlayer").StarterCharacterScripts.Core:Destroy()
        end
        Instance.new("BoolValue", game.CoreGui).Name = "AC_BYPASSED"
    end

    -- BOX AUTOFARM

    local af = false

    local UIS = game:GetService("UserInputService")
    local bind = enum.KeyCode.F5 -- https://create.roblox.com/docs/reference/engine/enums/KeyCode
    UIS.InputBegan:Connect(function(obj)
        if obj.KeyCode == bind then
            af = not af
        end
    end)

    local get
    local receive

    for _, obj in pairs(game:GetService("Workspace").Jobs:GetDescendants()) do
        if obj:IsA("TouchTransmitter") and receive == nil then
            obj.Parent.Parent.Name = "GiverJob"
            receive = obj
        end
        if get == nil and obj:IsA("ClickDetector") and obj.Parent.Name == "Box" then
            get = obj
        end
    end

    repeat
        task.wait()
    until get ~= nil and receive ~= nil

    task.spawn(function()
        game:GetService("RunService").Heartbeat:Connect(function(s)
            if game:GetService("Players").LocalPlayer.Character then
                if af == true then
                    if not game:GetService("Players").LocalPlayer.Character.RightHand:FindFirstChild("JobBox") then
                        if get:IsA("ClickDetector") then
                            fireclickdetector(get, 10)
                        end
                    end
                    if game:GetService("Players").LocalPlayer.Character.RightHand:FindFirstChild("JobBox") then
                        local box = game:GetService("Players").LocalPlayer.Character.RightHand:FindFirstChild("JobBox")
                        firetouchinterest(box, receive.Parent, 0)
                        task.wait()
                        firetouchinterest(box, receive.Parent, 1)
                    end
                end
            end
        end)
    end) 
    print("Made by imvip on v3rm (github.com/imvipp)")
end
