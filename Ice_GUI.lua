SpecificHunting={ }
function SpecificHunting.ModuleInit()
	GUI_NewWindow("SpecificHunting",1024,25,300,200)
	GUI_NewCheckbox("SpecificHunting", "Companion", "gChoco","Settings")
	GUI_NewField("SpecificHunting", "Companion's Name", "gCompanionName","Settings")
	GUI_NewCheckbox("SpecificHunting", "Companion's Stance", "gCompanionStance","Settings")
	GUI_NewComboBox("SpecificHunting","Stance","cbStance","Settings","Follow,Free Stance,Defender Stance,Attacker Stance,Healer Stance");
	GUI_NewCheckbox("SpecificHunting", "Pet PT Heal Assist", "gPetHealAssist","Settings")
	GUI_NewComboBox("SpecificHunting","Mount","cbMounts","Settings","Ahriman,Coeurl,Company Chocobo,Goobbue,Legacy Chocobo,Magitek Armor,Unicorn");
	GUI_NewCheckbox("SpecificHunting", "Claim Over Kill", "gPrioritize","Settings")
	GUI_NewCheckbox("SpecificHunting", "Attack XClaimed", "gXclaim","Settings")
	GUI_NewNumeric("SpecificHunting", "CoK Max Distance =", "gCoKd", "Settings", "0", "250")
	GUI_NewCheckbox("SpecificHunting", "Hunt Non-Prioritzed", "gHuntEx","Settings")
	GUI_NewCheckbox("SpecificHunting", "Party Mode", "gPartyMode","Settings")
	GUI_NewCheckbox("SpecificHunting", "Debugging", "gDebug","Settings")

	GUI_NewNumeric("SpecificHunting", "Content ID", "gContentID1", "Prioritized Targets", "0", "9999")
	GUI_NewNumeric("SpecificHunting", "Content ID", "gContentID2", "Prioritized Targets", "0", "9999")
	GUI_NewNumeric("SpecificHunting", "Content ID", "gContentID3", "Prioritized Targets", "0", "9999")
	GUI_NewNumeric("SpecificHunting", "Content ID", "gContentID4", "Prioritized Targets", "0", "9999")
	GUI_NewNumeric("SpecificHunting", "Content ID", "gContentID5", "Prioritized Targets", "0", "9999")
	GUI_NewNumeric("SpecificHunting", "Content ID", "gContentID6", "Prioritized Targets", "0", "9999")
	GUI_NewNumeric("SpecificHunting", "Exclude ID", "gExcludeID1", "Exclude", "0", "9999")
	GUI_NewNumeric("SpecificHunting", "Exclude ID", "gExcludeID2", "Exclude", "0", "9999")
	GUI_NewNumeric("SpecificHunting", "Exclude ID", "gExcludeID3", "Exclude", "0", "9999")
	GUI_NewNumeric("SpecificHunting", "Exclude ID", "gExcludeID4", "Exclude", "0", "9999")
	GUI_NewNumeric("SpecificHunting", "Exclude ID", "gExcludeID5", "Exclude", "0", "9999")
	GUI_NewNumeric("SpecificHunting", "Exclude ID", "gExcludeID6", "Exclude", "0", "9999")
	


	--DO NOT OPEN
--~ 	GUI_NewField("SpecificHunting", "Artifact Fix", "artfixvar","Fix")
	--GUI Size
	GUI_SizeWindow("SpecificHunting",250,300)
	
	SpecificHunting = Settings.FFXIVMINION.SpecificHunting
	
--~ 	Initialise()
	--Init Values


	


	if (Settings.SpecificHunting.gChoco == nil) then
		Settings.SpecificHunting.gChoco = "0"
	end	
	
	if (Settings.SpecificHunting.gCompanionName == nil) then
		Settings.SpecificHunting.gCompanionName = "0"
	end
	
	if (Settings.SpecificHunting.gCompanionStance == nil) then
		Settings.SpecificHunting.gCompanionStance = "0"
	end

	if (Settings.SpecificHunting.cbStance == nil) then
		Settings.SpecificHunting.cbStance = "Free Stance"
	end

	if (Settings.SpecificHunting.gPetHealAssist == nil) then
		Settings.SpecificHunting.gPetHealAssist = "Free Stance"
	end
	
	if (Settings.SpecificHunting.cbMounts == nil) then
		Settings.SpecificHunting.cbMounts = "Company Chocobo"
	end
	
	if (Settings.SpecificHunting.gPrioritize == nil) then
		Settings.SpecificHunting.gPrioritize = "0"
	end
		
	
	if (Settings.SpecificHunting.gXclaim == nil) then
		Settings.SpecificHunting.gXclaim = "0"
	end
	
	if (Settings.SpecificHunting.gCoKd == nil) then
		Settings.SpecificHunting.gCoKd = "37"
	end
	
	if (Settings.SpecificHunting.gHuntEx == nil) then
		Settings.SpecificHunting.gHuntEx = "0"
	end
	
	if (Settings.SpecificHunting.gPartyMode == nil) then
		Settings.SpecificHunting.gPartyMode = "0"
	end
	
	if (Settings.SpecificHunting.gDebug == nil) then
		Settings.SpecificHunting.gDebug = "0"
	end
	
	if (Settings.SpecificHunting.gContentID1 == nil) then
		Settings.SpecificHunting.gContentID1 = "0"
	end
	
	if (Settings.SpecificHunting.gContentID2 == nil) then
		Settings.SpecificHunting.gContentID2 = "0"
	end
	
	if (Settings.SpecificHunting.gContentID3 == nil) then
		Settings.SpecificHunting.gContentID3 = "0"
	end
	
	if (Settings.SpecificHunting.gContentID4 == nil) then
		Settings.SpecificHunting.gContentID4 = "0"
	end
	
	if (Settings.SpecificHunting.gContentID5 == nil) then
		Settings.SpecificHunting.gContentID5 = "0"
	end
	
	if (Settings.SpecificHunting.gContentID6 == nil) then
		Settings.SpecificHunting.gContentID6 = "0"
	end

	
	if (Settings.SpecificHunting.gExcludeID1 == nil) then
		Settings.SpecificHunting.gExcludeID1 = "0"
	end
	
	if (Settings.SpecificHunting.gExcludeID2 == nil) then
		Settings.SpecificHunting.gExcludeID2 = "0"
	end
	
	if (Settings.SpecificHunting.gExcludeID3 == nil) then
		Settings.SpecificHunting.gExcludeID3 = "0"
	end
	
	if (Settings.SpecificHunting.gExcludeID4 == nil) then
		Settings.SpecificHunting.gExcludeID4 = "0"
	end
	
	if (Settings.SpecificHunting.gExcludeID5 == nil) then
		Settings.SpecificHunting.gExcludeID5 = "0"
	end
	
	if (Settings.SpecificHunting.gExcludeID6 == nil) then
		Settings.SpecificHunting.gExcludeID6 = "0"
	end
	
	
	gChoco =  Settings.SpecificHunting.gChoco	
	gCompanionName =  Settings.SpecificHunting.gCompanionName
	gCompanionStance =  Settings.SpecificHunting.gCompanionStance
	cbStance = Settings.SpecificHunting.cbStance
	gPetHealAssist =  Settings.SpecificHunting.gPetHealAssist  
	cbMounts = Settings.SpecificHunting.cbMounts
	gPrioritize = Settings.SpecificHunting.gPrioritize
	gXclaim = Settings.SpecificHunting.gXclaim
	gCoKd = Settings.SpecificHunting.gCoKd
	gHuntEx = Settings.SpecificHunting.gHuntEx
	gPartyMode = Settings.SpecificHunting.gPartyMode
	gDebug = Settings.SpecificHunting.gDebug
	gContentID1 = Settings.SpecificHunting.gContentID1
	gContentID2 = Settings.SpecificHunting.gContentID2
	gContentID3 = Settings.SpecificHunting.gContentID3
	gContentID4 = Settings.SpecificHunting.gContentID4
	gContentID5 = Settings.SpecificHunting.gContentID5
	gContentID6 = Settings.SpecificHunting.gContentID6
	gExcludeID1 = Settings.SpecificHunting.gExcludeID1
	gExcludeID2 = Settings.SpecificHunting.gExcludeID2
	gExcludeID3 = Settings.SpecificHunting.gExcludeID3
	gExcludeID4 = Settings.SpecificHunting.gExcludeID4
	gExcludeID5 = Settings.SpecificHunting.gExcludeID5
	gExcludeID6 = Settings.SpecificHunting.gExcludeID6
end
function SpecificHunting.GUIVarUpdate(Event, NewVals, OldVals)
	--Companion Stance
	if cbStance == "Follow"  then
		stance = stancer[3]	
	elseif  cbStance == "Free Stance"  then
		stance = stancer[4]
	elseif  cbStance == "Defender Stance"  then
		stance = stancer[5]
	elseif  cbStance == "Attacker Stance"  then
		stance = stancer[6]	
	elseif  cbStance == "Healer Stance"  then
		stance = stancer[7]	
	end
	
	Debugy = gDebug
	
	--Mounts
	if  cbMounts == "Ahriman"  then
		mount = mounts[9]
	elseif  cbMounts == "Coeurl"  then
		mount = mounts[8]
	elseif  cbMounts == "Company Chocobo"  then
		mount = mounts[1]	
	elseif  cbMounts == "Goobbue"  then
		mount = mounts[4]	
	elseif  cbMounts == "Legacy Chocobo"  then
		mount = mounts[5]
	elseif  cbMounts == "Magitek Armor"  then
		mount = mounts[6]
	elseif  cbMounts == "Unicorn"  then
		mount = mounts[15]
	end
	
	for k,v in pairs(NewVals) do
		if (k == "gChoco" or
			k == "gCompanionName" or
			k == "gCompanionStance" or
			k == "cbStance" or
			k == "gPetHealAssist" or
			k == "cbMounts" or			
			k == "gPrioritize" or
			k == "gXclaim" or
			k == "gCoKd" or
			k == "gHuntEx" or
			k == "gPartyMode" or
			k == "gDebug" or
			k == "gContentID1" or
			k == "gContentID2" or
			k == "gContentID3" or
			k == "gContentID4" or
			k == "gContentID5" or
			k == "gContentID6" or
			k == "gExcludeID1" or
			k == "gExcludeID2" or
			k == "gExcludeID3" or
			k == "gExcludeID4" or
			k == "gExcludeID5" or
			k == "gExcludeID6")		    
		then
			Settings.SpecificHunting[tostring(k)] = v
		end
	end
	GUI_RefreshWindow("SpecificHunting")
end