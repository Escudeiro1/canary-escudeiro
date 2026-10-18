local internalNpcName = "Gladys"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 148,
	lookHead = 57,
	lookBody = 94,
	lookLegs = 78,
	lookFeet = 114,
	lookAddons = 1,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Fangs, fur, hooves ... if it comes from a were-creature I'll buy it!" },
	{ text = "If you're in need of some tools, just ask me." },
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

keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "It is time." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Gladys." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am Grimvale's druid. I can offer you some useful tools and will also buy any were-creature body parts, if you bring some." })
keywordHandler:addKeyword({ "werewolves" }, StdModule.say, { npcHandler = npcHandler, text = "Yes. They dwell here on {Grimvale}. The were-sickness or the curse, whatever you're believing in, transforms peaceful villagers into savage beasts." })
keywordHandler:addKeyword({ "dangerous" }, StdModule.say, { npcHandler = npcHandler, text = "Yes. Grimvale is affected by were-sickness. We also call it the Curse of the Full Moon." })
keywordHandler:addKeyword({ "grimvale" }, StdModule.say, { npcHandler = npcHandler, text = "Well, this small island you are standing on. It is our home, yet a little {dangerous}, lately." })
keywordHandler:addKeyword({ "cornell" }, StdModule.say, { npcHandler = npcHandler, text = "He clings to this village, as we all do, in spite of the Curse. But he's as much home on water as on land. I guess that's why he runs a ferry service these days." })
keywordHandler:addKeyword({ "maeryn" }, StdModule.say, { npcHandler = npcHandler, text = "She's taken upon her the burden of being the protector of this village. I've known her since she was a little girl - very sweet, and very determined she was. Now she has grown up to be a forceful woman, courageous and deadly with the bow." })
keywordHandler:addKeyword({ "owin" }, StdModule.say, { npcHandler = npcHandler, text = "A seasoned hunter, though he turned to research lately and barely goes out anymore. Very knowledgeable about the woods, animals and {werewolves}." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "badger boots", clientId = 22086, sell = 7500 },
	{ itemName = "basket", clientId = 2855, buy = 6 },
	{ itemName = "bottle", clientId = 2875, buy = 3 },
	{ itemName = "bucket", clientId = 2873, buy = 4 },
	{ itemName = "candelabrum", clientId = 2911, buy = 8 },
	{ itemName = "candlestick", clientId = 2917, buy = 2 },
	{ itemName = "closed trap", clientId = 3481, buy = 280, sell = 75 },
	{ itemName = "crowbar", clientId = 3304, buy = 260, sell = 50 },
	{ itemName = "crusher", clientId = 46627, buy = 500 },
	{ itemName = "fishing rod", clientId = 3483, buy = 150, sell = 40 },
	{ itemName = "fox paw", clientId = 27462, sell = 100 },
	{ itemName = "fur armor", clientId = 22085, sell = 5000 },
	{ itemName = "hand auger", clientId = 31334, buy = 25 },
	{ itemName = "machete", clientId = 3308, buy = 35, sell = 6 },
	{ itemName = "net", clientId = 31489, buy = 50 },
	{ itemName = "pick", clientId = 3456, buy = 50, sell = 15 },
	{ itemName = "present", clientId = 2856, buy = 10 },
	{ itemName = "rope", clientId = 3003, buy = 50, sell = 15 },
	{ itemName = "scythe", clientId = 3453, buy = 50, sell = 10 },
	{ itemName = "shovel", clientId = 3457, buy = 50, sell = 8 },
	{ itemName = "torch", clientId = 2920, buy = 2 },
	{ itemName = "watch", clientId = 2906, buy = 20, sell = 6 },
	{ itemName = "werebadger claws", clientId = 22051, sell = 160 },
	{ itemName = "werebadger skull", clientId = 22055, sell = 185 },
	{ itemName = "werebear fur", clientId = 22057, sell = 185 },
	{ itemName = "werebear skull", clientId = 22057, sell = 195 },
	{ itemName = "wereboar hooves", clientId = 22053, sell = 175 },
	{ itemName = "wereboar loincloth", clientId = 22087, sell = 1500 },
	{ itemName = "wereboar tusk", clientId = 22054, sell = 165 },
	{ itemName = "werefox tail", clientId = 27463, sell = 200 },
	{ itemName = "werewolf amulet", clientId = 22060, sell = 3000 },
	{ itemName = "werewolf fang", clientId = 22052, sell = 180 },
	{ itemName = "werewolf fur", clientId = 10317, sell = 380 },
	{ itemName = "wooden hammer", clientId = 3459, sell = 15 },
	{ itemName = "worm", clientId = 3492, buy = 1 },
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
