local internalNpcName = "Ztiss"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 340,
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

local TheNewFrontier = Storage.Quest.U8_54.TheNewFrontier
local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "guezt") then
		if player:getStorageValue(TheNewFrontier.Questline) == 23 then
			npcHandler:say({
				"Ziz iz not for you to azk. I work for zomeone of immenze power. He haz an {offer} for you.",
			}, npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif MsgContains(message, "offer") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("You are ztill a captive and your life is forfeit. Zere might be a way for you to ezcape if you agree to {work} for my mazter.", npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
	elseif MsgContains(message, "work") then
		if npcHandler:getTopic(playerId) == 2 then
			npcHandler:say({
				"Zere iz a great tournament of ztrengz each decade. It determinez ze granted privilegez for zertain individualz of power for ze comming decade. ...",
				"My mazter wantz to zurprize hiz opponentz by an unexpected move. He will uze warriorz from ze outzide, zomeone zat no one can azzezz. ...",
				"One of ziz warriorz could be you. Or you could ztay here and rot in ze dungeon. Are you interezted in ziz deal?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 3)
		end
	elseif MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 3 then
			npcHandler:say({
				"You are zmart for a zoftzkin, but before you begin to feel too zmart, you should know zat we will zeal our deal wiz you drinking a ztrong poizon zat will inevitably kill you if you want to trick me and not attend ze tournament. ...",
				"Zo are you ready to drink ziz poizon here?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 4)
		elseif npcHandler:getTopic(playerId) == 4 then
			npcHandler:say({
				"Excellent! Now you may leave ziz area zrough ze teleporter to ze norz. It will bring you to a hidden boat. Ziz boat will take you to ze tournament izle. ...",
				"Zere you'll learn anyzing you need to know about ze great tournament.",
			}, npc, creature)
			player:setStorageValue(TheNewFrontier.Questline, 24)
			player:setStorageValue(TheNewFrontier.Mission08, 2) --Questlog, The New Frontier Quest "Mission 08: An Offer You Can't Refuse"
			player:setStorageValue(TheNewFrontier.Mission09[1], 1) --Questlog, The New Frontier Quest "Mission 08: An Offer You Can't Refuse"
			npcHandler:setTopic(playerId, 0)
		end
	end
	return true
end
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I'm Ztiss!" })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Ziz iz not for you to azk. I work for zomeone of immenze power. He haz an offer for you." })
keywordHandler:addKeyword({ "great wall" }, StdModule.say, { npcHandler = npcHandler, text = "King Chong III ordered ze begin of ze wall'z conztruction in ze zirteen'z year of hiz reign. Ze wall waz built az lazt line of defenze againzt barbarianz az well az a boundary between ze lower and upper clazzez." })
keywordHandler:addKeyword({ "minotaurz" }, StdModule.say, { npcHandler = npcHandler, text = "Zey are zomewhat enigmatic. Zey zeem to be ze leaderz of ze orcz. If we got rid of zem, we would probably eliminate ze orc zreat az well." })
keywordHandler:addKeyword({ "emperor" }, StdModule.say, { npcHandler = npcHandler, text = "Ze mighty dragon emperor iz immortal. Hiz power iz unchallenged and hiz wizdom iz unparalleled. He rezidez in ze dragon palace behind ze great wall." })
keywordHandler:addKeyword({ "dragon" }, StdModule.say, { npcHandler = npcHandler, text = "Ze dragonz are ze rulerz of ziz land. Zeir wize decizionz lead our people and zeir power protectz uz." })
keywordHandler:addKeyword({ "humanz" }, StdModule.say, { npcHandler = npcHandler, text = "Humanz are of no importance. Zey are wizout power and lack ze zkillz and manpower to poze a zreat to uz." })
keywordHandler:addKeyword({ "palace" }, StdModule.say, { npcHandler = npcHandler, text = "Ze palace iz a mozt magnificant place zat only ze mozt honourable officialz and ze dragon kingz may enter." })
keywordHandler:addKeyword({ "kingz" }, StdModule.say, { npcHandler = npcHandler, text = "Ze dragon kingz are ze mozt truzted followerz of ze emperor. Zey replaced ze higher ranking lizardz in ze hierarchy when ze rule of ze dragon emperor waz eztablished." })
keywordHandler:addKeyword({ "orcz" }, StdModule.say, { npcHandler = npcHandler, text = "Zey are ze worzt of ze barbarianz, vile and brutal zey aim only at deztruction." })
npcHandler:setMessage(MESSAGE_GREET, "Be greeted my .. {guezt}.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
