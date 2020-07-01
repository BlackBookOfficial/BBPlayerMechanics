-- Script made by JayJax aka Black Book --

local ishurt = false

-- The movement mechanics
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerYeet = GetPlayerPed(PlayerId())
		SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
		
		if Config.Enabled then
			if Config.HealthEnabled then
				if GetEntityHealth(playerYeet) <= Config.HealthRatio and GetEntityHealth(playerYeet) > Config.HealthRatioextreme then
					setHurt()
					
					if Config.StaminaEnabled then
						StaminaMechanicsOn()
					end
					
					SetCamEffect(1)
				elseif GetEntityHealth(playerYeet) <= Config.HealthRatioextreme then
					setHurtExtreme()
					
					if Config.StaminaEnabled then
						StaminaMechanicsOn()
					end
					
					SetCamEffect(2)
				elseif ishurt and GetEntityHealth(playerYeet) > Config.HealthRatio then
					setNotHurt()
					
					if Config.StaminaEnabled then
						StaminaMechanicsOff()
					end
					
					SetCamEffect(0)
					if ishurt then
						return
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15000)
		local playerYeet = GetPlayerPed(PlayerId())
		local health = GetEntityHealth(playerYeet)
			
		if Config.Enabled then
			if Config.HealthEnabled then
				if health <= 150 and health > 120 then
					exports['mythic_notify']:SendAlert('inform', 'I am feeling weird, might need a doctor!', 3000)
				elseif health <= 120 then
					exports['mythic_notify']:SendAlert('error', 'I am really hurt! I need a doctor!!!', 5000)
				elseif health > 160 and health < 190 then
					exports['mythic_notify']:SendAlert('inform', 'I might need a bandage', 2500)
				elseif health > 190 then
					exports['mythic_notify']:SendAlert('success', 'Feeling good', 2500)
				end
			end
		end
	end
end)

-- Functions
-- Do not touch unless you actually know the fuck you are doing...
function setHurt()
	local playerYeet = GetPlayerPed(PlayerId())
	
	RequestAnimSet("move_m@injured")
	SetPedMovementClipset(playerYeet, "move_m@injured", true)
	
	-- Other elements
	if Config.EnableAnimation then
		SetPedMotionBlur(playerYeet, true)
		SetPedIsDrunk(playerYeet, true)
	end
	ishurt = true
end

function setHurtExtreme()
	local playerYeet = GetPlayerPed(PlayerId())
	
	RequestAnimSet("move_m@injured")
	SetPedMovementClipset(playerYeet, "move_m@injured", true)
	
	-- Other elements
	if Config.EnableAnimation then
		SetPedMotionBlur(playerYeet, true)
		SetPedIsDrunk(playerYeet, true)
		SetTimecycleModifier("damage")
	end
	ishurt = true
end

function setNotHurt()
	local playerYeet = GetPlayerPed(PlayerId())
	
	ResetPedMovementClipset(playerYeet)
	ResetPedWeaponMovementClipset(playerYeet)
	ResetPedStrafeClipset(playerYeet)

	-- Other elements
	if Config.EnableAnimation then
		SetPedMotionBlur(playerYeet, false)
		SetPedIsDrunk(playerYeet, false)
		ClearTimecycleModifier()
	end
	ishurt = false
end

function StaminaMechanicsOn()
	local playerYeet = GetPlayerPed(PlayerId())
	
	RestorePlayerStamina(playerYeet, Config.StaminaRatio)
	
	-- Other elements
	if Config.EnableAnimation then
		if Config.ShakeEnabled then
			ShakeCam(GetRenderingCam(), 'DRUNK_SHAKE', 0)
		end
	end
end

function StaminaMechanicsOff()
	local playerYeet = GetPlayerPed(PlayerId())
	
	RestorePlayerStamina(playerYeet, Config.StaminaDefaultRatio)
	
	-- Other elements
	if Config.EnableAnimation then
		if Config.ShakeEnabled then
			ShakeCam(GetRenderingCam(), 'DRUNK_SHAKE', 1)
		end
	end
end
