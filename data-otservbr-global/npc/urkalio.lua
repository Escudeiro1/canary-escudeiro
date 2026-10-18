local internalNpcName = "Urkalio"
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
	lookHead = 97,
	lookBody = 59,
	lookLegs = 120,
	lookFeet = 114,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Enjoy a good drink in the Hard Rock Tavern!" },
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

keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "I would love to see that weapon in a fight." })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "THAT would be some attraction down here." })
-- above "tibia", which is inside "tibianus"
keywordHandler:addKeyword({ "tibianus" }, StdModule.say, { npcHandler = npcHandler, text = "Down here everyone is king as far as where his weapons reach." })
keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "Sooner or later everyone comes here, so why bother to travel." })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "I don't care about their 'independence war'." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Such a boring city. I wonder why anyone would live there." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "Down here everyone is king as far as where his weapons reach." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "No clue, it's equally dark down here at any time." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am Urkalio." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am responsible for the Hard Rock Pits Tavern." })
keywordHandler:addAliasKeyword({ "tavern" })
keywordHandler:addKeyword({ "amazons" }, StdModule.say, { npcHandler = npcHandler, text = "Some came here to challenge the local champions. I can't say I was impressed by their skills. However, they took a few heads as trophies." })
keywordHandler:addKeyword({ "drink" }, StdModule.say, { npcHandler = npcHandler, text = "So do you want beer, wine, lemonade, or ... uhm ... water? Ask me for a {trade}." })
keywordHandler:addKeyword({ "asrak" }, StdModule.say, { npcHandler = npcHandler, text = "He's the best. To be the man, you'll have to beat the minotaur, so to say. Not that you could provoke him to a fight at all." })
keywordHandler:addKeyword({ "maria" }, StdModule.say, { npcHandler = npcHandler, text = "She's kind of my boss." })
keywordHandler:addKeyword({ "sell" }, StdModule.say, { npcHandler = npcHandler, text = "I sell food and drinks for the hungry and thirsty. Ask me for a {trade} if you want." })
keywordHandler:addKeyword({ "food" }, StdModule.say, { npcHandler = npcHandler, text = "I have cookies, bread, cheese, ham, and meat. Ask me for a {trade} if you want any." })
keywordHandler:addKeyword({ "pits" }, StdModule.say, { npcHandler = npcHandler, text = "Choose your enemies with care." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "bread", clientId = 3600, buy = 4 },
	{ itemName = "cheese", clientId = 3607, buy = 6 },
	{ itemName = "cookie", clientId = 3598, buy = 5 },
	{ itemName = "ham", clientId = 3582, buy = 8 },
	{ itemName = "meat", clientId = 3577, buy = 5 },
	{ itemName = "mug of beer", clientId = 2880, buy = 2, count = 3 },
	{ itemName = "mug of lemonade", clientId = 2880, buy = 2, count = 12 },
	{ itemName = "mug of water", clientId = 2880, buy = 1, count = 1 },
	{ itemName = "mug of wine", clientId = 2880, buy = 3, count = 2 },
}
-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

npcType:register(npcConfig)
