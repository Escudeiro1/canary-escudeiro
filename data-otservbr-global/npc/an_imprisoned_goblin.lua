local internalNpcName = "An Imprisoned Goblin"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 61,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Me so hungry..." },
	{ text = "Frog God, hear poor goblin! Send help!..." },
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

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Name lost in sorrow! Took new one to show tragic fate of goblinkind! Garamor Avolok Tor-Mazak!" })
keywordHandler:addKeyword({ "garamor avolok tor-mazak" }, StdModule.say, { npcHandler = npcHandler, text = "Black Veil on Mind, Shadow on Heart, Tears of Blood, Weeping for Thousands Killed by Greed! Near enough translation." })
keywordHandler:addKeyword({ "swordfish" }, StdModule.say, { npcHandler = npcHandler, text = "Him best friend of Sugatrap. Found city founding stone, and him become protector of city. ... Many great deeds defending first goblin generations from hungry ogres poking around in mountains! Long we safe because of him!" })
keywordHandler:addKeyword({ "hopgoblin" }, StdModule.say, { npcHandler = npcHandler, text = "Greatest thinker of golden age. 'I think, therefore I goblin!' When ogre found secret tunnel entrance, it Hopgoblin who told famous riddle to make ogre think long enough, saving hundreds of goblins!" })
keywordHandler:addKeyword({ "sugatrap" }, StdModule.say, { npcHandler = npcHandler, text = "Long time ago, he given vision by Frog God, and founded hidden city of goblins. Free goblins! First among equals he was! But great times long gone. All devastated by greedy ogres." })
keywordHandler:addKeyword({ "goblins" }, StdModule.say, { npcHandler = npcHandler, text = "Once, goblins stupid and greedy like rest of this world! But then, Frog God gave vision to Sugatrap how to progress. Went to holy mountain! Grew goblin civilization! Peace! Plenty! Harmony! ... But alas, goblins lost greatness again, devoured by insatiable ogre appetite for goblin flesh." })
keywordHandler:addKeyword({ "ogres" }, StdModule.say, { npcHandler = npcHandler, text = "Bane of goblins! Maybe sent to punish us? But why? All we know, they greedy, and they enslave and eat goblins. Horrible fate!" })
keywordHandler:addKeyword({ "mines" }, StdModule.say, { npcHandler = npcHandler, text = "Slavery! Poor goblins dig through hard earth for precious stones and crystals, all for greedy ogres." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
