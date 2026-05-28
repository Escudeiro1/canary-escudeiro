local internalNpcName = "Captain Waverider"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 96,
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
	if MsgContains(message, "peg leg") then
		if player:getStorageValue(Storage.Quest.U7_8.TheShatteredIsles.AccessToMeriana) == 1 then
			npcHandler:say("Ohhhh. So... <lowers his voice> you know who sent you so I sail you to you know where. <wink> <wink> It will cost 50 gold to cover my expenses. Is it that what you wish?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		else
			npcHandler:say("Sorry, my old ears can't hear you.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "passage") then
		npcHandler:say("<sigh> I knew someone else would claim all the treasure someday. But at least it will be you and not some greedy and selfish person. For a small fee of 200 gold pieces I will sail you to your rendezvous with fate. Do we have a deal?", npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif MsgContains(message, "no") then
		npcHandler:say("I have to admit this leaves me a bit puzzled.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			if player:removeMoneyBank(50) then
				npcHandler:say("And there we go!", npc, creature)
				player:teleportTo(Position(32346, 32625, 7))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("You don't have enough money.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:removeMoneyBank(200) then
				npcHandler:say("And there we go!", npc, creature)
				player:teleportTo(Position(32131, 32913, 7))
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("You don't have enough money.", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
	return true
end

keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "Rumour has it that old Captain Blackbeard found it in a dead sea serpent once and hid it on Treasure Island. Oh my, why can't I keep my mouth shut about Treasure Island." })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "As legend has it, he has hidden some of his magical treasures on Treasure Island. Oh my, I should not mention Treasure Island in front of strangers." })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "This city is too far away to care about." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "A rough place with rough people as far as I have heard." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "The king is enormously rich. His wealth is only dwarfed by the treasures of Treasure Island ... Oops, I guess I should not have mentioned that." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Oh I do nothing of importance. I mind my own business, catch a fish now and then, and try to find some riches on Treasure Island ... oops, I guess I should not have mentioned that." })
npcHandler:setMessage(MESSAGE_GREET, "Greetings, daring adventurer. If you need a {passage}, let me know.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Oh well.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
