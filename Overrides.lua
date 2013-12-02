--Functions in this file are meant to contain all functions that OVERRIDE all default bot functionality.

--Globals
mounts = ActionList("type=13")
mount = mounts[1]
stancer = ActionList("type=6")
stance = stancer[4]

--Misc
function ffxiv_task_killtarget:Init()
	--init ProcessOverWatch() cnes
	
	local ke_attarget = ml_element:create("AtTarget", c_attarget, e_attarget, 15)
	self:add( ke_attarget, self.overwatch_elements)
	
	local ke_bettertargetsearch = ml_element:create("SearchBetterTarget", c_bettertargetsearch, e_bettertargetsearch, 10)
	self:add( ke_bettertargetsearch, self.overwatch_elements)
	
	local ke_updateTarget = ml_element:create("UpdateTarget", c_updatetarget, e_updatetarget, 5)
	self:add( ke_updateTarget, self.overwatch_elements)
		
    --Process() cnes		    
	local ke_moveToTarget = ml_element:create( "MoveToTarget", c_movetotarget, e_movetotarget, 10 )
	self:add( ke_moveToTarget, self.process_elements)
	
	local ke_combat = ml_element:create( "AddCombat", c_add_combat, e_add_combat, 5 )
	self:add( ke_combat, self.process_elements)
	
    self:AddTaskCheckCEs()
end

--Mounting Function

function Mount()
		--dismiss Companion before mount.
		local dismisser = ActionList("type=6")
		local dismiss = dismisser[2]
		local acDismiss = ActionList:Get(dismiss.id,6)
		if (acDismiss.isready) then
			acDismiss:Cast()
		end
		
	if not(Player.ismounted) then
		if (acDismiss.isready) then
			acDismiss:Cast()
		end
		local acMount = ActionList:Get(mount.id,13)
		if (acMount.isready) then
			acMount:Cast()
		end
	end
end
function Dismount()
	if (Player.ismounted) then
		local mounts = ActionList("type=13")
		local mount = mounts[1]
		local acMount = ActionList:Get(mount.id,13)
		if (acMount.isready) then
			acMount:Cast()
		end
	end
end
--Heal Functions
function GetBestHealTarget()
	local pID = Player.id
	local el = EntityList("lowesthealth,alive,friendly,chartype=4,myparty,targetable,exclude="..tostring(pID)..",maxdistance="..tostring(ml_global_information.AttackRange))
	if ( el ) then
		local i,e = next(el)
		if (i~=nil and e~=nil) then
			return e
		end
	end
	
	local el = EntityList("lowesthealth,alive,friendly,chartype=4,targetable,exclude="..tostring(pID)..",maxdistance="..tostring(ml_global_information.AttackRange))
	if ( el ) then
		local i,e = next(el)
		if (i~=nil and e~=nil) then
			return e
		end
	end
	--ml_debug("GetBestHealTarget() failed with no entity found matching params")
	return nil
end


--Grind Functions
function GetNearestGrindAttackable()
	local minLevel = tostring(Player.level - tonumber(gMinMobLevel))
	local maxLevel = tostring(Player.level + tonumber(gMaxMobLevel))
	local prioritize  = gPrioritize
	local XClaimed = gXclaim
	local CoKd = gCoKd
	local HuntEx = gHuntEx
	local PartyMode = gPartyMode
	local MobID = (tostring(gContentID1)..","..tostring(gContentID2)..","..tostring(gContentID3)..","..tostring(gContentID4)..","..tostring(gContentID5)..","..tostring(gContentID6))
	local ExcludeID = (tostring(gExcludeID1)..","..tostring(gExcludeID2)..","..tostring(gExcludeID3)..","..tostring(gExcludeID4)..","..tostring(gExcludeID5)..","..tostring(gExcludeID6))
	
	if (ValidTable(ml_task_hub:CurrentTask())) then
		if (ml_task_hub:CurrentTask().name == "LT_GRIND" and ml_task_hub:CurrentTask().currentMarker ~= false) then
			local markerInfo = mm.GetMarkerInfo(ml_task_hub:CurrentTask().currentMarker)
			if (ValidTable(markerInfo)) then
				minLevel = markerInfo.minlevel
				maxLevel = markerInfo.maxlevel
			end
		end
	end
	
	
--prioritize claiming of monsters over killing, useful in highly competative areas.	
	if prioritize == "1" then
		for MobIDD in string.gmatch(MobID, "%d+") do
			if Debugy == "1" then
				d("ClaimOverKill Matching ID="..tostring(MobIDD))		
			end
--~ 			local el = EntityList("nearest,contentid="..MobIDD..",notincombat,alive,attackable,onmesh,fateid=0,maxdistance="..tostring(35)..",minlevel="..minLevel..",maxlevel="..maxLevel)
			local el = EntityList("nearest,contentid="..MobIDD..",targeting=0,notincombat,alive,attackable,onmesh,maxdistance="..tostring(CoKd))
			if ( el ) then
				local i,e = next(el)
				if (i~=nil and e~=nil) then
					if Debugy == "1" then
						d("Claim over Kill Enabled, EntityID= "..tostring(e))
					end
					return e
				end
			end
		end
	end	
	
--~ --should cuase the bot to finish off monsters if you are in a party.
	if PartyMode == "1" then	
		local petlist= EntityList("nearest,contentid=1403")
		local petID = ""
		local partymemberlist= EntityList.myparty 
		local PartyID = ""
		if ( partymemberlist) then 
			local i,entity = next(partymemberlist) 
			while (i~=nil and entity ~=nil) 
				do PartyID = tostring(entity.id) 
				local el = EntityList("lowesthealth,alive,attackable,onmesh,targeting="..PartyID)
					if ( el ) then
					    local i,e = next(el)
					    if (i~=nil and e~=nil) then
							if Debugy == "1" then
								d("Target PT Mode, EntityID= "..tostring(e))							
							end
						return e
					    end	
					end 		
				i,entity = next(partymemberlist,i) 		
			end	
		end
		if ( petlist) then 
			local i,entity = next(petlist) 
			while (i~=nil and entity ~=nil) 
				do petID = tostring(entity.id) 
				local el = EntityList("lowesthealth,alive,attackable,onmesh,targeting="..petID)
					if ( el ) then
						local i,e = next(el)
						if (i~=nil and e~=nil) then
							return e
						end    
					end         
				i,entity = next(petlist,i)         
			end    
		end 
	end

		
-- insures that the current monsters that are engaged are finished off before pulling another one,	
	local el = EntityList("lowesthealth,alive,attackable,onmesh,targetingme")
	if ( el ) then
	    local i,e = next(el)
	    if (i~=nil and e~=nil) then
		if Debugy == "1" then
			d("Finish Current Target, EntityID= "..tostring(e))							
		end
		return e
	    end
	end	
	
-- Specific Monster code that first seeks monsters not in combat, then the closet of said ContentID.
	
	for MobIDD in string.gmatch(MobID, "%d+") do			
		local el = EntityList("nearest,targeting=0,contentid="..MobIDD..",notincombat,alive,attackable,onmesh")
		if ( el ) then
			local i,e = next(el)
			if (i~=nil and e~=nil) then
				if Debugy == "1" then
					d("Target CoID, Exclude 1, EntityID= "..tostring(e))							
				end
				return e
			end
		end
		if XClaimed == "1" then 
			local el = EntityList("nearest,contentid="..MobIDD..",alive,attackable,onmesh")
			if ( el ) then
				local i,e = next(el)
				if (i~=nil and e~=nil) then
					if Debugy == "1" then
						d("Target CoID, Exclude 2, EntityID= "..tostring(e))							
					end
					return e
				end
			end
		end
	end

	
--No Match Found continue with Excluded monster results.
--Will not  hunt these unless HuntEx is set. Avoids grinding monsters that are not Specified.
	
	
	if HuntEx == "1" then
		local el = EntityList("nearest,exclude="..ExcludeID..",notincombat,alive,attackable,onmesh,targeting=0,fateid=0"..",minlevel="..minLevel..",maxlevel="..maxLevel)
		if ( el ) then
			local i,e = next(el)
			if (i~=nil and e~=nil) then
				if Debugy == "1" then
					d("Target NoCoID, Exclude 1, EntityID= "..tostring(e))							
				end
				return e
			end
		end
		
		if XClaimed == "1" then
			local el = EntityList("nearest,exclude="..ExcludeID..",alive,attackable,onmesh,fateid=0"..",minlevel="..minLevel..",maxlevel="..maxLevel)
			if ( el ) then
				local i,e = next(el)
				if (i~=nil and e~=nil) then
					if Debugy == "1" then
						d("Target NoCoID, Exclude 2, EntityID= "..tostring(e))							
					end
					return e
				end
			end
		end
	end	
	
-- If no Monster ID's have been set default to non prioritized code. I.e randoom monsters.
	if gContentID1 == "0" then	
	
		local el = EntityList("nearest,alive,notincombat,attackable,onmesh,targeting=0,fateid=0,minlevel="..minLevel..",maxlevel="..maxLevel)
		if ( el ) then
			local i,e = next(el)
			if (i~=nil and e~=nil) then	
				if Debugy == "1" then
					d("Target NoCoID 1 EntityID= "..tostring(e))							
				end			
				return e
			end
		end
		if XClaimed == "1" then		
			local el = EntityList("nearest,alive,attackable,onmesh,fateid=0,minlevel="..minLevel..",maxlevel="..maxLevel)
			if ( el ) then
				local i,e = next(el)
				if (i~=nil and e~=nil) then	
					if Debugy == "1" then
						d("Target NoCoID 2, EntityID= "..tostring(e))							
					end			
					return e
				end
			end
		end
		ml_debug("GetNearestAttackable() failed with no entity found matching params")
		return nil
	end
end

--Fate Functions
function GetNearestFateAttackable()
	local myPos = Player.pos
	local fateID = GetClosestFateID(myPos, true, true)
	local MobID = (tostring(gContentID1)..","..tostring(gContentID2)..","..tostring(gContentID3)..","..tostring(gContentID4)..","..tostring(gContentID5)..","..tostring(gContentID6))
	local ExcludeID = (tostring(gExcludeID1)..","..tostring(gExcludeID2)..","..tostring(gExcludeID3)..","..tostring(gExcludeID4)..","..tostring(gExcludeID5)..","..tostring(gExcludeID6))
	if (fateID ~= nil and fateID ~= 0) then
	
--should cuase the bot to finish off monsters if you are in a party.
	if PartyMode == "1" then
		local partymemberlist= EntityList.myparty 
		local PartyID = ""
		if ( partymemberlist) then 
			local i,entity = next(partymemberlist) 
			while (i~=nil and entity ~=nil) 
				do PartyID = tostring(entity.id) 
				local el = EntityList("nearest,alive,attackable,onmesh,targeting="..PartyID)
					if ( el ) then
					    local i,e = next(el)
					    if (i~=nil and e~=nil) then
						if Debugy == "1" then
							d("Fate-Target PT Mode, EntityID= "..tostring(e))							
						end
						return e
					    end	
					end 		
				i,entity = next(partymemberlist,i) 		
			end	
		end
	end

-- insures that the current monsters that are engaged are finished off before pulling another one,
	local el = EntityList("lowesthealth,alive,attackable,onmesh,targetingme")
	if ( el ) then
	    local i,e = next(el)
	    if (i~=nil and e~=nil) then
		if Debugy == "1" then
			d("Fate-Target Finish Current Target, EntityID= "..tostring(e))							
		end
		return e
	    end
	end	

-- Specific Monster code that first seeks monsters not in combat, then the closet of said ContentID.
	for MobIDD in string.gmatch(MobID, "%d+") do		
--~ 		local el = EntityList("nearest,contentid="..MobIDD..",notincombat,alive,attackable,onmesh,fateid="..tostring(fateID))
--~ 		if ( el ) then
--~ 			local i,e = next(el)
--~ 			if (i~=nil and e~=nil) then
--~ 				if Debugy == "1" then
--~ 					d("Fate-Target CoID 1, EntityID= "..tostring(e))							
--~ 				end
--~ 				return e
--~ 			end
--~ 		end
		
		local el = EntityList("nearest,contentid="..MobIDD..",alive,attackable,onmesh,fateid="..tostring(fateID))
		if ( el ) then
			local i,e = next(el)
			if (i~=nil and e~=nil) then
				if Debugy == "1" then
					d("Fate-Target CoID 2, EntityID= "..tostring(e))							
				end
				return e
			end
		end
	end
	
	
--No Match Found continue with Excluded monster results.
--Will not  hunt these unless HuntEx is set. Avoids grinding monsters that are not Specified.

	
--~ 	local el = EntityList("nearest,exclude="..ExcludeID..",notincombat,alive,attackable,onmesh,fateid="..tostring(fateID))
--~ 	if ( el ) then
--~ 		local i,e = next(el)
--~ 		if (i~=nil and e~=nil) then
--~ 			if Debugy == "1" then
--~ 				d("Fate-Target NoCoID, Exclude 1, EntityID= "..tostring(e))							
--~ 			end
--~ 			return e
--~ 		end
--~ 	end
	
	local el = EntityList("nearest,exclude="..ExcludeID..",alive,attackable,onmesh,,fateid="..tostring(fateID))
	if ( el ) then
		local i,e = next(el)
		if (i~=nil and e~=nil) then
			if Debugy == "1" then
				d("Fate-Target NoCoID, Exclude 2, EntityID= "..tostring(e))							
			end
			return e
		end
	end

	
-- If no Monster ID's have been set default to non prioritized code. I.e randoom monsters.
	if gContentID1 == "0" then	
-- insures that the current monsters that are engaged are finished off before pulling another one,
		local el = EntityList("lowesthealth,alive,attackable,onmesh,targetingme")
		if ( el ) then
		    local i,e = next(el)
		    if (i~=nil and e~=nil) then
			if Debugy == "1" then
				d("Target NoCoID 1, EntityID= "..tostring(e))							
			end
			return e
		    end
		end	

-- Specific Monster code that first seeks monsters not in combat, then the closet of said ContentID.
		local el = EntityList("nearest,notincombat,alive,attackable,onmesh,fateid="..tostring(fateID))
		if ( el ) then
			local i,e = next(el)
			if (i~=nil and e~=nil) then
				if Debugy == "1" then
					d("Target NoCoID 2, EntityID= "..tostring(e))							
				end
				return e
			end
		end
	
		local el = EntityList("nearest,alive,attackable,onmesh,fateid="..tostring(fateID))
		if ( el ) then
			local i,e = next(el)
			if (i~=nil and e~=nil) then
				if Debugy == "1" then
					d("Target NoCoID 3, EntityID= "..tostring(e))							
				end
				return e
			end
		end		
		ml_debug("GetNearestAttackable() failed with no entity found matching params")
		return nil
	end
end
end


--Modifyed to allow for the use of SwiftCast + summon of Pet in the skill manager
function SkillMgr.IsPetSummonSkill(skillID)
	
	if (	skillID == 165
		or  skillID == 150
		or 	skillID == 170
		or 	skillID == 180) then
		return true
	end
	return false
end