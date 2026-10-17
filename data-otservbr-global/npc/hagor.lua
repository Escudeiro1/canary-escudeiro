local internalNpcName = "Hagor"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 129,
	lookHead = 57,
	lookBody = 116,
	lookLegs = 63,
	lookFeet = 1156,
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

keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "I heared rumours that there is a sword called so. I don't know if it exists." })
keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "The gods made this world full of fascinating secrets and I will search them till my end." })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "Is this the city to the north? I heard rumours about it." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Thais... It's a big city in Middle-Tibia. Lots of people live there." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "Tibianus is our king. To be honest, I didn't hear much of him till now." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "Time has no meaning to me." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Hagor, the old hunter." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am a traveller. I have been travelling through the lands of Tibia for many years. Recently I have been spending my time exploring the Jakundaf Desert." })
keywordHandler:addKeyword({ "treasure" }, StdModule.say, { npcHandler = npcHandler, text = "Someone told me - I can't remember who it was - that there was a treasure hidden nearby." })
keywordHandler:addKeyword({ "library" }, StdModule.say, { npcHandler = npcHandler, text = "There is a library in here, right. I assume you are talking about this library. It's locked, as far as I know. But somewhere there has to be a key... maybe the librarian knows more?" })
keywordHandler:addKeyword({ "gharonk" }, StdModule.say, { npcHandler = npcHandler, text = "Gharonk is a very old language, only spoken by a few people. It's not a very complex language, but that does not mean that it is easy to understand!" })
keywordHandler:addKeyword({ "secret" }, StdModule.say, { npcHandler = npcHandler, text = "There are many secrets. But I fear, I can't tell you much about them. They are also secret to me..." })
keywordHandler:addKeyword({ "weapon" }, StdModule.say, { npcHandler = npcHandler, text = "Weapons? Do you have some? You better know how to use them!" })
keywordHandler:addKeyword({ "desert" }, StdModule.say, { npcHandler = npcHandler, text = "Yes, it's big, isn't it?" })
keywordHandler:addKeyword({ "morrin" }, StdModule.say, { npcHandler = npcHandler, text = "Ah, I remember that man. We made a deal, guess about what." })
keywordHandler:addKeyword({ "fight" }, StdModule.say, { npcHandler = npcHandler, text = "Fighting is an art. Know it and you will be strong, ignore it and you will die soon!" })
keywordHandler:addKeyword({ "guild" }, StdModule.say, { npcHandler = npcHandler, text = "There are many different guilds in Tibia. They come and go, come and go..." })
keywordHandler:addKeyword({ "door" }, StdModule.say, { npcHandler = npcHandler, text = "Which door are you talking about? If it is locked, maybe you should try to find a key for it!" })
keywordHandler:addKeyword({ "book" }, StdModule.say, { npcHandler = npcHandler, text = "Yes, I really can recommend reading books. It might help you find what you are looking for!" })
keywordHandler:addKeyword({ "help" }, StdModule.say, { npcHandler = npcHandler, text = "I'd really like to help you. Could you specify your request?" })
keywordHandler:addKeyword({ "exit" }, StdModule.say, { npcHandler = npcHandler, text = "Yes, there is an exit for these dungeons. Just find the teleporter." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
