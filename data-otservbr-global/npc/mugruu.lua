local internalNpcName = "Mugruu"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 858,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Come! Look!" },
	{ text = "Buying nice things!" },
	{ text = "Mugruu buys glittering stones and other pretty things." },
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

keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "Always mealtime!" })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Me Mugruu." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Me buying things. Me watching {Larek}. Then me think good idea buying things." })
keywordHandler:addKeyword({ "bloody skulls" }, StdModule.say, { npcHandler = npcHandler, text = "That our tribe. Always battles against {Thunder Tusks}." })
keywordHandler:addKeyword({ "thunder tusks" }, StdModule.say, { npcHandler = npcHandler, text = "Hostile tribe. Try stealing food, {water} and women. Many battles against {Bloody Skulls}." })
keywordHandler:addKeyword({ "great hunger" }, StdModule.say, { npcHandler = npcHandler, text = "Most powerful spirit. Must always get enough food. If not will eat up entire world." })
keywordHandler:addKeyword({ "chieftain" }, StdModule.say, { npcHandler = npcHandler, text = "Chieftain is {Vuzrog}. He big boss of {Bloody Skull} tribe." })
keywordHandler:addKeyword({ "krailos" }, StdModule.say, { npcHandler = npcHandler, text = "That meaning ogre lands. Steppe and grassland. Many fat {clomps}, few {water}." })
keywordHandler:addKeyword({ "mission" }, StdModule.say, { npcHandler = npcHandler, text = "Ask {Ghorza} or {Vuzrog}. Or perhaps ask {Grubokk}, too." })
keywordHandler:addAliasKeyword({ "quest" })
keywordHandler:addAliasKeyword({ "task" })
keywordHandler:addKeyword({ "goblins" }, StdModule.say, { npcHandler = npcHandler, text = "Shrimpy titches good for eating up. Or good for cooking meals and cleaning huts. Many working in mountains. Searching for onyx and opals. Ogres not want searching for themselves. So goblins have to search. {Grubokk} overseeing goblins." })
keywordHandler:addKeyword({ "grubokk" }, StdModule.say, { npcHandler = npcHandler, text = "Grubokk overseeing {goblins}. Sometimes eating them. He strong and always hungry. Nearly as hungry as {chieftain}." })
keywordHandler:addKeyword({ "clomps" }, StdModule.say, { npcHandler = npcHandler, text = "Clomp tasty beast. Much meat, very yummy!" })
keywordHandler:addKeyword({ "ghorza" }, StdModule.say, { npcHandler = npcHandler, text = "She shaman of {Bloody Skulls}. Knowing many things." })
keywordHandler:addKeyword({ "vuzrog" }, StdModule.say, { npcHandler = npcHandler, text = "He big boss of {Bloody Skulls}. That meaning {chieftain}." })
keywordHandler:addKeyword({ "nibble" }, StdModule.say, { npcHandler = npcHandler, text = "Shrimpy {goblin}. Cooking for {Vuzrog}." })
keywordHandler:addKeyword({ "larek" }, StdModule.say, { npcHandler = npcHandler, text = "He shrimpy human. Looking tasty. But had good idea: buying things!" })
keywordHandler:addKeyword({ "water" }, StdModule.say, { npcHandler = npcHandler, text = "Not enough water in {Krailos}. Big problem." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "arrow", clientId = 3447, buy = 3 },
	{ itemName = "blue quiver", clientId = 35848, buy = 400 },
	{ itemName = "bolt", clientId = 3446, buy = 4 },
	{ itemName = "bow", clientId = 3350, buy = 400, sell = 100 },
	{ itemName = "crossbow", clientId = 3349, buy = 500, sell = 120 },
	{ itemName = "crystalline arrow", clientId = 15793, buy = 20 },
	{ itemName = "diamond arrow", clientId = 35901, buy = 130 },
	{ itemName = "drill bolt", clientId = 16142, buy = 12 },
	{ itemName = "earth arrow", clientId = 774, buy = 5 },
	{ itemName = "envenomed arrow", clientId = 16143, buy = 12 },
	{ itemName = "flaming arrow", clientId = 763, buy = 5 },
	{ itemName = "flash arrow", clientId = 761, buy = 5 },
	{ itemName = "ogre choppa", clientId = 22172, sell = 1500 },
	{ itemName = "ogre ear stud", clientId = 22188, sell = 180 },
	{ itemName = "ogre klubba", clientId = 22171, sell = 2500 },
	{ itemName = "ogre nose ring", clientId = 22189, sell = 210 },
	{ itemName = "ogre scepta", clientId = 22183, sell = 3600 },
	{ itemName = "onyx arrow", clientId = 7365, buy = 7 },
	{ itemName = "piercing bolt", clientId = 7363, buy = 5 },
	{ itemName = "power bolt", clientId = 3450, buy = 7 },
	{ itemName = "prismatic bolt", clientId = 16141, buy = 20 },
	{ itemName = "quiver", clientId = 35562, buy = 400 },
	{ itemName = "red quiver", clientId = 35849, buy = 400 },
	{ itemName = "royal spear", clientId = 7378, buy = 15 },
	{ itemName = "shamanic mask", clientId = 22192, sell = 2000 },
	{ itemName = "shamanic talisman", clientId = 22184, sell = 200 },
	{ itemName = "shiver arrow", clientId = 762, buy = 5 },
	{ itemName = "skull fetish", clientId = 22191, sell = 250 },
	{ itemName = "sniper arrow", clientId = 7364, buy = 5 },
	{ itemName = "spear", clientId = 3277, buy = 9, sell = 3 },
	{ itemName = "spectral bolt", clientId = 35902, buy = 70 },
	{ itemName = "tarsal arrow", clientId = 14251, buy = 6 },
	{ itemName = "throwing star", clientId = 3287, buy = 42 },
	{ itemName = "vortex bolt", clientId = 14252, buy = 6 },
}
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
