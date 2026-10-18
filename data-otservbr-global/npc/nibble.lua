local internalNpcName = "Nibble"
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
	{ text = "Work, work, work..." },
	{ text = "Making grub as fast as can!" },
	{ text = "Poor goblin! Poor goblin!" },
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

keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "Eating time for ogre bosses. Cleaning pigsty time foor poor goblin, always and again." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "<sigh> Ogre bosses call me Nibble." })
keywordHandler:addKeyword({ "golozo taku narkat kash bartak har-alhad" }, StdModule.say, { npcHandler = npcHandler, text = "You mispronounce badly, hu-man! But no matter." })
keywordHandler:addKeyword({ "hopgoblin" }, StdModule.say, { npcHandler = npcHandler, text = "Him great philosopher goblin, wisest of all! Him see what need be done in thought and deed, and him do it, even if weak minds often not understand. ... Him said, goblin need many thoughts, many voices. Him said, freedom in spirit. Him said, responsibility in action. In the end, him make ultimate sacrifice. Said need of many goblins outweigh need of one! But his sad, sad loss." })
keywordHandler:addKeyword({ "swordfish" }, StdModule.say, { npcHandler = npcHandler, text = "Hero of past days, made clever pranks on ogres to save many fellow goblins. Right hand of Sugatrap during trek to find holy mountain, and trusted friend after. ... Him patron of secret city. Countless tales of his deeds, told little goblin whelps in their crib! Every goblin want to be like him - feisty, fast and funny Swordfish!" })
keywordHandler:addKeyword({ "frog god" }, StdModule.say, { npcHandler = npcHandler, text = "You not worthy of croaking his name! He no listen to you, he no turn golden eye on you, hu-man!" })
keywordHandler:addKeyword({ "goblins" }, StdModule.say, { npcHandler = npcHandler, text = "Chosen folk of Frog God. Lived free in free goblin city! Golden age of goblins before ogre came! ... Now slaves of ogres, mining for crystals. Source of deep shame. You not understand, you no goblin." })
keywordHandler:addKeyword({ "vuzrog" }, StdModule.say, { npcHandler = npcHandler, text = "Acting chieftain of tribe. Him always hungry, always make me stir horrible ogre soup with goblin bones in it! ... Him see everything as either to be eaten, be beaten or to be used for menial task. Bah." })
keywordHandler:addKeyword({ "mugruu" }, StdModule.say, { npcHandler = npcHandler, text = "Him only ogre in camp with flicker of cleverness. Him learn from hu-man Larek how to trade. Before, him used to make crude tools like rest of ogres. ... One time, goblins steal some of Mugruu's tools and ran away. Not know what became of them. Hope they smuggled to people in mines! ... But after that, all goblin slaves in camp killed except for me. I left alive as punishment! But will not give up! One day, we goblins free again!" })
keywordHandler:addKeyword({ "ghorza" }, StdModule.say, { npcHandler = npcHandler, text = "Ogress of power. Serve horrible hungry god, but she at least not interested in goblins, she always leave Nibble alone." })
keywordHandler:addKeyword({ "ogres" }, StdModule.say, { npcHandler = npcHandler, text = "Big, brutes, barbarians. Them worship greed, always greedy. Greedy for crystals! Greedy for tasty food! Greedy for violence! ... But goblins will not give up. One day we free again. ... And then, will rebuild great city greater than ever, and never be seen again by hulky ogres or hu-mans! Happiness!" })
keywordHandler:addKeyword({ "mines" }, StdModule.say, { npcHandler = npcHandler, text = "Goblin folk use to live happy in secret. Then one day ogre fall into goblin tunnel. Baaaaad day for goblins! ... Ogre come and eat goblin babies. Ogre come and make goblin mine for holy crystals. Sacrilege! Slavery! ... Ogre take goblin chief as slave in camp. Ignominy! Cannot leave camp! Cannot free people!" })
keywordHandler:addKeyword({ "larek" }, StdModule.say, { npcHandler = npcHandler, text = "Him slave like me, baking cookies for glutton chieftain. Him never leave camp again alive." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
