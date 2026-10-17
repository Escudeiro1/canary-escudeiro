local internalNpcName = "Vuzrog"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 857,
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

keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "It's mealtime!" })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Me Vuzrog." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Vuzrog {chieftain}. Big boss of {Bloody Skull} tribe." })
keywordHandler:addKeyword({ "thunder tusks" }, StdModule.say, { npcHandler = npcHandler, text = "Hrmpf. Causing trouble all time. Attacking our village, plundering, taking away our food and {water}." })
keywordHandler:addKeyword({ "bloody skull" }, StdModule.say, { npcHandler = npcHandler, text = "Bloody Skulls are ogres who live here. This tribe. Most big clan of {Krailos}. Most strong {chieftain}. Most wise {shaman}." })
keywordHandler:addKeyword({ "great hunger" }, StdModule.say, { npcHandler = npcHandler, text = "Great Hunger powerful spirit. Always needs food, very much food. If Great Hunger not getting enough food, its stomach rumbling. Then earth quaking, trembling. At end Great Hunger will eat up entire world. So ogres always feeding Great Hunger." })
keywordHandler:addKeyword({ "chieftain" }, StdModule.say, { npcHandler = npcHandler, text = "Chieftain is big boss of ogre tribe. Strongest ogre always chieftain. Vuzrog strongest ogre here. So Vuzrog is big boss!" })
keywordHandler:addKeyword({ "krailos" }, StdModule.say, { npcHandler = npcHandler, text = "This steppe and grassland here. That Krailos. Home of ogres. Sourrounded by mountains and much water. We not know what behind water or mountains." })
keywordHandler:addKeyword({ "goblins" }, StdModule.say, { npcHandler = npcHandler, text = "Arrgh, wimpy shrimps! Stumbling around like warty toads. Sometimes ogres let them getting black stones from mountains. Small tunnels there, ogres not getting in. But small goblins can. And sometimes ogres eat them." })
keywordHandler:addKeyword({ "grubokk" }, StdModule.say, { npcHandler = npcHandler, text = "Grubokk young and impatient. Strong arms, but narrow in head. Oversees {goblins} in mines near high mountains." })
keywordHandler:addKeyword({ "shaman" }, StdModule.say, { npcHandler = npcHandler, text = "Shaman is spirit leader of tribe. Makes things right with spirits and {Great Hunger}. Blesses newborn ogrelings. {Ghorza} is {Bloody Skulls} shaman." })
keywordHandler:addKeyword({ "ghorza" }, StdModule.say, { npcHandler = npcHandler, text = "Ghorza tribe {shaman}. She wise, old woman. But also stubborn. Seems to like shrimpy {humans}. Vuzrog not knowing why. But Vuzrog has deal with Ghorza. ... Allows humans coming here. As long as tasty small titches not causing trouble." })
keywordHandler:addKeyword({ "humans" }, StdModule.say, { npcHandler = npcHandler, text = "Humans tasty. Ogres often eat them, taste better than goblins. But {Ghorza}, Bloody Skulls {shaman}, says: Not eat human visitors anymore." })
keywordHandler:addKeyword({ "nibble" }, StdModule.say, { npcHandler = npcHandler, text = "Nibble small {goblin}. Cooking for Vuzrog. Clearing away rubbish. Useful at moment. Perhaps later Vuzrog eats tiny titch." })
keywordHandler:addKeyword({ "mugruu" }, StdModule.say, { npcHandler = npcHandler, text = "Mugruu friend of {chieftain}. Makes things like shrimpy human {Larek} now. Buying things. But not for you! If want trading with Mugruu, first must help Vuzrog." })
keywordHandler:addKeyword({ "larek" }, StdModule.say, { npcHandler = npcHandler, text = "Is shrimpy human living here. First Vuzrog want eat him. But Larek bringing sweets. Cookies and candy. Vuzrog likes sweets! So allowed Larek to stay, if Larek brings sweets for Vuzrog." })
keywordHandler:addKeyword({ "water" }, StdModule.say, { npcHandler = npcHandler, text = "Very few water in {Krailos}. Most seas drying out. Ogres fighting for water. If want know more, ask {Ghorza}." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
