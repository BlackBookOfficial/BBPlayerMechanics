-- Script made by JayJax aka Black Book --

local crouched = false

if Config.EnableCrouch then
	Citizen.CreateThread(function()
		while true do 
			Citizen.Wait(1)

			local ped = GetPlayerPed(PlayerId())

			if DoesEntityExist(ped) and not IsEntityDead(ped) and not IsPedInAnyVehicle(ped) then 
				DisableControlAction(0, 36, true) -- INPUT_DUCK  

				if not IsPauseMenuActive() then 
					if IsDisabledControlJustPressed(0, 36) then 
						RequestAnimSet("move_ped_crouched")

						while not HasAnimSetLoaded("move_ped_crouched") do 
							Citizen.Wait(100)
						end 

						if crouched == true then 
							ResetPedMovementClipset(ped, 0)
							crouched = false 
						elseif crouched == false then
							SetPedMovementClipset(ped, "move_ped_crouched", 0.25)
							crouched = true 
						end 
					end
				end 
			end 
		end
	end)
end