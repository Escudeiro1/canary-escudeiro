local internalNpcName = "Sirik"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 251,
	lookHead = 79,
	lookBody = 116,
	lookLegs = 116,
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

keywordHandler:addKeyword({ "news" }, StdModule.say, { npcHandler = npcHandler, text = "I am busy. Please ask the citizens for news." })
keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "I would love to have that legendary weapon. If you find it, bring it to me!" })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "Wait, wait! Don't say a word, it's, it's ... that very small guy with the hairy feet? No?" })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I AM A BARBARIAN! Names are of no concern during work!! If somebody is calling for help, I will come." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "It's my duty to protect Svargrond and its citizens." })
keywordHandler:addKeyword({ "how are you" }, StdModule.say, { npcHandler = npcHandler, text = "I am healthy and vigilant. Always ready to make some raiders one head smaller." })
keywordHandler:addKeyword({ "barbarians" }, StdModule.say, { npcHandler = npcHandler, text = "Go find Sven our jarl if you want to join our community. At this time he should be at the tavern. Follow the main road to the west and at the furrier quarter turn south." })
keywordHandler:addAliasKeyword({ "test" })
keywordHandler:addAliasKeyword({ "join" })
keywordHandler:addKeyword({ "formorgar" }, StdModule.say, { npcHandler = npcHandler, text = "There are valuable ores in the mines under the Formorgar glacier. But nobody who has ever tried to gather some has ever come back. I have no clue what's going on down there." })
keywordHandler:addAliasKeyword({ "mines" })
keywordHandler:addKeyword({ "sorcerers" }, StdModule.say, { npcHandler = npcHandler, text = "You have to look for Romir." })
keywordHandler:addKeyword({ "guildhall" }, StdModule.say, { npcHandler = npcHandler, text = "In the city you will find three guildhalls. Frost Manor is on top of the cliff ... Crystal Glance is north of the depot at the street which leads to the arena and Mammoth Belly is to the south, near the furrier quarter." })
keywordHandler:addKeyword({ "dankwart" }, StdModule.say, { npcHandler = npcHandler, text = "He is the keeper of our Tavern. No need to explain where you find him." })
keywordHandler:addKeyword({ "grimlund" }, StdModule.say, { npcHandler = npcHandler, text = "Stay away from there! It's the home of the chakoyas." })
keywordHandler:addKeyword({ "serpents" }, StdModule.say, { npcHandler = npcHandler, text = "All of a sudden the years of the serpents ended. I am glad that we regained the contact with the rest of Tibia. ... Still, if you are very attentive, you may see a sea serpent. Not all of them have disappeared." })
keywordHandler:addKeyword({ "thorwulf" }, StdModule.say, { npcHandler = npcHandler, text = "He is the trainer for knights. You find him near the arena." })
keywordHandler:addKeyword({ "captain" }, StdModule.say, { npcHandler = npcHandler, text = "Let me think......where could a captain be??? Think twice before you ask me silly questions!!!" })
keywordHandler:addKeyword({ "barbara" }, StdModule.say, { npcHandler = npcHandler, text = "Is that a name?? Maybe it originates from 'barbarian'. I have to think about that... bye!" })
keywordHandler:addKeyword({ "jessica" }, StdModule.say, { npcHandler = npcHandler, text = "She is the leader of the Carlin traders. She spends most of her time in the jewellery store which is also the bank of Svargrond. You find it south of the road between the harbour and the depot." })
keywordHandler:addKeyword({ "siflind" }, StdModule.say, { npcHandler = npcHandler, text = "Ohh, old mother Siflind! She is a lovely shaman. You find her on Nibelor." })
keywordHandler:addKeyword({ "helheim" }, StdModule.say, { npcHandler = npcHandler, text = "A small island north east of Tyrsung. Nothing important there. Maybe one of the fishermen can bring you there if you like to go." })
keywordHandler:addKeyword({ "hrodmir" }, StdModule.say, { npcHandler = npcHandler, text = "This big, icy rock you're standing at right now. The raiders live in the middle and south of the big Formorgar glacier." })
keywordHandler:addKeyword({ "nibelor" }, StdModule.say, { npcHandler = npcHandler, text = "It's a sacred place for us! Our shamans live there. Ask Iskan if you want to go there." })
keywordHandler:addKeyword({ "okolnir" }, StdModule.say, { npcHandler = npcHandler, text = "The third biggest island of all Ice Islands. Home of the frost dragons. Give me your money if you want to go there, you won't need it afterwards." })
keywordHandler:addKeyword({ "tyrsung" }, StdModule.say, { npcHandler = npcHandler, text = "That is the big island east of Hrodmir. Venorian hunters settled there ..... or maybe they got eaten up by the frost giants." })
keywordHandler:addKeyword({ "paladin" }, StdModule.say, { npcHandler = npcHandler, text = "You have to look for Hawkyr." })
keywordHandler:addKeyword({ "chakoya" }, StdModule.say, { npcHandler = npcHandler, text = "These chakoyas are nasty little creatures. Not very dangerous for an ambitious fighter but still nasty." })
keywordHandler:addKeyword({ "dragons" }, StdModule.say, { npcHandler = npcHandler, text = "A special kind of them lives on Okolnir, the frost dragons. They adapted well to the cold conditions here." })
keywordHandler:addKeyword({ "trainer" }, StdModule.say, { npcHandler = npcHandler, text = "The guild masters for paladins and knights are at the arena, the shamans on Nibelor surely can teach druids new things ... and Romir the old hermit who lives in a cave north of Svargrond may have some knowledge concerning magic." })
keywordHandler:addKeyword({ "rumours" }, StdModule.say, { npcHandler = npcHandler, text = "I have no time to natter. Ask the citizens for rumours." })
keywordHandler:addKeyword({ "jarl" }, StdModule.say, { npcHandler = npcHandler, text = "Our leader is Jarl Sven the Younger! You find him in the tavern west of the city." })
keywordHandler:addAliasKeyword({ "leader" })
keywordHandler:addKeyword({ "baltim" }, StdModule.say, { npcHandler = npcHandler, text = "Never heard that name." })
keywordHandler:addAliasKeyword({ "zora" })
keywordHandler:addKeyword({ "bertha" }, StdModule.say, { npcHandler = npcHandler, text = "She trades with general goods. You can find her in her shop near the harbour." })
keywordHandler:addKeyword({ "kjesse" }, StdModule.say, { npcHandler = npcHandler, text = "You can find him at the temple to the west. He is the shaman of Svargrond." })
keywordHandler:addKeyword({ "nilsor" }, StdModule.say, { npcHandler = npcHandler, text = "He is one of our shamans that live on Nibelor." })
keywordHandler:addKeyword({ "robert" }, StdModule.say, { npcHandler = npcHandler, text = "HAA, he thinks his weapons are the best!! Too weak to hold a real barbarian axe! You find him near the arena." })
keywordHandler:addKeyword({ "fimbul" }, StdModule.say, { npcHandler = npcHandler, text = "Fimbul Shelf is the name of the big shelf ice west of Svargrond. A good spot to go ice fishing." })
keywordHandler:addKeyword({ "weapon" }, StdModule.say, { npcHandler = npcHandler, text = "You can find the weapon and armor shops at the arena to the north. Talk to Robert." })
keywordHandler:addKeyword({ "magic" }, StdModule.say, { npcHandler = npcHandler, text = "I heard Nelly talking about runes and fluids. Ask her." })
keywordHandler:addAliasKeyword({ "fruids" })
keywordHandler:addKeyword({ "hawkyr" }, StdModule.say, { npcHandler = npcHandler, text = "He is the paladin trainer. You find him near the arena." })
keywordHandler:addKeyword({ "knight" }, StdModule.say, { npcHandler = npcHandler, text = "You have to look for Thorwulf." })
keywordHandler:addKeyword({ "dwarfs" }, StdModule.say, { npcHandler = npcHandler, text = "How can somebody of that size drink that much?? I met a dwarf once but my memory of this evening is a little bit clouded." })
keywordHandler:addKeyword({ "demons" }, StdModule.say, { npcHandler = npcHandler, text = "We have tales about dark, evil creatures that can kill dozens of brave warriors in a blink of an eye. I'm glad that these are only tales." })
keywordHandler:addKeyword({ "druids" }, StdModule.say, { npcHandler = npcHandler, text = "You have to look for Hjaern." })
keywordHandler:addKeyword({ "hjaern" }, StdModule.say, { npcHandler = npcHandler, text = "He is one of our shamans and trainer for druids. He lives on Nibelor." })
keywordHandler:addKeyword({ "busty" }, StdModule.say, { npcHandler = npcHandler, text = "NOT ME! With that thick fur clothes we are wearing, it is not easy to see... er... female characteristics." })
keywordHandler:addKeyword({ "iskan" }, StdModule.say, { npcHandler = npcHandler, text = "He is the leader of the dog sled. Last time I saw him he was with his dogs on the shelf ice north of the harbour." })
keywordHandler:addKeyword({ "lurik" }, StdModule.say, { npcHandler = npcHandler, text = "He is the representative of the explorer's society here in Svargrond. You find him south of the road between the harbour and the depot." })
keywordHandler:addKeyword({ "shelf" }, StdModule.say, { npcHandler = npcHandler, text = "West of Svargrond is the Fimbul Ice Shelf, Nibelor and Grimlund are embedded in shelf ice, and in the north of Hrodmir are several small shelf ice fields." })
keywordHandler:addKeyword({ "camps" }, StdModule.say, { npcHandler = npcHandler, text = "The raider camps are south of Hrodmir. The tribe to the east lives in a glacier cave. They call their settlement Ragnir. ... The most southern camp is called Krimhorn and the raider caves to the west are called Bittermor." })
keywordHandler:addKeyword({ "tales" }, StdModule.say, { npcHandler = npcHandler, text = "Once upon a time there was ..... WHO DO YOU THINK I AM! GO TO YOUR GRANDMOTHER FOR SUCH THINGS!!" })
keywordHandler:addKeyword({ "ghost" }, StdModule.say, { npcHandler = npcHandler, text = "Some people say that Helheim is a haunted place because there is a rock that looks like a skull. Just a tale to scare kids if you ask me." })
keywordHandler:addKeyword({ "guard" }, StdModule.say, { npcHandler = npcHandler, text = "I am a guard and proud to be a barbarian." })
keywordHandler:addKeyword({ "queen" }, StdModule.say, { npcHandler = npcHandler, text = "Who?" })
keywordHandler:addKeyword({ "romir" }, StdModule.say, { npcHandler = npcHandler, text = "He is an old hermit who lives in a hut on the elevated plain north of Svargrond . He is some kind of male witch, you know what I mean? ... He knows magic and all that. Maybe he teaches his knowledge to others." })
keywordHandler:addKeyword({ "arena" }, StdModule.say, { npcHandler = npcHandler, text = "If you think you are strong enough, then try to fight there. You have to challenge waves of monsters that get stronger and stronger. ... The entrance to the arena is a stairway north of the town, left of the town gate." })
keywordHandler:addKeyword({ "banor" }, StdModule.say, { npcHandler = npcHandler, text = "I only know Chyll, the cold north wind, the father of frost." })
keywordHandler:addKeyword({ "sven" }, StdModule.say, { npcHandler = npcHandler, text = "Sven the Younger is our jarl. At this time he should be at the tavern. Follow the main road to the west and at the furrier quarter turn south." })
keywordHandler:addKeyword({ "sled" }, StdModule.say, { npcHandler = npcHandler, text = "You can ask Iskan to bring you with his dog sled to Nibelor." })
keywordHandler:addKeyword({ "elfs" }, StdModule.say, { npcHandler = npcHandler, text = "Too weak to hold a real weapon and too soft for the climate here. I've never seen one." })
keywordHandler:addKeyword({ "cult" }, StdModule.say, { npcHandler = npcHandler, text = "Let me think .......... Yes there have been a bunch of strange looking guys passing Svargrond and heading for the old mines. It somehow reminded me of a cult." })
keywordHandler:addKeyword({ "shop" }, StdModule.say, { npcHandler = npcHandler, text = "Near the harbour you find the equipment shop, the branch of the explorer's society as well as the post office and the bank. ... Right-hand of the depot, which is in the centre of Svargrond, you find the furniture store ... All weapon and armor traders linger at the arena in the North and the tavern is to the west." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
