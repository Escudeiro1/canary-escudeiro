local internalNpcName = "Rotem Valos"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 335,
	lookHead = 79,
	lookBody = 77,
	lookLegs = 79,
	lookFeet = 94,
	lookAddons = 2,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "<sigh> The world has grown complicated since my youth." },
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
keywordHandler:addKeyword({ "adventurers" }, StdModule.say, { npcHandler = npcHandler, text = "We are the Adventurers' Guild, and from this base, we pursue our mission to provide help and information. Occasionally, we need help with various other work." })
keywordHandler:addKeyword({ "fasul abrek" }, StdModule.say, { npcHandler = npcHandler, text = "Sorry but this is a matter I'm not prepared to discuss ... yet." })
keywordHandler:addKeyword({ "equipment" }, StdModule.say, { npcHandler = npcHandler, text = "You become stronger in several ways, some more obvious than others. First of all, there is your equipment. Better equipment means you are harder to kill. ... Equipment can be dropped as loot by killed creatures. Stronger monsters drop better loot of course. You might get equipment as a reward from some missions, which is especially true for the most experienced adventurers. ... You can also buy equipment offered by other players in the market, accessible via the depot. Then there are your skills - when they improve, so does your chance to cope with enemies that you encounter on your travels." })
keywordHandler:addKeyword({ "blessings" }, StdModule.say, { npcHandler = npcHandler, text = "Blessings are something the gods bestow upon us in order to protect us. They are expensive though, and require a lot of costly travel. So it might take a while until blessings are an option for an adventurer. ... In case of death, blessings will reduce the loss of experience. The different blessings are cumulative, and add up with each other. However, blessings are spent once you die, and will have to be renewed again. ... Therefore, blessings are mainly a tool for the experienced adventurer who has a lot to lose when he dies." })
keywordHandler:addKeyword({ "stronger" }, StdModule.say, { npcHandler = npcHandler, text = "You become stronger in several ways, some more obvious than others. First of all, there is your {equipment}. Better equipment means you are harder to kill. Then there's your {skills} and experience, and your {vocation}, for example." })
keywordHandler:addKeyword({ "vocation" }, StdModule.say, { npcHandler = npcHandler, text = "Your vocation is what you chose to be - either a knight, paladin, druid or sorcerer. Each vocation has its own fighting technique and skills." })
keywordHandler:addKeyword({ "premium" }, StdModule.say, { npcHandler = npcHandler, text = "If you have a premium account and were blessed by the gods, you can also use the training statues for some meditative combat training. This means your skills are trained while your character is logged out." })
keywordHandler:addKeyword({ "skills" }, StdModule.say, { npcHandler = npcHandler, text = "Be careful not to die, as you lose skill points with each death! Skills increase by using them. So when you fight a creature, you will always grow a little more skilled with the weapon or magic skill that you use. ... Then there is your experience, of course. The more experience you have gained, the more life force and mana you have at your disposal. As you probably already know, you get experience through fighting things, and some missions. ... Premium accounts have two additional possibilities, as they can also use training statues and get promotions." })
keywordHandler:addKeyword({ "loot" }, StdModule.say, { npcHandler = npcHandler, text = "The simplest loot is probably junk, but other stuff dropped by slain monsters might be worth something to one of the inhabitants; or you can sell it to some vendors. Dropped creature products often are not that heavy, so they might be worth keeping. ... Check if any dropped weapons or armor are better than what you have. Even if they're not, it might be worth keeping them to sell them to a weapon or armor vendor. ... Provided you have the capacity to carry it, that is! But don't become overconfident and forget about death! If you die, you lose part of what you carry, so you might want to stash some spare equipment at the depot." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
