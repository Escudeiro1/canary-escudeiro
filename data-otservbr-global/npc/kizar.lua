local internalNpcName = "Kizar"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 132,
	lookHead = 114,
	lookBody = 68,
	lookLegs = 19,
	lookFeet = 115,
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

keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I'm kind of a {butler} of the First {Dragon}. I used to be a {bard} but I decided I needed a job change." })
keywordHandler:addKeyword({ "responsible" }, StdModule.say, { npcHandler = npcHandler, text = "I couldn't stand the pressure anymore and decided I'd prefer working for a {dragon}." })
keywordHandler:addKeyword({ "deliveries" }, StdModule.say, { npcHandler = npcHandler, text = "The boss has some kind of agreement with the amazons of the Green Claw Swamp. They sent us all the {goods} we need." })
keywordHandler:addKeyword({ "dragon" }, StdModule.say, { npcHandler = npcHandler, text = "Yes he hired me as his {butler} so to say. He is a real pain sometimes and requires me to bath in hot water - along with loads of vegetables. However, he is also not worse than my boss before him." })
keywordHandler:addKeyword({ "butler" }, StdModule.say, { npcHandler = npcHandler, text = "He has no unreasonable demands so the {job} is acceptable. Sometimes he's moody and some of his demands are strange, especially the {deliveries} he orders now and then. ... Well, rich and eccentric people are all the same, be they humans or dragons." })
keywordHandler:addKeyword({ "goods" }, StdModule.say, { npcHandler = npcHandler, text = "For a while they tried to train local wasps for {deliveries}, but later on they preferred to assign them to dragons." })
keywordHandler:addKeyword({ "bard" }, StdModule.say, { npcHandler = npcHandler, text = "Yes, I travelled from town to town to perform my songs - sometimes for the populace, sometimes for the nobility. But eventually it took its {toll} on me." })
keywordHandler:addKeyword({ "toll" }, StdModule.say, { npcHandler = npcHandler, text = "There is always this pressure and the possibility of failure. Also, there is a good chance that people hold you - a travelling stranger - {responsible} for everything from weather to bad harvests." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
