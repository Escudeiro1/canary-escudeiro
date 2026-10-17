local internalNpcName = "Jimbin"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 160,
	lookHead = 97,
	lookBody = 127,
	lookLegs = 97,
	lookFeet = 76,
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

keywordHandler:addKeyword({ "army" }, StdModule.say, { npcHandler = npcHandler, text = "I supply the army with dwarfish beer to keep morals high." })
keywordHandler:addKeyword({ "news" }, StdModule.say, { npcHandler = npcHandler, text = "Oh well, many hidden places of ancient times appear seemingly out of nowhere in these times." })
keywordHandler:addAliasKeyword({ "rumour" })
keywordHandler:addAliasKeyword({ "rumor" })
keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "Actually I belive it's more than a taverntale." })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "Hah! He never dares to trespass our realm." })
keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "The Tibia our race was born into was even more fierce than the world you young ones know." })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "Silly town. Alcohol is forbidden there and elves visit this town quite often, what certainly suggests nothing good about a town, jawoll." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Bah! Humans, can't stand a drink, jawoll." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "The king orders huge amounts of mushroombeer for festivities." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "It is about 12:28 pm." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am Jimbin Luckythroat, son of Earth, from the Molten Rock." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I'm runing the Jolly Axeman together with my wife Maryza." })
keywordHandler:addAliasKeyword({ "tavern" })
keywordHandler:addKeyword({ "drink" }, StdModule.say, { npcHandler = npcHandler, text = "I can offer you beer... or water if you are sick. If you'd like to see my offers, ask me for a {trade}." })
keywordHandler:addKeyword({ "book" }, StdModule.say, { npcHandler = npcHandler, text = "The cookbook? It belongs to Maryza. I think she has a few copies for sale." })
keywordHandler:addKeyword({ "general" }, StdModule.say, { npcHandler = npcHandler, text = "The general is a fine man. Can drink as much as he wants and still is sober." })
keywordHandler:addKeyword({ "maryza" }, StdModule.say, { npcHandler = npcHandler, text = "She's a fine cook; likes it bloddy, though. Humans call her Bloody Mary, but don't mention that to her if you're smart." })
keywordHandler:addKeyword({ "food" }, StdModule.say, { npcHandler = npcHandler, text = "Ask my wife Maryza for food." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
