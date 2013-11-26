function GetBestHealTargetTank()
local tank1 = 0
local tank2 = 0
local el = EntityList("friendly,chartype=4,alive,myparty,targetable,maxdistance="..tostring(ml_global_information.AttackRange))
	if ( el ) then
		local i,e = next(el)
		while (i~=nil and e~=nil) do
			if e.job == (1 or 3 or 19 or 21) then
				if tank1 == 0 then
					tank1 = e
				end
				if tank2 == 0 then
					tank2 = e
				end
			end		
		local i,e = next(el,i) 
		end  
	end
	
	if tank2 ~= 0 and tank1 ~= 0 then
		if tank2 == 0 then
			return tank1
		end
			if tank1.hp.percent <= tank2.hp.percent then
				return tank1
			elseif tank2.hp.percent <= tank1.hp.percent then
				return tank2
			end
	end
	--ml_debug("GetBestHealTarget() failed with no entity found matching params")
	return nil
end
function AoEGroundBasedHealOptimization()
local count = 0
local PosSumX = 0
local PosSumY = 0
local PosSumZ = 0

local el = EntityList("alive,friendly,chartype=4,myparty,distanceto="..e.id..",maxdistance="..tostring(MaxSpellRadius))
	while i ~= nil and e ~=nil do
			PosSumX = PosSumX + e.pos.x
			PosSumY = PosSumY + e.pos.y
			PosSumZ = PosSumZ + e.pos.z
			count = count + 1
		local i,e = next(el, i)
	end
		PosSumX = (PosSumX / count)
		PosSumY = (PosSumY / count)
		PosSumZ = (PosSumZ / count)
end
function AoEGroundAttackOptimization()
local count = 0
local PosSumX = 0
local PosSumY = 0
local PosSumZ = 0

local el = EntityList("alive,attackable,onmesh,distanceto="..e.id..",maxdistance="..tostring(MaxSpellRadius)))
	while i ~= nil and e ~=nil do
		PosSumX = PosSumX + e.pos.x
		PosSumY = PosSumY + e.pos.y
		PosSumZ = PosSumZ + e.pos.z
		count = count + 1
		local i,e = next(el, i)
	end
	PosSumX = (PosSumX / count)
	PosSumY = (PosSumY / count)
	PosSumZ = (PosSumZ / count)	
end
function AoEPlayerBasedHealthCheck(MaxSpellRadius,HPCheckAmount,CountChk)
local MaxSpellRadius = 0  --//The Maximum Radius of the Spell from the Player.
local HPCheckAmount = 0 --//The Health Threshhold for counting as a Target.
local CountChk= 0 --//The Number Of Unit's whom meet the Spells Critira.
local Count = 0
local el = EntityList("alive,myparty,maxdistance="..tostring(MaxSpellRadius))
	if ( el ) then
		local i,e = next(el)
		while (i~=nil and e~=nil) do
			if e.hp.percent < HPCheckAmount then
				Count= Count + 1
			end

		local i,e = next(el,i)  
		
			if Count >= CountChk then
				return true
			else 
				return false
			end
		end  
	end
end
function AoETargetBasedHPCheck(MaxSpellRange,MaxSpellRadius,HPCheckAmount,CountChk)
local MaxSpellRange = 0 --//The Maximum Range of the Spell.
local MaxSpellRadius = 0 --//The Maximum Radius of the Spell from the Player.
local HPCheckAmount = 0 --//The Health Threshhold for counting as a Target.
local CountChk= 0 --//The Number Of Unit's whom meet the Spells Critira.
local PrevCount = 0 --//The Previous Count Of Unit's whom meet the Spells Critira.
local PrevID = 0 
local EntityCount = 0
local el = EntityList("alive,myparty,maxdistance="..tostring(MaxSpellRange))
	if ( el ) then
	local i,e = next(el)
	while (i~=nil and e~=nil) do
	local el2 = EntityList("alive,myparty,distanceto="..e.id...",maxdistance="..tostring(MaxSpellRadius))
		if ( el2 ) then
			local i2,e2 = next(el2)
			while (i2~=nil and e2~=nil) do
					if e2.hp.percent <= HPCheckAmount then
						EntityCount= EntityCount + 1
					end
				local i2,e2 = next(el2,i2)  
			end  
		end
			if EntityCount ~= 0 then
					if PrevCount < EntityCount then
						PrevCount = EntityCount
						PrevID = e.id
					end
				local i,e = next(el,i)  
			end  
			if (PrevCount ~= 0 or EntityCount ~= 0) and (PrevCount < EntityCount) then
				if PrevID > EntityCount then
					return PrevCount
				else
					return EntityCount
				end
			end
		end
	end
end
--Returns monsters that are targeting partymembers.
function GetTargetingPartyPlayer()
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
function GetTargetingPet()	
	local petlist= EntityList("nearest,contentid=1403")
	local petID = ""
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
function GetTargetingParty()
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