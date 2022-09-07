function noshadow(plr)
	for _,v in pairs(plr.Character:GetDescendants()) do
		if v:IsA'BasePart' or v:IsA'MeshPart' then
			v.CastShadow = false
		end
	end
end
game:service'Players'.PlayerAdded:connect(function(plr)
	plr.CharacterAppearanceLoaded:connect(function()
		noshadow(plr)
	end)
end)
for _,plr in pairs(game:service'Players':GetPlayers()) do
	plr.CharacterAppearanceLoaded:connect(function()
		noshadow(plr)
	end)
	noshadow(plr)
end

-- This entire script exists just to remove the shadow that's automatically applied to the player by the engine 