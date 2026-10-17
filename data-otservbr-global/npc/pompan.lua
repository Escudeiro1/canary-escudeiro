local internalNpcName = "Pompan"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 132,
	lookHead = 78,
	lookBody = 13,
	lookLegs = 32,
	lookFeet = 108,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

local tomes = Storage.Quest.U8_54.TheNewFrontier.TomeofKnowledge
npcConfig.shop = {
	{ name = "backpack", clientId = 2854, buy = 20 },
	{ name = "bag", clientId = 2853, buy = 5 },
	{ name = "basket", clientId = 2855, buy = 6 },
	{ name = "blue quiver", clientId = 35848, buy = 400 },
	{ name = "bucket", clientId = 2873, buy = 4 },
	{ name = "candlestick", clientId = 2917, buy = 2 },
	{ name = "closed trap", clientId = 3481, buy = 280, sell = 75 },
	{ name = "crowbar", clientId = 3304, buy = 260, sell = 50 },
	{ name = "expedition backpack", clientId = 10324, buy = 100 },
	{ name = "expedition bag", clientId = 10325, buy = 50 },
	{ name = "fishing rod", clientId = 3483, buy = 150, sell = 40 },
	{ name = "lamp", clientId = 2914, buy = 8 },
	{ name = "pick", clientId = 3456, buy = 50, sell = 15 },
	{ name = "quiver", clientId = 35562, buy = 400 },
	{ name = "red quiver", clientId = 35849, buy = 400 },
	{ name = "rope", clientId = 3003, buy = 50, sell = 15 },
	{ name = "scythe", clientId = 3453, buy = 50, sell = 10 },
	{ name = "shovel", clientId = 3457, buy = 50, sell = 8 },
	{ name = "torch", clientId = 2920, buy = 2 },
	{ name = "watch", clientId = 2906, buy = 20, sell = 6 },
	{ name = "worm", clientId = 3492, buy = 1 },
	{ name = "inkwell", clientId = 3509, sell = 8 },
	{ name = "mirror", clientId = 3463, sell = 10 },
	{ name = "sickle", clientId = 3293, sell = 3 },
	-- 1 tome
	{ name = "arrow", clientId = 3447, buy = 3, storageKey = tomes, storageValue = 1 },
	{ name = "bolt", clientId = 3446, buy = 4, storageKey = tomes, storageValue = 1 },
	{ name = "bow", clientId = 3350, buy = 400, sell = 100, storageKey = tomes, storageValue = 1 },
	{ name = "crossbow", clientId = 3349, buy = 500, sell = 120, storageKey = tomes, storageValue = 1 },
	{ name = "crystalline arrow", clientId = 15793, buy = 20, storageKey = tomes, storageValue = 1 },
	{ name = "diamond arrow", clientId = 35901, buy = 130, storageKey = tomes, storageValue = 1 },
	{ name = "dragon tapestry", clientId = 10347, buy = 80, storageKey = tomes, storageValue = 1 },
	{ name = "drill bolt", clientId = 16142, buy = 12, storageKey = tomes, storageValue = 1 },
	{ name = "earth arrow", clientId = 774, buy = 5, storageKey = tomes, storageValue = 1 },
	{ name = "envenomed arrow", clientId = 16143, buy = 12, storageKey = tomes, storageValue = 1 },
	{ name = "flaming arrow", clientId = 763, buy = 5, storageKey = tomes, storageValue = 1 },
	{ name = "flash arrow", clientId = 761, buy = 5, storageKey = tomes, storageValue = 1 },
	{ name = "onyx arrow", clientId = 7365, buy = 7, storageKey = tomes, storageValue = 1 },
	{ name = "piercing bolt", clientId = 7363, buy = 5, storageKey = tomes, storageValue = 1 },
	{ name = "power bolt", clientId = 3450, buy = 7, storageKey = tomes, storageValue = 1 },
	{ name = "prismatic bolt", clientId = 16141, buy = 20, storageKey = tomes, storageValue = 1 },
	{ name = "royal spear", clientId = 7378, buy = 15, storageKey = tomes, storageValue = 1 },
	{ name = "shiver arrow", clientId = 762, buy = 5, storageKey = tomes, storageValue = 1 },
	{ name = "sniper arrow", clientId = 7364, buy = 5, storageKey = tomes, storageValue = 1 },
	{ name = "spear", clientId = 3277, buy = 9, sell = 3, storageKey = tomes, storageValue = 1 },
	{ name = "spectral bolt", clientId = 35902, buy = 70, storageKey = tomes, storageValue = 1 },
	{ name = "tarsal arrow", clientId = 14251, buy = 6, storageKey = tomes, storageValue = 1 },
	{ name = "throwing star", clientId = 3287, buy = 42, storageKey = tomes, storageValue = 1 },
	{ name = "vortex bolt", clientId = 14252, buy = 6, storageKey = tomes, storageValue = 1 },
	{ name = "corrupted flag", clientId = 10409, sell = 700, storageKey = tomes, storageValue = 1 },
	{ name = "high guard flag", clientId = 10415, sell = 550, storageKey = tomes, storageValue = 1 },
	{ name = "legionnaire flags", clientId = 10417, sell = 500, storageKey = tomes, storageValue = 1 },
	{ name = "zaogun flag", clientId = 10413, sell = 600, storageKey = tomes, storageValue = 1 },
	-- 2 tomes
	{ name = "minotaur backpack", clientId = 10327, buy = 200, storageKey = tomes, storageValue = 2 },
	-- 5 tomes
	{ name = "dragon backpack", clientId = 10326, buy = 200, storageKey = tomes, storageValue = 5 },
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

keywordHandler:addKeyword({ "superiors" }, StdModule.say, { npcHandler = npcHandler, text = "My superiors are a board of tree traders from Venore who are looking for new opportunities." })
keywordHandler:addKeyword({ "lizards" }, StdModule.say, { npcHandler = npcHandler, text = "They are an incredible threat. At the moment, they are occupied with the orcs. But once they are done with the orcs, who will be next? They might even plan to conquer human civilisation... ... I agree with my superiors that a preventative strike will be the best solution. The lizards' cities are rich and the land offers plentiful resources that would easily cover the costs of a war." })
keywordHandler:addKeyword({ "ongulf" }, StdModule.say, { npcHandler = npcHandler, text = "He can be quite stubborn sometimes but I see why they chose him to head this venture. ... If you've ever talked to dwarfs, you'll recognise that he is an rather open-minded and flexible fellow." })
keywordHandler:addKeyword({ "humans" }, StdModule.say, { npcHandler = npcHandler, text = "They are neglectable as they have nothing to offer. They live in horrible primitive conditions, but we are not here for charity work. As long as they don't have anything interesting to offer, we will simply ignore them." })
keywordHandler:addKeyword({ "venore" }, StdModule.say, { npcHandler = npcHandler, text = "My lovely hometown was always at the forefront of science, exploration and daring ventures. I see some profitable opportunities in this project, and I'm in constant correspondence with my {superiors}." })
keywordHandler:addKeyword({ "mines" }, StdModule.say, { npcHandler = npcHandler, text = "The mines do well. If only the miners would loosen their purse strings." })
keywordHandler:addKeyword({ "orcs" }, StdModule.say, { npcHandler = npcHandler, text = "Of course they are dangerous. But we all know: Orcs can die, can't they? And speaking of that, they might have stolen some interesting stuff from these lizardmen that could be of some value for someone with an exotic taste." })
npcHandler:setMessage(MESSAGE_GREET, "Hello.")
npcHandler:setMessage(MESSAGE_FAREWELL, "It was a pleasure to help you, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Keep in mind you won't find better offers here. Just browse through my wares.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
