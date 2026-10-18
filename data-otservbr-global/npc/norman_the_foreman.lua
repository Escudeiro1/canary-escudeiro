local internalNpcName = "Norman The Foreman"
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
	lookHead = 59,
	lookBody = 98,
	lookLegs = 96,
	lookFeet = 114,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "You two! Grab that saw and set to work on those logs! I need 50 planks by the end of shift!" },
	{ text = "Oi! You lot over there! Careful, that's valuable timber you're handlin'!" },
	{ text = "You lot! Get to work! Those roads planks don't lay 'emselves by magic you know!" },
	{ text = "Oi you! Yes, you! Come on, come on, get movin'! Lose that coffee mug and check on the water wheels!" },
	{ text = "You! Get your lazy butt up this minute! I don't pay you for starin' 'oles in the air!" },
	{ text = "You there! D'ya call that work? I call that lazin' around! Now get to choppin' up that timber this instant!" },
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

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
