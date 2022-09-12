wait(2)
print("Working!")

local cam = workspace.CurrentCamera
local player = game.Players.LocalPlayer
local FocusPoint = game.Workspace.FocusPoint
local Camera = game.Workspace.POV
-- FocusPoint and Camera are the start and finish point of the camera. Moving these in the engine moves the camera's POV


cam.CameraType = "Scriptable"
cam:Interpolate(Camera.CFrame, FocusPoint.CFrame, 0.1)
cam.FieldOfView = 30

-- Once the Type is changed to Scriptable, it's able to be altered.