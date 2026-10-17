local internalNpcName = "Wyat"
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
	lookHead = 98,
	lookBody = 96,
	lookLegs = 95,
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

keywordHandler:addKeyword({ "army" }, StdModule.say, { npcHandler = npcHandler, text = "I usually work with the townguards only." })
keywordHandler:addAliasKeyword({ "guard" })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "HAIL TO KING TIBIANUS!" })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am the {sheriff} of the Thaian territory." })
keywordHandler:addKeyword({ "chester kahs" }, StdModule.say, { npcHandler = npcHandler, text = "His bureau is at the northgate." })
keywordHandler:addKeyword({ "inhabitants" }, StdModule.say, { npcHandler = npcHandler, text = "Be more specific! If you want to talk about someone I'll need a name!" })
keywordHandler:addKeyword({ "rebellion" }, StdModule.say, { npcHandler = npcHandler, text = "Luckily that's nothing I have to care about." })
keywordHandler:addKeyword({ "zathroth" }, StdModule.say, { npcHandler = npcHandler, text = "Don't mention this name!" })
keywordHandler:addKeyword({ "criminal" }, StdModule.say, { npcHandler = npcHandler, text = "Our enemies are numerous and not all are obvious." })
keywordHandler:addKeyword({ "problems" }, StdModule.say, { npcHandler = npcHandler, text = "We will handle each problem with care." })
keywordHandler:addKeyword({ "benjamin" }, StdModule.say, { npcHandler = npcHandler, text = "The poor fool lost his mind some years ago. It's a good thing they gave him a job in the post office." })
keywordHandler:addKeyword({ "eclesius" }, StdModule.say, { npcHandler = npcHandler, text = "An old magician that lives south of here. I sometimes see strange smoke coming from his house." })
keywordHandler:addKeyword({ "sheriff" }, StdModule.say, { npcHandler = npcHandler, text = "I uphold law and order. I protect Thais {inhabitants} ... and keep an eye on them." })
keywordHandler:addKeyword({ "mission" }, StdModule.say, { npcHandler = npcHandler, text = "Look up our 'Tibia's most wanted' lists." })
keywordHandler:addAliasKeyword({ "quest" })
keywordHandler:addKeyword({ "general" }, StdModule.say, { npcHandler = npcHandler, text = "Old Bloodblade does a fine job." })
keywordHandler:addKeyword({ "weapon" }, StdModule.say, { npcHandler = npcHandler, text = "Sam, the Thaian smith, is a man of great diligence. Whenever in need of weapons or armor, just ask him." })
keywordHandler:addAliasKeyword({ "armor" })
keywordHandler:addKeyword({ "castle" }, StdModule.say, { npcHandler = npcHandler, text = "The castle should be relatively safe from criminal transgressions." })
keywordHandler:addKeyword({ "harsky" }, StdModule.say, { npcHandler = npcHandler, text = "A fine warrior, indeed. He is one of the king's bodyguards." })
keywordHandler:addAliasKeyword({ "stutch" })
keywordHandler:addKeyword({ "banor" }, StdModule.say, { npcHandler = npcHandler, text = "He is the patron of justice and bravery." })
keywordHandler:addKeyword({ "elane" }, StdModule.say, { npcHandler = npcHandler, text = "A woman of great skill and courage. No one deserves the title of a Grandmaster of the Paladins more then her." })
keywordHandler:addKeyword({ "city" }, StdModule.say, { npcHandler = npcHandler, text = "The city is not as bad as some people might claim, but we certainly have our problems here." })
keywordHandler:addKeyword({ "bozo" }, StdModule.say, { npcHandler = npcHandler, text = "He's so funny, I could listen to his jokes for hours." })
keywordHandler:addKeyword({ "gorn" }, StdModule.say, { npcHandler = npcHandler, text = "He was a rowdy in his youth, but now he's a fine citizen as far as I can tell." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
