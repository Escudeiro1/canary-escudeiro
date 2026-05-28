local internalNpcName = "Herbert"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 132,
	lookHead = 97,
	lookBody = 93,
	lookLegs = 36,
	lookFeet = 93,
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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "letter") then
		if player:getStorageValue(Storage.Quest.U8_2.TheThievesGuildQuest.Mission06) == 1 then
			npcHandler:say("You would like Chantalle's letter? only if you are willing to pay a price. {gold} maybe?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif MsgContains(message, "gold") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("Are you willing to pay 1000 gold for this letter?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
	elseif MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 2 then
			if player:removeMoneyBank(1000) then
				player:addItem(7940, 1)
				npcHandler:say("Here you go kind sir.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "Why should you seek mere metal when the pen is mightier than the blade, and so is love? Fool! Be a lover, be a poet if you must, but never raise a blade unless your cause is just." })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "Is he real? Or is he a mere story, a tale told by weary parents by the fireside to put fear into their unruly children's hearts? ... But no! No! He is real, I tell you, he is real, for I can feel the icy clasp of his will of steel even while I am standing here. Who will be there to stop him if he stirs again, I ask of you?" })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "Carlin! Oh Carlin, my love! Noble jewel of the north, it is you that I crave, for only among your people can I stop being a slave! ... One day I will come to you, fair Carlin. Bid this humble traveller welcome, lift this humble star into the sky of greatness!" })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "I mourn you, Thais, for you are no longer the shiny diamond that inspired a sense of purpose and pride in us all. ... Rather than building a temple for the muses your people chose to build an arena, where blood is shed and animals are slaughtered for sport. Oh Thais, how deep have you fallen!" })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "If only his majesty's eyes would rest me on the stage, if only he saw me once! How could he not see the greatness of my art if he saw me act my part?" })
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
