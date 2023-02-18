if game.PlaceId == 6735572261 then
_G.rainbow = true
while task.wait(.05) do
    if _G.rainbow == true then
        game:GetService("ReplicatedStorage").Remotes.Hair:FireServer(11, Color3.fromHSV(math.random(0,255),math.random(0,255),math.random(0,255)))
    end
end

game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg,r)
    msg = string.lower(msg)
    if string.find(msg, "/rh") then
        _G.rainbow = not _G.rainbow
    end
end)
end
