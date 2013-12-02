
ffxiv_task_specifichunting = inheritsFrom(ml_task)
ffxiv_task_specifichunting.name = "LT_SPECIFICHUNTING"
ffxiv_task_specifichunting.ticks = 0
ffxiv_task_specifichunting.blTicks = 0

ffxiv_task_specifichunting = inheritsFrom(ml_task)
--Logic Unit
function ffxiv_task_specifichunting:Create()
    local newinst = inheritsFrom(ffxiv_task_specifichunting)
    
    --ml_task members
    newinst.valid = true
    newinst.completed = false
    newinst.subtask = nil
    newinst.auxiliary = false
    newinst.process_elements = {}
    newinst.overwatch_elements = {}
    
    --ffxiv_task_killtarget members
    newinst.name = "LT_SPECIFICHUNTING"
    
    return newinst
end
function ffxiv_task_specifichunting:Init()
    local ke_companion = ml_element:create( "Companion", c_companion, e_companion, 20 )
    self:add( ke_companion, self.overwatch_elements)
    
    local ke_companionstance = ml_element:create( "Companion Stance", c_companionstance, e_companionstance, 25 )
    self:add( ke_companionstance, self.process_elements)

	local ke_pethealassist = ml_element:create( "Pet Heal Assister", c_pethealassist, e_pethealassist, 15 )
    self:add( ke_pethealassist, self.overwatch_elements)

    self:AddTaskCheckCEs()
end
function ffxiv_task_specifichunting:OnSleep()

end
function ffxiv_task_specifichunting:OnTerminate()

end
function ffxiv_task_specifichunting:IsGoodToAbort()

end
function ffxiv_task_specifichunting:task_complete_eval()

end
function ffxiv_task_specifichunting:task_complete_execute()
    self.completed = true
end

--Pet
c_pethealassist = inheritsFrom( ml_cause )
e_pethealassist = inheritsFrom( ml_effect )
function c_pethealassist:evaluate()
    if ( ml_task_hub:CurrentTask().pos ~= nil and ml_task_hub:CurrentTask().pos ~= 0 and gPetHealAssist == "1" ) then
       if ( Player.pet ~= nil and Player.pet ~= 0) then
           return true
        end
    end
    
    return false
end
function e_pethealassist:execute()
	PetPartyHealAssist()
end

--Companion
c_companion = inheritsFrom( ml_cause )
e_companion = inheritsFrom( ml_effect )
function c_companion:evaluate()
    if ( ml_task_hub:CurrentTask().pos ~= nil and ml_task_hub:CurrentTask().pos ~= 0 and gChoco == "1" ) then
        if (not Player.ismounted and not ActionList:IsCasting() and not Player.incombat) then
            if CheckCompanion() == true then
				return true
			end
        end
    end
    
    return false
end
function e_companion:execute()
    Player:Stop()
    SummonCompanion()
end
c_companionstance = inheritsFrom( ml_cause )
e_companionstance = inheritsFrom( ml_effect )
function c_companionstance:evaluate()
    if ( ml_task_hub:CurrentTask().pos ~= nil and ml_task_hub:CurrentTask().pos ~= 0 and gChoco == "1" ) then
        if (not Player.ismounted and not ActionList:IsCasting() and not Player.incombat) then
			if CheckCompanion() == false then
				return true
			end
        end
    end
    
    return false
end
function e_companionstance:execute()
    CompanionStance()  
end