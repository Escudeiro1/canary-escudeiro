local internalNpcName = "Cruleo"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 254,
	lookHead = 94,
	lookBody = 115,
	lookLegs = 97,
	lookFeet = 97,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "<gulp gulp>" },
	{ text = "This will earn me some handsome amount of gold!" },
	{ text = "Muhahaha!" },
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
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I'm a {hunter} and proud of it. I'm also willing to buy certain trophies of your own hunts if you are interested to {trade}." })
keywordHandler:addKeyword({ "hunter" }, StdModule.say, { npcHandler = npcHandler, text = "Hunting is not for the chicken-hearted. I'm a hunter, my father was a hunter and my father's father was a hunter. That is the way things are. You hunt or you are hunted. ... There is no shame, we humans fought our way up the food chain. In fact it is an honour and we should not mock our ancestors' efforts. ... We humans are hunters, like it or not. Hunting is part of life and it is how the world works and was meant to be." })
keywordHandler:addKeyword({ "elves" }, StdModule.say, { npcHandler = npcHandler, text = "Those pesky tree dwellers are bad for business. They care more for the animals than for us humans, why would we care for them or their assumed pets? ... Their days are over, even when they fail to see that. This is the age of humans and it is us who decide what is right or wrong." })
keywordHandler:addKeyword({ "furs" }, StdModule.say, { npcHandler = npcHandler, text = "The fur of the white deer is prized by followers of the latest fashion, magicians and nobles. Some use them for assumed magical purposes, others for prestige, others for style." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "white deer antlers", clientId = 12544, sell = 400 },
	{ itemName = "white deer skin", clientId = 12545, sell = 245 },
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
