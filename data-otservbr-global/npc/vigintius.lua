local internalNpcName = "Vigintius"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 273,
	lookHead = 94,
	lookBody = 94,
	lookLegs = 88,
	lookFeet = 61,
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

keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "You've been around a while, sometimes even in {disguise} - not that you could fool me <wink> <wink>. But imagine, there are still places to be discovered! Do you remember that one place, you never figured out how to enter? ... Took you tons of time but no clue yet, eh? Know what? I've been there. Seen it all - but I won't tell!" })
keywordHandler:addKeyword({ "entertaining" }, StdModule.say, { npcHandler = npcHandler, text = "Yeah, just remember all the hunts, the cool people you've met and that guy you befriended? Of course you do, man! That's what this is all about after all! ... I'm pretty sure you're already on your way to your next adventure and someone's waiting. Don't let an old dodderer like me keep you. Go out there and have fun! Don't forget: I'll keep an eye on ya!" })
keywordHandler:addKeyword({ "first dragon" }, StdModule.say, { npcHandler = npcHandler, text = "The dragon was ancient beyond compare. Eventually even he had to succumb to old age and flew to the dragon cemetery to die there. Or so it is told." })
keywordHandler:addKeyword({ "explorer" }, StdModule.say, { npcHandler = npcHandler, text = "I heard that a member of the Explorer Society was in fact searching for the {First Dragon}. What a foolish endeavour - please excuse this comment. A romantic idea and a brave venture but seriously: the First Dragon. It is just a myth! ... However the explorer found an ancient inscription underneath the city of Thais. Reportedly he discovered it in the small {cave} where the first time ever a dragon was sighted on Tibia." })
keywordHandler:addAliasKeyword({ "inscription" })
keywordHandler:addKeyword({ "ignorance" }, StdModule.say, { npcHandler = npcHandler, text = "You still remember those times when you were a rookie, don't ya? Well I do and you were one of the rookiest rookies I've ever seen - and I've seen my share, man. ... How you tried to get out of that hole! Pure comedy, I tell ya. I also know you were a bit afraid of trolls! LOL! Imagine, trolls! ... 'Oh, they will kill me! Must get out of here!' Priceless! Don't feel ashamed, man. We all've been there! In the end you turned out quite well I must say! Well, at least you could have turned out {worse}, man." })
keywordHandler:addKeyword({ "disguise" }, StdModule.say, { npcHandler = npcHandler, text = "C'mon man. We all get curious about other vocations now and then. Nothing to be ashamed of! Thing is, everything is about fun in the end, isn't it?" })
keywordHandler:addKeyword({ "memories" }, StdModule.say, { npcHandler = npcHandler, text = "There are so many of them! Like that crazy guy in this one city, wasn't it - Thais? I've definitely seen my share of crazy stuff but that guy was as nuts as a coconut. ... I wonder what became of him. Do you know? Ah never mind, man. There are too many nice fellows around to care about those who are nuts. As {entertaining} as they might be from time to time." })
keywordHandler:addKeyword({ "worse" }, StdModule.say, { npcHandler = npcHandler, text = "Yeah, like that one guy that was getting on your nerves in that dungeon. Some people can really be a pain. Can't remember how things turned out back then but I'm pretty sure you remember it quite well! Ah all those {memories}." })
keywordHandler:addKeyword({ "cave" }, StdModule.say, { npcHandler = npcHandler, text = "I don't know exactly where it is. Someone told me you have to pass some tunnels full of orcs, somewhere underneath the king's castle. But that might be just gossip." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
