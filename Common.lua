
function Interrupt()
--Needs to scan if the monster should Be Interrupt and then pass to a skill manager to cast a spell classed as an Interrupt.
end

function NeedtoRest()
	if Player.mp.percent < 60  then
		d("Should Rest for Mana")
	end
end

function Rez()
	local Dead = FindDead()
	if Dead ~= nil then
	--Do Rez Rutine Here
	end
		
end

function FindDead()
	local pID = Player.id
	local el = EntityList("dead,friendly,chartype=4,myparty,targetable,exclude="..tostring(pID)..",maxdistance="..tostring(ml_global_information.AttackRange))
	if ( el ) then
		local i,e = next(el)
		if (i~=nil and e~=nil) then
			return e
		end
	end
end
