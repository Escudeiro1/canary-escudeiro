local internalNpcName = "Bozarn"
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
	lookHead = 39,
	lookBody = 38,
	lookLegs = 95,
	lookFeet = 115,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
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

keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Thais is often overcrowded and malodorous. It's almost impossible to find a suitable mansion there. And even if you do, the unseemly neighbours most likely prove unbearable." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "It is time precisely." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I'm a {manservant}, like my father and my grandfather before me." })
keywordHandler:addKeyword({ "manservant" }, StdModule.say, { npcHandler = npcHandler, text = "In {modern} days our responsibilities are numerous." })
keywordHandler:addKeyword({ "master" }, StdModule.say, { npcHandler = npcHandler, text = "My master is a noble and wise man. He dedicated his life and fortune to the pursuit of knowledge. ... He became a {scholar} of note at a young age, and in our days he is often consulted amongst his peers for his vast knowledge of diverse topics." })
keywordHandler:addAliasKeyword({ "mazarius" })
keywordHandler:addKeyword({ "nobility" }, StdModule.say, { npcHandler = npcHandler, text = "Only the most civilized realms have a nobility worthy of that name. I doubt that any of the non-human races even grasp the concept of nobility, which might explain their barbarism." })
keywordHandler:addKeyword({ "darashia" }, StdModule.say, { npcHandler = npcHandler, text = "It's quiet and lonely here compared to Thais. Sometimes I'm hard put to obtain everything we require from the market or local traders, but the climate becomes the master." })
keywordHandler:addKeyword({ "scholar" }, StdModule.say, { npcHandler = npcHandler, text = "I'm not knowledgeable enough to comment on my master's studies, but he certainly is well known for them to men of learning from all over the world." })
keywordHandler:addKeyword({ "modern" }, StdModule.say, { npcHandler = npcHandler, text = "Times have changed, and the {nobility} and the {rich} usually don't employ large staffs of people any more. Only the most important ones are kept and entrusted with more and more duties." })
keywordHandler:addKeyword({ "rich" }, StdModule.say, { npcHandler = npcHandler, text = "There is a new breed of nobility. Sophisticated men and women, who, through determination and intelligence, rise to a status that allows them to be recognised by the true nobility as almost, but not quite, equals." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
