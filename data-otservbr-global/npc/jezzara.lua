local internalNpcName = "Jezzara"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 138,
	lookHead = 3,
	lookBody = 44,
	lookLegs = 91,
	lookFeet = 97,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Food of various kinds, have a look." },
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

keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "The world can be a dangerous place for the whole of the Akh'rah Uthun." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "You can buy watches here in the markethall." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am the mourned Jezzara." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I sell food of various kinds." })
keywordHandler:addKeyword({ "akh'rah uthun" }, StdModule.say, { npcHandler = npcHandler, text = "Well its just the Akh, the Rah and the Uthun." })
keywordHandler:addKeyword({ "ab'dendriel" }, StdModule.say, { npcHandler = npcHandler, text = "Elves don't like this land too much so we have little contact with them." })
keywordHandler:addAliasKeyword({ "elves" })
keywordHandler:addKeyword({ "ankrahmun" }, StdModule.say, { npcHandler = npcHandler, text = "This city is a safe haven that gives shelter from the dangers of the desert." })
keywordHandler:addKeyword({ "kazordoon" }, StdModule.say, { npcHandler = npcHandler, text = "Dwarves are not really fond of the endless sands of the desert. I must say I can't blame them for it." })
keywordHandler:addAliasKeyword({ "dwarfs" })
keywordHandler:addKeyword({ "darashia" }, StdModule.say, { npcHandler = npcHandler, text = "We are usually not allowed to travel that far without explicit permission, so we know this city mostly from the tales of travellers." })
keywordHandler:addKeyword({ "scarabs" }, StdModule.say, { npcHandler = npcHandler, text = "I am not afraid of something that attacks only my physical form. But they stay away from the city anyway." })
keywordHandler:addKeyword({ "pharaoh" }, StdModule.say, { npcHandler = npcHandler, text = "The pharaoh is our godking and the founder of our religion." })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "The cities of the Tibian continent have little contact with us." })
keywordHandler:addAliasKeyword({ "thais" })
keywordHandler:addAliasKeyword({ "venore" })
keywordHandler:addAliasKeyword({ "edron" })
keywordHandler:addKeyword({ "darama" }, StdModule.say, { npcHandler = npcHandler, text = "This continent is very diverse. There are deserts and mountains as well as a large jungle region." })
keywordHandler:addKeyword({ "undead" }, StdModule.say, { npcHandler = npcHandler, text = "Those who follow the pharaoh might become undead one day." })
keywordHandler:addKeyword({ "uthun" }, StdModule.say, { npcHandler = npcHandler, text = "The Uthun is the sentient part of all living things." })
keywordHandler:addKeyword({ "food" }, StdModule.say, { npcHandler = npcHandler, text = "I can offer you meat, ham, salmon, fish, fruits and vegetables. If you'd like to see my offers, ask me for a {trade}." })
npcHandler:setMessage(MESSAGE_GREET, "Be mourned pilgrim in flesh. Talking of flesh, maybe you'd enjoy some {food}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "May enlightenment be your path.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "May enlightenment be your path.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Sure, take a look at my offers.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "banana", clientId = 3587, buy = 5 },
	{ itemName = "bulb of garlic", clientId = 8197, buy = 3 },
	{ itemName = "carrot", clientId = 3595, buy = 8 },
	{ itemName = "dragon ham", clientId = 3583, buy = 25 },
	{ itemName = "fish", clientId = 3578, buy = 6 },
	{ itemName = "grapes", clientId = 3592, buy = 8 },
	{ itemName = "ham", clientId = 3582, buy = 15 },
	{ itemName = "jalapeno pepper", clientId = 8016, buy = 2 },
	{ itemName = "meat", clientId = 3577, buy = 10 },
	{ itemName = "melon", clientId = 3593, buy = 13 },
	{ itemName = "onion", clientId = 8015, buy = 2 },
	{ itemName = "orange", clientId = 3586, buy = 9 },
	{ itemName = "pumpkin", clientId = 3594, buy = 10 },
	{ itemName = "salmon", clientId = 3579, buy = 7 },
	{ itemName = "tomato", clientId = 3596, buy = 10 },
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
