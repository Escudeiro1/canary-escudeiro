local internalNpcName = "Yaman"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 103,
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

local function endConversationWithDelay(npcHandler, npc, creature)
	addEvent(function()
		npcHandler:unGreet(npc, creature)
	end, 1000)
end

local function greetCallback(npc, creature, message)
	local player = Player(creature)
	local playerId = player:getId()

	--Checks if the player has completed the quest
	if player:getStorageValue(Storage.Quest.U7_4.DjinnWar.EfreetFaction.Mission03) ~= 3 then
		if not MsgContains(message, "djanni'hah") and player:getStorageValue(Storage.Quest.U7_4.DjinnWar.Faction.Greeting) < 0 then
			npcHandler:say("Shove off, little one! Humans are not welcome here, |PLAYERNAME|!", npc, creature)
			endConversationWithDelay(npcHandler, npc, creature)
			return false
		end

		if player:getStorageValue(Storage.Quest.U7_4.DjinnWar.MaridFaction.Start) == 1 then
			npcHandler:say({
				"Hahahaha! ...",
				"|PLAYERNAME|, that almost sounded like the word of greeting. Humans - cute they are!",
			}, npc, creature)
			endConversationWithDelay(npcHandler, npc, creature)
			return false
		end
	end

	npcHandler:say("Be greeted, human |PLAYERNAME|. How can a humble djinn be of service?", npc, creature)
	npcHandler:setInteraction(npc, creature)

	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if table.contains({ "enchanted chicken wing", "boots of haste", "Enchanted Chicken Wing", "Boots of Haste" }, message) then
		npcHandler:say("Do you want to trade Boots of haste for Enchanted Chicken Wing?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif table.contains({ "warrior sweat", "warrior helmet", "Warrior Sweat", "Warrior Helmet" }, message) then
		npcHandler:say("Do you want to trade 4 Warrior Helmet for Warrior Sweat?", npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif table.contains({ "fighting spirit", "royal helmet", "Fighting Spirit", "Royal Helmet" }, message) then
		npcHandler:say("Do you want to trade 2 Royal Helmet for Fighting Spirit", npc, creature)
		npcHandler:setTopic(playerId, 3)
	elseif table.contains({ "magic sulphur", "fire sword", "Magic Sulphur", "Fire Sword" }, message) then
		npcHandler:say("Do you want to trade 3 Fire Sword for Magic Sulphur", npc, creature)
		npcHandler:setTopic(playerId, 4)
	elseif table.contains({ "job", "items", "Items", "Job" }, message) then
		npcHandler:say("I trade Enchanted Chicken Wing for Boots of Haste, Warrior Sweat for 4 Warrior Helmets, Fighting Spirit for 2 Royal Helmet Magic Sulphur for 3 Fire Swords", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "cookie") then
		if player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.Questline) == 31 and player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.CookieDelivery.Djinn) ~= 1 then
			npcHandler:say("You brought cookies! How nice of you! Can I have one?", npc, creature)
			npcHandler:setTopic(playerId, 5)
		end
	elseif MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) >= 1 and npcHandler:getTopic(playerId) <= 4 then
			local trade = {
				{ NeedItem = 3079, Ncount = 1, GiveItem = 5891, Gcount = 1 }, -- Enchanted Chicken Wing
				{ NeedItem = 3369, Ncount = 4, GiveItem = 5885, Gcount = 1 }, -- Flask of Warrior's Sweat
				{ NeedItem = 3392, Ncount = 2, GiveItem = 5884, Gcount = 1 }, -- Spirit Container
				{ NeedItem = 3280, Ncount = 3, GiveItem = 5904, Gcount = 1 }, -- Magic Sulphur
			}
			if player:getItemCount(trade[npcHandler:getTopic(playerId)].NeedItem) >= trade[npcHandler:getTopic(playerId)].Ncount then
				player:removeItem(trade[npcHandler:getTopic(playerId)].NeedItem, trade[npcHandler:getTopic(playerId)].Ncount)
				player:addItem(trade[npcHandler:getTopic(playerId)].GiveItem, trade[npcHandler:getTopic(playerId)].Gcount)
				return npcHandler:say("Here you are.", npc, creature)
			else
				npcHandler:say("Sorry but you don't have the item.", npc, creature)
			end
		elseif npcHandler:getTopic(playerId) == 5 then
			if not player:removeItem(130, 1) then
				npcHandler:say("You have no cookie that I'd like.", npc, creature)
				npcHandler:setTopic(playerId, 0)
				return true
			end

			player:setStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.CookieDelivery.Djinn, 1)
			if player:getCookiesDelivered() == 10 then
				player:addAchievement("Allow Cookies?")
			end

			npc:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
			npcHandler:say("You see, good deeds like this will ... YOU ... YOU SPAWN OF EVIL! I WILL MAKE SURE THE MASTER LEARNS ABOUT THIS!", npc, creature)
			npcHandler:removeInteraction(npc, creature)
			npcHandler:resetNpc(creature)
		end
	elseif MsgContains(message, "no") then
		if npcHandler:getTopic(playerId) >= 1 and npcHandler:getTopic(playerId) <= 4 then
			npcHandler:say("Ok then.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 5 then
			npcHandler:say("I see.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end
	return true
end

local function onTradeRequest(npc, creature)
	local player = Player(creature)
	local playerId = player:getId()

	if player:getStorageValue(Storage.Quest.U7_4.DjinnWar.EfreetFaction.Mission03) ~= 3 then
		npcHandler:say("I'm sorry, but you don't have Malor's permission to trade with me.", npc, creature)
		return false
	end
	return true
end

keywordHandler:addCustomGreetKeyword({ "djanni'hah" }, greetCallback, { npcHandler = npcHandler })

keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "This world is our playground." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "The djinns do not have kings these days. Gabel renounced his right to the title - a clever move. Malor would love to proclaim himself king, but he does not have the authority to do it. Perhaps one day he will." })
keywordHandler:addKeyword({ "ashta'daramai" }, StdModule.say, { npcHandler = npcHandler, text = "Ashta'daramai is the name of the Marids' fortress. Gabel tore his former fortress down and erected Ashta'daramai in its place. ... Personally I preferred the older fortress, but it does not make much difference. If our side wins the war it will be torn down anyway." })
keywordHandler:addKeyword({ "mal'ouquah" }, StdModule.say, { npcHandler = npcHandler, text = "Mal'ouquah is the name of this place. Malor built it - hence the name. It means 'Malor's rage'." })
keywordHandler:addKeyword({ "fa'hradin" }, StdModule.say, { npcHandler = npcHandler, text = "I feel a strange kind of respect for Fa'hradin even though he is a Marid. He is more level-headed and clear-sighted than most Efreet I know. ... I don't know what made him side with Gabel, but he is the only djinn I miss. ... In fact he was one of the few djinn I ever liked." })
keywordHandler:addKeyword({ "ankrahmun" }, StdModule.say, { npcHandler = npcHandler, text = "Ankrahmun is the oldest human settlement in Tibia. I remember how surprised we were when we found that humans were capable of building such fine cities." })
keywordHandler:addKeyword({ "kha'labal" }, StdModule.say, { npcHandler = npcHandler, text = "The Kha'labal we know today was created at the height of the djinn war. Not exactly a glorious chapter in the war's history." })
keywordHandler:addKeyword({ "ascension" }, StdModule.say, { npcHandler = npcHandler, text = "Hm. I don't know about this, human." })
keywordHandler:addKeyword({ "kha'zeel" }, StdModule.say, { npcHandler = npcHandler, text = "Djinns have lived in these mountains, called Kha'zeel, for as long as anyone can remember. ... Humans rarely come up here, and few djinn care to travel down to the Kha'labal. It is probably better this way. For both our races." })
keywordHandler:addKeyword({ "darashia" }, StdModule.say, { npcHandler = npcHandler, text = "The wealth of Darashia is proverbial. I have my own little plans with it." })
keywordHandler:addKeyword({ "melchior" }, StdModule.say, { npcHandler = npcHandler, text = "Melchior tried to double-cross us. That worm! He paid his treachery dearly. No human messes with the Efreet and lives to tell the tale." })
keywordHandler:addKeyword({ "baa'leal" }, StdModule.say, { npcHandler = npcHandler, text = "Baa'leal is our side's commander-in-chief. No wonder I can't be asked to join the service." })
keywordHandler:addKeyword({ "pharaoh" }, StdModule.say, { npcHandler = npcHandler, text = "They say that pharaoh established his own religion. Amazing. We djinn are notoriously given to pride, but no djinn would ever have the arrogance to proclaim himself god." })
keywordHandler:addKeyword({ "efreet" }, StdModule.say, { npcHandler = npcHandler, text = "Curious how we have changed physically in the course of time, isn't it? But the fact that we have different skin colours cannot hide the fact that Efreet and Marid are still related by blood." })
keywordHandler:addKeyword({ "humans" }, StdModule.say, { npcHandler = npcHandler, text = "Humans are selfish, greedy and unnecessarily cruel. In other words, they resemble us in many ways. ... Unlike other Efreet I would not kill a human just for the fun of it. However, I would not hesitate to do it if it seemed profitable. No offence." })
keywordHandler:addKeyword({ "scarab" }, StdModule.say, { npcHandler = npcHandler, text = "Some people find scarabs fascinating. Exactly why is simply beyond me." })
keywordHandler:addKeyword({ "alesar" }, StdModule.say, { npcHandler = npcHandler, text = "Ah yes - Alesar... Everybody here is really excited because of him. These fools seem to believe that winning the war will be a trifle now Malor is back and we have Alesar on our side. I am far more cautious. ... I don't think Alesar is trying to double-cross us, but I have a bad feeling about him. I still don't understand what made him switch sides." })
keywordHandler:addKeyword({ "palace" }, StdModule.say, { npcHandler = npcHandler, text = "They say that palace has turned into a home for the living dead under the new pharaoh's rule." })
keywordHandler:addKeyword({ "gabel" }, StdModule.say, { npcHandler = npcHandler, text = "Even though Malor would never admit it, Gabel is a strong and charismatic leader. We cannot win this war as long as he is alive." })
keywordHandler:addKeyword({ "marid" }, StdModule.say, { npcHandler = npcHandler, text = "I do not hate the Marid - not more than anybody else, anyhow. I joined the Efreet because it seemed the logical thing to do." })
keywordHandler:addKeyword({ "malor" }, StdModule.say, { npcHandler = npcHandler, text = "Malor is our leader. He is driven by greed and by ambition. He is clever, though. Personally, I sided with him because Daraman's creed did not appeal to me. ... 'Everybody for himself' is my motto. As an Efreet, I can do what I want. No artificial moral restraints. I take what I want." })
keywordHandler:addKeyword({ "lamp" }, StdModule.say, { npcHandler = npcHandler, text = "Yes - djinns sleep in lamps. How long did it take you to work that one out?" })
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell, human.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Farewell, human.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "At your service, just browse through my wares.")

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_ON_TRADE_REQUEST, onTradeRequest)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "ankh", clientId = 3077, sell = 100 },
	{ itemName = "dragon necklace", clientId = 3085, buy = 1000, sell = 100, count = 200 },
	{ itemName = "dwarven ring", clientId = 3097, buy = 2000, sell = 100 },
	{ itemName = "energy ring", clientId = 3051, buy = 2000, sell = 100 },
	{ itemName = "glacial rod", clientId = 16118, sell = 6500 },
	{ itemName = "hailstorm rod", clientId = 3067, sell = 3000 },
	{ itemName = "life ring", clientId = 3052, buy = 900, sell = 50 },
	{ itemName = "might ring", clientId = 3048, buy = 25000, sell = 250, count = 20 },
	{ itemName = "moonlight rod", clientId = 3070, sell = 200 },
	{ itemName = "muck rod", clientId = 16117, sell = 6000 },
	{ itemName = "mysterious fetish", clientId = 3078, sell = 50 },
	{ itemName = "necrotic rod", clientId = 3069, sell = 1000 },
	{ itemName = "northwind rod", clientId = 8083, sell = 1500 },
	{ itemName = "protection amulet", clientId = 3084, buy = 700, sell = 100, count = 250 },
	{ itemName = "ring of healing", clientId = 3098, buy = 2000, sell = 100 },
	{ itemName = "silver amulet", clientId = 3054, buy = 100, sell = 50, count = 200 },
	{ itemName = "snakebite rod", clientId = 3066, sell = 100 },
	{ itemName = "springsprout rod", clientId = 8084, sell = 3600 },
	{ itemName = "strange talisman", clientId = 3045, buy = 100, sell = 30, count = 200 },
	{ itemName = "terra rod", clientId = 3065, sell = 2000 },
	{ itemName = "time ring", clientId = 3053, buy = 2000, sell = 100 },
	{ itemName = "underworld rod", clientId = 8082, sell = 4400 },
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
