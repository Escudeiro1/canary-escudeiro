local internalNpcName = "Angelina"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 136,
	lookHead = 57,
	lookBody = 117,
	lookLegs = 118,
	lookFeet = 114,
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

local function greetCallback(npc, creature)
	local player = Player(creature)
	local playerId = player:getId()

	if player:getStorageValue(Storage.Quest.U7_8.MageAndSummonerOutfits.AddonWand) < 1 then
		npcHandler:setMessage(MESSAGE_GREET, "The gods must be praised that I am finally saved. I do not have many worldly possessions, but please accept a small reward, do you?")
	elseif player:getStorageValue(Storage.Quest.U7_8.MageAndSummonerOutfits.AddonWand) >= 1 then
		npcHandler:setMessage(MESSAGE_GREET, "Thanks for saving my life! Should I teleport you out of the Dark Cathedral?")
	end
	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "yes") then
		if player:getStorageValue(Storage.Quest.U7_8.MageAndSummonerOutfits.AddonWand) < 1 then
			npcHandler:say("I will tell you a small secret now. My friend Lynda in Thais can create a blessed wand. Greet her from me, maybe she will aid you.", npc, creature)
			player:setStorageValue(Storage.Quest.U7_8.MageAndSummonerOutfits.AddonWand, 1)
			player:setStorageValue(Storage.OutfitQuest.DefaultStart, 1)
		end
	end

	return true
end

keywordHandler:addKeyword({ "gods" }, StdModule.say, { npcHandler = npcHandler, text = "I'd love to discuss the teachings of the gods with you but this is neither the time nor the place." })
keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "One day this weapon will be unearthed and then it will be wielded against the servants of the evil." })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "He is only one of the many servants of the evil. Eventually he will fall but there will be others to take his place." })
keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "We all have to help to make this world a better place." })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "The druids have their own way to interpret the gods' will and this has to be respected." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Many see Thais as a fallen city but it is only the loudness of an ugly minority that gives people this impression." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "The king is a wise ruler but his realm is large and we all need to work hard to make the world a better place." })
keywordHandler:addKeyword({ "humble path" }, StdModule.say, { npcHandler = npcHandler, text = "There are no records about the foundation of this order, and it is unknown where its 'monks' come from. Yet, travellers told us that they are living near the remains of the dark cathedral." })
keywordHandler:addKeyword({ "ab'dendriel" }, StdModule.say, { npcHandler = npcHandler, text = "The elves have lost their balance and identity. In this unstable state they can easily be misled or might draw the wrong conclusions." })
keywordHandler:addAliasKeyword({ "elves" })
keywordHandler:addKeyword({ "kazordoon" }, StdModule.say, { npcHandler = npcHandler, text = "The dwarves carry bitterness and pain in their souls. But it is them that have forgotten about the gods and not the other way around." })
keywordHandler:addAliasKeyword({ "dwarves" })
keywordHandler:addKeyword({ "ankrahmun" }, StdModule.say, { npcHandler = npcHandler, text = "This city is the best example where godless philosophies might lead to." })
keywordHandler:addKeyword({ "prisoner" }, StdModule.say, { npcHandler = npcHandler, text = "I think Lorbas liked the idea to 'convert' me to their twisted cult and saw it as a test for their leaders. Now that the magic symbols are turned off, I will gather my strength within some hours and teleport to safety." })
keywordHandler:addKeyword({ "darashia" }, StdModule.say, { npcHandler = npcHandler, text = "I know only little about the teachings of Daraman but as far as I heard they concentrate too much on the single individual instead on the world as a whole." })
keywordHandler:addKeyword({ "darama" }, StdModule.say, { npcHandler = npcHandler, text = "A far away continent that will widen our view of the wonders the gods provide us with." })
keywordHandler:addKeyword({ "venore" }, StdModule.say, { npcHandler = npcHandler, text = "Sadly the trade barons care more about wealth than the gods." })
keywordHandler:addKeyword({ "saved" }, StdModule.say, { npcHandler = npcHandler, text = "I'm a priestess and I travelled here to learn about that order of the {humble path} I heard about. ... But when I started my investigations, this false {monk} Lorbas thought that I was suspicious and so he ordered his minions to take me as {prisoner}." })
keywordHandler:addKeyword({ "power" }, StdModule.say, { npcHandler = npcHandler, text = "I've no idea who is the mastermind behind all this, but it seems too big and too well organised to be the work of only a handful of false monks." })
keywordHandler:addKeyword({ "edron" }, StdModule.say, { npcHandler = npcHandler, text = "The downfall of some of the most noble knights there should serve us as a warning to stay on guard for the evil that wants to lure us on the wrong path." })
keywordHandler:addKeyword({ "monk" }, StdModule.say, { npcHandler = npcHandler, text = "I learnt that these monks are impostors that use false promises to lure unwary ones into the arms of their strange cult which seems to have more political than religious agendas." })
npcHandler:setMessage(MESSAGE_FAREWELL, "May the gods bless you.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "May the gods bless you.")

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
