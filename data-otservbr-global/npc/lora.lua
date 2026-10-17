local internalNpcName = "Lora"
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
	lookHead = 114,
	lookBody = 70,
	lookLegs = 0,
	lookFeet = 19,
	lookAddons = 1,
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

keywordHandler:addKeyword({ "gods" }, StdModule.say, { npcHandler = npcHandler, text = "They are the hands that weave our fate, but don't forget about your own power and influence." })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "He's not invited." })
keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "A world filled with wonders and adventures! All of this is waiting to be explored - by you!" })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "Time moves on and now the time has come again to {celebrate} and to look back and to remember." })
keywordHandler:addKeyword({ "festivities" }, StdModule.say, { npcHandler = npcHandler, text = "Isn't it always surprising how fast time flies? The {years} have positively flown by in a mist of happiness." })
keywordHandler:addKeyword({ "experiences" }, StdModule.say, { npcHandler = npcHandler, text = "In the end your experiences are part of our story - the story of a journey, of growth, of maturity. We all have created this together. Without each other none of this would exist. ... Thank you for listening! Thank you for forging friendships! Thank you for going on adventures! Thank you for exploring! Thank you for being a part of it! It is truly you who is truly celebrated here and now. Thank you! Thank you for everything!" })
keywordHandler:addKeyword({ "anniversary" }, StdModule.say, { npcHandler = npcHandler, text = "It's a fine day to {celebrate}." })
keywordHandler:addKeyword({ "beginnings" }, StdModule.say, { npcHandler = npcHandler, text = "In the beginning there was only an idea, a vision. Back then no one could foresee how things would evolve. The {past} has shown that the world can change the course of the people and the people can change the course of the world. ... Fates have crossed and parted. None of these encounters were insignificant. Even small pebbles make large waves, especially so, when one life impacts upon another. ... This little idea which was born so many, many years ago has influenced so many, many lives throughout the whole world. In return many hands have helped to shape and refine that idea." })
keywordHandler:addKeyword({ "celebrate" }, StdModule.say, { npcHandler = npcHandler, text = "Good times, come on! It's a celebration! Just look around and have fun! Talk about it. Tell people about your experiences and memories. Take some time to listen to their {stories}. ... Don't be a wallflower! Join in! It is you who we are celebrating here." })
keywordHandler:addKeyword({ "special" }, StdModule.say, { npcHandler = npcHandler, text = "Some of you have been witnesses to the evolution of this world, others have only recently begun their journey with us and still have so much to learn about the {past}." })
keywordHandler:addKeyword({ "stories" }, StdModule.say, { npcHandler = npcHandler, text = "In the end the whole world is nothing but a blank canvas, waiting to be filled with your {experiences}, your stories of friendship and hardship, of drama and love." })
keywordHandler:addKeyword({ "years" }, StdModule.say, { npcHandler = npcHandler, text = "From humble {beginnings} something {special} has been forged in the fire of the hardships of time to metamorphose into something that is so beautiful for so many." })
keywordHandler:addKeyword({ "today" }, StdModule.say, { npcHandler = npcHandler, text = "It has been a long journey but what a ride it has been! Imagination led to adventure. Friends were made and lost, people fell in love and got married. Everything because of this little idea. ... A vision has changed the {world} - at least a little bit. For some of us more than for others." })
keywordHandler:addKeyword({ "world" }, StdModule.say, { npcHandler = npcHandler, text = "We live in a world that is changing and growing. This is a wonderful thing. It has been such a fascinating {time} we have shared." })
keywordHandler:addKeyword({ "past" }, StdModule.say, { npcHandler = npcHandler, text = "It is in the nature of things to start out small and shaky just like a toddler taking its first steps. The world is continuously growing and changing. Hopefully for the better. ... And just as it takes a village to raise a child, it takes a community to grow a world. The past laid the foundation for a plethora of ideas and concepts, which have combined in unique ways to become what we know {today}." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
