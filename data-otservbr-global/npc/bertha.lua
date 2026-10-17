local internalNpcName = "Bertha"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 140,
	lookHead = 57,
	lookBody = 97,
	lookLegs = 116,
	lookFeet = 99,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Hey there, need some general goods or paperware?" },
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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "football") then
		npcHandler:say("Do you want to buy a football for 111 gold?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			local player = Player(creature)
			if player:getMoney() + player:getBankBalance() >= 111 then
				npcHandler:say("Here it is.", npc, creature)
				player:addItem(2990, 1)
				player:removeMoneyBank(111)
			else
				npcHandler:say("You don't have enough money.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		end
	end
	return true
end

keywordHandler:addKeyword({ "gods" }, StdModule.say, { npcHandler = npcHandler, text = "The gods seem to be far away in this corner of the world." })
keywordHandler:addKeyword({ "monsters" }, StdModule.say, { npcHandler = npcHandler, text = "There are enough monsters around to make you think twice about leaving the city." })
keywordHandler:addKeyword({ "news" }, StdModule.say, { npcHandler = npcHandler, text = "News? Are you mocking me? Almost any news would be good news. As long as it concerns Carlin's affairs, nothing seems to change for the better." })
keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "I toyed with the idea to spread the rumour that Excalibug might be hidden in the mines. I think if enough adventurers were lured into the mines, they might drive out the ones that occupy them now ... So do me a favour, when somebody asks about Excalibug, tell them it's down there in those mines." })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "Well, HE would only be needed to make things worse over here." })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "Carlin expects wonders of me. However, as long as they don't send some considerable help, they can wait until moss is growing in their hair." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "I guess whole Thais is laughing at the failure of our operations." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "The pompous king of Thais might be involved in the take-over of our mines." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I'm Bertha from Carlin." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I'm a trader by profession but here you could also call me the ambassador of Carlin. However, there is little I can do about our problems, and support from Carlin is virtually non-existent." })
keywordHandler:addKeyword({ "equipment" }, StdModule.say, { npcHandler = npcHandler, text = "I sell equipment for your adventure! Just ask me for a {trade} to see my wares." })
keywordHandler:addKeyword({ "years of serpents" }, StdModule.say, { npcHandler = npcHandler, text = "What a horrible threat those beasts have been. But if they hadn't vanished all of a sudden, we would never have stranded here." })
keywordHandler:addKeyword({ "barbarian test" }, StdModule.say, { npcHandler = npcHandler, text = "If you pass some disgusting barbarian test, you might become what they call an honourary barbarian. Just talk to jarl Sven the Younger about this nonsense and don't bother me." })
keywordHandler:addAliasKeyword({ "join" })
keywordHandler:addKeyword({ "how are you" }, StdModule.say, { npcHandler = npcHandler, text = "It could definitely be better but thanks for asking. I hope you're fine yourself." })
keywordHandler:addKeyword({ "svargrond" }, StdModule.say, { npcHandler = npcHandler, text = "These barbarians are still adapting to the city life but they do quite well I guess. They still lack interest in real trading and ... let's say they are a bit limited in their horizon." })
keywordHandler:addKeyword({ "bonelords" }, StdModule.say, { npcHandler = npcHandler, text = "Bonelords are one of the few threats of which we are spared here." })
keywordHandler:addKeyword({ "barbarian" }, StdModule.say, { npcHandler = npcHandler, text = "All this cold seems to have frozen the brains of those people to solid ice." })
keywordHandler:addKeyword({ "zathroth" }, StdModule.say, { npcHandler = npcHandler, text = "I think even the dark one does not care for these lands or is probably already done with it." })
keywordHandler:addKeyword({ "chakoya" }, StdModule.say, { npcHandler = npcHandler, text = "I think these chakoyas are only a tale to scare the local kids." })
keywordHandler:addKeyword({ "raiders" }, StdModule.say, { npcHandler = npcHandler, text = "Their presence is bad enough. The fact that they occupied the mines and that they hate us non-natives of this frozen rock makes things only worse." })
keywordHandler:addKeyword({ "nibelor" }, StdModule.say, { npcHandler = npcHandler, text = "Nibelor is an isle on which the local druids dwell." })
keywordHandler:addKeyword({ "mission" }, StdModule.say, { npcHandler = npcHandler, text = "Unless you can change the whole situation here, I don't have anything to do for you." })
keywordHandler:addAliasKeyword({ "task" })
keywordHandler:addKeyword({ "venore" }, StdModule.say, { npcHandler = npcHandler, text = "Venore's power and greed is a constant threat to our operations." })
keywordHandler:addKeyword({ "weapon" }, StdModule.say, { npcHandler = npcHandler, text = "Robert sells that. Go and ask him about that." })
keywordHandler:addKeyword({ "robert" }, StdModule.say, { npcHandler = npcHandler, text = "You can buy general goods from me. For weapons and armor you rather see my assistant Robert at the arena in the mountains to the west." })
keywordHandler:addKeyword({ "shaman" }, StdModule.say, { npcHandler = npcHandler, text = "That's how the local druids call themselves." })
keywordHandler:addKeyword({ "druids" }, StdModule.say, { npcHandler = npcHandler, text = "The druids of Carlin have quite good connections to the local druids here." })
keywordHandler:addKeyword({ "leader" }, StdModule.say, { npcHandler = npcHandler, text = "This city would need a new leader that wants to actively help our cause, but I don't see this happening any time soon." })
keywordHandler:addKeyword({ "edron" }, StdModule.say, { npcHandler = npcHandler, text = "They promised me these frozen lands could become for Carlin what Edron is for Thais. What a cruel joke." })
keywordHandler:addKeyword({ "enemy" }, StdModule.say, { npcHandler = npcHandler, text = "Our major enemy are the trade barons of Venore of course. They never gained foothold here though. Given how bad business is progressing in this settlement, it is not such a big surprise. They probably simply lost interest." })
keywordHandler:addKeyword({ "dwarf" }, StdModule.say, { npcHandler = npcHandler, text = "Sadly I could not win many dwarfs for our mining operations. They are probably afraid of Thais's reaction if it becomes known that they are helping us." })
keywordHandler:addKeyword({ "mines" }, StdModule.say, { npcHandler = npcHandler, text = "The mines are actually Carlin's property. If only the queen were sending soldiers, to get them back from this rabble. Venore is probably planning to take over these mines just as we are talking." })
keywordHandler:addKeyword({ "queen" }, StdModule.say, { npcHandler = npcHandler, text = "The queen expects miracles of us. But there is little we can do as long as the barbarians claim these mines that actually belong to us." })
keywordHandler:addKeyword({ "chyll" }, StdModule.say, { npcHandler = npcHandler, text = "That seems to be a god that the locals worship." })
keywordHandler:addKeyword({ "banor" }, StdModule.say, { npcHandler = npcHandler, text = "I'd like to see some knightly order cleansing this land in the name of Banor. But of course Banor's champions seek their glory in warmer areas." })
keywordHandler:addKeyword({ "camps" }, StdModule.say, { npcHandler = npcHandler, text = "There are several camps of the raiders somewhere in the South-West. If you want to end up as dog food, just travel there." })
keywordHandler:addKeyword({ "yeti" }, StdModule.say, { npcHandler = npcHandler, text = "Another senseless tale of superstitious natives." })
keywordHandler:addKeyword({ "cult" }, StdModule.say, { npcHandler = npcHandler, text = "Well, we heard of some strangers that travelled through this city. Not exchanging many words with the people here. The locals claim they headed straight to our old mines ... As far as I can tell though not much has changed at the mines. Our scouts are still attacked or even killed. So I assume the strangers were either killed or they are friends of the raiders ... I have no clue what has happened and I don't have the resources to find out." })
keywordHandler:addKeyword({ "jarl" }, StdModule.say, { npcHandler = npcHandler, text = "The jarl here is of no great help. Our equipment and wood is welcome but we get little profit out of these deals." })
keywordHandler:addKeyword({ "rumour" }, StdModule.say, { npcHandler = npcHandler, text = "I have confirmed information that Excalibug lies deep in the mines. If you manage to find it, you would be the biggest hero and everybody would know your name! ... King |PLAYERNAME|, who found Excalibug and saved the world !!! Sounds good, huh??" })

npcHandler:setMessage(MESSAGE_GREET, "Oh, please come in, |PLAYERNAME|. What can I do for you? If you need adventure equipment, ask me for a {trade}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Of course, just browse through my wares. {Footballs} have to be purchased separately.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "basket", clientId = 2855, buy = 6 },
	{ itemName = "black book", clientId = 2838, buy = 15 },
	{ itemName = "blue book", clientId = 2844, sell = 20 },
	{ itemName = "bottle", clientId = 2875, buy = 3 },
	{ itemName = "brown book", clientId = 2837, buy = 15 },
	{ itemName = "bucket", clientId = 2873, buy = 4 },
	{ itemName = "candelabrum", clientId = 2927, buy = 8 },
	{ itemName = "candlestick", clientId = 2917, buy = 2 },
	{ itemName = "closed trap", clientId = 3481, buy = 280, sell = 75 },
	{ itemName = "crowbar", clientId = 3304, buy = 260, sell = 50 },
	{ itemName = "crusher", clientId = 46627, buy = 500 },
	{ itemName = "cup", clientId = 2884, buy = 2 },
	{ itemName = "document", clientId = 2818, buy = 12 },
	{ itemName = "fishing rod", clientId = 3483, buy = 150, sell = 40 },
	{ itemName = "fur backpack", clientId = 7342, buy = 20 },
	{ itemName = "fur bag", clientId = 7343, buy = 5 },
	{ itemName = "gemmed book", clientId = 2842, sell = 100 },
	{ itemName = "green book", clientId = 2846, sell = 15 },
	{ itemName = "greeting card", clientId = 6386, buy = 30 },
	{ itemName = "grey small book", clientId = 2839, buy = 15 },
	{ itemName = "hand auger", clientId = 31334, buy = 25 },
	{ itemName = "inkwell", clientId = 3509, buy = 10, sell = 8 },
	{ itemName = "jug", clientId = 7244, buy = 10 },
	{ itemName = "machete", clientId = 3308, buy = 35, sell = 6 },
	{ itemName = "mug", clientId = 2880, buy = 4 },
	{ itemName = "net", clientId = 31489, buy = 50 },
	{ itemName = "orange book", clientId = 2843, sell = 30 },
	{ itemName = "parchment", clientId = 2817, buy = 8 },
	{ itemName = "pick", clientId = 3456, buy = 50, sell = 15 },
	{ itemName = "plate", clientId = 2905, buy = 6 },
	{ itemName = "present", clientId = 2856, buy = 10 },
	{ itemName = "rope", clientId = 3003, buy = 50, sell = 15 },
	{ itemName = "scroll", clientId = 2815, buy = 5 },
	{ itemName = "scythe", clientId = 3453, buy = 50, sell = 10 },
	{ itemName = "shovel", clientId = 3457, buy = 50, sell = 8 },
	{ itemName = "torch", clientId = 2920, buy = 2 },
	{ itemName = "valentine's card", clientId = 6538, buy = 30 },
	{ itemName = "watch", clientId = 2906, buy = 20, sell = 6 },
	{ itemName = "wooden hammer", clientId = 3459, sell = 15 },
	{ itemName = "worm", clientId = 3492, buy = 1 },
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
