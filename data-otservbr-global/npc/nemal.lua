local internalNpcName = "Nemal"
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
	lookHead = 38,
	lookBody = 116,
	lookLegs = 63,
	lookFeet = 114,
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

keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "I heard the name, but I don't trust rumours." })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "Aaaahh, Carlin, yes. I know this town. Strange graveyard there, isn't it?" })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Yes, I used to live there a while ago. Nice town." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "King...king...yes, there is one. I still can remember the time when we had an other king. What was his name again?" })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "I had a watch. It was nice, but I can't see the hands anymore." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Nemal." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I have no job. I'm a {wanderer}." })
keywordHandler:addKeyword({ "wanderer" }, StdModule.say, { npcHandler = npcHandler, text = "Yes, I seem to be blind. But I am not sure - maybe the dungeons are too dark!" })
keywordHandler:addAliasKeyword({ "blind" })
keywordHandler:addKeyword({ "dungeons" }, StdModule.say, { npcHandler = npcHandler, text = "You can find some treasures here - some are bigger, some are smaller, some are of true value, some are of materialistic value." })
keywordHandler:addAliasKeyword({ "treasure" })
keywordHandler:addKeyword({ "gharonk" }, StdModule.say, { npcHandler = npcHandler, text = "My father knew this language." })
keywordHandler:addKeyword({ "library" }, StdModule.say, { npcHandler = npcHandler, text = "I can't read or write. What use would I have of a library?" })
keywordHandler:addKeyword({ "secret" }, StdModule.say, { npcHandler = npcHandler, text = "Secrets should remain secret. No need of making them public." })
keywordHandler:addKeyword({ "weapon" }, StdModule.say, { npcHandler = npcHandler, text = "I always have weapons with me. You never know what's behind the next corner." })
keywordHandler:addKeyword({ "desert" }, StdModule.say, { npcHandler = npcHandler, text = "Desert? Where is one?" })
keywordHandler:addKeyword({ "sword" }, StdModule.say, { npcHandler = npcHandler, text = "I have a sword. It's very sharp. But I don't give it away, you never know." })
keywordHandler:addKeyword({ "fight" }, StdModule.say, { npcHandler = npcHandler, text = "Better know how to fight!" })
keywordHandler:addKeyword({ "guild" }, StdModule.say, { npcHandler = npcHandler, text = "Hmmm.. I wouldn't ever join a guild, but i know of the existance of some." })
keywordHandler:addKeyword({ "book" }, StdModule.say, { npcHandler = npcHandler, text = "I can't read. I've never learned it." })
keywordHandler:addKeyword({ "door" }, StdModule.say, { npcHandler = npcHandler, text = "Closed doors need keys. What a pity keys are not lying around like rubbish!" })
keywordHandler:addKeyword({ "help" }, StdModule.say, { npcHandler = npcHandler, text = "Hmm.. help? How can I help you?" })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
