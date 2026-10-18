local internalNpcName = "Ray"
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
	lookHead = 19,
	lookBody = 115,
	lookLegs = 126,
	lookFeet = 58,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "If you need help with letters or parcels, just ask me. I can explain everything." },
	{ text = "Stay in touch with your friends. Send a letter, let them know you care and such!" },
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

keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "There are rumours about some hidden stone tablets mentioning that weapon. Adventurers claim to have seen those tablets in the ancient lizard city." })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "I hope this colony is too remote and meaningless to him to care for a visit." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "All cities are covered by our mailing system." })
keywordHandler:addAliasKeyword({ "carlin" })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "Now it's 10:50 am." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Ray." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am responsible for this post office. If you have questions about the mail system or the depots, just ask me." })
keywordHandler:addKeyword({ "king tibianus" }, StdModule.say, { npcHandler = npcHandler, text = "The king lives far away in the lovely city of Thais, but even he can be reached by our mailing system." })
keywordHandler:addKeyword({ "lizards" }, StdModule.say, { npcHandler = npcHandler, text = "The lizards give me shivers. They are so alien, even more than the minotaurs or orcs we know from the surroundings of Thais." })
keywordHandler:addKeyword({ "dworcs" }, StdModule.say, { npcHandler = npcHandler, text = "Those bloodthirsty headhunters live in the south. I heard only horrible stories about them and I believe they are not exaggerated." })
keywordHandler:addKeyword({ "jungle" }, StdModule.say, { npcHandler = npcHandler, text = "The jungle is a dangerous place. Many got lost there and never returned." })
keywordHandler:addKeyword({ "apes" }, StdModule.say, { npcHandler = npcHandler, text = "They are a pest. A quite dangerous pest as far as I can tell." })
keywordHandler:addKeyword({ "post" }, StdModule.say, { npcHandler = npcHandler, text = "With our mail system you can send letters and parcels to other Tibians. I can either explain how letters and parcels work or sell them to you if you ask me for a {trade}." })
keywordHandler:addAliasKeyword({ "mail" })
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
