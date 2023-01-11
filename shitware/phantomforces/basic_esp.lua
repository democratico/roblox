local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(i,gpe)
	if i.KeyCode == _G.switchKey and gpe == false then
		_G.sex = not _G.sex
	end
end)

function raycast(plr, hitbox)
	local blacklistTable = { game:GetService("Players").LocalPlayer.Character }
	for _, obj in pairs(workspace.CurrentCamera:GetChildren()) do
		if obj:IsA("Model") then
			table.insert(blacklistTable, obj)
		end
	end
	rayxd = Ray.new(workspace.CurrentCamera.CFrame.p, plr.Torso.CFrame.p - workspace.CurrentCamera.CFrame.p)
	result = workspace:FindPartOnRayWithIgnoreList(rayxd, blacklistTable)

	-- W.I.P --
	if result.Transparency ~= 0 then
		local blacklistTable2 = { game:GetService("Players").LocalPlayer.Character,result }
		for _, obj in pairs(workspace.CurrentCamera:GetChildren()) do
			if obj:IsA("Model") then
				table.insert(blacklistTable2, obj)
			end
		end
		rayxd2 = Ray.new(workspace.CurrentCamera.CFrame.p, plr.Torso.CFrame.p - workspace.CurrentCamera.CFrame.p)
		result2 = workspace:FindPartOnRayWithIgnoreList(rayxd2, blacklistTable2)
		if result2.Parent == plr then
			hitbox.OutlineColor = Color3.fromRGB(0, 255, 0)
			hitbox.FillColor = Color3.fromRGB(16, 255, 16)
		else
			hitbox.OutlineColor = Color3.fromRGB(255, 0, 0)
			hitbox.FillColor = Color3.fromRGB(255, 16, 16)
		end
	end
	-- W.I.P --

	if result.Parent == plr then
		hitbox.OutlineColor = Color3.fromRGB(0, 255, 0)
		hitbox.FillColor = Color3.fromRGB(16, 255, 16)
	else
		hitbox.OutlineColor = Color3.fromRGB(255, 0, 0)
		hitbox.FillColor = Color3.fromRGB(255, 16, 16)
	end
end

function create(plr)
	local folder = Instance.new("Folder", game.CoreGui)
	folder.Name = plr.Name

	local BillboardGui = Instance.new("BillboardGui")
	--local TextLabel = Instance.new("TextLabel")

	BillboardGui.Parent = folder
	BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	BillboardGui.Active = true
	BillboardGui.Adornee = plr
	BillboardGui.AlwaysOnTop = true
	BillboardGui.ExtentsOffset = Vector3.new(0, 1.649999976158142, 0)
	BillboardGui.LightInfluence = 1.000
	BillboardGui.Size = UDim2.new(5, 0, 1, 0)

	--[[
			TextLabel.Parent = BillboardGui
			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.Position = UDim2.new(0, 0, 0.5, 0)
			TextLabel.Size = UDim2.new(1, 0, 0.5, 0)
			TextLabel.Font = Enum.Font.Arcade
			TextLabel.Text = plr.Name
			TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
			TextLabel.TextScaled = true
			TextLabel.TextSize = 14.000
			TextLabel.TextStrokeTransparency = 0.000
			TextLabel.TextWrapped = true
			]]

	local dist = Instance.new("BillboardGui")
	local TextLabel = Instance.new("TextLabel")

	dist.Name = "dist"
	dist.Parent = folder
	dist.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	dist.Active = true
	dist.Adornee = plr
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
	hitbox.Adornee = plr
	hitbox.OutlineColor = Color3.new(255, 0, 0)
	hitbox.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hitbox.FillColor = Color3.fromRGB(172, 16, 16)
	hitbox.FillTransparency = .4

	task.spawn(function()
		local hah
		hah = game:GetService("RunService").Heartbeat:Connect(function(step)
			if plr.Name == "Dead" or not plr.External or plr.Parent == workspace.Ignore.DeadBody or _G.sex == false then
				folder:Destroy()
				hah:Disconnect()
			end
			local dist = (workspace.CurrentCamera.CFrame.p - plr.Torso.CFrame.p).Magnitude
			TextLabel.Text = string.format("%.1f", dist) .. " studs"
			raycast(plr, hitbox)
		end)
	end)
end

function xd(reset)
	local enemyTeam = reset
	local connection

	if game:GetService("Players").LocalPlayer.Team.Name == "Phantoms" then
		enemyTeam = "Ghosts"
	else
		enemyTeam = "Phantoms"
	end
	if enemyTeam == "Ghosts" then
		for _, plr in pairs(workspace.Players:FindFirstChild("Bright orange"):GetChildren()) do
			create(plr)
		end
		connection = workspace.Players:FindFirstChild("Bright orange").ChildAdded:Connect(function(plr)
			create(plr)
		end)
	elseif enemyTeam == "Phantoms" then
		for _, plr in pairs(workspace.Players:FindFirstChild("Bright blue"):GetChildren()) do
			create(plr)
		end
		connection = workspace.Players:FindFirstChild("Bright blue").ChildAdded:Connect(function(plr)
			create(plr)
		end)
	end

	task.spawn(function()
		local hoh
		hoh = game:GetService("RunService").Heartbeat:Connect(function(step)
			if game:GetService("Players").LocalPlayer.Team.Name == enemyTeam or _G.sex == false then
				connection:Disconnect()
				hoh:Disconnect()
				for _, f in pairs(game.CoreGui:GetChildren()) do
					if f.Name == "Player" then
						f:Destroy()
					end
				end
				check()
			end
		end)
	end)
end

function check()
	local heh
	heh = game:GetService("RunService").Heartbeat:Connect(function(step)
		if _G.sex == true then
			heh:Disconnect()
			xd("")
		end
	end)
end

check()
