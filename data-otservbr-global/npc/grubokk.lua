local internalNpcName = "Grubokk"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 857,
}

npcConfig.flags = {
	floorchange = false,
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

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Grrrrrr! Me mighty Grubokk! You puny morsel!" })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Me guard goblin slaves. Good job! Free food! Hur hur!" })
keywordHandler:addKeyword({ "great hunger" }, StdModule.say, { npcHandler = npcHandler, text = "Yes, I always hungry! Chosen by Great Hunger! Hurhur! I made joke!" })
keywordHandler:addKeyword({ "thunder tusk" }, StdModule.say, { npcHandler = npcHandler, text = "Other tribe, stupid and mean, steal from us. We fight them always!" })
keywordHandler:addKeyword({ "krailos" }, StdModule.say, { npcHandler = npcHandler, text = "Land of ogres you see out there, hu-man!" })
keywordHandler:addKeyword({ "goblins" }, StdModule.say, { npcHandler = npcHandler, text = "Full of air from too much fan-ci-ful words. Worship puny, powerless frog. Tinker with tools without own strength. Not know true power. Not earthed like ogres. Deserve to be slaves!" })
keywordHandler:addKeyword({ "revolt" }, StdModule.say, { npcHandler = npcHandler, text = "Huh! Grubokk got all under control! Goblins quiet! But if not... tell me and Grubokk may have task for you! Harhar!" })
keywordHandler:addKeyword({ "tools" }, StdModule.say, { npcHandler = npcHandler, text = "Puny goblins tinker with fiddly tools, huh. Never get anywhere with their repairs! Pah! Ogre strong, use big pliers to cut through bone and hide!" })
keywordHandler:addAliasKeyword({ "pliers" })
keywordHandler:addKeyword({ "tribe" }, StdModule.say, { npcHandler = npcHandler, text = "Tribes always at war with others! Bash in enemy heads! Harharr!" })
keywordHandler:addKeyword({ "ogres" }, StdModule.say, { npcHandler = npcHandler, text = "Ogres strong! And our tribe strongest!" })
keywordHandler:addKeyword({ "chief" }, StdModule.say, { npcHandler = npcHandler, text = "Me want to be chieftain instead of chieftain!" })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
