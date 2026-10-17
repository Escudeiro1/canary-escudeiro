local internalNpcName = "Nelly"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 138,
	lookHead = 59,
	lookBody = 5,
	lookLegs = 4,
	lookFeet = 19,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Welcome to the post office!" },
	{ text = "Also selling runes, potions and magical equipment!" },
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
		{ itemName = "avalanche rune", clientId = 3161, buy = 64 },
		{ itemName = "blank rune", clientId = 3147, buy = 10 },
		{ itemName = "chameleon rune", clientId = 3178, buy = 210 },
		{ itemName = "convince creature rune", clientId = 3177, buy = 80 },
		{ itemName = "cure poison rune", clientId = 3153, buy = 65 },
		{ itemName = "destroy field rune", clientId = 3148, buy = 15 },
		{ itemName = "energy field rune", clientId = 3164, buy = 38 },
		{ itemName = "energy wall rune", clientId = 3166, buy = 85 },
		{ itemName = "explosion rune", clientId = 3200, buy = 31 },
		{ itemName = "fire bomb rune", clientId = 3192, buy = 147 },
		{ itemName = "fire field rune", clientId = 3188, buy = 28 },
		{ itemName = "fire wall rune", clientId = 3190, buy = 61 },
		{ itemName = "great fireball rune", clientId = 3191, buy = 64 },
		{ itemName = "heavy magic missile rune", clientId = 3198, buy = 12 },
		{ itemName = "intense healing rune", clientId = 3152, buy = 95 },
		{ itemName = "light magic missile rune", clientId = 3174, buy = 4 },
		{ itemName = "poison field rune", clientId = 3172, buy = 21 },
		{ itemName = "poison wall rune", clientId = 3176, buy = 52 },
		{ itemName = "stalagmite rune", clientId = 3179, buy = 12 },
		{ itemName = "sudden death rune", clientId = 3155, buy = 162 },
		{ itemName = "ultimate healing rune", clientId = 3160, buy = 175 },
	},
	["wands"] = {
		{ itemName = "hailstorm rod", clientId = 3067, buy = 15000 },
		{ itemName = "moonlight rod", clientId = 3070, buy = 1000 },
		{ itemName = "necrotic rod", clientId = 3069, buy = 5000 },
		{ itemName = "northwind rod", clientId = 8083, buy = 7500 },
		{ itemName = "snakebite rod", clientId = 3066, buy = 500 },
		{ itemName = "springsprout rod", clientId = 8084, buy = 18000 },
		{ itemName = "terra rod", clientId = 3065, buy = 10000 },
		{ itemName = "underworld rod", clientId = 8082, buy = 22000 },
		{ itemName = "wand of cosmic energy", clientId = 3073, buy = 10000 },
		{ itemName = "wand of decay", clientId = 3072, buy = 5000 },
		{ itemName = "wand of draconia", clientId = 8093, buy = 7500 },
		{ itemName = "wand of dragonbreath", clientId = 3075, buy = 1000 },
		{ itemName = "wand of inferno", clientId = 3071, buy = 15000 },
		{ itemName = "wand of starstorm", clientId = 8092, buy = 18000 },
		{ itemName = "wand of voodoo", clientId = 8094, buy = 22000 },
		{ itemName = "wand of vortex", clientId = 3074, buy = 500 },
	},
	["post stuff"] = {
		{ itemName = "label", clientId = 3507, buy = 1 },
		{ itemName = "letter", clientId = 3505, buy = 8 },
		{ itemName = "parcel", clientId = 3503, buy = 15 },
	},
	["exercise weapons"] = {
		{ itemName = "durable exercise rod", clientId = 35283, buy = 1250000, count = 1800 },
		{ itemName = "durable exercise wand", clientId = 35284, buy = 1250000, count = 1800 },
		{ itemName = "exercise rod", clientId = 28556, buy = 347222, count = 500 },
		{ itemName = "exercise wand", clientId = 28557, buy = 347222, count = 500 },
		{ itemName = "lasting exercise rod", clientId = 35289, buy = 10000000, count = 14400 },
		{ itemName = "lasting exercise wand", clientId = 35290, buy = 10000000, count = 14400 },
	},
	["others"] = {
		{ itemName = "spellwand", clientId = 651, sell = 299 },
	},
	["shields"] = {
		{ itemName = "spellbook", clientId = 3059, buy = 150 },
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
keywordHandler:addKeyword({ "gods" }, StdModule.say, { npcHandler = npcHandler, text = "This place is godforsaken." })
keywordHandler:addKeyword({ "news" }, StdModule.say, { npcHandler = npcHandler, text = "As if anything you'd get to hear, could be considered new." })
keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "A myth the locals probably enjoy." })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "May his name be cursed." })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "Carlin lost interest in this place quite fast." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Thais has no affairs here." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "I wonder if the king in Thais even knows that this post office exists." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am Nelly ... Any special reason you ask?" })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am working for the local post office. I also happen to have some recently imported potions and runes to sell for a very special price." })
keywordHandler:addKeyword({ "years of serpents" }, StdModule.say, { npcHandler = npcHandler, text = "If only these sea serpents had never disappeared." })
keywordHandler:addKeyword({ "information" }, StdModule.say, { npcHandler = npcHandler, text = "I can explain the {mail} system to you, or how {parcels} and {letters} work. If you want to buy something, ask me for a {trade}." })
keywordHandler:addAliasKeyword({ "help" })
keywordHandler:addKeyword({ "svargrond" }, StdModule.say, { npcHandler = npcHandler, text = "Yes, that's Svargrond. Welcome to the end of the world." })
keywordHandler:addKeyword({ "port hope" }, StdModule.say, { npcHandler = npcHandler, text = "It probably would be even better to be in that backwater town than here." })
keywordHandler:addKeyword({ "barbarian" }, StdModule.say, { npcHandler = npcHandler, text = "Those barbarians are just ruffians with no manners." })
keywordHandler:addKeyword({ "mission" }, StdModule.say, { npcHandler = npcHandler, text = "I don't have anything to do for you. Not even for me. What a boring place!" })
keywordHandler:addAliasKeyword({ "task" })
keywordHandler:addKeyword({ "enemies" }, StdModule.say, { npcHandler = npcHandler, text = "The city seems to be surrounded by enemies. It's just horrible." })
keywordHandler:addKeyword({ "shamans" }, StdModule.say, { npcHandler = npcHandler, text = "Just another name for the same magic users as usual. Probably spying on unsuspecting people like all those magic guys do." })
keywordHandler:addKeyword({ "chakoya" }, StdModule.say, { npcHandler = npcHandler, text = "Those chakoyas are hopefully just a local myth." })
keywordHandler:addKeyword({ "raiders" }, StdModule.say, { npcHandler = npcHandler, text = "Who cares, I would not be that stupid to leave this frozen town anyway." })
keywordHandler:addKeyword({ "nibelor" }, StdModule.say, { npcHandler = npcHandler, text = "I am not sure if it's a real place. Perhaps it's only some myth. Who knows or cares?" })
keywordHandler:addKeyword({ "mail" }, StdModule.say, { npcHandler = npcHandler, text = "With our mail system you can send {letters} and {parcels} to other Tibians. I can give you detailed {information} or sell letters and parcels to you if you ask me for a {trade}." })
keywordHandler:addKeyword({ "druids" }, StdModule.say, { npcHandler = npcHandler, text = "Druids of Carlin come here now and then to meet with the local shaman." })
keywordHandler:addKeyword({ "venore" }, StdModule.say, { npcHandler = npcHandler, text = "I wonder if things were better if Venore ran the mining operations." })
keywordHandler:addKeyword({ "queen" }, StdModule.say, { npcHandler = npcHandler, text = "At least the queen has some representatives here. Not that anyone in Thais would care about this block of ice." })
keywordHandler:addKeyword({ "edron" }, StdModule.say, { npcHandler = npcHandler, text = "What are you suggesting? What do you know ... No, you can't know anything at all. Just forget it." })
keywordHandler:addKeyword({ "dwarf" }, StdModule.say, { npcHandler = npcHandler, text = "It seems even the dwarfs know better than to try their luck here." })
keywordHandler:addKeyword({ "mines" }, StdModule.say, { npcHandler = npcHandler, text = "The loss of the mines doomed this place to complete insignificance." })
keywordHandler:addKeyword({ "chyll" }, StdModule.say, { npcHandler = npcHandler, text = "I think that's how the natives call the wind." })
keywordHandler:addKeyword({ "yeti" }, StdModule.say, { npcHandler = npcHandler, text = "The locals have so many superstitions, who can tell what's the truth and what is a myth." })
keywordHandler:addKeyword({ "cult" }, StdModule.say, { npcHandler = npcHandler, text = "There were several strange people passing through the city some months ago. As far as I heard, they headed to the west and probably died in the cold." })
keywordHandler:addKeyword({ "jarl" }, StdModule.say, { npcHandler = npcHandler, text = "The local authority and the first man here. He seems quite reasonable for a northman to me." })
keywordHandler:addKeyword({ "sell" }, StdModule.say, { npcHandler = npcHandler, text = "I sell parcels, letters, health potions, mana potions and runes." })
npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|, What can I do for you? I'm working for the post office, but I also trade with important {potions}, {runes} and other magical equipment.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ah, the impetuosity of youth.")
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
