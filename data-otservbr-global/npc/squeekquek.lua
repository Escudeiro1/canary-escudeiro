local internalNpcName = "Squeekquek"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 532,
	lookHead = 0,
	lookBody = 113,
	lookLegs = 95,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
}

npcConfig.shop = {}

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

keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "There sewers are that clean, atrocity it is!" })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Crowded, violence, stinky and dirty, a heaven on earth! One day the Corym will rule over Thais." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Me simple Corym is. Me doing some hauling in the {market}." })
keywordHandler:addKeyword({ "recommendation" }, StdModule.say, { npcHandler = npcHandler, text = "Me guess you out of luck here. Everyone knows you are a pain in the side of every villain since you coming from mainland. No one here will ever trade with mean you." })
keywordHandler:addKeyword({ "forest fury" }, StdModule.say, { npcHandler = npcHandler, text = "Strange creature, half woman, half deer. Looking so funny! We caught one and keep her in a cage, so anyone might see her." })
keywordHandler:addKeyword({ "ab'dendriel" }, StdModule.say, { npcHandler = npcHandler, text = "They are making some good cheese over there, me have to admit. Hmmm, stolen cheese!" })
keywordHandler:addKeyword({ "prophecies" }, StdModule.say, { npcHandler = npcHandler, text = "The prophecies speak of the holy land that Corym once will find. If they spread enough they one day will find the promised land of milk and cheese, Mousetralia!" })
keywordHandler:addKeyword({ "kazordoon" }, StdModule.say, { npcHandler = npcHandler, text = "So many pretty tunnels and so many mean dwarfs." })
keywordHandler:addKeyword({ "cyclops" }, StdModule.say, { npcHandler = npcHandler, text = "One-eyes are good smiths. Corym sometimes find metals that are of interest to one-eyes. Others often buy one-eyes' wares. Corym trade with them a lot." })
keywordHandler:addKeyword({ "market" }, StdModule.say, { npcHandler = npcHandler, text = "It's big market for everything. Other Corym come here to sell stuff they have ... found, yes, yes. And {people} come here to buy and sell {stuff}. Market is open only for trusted customers. This excludes you, of course." })
keywordHandler:addKeyword({ "people" }, StdModule.say, { npcHandler = npcHandler, text = "Different people come here for {trade}. People who not ... wanted other place. Or who wanted there, that is, yes, yes. Here people are all equal welcome. ... Who has good gold is good people here and welcome. Here are people from all places of world. Often traveling through secret Corym tunnels and paying for passage." })
keywordHandler:addKeyword({ "leader" }, StdModule.say, { npcHandler = npcHandler, text = "Raticus was great leader full of shrewd ideas and cunning. He saw potential in trading with others, being neutral party between all. ... Built great trading empire and had even greater {plans} but he {died} too young." })
keywordHandler:addKeyword({ "chosen" }, StdModule.say, { npcHandler = npcHandler, text = "Sometimes the big cheese chooses his champions amongst the Corym. They are fierce fighters, skilled looters, great diggers, shrewd leaders and the like. ... They become famous, rich and powerful but often fall prey to strange accidents. That is because big cheese is constantly testing them and if they fall, they are not worthy." })
keywordHandler:addKeyword({ "amazon" }, StdModule.say, { npcHandler = npcHandler, text = "Warrior-women are strong but often grim. Many of them don't like little corym. But some come here because they have no place at home anymore." })
keywordHandler:addKeyword({ "plans" }, StdModule.say, { npcHandler = npcHandler, text = "Raticus ever had great plans. Market idea was just one of them, yes, yes. He other great ideas had. He once was training big tortoises to become his bodyguards and the like! ... His ultimate plan though was get enough money to found expeditions to find the holy land of Corym {prophecies}." })
keywordHandler:addKeyword({ "stuff" }, StdModule.say, { npcHandler = npcHandler, text = "Other Corym sell stuff that they acquired elsewhere. Buy weapons from Cyclopses and sell them to orc and the like. But selling stuff to anyone is the rule here. ... Also sell lodge to people who on the run or looking for job. Some come here to sell stuff that they can't sell other where. Stuff they took and owner might looking. ... Some come here to {fight} and some Corym arrange that, too. Others just come here to spend the money they ... got somehow." })
keywordHandler:addKeyword({ "fight" }, StdModule.say, { npcHandler = npcHandler, text = "Some people liking fighting, others liking to bet their money. Me people eagerly deliver what is wanted." })
keywordHandler:addKeyword({ "corym" }, StdModule.say, { npcHandler = npcHandler, text = "We are numerous but hidden well. I have family everywhere in the world! We have many enemies and must stick together. ... On the other hand the commandments of the big cheese order us to spread." })
keywordHandler:addKeyword({ "died" }, StdModule.say, { npcHandler = npcHandler, text = "He choked on his food. Poor Raticus. Leader of market are always in bad luck. All die fast and competitors too. The great cheese puts big burden on his {chosen}." })
keywordHandler:addKeyword({ "sell" }, StdModule.say, { npcHandler = npcHandler, text = "Great trade bosses are suspicious towards strangers, yes, yes. Without invitation or {recommendation} there no way is, anyone will make trade with you." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
