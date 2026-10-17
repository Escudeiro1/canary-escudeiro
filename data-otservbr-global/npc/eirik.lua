local internalNpcName = "Eirik"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 251,
	lookHead = 79,
	lookBody = 116,
	lookLegs = 116,
	lookFeet = 116,
	lookAddons = 3,
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

keywordHandler:addKeyword({ "news" }, StdModule.say, { npcHandler = npcHandler, text = "I am busy. Please ask the citizens for news." })
keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "I would love to have that legendary weapon. If you find it, bring it to me!" })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "Wait, wait! Don't say a word, it's, it's ... that very small guy with the hairy feet? No?" })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I AM A BARBARIAN! Names are of no concern during work!! If somebody is calling for help, I will come." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "It's my duty to protect Svargrond and its citizens." })
keywordHandler:addKeyword({ "sorcerers" }, StdModule.say, { npcHandler = npcHandler, text = "You have to look for Romir." })
keywordHandler:addKeyword({ "grimlund" }, StdModule.say, { npcHandler = npcHandler, text = "Stay away from there! It's the home of the chakoyas." })
keywordHandler:addKeyword({ "paladins" }, StdModule.say, { npcHandler = npcHandler, text = "You have to look for Hawkyr." })
keywordHandler:addKeyword({ "thorwulf" }, StdModule.say, { npcHandler = npcHandler, text = "He is the trainer for knights. You find him near the arena." })
keywordHandler:addKeyword({ "mission" }, StdModule.say, { npcHandler = npcHandler, text = "The shamans still have something to do for you. You should go to Nibelor and talk to them if you haven't been there for a while." })
keywordHandler:addKeyword({ "nibelor" }, StdModule.say, { npcHandler = npcHandler, text = "It's a sacred place for us! Our shamans live there. Ask Iskan if you want to go there." })
keywordHandler:addKeyword({ "hrodmir" }, StdModule.say, { npcHandler = npcHandler, text = "This big, icy rock you're standing at right now. The raiders live in the middle and south of the big Formorgar glacier." })
keywordHandler:addKeyword({ "knights" }, StdModule.say, { npcHandler = npcHandler, text = "You have to look for Thorwulf." })
keywordHandler:addKeyword({ "fimbul" }, StdModule.say, { npcHandler = npcHandler, text = "Fimbul Shelf is the name of the big shelf ice west of Svargrond. A good spot to go ice fishing." })
keywordHandler:addKeyword({ "druids" }, StdModule.say, { npcHandler = npcHandler, text = "You have to look for Hjaern." })
keywordHandler:addKeyword({ "hjaern" }, StdModule.say, { npcHandler = npcHandler, text = "He is one of our shamans and trainer for druids. He lives on Nibelor." })
keywordHandler:addKeyword({ "hawkyr" }, StdModule.say, { npcHandler = npcHandler, text = "He is the paladin trainer. You find him near the arena." })
keywordHandler:addKeyword({ "iskan" }, StdModule.say, { npcHandler = npcHandler, text = "He is the leader of the dog sled. Last time I saw him he was with his dogs on the shelf ice north of the harbour." })
keywordHandler:addKeyword({ "shelf" }, StdModule.say, { npcHandler = npcHandler, text = "West of Svargrond is the Fimbul Ice Shelf, Nibelor and Grimlund are embedded in shelf ice, and in the north of Hrodmir are several small shelf ice fields." })
keywordHandler:addKeyword({ "magic" }, StdModule.say, { npcHandler = npcHandler, text = "I heard Nelly talking about runes and fluids. Ask her." })
keywordHandler:addKeyword({ "romir" }, StdModule.say, { npcHandler = npcHandler, text = "He is an old hermit who lives in a hut on the elevated plain north of Svargrond. He is some kind of male witch, you know what I mean? ... He knows magic and all that. Maybe he teaches his knowledge to others." })
keywordHandler:addKeyword({ "sled" }, StdModule.say, { npcHandler = npcHandler, text = "You can ask Iskan to bring you with his dog sled to Nibelor." })
keywordHandler:addKeyword({ "shop" }, StdModule.say, { npcHandler = npcHandler, text = "Near the harbour you find the equipment shop, the branch of the explorer's society as well as the post office and the bank. ... Right-hand of the depot, which is in the centre of Svargrond, you find the furniture store ... All weapon and armor traders linger at the arena in the North and the tavern is to the west." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
