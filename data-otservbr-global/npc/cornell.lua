local internalNpcName = "Cornell"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 129,
	lookHead = 114,
	lookBody = 99,
	lookLegs = 40,
	lookFeet = 115,
	lookAddons = 2,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Passage to Grimvale and Edron." },
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

-- Travel
local function addTravelKeyword(keyword, cost, destination, action)
	local travelKeyword = keywordHandler:addKeyword({ keyword }, StdModule.say, { npcHandler = npcHandler, text = "Do you seek a passage to " .. keyword:titleCase() .. " for |TRAVELCOST|?", cost = cost, discount = "postman" })
	travelKeyword:addChildKeyword({ "yes" }, StdModule.travel, { npcHandler = npcHandler, premium = false, cost = cost, discount = "postman", destination = destination }, nil, action)
	travelKeyword:addChildKeyword({ "no" }, StdModule.say, { npcHandler = npcHandler, text = "We would like to serve you some time.", reset = true })
end

addTravelKeyword("grimvale", 100, Position(33341, 31691, 7))
addTravelKeyword("edron", 100, Position(33304, 31719, 7))

-- Kick

-- Basic
keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "I'm offering a little ferry service between Edron and Grimvale." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Cornell." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I'm offering a little ferry service between {Edron} and {Grimvale}." })
keywordHandler:addKeyword({ "sail" }, StdModule.say, { npcHandler = npcHandler, text = "I can travel you to {Grimvale} or {Edron}." })
keywordHandler:addKeyword({ "werewolves" }, StdModule.say, { npcHandler = npcHandler, text = "Yes, werewolves, indeed. They dwell here on Grimvale. The were-sickness transforms our peaceful villagers into savage beasts. Why or how this curse found us, we do not know yet. Only that it is here now." })
keywordHandler:addKeyword({ "dangerous" }, StdModule.say, { npcHandler = npcHandler, text = "Werewolves, my friend! They dwell on Grimvale, where a horrible were-sickness transforms peaceful villagers into savage beasts. Why or how the curse found its way to this small island, we do not know. But somehow it did." })
keywordHandler:addKeyword({ "maeryn" }, StdModule.say, { npcHandler = npcHandler, text = "She's become a kind of protector for this village. A forceful woman, very courageous and experienced with the bow." })
keywordHandler:addKeyword({ "gladys" }, StdModule.say, { npcHandler = npcHandler, text = "Our druid. She was already old when I was still young, and has been living here on Grimvale for ages. She's very interested in were-creature body parts. If you find any, she might give you some coin for them." })
keywordHandler:addKeyword({ "owin" }, StdModule.say, { npcHandler = npcHandler, text = "He's the village's most experienced hunter. Not a young man anymore, but he can defend himself well enough against the {werewolves}. He's the one who knows most about Grimvale's forests, animals, and the werewolves here." })
npcHandler:setMessage(MESSAGE_GREET, "Welcome on board, |PLAYERNAME|. Where can I {sail} you today, to {Grimvale} or {Edron}?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye. Recommend us if you were satisfied with our service.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye then.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
