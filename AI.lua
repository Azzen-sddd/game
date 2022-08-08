
local PFS = game:GetService("PathfindingService")

local path = PFS:CreatePath()


	local npc = script.Parent
	local hrpOfNPC = npc:WaitForChild("HumanoidRootPart")

	local plrsHit = {}

	local maxDistance = 150

	local debounce = false

	
	npc.Humanoid.Touched:Connect(function(touch)
		if debounce == false then
		debounce = true
		if touch.Name == "AntiMonsterPart" then
				script.Parent.Parent = game.ServerStorage
		else
				local player = game:GetService("Players"):GetPlayerFromCharacter(touch.Parent)
				if player then
					game.ReplicatedStorage.Remotes.Jumpscare:FireClient(game.Players:GetPlayerFromCharacter(touch.Parent), "drewbie")
					wait(2)
					touch.Parent.Humanoid:TakeDamage(100)
				end
		end
		
			
		wait(1)
		debounce = false		
		end
	end)

	while wait() do

		local plrs = game.Players:GetPlayers()

		local closestHRP

		for i, plr in pairs(plrs) do

			if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character.Humanoid.Health > 0 then

				local hrp = plr.Character.HumanoidRootPart

				local distanceBetween = (hrpOfNPC.Position - hrp.Position).Magnitude


				if not closestHRP then closestHRP = hrp end

				if (hrpOfNPC.Position - closestHRP.Position).Magnitude > distanceBetween then

					closestHRP = hrp

				end
			end
	end
	
	

	if closestHRP and (hrpOfNPC.Position - closestHRP.Position).Magnitude <= maxDistance then
					path:ComputeAsync(script.Parent.Root.Position, closestHRP.Position)
					local waypoints = path:GetWaypoints()

						for i, waypoint in pairs(waypoints) do
							--local part = Instance.new("Part")
							--part.Size = Vector3.new(0.6,0.6,0.6)
							--part.Shape = "Ball"
							--part.Material = "Neon"
							--part.Parent = workspace
							--part.Anchored = true
							--part.CanCollide = false
							--part.Position = waypoint.Position + Vector3.new(0,2,0)

							if waypoint.Action == Enum.PathWaypointAction.Jump then
								script.Parent.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
							end


							script.Parent.Humanoid:MoveTo(waypoint.Position)
							--script.Parent.Humanoid.MoveToFinished:Wait()


					end
				
			end
			
		
	end
