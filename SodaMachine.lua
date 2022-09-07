-- Credits to CJ4 for helping out with this script --

local serverstorage = game:GetService("ServerStorage")
local tool = serverstorage.BloxyCola
local part = script.Parent
local owned = false
-- "owned" is needed to make sure that the player doesn't fill up their inventory with soda. 
-- This is to avoid soda-induced server crashing. It exists, it's an engine issue.

part.ProximityPrompt.Triggered:connect(function(player)
	if not (player.Backpack:FindFirstChild(tool.Name) or player.Character:FindFirstChild(tool.Name)) then
		for _,v in pairs(player.Character:GetChildren()) do
			if v:IsA'Tool' then
				v.Parent = player.Backpack
			end
		end
		tool:clone().Parent = player.Character
	end
end)
-- ProximityPrompt is a engine tool that creates a pop-up once the player is close enough to the part with said ProximityPrompt

