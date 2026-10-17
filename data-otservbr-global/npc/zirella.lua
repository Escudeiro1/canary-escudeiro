local internalNpcName = "Zirella"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 157,
	lookHead = 57,
	lookBody = 111,
	lookLegs = 67,
	lookFeet = 95,
	lookAddons = 2,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "I wish someone could spare a minute and help me..." },
	{ text = "This is too hard for an old woman like me." },
	{ text = "Hello, young adventurer, you look strong enough to help me!" },
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

	if player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaNpcGreetStorage) < 1 then
		npcHandler:setMessage(MESSAGE_GREET, "Oh, heaven must have sent you! Could you please help me with a {quest}?")
		storeTalkCid[playerId] = 0
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaNpcGreetStorage) == 1 then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome back, darling... so about that firewood, could you please {help} me?")
		storeTalkCid[playerId] = 2
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaNpcGreetStorage) == 2 then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome back, darling... so about the {dead trees}, let me explain that a little more, {yes}?")
		storeTalkCid[playerId] = 3
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaNpcGreetStorage) == 3 then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome back, darling... so about the {branches}, let me explain that a little more, {yes}?")
		storeTalkCid[playerId] = 4
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaNpcGreetStorage) == 4 then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome back, darling... so about the {pushing}, let me explain that a little more, {yes}?")
		storeTalkCid[playerId] = 5
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaNpcGreetStorage) == 5 then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome back, darling... so about the {cart}, let me explain that a little more, {yes}?")
		storeTalkCid[playerId] = 6
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaNpcGreetStorage) == 6 then
		npcHandler:setMessage(MESSAGE_GREET, "Oh, sweetheart, is there a problem with the quest? Should I {explain} it again?")
		storeTalkCid[playerId] = 7
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaNpcGreetStorage) == 7 then
		npcHandler:setMessage(MESSAGE_GREET, "Right, thank you sweetheart! This will be enough to heat my oven. Oh, and you are probably waiting for your reward, {yes}?")
		storeTalkCid[playerId] = 8
	elseif player:getStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaNpcGreetStorage) == 8 then
		npcHandler:setMessage(MESSAGE_GREET, "Oh, welcome back, dear Isleth Eagonst! Are you here for a little chat? Just use the highlighted {keywords} again to choose a {topic}.")
	end
	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if table.contains({ "yes", "quest", "ok" }, message) then
		if storeTalkCid[playerId] == 0 then
			npcHandler:say("By the way, 'quest' is a keyword that many NPCs react to, especially those which have tasks for you. So darling, about that {quest}... are you listening?", npc, creature)
			storeTalkCid[playerId] = 1
		elseif storeTalkCid[playerId] == 1 then
			npcHandler:say("Thank you so much for your kindness. I'm an old woman and I desperately need firewood for my oven. Could you please help me?", npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaQuestLog, 1)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaNpcGreetStorage, 1)
			storeTalkCid[playerId] = 2
		elseif storeTalkCid[playerId] == 2 then
			npcHandler:say("You're such a treasure. In the forest south of here, there are {dead trees} without any leaves. The first thing you have to do is search for one, {okay}?", npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaQuestLog, 2)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaNpcGreetStorage, 2)
			storeTalkCid[playerId] = 3
		elseif storeTalkCid[playerId] == 3 then
			npcHandler:say("Splendid, once you've found one, 'Use' it to break a branch from it. Did you understand that so far?", npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaQuestLog, 3)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaNpcGreetStorage, 3)
			storeTalkCid[playerId] = 4
		elseif storeTalkCid[playerId] == 4 then
			npcHandler:say("Good... so after you broke a branch, please push it here and select 'use with'. That will turn your mouse cursor into crosshairs. Then left-click on my cart. {Alright}?", npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaQuestLog, 4)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaNpcGreetStorage, 4)
			storeTalkCid[playerId] = 5
		elseif storeTalkCid[playerId] == 5 then
			npcHandler:say("To push the branch, drag and drop it on the grass by holding the left mousebutton and moving the cursor to where you want to throw the branch. Just push it near my cart before you 'Use' it, {alright}?", npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaQuestLog, 5)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaNpcGreetStorage, 5)
			storeTalkCid[playerId] = 6
		elseif storeTalkCid[playerId] == 6 then
			npcHandler:say({
				"Thank you darling! My cart is right beside me. It's a little complicated: I need some firewood, but it's very difficult for my slightly advanced age. ...",
				"Please go into the the forest southeast of here. You will find fine old rotten brown trees. Please RIGHT-CLICK in the lower right corner of that tree and choose 'USE'. That way, a branch should appear on the map. ...",
				"Don't put it in your inventory like before, but instead DRAG it over the map by LEFT-CLICKING the loose branch, HOLDING the LEFT MOUSE BUTTON and moving it over the map. ...",
				"When you are close to my cart, USE the branch WITH the cart: RIGHT-CLICK the branch on the floor and select 'USE WITH', Then LEFT-CLICK on the cart. Don't worry, you will see what I mean on the way. Thanks and {bye} for now!",
			}, npc, creature)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaQuestLog, 6)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaNpcGreetStorage, 6)
			Position(32064, 32273, 7):sendMagicEffect(CONST_ME_TUTORIALARROW)
			npcHandler:removeInteraction(npc, creature)
			npcHandler:resetNpc(creature)
		elseif storeTalkCid[playerId] == 7 then
			npcHandler:say({
				"Well, you know that old women like me like to talk a lot. If you see three dots at the end of a sentence, I have still something to say and you should not interrupt, like now ...",
				"Patience is a virtue, young adventurer! So, the quest was to go into the forest south of here and to find a dead tree. Wait, let me continue! ...",
				"'Use' a tree to break a dry branch from it. Afterwards, drag and drop the branch back to my cart and select 'Use with', then left-click on my cart. Thanks again for offering your help!",
			}, npc, creature)
			storeTalkCid[playerId] = nil
		elseif storeTalkCid[playerId] == 8 then
			npcHandler:say("Oh, you deserve it. You really have earned some experience! Also, you may enter my little house now and take what's in that chest beside my bed. Good {bye} for now!", npc, creature)
			player:addExperience(50, true)
			Position(32058, 32266, 6):sendMagicEffect(CONST_ME_TUTORIALARROW)
			player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaQuestLog, 8)
			player:setStorageValue(Storage.Quest.U8_2.TheBeginningQuest.ZirellaNpcGreetStorage, 8)
			npcHandler:removeInteraction(npc, creature)
			npcHandler:resetNpc(creature)
		end
	elseif MsgContains(message, "no") then
		if storeTalkCid[playerId] == 7 then
			npcHandler:say("Well then, I hope you find nice and dry branches for me! Good {bye}!", npc, creature)
			npcHandler:removeInteraction(npc, creature)
			npcHandler:resetNpc(creature)
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
keywordHandler:addKeyword({ "experience" }, StdModule.say, { npcHandler = npcHandler, text = "Earning experience and gaining levels will make you stronger. It's all about power in Tibia!" })
keywordHandler:addKeyword({ "rookgaard" }, StdModule.say, { npcHandler = npcHandler, text = "We are currently south of the village of Rookgaard, just follow the path to the east. Once you are there, you will meet many other {citizens}." })
keywordHandler:addKeyword({ "merchants" }, StdModule.say, { npcHandler = npcHandler, text = "We have a weapon smith called Obi, Dixi is selling armors and Al Dee is offering general tools. Also, you can buy potions from Lily. I think those are the most important people to trade with." })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "He is a mighty and evil wizard. Back then, all Tibians stuck together and managed to defeat him. I heard he fled and found a refuge to recover. ... There is a citadel on one of the Tibian islands which he uses to regain his power. Now and then, brave Tibians invade and weaken him again." })
keywordHandler:addKeyword({ "keywords" }, StdModule.say, { npcHandler = npcHandler, text = "Right, this was a keyword. But actually there are more interesting topics to talk about." })
keywordHandler:addKeyword({ "vocation" }, StdModule.say, { npcHandler = npcHandler, text = "The Tibian vocations are {knight}, {paladin}, {sorcerer} and {druid}, each of them has its own specialities." })
keywordHandler:addKeyword({ "sorcerer" }, StdModule.say, { npcHandler = npcHandler, text = "Sorcerers are elemental magic users, specialised in fire, energy and death magic." })
keywordHandler:addKeyword({ "monsters" }, StdModule.say, { npcHandler = npcHandler, text = "Here on Rookgaard, we are lucky that the monsters threatening our village are rather weak. I wouldn't want to have the {dragons} and {demons} of the main continent here!" })
keywordHandler:addKeyword({ "citizens" }, StdModule.say, { npcHandler = npcHandler, text = "Most of the citizens are {merchants}. We have also two {guards} and a {healer}, and a {teacher} in our academy." })
keywordHandler:addKeyword({ "dungeons" }, StdModule.say, { npcHandler = npcHandler, text = "There is a huge cave system under Tibia. Even Rookgaard has many underground dungeons. The bridge guards know all about them." })
keywordHandler:addKeyword({ "dallheim" }, StdModule.say, { npcHandler = npcHandler, text = "He's a great warrior. He can also tell you much about monsters and dungeons on this island." })
keywordHandler:addAliasKeyword({ "zerbrus" })
keywordHandler:addKeyword({ "cipfried" }, StdModule.say, { npcHandler = npcHandler, text = "Visiting Cipfried is a good idea if you are badly injured or poisoned. Just ask him for a heal." })
keywordHandler:addKeyword({ "paladin" }, StdModule.say, { npcHandler = npcHandler, text = "Paladins are distance fighters and holy magic users. They outrun their enemies and shoot them with arrows or bolts." })
keywordHandler:addKeyword({ "dragons" }, StdModule.say, { npcHandler = npcHandler, text = "You'll never forget your first dragon. That is true even after all those years. Fierce beasts they are!" })
keywordHandler:addKeyword({ "stories" }, StdModule.say, { npcHandler = npcHandler, text = "Hmm hmm, I could tell you some stories about {Thais} and the old days." })
keywordHandler:addKeyword({ "teacher" }, StdModule.say, { npcHandler = npcHandler, text = "The teacher of the academy is called Seymour. The academy is just north of the temple." })
keywordHandler:addKeyword({ "seymour" }, StdModule.say, { npcHandler = npcHandler, text = "Seymour is a teacher running the academy. He has many important information about Tibia." })
keywordHandler:addKeyword({ "warrior" }, StdModule.say, { npcHandler = npcHandler, text = "Well, everybody is a 'warrior' in general. You can choose between four {vocations} once you are level 8." })
keywordHandler:addKeyword({ "knight" }, StdModule.say, { npcHandler = npcHandler, text = "Knights are strong melee fighters. They usually use weapons such as swords, clubs or axes." })
keywordHandler:addKeyword({ "cities" }, StdModule.say, { npcHandler = npcHandler, text = "There are many cities on the main continent, much bigger than our little village here. You should visit all of them!" })
keywordHandler:addKeyword({ "demons" }, StdModule.say, { npcHandler = npcHandler, text = "There are numerous different demons all over Tibia. They mostly hide deep in dungeons, but sometimes they dare entering the human realm." })
keywordHandler:addKeyword({ "guards" }, StdModule.say, { npcHandler = npcHandler, text = "The bridge guards Dallheim and Zerbrus can tell you which monsters are suitable for your level and where to find them." })
keywordHandler:addKeyword({ "healer" }, StdModule.say, { npcHandler = npcHandler, text = "Our healer is called Cipfried. He guards the temple." })
keywordHandler:addKeyword({ "al dee" }, StdModule.say, { npcHandler = npcHandler, text = "Al Dee sells tools such as torches, ropes and shovels. You will learn about them soon!" })
keywordHandler:addKeyword({ "oracle" }, StdModule.say, { npcHandler = npcHandler, text = "Oh, you're a bit young to hear about the oracle. Be patient, you'll learn everything in time." })
keywordHandler:addKeyword({ "druid" }, StdModule.say, { npcHandler = npcHandler, text = "Druids are nature magic users, specialised in earth, ice and healing." })
keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "Tibia is a huge world with many {cities} - most of them threatened by {monsters}. If you help us fighting them, you will earn {experience} and grow into a strong {warrior}." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Thais was the first city in Tibia, back then it was even called 'Tibia City'. There were dragons just outside the gates! ... In the past years, brave adventurers have pushed them back into the dungeons, though. Also, there was this great battle with {Ferumbras}! Those were the days." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "An old woman like me has all the time in the world." })
keywordHandler:addKeyword({ "main" }, StdModule.say, { npcHandler = npcHandler, text = "The main continent is so much bigger than Rookgaard. You can travel there once you are level 8 and have chosen a {vocation}." })
keywordHandler:addKeyword({ "dixi" }, StdModule.say, { npcHandler = npcHandler, text = "She's Obi's granddaughter and deals with armors and shields, just upstairs from Obi's shop." })
keywordHandler:addKeyword({ "lily" }, StdModule.say, { npcHandler = npcHandler, text = "Lily's shop is just behind the bridge that leads to the village. She sells potions which will refill your health or cure poison." })
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye |PLAYERNAME|, may Uman bless you!.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye traveller, take care.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
