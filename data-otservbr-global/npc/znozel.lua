local internalNpcName = "Znozel"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 297,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Don't forget to deposit your money here in the Global Bank before you head out for adventure.", yell = false },
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

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Me Znozel the great goblin banker!" })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Me great good banker! Me smart and honey .. no wait I mean horrible .. no, no honest I am! Yes, yes! Money give, give to honest goblin! Uhhh so shiny coins!" })
keywordHandler:addKeyword({ "arena and zoo quarter" }, StdModule.say, { npcHandler = npcHandler, text = "Big humans there are mean. Big beasts even worse!" })
keywordHandler:addKeyword({ "foreigner quarter" }, StdModule.say, { npcHandler = npcHandler, text = "Others there only bully little goblins around." })
keywordHandler:addKeyword({ "alchemist quarter" }, StdModule.say, { npcHandler = npcHandler, text = "It gone BOOOM! Yes, yes! No good going there." })
keywordHandler:addKeyword({ "magician quarter" }, StdModule.say, { npcHandler = npcHandler, text = "Spooky guys are not good for business." })
keywordHandler:addKeyword({ "factory quarter" }, StdModule.say, { npcHandler = npcHandler, text = "Many humans there. Seldom come here to trade." })
keywordHandler:addKeyword({ "sunken quarter" }, StdModule.say, { npcHandler = npcHandler, text = "Me did not break it! Honest! Was broke as I came!" })
keywordHandler:addKeyword({ "trade quarter" }, StdModule.say, { npcHandler = npcHandler, text = "This West human not too bad is. He great trader, strong chieftain." })
keywordHandler:addKeyword({ "yalahari" }, StdModule.say, { npcHandler = npcHandler, text = "Taxes, taxes! Always government is harassing harmless little goblins!" })
keywordHandler:addKeyword({ "yalahar" }, StdModule.say, { npcHandler = npcHandler, text = "Me came here to plunder. Old banker hired me. When dragon eats banker for must waiting in line I taking over everything!" })
keywordHandler:addKeyword({ "goblin" }, StdModule.say, { npcHandler = npcHandler, text = "Goblins not bankers usually. But great love everything shiny. Yes. Yes." })
keywordHandler:addKeyword({ "dragon" }, StdModule.say, { npcHandler = npcHandler, text = "Dragons are always served first!" })
keywordHandler:addKeyword({ "cookie" }, StdModule.say, { npcHandler = npcHandler, text = "Me only take cookie if it's golden. Ehehehe." })
npcHandler:setMessage(MESSAGE_GREET, "Yes? What may I do for you, |PLAYERNAME|? Bank business, perhaps?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Have a nice day.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Have a nice day.")
npcHandler:setCallback(CALLBACK_GREET, NpcBankGreetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
