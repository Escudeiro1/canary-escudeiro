local internalNpcName = "Kromrek"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 131,
	lookHead = 104,
	lookBody = 104,
	lookLegs = 104,
	lookFeet = 104,
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

keywordHandler:addKeyword({ "danger" }, StdModule.say, { npcHandler = npcHandler, text = "We are under constant attacks by strange metal creatures from the south. Some are familiar like the glooth golems and the dreaded walkers but others are {foreign} to us but just as murderous of course." })
keywordHandler:addKeyword({ "foreign" }, StdModule.say, { npcHandler = npcHandler, text = "Some were identified as golems of yalaharian design. But others are of designs like nothing we have ever seen. ... There are control towers that boost the strength of the golems at a disturbing degree and there are batteries that recharge and so to say heal the attackers. ... This should be your first targets in any fights. But the worst thing in the enemies arsenal is the glooth {bomb} for sure." })
keywordHandler:addKeyword({ "bomb" }, StdModule.say, { npcHandler = npcHandler, text = "It's kind of a doomsday device, that can cause serious damage to our plant. It's slowly moving towards the plant and heavily armoured. The only way to stop it, is it's timely destruction." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
