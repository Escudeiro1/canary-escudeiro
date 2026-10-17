local internalNpcName = "Buddel"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 143,
	lookHead = 19,
	lookBody = 57,
	lookLegs = 22,
	lookFeet = 20,
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

-- Travel
local function addTravelKeyword(keyword, text, destination, randomDestination, randomNumber, condition, ringCheck, ringRemove, helheimAccess)
	if condition then
		keywordHandler:addKeyword({ keyword }, StdModule.say, { npcHandler = npcHandler, text = "No, no, no, you even are no barb....barba...er.. one of us!!!! Talk to the Jarl first!" }, condition)
	end
	if helheimAccess then
		keywordHandler:addKeyword({ keyword }, StdModule.say, { npcHandler = npcHandler, text = text }, helheimAccess)
	end
	if ringCheck then
		local ring = keywordHandler:addKeyword({ keyword }, StdModule.say, { npcHandler = npcHandler, text = "Ohh, you got a nice ring there! Ya don't have to pay if you gimme the ring and I promise you I will bring you to the correct spot!*HICKS* Alright?" }, ringCheck)
		ring:addChildKeyword({ "yes" }, StdModule.travel, { npcHandler = npcHandler, premium = false, cost = 0, destination = destination }, ringRemove)
		local normalTravel = ring:addChildKeyword({ "no" }, StdModule.say, { npcHandler = npcHandler, text = "Give me 50 gold and I bring you to " .. keyword .. ". 'kay?" })
		normalTravel:addChildKeyword({ "no" }, StdModule.say, { npcHandler = npcHandler, text = "You shouldn't miss the experience.", reset = true })
		if randomNumber then
			normalTravel:addChildKeyword({ "yes" }, StdModule.travel, { npcHandler = npcHandler, premium = false, cost = 50, discount = "postman", destination = destination }, randomNumber)
		end
		normalTravel:addChildKeyword({ "yes" }, StdModule.travel, { npcHandler = npcHandler, premium = false, cost = 50, discount = "postman", destination = randomDestination }, randomNumber)
	end
	local travelKeyword = keywordHandler:addKeyword({ keyword }, StdModule.say, { npcHandler = npcHandler, text = text, cost = 50, discount = "postman" })
	travelKeyword:addChildKeyword({ "no" }, StdModule.say, { npcHandler = npcHandler, text = "You shouldn't miss the experience.", reset = true })
	if randomNumber then
		travelKeyword:addChildKeyword({ "yes" }, StdModule.travel, { npcHandler = npcHandler, premium = false, cost = 50, discount = "postman", destination = destination }, randomNumber)
	end
	travelKeyword:addChildKeyword({ "yes" }, StdModule.travel, { npcHandler = npcHandler, premium = false, cost = 50, discount = "postman", destination = randomDestination }, randomNumber)
end

local randomDestination = { Position(32225, 31381, 7), Position(32462, 31174, 7), Position(32333, 31227, 7), Position(32021, 31294, 7) }
addTravelKeyword("okolnir", "It's nice there. Except of the ice dragons which are not very companionable.", Position(32225, 31381, 7), function()
	return randomDestination[math.random(#randomDestination)]
end, function()
	return math.random(5) > 1
end, function(player)
	return player:getStorageValue(Storage.Quest.U8_0.BarbarianTest.Questline) ~= 8
end, function(player)
	return player:getItemCount(3097) > 0
end, function(player)
	return player:removeItem(3097, 1)
end)
addTravelKeyword("helheim", "T'at is a small island to the east.", Position(32462, 31174, 7), function()
	return randomDestination[math.random(#randomDestination)]
end, function()
	return math.random(5) > 1
end, function(player)
	return player:getStorageValue(Storage.Quest.U8_0.BarbarianTest.Questline) ~= 8
end, function(player)
	return player:getItemCount(3097) > 0
end, function(player)
	return player:removeItem(3097, 1)
end, function(player)
	return player:getStorageValue(Storage.Quest.U8_0.TheIceIslands.Questline) < 30
end)
addTravelKeyword("tyrsung", "*HICKS* Big, big island east of here. Venorian hunters settled there ..... I could bring you north of their camp.", Position(32333, 31227, 7), function()
	return randomDestination[math.random(#randomDestination)]
end, function()
	return math.random(5) > 1
end, function(player)
	return player:getStorageValue(Storage.Quest.U8_0.BarbarianTest.Questline) ~= 8
end, function(player)
	return player:getItemCount(3097) > 0
end, function(player)
	return player:removeItem(3097, 1)
end)
addTravelKeyword("camp", "Both of you look like you could defend yourself! If you want to go there, ask me for a passage.", Position(32021, 31294, 7), function()
	return randomDestination[math.random(#randomDestination)]
end, function()
	return math.random(5) > 1
end, function(player)
	return player:getStorageValue(Storage.Quest.U8_0.BarbarianTest.Questline) ~= 8
end, function(player)
	return player:getItemCount(3097) > 0
end, function(player)
	return player:removeItem(3097, 1)
end)
-- Kick
keywordHandler:addKeyword({ "news" }, StdModule.say, { npcHandler = npcHandler, text = "Breezelda brought rum from Port *HICKS* er Hope." })
keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "Teeheehee, I don't know but you two are funny!" })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "Hey, who of you knows a story about that??? You or you? ... You are twins, aren't you?" })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "Hey, who of you knows a story about that??? You or you? ... You are twins, aren't you?" })
keywordHandler:addAliasKeyword({ "thais" })
keywordHandler:addAliasKeyword({ "edron" })
keywordHandler:addAliasKeyword({ "venore" })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "I'M THE KING OF THIS SHIP AND ALL RUM FLASKS IN IT!!" })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "There was a time I was called Bejorn. But everyone calls me Buddel. ..... and you are?" })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am a fisher aaaaaaand maybe I can show you the other islands. Depends on how good I know you two. Just ask me for a passage!" })
keywordHandler:addKeyword({ "kick" }, StdModule.kick, { npcHandler = npcHandler, text = "Get out o' here!*HICKS*", destination = { Position(32255, 31193, 7), Position(32256, 31193, 7), Position(32257, 31193, 7) } })

-- above "passage": its alias "go" is inside "dragon"
keywordHandler:addKeyword({ "dragon" }, StdModule.say, { npcHandler = npcHandler, text = "I saw one at the harbour! YES! It crawled up the bow of that battleship! *HICKS* Not very agile these beasts, it nearly didn't move at all." })
keywordHandler:addKeyword({ "passage" }, StdModule.say, { npcHandler = npcHandler, text = "Where are we at the moment? Is this Svargrond? Ahh yes!*HICKS* Where do you want to go?" })
keywordHandler:addAliasKeyword({ "trip" })
keywordHandler:addAliasKeyword({ "go" })
keywordHandler:addAliasKeyword({ "sail" })
keywordHandler:addKeyword({ "years of serpents" }, StdModule.say, { npcHandler = npcHandler, text = "The serpents were bad. Bad, bad, bad!! BAD SERPENTS! BAD!! I don't want the serpents back. No!" })
keywordHandler:addKeyword({ "how are you" }, StdModule.say, { npcHandler = npcHandler, text = "Good, good, good! *HICKS*" })
keywordHandler:addKeyword({ "port hope" }, StdModule.say, { npcHandler = npcHandler, text = "I have to go there sometime to buy more rum!" })
keywordHandler:addKeyword({ "breezelda" }, StdModule.say, { npcHandler = npcHandler, text = "She is a suuuuu*HICKS*uuuch a good captain! Sold me all her rum and not even ve'y expensive. *HICKS*" })
keywordHandler:addKeyword({ "svargrond" }, StdModule.say, { npcHandler = npcHandler, text = "You know a town nicer than this? NICER DICER! Apropos, don't play dice when you are drunk ... You wanna play a little bit? We three?? No? Ahhhhh, you are drunk! I see! *HICKS*" })
keywordHandler:addKeyword({ "shamans" }, StdModule.say, { npcHandler = npcHandler, text = "CAN'T YOU SEE I'M TALKING TO THAT GENTLEMAN BESIDE YOU?!?!? Okay, what did you ask?" })
keywordHandler:addKeyword({ "raiders" }, StdModule.say, { npcHandler = npcHandler, text = "They are fools. Other than us three, we are drunk er smart. *HICKS*" })
keywordHandler:addKeyword({ "nibelor" }, StdModule.say, { npcHandler = npcHandler, text = "The shamans respect me. They like fish! I like fish too. *HICKS* Stupid question! Otherwise I wouldn't be a fisherman!" })
keywordHandler:addKeyword({ "druids" }, StdModule.say, { npcHandler = npcHandler, text = "Druids are strange. Are you two druids? Er, not that you look strange!! No, no, no! *HICKS*" })
keywordHandler:addKeyword({ "dwarf" }, StdModule.say, { npcHandler = npcHandler, text = "They are the devil's dogsbodies! I heard they have rings which make you stone-cold sober when you wear them!" })
keywordHandler:addKeyword({ "husky" }, StdModule.say, { npcHandler = npcHandler, text = "I like them! Som'times when I fall asleep on my way home they warm me! Cute isn't it? *HICKS*" })
keywordHandler:addKeyword({ "chyll" }, StdModule.say, { npcHandler = npcHandler, text = "It is better to freeze a li'le than to paddle 'til your hands bri'le. That's what my gran' gran' gran' gran' pa' used to say all the time!" })
keywordHandler:addKeyword({ "jarl" }, StdModule.say, { npcHandler = npcHandler, text = "Sven? She's old and called young, er he. Sure he is! Got me? No? *HICKS* Doesn't matter." })
keywordHandler:addKeyword({ "mead" }, StdModule.say, { npcHandler = npcHandler, text = "Mead is good. Good, good, good ........ but that rum I bought from Breezelda is a nice va'iation! *HICKS*" })
keywordHandler:addKeyword({ "mine" }, StdModule.say, { npcHandler = npcHandler, text = "What is yours? Not that flask here that's mine!" })

npcHandler:setMessage(MESSAGE_GREET, "Hey big guys. You? {Here}? *HICKS*")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "compass", clientId = 10302, sell = 45 },
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
