local internalNpcName = "Ula"
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
	lookHead = 60,
	lookBody = 24,
	lookLegs = 38,
	lookFeet = 0,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Sorcs rule!" },
	{ text = "Fry your foes!" },
	{ text = "Wizards wield a mean staff!" },
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

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Me? <giggles> I am {Ula}, magic assistant to the grand sorcerer {Estrella} and humble spectator at our festival." })
keywordHandler:addKeyword({ "estrella" }, StdModule.say, { npcHandler = npcHandler, text = "She's awesome. She is our {sorcerer} vocation trainer on the Island of Destiny. ... You should talk to her after the festival if you want to become a sorc, too." })
keywordHandler:addKeyword({ "sorcerer" }, StdModule.say, { npcHandler = npcHandler, text = "That's us! Casting magic since - um, always, actually! We're the coolest cats in any town. ... I mean, cast fire and hurl death at your enemies? What's not to like about that? ... Anyway, go visit {Tylius} next door here if you wish to know more stuff - like, how to use a staff. It's really cool." })
keywordHandler:addKeyword({ "tylius" }, StdModule.say, { npcHandler = npcHandler, text = "He's sooo cute. ... I mean, he's an apprentice sorcerer, like me. He's in this tent right here. He's really good in staff and rod combat, you should totally check it out!" })
keywordHandler:addKeyword({ "magic" }, StdModule.say, { npcHandler = npcHandler, text = "Really handy to keep all kinds of jerks at a distance, let me tell you! And it's quite the thing to impress cute boys, too." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
