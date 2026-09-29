local internalNpcName = "Imbueno"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 132, -- Nobleman
	lookHead = 95,
	lookBody = 113,
	lookLegs = 39,
	lookFeet = 115,
	lookAddons = 3,
}

npcConfig.flags = {
	floorchange = false,
}

-- Imbuement materials trading table: buy = price Imbueno sells at (player
-- pays this), sell = price Imbueno buys at (player receives this). Same
-- items and prices as Scrapjack (see /tmp/antica_imbuement_prices_rounded.tsv).
npcConfig.shop = {
	{ itemName = "battle stone", clientId = 11447, buy = 300, sell = 200 },
	{ itemName = "blazing bone", clientId = 16131, buy = 800, sell = 500 },
	{ itemName = "bloody pincers", clientId = 9633, buy = 14500, sell = 13000 },
	{ itemName = "brimstone fangs", clientId = 11702, buy = 16100, sell = 15300 },
	{ itemName = "brimstone shell", clientId = 11703, buy = 210, sell = 200 },
	{ itemName = "broken shamanic staff", clientId = 11452, buy = 16700, sell = 14800 },
	{ itemName = "compass", clientId = 10302, buy = 200, sell = 60 },
	{ itemName = "crawler head plating", clientId = 14079, buy = 4600, sell = 3300 },
	{ itemName = "crystallized anger", clientId = 23507, buy = 450, sell = 250 },
	{ itemName = "cultish mask", clientId = 9638, buy = 25000, sell = 24200 },
	{ itemName = "cultish robe", clientId = 9639, buy = 200, sell = 150 },
	{ itemName = "cyclops toe", clientId = 9657, buy = 300, sell = 200 },
	{ itemName = "damselfly wing", clientId = 17458, buy = 200, sell = 50 },
	{ itemName = "deepling warts", clientId = 14012, buy = 180, sell = 150 },
	{ itemName = "demon horn", clientId = 5954, buy = 1000, sell = 850 },
	{ itemName = "demonic skeletal hand", clientId = 9647, buy = 80, sell = 60 },
	{ itemName = "draken sulphur", clientId = 11658, buy = 550, sell = 500 },
	{ itemName = "elven hoof", clientId = 18994, buy = 16800, sell = 15600 },
	{ itemName = "elven scouting glass", clientId = 11464, buy = 1000, sell = 550 },
	{ itemName = "elvish talisman", clientId = 9635, buy = 10500, sell = 8300 },
	{ itemName = "energy vein", clientId = 23508, buy = 270, sell = 200 },
	{ itemName = "fairy wings", clientId = 25694, buy = 350, sell = 200 },
	{ itemName = "fiery heart", clientId = 9636, buy = 400, sell = 300 },
	{ itemName = "flask of embalming fluid", clientId = 11466, buy = 5200, sell = 4300 },
	{ itemName = "frazzle skin", clientId = 20199, buy = 400, sell = 350 },
	{ itemName = "frosty heart", clientId = 9661, buy = 300, sell = 250 },
	{ itemName = "ghostly tissue", clientId = 9690, buy = 300, sell = 20 },
	{ itemName = "gloom wolf fur", clientId = 22007, buy = 45000, sell = 39800 },
	{ itemName = "gold-brocaded cloth", clientId = 40529, buy = 600, sell = 250 },
	{ itemName = "goosebump leather", clientId = 20205, buy = 650, sell = 500 },
	{ itemName = "green dragon leather", clientId = 5877, buy = 19000, sell = 15300 },
	{ itemName = "green dragon scale", clientId = 5920, buy = 500, sell = 250 },
	{ itemName = "hellspawn tail", clientId = 10304, buy = 500, sell = 400 },
	{ itemName = "lion's mane", clientId = 9691, buy = 60, sell = 50 },
	{ itemName = "little bowl of myrrh", clientId = 25702, buy = 7400, sell = 6900 },
	{ itemName = "mantassin tail", clientId = 11489, buy = 1600, sell = 950 },
	{ itemName = "metal spike", clientId = 10298, buy = 550, sell = 300 },
	{ itemName = "mooh'tah shell", clientId = 21202, buy = 1000, sell = 650 },
	{ itemName = "moohtant horn", clientId = 21200, buy = 5500, sell = 4200 },
	{ itemName = "mystical hourglass", clientId = 9660, buy = 750, sell = 500 },
	{ itemName = "ogre nose ring", clientId = 22189, buy = 250, sell = 150 },
	{ itemName = "orc tooth", clientId = 10196, buy = 600, sell = 400 },
	{ itemName = "peacock feather fan", clientId = 21975, buy = 400, sell = 250 },
	{ itemName = "petrified scream", clientId = 10420, buy = 450, sell = 250 },
	{ itemName = "piece of dead brain", clientId = 9663, buy = 23300, sell = 19700 },
	{ itemName = "piece of scarab shell", clientId = 9641, buy = 900, sell = 300 },
	{ itemName = "piece of swampling wood", clientId = 17823, buy = 7000, sell = 6600 },
	{ itemName = "pile of grave earth", clientId = 11484, buy = 400, sell = 80 },
	{ itemName = "poisonous slime", clientId = 9640, buy = 650, sell = 40 },
	{ itemName = "polar bear paw", clientId = 9650, buy = 1200, sell = 250 },
	{ itemName = "protective charm", clientId = 11444, buy = 3600, sell = 3200 },
	{ itemName = "quill", clientId = 28567, buy = 1100, sell = 750 },
	{ itemName = "rope belt", clientId = 11492, buy = 4300, sell = 3900 },
	{ itemName = "rorc feather", clientId = 18993, buy = 500, sell = 50 },
	{ itemName = "sabretooth", clientId = 10311, buy = 6000, sell = 5400 },
	{ itemName = "seacrest hair", clientId = 21801, buy = 260, sell = 150 },
	{ itemName = "silencer claws", clientId = 20200, buy = 4300, sell = 3800 },
	{ itemName = "slime heart", clientId = 21194, buy = 200, sell = 90 },
	{ itemName = "snake skin", clientId = 9694, buy = 450, sell = 350 },
	{ itemName = "some grimeleech wings", clientId = 22730, buy = 2300, sell = 1500 },
	{ itemName = "strand of medusa hair", clientId = 10309, buy = 5000, sell = 4200 },
	{ itemName = "swamp grass", clientId = 9686, buy = 100, sell = 10 },
	{ itemName = "thick fur", clientId = 10307, buy = 950, sell = 450 },
	{ itemName = "vampire teeth", clientId = 9685, buy = 300, sell = 200 },
	{ itemName = "vexclaw talon", clientId = 22728, buy = 1300, sell = 950 },
	{ itemName = "war crystal", clientId = 9654, buy = 500, sell = 350 },
	{ itemName = "warmaster's wristguards", clientId = 10405, buy = 200, sell = 100 },
	{ itemName = "waspoid wing", clientId = 14081, buy = 600, sell = 400 },
	{ itemName = "wereboar hooves", clientId = 22053, buy = 250, sell = 200 },
	{ itemName = "winter wolf fur", clientId = 10295, buy = 7200, sell = 6100 },
	{ itemName = "wyrm scale", clientId = 9665, buy = 400, sell = 350 },
	{ itemName = "wyvern talisman", clientId = 9644, buy = 10500, sell = 9400 },
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

keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I'm the only seller and buyer of imbuement items authorized by the Explorer Society." })

npcHandler:setMessage(MESSAGE_GREET, "Greetings, traveler! Unlike certain pirates around here with... questionable commercial practices, I deal only in top-quality imbuement items, honestly sourced and fairly priced. Just ask me about {trade}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Of course, take a look at my wares.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

npcType:register(npcConfig)
