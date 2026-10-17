local internalNpcName = "An Ancient Priest"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 65,
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

keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I'm the caretaker of this tomb. I also know these parts like the back of my hand - just in case you need a status update." })
keywordHandler:addKeyword({ "breakthrough" }, StdModule.say, { npcHandler = npcHandler, text = "The spirits talked to the shamans and taught them many new things. The rock revealed its secrets and taught the humans to build with stone and to melt ore to metal. The water taught them about the places where to find it and how to conserve it. ... The scorpion taught the use of poison and medicine, explained how to craft an armor and told them much about warfare. Many more spirits revealed their secrets, big and small." })
keywordHandler:addKeyword({ "canopic jars" }, StdModule.say, { npcHandler = npcHandler, text = "The canopic jars contain the preserved organs of Horestis's mummified body. ... They are powerful magic talismans that ward off any intrusion into Horestis's tomb." })
keywordHandler:addKeyword({ "prosecution" }, StdModule.say, { npcHandler = npcHandler, text = "In the jungle the cruel lizards hunted humans for sport and although food was abundant, the humans were denied any hunting grounds as the lizards claimed everything for themselves." })
keywordHandler:addKeyword({ "caretaker" }, StdModule.say, { npcHandler = npcHandler, text = "I preserve the history of the great Pharaoh Horestis." })
keywordHandler:addKeyword({ "prevailed" }, StdModule.say, { npcHandler = npcHandler, text = "They learned to live with that little that the desert and the sea had to offer. They dwelt in the caves of the mountains, however, some split and rather roamed the desert." })
keywordHandler:addKeyword({ "chieftain" }, StdModule.say, { npcHandler = npcHandler, text = "When the dynasty emerged, the chieftains were called Pharaohs. They were the absolute rulers on this side of the mountains. Soon the caves were abandoned and people left for fortified settlements." })
keywordHandler:addKeyword({ "abandoned" }, StdModule.say, { npcHandler = npcHandler, text = "When the caves were abandoned, Horestis ordered to rebuild them into a temple and a tomb at once." })
keywordHandler:addKeyword({ "horestis" }, StdModule.say, { npcHandler = npcHandler, text = "He was one of the first Pharaohs of the united tribes and under his rule the race of man flourished to formerly unknown heights." })
keywordHandler:addKeyword({ "heights" }, StdModule.say, { npcHandler = npcHandler, text = "He wisely used the power of his position to unite the tribes of the desert who formerly defied the rules of the dynasty." })
keywordHandler:addKeyword({ "dynasty" }, StdModule.say, { npcHandler = npcHandler, text = "The ancestors of the dynasty led the human tribes from the lizard-ruled jungles to the desert where they could finally live without prosecution." })
keywordHandler:addKeyword({ "lizards" }, StdModule.say, { npcHandler = npcHandler, text = "The lizards were powerful and many. They wielded magic unknown to the race of man at this time. Nothing could oppose their rule in these days. ... The desert was harsh but avoided by the lizards. Due to cunning and resilience the humans prevailed where the lizards had failed." })
keywordHandler:addKeyword({ "spirits" }, StdModule.say, { npcHandler = npcHandler, text = "The spirits of nature and of the animals began to talk to selected individuals. Individuals that used forbidden arts derived from what had been stolen from the lizards." })
keywordHandler:addKeyword({ "studies" }, StdModule.say, { npcHandler = npcHandler, text = "The first shamans of mankind wielded only little power and there was only a small distinction between magic and making fire or creating a tool. ... But when their dabbling with magic brought them into connection with the spirit world it became a breakthrough." })
keywordHandler:addKeyword({ "secrets" }, StdModule.say, { npcHandler = npcHandler, text = "With the emergence of these secrets, the shamans came out of hiding and boldly rose to power. Fights ensued and only the most mighty would prevail as leaders." })
keywordHandler:addKeyword({ "leaders" }, StdModule.say, { npcHandler = npcHandler, text = "The most powerful shaman and fighter became the chieftain and the others became priests under his rule. ... The chieftain married only into the families of priests and soon the first dynasty emerged." })
keywordHandler:addKeyword({ "status" }, StdModule.say, { npcHandler = npcHandler, text = "Horestis's body has been desecrated. His curse now hangs over the land like the shadow of the vulture. Abandon all hope mortals, his vengeance will be dreadful." })
keywordHandler:addKeyword({ "danger" }, StdModule.say, { npcHandler = npcHandler, text = "Some defied the rules of the dynasty that had made the jungle of Tiquanda taboo for all humans. When they wandered into the jungle to hunt and steal equipment and secrets about the desert, they provoked punishing raids by the lizard people." })
keywordHandler:addKeyword({ "temple" }, StdModule.say, { npcHandler = npcHandler, text = "Wide parts of the caves were planned to become a temple where the spirits of nature could be worshipped. ... It served as spiritual centre of the realm and Horestis's tomb was an integral part of the complex." })
keywordHandler:addKeyword({ "caves" }, StdModule.say, { npcHandler = npcHandler, text = "The caves were the first safe haven of humankind since the beginning of time. They were widened and artificial caves were added. ... Even later when a settlement had been built at the coast, the caves served as final retreat and fortress in times of danger." })
keywordHandler:addKeyword({ "raids" }, StdModule.say, { npcHandler = npcHandler, text = "The raids were a great danger for the tribes of man in these days. They had not the manpower or weapons to stand against the might of the lizards." })
keywordHandler:addKeyword({ "might" }, StdModule.say, { npcHandler = npcHandler, text = "Only slowly the humans became a power on their own. They learned from the desert, they learned from its inhabitants and finally, they learned how to communicate with its spirits." })
keywordHandler:addKeyword({ "arts" }, StdModule.say, { npcHandler = npcHandler, text = "In the jungle, the humans had learned some of the most basic principles of magic through observation and experimentation. ... Although everything connected with the lizard was seen as tainted, many of the greatest minds turned their attention to those studies." })
keywordHandler:addKeyword({ "pact" }, StdModule.say, { npcHandler = npcHandler, text = "The spirits, the temple and the tomb became forgotten. ... A few of the remaining priests, loyal to the pact, exiled themselves to the complex and summoned vengeful spirits as guardians of the tomb and the temple and they constructed several protections to ensure that Horestis's eternal rest is not disturbed." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
