local internalNpcName = "Ashtamor"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 130,
	lookHead = 19,
	lookBody = 114,
	lookLegs = 76,
	lookFeet = 114,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "The passage to the afterlife is filled with obstacles, but I can help you with my wares." },
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
keywordHandler:addKeyword({ "gods" }, StdModule.say, { npcHandler = npcHandler, text = "Once you leave your mortal shell, you'll become one with the gods." })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "It seems less rotten than most other cities, but still purification would do no harm." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Thais needs to be cleansed by fire just like Venore!" })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "Kings, queens ... I've seen them come and go. Everything fades, even the glory and wealth of the richest." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "It's time How much time is left?" })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "What's a name worth in your eyes? And more important: Does the choice of your name decide your fate? Perhaps we will never know." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I consider myself as a guide, a guardian for the souls who transcend the border to {another world}." })
keywordHandler:addAliasKeyword({ "wanderer" })
keywordHandler:addKeyword({ "another world" }, StdModule.say, { npcHandler = npcHandler, text = "Does it mean anything than losing your weak physical shell? And isn't the true power in the universe rather mental than physical?" })
keywordHandler:addAliasKeyword({ "death" })
keywordHandler:addKeyword({ "netherworld" }, StdModule.say, { npcHandler = npcHandler, text = "It is the place where the dead end up. Some sages believe, that it is located below the world of the living. ... Personally, I think it rather lies within another dimension so that terms like above or beneath are inappropriate to describe it. There are some rumours that the descent to the Netherworld is difficult yet possible for those still living." })
keywordHandler:addKeyword({ "afterlife" }, StdModule.say, { npcHandler = npcHandler, text = "No one really knows what awaits us beyond. Although there are some old stories about the {Netherworld}." })
keywordHandler:addKeyword({ "dwarfs" }, StdModule.say, { npcHandler = npcHandler, text = "Dwarfs live unhealthily long and its difficult to burn them to ashes. This is suspicious." })
keywordHandler:addAliasKeyword({ "dwarves" })
keywordHandler:addKeyword({ "monster" }, StdModule.say, { npcHandler = npcHandler, text = "Oh yes, monsters can grant you a passage to the afterlife also, but it's not a comfortable trip." })
keywordHandler:addKeyword({ "venore" }, StdModule.say, { npcHandler = npcHandler, text = "You come to this world naked, and you leave it this way. So there's no need to save your money, especially in a place like Venore." })
keywordHandler:addKeyword({ "guide" }, StdModule.say, { npcHandler = npcHandler, text = "You seem exceptionally healthy. It will still take many years until you'll need my guidance." })
keywordHandler:addKeyword({ "elves" }, StdModule.say, { npcHandler = npcHandler, text = "Elves have a strange relation to death. I don't know what they are up to but we should stay wary." })
keywordHandler:addKeyword({ "birth" }, StdModule.say, { npcHandler = npcHandler, text = "Birth might be the beginning but death is certainly not the end." })
keywordHandler:addKeyword({ "slime" }, StdModule.say, { npcHandler = npcHandler, text = "This man is so old and looks so unhealthy that I expect him to become my customer every day." })
keywordHandler:addKeyword({ "soul" }, StdModule.say, { npcHandler = npcHandler, text = "The essence of life, source of your very self. While the body is in space and time, the soul exists in time only." })
keywordHandler:addKeyword({ "fire" }, StdModule.say, { npcHandler = npcHandler, text = "The purging force of fire ... it helps to free souls and its smoke helps them to find their way to another world." })
keywordHandler:addKeyword({ "life" }, StdModule.say, { npcHandler = npcHandler, text = "Life is nothing but a pre-stage for the eternity of death." })
keywordHandler:addKeyword({ "body" }, StdModule.say, { npcHandler = npcHandler, text = "Is the mind a creation of the body, or the body an invention of the mind?" })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
