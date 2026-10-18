local internalNpcName = "Larek"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 472,
	lookHead = 19,
	lookBody = 50,
	lookLegs = 10,
	lookFeet = 3,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "What an interesting speck of land. I have to write down all this in my essay." },
	{ text = "I should provide more cookies for the ogres. They're looking at me so hungrily." },
	{ text = "Hm, guess I haven't found all new plants in this secluded part of the world yet." },
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
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "Unfortunately I lost my watch some weeks ago when exploring the steppe and cataloguing the plant life." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Larek. Some call me Larek the Wayfarer, because of my voyages to many faraway lands." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I like to think of myself as a discoverer and explorer of unknown regions and cultures. At the moment I'm acting as a kind of merchant. It is a convenient way to get {Vuzrog's} permission to live here for a time without getting eaten." })
keywordHandler:addKeyword({ "bloody skulls" }, StdModule.say, { npcHandler = npcHandler, text = "That's the tribe living in this village. They are one of the settled clans, whilst others are still nomadic. In addition, they seem to be the only tribe so far that tolerates humans. ... Mainly because the {shaman} sees a {benefit} in our presence." })
keywordHandler:addKeyword({ "chieftain" }, StdModule.say, { npcHandler = npcHandler, text = "The strongest male ogre is a tribe's chieftain. For the {Bloody Skulls} this is {Vuzrog}, at least at the moment. But {Ghorza} seems to expect that a younger ogre will challenge him soon." })
keywordHandler:addKeyword({ "forbidden" }, StdModule.say, { npcHandler = npcHandler, text = "The humans who lived here so long ago worshipped the suns of our world. Not only the calm and considerate {Suon} but also his reckless and wild sister {Fafnar}. As far as I found out, the veneration of these two aspects was in balance for a long time. ... But the the adherents to the wild goddess Fafnar prevailed and the destructive nature of their goddess eventually caused the downfall of this ancient empire." })
keywordHandler:addKeyword({ "secluded" }, StdModule.say, { npcHandler = npcHandler, text = "Krailos is surrounded by many underwater shelves. They make it difficult for ships to reach the coast unscathed. At the rugged shores you may find the one or other shipwreck." })
keywordHandler:addKeyword({ "benefit" }, StdModule.say, { npcHandler = npcHandler, text = "Ogres value food above all things. They like meat or beer, but as I found out they also adore sweets! They're downright scoffing them. But they don't know how to make cookies or candy. And at this point the humans come in. ... As far as I'm concerned, I survive amongst the ogres because I play the role of a merchant here. I provide them with sweets, they let me live here and pursue my studies about {Krailos}." })
keywordHandler:addKeyword({ "krailos" }, StdModule.say, { npcHandler = npcHandler, text = "Krailos is this vast grassland and steppe you are standing in, and is mainly populated by {ogres}. The region is located north of {Oramond}, bordered by high mountains to the south and a wild sea to the east, west and north. ... It's a {secluded} area, but it seems to has a very interesting {history}." })
keywordHandler:addKeyword({ "society" }, StdModule.say, { npcHandler = npcHandler, text = "The ogres are a tribal people, divided into several different clans. Leader of a tribe is usually the strongest male ogre. The {chieftain} is supported by an ogre-shaman. If the {shaman} is female, the two are often, but not necessarily, a couple." })
keywordHandler:addKeyword({ "oramond" }, StdModule.say, { npcHandler = npcHandler, text = "Oramond lies south of here, separated from Krailos by a high mountain chain. It's very different from the ogre lands, but also dangerous. Many minotaurs live there." })
keywordHandler:addKeyword({ "history" }, StdModule.say, { npcHandler = npcHandler, text = "Once a sophisticated, but peaceful grassland empire existed on this peninsula. It was noted for its advanced architecture and philosophy. ... But it was destroyed hundreds of years ago through social breakdown, caused by their interest in {forbidden} things. ... In this empire the ogres were not quite slaves, but rather a kind of deprived lower class. Yet it seems they were the only ones to survive the downfall of this ancient realm, perhaps simply because of their physical strength." })
keywordHandler:addKeyword({ "goblins" }, StdModule.say, { npcHandler = npcHandler, text = "There are quite a few goblins living here in Krailos. I suppose they originally arrived as stowaways on the ships that now and then burst at Krailos' rocky shores. Most of these goblins are kept as slaves by the ogres. ... As are other smaller races like dworcs or coryms." })
keywordHandler:addKeyword({ "grubokk" }, StdModule.say, { npcHandler = npcHandler, text = "He's strong but narrow-minded even by ogre standards. He's not often here in the village so I have seen him just a few times. And it's better that way for I assume he's cruel and sadistic." })
keywordHandler:addKeyword({ "vuzrog" }, StdModule.say, { npcHandler = npcHandler, text = "He's the {chieftain} of the {Bloody Skulls} tribe and, to be honest, he is the exemplary ogre: big, strong, always hungry, blunt and not very clever. ... But as he is the strongest indivdual of this tribe, he also is the big boss, as the ogres often call the chieftain." })
keywordHandler:addKeyword({ "ghorza" }, StdModule.say, { npcHandler = npcHandler, text = "Ghorza is the tribe's {shaman}. I have the impression that she is a rather unusual ogress, because she's interested in humans not only in the sense of a tasty snack. She seems to think that we could be useful to her and the tribe." })
keywordHandler:addKeyword({ "shaman" }, StdModule.say, { npcHandler = npcHandler, text = "The shaman is very important for an ogre tribe. Often, but not always, the shaman is an elder ogress. She cares for the spiritual welfare of the tribe, appeases the spirits, blesses newborn ogre-children and the like. ... This tribe's shaman is {Ghorza}." })
keywordHandler:addKeyword({ "fafnar" }, StdModule.say, { npcHandler = npcHandler, text = "Fafnar is one of the two suns of our world, considered as one of the gods, the daughter of {Fardos}, by many. Some call her the Scorching Sun and believe that she observes creation with hate and jealousy. ... But others think she's the stronger of the two suns, that {Suon}'s light turns pale compared to her brightness." })
keywordHandler:addKeyword({ "fardos" }, StdModule.say, { npcHandler = npcHandler, text = "Fardos is considered the creator, often called the Great Observer. Many people believe that it was his doing that we possess divine souls." })
keywordHandler:addKeyword({ "mugruu" }, StdModule.say, { npcHandler = npcHandler, text = "He's one of the ogres living here. He studied me for a while and now seems to imitate my behavior. He dabbles in trading now, buying different things. ... You could talk to him but I suppose, he'll not make a trade with you without the {chieftain}'s permission." })
keywordHandler:addKeyword({ "nibble" }, StdModule.say, { npcHandler = npcHandler, text = "He's a goblin who is being kept as a slave by the chieftain {Vuzrog}. Poor little fellow." })
keywordHandler:addKeyword({ "ogres" }, StdModule.say, { npcHandler = npcHandler, text = "The ogres are simple, warlike people, more interested in a fight and good {food} than in politics. Ogres like conflict; they are impulsive and quick to anger. They prefer to solve conflicts through combat rather than words. ... They are distrustful towards strangers like us and tend to welcome them with avoidance in the best case. Lately yet, the {Bloody Skulls} tribe here has shown a sort of {benefit} in trade with other peoples." })
keywordHandler:addKeyword({ "food" }, StdModule.say, { npcHandler = npcHandler, text = "An honorable death is not the highest purpose in an ogre's life, but rather a fulfilled life, which primarily means enough food and a comfortable hut. Food carries great weight in ogre life and {society}." })
keywordHandler:addKeyword({ "suon" }, StdModule.say, { npcHandler = npcHandler, text = "Suon is one of the two suns of our world, considered as one of the gods, the son of {Fardos}, by many. Some call him the Life-Bringing Sun and believe that he observes creation with love and blesses us with warmth and growth. ... Others guess he is just the misguided sibling of {Fafnar} and that his light turns pale compared to her brightness." })
keywordHandler:addKeyword({ "kaya" }, StdModule.say, { npcHandler = npcHandler, text = "Ah, yes, the charming Kaya is actually my research assistant. She's very proficient in Tibia's classical languages and myths. However, as we can't leave the village at the moment she is helping me with my private {bank} that I'm currently establishing." })
keywordHandler:addKeyword({ "bank" }, StdModule.say, { npcHandler = npcHandler, text = "Yes, of course. Simply lift the grille in my tent and walk down. Ask {Kaya} if you want to withdraw or deposit some money." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "black pearl", clientId = 3027, sell = 280 },
	{ itemName = "cookie", clientId = 3598, buy = 7 },
	{ itemName = "flour", clientId = 3603, buy = 30 },
	{ itemName = "hoe", clientId = 3455, buy = 15 },
	{ itemName = "juice squeezer", clientId = 5865, buy = 100 },
	{ itemName = "kitchen knife", clientId = 3469, buy = 20 },
	{ itemName = "onyx chip", clientId = 22193, sell = 500 },
	{ itemName = "opal", clientId = 22194, sell = 500 },
	{ itemName = "rope", clientId = 3003, buy = 50 },
	{ itemName = "shovel", clientId = 3457, buy = 50 },
	{ itemName = "small ruby", clientId = 3030, sell = 250 },
	{ itemName = "small topaz", clientId = 9057, sell = 200 },
	{ itemName = "vial", clientId = 2874, buy = 20 },
	{ itemName = "vial of milk", clientId = 2874, buy = 50, count = 9 },
	{ itemName = "white pearl", clientId = 3026, sell = 160 },
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
