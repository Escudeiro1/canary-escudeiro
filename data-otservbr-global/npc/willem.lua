local internalNpcName = "Willem"
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
	{ text = "Paladins do it with their eyes closed!" },
	{ text = "Be the hunter! Be a paladin!" },
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

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am {Willem}, prentice paladin to the honourable {Narai}." })
keywordHandler:addKeyword({ "shanoya" }, StdModule.say, { npcHandler = npcHandler, text = "She is top of our class and our combat trainer. Formidable with the spear! You should see her. A true huntress." })
keywordHandler:addKeyword({ "paladin" }, StdModule.say, { npcHandler = npcHandler, text = "The noblest of vocations. Roam the forests as a {ranger}! Hunt with the {hunters}! Slay {unholy} beasts!" })
keywordHandler:addKeyword({ "ranger" }, StdModule.say, { npcHandler = npcHandler, text = "A paladin rank. Sneak gracefully through the forests of Tibia and shoot clumsy monsters with your bow from afar!" })
keywordHandler:addAliasKeyword({ "hunter" })
keywordHandler:addKeyword({ "unholy" }, StdModule.say, { npcHandler = npcHandler, text = "Undead creatures like mummies, ghouls or vampires. We paladins slay them with our unique gift of holy {magic}. But our primary weapon to hunt monsters is the bow or spear." })
keywordHandler:addKeyword({ "narai" }, StdModule.say, { npcHandler = npcHandler, text = "She is the {paladin} vocation trainer on the Island of Destiny. ... Talk to her after the festival if you want to become a paladin, too!" })
keywordHandler:addKeyword({ "magic" }, StdModule.say, { npcHandler = npcHandler, text = "We paladins exclusively use holy magic, to slay undead and unholy creatures. Sorcerers and druids use the other forms of magic." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
