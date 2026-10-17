local internalNpcName = "Asnarus"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 104,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
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

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am called Asnarus." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am bound by my {word} to serve here as a trader. I will provide this service faithful for 111 years, as I vowed." })
keywordHandler:addKeyword({ "inquisition" }, StdModule.say, { npcHandler = npcHandler, text = "An overly ambitious and childish undertaking to try to purge the world of evil. But even the least of us must play their part in the war against evil, even you humans." })
keywordHandler:addKeyword({ "efreet" }, StdModule.say, { npcHandler = npcHandler, text = "They are our bane and shame. Unless they see the light and begin to walk the right path, they are no better than the vile demons; yet they could be so much more. ... It's to be blamed on us Djinn that we still fail to save our brethren from their evil ways." })
keywordHandler:addKeyword({ "years" }, StdModule.say, { npcHandler = npcHandler, text = "We Djinn are ageless and ancient. What is hundreds of years to me would be at most something about an hour for you, so I don't care much." })
keywordHandler:addKeyword({ "djinn" }, StdModule.say, { npcHandler = npcHandler, text = "We are a powerful embodiment of magic. We are so different from you humans that it's often hard to understand each other. Not that we'd care much. ... Your puny, little ambitions are of little concern to us. Everything you strive to accomplish will be blown away like sand before the desert wind in a blink of a Djinn's eye. ... Therefore we are as patient as we are wise. You humans, though, are nothing but a curiosity, and nothing that will endure like us." })
keywordHandler:addKeyword({ "human" }, StdModule.say, { npcHandler = npcHandler, text = "Humans are so weak and fragile, so disconnected from the true world, which is magic and its flow. The most powerful of you may wield strong spells of destruction, yet they are still not connected to magic as we are." })
keywordHandler:addKeyword({ "demon" }, StdModule.say, { npcHandler = npcHandler, text = "Fierce beasts, no better than the {Efreet}. You humans do well to fight them. They are vile and despicable, and I don't mind to be of some assistance in that fight, offering my service." })
keywordHandler:addKeyword({ "word" }, StdModule.say, { npcHandler = npcHandler, text = "I lost a game of chess to the chief inquisitor Henricus. By my word I am now bound to a service of 111 {years}." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "animate dead rune", clientId = 3203, buy = 375 },
	{ itemName = "arrow", clientId = 3447, buy = 2 },
	{ itemName = "blue quiver", clientId = 35848, buy = 400 },
	{ itemName = "bolt", clientId = 3446, buy = 4 },
	{ itemName = "bow", clientId = 3350, buy = 400, sell = 100 },
	{ itemName = "bowl of terror sweat", clientId = 20204, sell = 500 },
	{ itemName = "broken visor", clientId = 20184, sell = 1900 },
	{ itemName = "crossbow", clientId = 3349, buy = 500, sell = 120 },
	{ itemName = "crystalline arrow", clientId = 15793, buy = 20 },
	{ itemName = "dead weight", clientId = 20202, sell = 450 },
	{ itemName = "desintegrate rune", clientId = 3197, buy = 26 },
	{ itemName = "diamond arrow", clientId = 35901, buy = 130 },
	{ itemName = "drill bolt", clientId = 16142, buy = 12 },
	{ itemName = "earth arrow", clientId = 774, buy = 5 },
	{ itemName = "empty potion flask", clientId = 283, sell = 5 },
	{ itemName = "empty potion flask", clientId = 284, sell = 5 },
	{ itemName = "empty potion flask", clientId = 285, sell = 5 },
	{ itemName = "energy bomb rune", clientId = 3149, buy = 203 },
	{ itemName = "envenomed arrow", clientId = 16143, buy = 12 },
	{ itemName = "fireball rune", clientId = 3189, buy = 30 },
	{ itemName = "flaming arrow", clientId = 763, buy = 5 },
	{ itemName = "flash arrow", clientId = 761, buy = 5 },
	{ itemName = "frazzle skin", clientId = 20199, sell = 400 },
	{ itemName = "frazzle tongue", clientId = 20198, sell = 700 },
	{ itemName = "goosebump leather", clientId = 20205, sell = 650 },
	{ itemName = "great health potion", clientId = 239, buy = 225 },
	{ itemName = "great mana potion", clientId = 238, buy = 158 },
	{ itemName = "great spirit potion", clientId = 7642, buy = 254 },
	{ itemName = "health potion", clientId = 266, buy = 50 },
	{ itemName = "hemp rope", clientId = 20206, sell = 350 },
	{ itemName = "holy missile rune", clientId = 3182, buy = 16 },
	{ itemName = "icicle rune", clientId = 3158, buy = 30 },
	{ itemName = "magic wall rune", clientId = 3180, buy = 116 },
	{ itemName = "mana potion", clientId = 268, buy = 56 },
	{ itemName = "onyx arrow", clientId = 7365, buy = 7 },
	{ itemName = "paralyze rune", clientId = 3165, buy = 700 },
	{ itemName = "piercing bolt", clientId = 7363, buy = 5 },
	{ itemName = "poison bomb rune", clientId = 3173, buy = 85 },
	{ itemName = "pool of chitinous glue", clientId = 20207, sell = 430 },
	{ itemName = "power bolt", clientId = 3450, buy = 7 },
	{ itemName = "prismatic bolt", clientId = 16141, buy = 20 },
	{ itemName = "quiver", clientId = 35562, buy = 400 },
	{ itemName = "red quiver", clientId = 35849, buy = 400 },
	{ itemName = "royal spear", clientId = 7378, buy = 15 },
	{ itemName = "shiver arrow", clientId = 762, buy = 5 },
	{ itemName = "sight of surrenders eye", clientId = 20183, sell = 3000 },
	{ itemName = "silencer claws", clientId = 20200, sell = 390 },
	{ itemName = "silencer resonating chamber", clientId = 20201, sell = 600 },
	{ itemName = "sniper arrow", clientId = 7364, buy = 5 },
	{ itemName = "soulfire rune", clientId = 3195, buy = 46 },
	{ itemName = "spear", clientId = 3277, buy = 9, sell = 3 },
	{ itemName = "spectral bolt", clientId = 35902, buy = 70 },
	{ itemName = "stone shower rune", clientId = 3175, buy = 41 },
	{ itemName = "strong health potion", clientId = 236, buy = 115 },
	{ itemName = "strong mana potion", clientId = 237, buy = 108 },
	{ itemName = "supreme health potion", clientId = 23375, buy = 650 },
	{ itemName = "tarsal arrow", clientId = 14251, buy = 6 },
	{ itemName = "throwing star", clientId = 3287, buy = 42 },
	{ itemName = "thunderstorm rune", clientId = 3202, buy = 52 },
	{ itemName = "trapped bad dream monster", clientId = 20203, sell = 900 },
	{ itemName = "ultimate health potion", clientId = 7643, buy = 379 },
	{ itemName = "ultimate mana potion", clientId = 23373, buy = 488 },
	{ itemName = "ultimate spirit potion", clientId = 23374, buy = 488 },
	{ itemName = "vial", clientId = 2874, sell = 5 },
	{ itemName = "vortex bolt", clientId = 14252, buy = 6 },
	{ itemName = "wild growth rune", clientId = 3156, buy = 160 },
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
