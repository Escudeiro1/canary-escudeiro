local internalNpcName = "Wally"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 129,
	lookHead = 96,
	lookBody = 113,
	lookLegs = 95,
	lookFeet = 115,
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

keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "One of the oldest holdings of humanity that still exist and the heart of the biggest kingdom in the known world." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I'm Wally the post officer." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am working here at the post office for Kevin." })
keywordHandler:addKeyword({ "the big old one" }, StdModule.say, { npcHandler = npcHandler, text = "Its a huge Mountain, north of here, just across the river." })
keywordHandler:addKeyword({ "dwarfs" }, StdModule.say, { npcHandler = npcHandler, text = "The city of the dwarfs is a bit hidden and new postoficers often get lost while looking for it. Just look for a hidden passage to a western valley in the mountaion called the big old one." })
keywordHandler:addAliasKeyword({ "kazordoon" })
keywordHandler:addKeyword({ "benjamin" }, StdModule.say, { npcHandler = npcHandler, text = "Old Ben lost some of his marbles in some battle long ago. He is still a quite capable postman though ... on second thought thats some disturbing fact." })
keywordHandler:addKeyword({ "mission" }, StdModule.say, { npcHandler = npcHandler, text = "Ask Mr. Postner about your current missions." })
keywordHandler:addKeyword({ "markwin" }, StdModule.say, { npcHandler = npcHandler, text = "This minotaur is quite moody. Better make sure not to anger him. He's likely to call for his guards as soon as he notices a stranger, so you are on tough luck if you ever find him." })
keywordHandler:addKeyword({ "noodles" }, StdModule.say, { npcHandler = npcHandler, text = "This dog is his majestys most priced possesion and heavily guarded. Anger the dog and you anger the king." })
keywordHandler:addKeyword({ "venore" }, StdModule.say, { npcHandler = npcHandler, text = "I think no longer is king Tibianus reigning this city, nor are the merchants ruling it, regardless what they might think. The true monarch before whom all there bow is the money." })
keywordHandler:addKeyword({ "kevin" }, StdModule.say, { npcHandler = npcHandler, text = "Oh, our boss is upstairs. Better only disturb him with important issues though." })
keywordHandler:addKeyword({ "elven" }, StdModule.say, { npcHandler = npcHandler, text = "Elven volunteers for becoming a postofficer are quite rare. We had to rely on a human living there to ensure our postsystems function. Most elvish members of the guild prefer to work as courriers." })
keywordHandler:addKeyword({ "edron" }, StdModule.say, { npcHandler = npcHandler, text = "I gues Edron isn't the source of wealth and rescources as the thaians hoped. The defection of those knights did cause the expansion and exploitation there to an halt." })
keywordHandler:addKeyword({ "bones" }, StdModule.say, { npcHandler = npcHandler, text = "If I would be looking for bones I'd inspect some skeletons ... If I weren't so affraid of them that is." })
keywordHandler:addKeyword({ "liane" }, StdModule.say, { npcHandler = npcHandler, text = "Although I never met her in person we became penpals over the time." })
keywordHandler:addKeyword({ "lokur" }, StdModule.say, { npcHandler = npcHandler, text = "Dwarfs make quite good postmen. They are stubborn, strong and ... sturdy. Its a waste that he prefers a job behind the counter." })
keywordHandler:addKeyword({ "olrik" }, StdModule.say, { npcHandler = npcHandler, text = "This Olrik was made postman only for convenience. He is quite aware that his attitude and affiliation with the thaian government makes it impossible for him to rise in rank. This leads only to him behaving even worse tough." })
keywordHandler:addKeyword({ "dove" }, StdModule.say, { npcHandler = npcHandler, text = "Dove is as good as a dozend pigeons. He He He." })
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
