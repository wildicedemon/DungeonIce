function SwiftCastRez()
	local DeadPlayer = 0
	DeadPlayer = FindDead()
	local Raise = ActionList("type=1")
	local Rez = Raise[125]
	local acRez = ActionList:Get(Rez.id,DeadPlayer.id,1)
	if Player.job == (26 or 27 or 28) then
		Rez = Raise[173]
	end

	local SwiftCast = ActionList("type=1")
	local SCast = SwiftCast[150]
	local acSCast = ActionList:Get(SCast.id,1)
	if DeadPlayer ~= 0  then
		if DoesPlayerHaveBuff(167) == true then
			if (acRez.isready) then
				acRez:Cast()
			end
		end
		if DoesPlayerHaveBuff(167) == false then
			if (acSCast.isready) then
				acSCast:Cast()
			end
		end
	end
end