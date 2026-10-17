local internalNpcName = "Roderick"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 130,
	lookHead = 38,
	lookBody = 109,
	lookLegs = 109,
	lookFeet = 19,
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

keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "A nice myth but nothing more. bye Farewell. Roderick" })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "We are watching their relations with Ab'Dendriel closely." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "Ask someone else." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am Roderick of Thais, commoner." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am ambassador of our beloved king, Tibianus III." })
keywordHandler:addKeyword({ "kazordoon" }, StdModule.say, { npcHandler = npcHandler, text = "The dwarves are very dilligent and crafty people. Our contracts with Kazordoon asure the best for both of our races." })
keywordHandler:addKeyword({ "tibianus" }, StdModule.say, { npcHandler = npcHandler, text = "Our beloved ruler seeks friendship and peace with the elves of Ab'Dendriel." })
keywordHandler:addKeyword({ "sorcerer" }, StdModule.say, { npcHandler = npcHandler, text = "Perhaps Thaian sorcerers can teach the elves their magic in exchange for knowledge of that noble race." })
keywordHandler:addKeyword({ "deraisim" }, StdModule.say, { npcHandler = npcHandler, text = "I look forward to improve our relations with them." })
keywordHandler:addKeyword({ "teshial" }, StdModule.say, { npcHandler = npcHandler, text = "They hardly seem more then an elven myth." })
keywordHandler:addKeyword({ "venore" }, StdModule.say, { npcHandler = npcHandler, text = "The tradesmen of Venore show great interest in trade contracts with the elves." })
keywordHandler:addKeyword({ "crunor" }, StdModule.say, { npcHandler = npcHandler, text = "I am not familiar enough with the different faithes to discuss them properly." })
keywordHandler:addKeyword({ "olrik" }, StdModule.say, { npcHandler = npcHandler, text = "He is my servant and responsible for the mail. I wish he would not spent so much time with elven ladies and work harder." })
keywordHandler:addKeyword({ "elves" }, StdModule.say, { npcHandler = npcHandler, text = "Though there are differences, I am sure we can live in peace and harmony with that noble race." })
keywordHandler:addKeyword({ "magic" }, StdModule.say, { npcHandler = npcHandler, text = "I am impressed by the magic the elves are able to wield. Many of them can cast and even teach spells." })
keywordHandler:addKeyword({ "druid" }, StdModule.say, { npcHandler = npcHandler, text = "The elven magic is somewhat similar to that of the druids." })
keywordHandler:addKeyword({ "troll" }, StdModule.say, { npcHandler = npcHandler, text = "I heared about them working in the local mines." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
