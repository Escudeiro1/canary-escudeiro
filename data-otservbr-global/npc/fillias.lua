local internalNpcName = "Fillias"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 130,
	lookHead = 59,
	lookBody = 57,
	lookLegs = 49,
	lookFeet = 95,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "What? What? Is there anyone there? Oh. Just the wind." },
	{ text = "Shoo! Off with you, horrible pests!" },
	{ text = "Hah. It will all end in tears, you mark my words." },
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

keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "You're not from here, I could tell. I wish I were younger, I would have liked to see foreign lands. Too late now, too old. <sighs>" })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "Hmm, I heard of that. Not much chance of a return of that old regime on Oramond, though. The magistrate's in charge here. Fillias" })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "Do I look like I got a use for a clock? Hah. <mutters>" })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Hmm? Fillias Wayward Stokeston, that's what I was called. Nowadays, it's just ol' Fillias, hah." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Hmph. Not much of one left. Too old, see. Used to be the waterworks keeper." })
keywordHandler:addKeyword({ "waterworks" }, StdModule.say, { npcHandler = npcHandler, text = "Ah, those were the days! You see, there are two springs coming down the mountain. That's where the city gets its fresh water supplies. ... So we built subterranean {waterways}. And we used the rain water, too. Now that was clever. And everybody, rich or poor, could afford fresh water. Glorious days." })
keywordHandler:addKeyword({ "magistrate" }, StdModule.say, { npcHandler = npcHandler, text = "They say they run things, but have you seen what state this town's in? Just look around here and you see what I mean!" })
keywordHandler:addKeyword({ "waterways" }, StdModule.say, { npcHandler = npcHandler, text = "They're sewers now. Were used by the factory workers for their waste. Just two water reservoirs are still operative today. ... In the south, that's where the muddy water from the highlands is processed. But it's only used to wash all the filthy glooth into the river here! What a shame." })
keywordHandler:addKeyword({ "rathleton" }, StdModule.say, { npcHandler = npcHandler, text = "This city is so full of itself. True, we have an interesting past - at least the little that is known of it - but look at what happened to this part of town. ... There used to be families here, children, a market! Now, it's just me and some others hanging on." })
keywordHandler:addKeyword({ "factory" }, StdModule.say, { npcHandler = npcHandler, text = "Big building just across the street here. Completely ruined, now. Some strange accident years and years ago there, but it was all hushed up. I heard they built a new factory in the workshops quarter. Hah." })
keywordHandler:addKeyword({ "glooth" }, StdModule.say, { npcHandler = npcHandler, text = "Huh. They say it's very useful, but I still don't see it replacing water. Can't live without water. This city poisons itself with that glooth stuff! Remember when the old factory blew up? ... There's even food made out of glooth nowadays. Food! Out of something that came out of a worm? I won't have it. Fish and water's good enough for me!" })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
