local internalNpcName = "Wyda"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 54,
	lookHead = 0,
	lookBody = 119,
	lookLegs = 119,
	lookFeet = 126,
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

local condition = Condition(CONDITION_FIRE)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(60, 2000, -10)

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "cookie") then
		if player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.Questline) == 31 and player:getStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.CookieDelivery.Wyda) ~= 1 then
			npcHandler:say("You brought me a cookie?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif MsgContains(message, "mission") or MsgContains(message, "quest") then
		npcHandler:say({
			"A quest? Well, if you're so keen on doing me a favour... Why don't you try to find a {blood herb}?",
			"To be honest, I'm drowning in blood herbs by now.",
		}, npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "bloodherb") or MsgContains(message, "blood herb") then
		if player:getStorageValue(Storage.BloodHerbQuest) == 1 then
			npcHandler:say("Arrr... here we go again.... do you have a #$*§# blood herb for me?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		else
			npcHandler:say({
				"The blood herb is very rare. This plant would be very useful for me, but I don't know any accessible places to find it.",
				"To be honest, I'm drowning in blood herbs by now. But if it helps you, well yes.. I guess I could use another blood herb...",
			}, npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			if not player:removeItem(130, 1) then
				npcHandler:say("You have no cookie that I'd like.", npc, creature)
				npcHandler:setTopic(playerId, 0)
				return true
			end

			player:setStorageValue(Storage.Quest.U8_1.WhatAFoolishQuest.CookieDelivery.Wyda, 1)
			player:addCondition(condition)
			if player:getCookiesDelivered() == 10 then
				player:addAchievement("Allow Cookies?")
			end

			npc:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
			npcHandler:say("Well, it's a welcome change from all that gingerbread ... AHHH HOW DARE YOU??? FEEL MY WRATH!", npc, creature)
			npcHandler:removeInteraction(npc, creature)
			npcHandler:resetNpc(creature)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:removeItem(3734, 1) then
				player:setStorageValue(Storage.BloodHerbQuest, 2)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
				local TornTeddyRand = math.random(1, 100)
				if TornTeddyRand <= 70 then
					player:addItem(3454, 1) -- witchesbroom
					npcHandler:say("Thank you -SOOO- much! No, I really mean it! Really! Here, let me give you a reward...", npc, creature)
					npcHandler:setTopic(playerId, 0)
				else
					player:addItem(12617, 1) -- torn teddy
					npcHandler:say("Thank you -SOOO- much! No, I really mean it! Really! Ah, you know what, you can have this old thing...", npc, creature)
					npcHandler:setTopic(playerId, 0)
				end
			else
				npcHandler:say("No, you don't have any...", npc, creature)
				npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "no") then
		if npcHandler:getTopic(playerId) == 1 or npcHandler:getTopic(playerId) == 2 then
			npcHandler:say("I see.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end
	return true
end

keywordHandler:addKeyword({ "gods" }, StdModule.say, { npcHandler = npcHandler, text = "I believe that nature itself is God. Goddess, yes, you may call me that, thank you." })
keywordHandler:addKeyword({ "monsters" }, StdModule.say, { npcHandler = npcHandler, text = "/ creatures Many creatures live in, around, and beneath the swamp. Be careful!" })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "Haha, that's a stupid name. Who's that? Look, behind you!! WAHAHAHAHAHAHA." })
keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "Tibia is the name of our continent. You're a smart one, aren't you?" })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "Carlin is a beautiful town, but far from here. Do you live there? I've heard a band of male bards plays there sometimes. Maybe I should pay it a visit." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "I've heard stories about that city. It's nowhere near here, that's all I can tell you about it. Not. Interested." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "There are too many royals on this continent if you ask me... I've heard of a new festival called 'Kingsday'. Why don't they make a 'Witchday'?" })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "I think it is the fourth year after Queen Eloise's crowning, but I cannot tell you date or time. It's about time SOMETHING HAPPENED HERE!" })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Wyda, and what's yours? You should know me after all these years!" })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "or profession I am a witch. Didn't you notice? I think witches these days are underpaid. Who needs a witch anyway?" })
npcHandler:setMessage(MESSAGE_GREET, "What? A mundane talking to me? Amusing.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
