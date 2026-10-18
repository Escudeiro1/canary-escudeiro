local internalNpcName = "Tehlim"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 66,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "They must be rescued!" },
	{ text = "Oh no, no, NO! Whatever shall I do?" },
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

	if MsgContains(message, "mission") then
		if Player(creature):getStorageValue(Storage.Quest.U8_4.TheHiddenCityOfBeregar.RoyalRescue) == 5 then
			npcHandler:say("I warn you, those trolls are WAY more dangerous than the usual kind. Alone, I can't do anything for my brothers. Find a way to the trolls' hideout and rescue my brothers. Are you willing to help me?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			Player(creature):setStorageValue(Storage.Quest.U8_4.TheHiddenCityOfBeregar.RoyalRescue, 6)
			npcHandler:say(" Great! I hope you find my brothers. Good luck!", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	end
	return true
end

keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "The only place I know is Beregar. My home." })
keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "Beregar is our world. We don't want to be drawn in to any of your kind's conflicts." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "The only place I know is Beregar. My home." })
keywordHandler:addAliasKeyword({ "venore" })
keywordHandler:addAliasKeyword({ "ab'dendriel" })
keywordHandler:addAliasKeyword({ "darashia" })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "They call me Tehlim Madtreat. I can make a meal from almost anything." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I'm the cook for the expedition party. The only one who didn't get cought by those.... those MONSTERS." })
keywordHandler:addKeyword({ "kazordoon" }, StdModule.say, { npcHandler = npcHandler, text = "Uhh yes, I heard the stories about the lost tribe. Really interesting. There are rumours that they used these old tunnels around here when they left Beregar." })
keywordHandler:addKeyword({ "yalahar" }, StdModule.say, { npcHandler = npcHandler, text = "Wasn't that destroyed ages ago? Whatever, it makes no difference to me." })
keywordHandler:addKeyword({ "trolls" }, StdModule.say, { npcHandler = npcHandler, text = "Their hideout must be somewhere in the ore wagon tunnels. If you want to help me find Rehon and the others just ask me for a {mission}." })
keywordHandler:addKeyword({ "rehon" }, StdModule.say, { npcHandler = npcHandler, text = "You have to search the area for him. If he's still alive then rescue him... if not... you'll have to be the one to tell his father. I'm sorry." })
keywordHandler:addKeyword({ "dwarf" }, StdModule.say, { npcHandler = npcHandler, text = "I won't tell you the secret of our success. No!" })
keywordHandler:addKeyword({ "meal" }, StdModule.say, { npcHandler = npcHandler, text = "I am famous for having invented the most amazing meal ever known to dwarven kind! I call it 'hangman's relish'. I am not going to tell you the recipe, buuuut it contains lots of brown ale, special mushrooms and ground soapstone. Delicious!" })
keywordHandler:addAliasKeyword({ "food" })
npcHandler:setMessage(MESSAGE_WALKAWAY, "See you my friend.")
npcHandler:setMessage(MESSAGE_FAREWELL, "See you my friend.")
npcHandler:setMessage(MESSAGE_GREET, "Hello. I'm so glad someone has found me. Did you meet THEM?!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
