local internalNpcName = "Santiago"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 151,
	lookHead = 38,
	lookBody = 115,
	lookLegs = 87,
	lookFeet = 114,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Evil little beasts... I hope someone helps me fight them." },
	{ text = "Nasty creepy crawlies!" },
	{ text = "Hey! You over there, could you help me with a little quest? Just say 'hi' or 'hello' to talk to me!" },
	{ text = "Don't be shy, can't hurt to greet me with 'hello' or 'hi'!" },
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

local storeTalkCid = {}
local function greetCallback(npc, creature)
	local player = Player(creature)
	local playerId = player:getId()

	if player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage) < 1 then
		player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage, 1)
		player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoQuestLog, 1)
		npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|, nice to see you on Rookgaard! I saw you walking by and wondered if you could help me. Could you? Please, say {yes}!")
		storeTalkCid[playerId] = 0
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage) == 1 then
		npcHandler:setMessage(MESSAGE_GREET, "Oh, |PLAYERNAME|, it's you again! It's probably impolite to disturb a busy adventurer like you, but I really need help. Please, say {yes}!")
		storeTalkCid[playerId] = 0
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage) == 2 then
		npcHandler:say("Oh, what's wrong? As I said, simply go to my house south of here and go upstairs. Then come back and we'll continue our chat.", npc, creature)
		Position(32033, 32277, 6):sendMagicEffect(CONST_ME_TUTORIALARROW)
		return false
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage) == 3 then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome back, |PLAYERNAME|! Ahh, you found my chest. Let me take a look at you. You put on that coat, {yes}?")
		storeTalkCid[playerId] = 2
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage) == 4 then
		npcHandler:setMessage(MESSAGE_GREET, "Hey, I want to give you a weapon for free! You should not refuse that, in fact you should say '{yes}'!")
		storeTalkCid[playerId] = 2
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage) == 5 then
		npcHandler:say("I've forgotten to tell you something. Of course I need proof that you killed cockroaches. Please bring me at least 3 of their legs. Good luck!", npc, creature)
		return false
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage) == 6 then
		if player:removeItem(7882, 3) then
			npcHandler:setMessage(MESSAGE_GREET, "Good job! For that, I'll grant you 100 experience points! Oh - what was that? I think you advanced a level, {right}?")
			player:addExperience(100, true)
			player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoQuestLog, 5)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage, 7)
			storeTalkCid[playerId] = 4
		else
			npcHandler:say("I've forgotten to tell you something. Of course I need proof that you killed cockroaches. Please bring me at least 3 of their legs. Good luck!", npc, creature)
			return false
		end
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage) == 7 then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome back! Where were we... ? Ah, right, I asked you if you saw your 'level up'! You did, {right}?")
		storeTalkCid[playerId] = 4
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage) == 8 then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome back! Where were we... ? Ah, right, I asked you if those nasty cockroaches {hurt} you! Did they?")
		storeTalkCid[playerId] = 5
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage) == 9 then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome back! Where were we... ? Ah, right, I asked you if I should demonstrate some damage on you. Let's do it, {okay}?")
		storeTalkCid[playerId] = 6
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage) == 10 then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome back! Where were we... ? Ah, right, I was about to show you how you regain health, right?")
		storeTalkCid[playerId] = 7
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage) == 11 then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome back! Where were we... ? Ah, right, I gave you a fish to eat?")
		storeTalkCid[playerId] = 8
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage) == 12 then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome back! Where were we... ? Ah, right, I asked you if you saw Zirella! Did you?")
		storeTalkCid[playerId] = 9
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage) == 13 then
		npcHandler:setMessage(MESSAGE_GREET, "Hello again, |PLAYERNAME|! It's great to see you. If you like, we can chat a little. Just use the highlighted {keywords} again to choose a {topic}.")
	end
	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if table.contains({ "yes", "right", "ok" }, message) then
		if storeTalkCid[playerId] == 0 then
			npcHandler:say("Great, please go to my house, just a few steps south of here. Upstairs in my room, you'll find a chest. You can keep what you find inside of it! Come back after you got it and greet me to talk to me again. {Yes}?", npc, creature)
			Position(32033, 32277, 6):sendMagicEffect(CONST_ME_TUTORIALARROW)
			storeTalkCid[playerId] = 1
		elseif storeTalkCid[playerId] == 1 then
			npcHandler:say("Alright! Do you see the button called 'Quest Log'? There you can check the status of quests, like this one. {Bye} for now!", npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage, 2)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoQuestLog, 2)
			player:sendTutorial(3)
			npcHandler:removeInteraction(npc, creature)
			npcHandler:resetNpc(creature)
		elseif storeTalkCid[playerId] == 2 then
			if player:getItemCount(3562) > 0 then
				local coatSlot = player:getSlotItem(CONST_SLOT_ARMOR)
				if coatSlot then
					npcHandler:say("Ah, no need to say anything, I can see it suits you perfectly. Now we're getting to the fun part, let's get you armed! Are you ready for some {action}?", npc, creature)
					player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage, 4)
					storeTalkCid[playerId] = 3
				else
					npcHandler:say("Oh, you don't wear it properly yet. You need to drag and drop it from your bag to your armor slot. Here, let me show you again. Is it a little {clearer} now?", npc, creature)
					player:sendTutorial(5)
					storeTalkCid[playerId] = 2
				end
			else
				player:addItem(3562, 1)
				npcHandler:say("Oh no, did you lose my coat? Well, lucky you, I have a spare one here. Don't lose it again! Now we're getting to the fun part, let's get you armed! Are you ready for some {action}?", npc, creature)
				storeTalkCid[playerId] = 3
			end
		elseif storeTalkCid[playerId] == 3 then
			npcHandler:say("I knew I could count on you. Here, take this good and sturdy weapon in your hand. Then go back to my house and down the ladder. Good luck, and {bye} for now!", npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoQuestLog, 4)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage, 5)
			Position(32036, 32277, 6):sendMagicEffect(CONST_ME_TUTORIALARROW)
			player:addItem(3270, 1)
			npcHandler:removeInteraction(npc, creature)
			npcHandler:resetNpc(creature)
		elseif storeTalkCid[playerId] == 4 then
			npcHandler:say("That's just great! Now you have more health points, can carry more stuff and walk faster. Talking about health, did you get {hurt} by those cockroaches?", npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage, 8)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoQuestLog, 6)
			storeTalkCid[playerId] = 5
		elseif storeTalkCid[playerId] == 5 then
			npcHandler:say("Really? You look fine to me, must have been just a scratch. Well, there are much more dangerous monsters than cockroaches out there. Take a look at your status bar. You have 155 Health right now. I'll show you something, {yes}?", npc, creature)
			player:sendTutorial(19)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage, 9)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoQuestLog, 7)
			storeTalkCid[playerId] = 6
		elseif storeTalkCid[playerId] == 6 then
			npcHandler:say("This is an important lesson from me - an experienced veteran fighter. Take this! Look at your status bar again. As you can see, you've lost health. Now I'll tell you how to heal that, {yes}?", npc, creature)
			player:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
			npc:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
			player:addHealth(-20, COMBAT_PHYSICALDAMAGE)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage, 10)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoQuestLog, 8)
			player:sendTutorial(19)
			storeTalkCid[playerId] = 7
		elseif storeTalkCid[playerId] == 7 then
			npcHandler:say({
				"Here, take this fish which I've caught myself. Find it in your inventory, then 'Use' it to eat it. This will slowly refill your health. ...",
				"By the way: If your hitpoints are below 150, you will regenerate back to 150 hitpoints after few seconds as long as you are not hungry, outside a protection zone and do not have a battle sign. {Easy}, yes?",
			}, npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoQuestLog, 9)
			player:addItem(3578, 1)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage, 11)
			storeTalkCid[playerId] = 8
		elseif storeTalkCid[playerId] == 8 then
			npcHandler:say("I knew you'd get it right away. You can loot food from many creatures, such as deer and rabbits. You can find them in the forest nearby. By the way... have you seen {Zirella}?", npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage, 12)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoQuestLog, 10)
			storeTalkCid[playerId] = 9
		elseif storeTalkCid[playerId] == 9 then
			npcHandler:say("Really?? She was looking for someone to help her. Maybe you could go and see her. She lives just to the east and down the mountain. So, thank you again and {bye} for now!", npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage, 13)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoQuestLog, 11)
			player:addMapMark(Position(32045, 32270, 6), MAPMARK_GREENSOUTH, "To Zirella")
			npcHandler:removeInteraction(npc, creature)
			npcHandler:resetNpc(creature)
		end
	elseif MsgContains(message, "hurt") then
		if storeTalkCid[playerId] == 6 then
			npcHandler:say("This is an important lesson from me - an experienced veteran fighter. Take this! Look at your status bar again. As you can see, you've lost health. Now I'll tell you how to heal that, {yes}?", npc, creature)
			player:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
			npc:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
			player:addHealth(-20, COMBAT_PHYSICALDAMAGE)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage, 8)
			player:sendTutorial(19)
			storeTalkCid[playerId] = 7
		end
	elseif MsgContains(message, "action") then
		if storeTalkCid[playerId] == 3 then
			npcHandler:say("I knew I could count on you. Here, take this good and sturdy weapon in your hand. Then go back to my house and down the ladder. Good luck, and {bye} for now!", npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoQuestLog, 4)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage, 5)
			Position(32036, 32277, 6):sendMagicEffect(CONST_ME_TUTORIALARROW)
			player:addItem(3270, 1)
			npcHandler:removeInteraction(npc, creature)
			npcHandler:resetNpc(creature)
		end
	elseif MsgContains(message, "easy") then
		if storeTalkCid[playerId] == 8 then
			npcHandler:say("I knew you'd get it right away. You can loot food from many creatures, such as deer and rabbits. You can find them in the forest nearby. By the way... have you seen {Zirella}?", npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoNpcGreetStorage, 11)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.SantiagoQuestLog, 10)
			storeTalkCid[playerId] = 9
		end
	end
	return true
end

local function onReleaseFocus(npc, creature)
	local playerId = creature:getId()
	storeTalkCid[playerId] = nil
end

npcHandler:setCallback(CALLBACK_REMOVE_INTERACTION, onReleaseFocus)

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
keywordHandler:addKeyword({ "explorer society" }, StdModule.say, { npcHandler = npcHandler, text = "The explorer society has always work for brave adventurers. You can join them in Port Hope or Northport once you arrive on the main continent." })
keywordHandler:addKeyword({ "adventures" }, StdModule.say, { npcHandler = npcHandler, text = "You'll experience more than enough adventures soon enough, I'm sure! You look young and strong, Tibia awaits you!" })
keywordHandler:addKeyword({ "experience" }, StdModule.say, { npcHandler = npcHandler, text = "Earning experience and gaining levels will make you stronger. It's all about power in Tibia!" })
keywordHandler:addKeyword({ "cockroach" }, StdModule.say, { npcHandler = npcHandler, text = "Every morning, I'm missing about a dozen fishes. Once, I've seen one of those beasts nibbling on a fish! They are SO disgusting!" })
keywordHandler:addKeyword({ "merchants" }, StdModule.say, { npcHandler = npcHandler, text = "We have a weapon smith called Obi, Dixi is selling armors and Al Dee is offering general tools. Also, you can buy potions from Lily. I think those are the most important people to trade with." })
keywordHandler:addKeyword({ "fisherman" }, StdModule.say, { npcHandler = npcHandler, text = "To be a fisherman, you only need a fishing rod and worms. You can become one too! Fishing rods can be bought in all cities, even in Rookgaard." })
keywordHandler:addKeyword({ "svargrond" }, StdModule.say, { npcHandler = npcHandler, text = "There was a huge fuzz about it. Actually no one ever knew that it existed until a while ago when the sea serpents which had blocked the sea passage there suddenly disappeared ... Nowadays there is a barbarian settlement, and I heard that you need to win a drinking contest to become an inhabitant! Now that's something! ... Also, there are many different types of fish. They catch them through ice holes there." })
keywordHandler:addKeyword({ "port hope" }, StdModule.say, { npcHandler = npcHandler, text = "That's a small settlement in the south of Tibia. The jungle of Tiquanda is all around it. There are many places to discover like {Banuta}, {Trapwood} or {Chor}." })
keywordHandler:addKeyword({ "northport" }, StdModule.say, { npcHandler = npcHandler, text = "That's a very small village near one of the main cities, Carlin. I considered living there because it's almost as quiet as Rookgaard." })
keywordHandler:addKeyword({ "keywords" }, StdModule.say, { npcHandler = npcHandler, text = "Right, this was a keyword. But actually there are more interesting topics to talk about." })
keywordHandler:addKeyword({ "rookgaard" }, StdModule.say, { npcHandler = npcHandler, text = "We are currently south of the village of Rookgaard, just follow the path to the east. Once you are there, you will meet many other {citizens}." })
keywordHandler:addKeyword({ "vocation" }, StdModule.say, { npcHandler = npcHandler, text = "The Tibian vocations are {knight}, {paladin}, {sorcerer} and {druid}, each of them has its own specialities." })
keywordHandler:addKeyword({ "sorcerer" }, StdModule.say, { npcHandler = npcHandler, text = "Sorcerers are elemental magic users, specialised in fire, energy and death magic." })
keywordHandler:addKeyword({ "monsters" }, StdModule.say, { npcHandler = npcHandler, text = "Here on Rookgaard, we are lucky that the monsters threatening our village are rather weak. I wouldn't want to have the {dragons} and {demons} of the main continent here!" })
keywordHandler:addKeyword({ "citizens" }, StdModule.say, { npcHandler = npcHandler, text = "Most of the citizens are {merchants}. We have also two {guards} and a {healer}, and a {teacher} in our academy." })
keywordHandler:addKeyword({ "trapwood" }, StdModule.say, { npcHandler = npcHandler, text = "Wild horses couldn't drag me there!! Evil little beasts called dworcs live there. They use a weird type of voodoo magic." })
keywordHandler:addKeyword({ "dallheim" }, StdModule.say, { npcHandler = npcHandler, text = "He's a great warrior. He can also tell you much about monsters and dungeons on this island." })
keywordHandler:addAliasKeyword({ "zerbrus" })
keywordHandler:addKeyword({ "cipfried" }, StdModule.say, { npcHandler = npcHandler, text = "Visiting Cipfried is a good idea if you are badly injured or poisoned. Just ask him for a heal." })
keywordHandler:addKeyword({ "paladin" }, StdModule.say, { npcHandler = npcHandler, text = "Paladins are distance fighters and holy magic users. They outrun their enemies and shoot them with arrows or bolts." })
keywordHandler:addKeyword({ "dragons" }, StdModule.say, { npcHandler = npcHandler, text = "You'll never forget your first dragon. That is true even after all those years. Fierce beasts they are!" })
keywordHandler:addKeyword({ "stories" }, StdModule.say, { npcHandler = npcHandler, text = "There are so many things I could tell you, I don't even know where to start! My best stories are about {Svargrond} and the {explorer society}." })
keywordHandler:addKeyword({ "teacher" }, StdModule.say, { npcHandler = npcHandler, text = "The teacher of the academy is called Seymour. The academy is just north of the temple." })
keywordHandler:addKeyword({ "seymour" }, StdModule.say, { npcHandler = npcHandler, text = "Seymour is a teacher running the academy. He has many important information about Tibia." })
keywordHandler:addKeyword({ "warrior" }, StdModule.say, { npcHandler = npcHandler, text = "Well, everybody is a 'warrior' in general. You can choose between four {vocations} once you are level 8." })
keywordHandler:addKeyword({ "knight" }, StdModule.say, { npcHandler = npcHandler, text = "Knights are strong melee fighters. They usually use weapons such as swords, clubs or axes." })
keywordHandler:addKeyword({ "cities" }, StdModule.say, { npcHandler = npcHandler, text = "There are many cities on the main continent, much bigger than our little village here. You should visit all of them!" })
keywordHandler:addKeyword({ "demons" }, StdModule.say, { npcHandler = npcHandler, text = "There are numerous different demons all over Tibia. They mostly hide deep in dungeons, but sometimes they dare entering the human realm." })
keywordHandler:addKeyword({ "gossip" }, StdModule.say, { npcHandler = npcHandler, text = "Did you hear that story about me catching this HUUUUGE fish?! It was so big that I couldn't pull it on board of my ship... and... and ..." })
keywordHandler:addKeyword({ "guards" }, StdModule.say, { npcHandler = npcHandler, text = "The bridge guards Dallheim and Zerbrus can tell you which monsters are suitable for your level and where to find them." })
keywordHandler:addKeyword({ "healer" }, StdModule.say, { npcHandler = npcHandler, text = "Our healer is called Cipfried. He guards the temple." })
keywordHandler:addKeyword({ "pirate" }, StdModule.say, { npcHandler = npcHandler, text = "Oh, that life is over. I've settled down. Fighting against those {cockroaches} is the only excitement I have nowadays, and that's already enough!" })
keywordHandler:addKeyword({ "banuta" }, StdModule.say, { npcHandler = npcHandler, text = "That is the name of the ape town. They say there is an ape who can talk! I don't believe that, harharhar!" })
keywordHandler:addKeyword({ "al dee" }, StdModule.say, { npcHandler = npcHandler, text = "Al Dee sells tools such as torches, ropes and shovels. You will learn about them soon!" })
keywordHandler:addKeyword({ "oracle" }, StdModule.say, { npcHandler = npcHandler, text = "Oh, you're a bit young to hear about the oracle. Be patient, you'll learn everything in time." })
keywordHandler:addKeyword({ "druid" }, StdModule.say, { npcHandler = npcHandler, text = "Druids are nature magic users, specialised in earth, ice and healing." })
keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "Tibia is a huge world with many {cities} - most of them threatened by {monsters}. If you help us fighting them, you will earn {experience} and grow into a strong {warrior}." })
keywordHandler:addKeyword({ "quest" }, StdModule.say, { npcHandler = npcHandler, text = "I think apart from killing cockroaches there's no quest I could give you. There are many more quests on the main continent, just ask around!" })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Oh, my name is Santiago. I could tell you some {gossip} about me, harhar. I also know many {stories}." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "Time is passing slowly on Rookgaard, I can tell you!" })
keywordHandler:addKeyword({ "main" }, StdModule.say, { npcHandler = npcHandler, text = "The main continent is so much bigger than Rookgaard. You can travel there once you are level 8 and have chosen a {vocation}." })
keywordHandler:addKeyword({ "chor" }, StdModule.say, { npcHandler = npcHandler, text = "This place was discovered some years ago. It's a lizard town and those snake-human mixed thingies are still there! I wonder why they haven't been discovered earlier." })
keywordHandler:addKeyword({ "dixi" }, StdModule.say, { npcHandler = npcHandler, text = "She's Obi's granddaughter and deals with armors and shields, just upstairs from Obi's shop." })
keywordHandler:addKeyword({ "lily" }, StdModule.say, { npcHandler = npcHandler, text = "Lily's shop is just behind the bridge that leads to the village. She sells potions which will refill your health or cure poison." })
npcHandler:setMessage(MESSAGE_FAREWELL, "Take care, |PLAYERNAME|!.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye traveller, and enjoy your stay on Rookgaard.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
