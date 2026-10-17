local internalNpcName = "A Swan"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookTypeEx = 25445,
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

local ThreatenedDreams = Storage.Quest.U11_40.ThreatenedDreams
local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "mission") then
		if player:getStorageValue(ThreatenedDreams.Mission01[1]) == 11 then
			npcHandler:say({
				"My sister Ikassis sent you? Blessed be her soul! Yes, it is true: I need help. Listen, I will tell you a secret but please don't break it. As you might already suspect I'm not really a swan but a fae. ...",
				"But other than many of my siblings I did not take over a swan's body. I'm a swan maiden and this is one of my two aspects. I can take the shape of a swan as well as that of a young maiden. ...",
				"But to do so I need a magical artefact: a cloak made of swan feathers. If I lose this cloak - or someone steals it from me - I'm stuck to the form of a swan and can't change shape anymore. And this is exactly what happened: ...",
				"A troll stalked me while I was bathing in the river and he stole my cloak. Now I am trapped in the form of a swan. Please, can you find the thief and bring back the cloak?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(ThreatenedDreams.Mission01[1]) == 14 then
			if player:getItemCount(25244) >= 5 then
				player:removeItem(25244, 5)
				player:setStorageValue(ThreatenedDreams.Mission01[1], 15)
				npcHandler:say({
					"This is everything that remained of my cloak? That's terrible! However, I guess I can put the feathers together again. Yes, that should be enough feathers. ...",
					"Please give them to me so I can restore my cloak. But don't watch me! Swan maidens don't like to be observed. Nature's blessings, human being. I will tell Ikassis that you have been of great assistance.",
				}, npc, creature)
				npcHandler:setTopic(playerId, 0)
			else
				npcHandler:say("You need to deliver me like 5 feathers.", npc, creature)
			end
		else
			npcHandler:say("You are not on that mission.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say({
				"Thank you, human being! I guess the thieving troll headed to the mountains east of here. As far as I know you can only reach these mountain tops by diving into a small cave. ...",
				"The connecting tunnels will lead you to a mountain where you may discover him. I heard a man named Jerom talking about this when he passed by this river. Perhaps he knows more about it.",
			}, npc, creature)
			player:setStorageValue(ThreatenedDreams.Mission01[1], 12)
			npcHandler:setTopic(playerId, 0)
		end
	end
	return true
end

keywordHandler:addKeyword({ "news" }, StdModule.say, { npcHandler = npcHandler, text = "The news is that I'm quite desperate right now." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "Time is fluent, traveller." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is not meant to be known by humans." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I have no idea what you mean by this word." })
keywordHandler:addKeyword({ "swan maiden" }, StdModule.say, { npcHandler = npcHandler, text = "We are fae who can shapeshift from human form to swan form. We protect the wilds of our secret realm from every intruder and live in small flocks along secluded lakeshores." })
keywordHandler:addKeyword({ "alkestios" }, StdModule.say, { npcHandler = npcHandler, text = "He's a brother of mine. He took it upon himself to kind of lead our mission in the outside world. You may find him south of Ab'Dendriel." })
keywordHandler:addKeyword({ "siblings" }, StdModule.say, { npcHandler = npcHandler, text = "We call ourselves the fae. Some name us nature spirits or peri but we prefer the former term. Most of us are rather reclusive and live peaceful lives in our secret {realm}. We only leave it in order to {protect} our home. ... As we tend to be secretive about our true nature I'm afraid I can't tell you more." })
keywordHandler:addKeyword({ "feyrist" }, StdModule.say, { npcHandler = npcHandler, text = "It's a secret, hidden place. Only very few mortals get permission to enter it. A long time ago, we learned how to hide our realm from the outside world. Only if you gain our trust you will get permission to enter it." })
keywordHandler:addKeyword({ "protect" }, StdModule.say, { npcHandler = npcHandler, text = "Dark energies are seeping into the world. They are tainting our home as much as everything else. We couldn't discover the origin of these energies on Feyrist itself, Therefore, some of us decided to leave our home and investigate." })
keywordHandler:addKeyword({ "ikassis" }, StdModule.say, { npcHandler = npcHandler, text = "She's one of my sisters who took over the body of a snake. You can find her northwest of here." })
keywordHandler:addKeyword({ "dreams" }, StdModule.say, { npcHandler = npcHandler, text = "There is far more to dreams than mortal beings are aware of. They possess some kind of magical power, ancient and mysterious. I shouldn't tell you too much about it, but I can tell you that the fae are closely linked to this power." })
keywordHandler:addKeyword({ "realm" }, StdModule.say, { npcHandler = npcHandler, text = "We call it Feyrist and it is a secret, hidden place. Only very few mortals get permission to enter it. A long time ago, we learnt how to hide our realm from the outside world. Only if you gain our trust you will get permission to enter it." })
npcHandler:setMessage(MESSAGE_GREET, "I salute you, mortal being.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
