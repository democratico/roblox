--loadstring(game:HttpGet('https://raw.githubusercontent.com/imvipp/roblox/main/shitware/pennsylvania/main.lua'))()

if game.PlaceId == 7533528186 then
    print("Made by github.com/imvipp")
    getgenv().SecureMode = true

    --local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
    --local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Interface/CustomFIeld/main/RayField.lua'))()
    local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/imvipp/roblox/main/shitware/rayfield_UILIB.lua'))()

    local Window = Rayfield:CreateWindow({
        Name = "ShitWare // Pennsylvania",
        LoadingTitle = "ShitWare",
        LoadingSubtitle = "By vip",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "ShitWare", -- Create a custom folder for your hub/game
            FileName = "Pennsylvania"
        },
        Discord = {
            Enabled = true,
            Invite = "7pMRANYTtD", -- The Discord invite code, do not include discord.gg/
            RememberJoins = true -- Set this to false to make them join the discord every time they load it up
        },
        KeySystem = true, -- Set this to true to use our key system
        KeySettings = {
            Title = "ShitWare",
            Subtitle = "Key System",
            Note = "Join the discord (discord.gg/7pMRANYTtD)",
            FileName = "ShitWare_Key",
            SaveKey = true,
            GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
            Key = "uwu"
        }
    })

    Window:Prompt({
        Title = 'ShitWare | Prompt',
        SubTitle = '¿Are you gay?',
        Content = 'Meaning of gay: sexually or romantically attracted exclusively to people of own sex or gender (used especially of a man).',
        Actions = {
            Accept = {
                Name = 'Yes',
                Callback = function()
                    game.Players.LocalPlayer:Kick("faggot")
                end,
            },
            Decline = {
                Name = 'No',
                Callback = function() end,
            }
        }
    })

    --#$ Variables $#--

    local plr = game.Players.LocalPlayer
    local character = plr.Character or plr.CharacterAdded:Wait()

    function getchar()
        if workspace:FindFirstChild(game.Players.LocalPlayer.Name) then
            character = workspace:FindFirstChild(game.Players.LocalPlayer.Name)
        else
            character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        end
        plr = game.Players.LocalPlayer
    end

    local maxBalance = {
        200000, -- wallet
        500000 -- bank
    }

    --#$ Anticheat stuff $#--

    local OldNamecall3
    OldNamecall3 = hookmetamethod(game, "__namecall", function(self, ...)
        local args = { ... }
        local method = getnamecallmethod()

        if tostring(self) == "remoteeve" or tostring(self) == "clientdata" or
            tostring(self) == "WtflIlIlIlIl" and method == "FireServer" then
            args[1] = wait(9e9)
            return self.FireServer(self, unpack(args))
        end
        return OldNamecall3(self, ...)
    end)

    game:GetService("Workspace").Billboards["Gamepass Board3"].w["Radio Music"].Music.Playing = false

    function disableAC()
        game:GetService("Players").LocalPlayer.Backpack.LocalScript.Disabled = true
        game.Players.LocalPlayer.Character.Packed.Loader2.Disabled = true
        game.Players.LocalPlayer.Character.Packed.Loader1.Disabled = true
    end

    disableAC()
    spawn(function()
        while task.wait() do
            if game.Players.LocalPlayer.Character.Packed.Loader2.Disabled == false and game.Players.LocalPlayer.Character.Packed.Loader1.Disabled == false then
                disableAC()
            end
            getchar()
        end
    end)

    -------------------

    --#$ Bank AutoFarm | FUNCTIONS $#--

    local bAFlol = false
    local bRobbing = false

    function bAF()
        spawn(function()
            while wait(1.5) do
                if bAFlol == false then
                    break
                end
                if bAFlol == true then
                    if bRobbing == false then
                        if game:GetService("Workspace").Buildings.BankFolder.CanBeRobbed.Value == true then
                            bRobbing = true
                            if game.ReplicatedStorage.MoneyData[game.Players.LocalPlayer.Name].BankAccount.Value < maxBalance[2] and
                                game.ReplicatedStorage.MoneyData[game.Players.LocalPlayer.Name].Cash.Value < maxBalance[1] then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Buildings.BankFolder.Detector.CFrame
                                repeat
                                    wait()
                                until game.Players.LocalPlayer.BankStats.CashCollected.Value == 15000
                                if game.Players.LocalPlayer.BankStats.CashCollected.Value == 15000 then
                                    local npc = game:GetService("Workspace").Systems["Bank Heist Collector"]
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = npc.Head.CFrame
                                    wait(0.2)
                                    npc.HumanoidRootPart.ProximityPrompt:InputHoldBegin()
                                    wait(npc.HumanoidRootPart.ProximityPrompt.HoldDuration)
                                    npc.HumanoidRootPart.ProximityPrompt:InputHoldEnd()
                                    bRobbing = false
                                end
                            else
                                Rayfield:Notify({
                                    Title = "AutoFarm Error",
                                    Content = "You have maximum balance in your wallet and bank.",
                                    Duration = 3,
                                    Image = 4483362458,
                                    Actions = { -- Notification Buttons
                                        Ignore = {
                                            Name = "Ok",
                                            Callback = function() end
                                        },
                                    },
                                })
                            end
                        end
                    end
                end
            end
        end)
    end

    local mTab = Window:CreateTab("Money", 4483362458)
    local infmoney = mTab:CreateButton({
        Name = "Infinite money",
        Interact = 'Gives you 500K',
        Callback = function()
            game:GetService("ReplicatedStorage").MoneySystem:FireServer("ATM",{["action"]="withdraw",["amount"]=-129392315})
        end,
    })
    local afSection = mTab:CreateSection("Autofarm")
    local bAF_Toggle = mTab:CreateToggle({
        Name = "Bank AutoFarm",
        Info = "If you turn it off while robbing it will wait till you collect the cash then it will stop autofarming",
        CurrentValue = false,
        Flag = "bAF", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            bAFlol = Value
            if Value == true then
                bAF()
            end
        end,
    })
    local pstats_warning = mTab:CreateLabel("To use \"Get player stats\" you have to type the target's username NOT DISPLAY NAME. The result will appear in dev console (Press F9 and scroll down)")
    local getPstats = mTab:CreateInput({
        Name = "Get player stats:",
        PlaceholderText = "Target username",
        RemoveTextAfterFocusLost = false,
        Callback = function(Text)
            if PS:FindFirstChild(Text) then
                local p = PS:FindFirstChild(Text)
                if p.DisplayName == p.Name then
                    print("Stats about " ..p.Name .."\nWallet: $" ..tostring(game.ReplicatedStorage.MoneyData[Text].Cash.Value) .."\nBank: $" .. tostring(game.ReplicatedStorage.MoneyData[Text].BankAccount.Value))
                else
                    print("Stats about " ..p.DisplayName .." ( @" ..Text .." )\nWallet: $" ..tostring(game.ReplicatedStorage.MoneyData[Text].Cash.Value) .."\nBank: $" .. tostring(game.ReplicatedStorage.MoneyData[Text].BankAccount.Value))
                end

            end
        end,
    })
    local afSection = mTab:CreateSection("Bank")
    local deposit = mTab:CreateInput({
        Name = "Deposit (ATM):",
        Info = "Must be a number value, maximum length: 6 characters, \nmaximum amount: 200000",
        PlaceholderText = "Money amount",
        NumbersOnly = true, -- If the user can only type numbers.
        CharacterLimit = 6, --max character limit. Remove if none.
        OnEnter = true,
        RemoveTextAfterFocusLost = false,
        Callback = function(Text)
            if tonumber(game.ReplicatedStorage.MoneyData[game.Players.LocalPlayer.Name].Cash.Value) > tonumber(Text) then
                game:GetService("ReplicatedStorage").MoneySystem:FireServer("ATM",{ ["action"] = "deposit", ["amount"] = tonumber(Text) })
            end
        end,
    })

    local withdraw = mTab:CreateInput({
        Name = "Withdraw (ATM):",
        Info = "Must be a number value, maximum length: 6 characters, \nmaximum amount: 200000",
        PlaceholderText = "Money amount",
        NumbersOnly = true, -- If the user can only type numbers.
        CharacterLimit = 6, --max character limit. Remove if none.
        OnEnter = true,
        RemoveTextAfterFocusLost = false,
        Callback = function(Text)
            if tonumber(game.ReplicatedStorage.MoneyData[game.Players.LocalPlayer.Name].BankAccount.Value) > tonumber(Text) then
                game:GetService("ReplicatedStorage").MoneySystem:FireServer("ATM",{ ["action"] = "withdraw", ["amount"] = tonumber(Text) })
            end
        end,
    })

    -----------------------------------

    local TPTab = Window:CreateTab("Teleports", 4483362458)
    local TPSection = TPTab:CreateSection("Teleports")

    local CityTPs_Dropdown = TPTab:CreateDropdown({
        Name = "City locations",
        Options = { "Civ Spawn", "Harmony Bank", "Car DealerShip", "MCSO Spawn", "PSP Spawn", "Prisoners Spawn",
            "CMPD Spawn",
            "MCFD Spawn", "DOT Spawn", "Army Spawn", "Soel's Guns & Ammo", "Casino", "Philly Hospital",
            "Jewelry (OUTSIDE)",
            "Jewelry (INSIDE)", "Los pollos hermanos", "Big Bros (OUTSIDE)", "Big Bros (ROOF)", "Philly Paint Shop",
            "Philly Shooting Club", "Pawn Shop", "PPD Station", "PSP Station", "Capitol (INSIDE)" },
        CurrentOption = "Civ Spawn",
        Flag = "cityLocations", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Option)
            if Option == "Civ Spawn" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1173.93433, 5.88394547, -1880.65991, 1,8.36646841e-09,3.2875324e-14, -8.36646841e-09, 1, 4.62313281e-08, -3.24885315e-14, -4.62313281e-08, 1)
            elseif Option == "Harmony Bank" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(31.5773354, 5.91323566, -356.561401, -0.978007615,-1.89580884e-08, 0.208569288, 3.93860278e-09, 1, 1.09364478e-07, -0.208569288, 1.07780764e-07,-0.978007615)
            elseif Option == "Car DealerShip" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1210.17554, 5.27346802, -1918.92432, 1.28122911e-05,1.10993717e-07, -1, -8.48555981e-09, 1, 1.10993611e-07, 1, 8.48413784e-09, 1.28122911e-05)
            elseif Option == "MCSO Spawn" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(382.288818, 6.24014473, -2281.3103, 1, 3.74453357e-08,-4.14666402e-14, -3.74453357e-08, 1, -2.88966007e-09, 4.13584369e-14, 2.88966007e-09, 1)
            elseif Option == "PSP Spawn" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2731.01465, 19.3445129, -557.929138, 0.999382854,7.87512704e-08, -0.0351276472, -7.89161447e-08, 1, -3.30711614e-09, 0.0351276472, 6.0772134e-09,0.999382854)
            elseif Option == "Prisoners Spawn" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3322.72437, -43.3606415, 1017.85297, -0.173402622,-1.5545071e-08, 0.984851003, -3.87683841e-09, 1, 1.51015893e-08, -0.984851003, -1.19945309e-09,-0.173402622)
            elseif Option == "CMPD Spawn" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-598.078003, 5.92038918, 239.346771, 0.965884566,-1.51863355e-09, -0.258973002, 6.3851906e-09, 1, 1.79506117e-08, 0.258973002, -1.8991809e-08,0.965884566)
            elseif Option == "MCFD Spawn" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1215.02686, 5.1999979, -1513.53711, 1,-9.05407305e-09,-3.94508602e-15, 9.05407305e-09, 1, 1.1324002e-07, 2.9198024e-15, -1.1324002e-07, 1)
            elseif Option == "DOT Spawn" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1203.50549, 5.36495876, -1677.8064, 1, 5.4062661e-09,-3.78522676e-15, -5.4062661e-09, 1, -6.76176128e-08, 3.41966788e-15, 6.76176128e-08, 1)
            elseif Option == "Army Spawn" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1831.17102, 5.30218697, 2344.15625, 1, -9.2644088e-09,-4.07671621e-15, 9.2644088e-09, 1, 1.15873256e-07, 3.00321905e-15, -1.15873256e-07, 1)
            elseif Option == "Soel's Guns & Ammo" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-309.382355, 5.8839426, -135.703949, 0.998898745,2.65400839e-08, 0.0469181463, -2.72317511e-08, 1, 1.41027954e-08, -0.0469181463, -1.53649271e-08,0.998898745)
            elseif Option == "Casino" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(143.98848, 5.88394356, 18.0760098, 0.0201089773,-2.57470525e-08, -0.999797821, 5.29057189e-08, 1, -2.46881644e-08, 0.999797821, -5.23985655e-08,0.0201089773)
            elseif Option == "Philly Hospital" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1001.57166, 5.88399792, 123.13372, 0.0152309462,3.86254619e-08, 0.999884009, -8.09245222e-08, 1, -3.73972426e-08, -0.999884009, -8.03455364e-08,0.0152309462)
            elseif Option == "Jewelry (INSIDE)" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-537.246643, 6.03827095, -853.070435, -0.830620885,7.37640136e-08, 0.556838393, 6.01162355e-08, 1, -4.27955662e-08, -0.556838393, -2.07186468e-09,-0.830620885)
            elseif Option == "Jewelry (OUTSIDE)" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-561.167053, 5.88394451, -854.050842, 0.0213721693,5.21850581e-08, 0.999771595, 2.09134416e-08, 1, -5.26440473e-08, -0.999771595, 2.2033781e-08,0.0213721693)
            elseif Option == "Los pollos hermanos" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-116.03347, 5.88399887, -274.641907, -0.0196507238,9.51928314e-08, 0.999806881, 2.66311257e-08, 1, -9.46877989e-08, -0.999806881, 2.47652991e-08,-0.0196507238)
            elseif Option == "Big Bros (OUTSIDE)" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-572.559998, 5.8839426, -97.0449829, 0.023679141,1.19046923e-08, 0.99971962, 1.91857303e-08, 1, -1.23624604e-08, -0.99971962, 1.94730827e-08,0.023679141)
            elseif Option == "Big Bros (ROOF)" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-510.76825, 236.250916, -228.591446, 0.446605772,2.39485249e-08, 0.894730866, 3.44310465e-08, 1, -4.39524683e-08, -0.894730866, 5.04359434e-08,0.446605772)
            elseif Option == "Philly Shooting Club" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-450.95224, 5.88394356, -571.02179, 0.0151820518,-2.80393078e-08, -0.999884725, 4.91787198e-08, 1, -2.72958189e-08, 0.999884725, -4.87586469e-08,0.0151820518)
            elseif Option == "Philly Paint Shop" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2778.39771, 5.32951736, 453.593018, 0.0230581202,-2.65987765e-08, -0.999734104, 9.58970858e-09, 1, -2.63846704e-08, 0.999734104, -8.97877861e-09,0.0230581202)
            elseif Option == "Pawn Shop" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2708.92627, 6.1139698, 355.354126, 0.992190361,6.5075632e-08, -0.12473283, -6.73238105e-08, 1, -1.3808755e-08, 0.12473283, 2.20984031e-08,0.992190361)
            elseif Option == "PPD Station" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-598.20636, 5.92038822, 194.76738, 0.229997218,-1.06730241e-07, 0.973191261, 5.1633533e-09, 1, 1.08450088e-07, -0.973191261, -1.99182892e-08,0.229997218)
            elseif Option == "PSP Station" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-598.20636, 5.92038822, 194.76738, 0.229997218,-1.06730241e-07, 0.973191261, 5.1633533e-09, 1, 1.08450088e-07, -0.973191261, -1.99182892e-08,0.229997218)
            elseif Option == "Capitol (INSIDE)" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-598.20636, 5.92038822, 194.76738, 0.229997218,-1.06730241e-07, 0.973191261, 5.1633533e-09, 1, 1.08450088e-07, -0.973191261, -1.99182892e-08,0.229997218)
            end
        end,
    })
    local plrsSection = TPTab:CreateSection("Players")

    local PS = game:GetService("Players")
    local PLIST = {}
    local PlayersTPs = TPTab:CreateDropdown({
        Name = "Teleport to player",
        Options = PLIST,
        CurrentOption = "",
        Flag = "pTPs", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Option)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = PS[Option].Character.HumanoidRootPart.CFrame
        end,
    })

    local spectatePlrsDropdown = TPTab:CreateDropdown({
        Name = "Spectate player",
        Options = PLIST,
        CurrentOption = "",
        Flag = "specPlr", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Option)
            game.Workspace.Camera.CameraSubject = game.Players[Option].Character.Humanoid
        end,
    })
    local spectateYourself = TPTab:CreateButton({
        Name = "Stop spectating",
        Interact = 'Click',
        Callback = function()
            game.Workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
        end,
     })

    for _, p in pairs(PS:GetPlayers()) do
        if p ~= game.Players.LocalPlayer then
            PlayersTPs:Add(p.Name)
            spectatePlrsDropdown:Add(p.Name)
        end
    end
    PS.PlayerAdded:Connect(function(p)
        PlayersTPs:Add(p.Name)
        spectatePlrsDropdown:Add(p.Name)
    end)
    PS.PlayerRemoving:Connect(function(p)
        PlayersTPs:Remove(p.Name)
        spectatePlrsDropdown:Remove(p.Name)
    end)

    local Keybind = TPTab:CreateKeybind({
        Name = "Teleport to Mouse Position",
        CurrentKeybind = "Q",
        HoldToInteract = false,
        Flag = "TPMPOS", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Keybind)
            local mouse = game.Players.LocalPlayer:GetMouse()
            if mouse.Target then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.x, mouse.Hit.y + 5, mouse.Hit.z)
            end
        end,
    })

    local gTab = Window:CreateTab("PvP", 4483362458)
    -- W.I.P: ESP, HB Expander
    local gunsList = {}
    local pstats_warning = gTab:CreateLabel("Modifying your gun will totally remove recoil and will increase firerate, \ndo 100 damage per bullet and you will not have to reload.\nDo not equip the gun while modifying it, you will have to reload it after being modified to see the change.")
    local modGunDropdown = gTab:CreateDropdown({
        Name = "Modify gun stats",
        Options = gunsList,
        CurrentOption = "",
        Flag = "modGun", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Option)
            game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
            local m = require(game.Players.LocalPlayer.Backpack[Option].Resource.SettingsModule.ClientConfig)
            m['Ammo'] = math.huge
            m['BaseDamage'] = math.huge
            m['LimbDamage'] = math.huge
            m['ArmorDamage'] = math.huge
            m['HeadDamage'] = math.huge
            m["gunrecoil"] = 0
            m["camrecoil"] = 0
            m["AimGunRecoil"] = 0
            m["AimCamRecoil"] = 0
            m["CamShake"] = 0
            m["AimCamShake"] = 0
            m["Kickback"] = 0
            m["AimKickBack"] = 0
            m["Firerate"] = 0.10
            m["FireMode"] = 1
            m["BurstEnabled"] = false
            m["SemiEnabled"] = true
            m["AutoEnabled"] = true
            m["BoltAction"] = false
        end,
    })
    for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if tool.Name == "AK47" or tool.Name == "M4 Carbine" or tool.Name == "Glock 17" or tool.Name == "Serbu BFG-50" then
            modGunDropdown:Add(tool.Name)
        end
    end
    game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function(tool)
        if tool.Name == "AK47" or tool.Name == "M4 Carbine" or tool.Name == "Glock 17" or tool.Name == "Serbu BFG-50" then
            modGunDropdown:Add(tool.Name)
        end
    end)
    game.Players.LocalPlayer.Backpack.ChildRemoved:Connect(function(tool)
        if tool.Name == "AK47" or tool.Name == "M4 Carbine" or tool.Name == "Glock 17" or tool.Name == "Serbu BFG-50" then
            modGunDropdown:Remove(tool.Name)
        end
    end)
    game.Players.LocalPlayer.ChildAdded:Connect(function(child)
        if child.Name == "Backpack" then
            game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function(tool)
                if tool.Name == "AK47" or tool.Name == "M4 Carbine" or tool.Name == "Glock 17" or tool.Name == "Serbu BFG-50" then
                    modGunDropdown:Add(tool.Name)
                end
            end)
            game.Players.LocalPlayer.Backpack.ChildRemoved:Connect(function(tool)
                if tool.Name == "AK47" or tool.Name == "M4 Carbine" or tool.Name == "Glock 17" or tool.Name == "Serbu BFG-50" then
                    modGunDropdown:Remove(tool.Name)
                end
            end)
        end
    end)

    spawn(function()
        if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then
            wait(game.Players.RespawnTime)
            getchar()
        end
    end)

    ------------------------------------------------------------

    local ESPenabled

    function getRoot(char)
        return char:FindFirstChild("HumanoidRootPart")
    end

    local COREGUI = game.CoreGui
    local Players = game.Players
    local RunService = game.RunService

    function tagESP(player)
        for i,v in pairs(COREGUI:GetChildren()) do
			if v.Name == game.Players.LocalPlayer.Name..'_ESP' then
				v:Destroy()
			end
		end
		wait()
		if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Name ~= game.Players.LocalPlayer.Name and not COREGUI:FindFirstChild(game.Players.LocalPlayer.Name..'_ESP') then
            local ESPholder = Instance.new("Folder")
			ESPholder.Name = game.Players.LocalPlayer.Name..'_ESP'
			ESPholder.Parent = COREGUI
			repeat wait(1) until game.Players.LocalPlayer.Character and getRoot(game.Players.LocalPlayer.Character) and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			for b,n in pairs (game.Players.LocalPlayer.Character:GetChildren()) do
				if (n:IsA("BasePart")) then
					local a = Instance.new("BoxHandleAdornment")
					a.Name = game.Players.LocalPlayer.Name
					a.Parent = ESPholder
					a.Adornee = n
					a.AlwaysOnTop = true
					a.ZIndex = 10
					a.Size = n.Size
					a.Transparency = 0.3
					a.Color = game.Players.LocalPlayer.TeamColor
				end
			end
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild('Head') then
                local BillboardGui = Instance.new("BillboardGui")
                local TextLabel = Instance.new("TextLabel")
                BillboardGui.Adornee = game.Players.LocalPlayer.Character.Head
                BillboardGui.Name = game.Players.LocalPlayer.Name
                BillboardGui.Parent = ESPholder
                BillboardGui.Size = UDim2.new(0, 100, 0, 150)
                BillboardGui.StudsOffset = Vector3.new(0, 1, 0)
                BillboardGui.AlwaysOnTop = true
                TextLabel.Parent = BillboardGui
                TextLabel.BackgroundTransparency = 1
                TextLabel.Position = UDim2.new(0, 0, 0, -50)
                TextLabel.Size = UDim2.new(0, 100, 0, 100)
                TextLabel.Font = Enum.Font.SourceSansSemibold
                TextLabel.TextSize = 20
                TextLabel.TextColor3 = Color3.new(1, 1, 1)
                TextLabel.TextStrokeTransparency = 0
                TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom
                TextLabel.Text = 'Name: '..game.Players.LocalPlayer.Name
                TextLabel.ZIndex = 10
                local espLoopFunc
                local teamChange
                local addedFunc
                addedFunc = game.Players.LocalPlayer.CharacterAdded:Connect(function()
                    if ESPenabled then
                        espLoopFunc:Disconnect()
                        teamChange:Disconnect()
                        ESPholder:Destroy()
                        repeat wait(1) until getRoot(game.Players.LocalPlayer.Character) and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                        tagESP(game.Players.LocalPlayer)
                        addedFunc:Disconnect()
                    else
                        teamChange:Disconnect()
                        addedFunc:Disconnect()
                    end
                end)
                teamChange = game.Players.LocalPlayer:GetPropertyChangedSignal("TeamColor"):Connect(function()
                    if ESPenabled then
                        espLoopFunc:Disconnect()
                        addedFunc:Disconnect()
                        ESPholder:Destroy()
                        repeat wait(1) until getRoot(game.Players.LocalPlayer.Character) and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                        tagESP(game.Players.LocalPlayer)
                        teamChange:Disconnect()
                    else
                        teamChange:Disconnect()
                    end
                end)
                local function espLoop()
                    if COREGUI:FindFirstChild(game.Players.LocalPlayer.Name..'_ESP') then
                        if game.Players.LocalPlayer.Character and getRoot(game.Players.LocalPlayer.Character) and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and game.Players.LocalPlayer.Character and getRoot(game.Players.LocalPlayer.Character) and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                            local pos = math.floor((getRoot(game.Players.LocalPlayer.Character).Position - getRoot(game.Players.LocalPlayer.Character).Position).magnitude)
                            TextLabel.Text = 'Name: '..game.Players.LocalPlayer.Name..' | Health: '..game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').Health..' | Studs: '..pos
                        end
                    else
                        teamChange:Disconnect()
                        addedFunc:Disconnect()
                        espLoopFunc:Disconnect()
                    end
                end
                espLoopFunc = RunService.RenderStepped:Connect(espLoop)
            end
        end
    end

    function removetagESP(player)
        for i,c in pairs(COREGUI:GetChildren()) do
            if string.sub(c.Name, -4) == '_ESP' then
                c:Destroy()
            end
        end
    end

    -------------------------------------------------------------

    local ESP = gTab:CreateToggle({
        Name = "ESP",
        CurrentValue = false,
        Flag = "ESP", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            ESPenabled = Value
            local connection1
            local connection2

            if Value == true then
                for _, p in pairs(game.Players:GetPlayers()) do
                    tagESP(p)
                end
            
                connection1 = game.Players.PlayerAdded:Connect(function(p)
                    tagESP(p)
                end)
            
                connection2 = game.Players.PlayerRemoving:Connect(function(p)
                    removetagESP(p)
                end)
            else
                connection1:Disconnect()
                connection1 = nil
                connection2:Disconnect()
                connection2 = nil
            end
        end,
    })

    local hbe = false

    local HBEpartDropdown = gTab:CreateDropdown({
        Name = "Hitbox expander part:",
        Options = { "Head", "HumanoidRootPart" },
        CurrentOption = "HumanoidRootPart",
        Flag = "HBEpart", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Option) end,
    })

    local HBEpartToggle = gTab:CreateToggle({
        Name = "Hitbox expander",
        CurrentValue = false,
        Flag = "HBEtoggle", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            hbe = Value
            if Value == true then
                spawn(function()
                    while wait() do
                        if hbe == false then
                            for i, v in next, game:GetService("Players"):GetPlayers() do
                                if v.Name ~= game:GetService("Players").LocalPlayer.Name then
                                    pcall(function()
                                        if HBEpartDropdown.CurrentOption == "HumanoidRootPart" then
                                            v.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                                            v.Character.HumanoidRootPart.Transparency = 1
                                            v.Character.HumanoidRootPart.Material = "Plastic"
                                            v.Character.HumanoidRootPart.CanCollide = true
                                        elseif HBEpartDropdown.CurrentOption == "Head" then
                                            v.Character.Head.Size = Vector3.new(2, 1, 1)
                                            v.Character.Head.CanCollide = true
                                        end
                                    end)
                                end
                            end
                            break;
                        end
                        for i, v in next, game:GetService("Players"):GetPlayers() do
                            if v.Name ~= game:GetService("Players").LocalPlayer.Name then
                                pcall(function()
                                    if HBEpartDropdown.CurrentOption == "HumanoidRootPart" then
                                        v.Character.HumanoidRootPart.Size = Vector3.new(20, 20, 20)
                                        v.Character.HumanoidRootPart.Transparency = 0.7
                                        v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really white")
                                        v.Character.HumanoidRootPart.Material = "Neon"
                                        v.Character.HumanoidRootPart.CanCollide = false
                                    elseif HBEpartDropdown.CurrentOption == "Head" then
                                        v.Character.Head.Size = Vector3.new(6, 6, 6)
                                        v.Character.Head.CanCollide = false
                                    end
                                end)
                            end
                        end
                    end
                end)
            end
        end,
    })

    local lpTab = Window:CreateTab("Player", 4483362458)
    local autobuyinfo = lpTab:CreateLabel("You must have the minium money to buy the tool")
    local autobuyDropdown = lpTab:CreateDropdown({
        Name = "Buy in-game item:",
        Options = { "Drill", "Protest", "Hammer", "Crowbar", "Gas Can", "Tire Pump", "Vest", "AK47", "Glock 17",
            "M4 Carbine",
            "Serbu BFG-50", "Knife" },
        CurrentOption = "",
        Flag = "ingameItem", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Option)
            if Option == "Vest" then
                game.ReplicatedStorage.BuyVest:FireServer()
            else
                game:GetService("ReplicatedStorage").MoneySystem:FireServer("ShopSystem", { ["Tool"] = Option })
            end
        end,
    })

    function playAnim(animID, speed, status)
        local Anim = Instance.new("Animation")
        Anim.AnimationId = "rbxassetid://"..animID
        local playerAnimHum = game.Players.LocalPlayer.Character.Humanoid:WaitForChild("Animator"):LoadAnimation(Anim)
        playerAnimHum:Play()
        playerAnimHum:AdjustSpeed(speed)
    
        if status then
            playerAnimHum:Stop()
        end
    end

    local animOptions = {
        "Scream",
        "Barrel roll",
        "Scared",
        "Head off",
        "Dab",
        "Crouch",
        "Lay down",
        "Loop head",
        "Head throw",
        "Rapid arm"
    }

    local animsDropdown = lpTab:CreateDropdown({
        Name = "Play animation",
        Options = animOptions,
        CurrentOption = "",
        Flag = "anim", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(option)
            if option == "Scream" then
                playAnim(180611870, 1, false)
            elseif option == "Barrel roll" then
                playAnim(136801964, 1, false)
            elseif option == "Scared" then
                playAnim(180612465, 1, false)
            elseif option == "Head off" then
                playAnim(121572214, 1, false)
            elseif option == "Dab" then
                playAnim(248263260, 1, false)
            elseif option == "Crouch" then
                playAnim(182724289, 1, false)
            elseif option == "Lay down" then
                playAnim(282574440, 1, false)
            elseif option == "Loop head" then
                playAnim(35154961, 640, false)
            elseif option == "Head throw" then
                playAnim(35154961, 1, false)
            elseif option == "Rapid arm" then
                playAnim(259438880, 100, false)
            end  
        end,
    })

    local stopanimButton = lpTab:CreateButton({
        Name = "Stop animation",
        Interact = 'Click',
        Callback = function()
            for _, anim in pairs(game.Players.LocalPlayer.Character.Humanoid:FindFirstChild("Animator"):GetPlayingAnimationTracks()) do
                anim:Stop()
            end
        end,
    })

    local infstamina = lpTab:CreateToggle({
        Name = "Infinite Stamina",
        CurrentValue = false,
        Flag = "infstamina", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            local UIS = game:GetService("UserInputService")
            local xd = UIS.InputBegan:Connect(function(input, isTyping)
                if input.KeyCode == Enum.KeyCode.LeftShift and isTyping == false then
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 26
                end
            end)
            local xd2 = UIS.InputEnded:Connect(function(input, isTyping)
                if input.KeyCode == Enum.KeyCode.LeftShift and isTyping == false then
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
                end
            end)
            if Value == true then
                game.Players.LocalPlayer.PlayerGui.MainUI.Stamina.SprintHandler.Disabled = true
            else
                xd:Disconnect()
                xd2:Disconnect()
                game.Players.LocalPlayer.PlayerGui.MainUI.Stamina.SprintHandler.Disabled = false
            end
        end,
    })

    local Button = lpTab:CreateButton({
        Name = "Reset player",
        Interact = 'Click',
        Callback = function()
            game.Players.LocalPlayer.Character.Humanoid.Health = 0
        end,
    })

    local walkspeed = lpTab:CreateSlider({
        Name = "WalkSpeed",
        Range = { 16, 500 },
        Increment = 10,
        Suffix = "WS",
        CurrentValue = 16,
        Flag = "WS", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            disableAC()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end,
    })

    local jumppower = lpTab:CreateSlider({
        Name = "JumpPower",
        Range = { 39, 500 },
        Increment = 10,
        Suffix = "JP",
        CurrentValue = 39,
        Flag = "JP", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            disableAC()
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
        end,
    })

    local infjumptoggled = false
    local infjump = lpTab:CreateToggle({
        Name = "Infinite jump",
        Info = "Makes you fly by jumping without falling down", -- Speaks for itself, Remove if none.
        CurrentValue = false,
        Flag = "infjp", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            infjumptoggled = Value
            if infjumptoggled == true then
                spawn(function()
                    while wait() do
                        if infjumptoggled == false then break; end
                        game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
                        wait(0.1)
                        game.Players.LocalPlayer.Character.Humanoid:ChangeState("Seated")
                    end
                end)
            end
        end,
    })

    local fbtoggled = false
    local fb_connection

    local fullbright = lpTab:CreateToggle({
        Name = "Full bright",
        Info = "Will make your game look like its daytime", -- Speaks for itself, Remove if none.
        CurrentValue = false,
        Flag = "fb", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            fbtoggled = Value

            if Value == true then
                fb_connection = game:GetService("RunService").RenderStepped:Connect(function()
                    if fbtoggled == false then
                        fb_connection:Disconnect()
                        fb_connection = nil
                    end
                    game.Lighting.ClockTime = 12
                end)
            end
        end,
    })

    local phonetoggled = false
    local phone_connection = nil

    local devicetoggle = lpTab:CreateToggle({
        Name = "Disguise as a phone player",
        Info = "Will make your nametag display that your on phone", -- Speaks for itself, Remove if none.
        CurrentValue = false,
        Flag = "phone", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            phonetoggled = Value

            if Value == true then
                phone_connection = game:GetService("RunService").RenderStepped:Connect(function()
                    if phonetoggled == false then
                        phone_connection:Disconnect()
                        phone_connection = nil
                    end
                    game.ReplicatedStorage.NameTagStuff:WaitForChild("Device"):FireServer("mobile")
                end)
            end
        end,
    })

    local nocliptoggled = false
    local noclip_connection = nil

    local nocliptoggle = lpTab:CreateToggle({
        Name = "Noclip",
        Info = "Will let you walk through walls", -- Speaks for itself, Remove if none.
        CurrentValue = false,
        Flag = "noclip", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            nocliptoggled = Value

            if Value == true then
                noclip_connection = game:GetService("RunService").RenderStepped:Connect(function()
                    if game.Players.LocalPlayer.Character ~= nil then
                        for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                            if child:IsA("BasePart") and child.CanCollide == true then
                                child.CanCollide = false
                            end
                        end
                    end
                    if nocliptoggled == false then
                        noclip_connection:Disconnect()
                        noclip_connection = nil
                        if game.Players.LocalPlayer.Character ~= nil then
                            for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                                if child:IsA("BasePart") and child.CanCollide == false then
                                    child.CanCollide = true
                                end
                            end
                        end
                    end
                end)
            end
        end,
    })

    local stopsnowtoggled = false
    local stopsnow_connection = nil

    local stopsnowtoggle = lpTab:CreateToggle({
        Name = "Delete snow",
        CurrentValue = false,
        Flag = "stopsnow", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            stopsnowtoggled = Value

            if Value == true then
                game.Workspace:WaitForChild("ThatSnowRenderModel").Parent = game.CoreGui
                stopsnow_connection = game:GetService("RunService").RenderStepped:Connect(function()
                    if game.Players.LocalPlayer ~= nil then
                        if game.Players.LocalPlayer.PlayerScripts:WaitForChild("Snow").Disabled == false then
                            game.Players.LocalPlayer.PlayerScripts:WaitForChild("Snow").Disabled = true
                        end
                    end
                    if stopsnowtoggled == false then
                        stopsnow_connection:Disconnect()
                        stopsnow_connection = nil
                        if game.Players.LocalPlayer ~= nil then
                            if game.CoreGui:FindFirstChild("ThatSnowRenderModel") then
                                game.CoreGui:FindFirstChild("ThatSnowRenderModel").Parent = game.Workspace
                            end
                            if game.Players.LocalPlayer.PlayerScripts:WaitForChild("Snow").Disabled == true then
                                game.Players.LocalPlayer.PlayerScripts:WaitForChild("Snow").Disabled = false
                            end
                        end
                    end
                end)
            end
        end,
    })

    local call911toggled = false
    local call911_connection = nil

    local call911toggle = lpTab:CreateToggle({
        Name = "Spam 911 calls (USE ALT)",
        Info = "This is bannable and very risky!", -- Speaks for itself, Remove if none.
        CurrentValue = false,
        Flag = "call911", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            call911toggled = Value

            if Value == true then
                call911_connection = game:GetService("RunService").RenderStepped:Connect(function()
                    game:GetService("ReplicatedStorage").PhoneEvent:FireServer("911",{["Description"]="i shit myself",["Location"]="your mom's bed"})
                    
                    if call911toggled == false then
                        call911_connection:Disconnect()
                        call911_connection = nil
                    end
                end)
            end
        end,
    })

    local panicmodeButton = lpTab:CreateButton({
        Name = "Panic mode",
        Interact = 'Disables everything',
        Callback = function()
            call911toggle:Set(false)
            HBEpartToggle:Set(false)
            infstamina:Set(false)
            nocliptoggle:Set(false)
            fullbright:Set(false)
            devicetoggle:Set(false)
            infjump:Set(false)
            walkspeed:Set(16)
            jumppower:Set(39)
            stopsnowtoggle:Set(false)
            for _, anim in pairs(game.Players.LocalPlayer.Character.Humanoid:FindFirstChild("Animator"):GetPlayingAnimationTracks()) do
                anim:Stop()
            end
        end,
    })
    -- to be done: radio logger
end
