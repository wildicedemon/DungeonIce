
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

--Pet Heal the lowest Health party member, currently SetUp for EOS, and Selane
function PetPartyHealAssist()
local pet = Player.pet
local PetHeals = ActionList("type=11")
local PetHeal = PetHeals[32]
if pet.contentid == 1399 then
	local PetHeal = PetHeals[36]
end
local acPetHeal = ActionList:Get(PetHeal.id,PetHealTarget.id,13)
local PetHealTarget = GetBestSummonHealTarget()
	if Debugy == "1" then
		d("Entering Pet Heal Assist =  "..tostring(PetHealTarget.name))
	end
		if (PetHealTarget ~= nil) and(PetHealTarget.hp.percent < 100) then
			if Debugy == "1" then
				d("Preparing to Cast Embrace On =  "..tostring(PetHealTarget.name)..",  Hp Percentage at =  "..tostring(PetHealTarget.hp.percent))
			end
			if ( pet ~= nil and pet ~= 0) then
				if (acPetHeal.isready) then
					acPetHeal:Cast()
				end
			end
		end
end