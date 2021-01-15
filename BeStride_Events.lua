function BeStride:EventNewMount(arg1, arg2)
	BeStride:AddNewMount(arg2)
	BeStride:AddCommonMount(arg2)
	local mount = mountTable.master[arg2]
	
	if BeStride:DBGet("settings.mount.enablenew") then
		BeStride:DBSetMount(mount.type,arg2,true)
	else
		BeStride:DBSetMount(mount.type,arg2,false)
	end
end

function BeStride:EventUpdateKeyBinding()
end

function BeStride:EventCombatEnter()
	local combatButton = BeStride_Logic:Combat()
	if combatButton ~= nil then
		BeStride_ABRegularMount:SetAttribute("macrotext",combatButton)
		BeStride_ABGroundMount:SetAttribute("macrotext",combatButton)
		BeStride_ABPassengerMount:SetAttribute("macrotext",combatButton)
		BeStride_ABRepairMount:SetAttribute("macrotext",combatButton)
	end
	if BeStride_Logic:IsWorgen() then
		playerStatus.worgenform = true
	end
end

function BeStride:EventSpellCastSucceeded(arg1, arg2, arg3, arg4)
	if not (UnitAffectingCombat("player") or InCombatLockdown()) then
		if arg2 == "player" then
			if arg4 == BeStride_Constants.spells.worgen.twoforms then
				playerStatus.worgenform = not playerStatus.worgenform
			elseif arg4 == BeStride_Constants.spells.worgen.runningwild then
				playerStatus.worgenform = true
			elseif arg4 == BeStride_Constants.spells.worgen.darkflight then
				playerStatus.worgenform = true
			end
		end
	end
end

function BeStride:EventCombatExit()
	BeStride_ABRegularMount:SetAttribute("macrotext",nil)
	BeStride_ABGroundMount:SetAttribute("macrotext",nil)
	BeStride_ABPassengerMount:SetAttribute("macrotext",nil)
	BeStride_ABRepairMount:SetAttribute("macrotext",nil)
end