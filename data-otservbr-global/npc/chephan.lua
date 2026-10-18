local internalNpcName = "Chephan"
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
	lookHead = 2,
	lookBody = 26,
	lookLegs = 115,
	lookFeet = 76,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Cooking utensils and kitchen equipment! For pros and starters!" },
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

keywordHandler:addKeyword({ "news" }, StdModule.say, { npcHandler = npcHandler, text = "My recipes are family secrets, sorry." })
keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "Just an oversized kitchen knife. Better buy a real one." })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "See this fork? Now imagine what a hero like you could do with that fork to an evil sorcerer! Care to buy one?" })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "So many women and so little interest in cooking, horrible." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Thaian cooking utensils are of low quality. Make sure to buy our quality wares here as soon as possible." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "Watches are sold in the south-eastern part of this warehouse." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I'm Chephan, at your service." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I {sell} all the cooking utensils you can dream of." })
keywordHandler:addAliasKeyword({ "looking" })
keywordHandler:addKeyword({ "warehouse" }, StdModule.say, { npcHandler = npcHandler, text = "Here you can by many things you will need one day or another. Just have a look." })
keywordHandler:addKeyword({ "sell" }, StdModule.say, { npcHandler = npcHandler, text = "I offer the best cooking utensils in town. If you like to see my offers, ask me for a {trade}." })
keywordHandler:addAliasKeyword({ "cooking" })
-- after "cooking", which contains "king"
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "Even a king needs a fork now and then - to scratch his back or to poke servants for example." })
keywordHandler:addAliasKeyword({ "tibianus" })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "baking tray", clientId = 8020, buy = 20 },
	{ itemName = "bottle", clientId = 2875, buy = 3 },
	{ itemName = "bucket", clientId = 7142, buy = 4 },
	{ itemName = "cleaver", clientId = 3471, buy = 15 },
	{ itemName = "cup", clientId = 2881, buy = 2 },
	{ itemName = "fork", clientId = 3467, buy = 10 },
	{ itemName = "jug", clientId = 7243, buy = 10 },
	{ itemName = "kitchen knife", clientId = 3469, buy = 10 },
	{ itemName = "mug", clientId = 2880, buy = 4 },
	{ itemName = "oven spatula", clientId = 3472, buy = 12 },
	{ itemName = "pan", clientId = 3466, buy = 20 },
	{ itemName = "plate", clientId = 2905, buy = 6 },
	{ itemName = "pot", clientId = 3465, buy = 30 },
	{ itemName = "rolling pin", clientId = 3473, buy = 12 },
	{ itemName = "spoon", clientId = 3468, buy = 10 },
	{ itemName = "wooden spoon", clientId = 3470, buy = 5 },
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
