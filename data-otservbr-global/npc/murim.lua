local internalNpcName = "Murim"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 160,
	lookHead = 116,
	lookBody = 24,
	lookLegs = 21,
	lookFeet = 39,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Don't forget to deposit your money here in the Global Bank before you head out for adventure.", yell = false },
}
npcConfig.shop = {
	{ itemName = "label", clientId = 3507, buy = 1 },
	{ itemName = "letter", clientId = 3505, buy = 8 },
	{ itemName = "parcel", clientId = 3503, buy = 15 },
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
npcHandler.isBank = true

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

keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "A weapon of pure power - or a weapon of pure imagination. Who knows?" })
keywordHandler:addKeyword({ "mining guild" }, StdModule.say, { npcHandler = npcHandler, text = "It took my three weeks with almost no sleep to do all the paperwork for my business permission, but it was worth it! ... The guild is sticking to the old traditions and that is a good thing for sure." })
keywordHandler:addKeyword({ "kazordoon" }, StdModule.say, { npcHandler = npcHandler, text = "I hope this new project lets Kazordoon prosper. Half of my family is involved in Farmine one way or another. If things turn out well, we will earn a hefty sum of money." })
keywordHandler:addKeyword({ "farmine" }, StdModule.say, { npcHandler = npcHandler, text = "A promising project for Kazordoon." })
keywordHandler:addKeyword({ "mission" }, StdModule.say, { npcHandler = npcHandler, text = "My only mission is to keep this little office running." })
keywordHandler:addKeyword({ "ongulf" }, StdModule.say, { npcHandler = npcHandler, text = "Now he is one-of-a-kind and a born leader." })
keywordHandler:addKeyword({ "dwarf" }, StdModule.say, { npcHandler = npcHandler, text = "Ah, my proud brothers and sisters. Only dwarfs could succeed with such an immense tunnelling project." })
keywordHandler:addKeyword({ "esrik" }, StdModule.say, { npcHandler = npcHandler, text = "If he only stopped bugging Ongulf about resources. We've already spent too much money on things that yield no immediate profit. ... But in the end, only profit will convince the imperial mining guild to continue their support." })
keywordHandler:addKeyword({ "elves" }, StdModule.say, { npcHandler = npcHandler, text = "Luckily we're far away from them." })
npcHandler:setMessage(MESSAGE_GREET, "Yes? What may I do for you, |PLAYERNAME|? Bank business, perhaps?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Have a nice day.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Have a nice day.")
npcHandler:setCallback(CALLBACK_GREET, NpcBankGreetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
