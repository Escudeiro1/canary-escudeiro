local internalNpcName = "Chrak"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 115,
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

local TheNewFrontier = Storage.Quest.U8_54.TheNewFrontier
local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "battle") then
		if player:getStorageValue(TheNewFrontier.Questline) == 24 then
			npcHandler:say({
				"Zo you want to enter ze arena, you know ze rulez and zat zere will be no ozer option zan deaz or victory?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 1)
		end
	elseif MsgContains(message, "mission") then
		if player:getStorageValue(TheNewFrontier.Questline) == 24 then
			npcHandler:say({
				"Ze tournament iz ze ultimate challenge of might and prowrezz. Ze rulez may have changed over ze centuriez but ze ezzence remained ze zame. ...",
				"If you know ze rulez, you might enter ze arena for ze {battle}.",
			}, npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(TheNewFrontier.Questline) == 27 then
			npcHandler:say({
				"You have done ze impozzible and beaten ze champion. Your mazter will be pleazed. Hereby I cleanze ze poizon from your body. You are now allowed to leave. ...",
				"For now ze mazter will zee zat you and your alliez are zpared of ze wraz of ze dragon emperor az you are unimportant for hiz goalz. ...",
				"You may crawl back to your alliez and warn zem of ze gloriouz might of ze dragon emperor and hiz minionz.",
			}, npc, creature)
			player:setStorageValue(TheNewFrontier.Questline, 28)
			player:setStorageValue(TheNewFrontier.Mission09[1], 3) --Questlog, "Mission 09: Mortal Combat"
			player:setStorageValue(TheNewFrontier.Mission10[1], 1) --Questlog, "Mission 10: New Horizons"
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			npcHandler:say("I grant you ze permizzion to enter ze arena. Remember, you'will have to enter ze arena az a team of two. If you are not familiar wiz ze rulez, I can explain zem to you once again.", npc, creature)
			player:setStorageValue(TheNewFrontier.Questline, 25)
			player:setStorageValue(TheNewFrontier.Mission09.ArenaDoor, 1)
			npcHandler:setTopic(playerId, 0)
		end
	end
	return true
end

keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "Ze dragon kingz zend zeir championz to ze Izle of Ztrife. Ze combat rezultz determine ze pozitionz ze dragon kingz will hold in ze court for ze next cycle. ... Ze dragon kingz put great pride in zeir championz and often put great effort into zeir training." })
keywordHandler:addKeyword({ "competitor" }, StdModule.say, { npcHandler = npcHandler, text = "I'm ze mazter of ze ceremony and ze gamez. I overzee zat everyzing iz handled accordingly to ze ancient traditionz. I'm ze one to teach ze rulez of ze tournament to ze competitorz." })
keywordHandler:addKeyword({ "tournament" }, StdModule.say, { npcHandler = npcHandler, text = "Ze tournament iz ze ultimate challenge of might and prowrezz. Ze rulez may have changed over ze centuriez but ze ezzence remained ze zame. ... If you know ze rulez, you might enter ze arena for ze battle." })
keywordHandler:addAliasKeyword({ "arena" })
keywordHandler:addAliasKeyword({ "victory" })
keywordHandler:addKeyword({ "emperor" }, StdModule.say, { npcHandler = npcHandler, text = "Ze dragon emperor will be watching ze tournament by magical meanz. Zo do your bezt to zhow an imprezzive fight. If you annoy ze dragon emperor, you will be killed - even if you have won ze tournament." })
keywordHandler:addKeyword({ "lizards" }, StdModule.say, { npcHandler = npcHandler, text = "In ancient timez, lizard men fought here for zeir own ztation in zociety. Even now when combat iz only a zubztitute for ze rivalry of ze officialz of te emperor'z court, zome value ze ancient art of war. ... Zey chooze only ze finezt warriorz from our armiez az zeir championz. Zoze often undergo yearz of painful training in ze art of fighting. ... Zeir zkillz are honed zrough relentlezz training by ze finezt mazterz, and zey have to battle ze mozt challenging opponentz to prove worzy to participate in ze battle of ze tournament." })
keywordHandler:addKeyword({ "dragon" }, StdModule.say, { npcHandler = npcHandler, text = "Ze dragonz hold our zociety togezer. Weaknezz and fear zpread zrough our people before ze dragonz came. Zey gave uz ze power we needed to drive our enemiez back. ... Zey gave uz ze leaderzhip and rule we needed for our nation to become whole again and a new unity for a common goal." })
keywordHandler:addKeyword({ "palace" }, StdModule.say, { npcHandler = npcHandler, text = "Ze palace of ze dragon emperor iz well guarded againzt all intruderz. Only lizard men of great ztation are allowed to enter ze palace. It iz a place of maginificence, built and refined by generationz of artizianz under ze guidanze of ze emperorz." })
keywordHandler:addKeyword({ "gamez" }, StdModule.say, { npcHandler = npcHandler, text = "Even at timez of ze firzt emperorz, ze tournament waz a great event to prove onez might and ztrengz. Firzt, ze mightiezt warriorz competed for a rank in ze imperial army. ... Later zey fought for ze great ruling familiez of ze land. Zey zent zeir greatezt warriorz to ze Izle of Ztrife and took great pride in providing ze mozt dangerouz and zuccezzful competitorz of ze tournament. ... Zince centuriez, ze tournament iz ze ultimate challenge for any warrior of ze land and beyond." })
keywordHandler:addKeyword({ "demon" }, StdModule.say, { npcHandler = npcHandler, text = "Zometimez an official drawz on ze dark powerz of ze nezerworld to call ruzlezz demonz into our realm. Bound to zeir will, zey are out for deztrucion and carnage. ... Uzually zey are not trained for ze tournament but zummoned in hordez who zen fight each ozer until only ze mozt fierce and rezilient emerge az victorz." })
keywordHandler:addKeyword({ "court" }, StdModule.say, { npcHandler = npcHandler, text = "Zome officialz rule over ze variouz citiez and keepz. Only ze mozt preztigiouz officialz are allowed a permanent pozition in ze imperial palace." })
keywordHandler:addKeyword({ "land" }, StdModule.say, { npcHandler = npcHandler, text = "My people call ziz land Zao. We are it'z rightful rulerz zince countless centuriez." })
npcHandler:setMessage(MESSAGE_GREET, "Greetingz, competitor.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
