local internalNpcName = "The Crone"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 78,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Let me mourn in peace." },
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

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I don't remember my name, neither my days as a mortal." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Once I was {Vashresamun}'s favourite handmaid. But I have fallen from {grace} and now I'm exiled from her {tomb}." })
keywordHandler:addAliasKeyword({ "mortal" })
keywordHandler:addKeyword({ "vashresamun" }, StdModule.say, { npcHandler = npcHandler, text = "I mourn the dark day I was exiled from her {tomb}." })
keywordHandler:addKeyword({ "melody" }, StdModule.say, { npcHandler = npcHandler, text = "Vashresamun erased the memory of the tune from my mind, I only remember its name: The Secret of the Rose Garden." })
keywordHandler:addKeyword({ "grace" }, StdModule.say, { npcHandler = npcHandler, text = "Don't ask about it, mortal. Memories bring too much grief." })
keywordHandler:addKeyword({ "tomb" }, StdModule.say, { npcHandler = npcHandler, text = "Her tomb is sealed and can only be entered with a certain {melody}." })
npcHandler:setMessage(MESSAGE_GREET, "Be greeted, |PLAYERNAME|... mortal.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
