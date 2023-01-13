if game.PlaceId == 11998813375 then
    local plr = game:GetService("Players").LocalPlayer
    character = plr.Character or plr.CharacterAdded:Wait()
    local RunService = game:GetService("RunService")
    local UIS = game:GetService("UserInputService")
    
    UIS.InputBegan:Connect(function(i,gpe)
        if i.KeyCode == _G.switchKey and gpe == false then
            _G.box_AF = not _G.box_AF
        end
    end)
    
    function startxd()
        task.spawn(function()
            game:GetService("Workspace")['game'].interactive.jobs.TruckJob.Shelves["Warehouse Shelf 1"].Name = "WarehouseShelf69"
            while task.wait(23.2) do
                if _G.box_AF == true then
                    character.HumanoidRootPart.CFrame = CFrame.new(28.6322002, 3.40753126, 141.114059, 0.409054905, 4.89856724e-08, -0.912509799, -1.10760638e-07, 1, 4.03118161e-09, 0.912509799, 9.9421186e-08, 0.409054905)
                    wait(.15)
                    fireproximityprompt(game:GetService("Workspace")['game'].interactive.jobs.TruckJob.Truck.MeshPart.Attachment.ProximityPrompt)
                    wait(1)
                    character.HumanoidRootPart.CFrame = game:GetService("Workspace")['game'].interactive.jobs.TruckJob.Shelves["WarehouseShelf69"].CFrame
                    wait(.25)
                    fireproximityprompt(game:GetService("Workspace")['game'].interactive.jobs.TruckJob.Shelves["WarehouseShelf69"].Attachment.ProximityPrompt)
                    wait(.8)
                else
                    check(true)
                    break
                end
            end
        end)
    end
    
    function check(xd)
        task.spawn(function()
            if xd == true then
                game:GetService("Workspace")['game'].interactive.jobs.TruckJob.Shelves["WarehouseShelf69"].Name = "Warehouse Shelf 1"
            end
            local a
            a = RunService.Heartbeat:Connect(function(step)
                if _G.box_AF == true then
                    startxd()
                    a:Disconnect()
                end
            end)
        end)
    end
    
    check(false) 
end
