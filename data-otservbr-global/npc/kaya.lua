local internalNpcName = "Kaya"
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
	lookHead = 79,
	lookBody = 53,
	lookLegs = 53,
	lookFeet = 0,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Don't forget to deposit your money here in the Tibian Bank before you head out for adventure.", yell = false },
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

	-- Parse bank
	npc:parseBank(message, npc, creature, npcHandler)
	-- Parse guild bank
	npc:parseGuildBank(message, npc, creature, playerId, npcHandler)
	-- Normal messages
	npc:parseBankMessages(message, npc, creature, npcHandler)
	return true
end

keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "It is exactly time." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Kaya." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I work for the Tibian bank." })
keywordHandler:addKeyword({ "explorer society" }, StdModule.say, { npcHandler = npcHandler, text = "The Explorer Society is an elite society of adventurers that explore and research all aspects of our world. We are interested in the many different creatures of Tibia, as well as the history of curious structures and items." })
keywordHandler:addKeyword({ "chieftain" }, StdModule.say, { npcHandler = npcHandler, text = "The chieftain ist the big boss of a tribe, as the {ogres} call it." })
keywordHandler:addKeyword({ "krailos" }, StdModule.say, { npcHandler = npcHandler, text = "Krailos is this peninsula that forms the northern part of Oramond. As you might have noticed it s mainly populated by {ogres}." })
keywordHandler:addKeyword({ "goblins" }, StdModule.say, { npcHandler = npcHandler, text = "Many goblins are kept as {slave}s or are even eaten by the {ogres}. Unlike the dworcs or coryms who come here as stowaways at times, the goblins seem to live in {Krailos} for quite a while yet." })
keywordHandler:addKeyword({ "grubokk" }, StdModule.say, { npcHandler = npcHandler, text = "I haven't seen him very often - fortunately. He seems to be cruel, blunt and disgusting even by ogre standards. ... Most of the time he's overseeing the {goblins} who have to work in the faraway mines, in the mountains that seperate {Krailos} from southern Oramond." })
keywordHandler:addKeyword({ "vuzrog" }, StdModule.say, { npcHandler = npcHandler, text = "Vuzrog is the tribe's {chieftain}. In ogre tribes the chief is always the strongest male or - in rarer cases - female tribe member. Vuzrog is impulsive and irascible, if he's hungry. And that he is most of the time." })
keywordHandler:addKeyword({ "ghorza" }, StdModule.say, { npcHandler = npcHandler, text = "Ghorza is the tribe's {shaman}. She's an elder ogress which seems to have much influence here, even on the {chieftain} {Vuzrog}. She is able to exert shamanistic magic of considerable power." })
keywordHandler:addKeyword({ "shaman" }, StdModule.say, { npcHandler = npcHandler, text = "An ogre shaman is the link between the tribe and the spirits." })
keywordHandler:addKeyword({ "mugruu" }, StdModule.say, { npcHandler = npcHandler, text = "He's one of the {ogres} here in the village. Some weeks ago he suddenly was very interested in {Larek}'s doings and now he is selling and buying things, too." })
keywordHandler:addKeyword({ "nibble" }, StdModule.say, { npcHandler = npcHandler, text = "Oh, the poor Nibble. He's kept as a {slave} by {chieftain} {Vuzrog}. He has to cook his meals, to clean his hut and so on. For a goblin he's quite cute. I really feel sorry for him." })
keywordHandler:addKeyword({ "larek" }, StdModule.say, { npcHandler = npcHandler, text = "Larek is a member of the {Explorer Society}. He came here from Port Hope to explore the still little-known peninsula {Krailos} and I accompanied him as research assistant. I'm still a novice but proficient in Tibia's classical languages and myths. ... That's the reason Larek asked me to assit him on this journey." })
keywordHandler:addKeyword({ "ogres" }, StdModule.say, { npcHandler = npcHandler, text = "The ogres are a rough, yet interesting people. {Larek} has written an essay about their culture - if you want to use this word in relation to ogres. If you want to know more, feel free to ask Larek." })
keywordHandler:addKeyword({ "slave" }, StdModule.say, { npcHandler = npcHandler, text = "The ogres keep smaller races like {goblins}, dworcs or coryms as slaves. They let them do the cooking and cleaning, they send them to the mines in the south to dig up onyx and opals. Or they eat them, if they get hungry. ... Awful, I know. I guess, we sould return to Port Hope as soon as posible." })
npcHandler:setMessage(MESSAGE_GREET, "Yes? What may I do for you, |PLAYERNAME|? Bank business, perhaps?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Have a nice day.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Have a nice day.")
npcHandler:setCallback(CALLBACK_GREET, NpcBankGreetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
