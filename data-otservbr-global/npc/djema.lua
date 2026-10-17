local internalNpcName = "Djema"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 136,
	lookHead = 77,
	lookBody = 8,
	lookLegs = 86,
	lookFeet = 115,
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

keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "I have read all about the northern cities. It is almost as if I had been there myself." })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "I have read all about the northern cities. It is almost as if I had been there myself." })
keywordHandler:addKeyword({ "tibia" }, StdModule.say, { npcHandler = npcHandler, text = "Daddy has often told me about how huge and mysterious this world is. <Sighs> How much I would like to see it all. But he won't let me go. ... Djehave read books about the northern continent inhabited by thousands and thousands of people. Ordinary humans just like you and me! Imagine that!" })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "Officially there is no king of the djinn. Daddy used to hold the title, but he has chosen to put if off. Of course, he is still the undisputed leader of the Marid. He simply dislikes the title." })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Djema. Daddy says it means 'Moonflower' in the old language." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Djeam the librarian in this place. I don't like the work too much because we do not really have that many books, and most of them are written by people who have died thousands of years ago. ... If dad wanted me to have a job to keep me entertained that was a real non-starter." })
keywordHandler:addKeyword({ "ab'dendriel" }, StdModule.say, { npcHandler = npcHandler, text = "I have read all about the northern cities. It is almost as if I had been there myself." })
keywordHandler:addAliasKeyword({ "edron" })
keywordHandler:addAliasKeyword({ "kazordoon" })
keywordHandler:addAliasKeyword({ "venore" })
keywordHandler:addKeyword({ "librarian" }, StdModule.say, { npcHandler = npcHandler, text = "Yes. I administrate the library. You know - registering new books, sorting them in alphabetical order etc. ... To be honest I am not very good in this. Thank goodness daddy gave that magical blackboard to me. It is quite useful." })
keywordHandler:addKeyword({ "fa'hradin" }, StdModule.say, { npcHandler = npcHandler, text = "Uncle Fad is a weird guy. He is incredibly intelligent, but he is also totally inept in worldly matters. Sometimes I feel he is not quite at home in this world." })
keywordHandler:addKeyword({ "kha'labal" }, StdModule.say, { npcHandler = npcHandler, text = "That is the huge desert to the east. You can see it from here if you look in the direction of the rising sun. It seems huge... endless... It makes my heart sink whenever I watch it." })
keywordHandler:addKeyword({ "ankrahmun" }, StdModule.say, { npcHandler = npcHandler, text = "If there is one city I don't want to see it is Ankrahmun. I have heard all kinds of stories about the pharaoh and his cult of weirdos!" })
keywordHandler:addKeyword({ "darashia" }, StdModule.say, { npcHandler = npcHandler, text = "Darashia is a beautiful city to the north. I have been there! One day Daddy disguised himself, and he took me there. It was awesome. ... There was so much life and colour and excitement... I suppose he did it because he knew how much I yearned to go there. Bless him - he only wanted to help. But after that I felt worse than ever." })
keywordHandler:addKeyword({ "adopted" }, StdModule.say, { npcHandler = npcHandler, text = "I can't remember my parents. I... They have both died a long time. At least that is what I have been told. Listen, can we talk about something else?" })
keywordHandler:addKeyword({ "daraman" }, StdModule.say, { npcHandler = npcHandler, text = "Daraman was a human, but he must have been something very special - he was a holy man. To this day daddy and all the other djinn around here look up to Daraman as a true prophet." })
keywordHandler:addKeyword({ "pharaoh" }, StdModule.say, { npcHandler = npcHandler, text = "Apparently he is an undead! Yuk - how disgusting!" })
keywordHandler:addKeyword({ "efreet" }, StdModule.say, { npcHandler = npcHandler, text = "Apparently the greenskins are different from the Marid who have raised me. I don't know. Perhaps the Efreet would be more fun than the djinn around here, but then daddy says they are really evil." })
keywordHandler:addKeyword({ "humans" }, StdModule.say, { npcHandler = npcHandler, text = "I have lived here for as long as I can remember, but I know I don't belong here. I belong to them! I am a human! One day I will leave this place, and I will never come back." })
keywordHandler:addKeyword({ "gabel" }, StdModule.say, { npcHandler = npcHandler, text = "Gabel is my father. He runs this place. Of course, he is not my real daddy. But he {adopted} me, you know. Or rather, all the Marid adopted me." })
keywordHandler:addKeyword({ "marid" }, StdModule.say, { npcHandler = npcHandler, text = "The djinn you have met call themselves the Marid. They are generally very nice. Nice, but boring." })
keywordHandler:addKeyword({ "malor" }, StdModule.say, { npcHandler = npcHandler, text = "Malor is the leader of the Efreet. I have never seen him, but they say he is really nasty. Daddy always gets upset when this name is pronounced." })
keywordHandler:addKeyword({ "djinn" }, StdModule.say, { npcHandler = npcHandler, text = "The djinn are a curious race. They are nice, but they are always so serious. Oh, don't get me wrong, there is not a single djinn around here I do not like, but, you know, they are not much fun. ... I guess that is because they are all such devout followers of Daraman, but perhaps it is just because of all the bad things that have happened." })
keywordHandler:addKeyword({ "books" }, StdModule.say, { npcHandler = npcHandler, text = "The books around here are not exactly what I would call a riveting read. Most of them are technical documents written by uncle Fad at some point or other. Now and then he turns up and brings new files. Not that anybody would ever read them. ... It is my job to make sure they are filed and registered." })
keywordHandler:addKeyword({ "lamp" }, StdModule.say, { npcHandler = npcHandler, text = "When I was still a kid I could not understand how it could be that I was not able to sleep in a lamp. ... That was when I wanted nothing more than to be like the people around me. I may see things a bit more clearly now, but the feeling of yearning remains." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
