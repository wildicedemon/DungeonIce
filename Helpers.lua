function GetBestDungeonDPSMob ()
--Need to select monster based on aggeopercentage, monster prioritylist, tanks target, and maybe more.
end


--Return's what is targeting XX
	--Returns the lowesthealth entity that is targeting a partymember.
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
	--Returns the lowesthealth entity that is targeting a partymember who is also a player.
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
	--Returns the lowesthealth entity that is targeting a partymember that is a pet.
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

---------------------------------------------------------------------------------------------------------
--Attack
	--optimizes the placement of Ground Targeted AoE's UNFINISHED
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


--Healing
	--Return's the Best Heal Target that is also a tank with the lowest health.
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
	--Optimizes the placement of Ground Targeted Heals
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
	--This returns [true or false] weather or not a heal which whose origen is player based should be done based on the conditions passed to it.
function AoEHealPlayerBasedHealthCheck(MaxSpellRadius,HPCheckAmount,CountCheck)
local MSRadius = MaxSpellRadius  --//The Maximum Radius of the Spell from the Player.
local HPChkAmount = HPCheckAmount --//The Health Threshhold for counting as a Target.
local CountChk= CountCheck --//The Number Of Unit's whom meet the Spells Critira.
local Count = 0
local el = EntityList("alive,myparty,maxdistance="..tostring(MSRadius))
	if ( el ) then
		local i,e = next(el)
		while (i~=nil and e~=nil) do
			if e.hp.percent < HPChkAmount then
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
	----This returns [true or false] weather or not a heal which whose origen is target based should be done based on the conditions passed to it.
function AoEHealTargetBasedHPCheck(MaxSpellRange,MaxSpellRadius,HPCheckAmount,CountCheck)
local MSRange = MaxSpellRange --//The Maximum Range of the Spell.
local MSRadius = MaxSpellRadius --//The Maximum Radius of the Spell from the Player.
local HPChkAmount = HPCheckAmount --//The Health Threshhold for counting as a Target.
local CountChk= CountCheck --//The Number Of Unit's whom meet the Spells Critira.
local PrevCount = 0 --//The Previous Count Of Unit's whom meet the Spells Critira.
local PrevID = 0 
local EntityCount = 0
local el = EntityList("alive,myparty,maxdistance="..tostring(MSRange))
	if ( el ) then
	local i,e = next(el)
	while (i~=nil and e~=nil) do
	local el2 = EntityList("alive,myparty,distanceto="..e.id...",maxdistance="..tostring(MSRadius))
		if ( el2 ) then
			local i2,e2 = next(el2)
			while (i2~=nil and e2~=nil) do
					if e2.hp.percent <= HPChkAmount then
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


--Pet
	--This return's the entity whose health is lowest, within 35 yalms, and is in the party so that.
function GetBestSummonHealTarget()
	local el = EntityList("lowesthealth,friendly,chartype=4,myparty,alive,maxdistance="..tostring(35))
	if ( el ) then
		local i,e = next(el)
		if (i~=nil and e~=nil) then
			return e
		end
	end
	--ml_debug("GetBestHealTarget() failed with no entity found matching params")
	return nil
end

--Buff's
	--Return's [True or False] if the entity has the buff present.
function DoesEntityHaveBuff(BuffsToCheck,Entity)
	local Entity = 0
	local BuffsToChk = BuffsToCheck --//Id's of Buff's to check against current Entity Buffs.
	local EntityBuffs = Entity.buffs
	if (TableSize(EntityBuffs) > 0) then 							
		for buffid in StringSplit(BuffsToChk,",") do
			if (tonumber(buffid) ~= nil) then
				for i, buff in pairs(EntityBuffs) do
					if (buff.id == tonumber(buffid)) then--and buff.ownerid == PID) then
						return true
					end
				end	
			end
		end	    
	end
	return false
end
	--Return's [True or False] if the Player has the buff present.
function DoesPlayerHaveBuff(BuffsToCheck)
	local BuffsToChk = BuffsToCheck --//Id's of Buff's to check against current Player Buffs.
	local PlayerBuffs = Player.buffs        
	if (TableSize(PlayerBuffs) > 0) then 							
		for buffid in StringSplit(BuffsToChk,",") do
			if (tonumber(buffid) ~= nil) then
				for i, buff in pairs(PlayerBuffs) do
					if (buff.id == tonumber(buffid)) then--and buff.ownerid == PID) then
						return true
					end
				end	
			end
		end
	end
	return false	      
end
	--Return's [True or False] if a Party Member has the buff present.
function DoesPartyMemberHaveBuff(BuffsToCheck)
	local Entity = 0
	local BuffsToChk = BuffsToCheck --//Id's of Buff's to check against current Entity Buffs.
	local AllyBuffs = 0
	local partymemberlist = EntityList.myparty 
	local PartyID = ""
	if ( partymemberlist) then 
		local i,entity = next(partymemberlist) 
		while (i~=nil and entity ~=nil) 
		AllyBuffs = entity.buffs
			if (TableSize(AllyBuffs) > 0) then 							
				for buffid in StringSplit(BuffsToChk,",") do
					if (tonumber(buffid) ~= nil) then
						for i, buff in pairs(AllyBuffs) do
							if (buff.id == tonumber(buffid)) then--and buff.ownerid == PID) then
								return true
							end
						end	
					end
				end	    
			end		
			i,entity = next(partymemberlist,i) 		
		end	
		return false
	end
--Returns the First Party member that does not have the buff/s checked.
--Returns False if no member is found or not missing buff checked.
function ReturnPartyMemberNotHaveBuff(BuffsToCheck)
	local Entity = 0
	local BuffsToChk = BuffsToCheck --//Id's of Buff's to check against current Entity Buffs.
	local AllyBuffs = 0
	local partymemberlist = EntityList.myparty 
	local PartyID = ""
	if ( partymemberlist) then 
		local i,entity = next(partymemberlist) 
		while (i~=nil and entity ~=nil) 
		AllyBuffs = entity.buffs
			if (TableSize(AllyBuffs) > 0) then 							
				for buffid in StringSplit(BuffsToChk,",") do
					if (tonumber(buffid) ~= nil) then
						for i, buff in pairs(AllyBuffs) do
							if not (buff.id == tonumber(buffid)) then--and buff.ownerid == PID) then
								return entity
							end
						end	
					end
				end	    
			end		
			i,entity = next(partymemberlist,i) 		
		end	
		return false
	end




---------------------------------------------------------------------------------------------------------
--Fucntion's to be repurposed, Not doing all of the math -.-
--Need to work on conic skill calculations.
---------------------------------------------------------------------------------------------------------
function GetCone(radius,theta)
 
        --Build table of enemies in range
        n = 1
        v1,v2,v3 = 0,0,0
        largeN,largeV1,largeV2 = 0,0,0
        theta1,theta2,smallBisect = 0,0,0
        coneTargetsTable = {}
       
        for i = 1, heroManager.iCount, 1 do
        hero = heroManager:getHero(i)
        if ValidTarget(hero,radius) then-- and inRadius(hero,radius*radius) then
                        coneTargetsTable[n] = hero
                        n=n+1
                end
        end
 
        if #coneTargetsTable>=2 then -- true if calculation is needed
        --Determine if angle between vectors are < given theta
                for i=1, #coneTargetsTable,1 do
                        for j=1,#coneTargetsTable, 1 do
                                if i~=j then
                                        --Position vector from player to 2 different targets.
                                        v1 = Vector(coneTargetsTable[i].x-player.x , coneTargetsTable[i].z-player.z)
                                        v2 = Vector(coneTargetsTable[j].x-player.x , coneTargetsTable[j].z-player.z)
                                        thetav1 = sign(v1.y)*90-math.deg(math.atan(v1.x/v1.y))
                                        thetav2 = sign(v2.y)*90-math.deg(math.atan(v2.x/v2.y))
                                        thetaBetween = thetav2-thetav1                 
 
                                        if (thetaBetween) <= theta and thetaBetween>0 then --true if targets are close enough together.
                                                if #coneTargetsTable == 2 then --only 2 targets, the result is found.
                                                        largeV1 = v1
                                                        largeV2 = v2
                                                else
                                                        --Determine # of vectors between v1 and v2                                                     
                                                        tempN = 0
                                                        for k=1, #coneTargetsTable,1 do
                                                                if k~=i and k~=j then
                                                                        --Build position vector of third target
                                                                        v3 = Vector(coneTargetsTable[k].x-player.x , coneTargetsTable[k].z-player.z)
                                                                        --For v3 to be between v1 and v2
                                                                        --it must be clockwise to v1
                                                                        --and counter-clockwise to v2
                                                                        if areClockwise(v3,v1) and not areClockwise(v3,v2) then
                                                                                tempN = tempN+1
                                                                        end
                                                                end
                                                        end
                                                        if tempN > largeN then
                                                        --store the largest number of contained enemies
                                                        --and the bounding position vectors
                                                                largeN = tempN
                                                                largeV1 = v1
                                                                largeV2 = v2
                                                        end
                                                end
                                        end
                                end
                        end
                end
        elseif #coneTargetsTable==1 then
                return coneTargetsTable[1]
        end
       
        if largeV1 == 0 or largeV2 == 0 then
        --No targets or one target was found.
                return nil
        else
        --small-Bisect the two vectors that encompass the most vectors.
                if largeV1.y == 0 then
                        theta1 = 0
                else
                        theta1 = sign(largeV1.y)*90-math.deg(math.atan(largeV1.x/largeV1.y))
                end
                if largeV2.y == 0 then
                        theta2 = 0
                else
                        theta2 = sign(largeV2.y)*90-math.deg(math.atan(largeV2.x/largeV2.y))
                end
 
                smallBisect = math.rad((theta1 + theta2) / 2)
                vResult = {}
                vResult.x = radius*math.cos(smallBisect)+player.x
                vResult.y = player.y
                vResult.z = radius*math.sin(smallBisect)+player.z
               
                return vResult
        end
end

-- Conic Skill Usage
function isInsideSectorByAngle(Point, Center, Angle, AngleWidth, Radius)
        assert(VectorType(Point) and VectorType(Center) and type(Angle) == "number" and type(AngleWidth) == "number" and type(Radius) == "number", "isInsideSectorByAngle: wrong argument types (<Vector>, <Vector>, integer, integer, integer expected)")
        local TempPoint1 = FindPointOnCircle(Center, Angle-AngleWidth/2, Radius)
        local TempPoint2 = FindPointOnCircle(Center, Angle+AngleWidth/2, Radius)
        return isInsideSector(Point, Center, TempPoint1, TempPoint2)
end 
function isInsideSector(point, center, sectorStart, sectorEnd)
        assert(VectorType(point) and VectorType(center) and VectorType(sectorStart) and VectorType(sectorEnd), "isInsideSector: wrong argument types (<Vector>, <Vector>, <Vector>, <Vector> expected)")
        local relPoint = {}
        relPoint.x = point.x - center.x
        relPoint.z = point.x - center.z
        return (not areClockwise(sectorStart, relPoint) and areClockwise(sectorEnd, relPoint) and GetDistance(relPoint) < RRange)
end 
function FindPointOnCircle(Center, Angle, Radius)
        assert(VectorType(Center) and type(Angle) == "number" and type(Radius) == "number", "FindPointOnCircle: wrong argument types (<Vector>, integer, integer expected)")
        if Angle < 0 then
                Angle = 360-(Angle%360)
        end
        local ReturnAngle = {}
        ReturnAngle.x = math.sin(math.rad(Angle))*Radius + Center.x
        ReturnAngle.y = Center.y
        ReturnAngle.z = math.cos(math.rad(Angle))*Radius + Center.z
        return ReturnAngle
end 
function areClockwise(v1, v2)
        assert(VectorType(v1) and VectorType(v2), "areClockwise: wrong argument types (<Vector>, <Vector> expected)")
        if v1 ~= nil and v2 ~= nil then
                return ((-v1.x*v2.z + v1.z*v2.x) > 0)
        end
end 
function FindDegrees(Vector1, Vector2)
        assert(VectorType(Vector1) and VectorType(Vector2), "FindDegrees: wrong argument types (<Vector>, <Vector> expected)")
        return math.deg(math.atan2((Vector1.x-Vector2.x),(Vector1.z-Vector2.z)))
end 
-- Minimum Enclosing Circle Sector
function GetMECS(Center, AngleDegree, Radius, Minimum, Interval)
        assert(VectorType(Center) and type(AngleDegree) == "number" and type(Radius) == "number" and type(Minimum) == "number" and type(Interval) == "number", "GetMECS: wrong argument types (<Vector>, integer, integer, integer, integer expected)" )
        if Minimum == nil then Minimum = 0 end
        local Points = {}
        local EnemyCount = CountEnemyHeroInRange(Radius)
        local ReturnPoint
        if EnemyCount >= 2 then
                for i = 1, heroManager.iCount do
                        local enemy = heroManager:GetHero(i)
                        if ValidTarget(enemy, Radius) then
                                table.insert(Points, Vector(enemy))
                        end
                end
        end
        if EnemyCount == 0 or EnemyCount < Minimum then return end
        if EnemyCount == 1 and not EnemyCount < Minimum then
                for i = 1, heroManager.iCount do
                        local enemy = heroManager:getHero(i)
                        if ValidTarget(enemy, Radius) then
                                ReturnPoint = enemy
                                return ReturnPoint
                        end
                end
        if EnemyCount == 2 and not EnemyCount < Minimum then
                local TempAngle = FindDegrees(myHero, Vector((Points[1].x - Points[2].x) + Points[1].x, myHero.y, (Points[1].z - Points[2].z) + Points[1].z))
                if isInsideSectorByAngle(Points[1], Center, TempAngle, AngleDegree, Radius) and isInsideSectorByAngle(Points[2], Center, TempAngle, AngleDegree, Radius) then
                        return FindPointOnCircle(Center, TempAngle, Radius)
                else
                        return Points[1]
                end
        end
        if (EnemyCount > 2 and not EnemyCount < Minimum then
                local highestCount = 0
                local BestAngle = 0
                local Interval360 = 360 / Interval
                for i = 1, Interval360 do
                        local count = 0
                        local TestAngle = i*Interval
                        for _, enemy in ipairs(points) do
                                if isInsideSectorByAngle(enemy, Center, TestAngle, AngleDegree, Radius)
                                        count = count + 1
                                end
                        end
                        if count > highestCount then
                                BestAngle = TestAngle
                                highestCount = count
                        end
                end
                if highestCount >= Minimum then
                        return FindPointOnCircle(Center, BestAngle, Radius)
                end
        end