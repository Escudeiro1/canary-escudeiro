local internalNpcName = "A Dark Priestess"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 58,
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

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is of no concern to you!" })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I'm a priestess of Zathroth." })
keywordHandler:addKeyword({ "sacrifice" }, StdModule.say, { npcHandler = npcHandler, text = "Zathroth teaches us that without sacrifice there is no progress and everything you gain is connected to a {burden}." })
keywordHandler:addKeyword({ "knowledge" }, StdModule.say, { npcHandler = npcHandler, text = "There is no knowledge that is forbidden. If you are powerful enough to take it, it is yours. Be aware though that knowledge for the sake of knowing alone is a sin in the eyes of Zathroth. ... Those who 'know' are entitled to act! The more you understand the more you are responsible to change things even when the ignorant world will blame you for that." })
keywordHandler:addKeyword({ "necessity" }, StdModule.say, { npcHandler = npcHandler, text = "Doing the necessary is always a burden. Ignorant people will blame and fear you for your actions. Some things that have to be done are not going to make you popular. ... More often than not people won't understand your actions. Often it is not possible to explain things at all." })
keywordHandler:addKeyword({ "intruders" }, StdModule.say, { npcHandler = npcHandler, text = "The war of the demons has reached an eternal stalemate. Only intruders might tip the scales of favour for a while. But even the side profiting from such an intervention would not be grateful since they would feel their advantage is a cheated one. ... Should one side get considerably weakened, the other will take more hold in the complex. ... Eventually the more powerful side will be able to summon their leaders to our plane and will dominate the battlefield for a while. Eventually though, a backlash of the other demons will drive them back and the stalemate is restored." })
keywordHandler:addKeyword({ "zathroth" }, StdModule.say, { npcHandler = npcHandler, text = "You misled fools know nothing about the {truth}. The lies that your temples feed you have poisoned your mind! ... Zathroth is the source of everything. When the other gods hesitated to do the necessary to start creation it was Zathroth who stepped forward and took it upon him to commit the great {sacrifice}." })
keywordHandler:addKeyword({ "burden" }, StdModule.say, { npcHandler = npcHandler, text = "A burden comes in many shapes. Often it is the burden of {knowledge}. Sometimes it is the burden of {necessity}." })
keywordHandler:addKeyword({ "truth" }, StdModule.say, { npcHandler = npcHandler, text = "Even before the priests of Zathroth were banished from the cities, they spread lies to poison the mind of the people. ... When the priests had left it became even worse, and now after several generations of lies and propaganda, all what is left in the minds of the people is a fabricated scarecrow." })
keywordHandler:addKeyword({ "edron" }, StdModule.say, { npcHandler = npcHandler, text = "This isle holds many secrets. You will have to figure them out on your own though. Knowledge comes only to the worthy." })
keywordHandler:addKeyword({ "demon" }, StdModule.say, { npcHandler = npcHandler, text = "The word 'demon' is extremely imprecise. It is like a baby calling everything with four legs a 'cow'. ... There are demons that are more a tool than a sentient being. Then there are demons whose intellect dwarfs the greatest minds of humanity. ... Some are unique, others belong to races and subspecies and even in a given demon race the differences might be extreme." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
