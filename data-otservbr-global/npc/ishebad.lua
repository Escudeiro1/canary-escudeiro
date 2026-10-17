local internalNpcName = "Ishebad"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 65,
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

-- Promotion
local promoteKeyword = keywordHandler:addKeyword({ "promot" }, StdModule.say, { npcHandler = npcHandler, text = "Do you want to be promoted in your vocation for 20000 gold?" })
promoteKeyword:addChildKeyword({ "yes" }, StdModule.promotePlayer, { npcHandler = npcHandler, monk = true, level = 20, cost = 20000 })
promoteKeyword:addChildKeyword({ "" }, StdModule.say, { npcHandler = npcHandler, text = "Ok, whatever.", reset = true })

keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "This world just awaits the wisdom of our pharaoh. It needs that wisdom and will soon learn to appreciate it." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "Time does not matter to the undead." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am Ishebad the chosen." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "The pharaoh wants not to be disturbed. I am his grand vizier and responsible for the daily affairs of the city and promotions of heroes." })
keywordHandler:addAliasKeyword({ "arkhothep" })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "Other cities are of no importance. Ankrahmun will become the center of the known world anyways." })
keywordHandler:addAliasKeyword({ "venore" })
keywordHandler:addAliasKeyword({ "kazordoon" })
keywordHandler:addAliasKeyword({ "ab'dendriel" })
keywordHandler:addKeyword({ "ankrahmun" }, StdModule.say, { npcHandler = npcHandler, text = "Our city will become the capital of a worldwide empire." })
keywordHandler:addKeyword({ "uthun" }, StdModule.say, { npcHandler = npcHandler, text = "Consult a priest to learn how you could achieve ascension." })
keywordHandler:addAliasKeyword({ "ascension" })
keywordHandler:addKeyword({ "darashia" }, StdModule.say, { npcHandler = npcHandler, text = "This village is so insignificant that our wise pharaoh has choosen to ignore it." })
keywordHandler:addKeyword({ "pharaoh" }, StdModule.say, { npcHandler = npcHandler, text = "Our immortal ruler, may he be blessed, is the keeper of our enlightenment and our saviour." })
keywordHandler:addKeyword({ "undead" }, StdModule.say, { npcHandler = npcHandler, text = "Undeath is only for the choosen." })
keywordHandler:addKeyword({ "darama" }, StdModule.say, { npcHandler = npcHandler, text = "The rule of our beloved pharaoh will soon spread this continent and one day the whole known world." })
keywordHandler:addKeyword({ "scarab" }, StdModule.say, { npcHandler = npcHandler, text = "The scarabs are keepers of secrets. Some secrets are not meant for you mortals. Ever keep that in mind." })
npcHandler:setMessage(MESSAGE_GREET, "Be mourned, pilgrim in flesh. Are you looking for a promotion?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye, |PLAYERNAME|!")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
