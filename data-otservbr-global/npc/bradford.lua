local internalNpcName = "Bradford"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 128,
	lookHead = 38,
	lookBody = 93,
	lookLegs = 82,
	lookFeet = 116,
	lookAddons = 2,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Ahem. A stooory is told, adventures unfold..." },
	{ text = "Ahem. Demons dance in the hall of bones!" },
	{ text = "Ahem. It's brother against brother, steel against steel..." },
	{ text = "Ahem. Laaaaand of the twin suns, how beautiful you are..." },
	{ text = "Ahem. Love... and death... and romance... lalala... and so on." },
	{ text = "Ahem. Ohhh blood is shed... and insanity reigns..." },
	{ text = "Ahem. Ohhh Tibia, my one true love..." },
	{ text = "Ahem. The stars are so pretty, so pretty tonight..." },
	{ text = "Ahem. Yo ho ho and a bottle of rum!" },
	{ text = "Okay, now I need some rum to keep my throat wet." },
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
