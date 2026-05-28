local internalNpcName = "Boveas"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 25,
}

npcConfig.flags = {
	floorchange = false,
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Oh, I'm sorry. I forgot to introduce myself. Tends to happen when I'm scared that some bloodthirsty adventurer is going to kill me on account of my cunning disguise. My name is Boveas." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I studied the art of magic for many years, but it's a bit abstract for a man with my hands on attitude to life. ... So I decided to find some kind of niche for my studies. It was then I came upon the idea of studying the magic of other races. ... Unfortunately, that proved to be far too much for one person. After careful consideration I decided to concentrate my efforts on the secrets of minotaur magic. ... It didn't take me long to become fascinated with the whole race and I wanted to learn more about them. ... I have invested a considerable amount of resources in setting up this ruse to infiltrate this city. ... During my time here I have not only learned a lot about the magic of the minotaurs, but I have also found out some intriguing facts about their culture. And there is still so much for me to discover! Thrilling." })
npcHandler:setMessage(MESSAGE_GREET, "Hi! I hope you're not going to kill me!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye, |PLAYERNAME|.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
