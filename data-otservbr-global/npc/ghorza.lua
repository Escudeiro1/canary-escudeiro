local internalNpcName = "Ghorza"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 859,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Great Hunger is upset." },
	{ text = "Spirits are restless." },
	{ text = "All water drying up and Vuzrog does nothing!" },
}

local itemsTable = {
	["potions"] = {
		{ itemName = "empty potion flask", clientId = 283, sell = 5 },
		{ itemName = "empty potion flask", clientId = 284, sell = 5 },
		{ itemName = "empty potion flask", clientId = 285, sell = 5 },
		{ itemName = "great health potion", clientId = 239, buy = 225 },
		{ itemName = "great mana potion", clientId = 238, buy = 158 },
		{ itemName = "great spirit potion", clientId = 7642, buy = 254 },
		{ itemName = "health potion", clientId = 266, buy = 50 },
		{ itemName = "mana potion", clientId = 268, buy = 56 },
		{ itemName = "strong health potion", clientId = 236, buy = 115 },
		{ itemName = "strong mana potion", clientId = 237, buy = 108 },
		{ itemName = "supreme health potion", clientId = 23375, buy = 650 },
		{ itemName = "ultimate health potion", clientId = 7643, buy = 379 },
		{ itemName = "ultimate mana potion", clientId = 23373, buy = 488 },
		{ itemName = "ultimate spirit potion", clientId = 23374, buy = 488 },
		{ itemName = "vial", clientId = 2874, sell = 5 },
	},
	["runes"] = {
		{ itemName = "animate dead rune", clientId = 3203, buy = 375 },
		{ itemName = "avalanche rune", clientId = 3161, buy = 64 },
		{ itemName = "blank rune", clientId = 3147, buy = 10 },
		{ itemName = "chameleon rune", clientId = 3178, buy = 210 },
		{ itemName = "convince creature rune", clientId = 3177, buy = 80 },
		{ itemName = "cure poison rune", clientId = 3153, buy = 65 },
		{ itemName = "destroy field rune", clientId = 3148, buy = 15 },
		{ itemName = "disintegrate rune", clientId = 3197, buy = 26 },
		{ itemName = "energy bomb rune", clientId = 3149, buy = 203 },
		{ itemName = "energy field rune", clientId = 3164, buy = 38 },
		{ itemName = "energy wall rune", clientId = 3166, buy = 85 },
		{ itemName = "explosion rune", clientId = 3200, buy = 31 },
		{ itemName = "fire bomb rune", clientId = 3192, buy = 147 },
		{ itemName = "fire field rune", clientId = 3188, buy = 28 },
		{ itemName = "fire wall rune", clientId = 3190, buy = 61 },
		{ itemName = "fireball rune", clientId = 3189, buy = 30 },
		{ itemName = "great fireball rune", clientId = 3191, buy = 64 },
		{ itemName = "heavy magic missile rune", clientId = 3198, buy = 12 },
		{ itemName = "icicle rune", clientId = 3158, buy = 30 },
		{ itemName = "holy missile rune", clientId = 3182, buy = 16 },
		{ itemName = "intense healing rune", clientId = 3152, buy = 95 },
		{ itemName = "light magic missile rune", clientId = 3174, buy = 4 },
		{ itemName = "magic wall rune", clientId = 3180, buy = 116 },
		{ itemName = "paralyze rune", clientId = 3165, buy = 700 },
		{ itemName = "poison bomb rune", clientId = 3173, buy = 85 },
		{ itemName = "soulfire rune", clientId = 3195, buy = 46 },
		{ itemName = "stalagmite rune", clientId = 3179, buy = 12 },
		{ itemName = "stone shower rune", clientId = 3175, buy = 41 },
		{ itemName = "sudden death rune", clientId = 3155, buy = 162 },
		{ itemName = "thunderstorm rune", clientId = 3202, buy = 52 },
		{ itemName = "ultimate healing rune", clientId = 3160, buy = 175 },
		{ itemName = "wild growth rune", clientId = 3156, buy = 160 },
	},
}

npcConfig.shop = {}
for _, categoryTable in pairs(itemsTable) do
	for _, itemTable in ipairs(categoryTable) do
		table.insert(npcConfig.shop, itemTable)
	end
end

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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local categoryTable = itemsTable[message:lower()]

	if categoryTable then
		local remainingCategories = npc:getRemainingShopCategories(message:lower(), itemsTable)
		npcHandler:say("Of course, just browse through my wares. You can also look at " .. remainingCategories .. ".", npc, player)
		npc:openShopWindowTable(player, categoryTable)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "Ghorza not understanding question. If sun is in sky, time is day. If sky is dark, time is night." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Me Ghorza." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Ghorza tribe's {shaman}." })
keywordHandler:addKeyword({ "dreadful thirst" }, StdModule.say, { npcHandler = npcHandler, text = "Is new powerful spirit. Younger than {Great Hunger} but even more dangerous. We feeding Great Hunger with meat. Always enough meat in Krailos. Dreadful Thirst wants water, but dries up all water sources. So not enough water to calm Dreadful Thirst." })
keywordHandler:addKeyword({ "bloody skulls" }, StdModule.say, { npcHandler = npcHandler, text = "Bloody Skulls are ogres living here. Biggest clan of {Krailos}. Other strong tribe is {Thunder Tusk} Clan. There other tribes, too. Having no villages but being nomadic. Take care, little human, they all {maneaters}." })
keywordHandler:addKeyword({ "thunder tusk" }, StdModule.say, { npcHandler = npcHandler, text = "Thunder Tusk Clan is hostile tribe. Often battles against Thunder Tusks. They jealous. Stealing {Bloody Skulls} food and young ogresses. But most of all stealing water." })
keywordHandler:addKeyword({ "great hunger" }, StdModule.say, { npcHandler = npcHandler, text = "Great Hunger most mighty of all spirits. Will eat up entire world if ogres not feeding it all time. So ogres give Great Hunger tasty snacks: meat, beer, humans, elves ... Great Hunger devouring everything. ... If Great Hunger not sated it getting stomach growling. If that happening earth is quaking and trembling. Very dangerous! If ogres die, Great Hunger eating them up. In Great Hunger's stomach ogres waiting to be {born again}." })
keywordHandler:addKeyword({ "born again" }, StdModule.say, { npcHandler = npcHandler, text = "If ogress eating from Great Hunger's {cauldron}, ogress can take in little ogreling. So tribe always getting new ogres from Great Hunger's cauldron." })
keywordHandler:addKeyword({ "chieftain" }, StdModule.say, { npcHandler = npcHandler, text = "Vuzrog {Bloody Skulls} chieftain. Is big boss. Always strongest ogre is chieftain of tribe. Chieftain always mighty and brave. But if chieftain getting old, younger ogre coming, claiming chieftain tent." })
keywordHandler:addKeyword({ "maneaters" }, StdModule.say, { npcHandler = npcHandler, text = "Mhmm. Ogres eating humans, elves, dworcs and goblins. Also cow-men, if getting one. Dwarves being bit chewy and rat-men are stopgap. Not very tasty. Other tribes often eating men. But {Bloody Skulls} now allowing them coming here. ... There human merchant living here. His name Larek. Knows where to get sweets like cookies or candy. If we eat him up, no more sweets. See? Sometimes benefit not to eat visitors. Perhaps you benefit, too. If not, hmmm, we'll eat you." })
keywordHandler:addKeyword({ "cauldron" }, StdModule.say, { npcHandler = npcHandler, text = "Cauldron is one of dried salt seas. At some times in year ogres putting in much, much food: meat, oil, roots, beer - making thick, tasty soup. Then ogres throwing in sacrifices: humans, goblins, elves ... whoever ogres get. ... So Great Hunger is nourished. Then each younger ogress eats from cauldron. Sometimes then she taking in new ogreling waiting in cauldron." })
keywordHandler:addKeyword({ "krailos" }, StdModule.say, { npcHandler = npcHandler, text = "Is name of steppe and grassland you standing in. Where suns standing most high there great mountains. We not knowing what behind. In the middle much grassland, behind that just dry soil. And behind that very, very much salty water. ... Sometimes humans or elves coming from water. Sitting in odd wooden boxes that always breaking at stony shores. We not knowing where they from and why they using odd wooden boxes. Men calling them ships. Sometimes good food in wreckage." })
keywordHandler:addKeyword({ "grubokk" }, StdModule.say, { npcHandler = npcHandler, text = "Ah, pesky bumble! He overseeing goblins working in mines far away in high mountains. Better that way, so he not causing trouble here in village." })
keywordHandler:addKeyword({ "goblins" }, StdModule.say, { npcHandler = npcHandler, text = "Little greenlings. Weak but sometimes useful. Ogres let them getting black stones from mountains. Small tunnels there, ogres not getting in. But small goblins can. And sometimes ogres eating them." })
keywordHandler:addKeyword({ "shaman" }, StdModule.say, { npcHandler = npcHandler, text = "Shaman important for tribe. {Chieftain} says when fighting, where fighting and against who fighting. But shaman caring for spirits. Spirits of steppe and grassland, but also spirits of fathers and mothers. ... Shaman also making sure that {Great Hunger} not getting angry." })
keywordHandler:addKeyword({ "vuzrog" }, StdModule.say, { npcHandler = npcHandler, text = "Vuzrog is {Bloody Skull} tribe {chieftain}. Is strong ogre, but getting old. Ghorza thinking, soon younger ogre will challenge Vuzrog. They will fight. If Vuzrog losing fight, Bloody Skulls having new big boss." })
keywordHandler:addKeyword({ "nibble" }, StdModule.say, { npcHandler = npcHandler, text = "He little goblin. Cooking for {chieftain} and cleaning his tent. Useless." })
keywordHandler:addKeyword({ "mugruu" }, StdModule.say, { npcHandler = npcHandler, text = "Mugruu is ogre here in village. Friend of {chieftain}. Recently he buying things like human trader {Larek}." })
keywordHandler:addKeyword({ "larek" }, StdModule.say, { npcHandler = npcHandler, text = "He tasty little human. Came here some time ago. Wanted to stay, but {Vuzrog} said no. But Larek brought sweets like cookies and candy. Ogres loving sweets but not know how to make. Ghorza this told {chieftain}, so Vuzrog said yes. ... Ghorza loves sweets, too, but also has other reason for deal with Vuzrog and Larek. Human knows useful things. Perhaps could be useful one day." })
npcHandler:setMessage(MESSAGE_GREET, "Hello, scraggy human.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Take care of evil spirits.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Take care of evil spirits.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Of course, just browse through my wares. Or do you want to look only at " .. GetFormattedShopCategoryNames(itemsTable) .. ".")
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
