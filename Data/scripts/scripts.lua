-- define lua functions 
function NoOp(self, source)
end


function kill(self) -- Kill unit self.
	ExecuteAction("NAMED_KILL", self);
end

function RadiatePhialFear( self )
	ObjectBroadcastEventToEnemies( self, "BeAfraidOfPhial", 75 )
end

function RadiateUncontrollableFear( self )
	ObjectBroadcastEventToEnemies( self, "BeUncontrollablyAfraid", 350 )
end

function RadiateGateDamageFear(self)
	ObjectBroadcastEventToAllies(self, "BeAfraidOfGateDamaged", 200)
end

function RadiateBalrogFear(self)
	ObjectBroadcastEventToEnemies(self, "BeAfraidOfBalrog", 180)
end

function OnMumakilCreated(self)
	ObjectHideSubObjectPermanently( self, "Houda", true )
	ObjectHideSubObjectPermanently( self, "Houda01", true )
end

function OnTrollCreated(self)
	ObjectHideSubObjectPermanently( self, "Trunk01", true )
end

function OnEntCreated(self)
	ObjectHideSubObjectPermanently( self, "ROCK", true )
end

function GoIntoRampage(self)
	ObjectEnterRampageState(self)
		
	--Broadcast fear to surrounding unit(if we actually rampaged)
	if ObjectTestModelCondition(self, "WEAPONSET_RAMPAGE") then
		ObjectBroadcastEventToUnits(self, "BeAfraidOfRampage", 250)
	end
end

function MakeMeAlert(self)
	ObjectEnterAlertState(self)
end

function BeEnraged(self)
	--Broadcast enraged to surrounding units.
	ObjectBroadcastEventToAllies(self, "BeingEnraged", 500)
end

function BecomeEnraged(self)
	ObjectSetEnragedState(self, true)
end

function StopEnraged(self)
	ObjectSetEnragedState(self, false)
end

function BecomeUncontrollablyAfraid(self, other)
	if not ObjectTestCanSufferFear(self) then
		return
	end

	ObjectEnterUncontrollableCowerState(self, other)
end

function BecomeAfraidOfRampage(self, other)
	if not ObjectTestCanSufferFear(self) then
		return
	end

	ObjectEnterCowerState(self, other)
end

function BecomeAfraidOfBalrog(self, other)
	if not ObjectTestCanSufferFear(self) then
		return
	end

	ObjectEnterCowerState(self, other)
end

function RadiateTerror(self, other)
	ObjectBroadcastEventToEnemies(self, "BeTerrified", 180)
end
	

function BecomeTerrified(self, other)
	if not ObjectTestCanSufferFear(self) then
		return
	end
	
	ObjectEnterRunAwayPanicState(self, other)
end

function BecomeAfraidOfGateDamaged(self, other)
	if not ObjectTestCanSufferFear(self) then
		return
	end

	ObjectEnterCowerState(self,other)
end


function ChantForUnit(self) -- Used by units to broadcast the chant event to their own side.
	ObjectBroadcastEventToAllies(self, "BeginChanting", 9999)
end

function StopChantForUnit(self) -- Used by units to stop the chant event to their own side.
	ObjectBroadcastEventToAllies(self, "StopChanting", 9999)
end

function BeginCheeringForGrond(self)
	ObjectSetChanting(self, true)
end

function StopCheeringForGrond(self)
	ObjectSetChanting(self, false)
end

function OnMordorArcherCreated(self)
	ObjectHideSubObjectPermanently( self, "ARROWFIRE", true )
end

function MordorFighterBecomeUncontrollablyAfraid(self,other)
	local wasAfraid = ObjectTestModelCondition(self, "EMOTION_AFRAID")

	BecomeUncontrollablyAfraid(self,other)                 -- Call base function appropriate to many unit types
	
	-- Play unit-specific sound, but only when first entering state (not every time troll sends out fear message!)
	-- BecomeAfraidOfTroll may fail, don't play sound if we didn't enter fear state
		if ( not wasAfraid ) and ObjectTestModelCondition(self, "EMOTION_AFRAID") then
		ObjectPlaySound(self, "MordorFighterEntFear") 
	end
end

function MordorFighterBecomeAfraidOfPhial(self,other)
	local wasAfraid = ObjectTestModelCondition(self, "EMOTION_AFRAID")

	BecomeUncontrollablyAfraid(self,other)
	-- BecomeAfraidOfTroll(self,other)                 -- Call base function appropriate to many unit types
	
	-- Play unit-specific sound, but only when first entering state (not every time troll sends out fear message!)
	-- BecomeAfraidOfTroll may fail, don't play sound if we didn't enter fear state
--		if ( not wasAfraid ) and ObjectTestModelCondition(self, "EMOTION_AFRAID") then
--			ObjectPlaySound(self, "MordorFighterEntFear") 
--		end
end


function ShelobBecomeAfraidOfPhial(self,other)
	local wasAfraid = ObjectTestModelCondition(self, "EMOTION_AFRAID")

	BecomeUncontrollablyAfraid(self,other)
	-- BecomeAfraidOfTroll(self,other)                 -- Call base function appropriate to many unit types
	
	-- Play unit-specific sound, but only when first entering state (not every time troll sends out fear message!)
	-- BecomeAfraidOfTroll may fail, don't play sound if we didn't enter fear state
--		if ( not wasAfraid ) and ObjectTestModelCondition(self, "EMOTION_AFRAID") then
--			ObjectPlaySound(self, "MordorFighterEntFear") 
--		end
end

function OnGondorFighterCreated(self)
	ObjectHideSubObjectPermanently( self, "Forged_Blade", true )
end

function OnAragornCreated(self)
	ObjectHideSubObjectPermanently( self, "PLANE02", true )
end

function OnGondorArcherCreated(self)
	-- ObjectHideSubObjectPermanently( self, "arrow", true )		-- This gets hidden pending the art being fixed.  it is the pre-new-archer-firing-pattern arrow
	ObjectHideSubObjectPermanently( self, "FireArowTip", true ) -- This gets hidden because the Fire Arrow upgrade turns it on.
end

function OnLegolasCreated(self)
	-- ObjectHideSubObjectPermanently( self, "arrow02", true )		-- This gets hidden pending the art being fixed.  it is the pre-new-archer-firing-pattern arrow
	-- ObjectHideSubObjectPermanently( self, "arrow", true )		-- This gets hidden pending the art being fixed.  it is the pre-new-archer-firing-pattern arrow
end

function OnRohanArcherCreated(self)
	ObjectHideSubObjectPermanently( self, "FireArowTip", true ) -- yes, it's a typo in the art.
	-- ObjectHideSubObjectPermanently( self, "ArrowNock", true )
	-- ObjectHideSubObjectPermanently( self, "arrow", true )
end

function GondorFighterBecomeAfraid(self, other)
	if not ObjectTestCanSufferFear(self) then
		return
	end

	ObjectPlaySound(self, "GondorSoldierScream")
	
	-- An object has a 100% chance to become afraid.
	-- An object has a 66% chance to be feared, 33% chance to run away.
	if GetRandomNumber() <= 0.67 then 
		ObjectEnterFearState(self, other, false) -- become afraid of other.
	else --if GetRandomNumber() > 0.67 then
		ObjectEnterRunAwayPanicState(self, other) -- run away.

	end
end


function GondorFighterBecomeAfraidOfGateDamaged(self, other)
	local wasAfraid = ObjectTestModelCondition(self, "EMOTION_AFRAID")

	BecomeAfraidOfGateDamaged(self,other)                 -- Call base function appropriate to many unit types
	
	-- Play unit-specific sound, but only when first entering state (not every time troll sends out fear message!)
	-- BecomeAfraidOfGateDamaged may fail, don't play sound if we didn't enter fear state
	
	if ( not wasAfraid ) and ObjectTestModelCondition(self, "EMOTION_AFRAID") then
		ObjectPlaySound(self, "GondorSoldierScream")	
	end
end

function GondorFighterRecoverFromTerror(self)
	-- Add recovery sound
	ObjectPlaySound(self, "GondorSoldierRecoverFromTerror")
end

function SpyMoving(self, other)
	print(ObjectDescription(self).." spying movement of "..ObjectDescription(other));
end

function GandalfConsiderUsingDefensePower(self, other, delay, amount)
	-- Put up the shield if a big attack is coming and we have time to block it
	if tonumber(delay) > 1 then
		if tonumber(amount) >= 100 then
			ObjectDoSpecialPower(self, "SpecialPowerShieldBubble")
			return
		end
	end
	
	-- Or, if we are being hit and there are alot of guys arround, do our cool pushback power
	if tonumber(ObjectCountNearbyEnemies(self, 50)) >= 4 then
		ObjectDoSpecialPower(self, "SpecialPowerTelekeneticPush")
		return
	end
end

function GandalfTriggerWizardBlast(self)
	ObjectCreateAndFireTempWeapon(self, "GandalfWizardBlast")
end

function SarumanConsiderUsingDefensePower(self, other, delay, amount)
	-- Put up the shield if a big attack is coming and we have time to block it
--E4	if tonumber(delay) > 1 then
--E4		if tonumber(amount) >= 25 then
--E4			ObjectDoSpecialPower(self, "SpecialPowerShieldBubble")
--E4			return
--E4		end
--E4	end
	
	-- Or, if we are being hit and there are alot of guys arround, do our cool pushback power
	if tonumber(ObjectCountNearbyEnemies(self, 50)) >= 4 then
		ObjectDoSpecialPower(self, "SpecialPowerTelekeneticPush")
		return
	end
end

function BalrogTriggerBreatheFire(self)
	ObjectCreateAndFireTempWeapon(self, "MordorBalrogBreath")
end

function OnRohirrimCreated(self)
	ObjectHideSubObjectPermanently( self, "Forged_Blade", true )
	ObjectHideSubObjectPermanently( self, "SHIELD", true )
	ObjectHideSubObjectPermanently( self, "FireArowTip", true )
	ObjectHideSubObjectPermanently( self, "HELMET01", true )
	ObjectHideSubObjectPermanently( self, "HELMET02", true )
	ObjectHideSubObjectPermanently( self, "HELMET03", true )	
	-- define the locals as random numbers
	local helmet 			=	GetRandomNumber()	
	if helmet <= 0.3 then
		ObjectHideSubObjectPermanently( self, "HELMET01", false )
	elseif helmet <= 0.6 then
		ObjectHideSubObjectPermanently( self, "HELMET02", false )
	else
		ObjectHideSubObjectPermanently( self, "HELMET03", false )
	end
end

function OnSummonedRohirrimCreated(self)
	ObjectGrantUpgrade( self, "Upgrade_RohanHeavyArmor" )
	ObjectGrantUpgrade( self, "Upgrade_RohanHorseShield" )
	ObjectHideSubObjectPermanently( self, "Forged_Blade", true )
end

function OnGondorCavalryCreated(self)
	ObjectHideSubObjectPermanently( self, "Forged_Blade", true )
	ObjectHideSubObjectPermanently( self, "sshield", true )
end

function OnBallistaCreated(self)
	ObjectHideSubObjectPermanently( self, "MinedArrow", true )
end

function OnCatapultCreated(self)
	ObjectHideSubObjectPermanently( self, "PROJECTILEROCK", true )
	ObjectHideSubObjectPermanently( self, "FIREPLANE", true )
end

function OnTrebuchetCreated(self)
	ObjectHideSubObjectPermanently( self, "FIREPLANE", true )
end

function OnPorterCreated(self)
	ObjectHideSubObjectPermanently( self, "ARROWS", true )
	ObjectHideSubObjectPermanently( self, "BRAZIER", true )
	ObjectHideSubObjectPermanently( self, "BOWS", true )
	ObjectHideSubObjectPermanently( self, "TREBUCHET_FIRE", true )
	ObjectHideSubObjectPermanently( self, "SWORDS", true )
	ObjectHideSubObjectPermanently( self, "SHIELDS", true )
	ObjectHideSubObjectPermanently( self, "ARMOR", true )
	ObjectHideSubObjectPermanently( self, "BANNERS", true )
end

function OnOrcPorterCreated(self)
	ObjectHideSubObjectPermanently( self, "Forged_Blade", true )
	ObjectHideSubObjectPermanently( self, "SWORD_UPGRADES", true )
	ObjectHideSubObjectPermanently( self, "ARROW_UPGRADE", true )
	ObjectHideSubObjectPermanently( self, "ARMOR_UPGRADE", true )
	ObjectHideSubObjectPermanently( self, "GOLD", true )
	ObjectHideSubObjectPermanently( self, "FireArowTip", true )
end

function OnPeasantCreated(self)
	ObjectHideSubObjectPermanently( self, "HELMET", true )
	ObjectHideSubObjectPermanently( self, "SWORD", true )
	ObjectHideSubObjectPermanently( self, "HAMMER", false )
	ObjectHideSubObjectPermanently( self, "FORGED_BLADE", true )
	ObjectHideSubObjectPermanently( self, "SHIELD", true )
	ObjectHideSubObjectPermanently( self, "Broom", true )
end

function OnMordorSauronCreated(self)
	ObjectHideSubObject( self, "SHARD01", true )
	ObjectHideSubObject( self, "SHARD02", true )
	ObjectHideSubObject( self, "SHARD03", true )
	ObjectHideSubObject( self, "SHARD04", true )
	ObjectHideSubObject( self, "SHARD05", true )
	ObjectHideSubObject( self, "SHARD06", true )
	ObjectHideSubObject( self, "SHARD07", true )
	ObjectHideSubObject( self, "SHARD08", true )
	ObjectHideSubObject( self, "SHARD09", true )
	ObjectHideSubObject( self, "SHARD10", true )
	ObjectHideSubObject( self, "SHARD11", true )
	ObjectHideSubObject( self, "SHARD12", true )
	ObjectHideSubObject( self, "SHARD13", true )
	ObjectHideSubObject( self, "SHARD14", true )
	ObjectHideSubObject( self, "SHARD15", true )
	ObjectHideSubObject( self, "SHARD16", true )
	ObjectHideSubObject( self, "SHARD17", true )
	ObjectHideSubObject( self, "SHARD18", true )
	ObjectHideSubObject( self, "SHARD19", true )
	ObjectHideSubObject( self, "SHARD20", true )
end

function OnElvenWarriorCreated(self)
	ObjectHideSubObject( self, "ARROW", true )
	ObjectHideSubObject( self, "ARROWNOCK", true )
	ObjectHideSubObjectPermanently( self, "Forged_Blade", true )
	ObjectHideSubObjectPermanently( self, "FIREAROWTIP", true )
end

function OnIsengardFighterCreated(self)
	ObjectHideSubObjectPermanently( self, "Forged_Blade", true )
	ObjectHideSubObjectPermanently( self, "SHIELD", true )
end

function OnIsengardArcherCreated(self)
	ObjectHideSubObject( self, "ARROWNOCK", true )
	ObjectHideSubObjectPermanently( self, "FIREAROWTIP", true )
end

function OnGarrisonableCreated(self)
	ObjectHideSubObjectPermanently( self, "GARRISON01", true )
	ObjectHideSubObjectPermanently( self, "GARRISON02", true )
end

-- MME Scripts

function OnRohirrimArcherCreated(self)
	ObjectHideSubObjectPermanently( self, "FireArowTip", true )	
	-- hide all helmets
	ObjectHideSubObjectPermanently( self, "HELMET01", true )
	ObjectHideSubObjectPermanently( self, "HELMET02", true )
	ObjectHideSubObjectPermanently( self, "HELMET03", true )	
	-- define the locals as random numbers
	local helmet 			=	GetRandomNumber()	
	if helmet <= 0.3 then
		ObjectHideSubObjectPermanently( self, "HELMET01", false )
	elseif helmet <= 0.6 then
		ObjectHideSubObjectPermanently( self, "HELMET02", false )
	else
		ObjectHideSubObjectPermanently( self, "HELMET03", false )
	end
end

function OnMordorOrcFighterCreated(self)

	-- comments:
	-- this function is very long, because of all the different subobjects we have to choose from
	-- the basic order is: hide everything, choose a helmet, choose all other equipment depending on the fact if a helmet is shown or not

	
	-- hide all heads
	ObjectHideSubObjectPermanently( self, "HEAD02", true )
	ObjectHideSubObjectPermanently( self, "HELMET_HEAD01", true )
	ObjectHideSubObjectPermanently( self, "HELMET_HEAD02", true )
	ObjectHideSubObjectPermanently( self, "HELMET_HEAD03", true )
	ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD01", true )
	ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD02", true )
	ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD03", true )
	ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD04", true )
	
	-- hide all hair
	ObjectHideSubObjectPermanently( self, "NOHELMET_HAIR01", true )
	ObjectHideSubObjectPermanently( self, "NOHELMET_HAIR02", true )
	ObjectHideSubObjectPermanently( self, "HELMET_HAIR01", true )
	
	-- hide all helmets
	ObjectHideSubObjectPermanently( self, "HELMET_01", true )
	ObjectHideSubObjectPermanently( self, "HELMET_02", true )
	ObjectHideSubObjectPermanently( self, "HELMET_03", true )
	ObjectHideSubObjectPermanently( self, "HELMET_04", true )
	ObjectHideSubObjectPermanently( self, "HELMET_05", true )
	ObjectHideSubObjectPermanently( self, "HELMET_06", true )
	ObjectHideSubObjectPermanently( self, "HELMET_07", true )
	ObjectHideSubObjectPermanently( self, "HELMET_08", true )
	ObjectHideSubObjectPermanently( self, "HELMET_09", true )
	
	--hide all right hand equipments (only weapons)
	ObjectHideSubObjectPermanently( self, "RIGHT_SWORD01", true )
	ObjectHideSubObjectPermanently( self, "RIGHT_SWORD02", true )
	ObjectHideSubObjectPermanently( self, "RIGHT_SWORD03", true )
	ObjectHideSubObjectPermanently( self, "RIGHT_SWORD04", true )
	ObjectHideSubObjectPermanently( self, "RIGHT_SPEAR01", true )
	ObjectHideSubObjectPermanently( self, "RIGHT_SPEAR02", true )
	ObjectHideSubObjectPermanently( self, "RIGHT_SPEAR03", true )
	ObjectHideSubObjectPermanently( self, "RIGHT_SPEAR04", true )
	ObjectHideSubObjectPermanently( self, "RIGHT_AXE01", true )
	ObjectHideSubObjectPermanently( self, "RIGHT_AXE02", true )
	ObjectHideSubObjectPermanently( self, "RIGHT_AXE03", true )
	ObjectHideSubObjectPermanently( self, "RIGHT_AXE04", true )
	ObjectHideSubObjectPermanently( self, "RIGHT_MACE01", true )
	ObjectHideSubObjectPermanently( self, "RIGHT_MACE02", true )
	ObjectHideSubObjectPermanently( self, "RIGHT_MACE03", true )
	
	--hide all left hand equipments (shields and weapons)
	ObjectHideSubObjectPermanently( self, "LEFT_SHIELD01", true )
	ObjectHideSubObjectPermanently( self, "LEFT_SHIELD02", true )
	ObjectHideSubObjectPermanently( self, "LEFT_SHIELD03", true )
	ObjectHideSubObjectPermanently( self, "LEFT_SHIELD04", true )
	ObjectHideSubObjectPermanently( self, "LEFT_SHIELD05", true )
	ObjectHideSubObjectPermanently( self, "LEFT_SHIELD06", true )
	ObjectHideSubObjectPermanently( self, "LEFT_SWORD01", true )
	ObjectHideSubObjectPermanently( self, "LEFT_SWORD02", true )
	ObjectHideSubObjectPermanently( self, "LEFT_SWORD03", true )
	ObjectHideSubObjectPermanently( self, "LEFT_SWORD04", true )
	ObjectHideSubObjectPermanently( self, "LEFT_AXE01", true )
	ObjectHideSubObjectPermanently( self, "LEFT_AXE02", true )
	ObjectHideSubObjectPermanently( self, "LEFT_AXE03", true )
	
	-- define the locals as random numbers
	local head 			=	GetRandomNumber()
	local helmet 		=	GetRandomNumber()
	local hair 			=	GetRandomNumber()
	local righthand 	=	GetRandomNumber()
	local lefthand 		=	GetRandomNumber()
	
	local hashelmet		= false
	
	
	--//////////////////////////////////////////
	--			HELMET
	--//////////////////////////////////////////
	-- start picking a helmet
	-- this comes first because some heads and hair must have a helmet, some must not
	
	if helmet <= 0.1 then
		hashelmet		= false
	elseif helmet <= 0.2 then
		ObjectHideSubObjectPermanently( self, "HELMET_01", false )
		hashelmet		= true
	elseif helmet <= 0.3 then
		ObjectHideSubObjectPermanently( self, "HELMET_02", false )
		hashelmet		= true
	elseif helmet <= 0.4 then
		ObjectHideSubObjectPermanently( self, "HELMET_03", false )
		hashelmet		= true
	elseif helmet <= 0.5 then
		ObjectHideSubObjectPermanently( self, "HELMET_04", false )
		hashelmet		= true
	elseif helmet <= 0.6 then
		ObjectHideSubObjectPermanently( self, "HELMET_05", false )
		hashelmet		= true
	elseif helmet <= 0.7 then
		ObjectHideSubObjectPermanently( self, "HELMET_06", false )
		hashelmet		= true
	elseif helmet <= 0.8 then
		ObjectHideSubObjectPermanently( self, "HELMET_07", false )
		hashelmet		= true
	elseif helmet <= 0.9 then
		ObjectHideSubObjectPermanently( self, "HELMET_08", false )
		hashelmet		= true
	else
		ObjectHideSubObjectPermanently( self, "HELMET_09", false )
		hashelmet		= true
	end
	
	
	--//////////////////////////////////////////
	--			HEAD
	--//////////////////////////////////////////
	-- set the heads that require a helmet
	if hashelmet == true then
	
		if head <= 0.25 then
			ObjectHideSubObjectPermanently( self, "HEAD02", false )
		elseif head <= 0.5 then
			ObjectHideSubObjectPermanently( self, "HELMET_HEAD01", false )
		elseif head <= 0.75 then
			ObjectHideSubObjectPermanently( self, "HELMET_HEAD02", false )
		else
			ObjectHideSubObjectPermanently( self, "HELMET_HEAD03", false )
		end
		
	end
	
	-- now set the heads that must not have a helmet
	if hashelmet == false then
	
		if head <= 0.25 then
			ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD01", false )
		elseif head <= 0.5 then
			ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD02", false )
		elseif head <= 0.75 then
			ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD03", false )
		else
			ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD04", false )
		end
		
	end	
	
	
	--//////////////////////////////////////////
	--			HAIR
	--//////////////////////////////////////////
	
	-- set helmet-hair
	if hashelmet == true then
	
		-- 33% chance of getting helmet-hair
		if hair <= 0.33 then
			ObjectHideSubObjectPermanently( self, "HELMET_HAIR01", false )
		end
	
	end
	
	-- set non-helmet-hair 
	if hashelmet == false then
	
		-- 50% chance of getting non-helmet-hair
		if hair <= 0.25 then
			ObjectHideSubObjectPermanently( self, "NOHELMET_HAIR01", false )
		elseif head <= 0.5 then
			ObjectHideSubObjectPermanently( self, "NOHELMET_HAIR02", false )
		end
	
	end
	
	
	--//////////////////////////////////////////
	--			RIGHT HAND
	--//////////////////////////////////////////
	-- set the right hand subobject; note: we need one of them, so there's no "empty" possibility
	if righthand <= 0.066 then
		ObjectHideSubObjectPermanently( self, "RIGHT_SWORD01", false )
	elseif righthand <= 0.133 then
		ObjectHideSubObjectPermanently( self, "RIGHT_SWORD02", false )
	elseif righthand <= 0.2 then
		ObjectHideSubObjectPermanently( self, "RIGHT_SWORD03", false )
	elseif righthand <= 0.266 then
		ObjectHideSubObjectPermanently( self, "RIGHT_SWORD04", false )
	elseif righthand <= 0.333 then
		ObjectHideSubObjectPermanently( self, "RIGHT_SPEAR01", false )
	elseif righthand <= 0.4 then
		ObjectHideSubObjectPermanently( self, "RIGHT_SPEAR02", false )
	elseif righthand <= 0.466 then
		ObjectHideSubObjectPermanently( self, "RIGHT_SPEAR03", false )
	elseif righthand <= 0.533 then
		ObjectHideSubObjectPermanently( self, "RIGHT_SPEAR04", false )
	elseif righthand <= 0.6 then
		ObjectHideSubObjectPermanently( self, "RIGHT_AXE01", false )
	elseif righthand <= 0.666 then
		ObjectHideSubObjectPermanently( self, "RIGHT_AXE02", false )
	elseif righthand <= 0.733 then
		ObjectHideSubObjectPermanently( self, "RIGHT_AXE03", false )
	elseif righthand <= 0.8 then
		ObjectHideSubObjectPermanently( self, "RIGHT_AXE04", false )
	elseif righthand <= 0.866 then
		ObjectHideSubObjectPermanently( self, "RIGHT_MACE01", false )
	elseif righthand <= 0.933 then
		ObjectHideSubObjectPermanently( self, "RIGHT_MACE02", false )
	else
		ObjectHideSubObjectPermanently( self, "RIGHT_MACE03", false )
	end
	
	
	--//////////////////////////////////////////
	--			LEFT HAND
	--//////////////////////////////////////////
	-- set the left hand subobject; note: we don't necessarily need one of them, so we can have some unused possibilities
	if lefthand <= 0.066 then
		ObjectHideSubObjectPermanently( self, "LEFT_SHIELD01", false )
	elseif lefthand <= 0.133 then
		ObjectHideSubObjectPermanently( self, "LEFT_SHIELD02", false )
	elseif lefthand <= 0.2 then
		ObjectHideSubObjectPermanently( self, "LEFT_SHIELD03", false )
	elseif lefthand <= 0.266 then
		ObjectHideSubObjectPermanently( self, "LEFT_SHIELD04", false )
	elseif lefthand <= 0.333 then
		ObjectHideSubObjectPermanently( self, "LEFT_SHIELD05", false )
	elseif lefthand <= 0.4 then
		ObjectHideSubObjectPermanently( self, "LEFT_SHIELD06", false )
	elseif lefthand <= 0.466 then
		ObjectHideSubObjectPermanently( self, "LEFT_SWORD01", false )
	elseif lefthand <= 0.533 then
		ObjectHideSubObjectPermanently( self, "LEFT_SWORD02", false )
	elseif lefthand <= 0.6 then
		ObjectHideSubObjectPermanently( self, "LEFT_SWORD03", false )
	elseif lefthand <= 0.666 then
		ObjectHideSubObjectPermanently( self, "LEFT_SWORD04", false )
	elseif lefthand <= 0.733 then
		ObjectHideSubObjectPermanently( self, "LEFT_AXE01", false )
	elseif lefthand <= 0.8 then
		ObjectHideSubObjectPermanently( self, "LEFT_AXE02", false )
	elseif lefthand <= 0.866 then
		ObjectHideSubObjectPermanently( self, "LEFT_AXE03", false )
	else
		-- do nothing
	end
	
end

function OnMordorOrcArcherCreated(self)

	-- normal:
	ObjectHideSubObjectPermanently( self, "ARROWFIRE", true )

	-- comments:
	-- this is basicly a copy-paste from the orc fighter above, but we have less different weapons

	
	-- hide all heads
	ObjectHideSubObjectPermanently( self, "HEAD02", true )
	ObjectHideSubObjectPermanently( self, "HELMET_HEAD01", true )
	ObjectHideSubObjectPermanently( self, "HELMET_HEAD02", true )
	ObjectHideSubObjectPermanently( self, "HELMET_HEAD03", true )
	ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD01", true )
	ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD02", true )
	ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD03", true )
	ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD04", true )
	
	-- hide all hair
	ObjectHideSubObjectPermanently( self, "NOHELMET_HAIR01", true )
	ObjectHideSubObjectPermanently( self, "NOHELMET_HAIR02", true )
	ObjectHideSubObjectPermanently( self, "HELMET_HAIR01", true )
	
	-- hide all helmets
	ObjectHideSubObjectPermanently( self, "HELMET_01", true )
	ObjectHideSubObjectPermanently( self, "HELMET_02", true )
	ObjectHideSubObjectPermanently( self, "HELMET_03", true )
	ObjectHideSubObjectPermanently( self, "HELMET_04", true )
	ObjectHideSubObjectPermanently( self, "HELMET_05", true )
	ObjectHideSubObjectPermanently( self, "HELMET_06", true )
	ObjectHideSubObjectPermanently( self, "HELMET_07", true )
	ObjectHideSubObjectPermanently( self, "HELMET_08", true )
	ObjectHideSubObjectPermanently( self, "HELMET_09", true )
	
	-- hide all bows
	ObjectHideSubObjectPermanently( self, "BOW_01", true )
	ObjectHideSubObjectPermanently( self, "BOW_02", true )
	ObjectHideSubObjectPermanently( self, "BOW_03", true )
	
	
	
	-- define the locals as random numbers
	local head 			=	GetRandomNumber()
	local helmet 		=	GetRandomNumber()
	local hair 			=	GetRandomNumber()
	local bow 	=	GetRandomNumber()
	
	local hashelmet		= false
	
	
	--//////////////////////////////////////////
	--			HELMET
	--//////////////////////////////////////////
	-- start picking a helmet
	-- this comes first because some heads and hair must have a helmet, some must not
	
	if helmet <= 0.1 then
		hashelmet		= false
	elseif helmet <= 0.2 then
		ObjectHideSubObjectPermanently( self, "HELMET_01", false )
		hashelmet		= true
	elseif helmet <= 0.3 then
		ObjectHideSubObjectPermanently( self, "HELMET_02", false )
		hashelmet		= true
	elseif helmet <= 0.4 then
		ObjectHideSubObjectPermanently( self, "HELMET_03", false )
		hashelmet		= true
	elseif helmet <= 0.5 then
		ObjectHideSubObjectPermanently( self, "HELMET_04", false )
		hashelmet		= true
	elseif helmet <= 0.6 then
		ObjectHideSubObjectPermanently( self, "HELMET_05", false )
		hashelmet		= true
	elseif helmet <= 0.7 then
		ObjectHideSubObjectPermanently( self, "HELMET_06", false )
		hashelmet		= true
	elseif helmet <= 0.8 then
		ObjectHideSubObjectPermanently( self, "HELMET_07", false )
		hashelmet		= true
	elseif helmet <= 0.9 then
		ObjectHideSubObjectPermanently( self, "HELMET_08", false )
		hashelmet		= true
	else
		ObjectHideSubObjectPermanently( self, "HELMET_09", false )
		hashelmet		= true
	end
	
	
	--//////////////////////////////////////////
	--			HEAD
	--//////////////////////////////////////////
	-- set the heads that require a helmet
	if hashelmet == true then
	
		if head <= 0.25 then
			ObjectHideSubObjectPermanently( self, "HEAD02", false )
		elseif head <= 0.5 then
			ObjectHideSubObjectPermanently( self, "HELMET_HEAD01", false )
		elseif head <= 0.75 then
			ObjectHideSubObjectPermanently( self, "HELMET_HEAD02", false )
		else
			ObjectHideSubObjectPermanently( self, "HELMET_HEAD03", false )
		end
		
	end
	
	-- now set the heads that must not have a helmet
	if hashelmet == false then
	
		if head <= 0.25 then
			ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD01", false )
		elseif head <= 0.5 then
			ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD02", false )
		elseif head <= 0.75 then
			ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD03", false )
		else
			ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD04", false )
		end
		
	end	
	
	
	--//////////////////////////////////////////
	--			HAIR
	--//////////////////////////////////////////
	
	-- set helmet-hair
	if hashelmet == true then
	
		-- 33% chance of getting helmet-hair
		if hair <= 0.33 then
			ObjectHideSubObjectPermanently( self, "HELMET_HAIR01", false )
		end
	
	end
	
	-- set non-helmet-hair 
	if hashelmet == false then
	
		-- 50% chance of getting non-helmet-hair
		if hair <= 0.25 then
			ObjectHideSubObjectPermanently( self, "NOHELMET_HAIR01", false )
		elseif head <= 0.5 then
			ObjectHideSubObjectPermanently( self, "NOHELMET_HAIR02", false )
		end
	
	end
	
	
	--//////////////////////////////////////////
	--			RIGHT HAND
	--//////////////////////////////////////////
	-- set the bow; note: we need one of them, so there's no "empty" possibility
	if bow <= 0.33 then
		ObjectHideSubObjectPermanently( self, "BOW_01", false )
	elseif bow <= 0.66 then
		ObjectHideSubObjectPermanently( self, "BOW_02", false )
	else
		ObjectHideSubObjectPermanently( self, "BOW_03", false )
	end
	
	
end

function OnMordorOrcPikemanCreated(self)

	-- comments:
	-- this function is very long, because of all the different subobjects we have to choose from
	-- the basic order is: hide everything, choose a helmet, choose all other equipment depending on the fact if a helmet is shown or not

	
	-- hide all heads
	ObjectHideSubObjectPermanently( self, "HEAD02", true )
	ObjectHideSubObjectPermanently( self, "HELMET_HEAD01", true )
	ObjectHideSubObjectPermanently( self, "HELMET_HEAD02", true )
	ObjectHideSubObjectPermanently( self, "HELMET_HEAD03", true )
	ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD01", true )
	ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD02", true )
	ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD03", true )
	ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD04", true )
	
	-- hide all hair
	ObjectHideSubObjectPermanently( self, "NOHELMET_HAIR01", true )
	ObjectHideSubObjectPermanently( self, "NOHELMET_HAIR02", true )
	ObjectHideSubObjectPermanently( self, "HELMET_HAIR01", true )
	
	-- hide all helmets
	ObjectHideSubObjectPermanently( self, "HELMET_01", true )
	ObjectHideSubObjectPermanently( self, "HELMET_02", true )
	ObjectHideSubObjectPermanently( self, "HELMET_03", true )
	ObjectHideSubObjectPermanently( self, "HELMET_04", true )
	ObjectHideSubObjectPermanently( self, "HELMET_05", true )
	ObjectHideSubObjectPermanently( self, "HELMET_06", true )
	ObjectHideSubObjectPermanently( self, "HELMET_07", true )
	ObjectHideSubObjectPermanently( self, "HELMET_08", true )
	ObjectHideSubObjectPermanently( self, "HELMET_09", true )
	
	--hide all spears
	ObjectHideSubObjectPermanently( self, "SPEAR01", true )
	ObjectHideSubObjectPermanently( self, "SPEAR02", true )
	ObjectHideSubObjectPermanently( self, "SPEAR03", true )
	ObjectHideSubObjectPermanently( self, "SPEAR04", true )
	ObjectHideSubObjectPermanently( self, "SPEAR05", true )
	ObjectHideSubObjectPermanently( self, "SPEAR06", true )

	
	-- define the locals as random numbers
	local head 			=	GetRandomNumber()
	local helmet 		=	GetRandomNumber()
	local hair 			=	GetRandomNumber()
	local spear 		=	GetRandomNumber()
	
	local hashelmet		= false
	
	
	--//////////////////////////////////////////
	--			HELMET
	--//////////////////////////////////////////
	-- start picking a helmet
	-- this comes first because some heads and hair must have a helmet, some must not
	
	if helmet <= 0.1 then
		hashelmet		= false
	elseif helmet <= 0.2 then
		ObjectHideSubObjectPermanently( self, "HELMET_01", false )
		hashelmet		= true
	elseif helmet <= 0.3 then
		ObjectHideSubObjectPermanently( self, "HELMET_02", false )
		hashelmet		= true
	elseif helmet <= 0.4 then
		ObjectHideSubObjectPermanently( self, "HELMET_03", false )
		hashelmet		= true
	elseif helmet <= 0.5 then
		ObjectHideSubObjectPermanently( self, "HELMET_04", false )
		hashelmet		= true
	elseif helmet <= 0.6 then
		ObjectHideSubObjectPermanently( self, "HELMET_05", false )
		hashelmet		= true
	elseif helmet <= 0.7 then
		ObjectHideSubObjectPermanently( self, "HELMET_06", false )
		hashelmet		= true
	elseif helmet <= 0.8 then
		ObjectHideSubObjectPermanently( self, "HELMET_07", false )
		hashelmet		= true
	elseif helmet <= 0.9 then
		ObjectHideSubObjectPermanently( self, "HELMET_08", false )
		hashelmet		= true
	else
		ObjectHideSubObjectPermanently( self, "HELMET_09", false )
		hashelmet		= true
	end
	
	
	--//////////////////////////////////////////
	--			HEAD
	--//////////////////////////////////////////
	-- set the heads that require a helmet
	if hashelmet == true then
	
		if head <= 0.25 then
			ObjectHideSubObjectPermanently( self, "HEAD02", false )
		elseif head <= 0.5 then
			ObjectHideSubObjectPermanently( self, "HELMET_HEAD01", false )
		elseif head <= 0.75 then
			ObjectHideSubObjectPermanently( self, "HELMET_HEAD02", false )
		else
			ObjectHideSubObjectPermanently( self, "HELMET_HEAD03", false )
		end
		
	end
	
	-- now set the heads that must not have a helmet
	if hashelmet == false then
	
		if head <= 0.25 then
			ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD01", false )
		elseif head <= 0.5 then
			ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD02", false )
		elseif head <= 0.75 then
			ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD03", false )
		else
			ObjectHideSubObjectPermanently( self, "NOHELMET_HEAD04", false )
		end
		
	end	
	
	
	--//////////////////////////////////////////
	--			HAIR
	--//////////////////////////////////////////
	
	-- set helmet-hair
	if hashelmet == true then
	
		-- 33% chance of getting helmet-hair
		if hair <= 0.33 then
			ObjectHideSubObjectPermanently( self, "HELMET_HAIR01", false )
		end
	
	end
	
	-- set non-helmet-hair 
	if hashelmet == false then
	
		-- 50% chance of getting non-helmet-hair
		if hair <= 0.25 then
			ObjectHideSubObjectPermanently( self, "NOHELMET_HAIR01", false )
		elseif head <= 0.5 then
			ObjectHideSubObjectPermanently( self, "NOHELMET_HAIR02", false )
		end
	
	end
	
	
	--//////////////////////////////////////////
	--			RIGHT HAND
	--//////////////////////////////////////////
	-- set the right hand subobject; note: we need one of them, so there's no "empty" possibility
	if spear <= 0.2 then
		ObjectHideSubObjectPermanently( self, "SPEAR01", false )
	elseif spear <= 0.4 then
		ObjectHideSubObjectPermanently( self, "SPEAR02", false )
	elseif spear <= 0.6 then
		ObjectHideSubObjectPermanently( self, "SPEAR03", false )
	elseif spear <= 0.8 then
		ObjectHideSubObjectPermanently( self, "SPEAR04", false )
	elseif spear <= 0.9 then
		ObjectHideSubObjectPermanently( self, "SPEAR05", false )
	else
		ObjectHideSubObjectPermanently( self, "SPEAR06", false )
	end

	
end