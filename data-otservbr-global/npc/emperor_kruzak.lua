local internalNpcName = "Emperor Kruzak"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 66,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
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

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if (MsgContains(message, "outfit")) or (MsgContains(message, "addon")) then
		npcHandler:say("In exchange for a truly generous donation, I will offer a special outfit. Do you want to make a donation?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif MsgContains(message, "yes") then
		-- vamos tratar todas condições para YES aqui
		if npcHandler:getTopic(playerId) == 1 then
			-- para o primeiro Yes, o npc deve explicar como obter o outfit
			npcHandler:say({
				"Excellent! Now, let me explain. If you donate 1.000.000.000 gold pieces, you will be entitled to wear a unique outfit. ...",
				"You will be entitled to wear the {armor} for 500.000.000 gold pieces, {helmet} for an additional 250.000.000 and the {boots} for another 250.000.000 gold pieces. ...",
				"What will it be?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 2)
			-- O NPC só vai oferecer os addons se o player já tiver escolhido.
		elseif npcHandler:getTopic(playerId) == 2 then
			-- caso o player repita o yes, resetamos o tópico para começar de novo?
			npcHandler:say("In that case, return to me once you made up your mind.", npc, creature)
			npcHandler:setTopic(playerId, 0)
			-- Inicio do outfit
		elseif npcHandler:getTopic(playerId) == 3 then -- ARMOR/OUTFIT
			if player:getStorageValue(Storage.Quest.U12_15.GoldenOutfits) < 1 then
				if player:getMoney() + player:getBankBalance() >= 500000000 then
					local inbox = player:getStoreInbox()
					local inboxItems = inbox:getItems()
					if inbox and #inboxItems < inbox:getMaxCapacity() then
						local decoKit = inbox:addItem(ITEM_DECORATION_KIT, 1)
						local decoItemName = ItemType(31510):getName()
						decoKit:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "You bought this item in the Store.\nUnwrap it in your own house to create a " .. decoItemName .. ".")
						decoKit:setActionId(36345)
						npcHandler:say("Take this armor as a token of great gratitude. Let us forever remember this day, my friend!", npc, creature)
						player:removeMoneyBank(500000000)
						player:addOutfit(1211)
						player:addOutfit(1210)
						player:getPosition():sendMagicEffect(171)
						player:setStorageValue(Storage.Quest.U12_15.GoldenOutfits, 1)
					else
						npcHandler:say("Please make sure you have free slots in your store inbox.", npc, creature)
					end
				else
					npcHandler:say("You do not have enough money to donate that amount.", npc, creature)
				end
			else
				npcHandler:say("You alread have that addon.", npc, creature)
			end
			npcHandler:setTopic(playerId, 2)
			-- Fim do outfit
			-- Inicio do helmet
		elseif npcHandler:getTopic(playerId) == 4 then
			if player:getStorageValue(Storage.Quest.U12_15.GoldenOutfits) == 1 then
				if player:getStorageValue(Storage.Quest.U12_15.GoldenOutfits) < 2 then
					if player:getMoney() + player:getBankBalance() >= 250000000 then
						npcHandler:say("Take this helmet as a token of great gratitude. Let us forever remember this day, my friend. ", npc, creature)
						player:removeMoneyBank(250000000)
						player:addOutfitAddon(1210, 1)
						player:addOutfitAddon(1211, 1)
						player:getPosition():sendMagicEffect(171)
						player:setStorageValue(Storage.Quest.U12_15.GoldenOutfits, 2)
						npcHandler:setTopic(playerId, 2)
					else
						npcHandler:say("You do not have enough money to donate that amount.", npc, creature)
						npcHandler:setTopic(playerId, 2)
					end
				else
					npcHandler:say("You alread have that outfit.", npc, creature)
					npcHandler:setTopic(playerId, 2)
				end
			else
				npcHandler:say("You need to donate {armor} outfit first.", npc, creature)
				npcHandler:setTopic(playerId, 2)
			end
			npcHandler:setTopic(playerId, 2)
			-- Fim do helmet
			-- Inicio da boots
		elseif npcHandler:getTopic(playerId) == 5 then
			if player:getStorageValue(Storage.Quest.U12_15.GoldenOutfits) == 2 then
				if player:getStorageValue(Storage.Quest.U12_15.GoldenOutfits) < 3 then
					if player:getMoney() + player:getBankBalance() >= 250000000 then
						npcHandler:say("Take this boots as a token of great gratitude. Let us forever remember this day, my friend. ", npc, creature)
						player:removeMoneyBank(250000000)
						player:addOutfitAddon(1210, 2)
						player:addOutfitAddon(1211, 2)
						player:getPosition():sendMagicEffect(171)
						player:setStorageValue(Storage.Quest.U12_15.GoldenOutfits, 3)
						npcHandler:setTopic(playerId, 2)
					else
						npcHandler:say("You do not have enough money to donate that amount.", npc, creature)
						npcHandler:setTopic(playerId, 2)
					end
				else
					npcHandler:say("You alread have that outfit.", npc, creature)
					npcHandler:setTopic(playerId, 2)
				end
			else
				npcHandler:say("You need to donate {helmet} addon first.", npc, creature)
				npcHandler:setTopic(playerId, 2)
			end
			-- Fim da boots
			npcHandler:setTopic(playerId, 2)
		end
		--inicio das opções armor/helmet/boots
		-- caso o player não diga YES, dirá alguma das seguintes palavras:
	elseif (MsgContains(message, "armor")) and npcHandler:getTopic(playerId) == 2 then
		npcHandler:say("So you wold like to donate 500.000.000 gold pieces which in return will entitle you to wear a unique armor?", npc, creature)
		npcHandler:setTopic(playerId, 3) -- alterando o tópico para que no próximo YES ele faça o outfit
	elseif (MsgContains(message, "helmet")) and npcHandler:getTopic(playerId) == 2 then
		npcHandler:say("So you would like to donate 250.000.000 gold pieces which in return will entitle you to wear unique helmet?", npc, creature)
		npcHandler:setTopic(playerId, 4) -- alterando o tópico para que no próximo YES ele faça o helmet
	elseif (MsgContains(message, "boots")) and npcHandler:getTopic(playerId) == 2 then
		npcHandler:say("So you would like to donate 250.000.000 gold pieces which in return will entitle you to wear a unique boots?", npc, creature)
		npcHandler:setTopic(playerId, 5) -- alterando o tópico para que no próximo YES ele faça a boots
	end
	-- fim das opções armor/helmet/boots
end

-- Promotion
local node1 = keywordHandler:addKeyword({ "promot" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "I can promote you for 20000 gold coins. Do you want me to promote you?" })
node1:addChildKeyword({ "yes" }, StdModule.promotePlayer, { npcHandler = npcHandler, monk = true, cost = 20000, level = 20, text = "Congratulations! You are now promoted." })
node1:addChildKeyword({ "no" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Alright then, come back when you are ready.", reset = true })

-- Greeting message
keywordHandler:addGreetKeyword({ "hail emperor" }, { npcHandler = npcHandler, text = "Hiho, may fire and earth bless you, my child. Are you looking for a promotion?" })
keywordHandler:addGreetKeyword({ "salutations emperor" }, { npcHandler = npcHandler, text = "Hiho, may fire and earth bless you, my child. Are you looking for a promotion?" })

keywordHandler:addKeyword({ "army" }, StdModule.say, { npcHandler = npcHandler, text = "Well, you'd better ask the general." })
keywordHandler:addKeyword({ "monsters" }, StdModule.say, { npcHandler = npcHandler, text = "Well, it's up to the younger ones to slay the beasts that roam the lands and the tunnels." })
keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "Well, well, well, the godblade. A myth? Perhaps. Even in my youth, it was only a legend." })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "Well, we are prepared even for him." })
keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "Well, the gods handed the lands over to the younger races, but my people will leave this word in dignity." })
keywordHandler:addAliasKeyword({ "lands" })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "Well we are at peace with Carlin and Thais." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Well we are at peace with Carlin and Thais." })
keywordHandler:addKeyword({ "time" }, StdModule.say, { npcHandler = npcHandler, text = "Well, after some centuries I stopped to worry about time anymore." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Well, I am Emperor Kruzak Dustbeard, son of Fire and Earth, second only to the gods, jawoll." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Well, I'm the emperor of the dwarfs. It's my duty to protect my folk and to see that justice is done." })
keywordHandler:addKeyword({ "axe of vengeance" }, StdModule.say, { npcHandler = npcHandler, text = "Well, the Axes of Vengeance were troublemakers even when they were few. Their reckless ways and boasting sadly impressed a lot of the young and easily gullible. ... Stories of their mostly made-up exploits and lies lured some into their embrace, but it was not until the blight that they became popular and a threat thanks to their leader, Jarok Bilespit." })
keywordHandler:addAliasKeyword({ "axes of vengeance" })
keywordHandler:addAliasKeyword({ "renegades" })
keywordHandler:addKeyword({ "ancient tribe" }, StdModule.say, { npcHandler = npcHandler, text = "Well, there is an old poem that is known by every dwarven child. It tells a story about the God Wars and the early years of Tibia. There have been two big dwarven tribes, but then a conflict arose. ... This conflict caused one of the tribes to leave their birthplace and to find themselves a new home. Not in my wildest dreams I would have believed that this poem could contain some truth. You should try to find it." })
keywordHandler:addKeyword({ "blight" }, StdModule.say, { npcHandler = npcHandler, text = "Well, the blight was a great disaster. It hit us completely unprepared. ... Given the severity of the disaster, we can be glad we handled it that well. Still, it weakened our defences, and by chance or sinister plans our enemies took it as an opportunity to hit us even harder. ... In the midst of recovering from the blight and relocating resources, the trouble in the mines began. First with rampaging creatures and then came the Lost. ... With resources bound there, even here in Kazordoon an enemy rose his ugly head ... and this head wore a dwarfen beard. Our own people, lead by the Axe of Vengeance fellowship." })
keywordHandler:addKeyword({ "food" }, StdModule.say, { npcHandler = npcHandler, text = "Well, go and buy some in the city." })
keywordHandler:addAliasKeyword({ "equipment" })
keywordHandler:addKeyword({ "sorcerers" }, StdModule.say, { npcHandler = npcHandler, text = "Well, the sorcerers are followers of the elemental powers." })
keywordHandler:addAliasKeyword({ "sorcerors" })
keywordHandler:addKeyword({ "minotaurs" }, StdModule.say, { npcHandler = npcHandler, text = "Well, we don't fear them. They seem more occupied with the humans anyway." })
keywordHandler:addKeyword({ "prepared" }, StdModule.say, { npcHandler = npcHandler, text = "Well, we use all stocked resources of finest metal to craft weapons and armor, we train new warriors and spellcasters every day. ... We give battle training to each citizen to enable them to better defend themselves and to form militia units in case of emergency. And we call in old favours and allies." })
keywordHandler:addKeyword({ "dungeons" }, StdModule.say, { npcHandler = npcHandler, text = "Well, there are a lot of dungeons in the lands, waiting to be explored by the daring ones." })
keywordHandler:addKeyword({ "paladins" }, StdModule.say, { npcHandler = npcHandler, text = "Well, we have some crossbowmen in our army but rely more on our knights." })
keywordHandler:addKeyword({ "conflict" }, StdModule.say, { npcHandler = npcHandler, text = "Well, our race is very hot-blooded, bullheaded, and also proud. The real cause is unknown but I can imagine how it happened." })
keywordHandler:addKeyword({ "justice" }, StdModule.say, { npcHandler = npcHandler, text = "Well, justice is a difficult thing. Can one be just to all at once, and if not, to whom should he be just?" })
keywordHandler:addKeyword({ "mission" }, StdModule.say, { npcHandler = npcHandler, text = "Well, if you wander the world with open eyes, you will see the quests without asking." })
keywordHandler:addAliasKeyword({ "quest" })
keywordHandler:addKeyword({ "knights" }, StdModule.say, { npcHandler = npcHandler, text = "Well, dwarfish knights are feared by our enemies in the whole world." })
keywordHandler:addKeyword({ "noodles" }, StdModule.say, { npcHandler = npcHandler, text = "WAAAH! Don't mention that beast! It was after the bones of our ancestors, last time King Tibianus visted us!" })
keywordHandler:addKeyword({ "beregar" }, StdModule.say, { npcHandler = npcHandler, text = "Well, you claim there is another dwarven city called Beregar? Could that be the city of the ancient tribe?!?" })
keywordHandler:addKeyword({ "castle" }, StdModule.say, { npcHandler = npcHandler, text = "Well, our people need no castle, our home IS a fortress." })
keywordHandler:addKeyword({ "druids" }, StdModule.say, { npcHandler = npcHandler, text = "Well, we have almost no druids in our town. If need arises we can call for them from Carlin." })
keywordHandler:addKeyword({ "heroes" }, StdModule.say, { npcHandler = npcHandler, text = "Well, we dwarfs produced some of the greatest heroes of all times." })
keywordHandler:addKeyword({ "father" }, StdModule.say, { npcHandler = npcHandler, text = "Well, more than 150 years ago, my father lost his beard overnight. Thereupon, he resigned from his leadership after hundreds of years of supreme ruling." })
keywordHandler:addKeyword({ "durin" }, StdModule.say, { npcHandler = npcHandler, text = "Well, Durin is one of the celestial paladins, messenger of the gods. He's the protector of the dwarven race." })
keywordHandler:addKeyword({ "mines" }, StdModule.say, { npcHandler = npcHandler, text = "Well, our mines have been invaded by a basilisk. We trapped him with a cave-in. The hero who brings me the body of this beast will get a great reward. ... But of course after the {blight} we have other problems down there, like the lost and the renegades." })
keywordHandler:addKeyword({ "enemy" }, StdModule.say, { npcHandler = npcHandler, text = "Well, only a dead enemy is a good enemy." })
keywordHandler:addKeyword({ "elves" }, StdModule.say, { npcHandler = npcHandler, text = "Well, they are not as bad as one might think." })
keywordHandler:addKeyword({ "edron" }, StdModule.say, { npcHandler = npcHandler, text = "Well, it is a colony of this human king." })
keywordHandler:addKeyword({ "elane" }, StdModule.say, { npcHandler = npcHandler, text = "Well, the High Paladin is a woman that deserves respect. I admired most Elanes I met in my life." })
keywordHandler:addKeyword({ "tribe" }, StdModule.say, { npcHandler = npcHandler, text = "Well, like all dwarfs we worship earth and fire. As you know, our tribe is closer connected to the element of earth. It is said that the other tribe prefers the element of fire." })
keywordHandler:addKeyword({ "city" }, StdModule.say, { npcHandler = npcHandler, text = "Well, go and see the wonders of our cities for yourself." })
keywordHandler:addKeyword({ "poem" }, StdModule.say, { npcHandler = npcHandler, text = "Well, it must have been written by someone of the Kazordoon tribe as there hasn't been any contact to the other tribe since the day we parted. I doubt you'll find a written copy of it here as it has been passed on by word of mouth. ... Maybe you find someone who tells you the poem. I for myself don't have time to tell you a children's poem. By the beard of my father, I'm the emperor, jawoll!" })
npcHandler:setMessage(MESSAGE_WALKAWAY, "Farewell, |PLAYERNAME|, my child!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, greetCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
