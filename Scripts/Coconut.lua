-- Credits to CJ4 for helping out with this script --

local loading = script:WaitForChild'loading' -- waitforchild waits for the item to load before assigning it
loading.Parent = game:service'Players'.LocalPlayer:WaitForChild'PlayerGui' -- enable the loading screen
repeat wait() until workspace.CurrentCamera ~= nil -- give time to allow loading of camera
repeat wait() until game:service'Players'.LocalPlayer.Character ~= nil -- give time to allow loading of player
wait(.5) -- give time to allow loading of assets
local cam = workspace.CurrentCamera -- the camera of the game
local rooms = workspace.rooms
local FocusPoint = rooms.room1.FocusPoint
local Camera = rooms.room1.POV
local Owner = game:service'Players'.LocalPlayer

cam.CameraType = Enum.CameraType.Scriptable -- disable default camera scripts
cam.FieldOfView = 30

local debounce = false -- basic cooldown

for _,room in pairs(rooms:GetChildren()) do -- single function for every room, easier life!!!
	room.teleportpart.Touched:connect(function(hit) -- triggered when player touches the teleport area
		if debounce == true then return end -- kill the function thread if it is still on cooldown
		if not (Owner.Character ~= nil and Owner.Character:FindFirstChild'HumanoidRootPart') then return end -- kill the function thread if the player is broken
		debounce = true -- enable cooldown
		local index = tonumber(string.sub(room.Name,5)) -- set the index to the room's actual number, rather than iteration count
		local roomto -- the room we want to go to
		if index+1 > #rooms:GetChildren() then -- if we have run out of rooms, go back to the start!
			roomto = rooms['room'..tostring(1)]
		else -- otherwise, go up one room!
			roomto = rooms['room'..tostring(index+1)]
		end
		FocusPoint = roomto.FocusPoint -- where the camera will look
		Camera = roomto.POV -- where the camera is positioned
		game:service'TweenService':Create( -- call the animation module
			cam, -- what to animate
			TweenInfo.new(.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut), -- the animation rules
			{CFrame=CFrame.new(Camera.Position,FocusPoint.Position)} -- what properties to animate
		):Play() -- play the created animation
		wait(.25) -- wait until player is most likely out of view before teleporting
		local Torso = Owner.Character:FindFirstChild'HumanoidRootPart' -- set to the player's body
		Torso.CFrame = roomto.teleportspot.CFrame -- teleport the player
		repeat wait() until (Torso.Position - roomto.teleportspot.Position).magnitude <= 5 -- wait until the player is teleported
		repeat wait() until (Torso.Position - roomto.teleportspot.Position).magnitude > 5 -- wait until the player leaves the new teleport area
		debounce = false -- disable cooldown
	end)
end


cam.CFrame = CFrame.new(Camera.Position,FocusPoint.Position)
game:service'TweenService':Create(loading.t,TweenInfo.new(1),{Transparency=1}):Play()
game:service'Debris':AddItem(loading,2)