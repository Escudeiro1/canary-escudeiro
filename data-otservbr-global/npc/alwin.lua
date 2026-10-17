local internalNpcName = "Alwin"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 131,
	lookHead = 113,
	lookBody = 113,
	lookLegs = 113,
	lookFeet = 115,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

local condition = Condition(CONDITION_FIRE)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(10, 1000, -10)

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if table.contains({ "fuck", "idiot", "asshole", "ass", "fag", "stupid", "tyrant", "shit", "lunatic" }, message) then
		npcHandler:say("Take this!", npc, creature)
		local player = Player(creature)
		player:getPosition():sendMagicEffect(CONST_ME_EXPLOSIONAREA)
		player:addCondition(condition)
		npcHandler:removeInteraction(npc, creature)
		npcHandler:resetNpc(creature)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
keywordHandler:addKeyword({ "monsters" }, StdModule.say, { npcHandler = npcHandler, text = "The swamp is full of nasty snakes and there's a dragon breeding ground somewhere in the swamps." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "Tibianus III is our beloved king!" })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am a protector of the people of Venore." })
keywordHandler:addKeyword({ "swamptroll" }, StdModule.say, { npcHandler = npcHandler, text = "This hideous creatures are even more ugly than the normal trolls. They are treacherous and use several poisons." })
keywordHandler:addKeyword({ "tibianus" }, StdModule.say, { npcHandler = npcHandler, text = "Tibianus III is our beloved king!" })
keywordHandler:addKeyword({ "amazons" }, StdModule.say, { npcHandler = npcHandler, text = "They are the best example for the results of the Carlin madness." })
keywordHandler:addKeyword({ "venore" }, StdModule.say, { npcHandler = npcHandler, text = "The harbour is to the north, the weapon market in the south, the general market to the west, and the bank to the east. You will find other shops and the Hard Rock Tavern in the center." })
keywordHandler:addKeyword({ "swamp" }, StdModule.say, { npcHandler = npcHandler, text = "The swamp is a dangerous place and full of monsters, not to mention all those swampelves living at shadowthorn, amazons, and swamptrolls." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
