local internalNpcName = "Hoggle"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 128,
	lookHead = 21,
	lookBody = 46,
	lookLegs = 88,
	lookFeet = 94,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Oh, this misery..." },
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

keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "There are stories about a city behind the mountain, but why should I go there? There is enough fish here." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "I know this city. Sometimes I sell fish to Frodo." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "No, it's not time now to go fishing." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am Hoggle. I live in this house." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am just a poor fisherman." })
keywordHandler:addKeyword({ "fisherman" }, StdModule.say, { npcHandler = npcHandler, text = "It's a very hard job, cause without a boat I have to swim and fish at the same time!" })
keywordHandler:addKeyword({ "mountain" }, StdModule.say, { npcHandler = npcHandler, text = "Yes, there is a mountain to the north, but it's of no interest. There isn't any fish on it." })
keywordHandler:addKeyword({ "mermaid" }, StdModule.say, { npcHandler = npcHandler, text = "I saw one! She had the body of a fish, and also the head of a fish. Amazing!" })
keywordHandler:addKeyword({ "stupid" }, StdModule.say, { npcHandler = npcHandler, text = "My mom always said, stupid is who stupid does." })
keywordHandler:addKeyword({ "garden" }, StdModule.say, { npcHandler = npcHandler, text = "I tried to breed fish in my garden but to no avail." })
keywordHandler:addKeyword({ "secret" }, StdModule.say, { npcHandler = npcHandler, text = "Can you keep a secret? I think fish can't breath on land!" })
keywordHandler:addKeyword({ "finger" }, StdModule.say, { npcHandler = npcHandler, text = "No, fish don't have fingers." })
keywordHandler:addKeyword({ "frodo" }, StdModule.say, { npcHandler = npcHandler, text = "He buys my fish." })
keywordHandler:addKeyword({ "fish" }, StdModule.say, { npcHandler = npcHandler, text = "I think they can talk, but they are wise enough to be silent. Once I saw a mermaid." })
keywordHandler:addKeyword({ "food" }, StdModule.say, { npcHandler = npcHandler, text = "If you are hungry you can go downstairs, perhaps you will find some fish. You can also take some shoes if you want." })
keywordHandler:addKeyword({ "boat" }, StdModule.say, { npcHandler = npcHandler, text = "My boat sunk. I thought it would be more aerodynamic with holes in it." })
npcHandler:setMessage(MESSAGE_GREET, "Welcome to my humble home!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
