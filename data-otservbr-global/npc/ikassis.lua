local internalNpcName = "Ikassis"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 28,
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
	{ text = "Perhaps we shouldn't have come here." },
	{ text = "I pity this poor mother." },
	{ text = "The wildlife is troubled." },
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

local ThreatenedDreams = Storage.Quest.U11_40.ThreatenedDreams
local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "mission") then
		if player:getStorageValue(ThreatenedDreams.Mission01[1]) == 4 then
			npcHandler:say({
				"One of my sisters, in the disguise of a nightingale, told me that Alkestios would send you. There is a problem which is not concerning me but a wolf mother on the small island Cormaya. ...",
				"As we, the fae, consider ourselves guardians and protectors of plants and animals, it is important for me to help this wolf. Unfortunately, I can't do it myself because at the moment I'm bound to this vessel, this snake. ...",
				"Thus I can't cross the ocean to reach Cormaya. Will you help me?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(ThreatenedDreams.Mission01[1]) == 10 then
			npcHandler:say("The wolf's ghost has found peace. Thank you, human being. However, there is someone else who needs help: A sister of mine who's bereft of something very precious. You'll find her in the guise of a swan at a small river south-east of here.", npc, creature)
			player:setStorageValue(ThreatenedDreams.Mission01[1], 11)
			npcHandler:setTopic(playerId, 0)
		else
			npcHandler:say("You are not on that mission.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say({
				"Nature's blessings! You may find the desperate wolf mother in the south of Cormaya. You will know the place because there is a big stone that looks like a grumpy face. ...",
				"At night it will weep bloody tears and only at night you will meet the ghost there. Take this talisman so you may be able to talk with animals and even plants and stones. Just don't expect that all of them will answer you.",
			}, npc, creature)
			player:setStorageValue(ThreatenedDreams.Mission01[1], 5)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "no") then
		npcHandler:say("Then not.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	end
	return true
end

keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "It's a place full of stone buildings and mortal beings. I guess you call it a town. But I'm still not sure which purpose it serves." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "Time is a human concept, traveler." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Ikassis. It means ,the long-sighted'." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Job? I have no idea what this peculiar word could mean." })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "It's a place full of stone buildings and mortal beings. I guess you call it a town. But I'm still not sure which purpose it serves." })
keywordHandler:addAliasKeyword({ "venore" })
keywordHandler:addAliasKeyword({ "darashia" })
keywordHandler:addAliasKeyword({ "edron" })
keywordHandler:addKeyword({ "ab'dendriel" }, StdModule.say, { npcHandler = npcHandler, text = "It's a place full of life, huge trees, lush plants and various animals. I visited it once when {Alkestios} took me there. It is a place of beauty." })
keywordHandler:addKeyword({ "kazordoon" }, StdModule.say, { npcHandler = npcHandler, text = "It is located somewhere in the mountains, I guess." })
keywordHandler:addKeyword({ "roshamuul" }, StdModule.say, { npcHandler = npcHandler, text = "This is a dark and dangerous place. It is full of terrible monsters and made of nightmares - literally." })
keywordHandler:addKeyword({ "oramond" }, StdModule.say, { npcHandler = npcHandler, text = "I have never heard of this place." })
keywordHandler:addAliasKeyword({ "rathleton" })
keywordHandler:addAliasKeyword({ "krailos" })
keywordHandler:addKeyword({ "alkestios" }, StdModule.say, { npcHandler = npcHandler, text = "He's a brother of mine. He took it upon himself to kind of lead our {mission} in the outside world. You may find him south of {Ab'Dendriel}." })
keywordHandler:addKeyword({ "siblings" }, StdModule.say, { npcHandler = npcHandler, text = "We call ourselves the fae. Some name us nature spirits or peri but we prefer the former term. Most of us are rather reclusive and live peaceful lives in our secret {realm}. We only leave it in order to {protect} our home. ... As we tend to be secretive about our true nature I'm afraid I can't tell you more." })
keywordHandler:addKeyword({ "feyrist" }, StdModule.say, { npcHandler = npcHandler, text = "It is a secret, hidden place. Just few mortals get permission to enter it. A long time ago, we learned how to hide our realm from the outside world. Only if you gain our trust I will tell you how to reach it." })
keywordHandler:addKeyword({ "protect" }, StdModule.say, { npcHandler = npcHandler, text = "A strange dark {energy} is seeping into our world lately. It is pervading all continents and islands and it grows stronger with every day. Yet I don't know where it arises from nor what we could do to dispel it." })
keywordHandler:addKeyword({ "dwarves" }, StdModule.say, { npcHandler = npcHandler, text = "We know them, yes. Their {dreams} are different from those of {elves} and {humans}. Somehow graver and more grounded." })
keywordHandler:addKeyword({ "darama" }, StdModule.say, { npcHandler = npcHandler, text = "I guess it's a desert." })
keywordHandler:addKeyword({ "energy" }, StdModule.say, { npcHandler = npcHandler, text = "It is still somewhat in hiding, so most creatures won't sense it ... yet. But its corrosive power has already begun to affect my kind and our hidden {realm} in unpleasant ways." })
keywordHandler:addKeyword({ "dreams" }, StdModule.say, { npcHandler = npcHandler, text = "There is far more to dreams than mortal beings are aware of. They possess some kind of magical power, ancient and mysterious. I shouldn't tell you too much about it, but I can tell you that the fae are closely linked to this power." })
keywordHandler:addKeyword({ "humans" }, StdModule.say, { npcHandler = npcHandler, text = "They inhabit these huge places filled with stone buildings. They call them towns, I guess. Some of them are cheerful and well-meaning, others are wicked and cruel. Their traits and attitudes vary greatly - and so do their {dreams}." })
keywordHandler:addKeyword({ "realm" }, StdModule.say, { npcHandler = npcHandler, text = "We call it Feyrist and it is a secret, hidden place. Just few mortals get permission to enter it. A long time ago, we learned how to hide our realm from the outside world. Only if you gain our trust I will tell you how to reach it." })
keywordHandler:addKeyword({ "elves" }, StdModule.say, { npcHandler = npcHandler, text = "They inhabit {Ab'Dendriel} and live in close touch with nature. Their {dreams} are mostly serene and suffused with light." })
keywordHandler:addKeyword({ "snake" }, StdModule.say, { npcHandler = npcHandler, text = "Outside of our secret {realm} my {siblings} and I can't keep our true shape. If we want to travel other parts of the world, we must take over the bodies of animals. But we are causing them no harm and we just take control if necessary." })
npcHandler:setMessage(MESSAGE_GREET, "Nature's blessing, traveler!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
