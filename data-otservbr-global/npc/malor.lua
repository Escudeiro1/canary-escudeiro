local internalNpcName = "Malor"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 103,
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

local function releasePlayer(npc, creature)
	if not Player(creature) then
		return
	end

	npcHandler:removeInteraction(npc, creature)
	npcHandler:resetNpc(creature)
end

local function endConversationWithDelay(npcHandler, npc, creature)
	addEvent(function()
		npcHandler:unGreet(npc, creature)
	end, 1000)
end

local function greetCallback(npc, creature, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not MsgContains(message, "djanni'hah") and player:getStorageValue(Storage.Quest.U7_4.DjinnWar.Faction.Greeting) < 0 then
		npcHandler:say("Shove off, little one! Humans are not welcome here, |PLAYERNAME|!", npc, creature)
		endConversationWithDelay(npcHandler, npc, creature)
		return false
	end

	if player:getStorageValue(Storage.Quest.U7_4.DjinnWar.MaridFaction.Start) == 1 then
		npcHandler:say({
			"Hahahaha! ...",
			"|PLAYERNAME|, that almost sounded like the word of greeting. Humans - cute they are!",
		}, npc, creature)
		endConversationWithDelay(npcHandler, npc, creature)
		return false
	end

	npcHandler:say("Greetings, human |PLAYERNAME|. My patience with your kind is limited, so speak quickly and choose your words well.", npc, creature)
	npcHandler:setInteraction(npc, creature)

	return true
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local missionProgress = player:getStorageValue(Storage.Quest.U7_4.DjinnWar.EfreetFaction.Mission03)
	if MsgContains(message, "mission") then
		if player:getStorageValue(Storage.Quest.U7_4.DjinnWar.EfreetFaction.Mission02) == 3 then
			if missionProgress < 1 then
				npcHandler:say({
					"I guess this is the first time I entrust a human with a mission. And such an important mission, too. But well, we live in hard times, and I am a bit short of adequate staff. ...",
					"Besides, Baa'leal told me you have distinguished yourself well in previous missions, so I think you might be the right person for the job. ...",
					"But think carefully, human, for this mission will bring you close to certain death. Are you prepared to embark on this mission?",
				}, npc, creature)
				npcHandler:setTopic(playerId, 1)
			elseif missionProgress == 1 then
				npcHandler:say("You haven't finished your final mission yet. Shall I explain it again to you?", npc, creature)
				npcHandler:setTopic(playerId, 1)
			elseif missionProgress == 2 then
				npcHandler:say("Have you found Fa'hradin's lamp and placed it in Malor's personal chambers?", npc, creature)
				npcHandler:setTopic(playerId, 2)
			else
				npcHandler:say("There's no mission left for you, friend of the Efreet. However, I have a {task} for you.", npc, creature)
			end
		else
			npcHandler:say({
				"So you would like to fight for us. Hmm. ...",
				"You show true courage, human, but I will not accept your offer at this point of time.",
			}, npc, creature)
		end
	elseif npcHandler:getTopic(playerId) == 1 then
		if MsgContains(message, "yes") then
			npcHandler:say({
				"Well, listen. We are trying to acquire the ultimate weapon to defeat Gabel: Fa'hradin's lamp! ...",
				"At the moment it is still in the possession of that good old friend of mine, the Orc King, who kindly released me from it. ...",
				"However, for some reason he is not as friendly as he used to be. You better watch out, human, because I don't think you will get the lamp without a fight. ...",
				"Once you have found the lamp you must enter Ashta'daramai again. Sneak into Gabel's personal chambers and exchange his sleeping lamp with Fa'hradin's lamp! ...",
				"If you succeed, the war could be over one night later!",
			}, npc, creature)
			player:setStorageValue(Storage.Quest.U7_4.DjinnWar.EfreetFaction.Mission03, 1)
		elseif MsgContains(message, "no") then
			npcHandler:say("Your choice.", npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	elseif npcHandler:getTopic(playerId) == 2 then
		if MsgContains(message, "yes") then
			npcHandler:say({
				"Well well, human. So you really have made it - you have smuggled the modified lamp into Gabel's bedroom! ...",
				"I never thought I would say this to a human, but I must confess I am impressed. ...",
				"Perhaps I have underestimated you and your kind after all. ...",
				"I guess I will take this as a lesson to keep in mind when I meet you on the battlefield. ...",
				"But that's in the future. For now, I will confine myself to give you the permission to trade with my people whenever you want to. ...",
				"Farewell, human!",
			}, npc, creature)
			player:setStorageValue(Storage.Quest.U7_4.DjinnWar.EfreetFaction.Mission03, 3)
			player:setStorageValue(Storage.Quest.U7_4.DjinnWar.EfreetFaction.DoorToMaridTerritory, 1)
			player:addAchievement("Efreet Ally")
			addEvent(function()
				releasePlayer(npc, creature)
			end, 1000)
		elseif MsgContains(message, "no") then
			npcHandler:say("Just do it!", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "task") and player:getStorageValue(Storage.Quest.U7_4.DjinnWar.EfreetFaction.Mission03) == 3 then
		if player:getStorageValue(Storage.Quest.U8_5.KillingInTheNameOf.BlueDjinnTask) < 0 or player:getStorageValue(Storage.Quest.U8_5.KillingInTheNameOf.BlueDjinnTask) == 3 then
			npcHandler:say("There are still blue djinns everywhere! We can't let a single one of them live. I guess a start would be for you to kill 500 blue djinns and Marid. Will you assist us?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		elseif player:getStorageValue(Storage.Quest.U8_5.KillingInTheNameOf.BlueDjinnTask) == 0 then
			if player:getStorageValue(Storage.Quest.U8_5.KillingInTheNameOf.MonsterKillCount.BlueDjinnCount) >= 500 then
				npcHandler:say({
					"Well well, human. Not bad. I'm not surprised, since you have done acceptably well in the past. So I suppose I can ask you for another thing. ...",
					"Seek out Fahim the Wise. A name which is utter mockery, since he's one of the stupidest Marid I've ever seen. He hides somewhere in Yalahar, probably afraid to come anywhere near Mal'ouquah. ...",
					"I suggest you teach that joke of a djinn a lesson he won't forget.",
				}, npc, creature)
				player:setStorageValue(Storage.Quest.U8_5.KillingInTheNameOf.BossKillCount.FahimCount, 0)
				player:setStorageValue(Storage.Quest.U8_5.KillingInTheNameOf.BlueDjinnTask, 1)
			else
				npcHandler:say("Come back when you kill 500 blue djinns and Marid.", npc, creature)
			end
		elseif player:getStorageValue(Storage.Quest.U8_5.KillingInTheNameOf.BlueDjinnTask) == 2 then
			npcHandler:say({
				"You've met Fahim the Wise? That's good. I'm pretty sure it was easy to give him a nice beating. ...",
				"If you should feel like killing blue djinns in our service again, just talk to me about that task.",
			}, npc, creature)
			player:setStorageValue(Storage.Quest.U8_5.KillingInTheNameOf.BlueDjinnTask, 3)
			player:addExperience(10000, true)
			player:addMoney(5000)
		end
	elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 3 then
		npcHandler:say("Good, then show those pathetic Marid what you're made of.", npc, creature)
		player:setStorageValue(JOIN_STOR, 1)
		player:setStorageValue(Storage.Quest.U8_5.KillingInTheNameOf.MonsterKillCount.BlueDjinnCount, 0)
		player:setStorageValue(Storage.Quest.U8_5.KillingInTheNameOf.AltKillCount.BlueDjinnCount, 0)
		player:setStorageValue(Storage.Quest.U8_5.KillingInTheNameOf.AltKillCount.MaridCount, 0)
		player:setStorageValue(Storage.Quest.U8_5.KillingInTheNameOf.BlueDjinnTask, 0)
	end
	return true
end

keywordHandler:addCustomGreetKeyword({ "djanni'hah" }, greetCallback, { npcHandler = npcHandler })

keywordHandler:addKeyword({ "gods" }, StdModule.say, { npcHandler = npcHandler, text = "Are not the creators reflected in their creations? Look around! What do you see? There is nothing but cowardice and treachery in the world of humans. ... How low the gods must be who made them. I have no respect for them." })
keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "The world of Tibia is ours by right. I will not rest until we have conquered it." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "I may not have reached my goal yet, but neither has that accursed Gabel. As long as the Marid and Efreet are disunited neither of us can call himself the king of all djinn." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am the true leader of all djinn - perhaps not by birth, but certainly by merit. One day all djinn will come to recognise that I alone deserve to be king." })
keywordHandler:addKeyword({ "akh'rah uthun" }, StdModule.say, { npcHandler = npcHandler, text = "Another one of that loony pharaoh's bright ideas. Nothing but nonsense and balderdash." })
keywordHandler:addAliasKeyword({ "uthun" })
keywordHandler:addKeyword({ "ashta'daramai" }, StdModule.say, { npcHandler = npcHandler, text = "Ashta'daramai is the fortress of our sworn enemies, the oh so powerful Marid. The day will come when I see its smouldering walls collapse." })
keywordHandler:addKeyword({ "mal'ouquah" }, StdModule.say, { npcHandler = npcHandler, text = "Do you like this place? I have built Mal'ouquah as a home for those among my kind who did not fall for Daraman's sugar covered lies. From here I shall rule the world when the time has come." })
keywordHandler:addKeyword({ "fa'hradin" }, StdModule.say, { npcHandler = npcHandler, text = "Fa'hradin is Gabel's lieutenant. I have known him for a long time, and I have always respected him. ... Unfortunately he chose the wrong side when the time to chose sides came. I have not given up hope of winning him over for some reason, but if I meet him on the battlefield I will not hesitate to kill him myself." })
keywordHandler:addKeyword({ "ankrahmun" }, StdModule.say, { npcHandler = npcHandler, text = "Even though it always was a human settlement I have always had a soft spot for the place. I am even thinking about making it my capital once I have taken over the world." })
keywordHandler:addKeyword({ "kha'labal" }, StdModule.say, { npcHandler = npcHandler, text = "Kha'labal. I do not like that desert. Looking at it brings up bad memories." })
keywordHandler:addKeyword({ "ascension" }, StdModule.say, { npcHandler = npcHandler, text = "Ascension? That does ring a bell. Isn't that an element of the pharaoh's doctrines." })
keywordHandler:addKeyword({ "kha'zeel" }, StdModule.say, { npcHandler = npcHandler, text = "They say the Kha'zeel mountains have been made by gods. If that is true they must have left long ago, because I have lived here for eons, and I have never met one of them." })
keywordHandler:addKeyword({ "darashia" }, StdModule.say, { npcHandler = npcHandler, text = "Darashia is a very rich city. Once this war is won I will drop by at the Caliph's palace and pay my respects, if you know what I mean." })
keywordHandler:addKeyword({ "melchior" }, StdModule.say, { npcHandler = npcHandler, text = "Melchior! Hah, that fool! Is he still alive? I never thought the old wretch would make it after I gave him my special treatment and sent him out into the Kha'labal. ... Amazing, really. It has often occurred to me how much humans resemble rats - they are just as hard to kill!" })
keywordHandler:addKeyword({ "baa'leal" }, StdModule.say, { npcHandler = npcHandler, text = "I suppose you have met Baa'leal already? The fact that you have survived that encounter shows that you are surprisingly strong for a human. ... I almost feel some respect for you... Well, almost." })
keywordHandler:addKeyword({ "daraman" }, StdModule.say, { npcHandler = npcHandler, text = "Of all human liars and schemers he was the worst. This self-styled prophet single-handedly managed to disunite my race and to spark a bloody civil war. ... If somebody fulfilled a wish for me for a change I would bring him back to life and make him pay." })
keywordHandler:addKeyword({ "pharaoh" }, StdModule.say, { npcHandler = npcHandler, text = "I have heard that pompous pharaoh believes himself to be some sort of deity. That pathetic bonehead a god? Don't make me laugh!" })
keywordHandler:addKeyword({ "humans" }, StdModule.say, { npcHandler = npcHandler, text = "Your race is weak, but incurably treacherous. I will never forgive humanity the fact that it was one of your kind who spread the seed of dissent among the djinn." })
keywordHandler:addKeyword({ "scarab" }, StdModule.say, { npcHandler = npcHandler, text = "Scarabs are ancient creatures, which is why I respect them. But I will never allow any of these critters to undermine the foundations of my fortress." })
keywordHandler:addKeyword({ "alesar" }, StdModule.say, { npcHandler = npcHandler, text = "Oh yes, Alesar! I bet Gabel went mad when he learnt that Alesar switched sides. If only I had been there to watch his face." })
keywordHandler:addKeyword({ "djinn" }, StdModule.say, { npcHandler = npcHandler, text = "We are strong and proud. One day we will take our rightful place on the throne of creation, and your vulgar race will either serve us or perish. ... Nothing personal, human. It is a natural process. And you humans will find that the djinn can be just masters." })
keywordHandler:addKeyword({ "marid" }, StdModule.say, { npcHandler = npcHandler, text = "The so-called Marid have forgotten what it is like to be djinn! They are weak!" })
keywordHandler:addKeyword({ "gabel" }, StdModule.say, { npcHandler = npcHandler, text = "That fool. He thought he'd got rid of me for good. But I'm back, and this time I will finish what I have begun. That weak-willed wimp has held on to power far too long." })
keywordHandler:addKeyword({ "lamp" }, StdModule.say, { npcHandler = npcHandler, text = "We djinn use them to sleep." })
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell, human. When I have taken my rightful place I shall remember those who served me well. Even if they are only humans.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Farewell, human.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, greetCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
