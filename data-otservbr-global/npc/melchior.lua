local internalNpcName = "Melchior"
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
	lookHead = 0,
	lookBody = 25,
	lookLegs = 59,
	lookFeet = 115,
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
	local playerId = creature:getId()
	npcHandler:setMessage(MESSAGE_GREET, Player(creature):getSex() == PLAYERSEX_FEMALE and "Welcome, |PLAYERNAME|! The lovely sound of your voice shines like a beam of light through my solitary darkness!" or "Greetings, |PLAYERNAME|. I do not see your face, but I can read a thousand things in your voice!")
	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "word of greeting") then
		if player:getStorageValue(Storage.Quest.U7_4.DjinnWar.Faction.Greeting) ~= 0 then
			npcHandler:say({
				"The djinns have an ancient code of honour. This code includes a special concept of hospitality. Anybody who utters the word of greeting must not be attacked even if he is an enemy. Well, at least that is what the code says. ...",
				"I have found out, though, that this does not work at all times. There is no point to say the word of greeting to an enraged djinn. ...",
				"I can tell you the word of greeting if you're interested. It is {DJANNI'HAH}. Remember this word well, stranger. It might save your life one day. ...",
				"And keep in mind that you must choose sides in this conflict. You can only follow the Efreet or the Marid - once you have made your choice there is no way back. I know from experience that djinn do not tolerate double-crossing.",
			}, npc, creature)

			if player:getStorageValue(Storage.Quest.U7_4.DjinnWar.Factions) ~= 1 then
				player:setStorageValue(Storage.Quest.U7_4.DjinnWar.Factions, 1)
			end
			player:setStorageValue(Storage.Quest.U7_4.DjinnWar.Faction.Greeting, 1)
		end
	end

	return true
end

keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "Tibia is such a beautiful place. I would give it all if I could see it again." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My late father, may he rest in peace, chose to call me Melchior." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am a poor beggar. I try to make a meagre living here since a cruel fate has left me a blind man." })
keywordHandler:addKeyword({ "ashta'daramai" }, StdModule.say, { npcHandler = npcHandler, text = "Aah yes - the Marids' fortress. Perched high on the Kha'zeel, it is a marvel to behold. They say Gabel built it on the ruins of his original palace." })
keywordHandler:addKeyword({ "old pharaoh" }, StdModule.say, { npcHandler = npcHandler, text = "The old pharaoh? I keep on hearing {rumours} about him, but I do not know if they are true." })
keywordHandler:addKeyword({ "mal'ouquah" }, StdModule.say, { npcHandler = npcHandler, text = "That is the Efreet's gloomy fortress, home of Malor, hidden high up in the Kha'zeel mountains. I used to go there often. Don't make the same mistake, stranger! I would love to think there is somebody who profited from the lesson I had to learn!" })
keywordHandler:addKeyword({ "ankrahmun" }, StdModule.say, { npcHandler = npcHandler, text = "I hate this city. Period. I would never have come here, but I haven't had much of a choice. The caravan that picked me up in the Kha'zeel was headed for this place, and I was glad enough they brought me here. ... But now I really wish I could leave. These people and their ruler give me the creeps!" })
keywordHandler:addKeyword({ "ascension" }, StdModule.say, { npcHandler = npcHandler, text = "The concept of ascension is central to the pharaoh's creed. I am not sure I really understand it, but apparently it has to do with transformation to undeath. Nice, isn't it?" })
keywordHandler:addKeyword({ "fa'hradin" }, StdModule.say, { npcHandler = npcHandler, text = "I know that name. He is a Marid, right? I have met him once. He seemed pretty important." })
keywordHandler:addKeyword({ "kazordoon" }, StdModule.say, { npcHandler = npcHandler, text = "I have never been to cities on other continents. And I suppose now I never will. I would be glad enough to leave this place." })
keywordHandler:addKeyword({ "kha'zeel" }, StdModule.say, { npcHandler = npcHandler, text = "That is the name of the huge mountain range to the west of the great desert, the Kha'labal. That's where you will find the djinns' fortresses Ashta'daramai and Mal'ouquah." })
keywordHandler:addKeyword({ "darashia" }, StdModule.say, { npcHandler = npcHandler, text = "Aah yes... Darashia. I would give anything if I could see it again." })
keywordHandler:addKeyword({ "bas'saam" }, StdModule.say, { npcHandler = npcHandler, text = "Yes, I know him. He is an Efreet trader. I met him often during my travels, and even though there was no real sympathy we had a certain mutual respect for each other. But all that changed when he found out I had dealings with the Marid." })
keywordHandler:addKeyword({ "daraman" }, StdModule.say, { npcHandler = npcHandler, text = "Daraman was a holy man, a true prophet. He showed us how we can master grief and affliction through dignity and brotherliness. It is a shame I only came to fully appreciate his teachings when fate had cast me into darkness." })
keywordHandler:addKeyword({ "ruler" }, StdModule.say, { npcHandler = npcHandler, text = "The pharaoh? He is always in the palace, so I have heard only rumors about him. But I know one thing for sure - he is mad. End of story." })
keywordHandler:addAliasKeyword({ "pharaoh" })
keywordHandler:addKeyword({ "scarabs" }, StdModule.say, { npcHandler = npcHandler, text = "Those damn scavengers! I detest them. When I was stumbling through the desert, all blind and desperate, they followed me around. ... They watched my every step, waiting for me to give up and die. But I never did. Damn vermin! You'll have to eat somebody else!" })
keywordHandler:addKeyword({ "efreet" }, StdModule.say, { npcHandler = npcHandler, text = "Beware the Efreet, stranger! They hate all humans, and if they had their way all of us would be killed. If you meet one be sure to say the word of greeting immediately because otherwise you will be killed in a heartbeat. ... And do not approach them if you are a follower of the Marid - they are impossible to fool!" })
keywordHandler:addKeyword({ "rumour" }, StdModule.say, { npcHandler = npcHandler, text = "It is said the son of the old pharaoh, the present pharaoh, killed him and turned him into some ghastly undead!" })
keywordHandler:addAliasKeyword({ "rumor" })
keywordHandler:addKeyword({ "palace" }, StdModule.say, { npcHandler = npcHandler, text = "The palace lies to the south of the arena and to the west of the temple. Better stay clear of that place. If but half the things I have heard about it are true this palace is not a place for the living anymore." })
keywordHandler:addKeyword({ "temple" }, StdModule.say, { npcHandler = npcHandler, text = "That temple is very old, and for centuries it used to be a place of worship and of contemplation. Now that the priests there are fanatic followers of the pharaoh this is no longer a holy place." })
keywordHandler:addKeyword({ "alesar" }, StdModule.say, { npcHandler = npcHandler, text = "I know that name. He is a Marid. This djinn is one of the best smiths ever to live. You should see the scimitars he makes - hard as titanium yet light as a desert breeze. ... I kept on trying to get the Marid to sell one to me, but they never did. Too bad - I could have made a fortune." })
keywordHandler:addKeyword({ "haroun" }, StdModule.say, { npcHandler = npcHandler, text = "A Marid trader. I have often had dealings with him. He drove me mad because he never accepted any haggling, but then he never ever tried to trick me. He was not really a trader at heart, I suppose. He was more of a monk or maybe a preacher." })
keywordHandler:addKeyword({ "blind" }, StdModule.say, { npcHandler = npcHandler, text = "Yes, I am. I was not born that way, but a cruel fate caused me to lose my eyesight." })
keywordHandler:addKeyword({ "marid" }, StdModule.say, { npcHandler = npcHandler, text = "The Marid are gentle, kind-hearted djinn, or at least that is how they act towards humans. However, they are quite reclusive, too. They will not talk to human unless he says the word of greeting first. ... And do not approach them if you are a follower of the Efreet - they are impossible to fool!" })
keywordHandler:addKeyword({ "gabel" }, StdModule.say, { npcHandler = npcHandler, text = "He is the leader of the Marid! I have never met him myself, but everybody was full of praise for him back at Ashta'daramai. The legend has it that it was him who introduced the djinns to wise Daraman's teachings." })
keywordHandler:addKeyword({ "malor" }, StdModule.say, { npcHandler = npcHandler, text = "Malor is the Efreets' leader. He is perhaps not the strongest of all efreet, but his treachery and cruelty are certainly unrivalled. He was defeated a long, long time ago, but he was not killed. ... I don't know why... I have a strange feeling of foreboding whenever I hear his name." })
keywordHandler:addKeyword({ "arena" }, StdModule.say, { npcHandler = npcHandler, text = "Ah yes, the arena. I do not really know what's going on there, because I have never seen it myself. However, I often hear strange noises from there, cheers and jeers and sometimes pityful screams." })
keywordHandler:addKeyword({ "uthun" }, StdModule.say, { npcHandler = npcHandler, text = "According to the pharaoh's teachings this is the total of a living being's memories and personal experiences." })
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell, stranger. May Uman the Wise guide your steps in this treacherous land.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Farewell, stranger. May Uman the Wise guide your steps in this treacherous land.")

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
