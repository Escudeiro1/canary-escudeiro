local internalNpcName = "Lurik"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 133,
	lookHead = 38,
	lookBody = 94,
	lookLegs = 96,
	lookFeet = 116,
	lookAddons = 3,
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

	if MsgContains(message, "mission") then
		if player:getStorageValue(Storage.Quest.U7_6.ExplorerSociety.TheAstralPortals) == 56 and player:getStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine) == 56 and player:getStorageValue(Storage.Quest.U7_6.ExplorerSociety.TheIslandofDragons) == 57 then --will need review in the future
			npcHandler:say("Ah, you've just come in time. An experienced explorer is just what we need here! Would you like to go on a mission for us?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(Storage.Quest.U7_6.ExplorerSociety.TheIslandofDragons) == 58 and player:getStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine) == 58 then
			if player:removeItem(7314, 1) then
				npcHandler:say({
					"A frozen dragon lord? This is just the information we needed! And you even brought a scale from it! Take these 5000 gold pieces as a reward. ...",
					"As you did such a great job, I might have another mission for you later.",
				}, npc, creature)
				player:addItem(3035, 50)
				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.TheIslandofDragons, 59)
				player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 59)
			else
				npcHandler:say("You're not done yet...", npc, creature)
			end
		elseif player:getStorageValue(Storage.Quest.U7_6.ExplorerSociety.TheIslandofDragons) == 59 and player:getStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine) == 59 then
			npcHandler:say({
				"Ah, yes, the mission. Let me tell you about something called ice music. ...",
				"There is a cave on Hrodmir, north of the southernmost barbarian camp Krimhorn. ...",
				"In this cave, there are a waterfall and a lot of stalagmites. ...",
				"When the wind blows into this cave and hits the stalagmites, it is supposed to create a sound similar to a soft song. ...",
				"Please take this resonance crystal and use it on the stalagmites in the cave to record the sound of the wind.",
			}, npc, creature)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.TheIceMusic, 60)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 60)
			player:addItem(7242, 1)
		elseif player:getStorageValue(Storage.Quest.U7_6.ExplorerSociety.TheIceMusic) == 61 and player:getStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine) == 61 and player:removeItem(7315, 1) then
			npcHandler:say({
				"Ah! You did it! I can't wait to hear the sound... but I will do that in a silent moment. ...",
				"You helped as much in our research here. As a reward, you may use our astral portal in the upper room from now on. ...",
				"For just one orichalcum pearl, you can travel between Liberty Bay and Svargrond. Thank you again!",
			}, npc, creature)
			npcHandler:setTopic(playerId, 0)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.TheIceMusic, 62)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 62)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.IceMusicDoor, 1)
		elseif player:getStorageValue(Storage.Quest.U8_0.TheIceIslands.Questline) == 32 then
			npcHandler:say({
				"You are the one who became an honorary barbarian! The one who made friends with the grim local musher and helped the shamans of Nibelor! The one they call old bearhugg ... erm ... I mean indeed I might have a mission for someone like you ...",
				"We are trying to find out what is happening in the raider camps. Through our connection to the shamans we could get a covered contact in their majorcamp far to the south. We equipped our contact with a memory crystal so he could report all he knew ...",
				"We need you to recover this crystal. Travel to the southern camp of the raiders and find our contact man there. Get the memory crystal and bring ithere. The society and the shamans will then decide our next steps. Do you think you can do this?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 2)
		elseif player:getStorageValue(Storage.Quest.U8_0.TheIceIslands.Questline) == 33 then
			npcHandler:say("Have you retrieved the memory crystal?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		elseif player:getStorageValue(Storage.Quest.U8_0.TheIceIslands.Questline) == 34 and player:getStorageValue(Storage.Quest.U8_0.TheIceIslands.MemoryCrystal) > os.time() then
			npcHandler:say("Give me some more time!", npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.Quest.U8_0.TheIceIslands.Questline) == 34 and player:getStorageValue(Storage.Quest.U8_0.TheIceIslands.MemoryCrystal) < os.time() then
			npcHandler:say({
				"The information was quite useful. What worries me most are not the raiders but those that have driven them from the old mines...",
				"We need to investigate the mines. Most entrances collapsed due to the lack of maintenance but there should be some possibilities to get in ...",
				"In case you find a door, Ill tell you the old trick of the Carlin mining company to open it <whisper> <whisper>. Find some hint or someone who is willing to talk about what is going on there.",
			}, npc, creature)
			npcHandler:setTopic(playerId, 0)
			player:setStorageValue(Storage.Quest.U8_0.TheIceIslands.Questline, 35)
			player:setStorageValue(Storage.Quest.U8_0.TheIceIslands.Mission09, 1) -- Questlog The Ice Islands Quest, Formorgar Mines 1: The Mission
			player:setStorageValue(Storage.Quest.U8_0.TheIceIslands.FormorgarMinesDoor, 1)
		end
	elseif MsgContains(message, "yes") then
		-- ISLAND OF DRAGONS
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say({
				"Now we're talking! Maybe you've already heard of the island Okolnir south of Hrodmir. ...",
				"Okolnir is the home of a new and fierce dragon race, the so-called frost dragons. However, we have no idea where they originate from. ...",
				"Rumours say that dragon lords, that roamed on this isle, were somehow turned into frost dragons when the great frost covered Okolnir. ...",
				"Travel to Okolnir and try to find a proof for the existence of dragon lords there in the old times. I think old Buddel might be able to bring you there.",
			}, npc, creature)
			npcHandler:setTopic(playerId, 0)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.TheIslandofDragons, 57)
			player:setStorageValue(Storage.Quest.U7_6.ExplorerSociety.QuestLine, 57)
			-- ISLAND OF DRAGONS
		elseif npcHandler:getTopic(playerId) == 2 then
			npcHandler:say("Excellent. Just report about your mission when you got the memory crystal.", npc, creature)
			player:setStorageValue(Storage.Quest.U8_0.TheIceIslands.Questline, 33)
			player:setStorageValue(Storage.Quest.U8_0.TheIceIslands.Mission08, 2) -- Questlog The Ice Islands Quest, The Contact
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:removeItem(7281, 1) then
				npcHandler:say("Ah, great. Please give me some time to evaluate the information. Then talk to me again about your mission. ", npc, creature)
				player:setStorageValue(Storage.Quest.U8_0.TheIceIslands.Questline, 34)
				player:setStorageValue(Storage.Quest.U8_0.TheIceIslands.Mission08, 4) -- Questlog The Ice Islands Quest, The Contact
				player:setStorageValue(Storage.Quest.U8_0.TheIceIslands.MemoryCrystal, os.time() + 5 * 60)
				npcHandler:setTopic(playerId, 0)
			end
		end
	end
	return true
end

keywordHandler:addKeyword({ "gods" }, StdModule.say, { npcHandler = npcHandler, text = "We know of father Chyll and his freezing breath. We care little for other gods. It is foolish to meddle with beings that are so powerful ... We leave it to the druids and shamans to handle such affairs." })
keywordHandler:addKeyword({ "news" }, StdModule.say, { npcHandler = npcHandler, text = "At this remote spot, news are old news. Did you hear that quara attacked Liberty Bay?" })
keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "On the campfire, there are numerous tales about this weapon. It's told that it has been missing since ages ... In my opinion, the power and fame of a weapon shouldn't exceed the power and fame of it's wielder. And I have not heard of any hero whose fame would surpass that of excalibug." })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "Even here we heard about this powerful man. Travellers from the south only dare to whisper his name." })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "We are friends of the Carliners. Still we don't allow their politics to influence our way to handle things here." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "We understand that our friends from Carlin are wary with the realm ruled by Thais but this is not of our concern." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "No kings or queens rule these remote lands." })
keywordHandler:addAliasKeyword({ "queen" })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Lurik. Odd enough you ask though. People hardly do that nowadays. I feel as if my name was  painted above my head or something." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am the local contact of the explorer's society. I just love it to be at the frontier of all known lands." })
keywordHandler:addKeyword({ "explorer's society" }, StdModule.say, { npcHandler = npcHandler, text = "Our noble society is dedicated to explore the unknown. No location is too remote for our members to travel there ... No beast is too wild to be hunted. No treasure buried too deep to be unearthed ... Only the most dedicated and fearless adventurers may join our ranks." })
keywordHandler:addAliasKeyword({ "explorer society" })
keywordHandler:addKeyword({ "years of serpents" }, StdModule.say, { npcHandler = npcHandler, text = "It was an astonishing phenomenon. For decades, sea serpents made it impossible to reach these northern isles by ship ... The most puzzling part of this event is probably the fact that sea serpents usually prefer a southern climate ... However, almost over night the sea serpents seemed to be gone and the contact between Carlin and the isles here could finally be reestablished." })
keywordHandler:addKeyword({ "barbarian test" }, StdModule.say, { npcHandler = npcHandler, text = "All of our juveniles have to take the barbarian test to become a true member of our community. Foreigners who manage to master the test might become honorary barbarians and gain the respect of our people." })
keywordHandler:addKeyword({ "how are you" }, StdModule.say, { npcHandler = npcHandler, text = "I am fine. Thank you. There is a bit less work here than I had expected but I am sure we will have some intriguing discoveries just waiting for us." })
keywordHandler:addKeyword({ "everspring" }, StdModule.say, { npcHandler = npcHandler, text = "Everspring is the realm of the dead. It is a place of peace and harmony where those who boldly braved the challenges of life dwell for eternity and share stories at the campfires after a hunt ... Every true barbarian that is properly brought into afterlife will join the great hunt in Everspring where the animals are fat and have the thickest furs." })
keywordHandler:addKeyword({ "barbarian" }, StdModule.say, { npcHandler = npcHandler, text = "A true barbarian is something special among our people. Everyone who wants to become a barbarian will have to pass the barbarian test." })
keywordHandler:addKeyword({ "enemies" }, StdModule.say, { npcHandler = npcHandler, text = "This is a dangerous, unforgiving land. If you leave the city, you will have to deal with creatures that survive in this harsh environment. They are for sure a challenge for the unwary." })
keywordHandler:addKeyword({ "druids" }, StdModule.say, { npcHandler = npcHandler, text = "Most shaman and druids of our people live on the sacred isle Nibelor. There, they divine the future, calm the wrath of father Chyll and prepare the dead for their last travel to the lands of Everspring." })
keywordHandler:addAliasKeyword({ "shamans" })
keywordHandler:addKeyword({ "nibelor" }, StdModule.say, { npcHandler = npcHandler, text = "Nibelor has always been a sacred place for our people. The druids and shamans live there." })
keywordHandler:addKeyword({ "raiders" }, StdModule.say, { npcHandler = npcHandler, text = "Those barbarian who did oppose the building of this settlements call themselves raiders. They consist of some major and minor clans. ... It's said that they are lead by a shaman woman, who has celebrated her 100th birthday a long time ago, but I am not sure how believable such records are." })
keywordHandler:addKeyword({ "chakoya" }, StdModule.say, { npcHandler = npcHandler, text = "It's a shame I still have not seen a living chakoya. I could examine some dead specimen though and I have seen some of their victims ... It's hard to believe that such a small creature is such a terrible threat but for all I can tell they are indeed quite dangerous." })
keywordHandler:addKeyword({ "people" }, StdModule.say, { npcHandler = npcHandler, text = "The people here seem to be a bit uncivilised on the first glance. Rest assured that they are hospitable and generous if you earn their respect in some way." })
keywordHandler:addKeyword({ "venore" }, StdModule.say, { npcHandler = npcHandler, text = "We did not allow them to stay here. This had nothing to do with our friendship with Carlin but for the way they handled things and their harmful approach to go hunting." })
keywordHandler:addKeyword({ "edron" }, StdModule.say, { npcHandler = npcHandler, text = "We have heard only little about this far away place." })
keywordHandler:addAliasKeyword({ "port hope" })
keywordHandler:addKeyword({ "chyll" }, StdModule.say, { npcHandler = npcHandler, text = "Father north wind is called Chyll by our people. He is an unforgiving hunter. He knows no mercy with the weak ... Chyll is a harsh god and the best you can do is to avoid his attention. Only the shamans and druids deal with him." })
keywordHandler:addKeyword({ "dwarf" }, StdModule.say, { npcHandler = npcHandler, text = "I met some of those little people in the past. Considering our experience with the chakoyas, we don't underestimate someone just for its look. And those dwarfs proved indeed to be powerful, courageous and enduring." })
keywordHandler:addKeyword({ "cult" }, StdModule.say, { npcHandler = npcHandler, text = "I don't care what people who come here believe in. If they provoke father Chyll, he will take care of them on his own. If their gods prove to be more powerful than Chyll, they might deserve to live." })
keywordHandler:addKeyword({ "jarl" }, StdModule.say, { npcHandler = npcHandler, text = "The jarl is a kind of chieftain of the local people here. If you haven't done yet, talk to him. If you want to be accepted by the people here, you will have to ask the jarl for the barbarian test." })
keywordHandler:addKeyword({ "yeti" }, StdModule.say, { npcHandler = npcHandler, text = "The yetis are mythical beasts. Only few that encountered those creatures lived to tell the tale. The chakoyas worship them as divine beings, although they have no real relations to them, as far as we can tell." })
npcHandler:setMessage(MESSAGE_GREET, "Welcome to the {explorer society} headquarter of Svargrond, |PLAYERNAME|!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
	{ itemName = "orichalcum pearl", clientId = 5021, buy = 80 },
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
