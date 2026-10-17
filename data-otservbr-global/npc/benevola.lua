local internalNpcName = "Benevola"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 158,
	lookHead = 81,
	lookBody = 120,
	lookLegs = 15,
	lookFeet = 94,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Nature is in pain." },
	{ text = "The weather is fine today." },
	{ text = "I can hear the call of the forest." },
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
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I'm a preserver of nature. It's a sad thing, but as so many so-called intelligent beings tamper with nature's balance, it has become necessary to adjust things to maintain the {balance}." })
keywordHandler:addKeyword({ "white deer" }, StdModule.say, { npcHandler = npcHandler, text = "There are many stories and legends about the white deer. For sure it is a magnificent beast but this might be its downfall. Its majesty awakes the {greed} in the hearts of others and greed is balance's greatest enemy." })
keywordHandler:addKeyword({ "alkestios" }, StdModule.say, { npcHandler = npcHandler, text = "You know his name so I assume you have talked to him. I know how you feel. I was also rather surprised to meet a talking deer. He told me that he's not really an animal. But if you want to learn more, please talk to himself. ... I know a few things about him but I'm not sure what I'm allowed to reveal. Perhaps he will tell you more about himself and the reasons for his presence here." })
keywordHandler:addKeyword({ "balance" }, StdModule.say, { npcHandler = npcHandler, text = "The natural balance is a delicate thing. {Greed} is its greatest enemy. I do that little that I can do to preserve the balance." })
keywordHandler:addKeyword({ "nature" }, StdModule.say, { npcHandler = npcHandler, text = "Nature's balance sometimes seems like a myth or unreachable ideal. But we must do our part in keeping the balance because our intelligence gives us this responsibility." })
keywordHandler:addKeyword({ "wolves" }, StdModule.say, { npcHandler = npcHandler, text = "You might have occasionally encountered a few wolves and probably even fought them. Those are the few wolves that got too hungry and daring so they left their hiding place. ... Most wolves of a population you won't see at all though. They hide in the shadows and hunt by night. You only see them when the hunger drives them out and you will see that {hunger} makes them ferocious enemies." })
keywordHandler:addKeyword({ "hunger" }, StdModule.say, { npcHandler = npcHandler, text = "As long as many hungry wolves are out there, the deer population cannot recover. Therefore I placed magical traps in the wilderness. ... The traps will recognise any wolf that is starving and then pacify and magically shrink it. ... When you lured a starving wolf into a trap, please bring it to me. I will keep it in suspended animation until the balance is restored." })
keywordHandler:addKeyword({ "greed" }, StdModule.say, { npcHandler = npcHandler, text = "The {wolves} hunt their share until they feel no hunger anymore. Greedy people hunt the deer for its antlers and fur. The lowered deer population leave the wolves starving and aggressive until they become a threat." })
keywordHandler:addKeyword({ "elves" }, StdModule.say, { npcHandler = npcHandler, text = "Many have lost their touch to nature. They have given in to greed and the excuse of necessity. ... Yet, some still know, at least deep in their hearts, what is the right thing to do. This is my hope." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
