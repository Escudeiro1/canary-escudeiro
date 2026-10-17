local internalNpcName = "Jakahr"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 133,
	lookHead = 95,
	lookBody = 36,
	lookLegs = 33,
	lookFeet = 59,
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

keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "A weapon of legend. We rarely hear stories about it around here, however." })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "Carlin is a city far, far away from here. They say it is run by women and druids." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Thais is the capital of a kingdom on a far-off continent." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "The time is 7:48 am, pilgrim." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Jakahr." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am a member of the Postmasters Guild. If you have questions about the Royal Tibia Mail System or the depots, ask me." })
keywordHandler:addKeyword({ "ankrahmun" }, StdModule.say, { npcHandler = npcHandler, text = "This city is a safe haven that protects its citizens from the dangers of the desert." })
keywordHandler:addKeyword({ "receiver" }, StdModule.say, { npcHandler = npcHandler, text = "Well, the receiver - or addressee - is the person you want to send mail to. He or she can pick up your mail in the depot of the city you send it to." })
keywordHandler:addKeyword({ "darashia" }, StdModule.say, { npcHandler = npcHandler, text = "A minor settlement to the north." })
keywordHandler:addKeyword({ "mail" }, StdModule.say, { npcHandler = npcHandler, text = "With our mail system you can send letters and parcels to other Tibians. I can either explain how letters and parcels work or sell them to you if you ask me for a {trade}." })
keywordHandler:addKeyword({ "pharaoh" }, StdModule.say, { npcHandler = npcHandler, text = "The pharaoh keeps this city safe. He is both our political and our spiritual leader." })
keywordHandler:addKeyword({ "darama" }, StdModule.say, { npcHandler = npcHandler, text = "On this continent, the only place of real importance is our city." })
keywordHandler:addKeyword({ "depot" }, StdModule.say, { npcHandler = npcHandler, text = "Each major city has at least one depot. Just step in front of one of the lockers and you can store items inside. Your mail will also arrive there. Each city has its own storage, don't forget where you store items!" })
keywordHandler:addKeyword({ "uthun" }, StdModule.say, { npcHandler = npcHandler, text = "Sorry, but you should discuss religous issues like these in the temple. I am not a priest, and there is little I can tell you about it." })
keywordHandler:addKeyword({ "help" }, StdModule.say, { npcHandler = npcHandler, text = "With a letter you can send a message to another Tibian's depot. If you want to send it to 'Ben' in 'Thais', use the letter - so that a form opens - and write 'Ben' in the first line and 'Thais' in the second line. Write your message below that. ... Then drag your letter on one of the blue mailboxes here to send it." })
keywordHandler:addKeyword({ "city" }, StdModule.say, { npcHandler = npcHandler, text = "The depots you can send parcels or letters to are in the following cities: Ab'Dendriel, Ankrahmun, Carlin, Darashia, Edron, Farmine, Kazordoon, Liberty Bay, Port Hope, Svargrond, Thais, Venore and Yalahar." })
npcHandler:setMessage(MESSAGE_GREET, "Hello, mourned pilgrim. How may I help you |PLAYERNAME|?")
npcHandler:setMessage(MESSAGE_FAREWELL, "It was an honour to serve you, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "It was an honour to serve you.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Here. Don't forget that you need to buy a label too if you want to send a parcel. Always write the name of the {receiver} in the first line.")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "label", clientId = 3507, buy = 1 },
	{ itemName = "letter", clientId = 3505, buy = 8 },
	{ itemName = "parcel", clientId = 3503, buy = 15 },
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
