local internalNpcName = "Talesia"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 138,
	lookHead = 114,
	lookBody = 97,
	lookLegs = 58,
	lookFeet = 116,
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

keywordHandler:addKeyword({ "army" }, StdModule.say, { npcHandler = npcHandler, text = "At least they are useful, but we pay enough taxes to supply the entire Thaian army." })
keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "I am contend with my familysword meloncutter." })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "I hope he is aware that his enemies live elsewhere." })
-- above "tibia", which is inside "tibianus"
keywordHandler:addKeyword({ "tibianus" }, StdModule.say, { npcHandler = npcHandler, text = "We pay this man enough to live here undisturbed of major interventions." })
keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "The world is a treasure chest for those of knowledge and skill." })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "They are a bit problematic as business partners, but their independence from Thais is... interesting." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "I hope they live well from our taxes..." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "We pay this man enough to live here undisturbed of major interventions." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "It's 1:25 am right now." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am Talesia De'Mir, owner of {Crunor}'s Finest {Warehouse}." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am a the owner of {Crunor}'s Finest {Warehouse} of course." })
keywordHandler:addKeyword({ "privileges" }, StdModule.say, { npcHandler = npcHandler, text = "We are alowed to trade with anyone, Thaian subject or not, have no Thaian noble as governor, and own the exclusive {gambling} license." })
keywordHandler:addKeyword({ "warehouse" }, StdModule.say, { npcHandler = npcHandler, text = "My warehouse is only one of many. We merchants hold this city together and lead it to prosperity." })
keywordHandler:addKeyword({ "gambling" }, StdModule.say, { npcHandler = npcHandler, text = "I don't care much about it, though others profit greatly." })
keywordHandler:addKeyword({ "crunor" }, StdModule.say, { npcHandler = npcHandler, text = "A god worth to worship. At least he gives something useful back to the faithful." })
keywordHandler:addKeyword({ "taxes" }, StdModule.say, { npcHandler = npcHandler, text = "Venore is the major tax payer in the whole realm. So we more than deserve the {privileges} the king granted us." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
