local internalNpcName = "Cranky Lizard Crone"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 339,
}

npcConfig.flags = {
	floorchange = false,
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

-- Messages
local newaddon = "Here you are, enjoy your brand new addon!"
local noItems = "You do not have all the required items."
local already = "It seems you already have this addon, don't you try to mock me son!"

--WAYFARER START --
function WayfarerFirst(npc, creature, message, keywords, parameters, node)
	local player = Player(creature)
	if not player then
		return
	end

	if player:isPremium() then
		if player:getStorageValue(Storage.WayfarerOutfit) < 1 then
			if player:getItemCount(11701) > 0 then
				if player:removeItem(11701, 1) then
					npcHandler:say(newaddon, npc, creature)
					player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
					player:addOutfitAddon(366, 1)
					player:addOutfitAddon(367, 1)
					player:setStorageValue(Storage.WayfarerOutfit, 1)
				end
			else
				npcHandler:say(noItems, npc, creature)
			end
		else
			npcHandler:say(already, npc, creature)
		end
	end
end

function WayfarerSecond(npc, creature, message, keywords, parameters, node)
	local player = Player(creature)
	if not player then
		return
	end

	if player:isPremium() then
		if player:getStorageValue(Storage.WayfarerOutfit + 1) < 1 then
			if player:getItemCount(11700) > 0 then
				if player:removeItem(11700, 1) then
					npcHandler:say(newaddon, npc, creature)
					player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
					player:addOutfitAddon(366, 2)
					player:addOutfitAddon(367, 2)
					player:setStorageValue(Storage.WayfarerOutfit + 1, 1)
				end
			else
				npcHandler:say(noItems, npc, creature)
			end
		else
			npcHandler:say(already, npc, creature)
		end
	end
end

-- WAYFARER END --
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Oh I'm a fisherwoman, fishing zinze ze firzt day I can remember. Ahehe. In fact, my whole family waz. But now I... I am alone. I'm ze only one left." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name iz... iz... hmmm, I zeem to have... forgotten it. Ah well I am old. Pleaze exzcuze my zilly {behaviour}. Ahehe." })
keywordHandler:addKeyword({ "behaviour" }, StdModule.say, { npcHandler = npcHandler, text = "All izz gtting harder and harder witzz zze yearzz, even my {job}." })
keywordHandler:addKeyword({ "emperor" }, StdModule.say, { npcHandler = npcHandler, text = "Hm, I don't really know, it seemz I.. cannot really remember. Well, I guezz he did not interfere wiz ze lifez of uz small folk here in ze village. And we alwayz had problemz of our own." })
keywordHandler:addKeyword({ "village" }, StdModule.say, { npcHandler = npcHandler, text = "Yez, beautiful izn't it... ahehe. Ah, I live here, yez. For zuch a long time. Az far az I can remember, I waz alwayz here. I like ziz village, I really love it. Like I loved my {family}, ah my family... how I mizz zem now." })
keywordHandler:addKeyword({ "spirits" }, StdModule.say, { npcHandler = npcHandler, text = "Ze... ze zpiritz. Zey are everywhere - and nowhere. In ze morning zey zit on my windowzill, in ze evening zey linger on my very doorztepz. In ze night I can almozt hear zem calling for me, longing for my... zoul." })
keywordHandler:addAliasKeyword({ "ghosts" })
keywordHandler:addKeyword({ "family" }, StdModule.say, { npcHandler = npcHandler, text = "We were fisherz, all of uz. My whole family. Ze draught waz our life, yez. Now I catch zem on my own, no one iz here to help me anymore. But I get along." })
keywordHandler:addKeyword({ "memory" }, StdModule.say, { npcHandler = npcHandler, text = "It iz gone... I cannot remember much. I am old, you know. I forget... zingz. Like my clozez, where did I put zem? My flowerz, too. Oh how I love flowerz. Almozt az much az my family. My poor family." })
keywordHandler:addKeyword({ "addons" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "I can offer you first & second addons of the following outfit: {Wayfarer}." })

keywordHandler:addKeyword({ "storage" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Ask about {first addon} or {second addon}." })

keywordHandler:addKeyword({ "outfit" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Ask about {first addon} or {second addon}." })

keywordHandler:addKeyword({ "mission" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Ask about {first addon} or {second addon}." })

keywordHandler:addKeyword({ "help" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "llected all the required pieces, say 'yes' and voila - you got yourself an addon!" })

local node1 = keywordHandler:addKeyword({ "first addon" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "To achieve the first storage addon you need to give me the Old Cape. Do you have them with you?" })
node1:addChildKeyword({ "yes" }, WayfarerFirst, {})
node1:addChildKeyword({ "no" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Alright then. Come back when you got all neccessary items.", reset = true })

local node2 = keywordHandler:addKeyword({ "second addon" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "To achieve the second storage addon you need to give me the Sedge Hat. Do you have them with you?" })
node2:addChildKeyword({ "yes" }, WayfarerSecond, {})
node2:addChildKeyword({ "no" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Alright then. Come back when you got all neccessary items.", reset = true })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
