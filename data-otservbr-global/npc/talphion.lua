local internalNpcName = "Talphion"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 160,
	lookHead = 27,
	lookBody = 86,
	lookLegs = 126,
	lookFeet = 127,
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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "dress pattern") then
		if player:getStorageValue(Storage.Quest.U7_24.ThePostmanMissions.Mission06) == 3 then
			if npcHandler:getTopic(playerId) < 1 then
				npcHandler:say("DRESS FLATTEN? WHO WANTS ME TO FLATTEN A DRESS?", npc, creature)
				npcHandler:setTopic(playerId, 1)
			elseif npcHandler:getTopic(playerId) == 1 then
				npcHandler:say("A PRESS LANTERN? NEVER HEARD ABOUT IT!", npc, creature)
				npcHandler:setTopic(playerId, 2)
			elseif npcHandler:getTopic(playerId) == 2 then
				npcHandler:say("CHESS? I DONT PLAY CHESS!", npc, creature)
				npcHandler:setTopic(playerId, 3)
			elseif npcHandler:getTopic(playerId) == 3 then
				npcHandler:say("A PATTERN IN THIS MESS?? HEY DON'T INSULT MY MACHINE HALL!", npc, creature)
				npcHandler:setTopic(playerId, 4)
			elseif npcHandler:getTopic(playerId) == 4 then
				npcHandler:say("AH YES! I WORKED ON THE DRESS PATTERN FOR THOSE UNIFORMS. STAINLESS TROUSERES, STEAM DRIVEN BOOTS! ANOTHERMARVEL TO BEHOLD! I'LL SENT A COPY TO KEVIN IMEDIATELY!", npc, creature)
				player:setStorageValue(Storage.Quest.U7_24.ThePostmanMissions.Mission06, 4)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
keywordHandler:addKeyword({ "news" }, StdModule.say, { npcHandler = npcHandler, text = "ASK JIMBIN ABOUT HIS BREWS, NOT ME!" })
keywordHandler:addKeyword({ "army" }, StdModule.say, { npcHandler = npcHandler, text = "ONE DAY OUR MACHINES WILL CHANGE THE ARMY'S STRUCTURE DRASTICALLY, JAWOLL!" })
keywordHandler:addKeyword({ "gods" }, StdModule.say, { npcHandler = npcHandler, text = "GODS, WHO NEEDS GODS, WHEN WE CAN BUILD THE CORRECT MACHINE FOR EVERY OCCASION?" })
keywordHandler:addKeyword({ "monsters" }, StdModule.say, { npcHandler = npcHandler, text = "I COULDN'T CARE LESS ABOUT THEM." })
keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "OLD FASHIONED BUTTERKNIFE! IF THEY LET ME, I WOULD CREATE WEAPONS THAT LEVEL ENTIRE CITIES!" })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "I BET I COULD BUILD A MACHINE TO SHRED HIM INTO PIECES!" })
keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "CAN'T TELL MUCH ABOUT IT. SELDOM GET OUT HERE, I AM A BUSY DWARF." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "ONE DAY I WILL CREATE A CLOCK FOR THE COLOSSUS" })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I HAVE NO TIME FOR A GAME!" })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "WHERE SHOULD I HOP?" })
keywordHandler:addKeyword({ "the big old one" }, StdModule.say, { npcHandler = npcHandler, text = "THIS IS THE NAME OF THIS MOUNTAIN!" })
keywordHandler:addKeyword({ "technomancers" }, StdModule.say, { npcHandler = npcHandler, text = "WE ARE THE FUTURE. WE WILL BECOME A MAJOR POWER IN DWARFEN SOCIETY SOON! THEY WILL SEE, THEY WILL ALL SEE!" })
keywordHandler:addKeyword({ "pyromancers" }, StdModule.say, { npcHandler = npcHandler, text = "OLD FOOLS, TO MUCH CONCERNED ABOUT TRADITION." })
keywordHandler:addAliasKeyword({ "geomancers" })
keywordHandler:addKeyword({ "kazordoon" }, StdModule.say, { npcHandler = npcHandler, text = "WHAT?" })
keywordHandler:addKeyword({ "offering" }, StdModule.say, { npcHandler = npcHandler, text = "YES, THE MOST SOPHISTICATED ITEMS THEY BUY ARE CROSSBOWS." })
keywordHandler:addKeyword({ "emperor" }, StdModule.say, { npcHandler = npcHandler, text = "AT LEAST HES SMART ENOUGH TO LEAVE US ALONE, SO THERES HOPE FOR HIM." })
keywordHandler:addKeyword({ "jimbin" }, StdModule.say, { npcHandler = npcHandler, text = "HIS BREWERY SAVED OUR DAY MORE THEN ONCE IN MANY WAYS." })
keywordHandler:addKeyword({ "maryza" }, StdModule.say, { npcHandler = npcHandler, text = "LOVELY, BUT PREDJUDICED AS MOST DWARFS ARE." })
keywordHandler:addKeyword({ "elves" }, StdModule.say, { npcHandler = npcHandler, text = "NO. I DON'T NEED ANY SHELVES!" })
keywordHandler:addKeyword({ "bezil" }, StdModule.say, { npcHandler = npcHandler, text = "BEZIL AND NEZIL ARE RUNNING A SHOP." })
keywordHandler:addAliasKeyword({ "nezil" })
keywordHandler:addKeyword({ "duria" }, StdModule.say, { npcHandler = npcHandler, text = "KNIGHTS DO NOT HAVE THE BRAIN TO EVEN UNDERSTAND WHAT WE ARE OFFERING THEM." })
keywordHandler:addKeyword({ "etzel" }, StdModule.say, { npcHandler = npcHandler, text = "WHO NEEDS MAGIC? PAH!" })
keywordHandler:addKeyword({ "kroox" }, StdModule.say, { npcHandler = npcHandler, text = "WE COULD TEACH HIM MUCH IF HE LISTENED." })
keywordHandler:addKeyword({ "uzgod" }, StdModule.say, { npcHandler = npcHandler, text = "WE COULD MAKE FOR HIM MACHINES TO DO HIS WORK IN HALF THE TIME I BET." })
keywordHandler:addKeyword({ "durin" }, StdModule.say, { npcHandler = npcHandler, text = "I AM SURE HE WOULD BE SMART ENOUGH TO SEE THE CHANCES WE PROVIDE FOR DWARFENHOOD." })
keywordHandler:addKeyword({ "earth" }, StdModule.say, { npcHandler = npcHandler, text = "SORRY, BUT JUST DUST AND MUD TO ME." })
keywordHandler:addKeyword({ "life" }, StdModule.say, { npcHandler = npcHandler, text = "WHAT HIVE?" })
keywordHandler:addKeyword({ "fire" }, StdModule.say, { npcHandler = npcHandler, text = "NICE RESOURCE FOR OUR MACHINES, BUT NO NEED TO MAKE A BIG DEAL ABOUT IT, JAWOLL!" })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "bolt", clientId = 3446, buy = 5 },
	{ itemName = "crossbow", clientId = 3349, buy = 1150 },
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
