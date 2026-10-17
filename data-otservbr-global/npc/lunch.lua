local internalNpcName = "Lunch"
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

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Me new name is Lunch." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am many, many things. Me bodyguard for Robson. Watching over him when sleeping. Me good fisherman. Me fish soo many fish that sometime no fish is left. ... Aaaand me many, many other things. All so more much fun with Robson. At home at goblin camp me only was punching ball for bigger goblins." })
keywordHandler:addKeyword({ "robson" }, StdModule.say, { npcHandler = npcHandler, text = "He good dwarf. Not kill me but gave me food and bandages. Me and Robson very great friends!" })
keywordHandler:addKeyword({ "dwarf" }, StdModule.say, { npcHandler = npcHandler, text = "Dwarf are dangerous fighters. Me first very great fear of Robson because dwarf he is. But Robson good dwarf is. Not killing poor little goblin. ... Uh, of course mayhaps that making him bad dwarf, me not sure." })
keywordHandler:addKeyword({ "isle" }, StdModule.say, { npcHandler = npcHandler, text = "Isle so scary. Evil monsters everywhere. Robson sometimes gone exploring. Me begging him not to go but he so brave. Gladly he always back for Lunch." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
