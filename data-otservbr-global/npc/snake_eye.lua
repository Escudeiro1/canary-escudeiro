local internalNpcName = "Snake Eye"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 73,
	lookHead = 20,
	lookBody = 30,
	lookLegs = 40,
	lookFeet = 50,
	lookAddons = 1,
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

	if MsgContains(message, "package for rashid") then
		if player:getStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission02) >= 1 and player:getStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission02) < 3 then
			npcHandler:say("So you're the delivery boy? Go ahead, but I warn you, it's quite heavy. You can take it from the box over there.", npc, creature)
			player:setStorageValue(Storage.Quest.U8_1.TheTravellingTrader.Mission02, 3)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "documents") then
		if player:getStorageValue(Storage.Quest.U8_2.TheThievesGuildQuest.Mission04) == 1 then
			player:setStorageValue(Storage.Quest.U8_2.TheThievesGuildQuest.Mission04, 2)
			npcHandler:say("Funny thing that everyone thinks we have forgers for fake documents here. But no, we don't. The best forger is old Ahmet in Ankrahmun.", npc, creature)
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "There's already too much order in Tibia. We don't need kings or whatever." })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "I've never been there. Don't know anything about it." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "In the beginning, it was a nice encampment. Now it's an overcrowded, polluted city. I hate it!" })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "We don't need one." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "Go and get a watch." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I'm Snake Eye." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Well, I'm the boss of this tavern." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "brown bread", clientId = 3602, buy = 4 },
	{ itemName = "fish", clientId = 3578, buy = 5 },
	{ itemName = "meat", clientId = 3577, buy = 6 },
	{ itemName = "mug of beer", clientId = 2880, buy = 5, count = 3 },
	{ itemName = "mug of wine", clientId = 2880, buy = 6, count = 2 },
	{ itemName = "vial of beer", clientId = 2874, buy = 5, count = 1, subType = 3 },
	{ itemName = "vial of wine", clientId = 2874, buy = 6, count = 1, subType = 2 },
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
