local internalNpcName = "A Ghostly Guardian"
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
	lookHead = 38,
	lookBody = 85,
	lookLegs = 9,
	lookFeet = 85,
	lookAddons = 3,
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

keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Once I was a guardian in these halls. It was my duty to welcome those who braved the challenge. But the Brotherhood infiltrated this place using stolen knowledge and their evil seed took root." })
keywordHandler:addKeyword({ "brotherhood of bones" }, StdModule.say, { npcHandler = npcHandler, text = "The Brotherhood intruded these halls that are made of dreams. They defiled them to suit their needs. Beware of taking the wrong path ... It will lead you to a powerful master of evil and I fear that he may try luring someone as powerful as you to his side. He will urge you to join his order of evil ... Resist the temptation of power! Stick to the virtues and seek out the Dream Master for spiritual guidance." })
keywordHandler:addKeyword({ "nightmare knights" }, StdModule.say, { npcHandler = npcHandler, text = "Once the Dream Challenge was a test to find out who was worthy to talk to the Dream Master. Worthy to become a Nightmare Knight. Now ... I am not sure ... I don't know if there are any Dream Masters left. Perhaps you might find one of them like in the days of old. Before the evil came." })
keywordHandler:addKeyword({ "dream master" }, StdModule.say, { npcHandler = npcHandler, text = "The Dream Master is perhaps the last living member of the Nightmare Knights. He used to be a teacher of young aspiring knights. So mighty was his power that even the Bone Master did not dare to challenge him." })
keywordHandler:addKeyword({ "bone master" }, StdModule.say, { npcHandler = npcHandler, text = "By using stolen secrets from our order as well as dark magic one of the last remaining bone masters found his way to this place ... He did not dare to challenge the Dream Master in fair combat. Instead, he decided to hide here and to poison the minds of those who sought the Master's guidance, luring them to the side of evil." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
