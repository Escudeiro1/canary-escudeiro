local internalNpcName = "Kalvin"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 132,
	lookHead = 115,
	lookBody = 117,
	lookLegs = 120,
	lookFeet = 126,
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

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "My name is Kalvin." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I'm an apprentice of Hugo. My current task is to inform everyone about our summer collection." })
keywordHandler:addKeyword({ "hand of inquisition" }, StdModule.say, { npcHandler = npcHandler, text = "The Inquisition grants this outfit only to their most trusted agents." })
keywordHandler:addKeyword({ "illuminated warrior" }, StdModule.say, { npcHandler = npcHandler, text = "A radiant outfit that can only be obtained in the distant kingdom of Thalassara by facing an enigmatic new god of Light." })
keywordHandler:addKeyword({ "crystal warlord" }, StdModule.say, { npcHandler = npcHandler, text = "A true warrior's attire! A striking armor and cloak, adorned with obsidian and crystals. You might want to visit the gnomes at Kazordoon if you wish to acquire this outfit. The hard part will be to earn their trust though." })
keywordHandler:addKeyword({ "glooth engineer" }, StdModule.say, { npcHandler = npcHandler, text = "The Rathleton Magistrate rewards people dedicated to their city with this outfit. If you can avert a dire threat for the city, it might be yours to wear." })
keywordHandler:addKeyword({ "premium outfit" }, StdModule.say, { npcHandler = npcHandler, text = "Premium outfits are only available to characters on a premium account. They include the nobleman outfit, the summoner outfit, the warrior outfit, the barbarian outfit, the wizard outfit, the oriental outfit and the druid outfit." })
keywordHandler:addKeyword({ "soil guardian" }, StdModule.say, { npcHandler = npcHandler, text = "Sometimes, the reclusive gnomes grant a dedicated helper the privilege to wear a special outfit like this one: the Soil Guardian. The riches of the Earth are shadowed out in the mushroom decor and the berg crystals embroidered. ... You might want to visit the gnomes at Kazordoon if you fancy this outfit. The hard part will be to earn their trust though." })
keywordHandler:addKeyword({ "cave explorer" }, StdModule.say, { npcHandler = npcHandler, text = "The practical attire for all who venture deep into the heart of the earth and a gnome's best friend: the cave explorer outfit! ... Handcrafted and awarded exclusively by the gnomes in the Spike to those who braved the dangers of the place and earned their gratitude." })
keywordHandler:addKeyword({ "elementalist" }, StdModule.say, { npcHandler = npcHandler, text = "With invisible air patterns and arcane sigils, it radiates that the wearer has the powers of the elements at his disposal. I believe you have to face a rogue mage near Edron to earn it." })
keywordHandler:addKeyword({ "demon hunter" }, StdModule.say, { npcHandler = npcHandler, text = "I think the members of the inquisition award this outfit to their members when they have reached a certain rank. They hide somewhere under Thais." })
keywordHandler:addKeyword({ "dreamwarrior" }, StdModule.say, { npcHandler = npcHandler, text = "Dream Warriors defend the Dream Courts against unwanted intruders, be it from the real world or from the Nightmare Realms. Only rarely the dream elves grant the right to wear it to outsiders." })
keywordHandler:addKeyword({ "fiend slayer" }, StdModule.say, { npcHandler = npcHandler, text = "There are rumours about an ancient keep were such an outfit might be acquired through heroic deeds." })
keywordHandler:addKeyword({ "free outfit" }, StdModule.say, { npcHandler = npcHandler, text = "Well, we have the traditional knight outfit, the hunter outfit, the mage outfit and the citizen outfit. And, provided you find a partner, there is a newly wed outfit, too." })
keywordHandler:addKeyword({ "brotherhood" }, StdModule.say, { npcHandler = npcHandler, text = "They were the followers of Goshnar, the king of necromancy. They fought the Nightmare Knights without knowing any limits. It might be a foolish thing to look for them but if you are interested, the Plains of Havoc are a good start." })
keywordHandler:addKeyword({ "dreamwarden" }, StdModule.say, { npcHandler = npcHandler, text = "As a dream warden, there is nothing you can't vanquish. Dreams, nightmares and illusions can't scare you anymore. Go to Roshamuul, if you desire such an outfit and search for it there." })
keywordHandler:addKeyword({ "poltergeist" }, StdModule.say, { npcHandler = npcHandler, text = "With this angst-inducing vestment you are able to wander around Tibia and scare many an unsuspecting wayfarer. But you have to defeat the dreaded Pale Worm first." })
keywordHandler:addKeyword({ "riftwarrior" }, StdModule.say, { npcHandler = npcHandler, text = "Go through hell. Seven times. Defeat the demons. Countless times. Put an end to Ferumbras' claims to ascendancy, once and for all. Then you may call yourself a rift warrior and dress appropriately." })
keywordHandler:addKeyword({ "collection" }, StdModule.say, { npcHandler = npcHandler, text = "We have designed many new dresses, cloaks, armors, hats, weapons... commonly referred to as outfits and addons." })
keywordHandler:addKeyword({ "yalaharian" }, StdModule.say, { npcHandler = npcHandler, text = "The people travel to Yalahar and come back with these fancy clothings. One of them told me that the Edron Academy is sending people to this ancient city." })
keywordHandler:addKeyword({ "battlemage" }, StdModule.say, { npcHandler = npcHandler, text = "Battlemages know how to combine arcane knowledge with wielding a sword. They often explore secret and dangerous sites of hidden or forgotten knowledge." })
keywordHandler:addKeyword({ "discoverer" }, StdModule.say, { npcHandler = npcHandler, text = "If you are interested in travelling and discovering the world of Tibia, this might be the perfect outfit for you. ... Whether you are visiting the dry Daramian deserts, the icy mountains of Hrodmir or the deep Tiquandan jungle, you will always be well prepared for every encounter and adventure." })
keywordHandler:addKeyword({ "rootwalker" }, StdModule.say, { npcHandler = npcHandler, text = "Being one with a botanical being would require the will to live and feel the plant through and through, like a transformation from within." })
keywordHandler:addKeyword({ "newly wed" }, StdModule.say, { npcHandler = npcHandler, text = "Pick a wedding partner and time and this outfit can be yours! Snow-white silk and lace for the glowing bride, including a veil and blossom circlet for that most special day. ... For the groom, a fine black frock-coat with brazen buttons, and white silk knee socks to lead your lady to the altar in style." })
keywordHandler:addKeyword({ "barbarian" }, StdModule.say, { npcHandler = npcHandler, text = "This outfit stands for raw power, battle cries and lack of manners. I heard that there are a few barbarians living near Northport. They might just be able to provide fitting addons." })
keywordHandler:addKeyword({ "afflicted" }, StdModule.say, { npcHandler = npcHandler, text = "I heard it is the latest rage for all feverish citizens. Dropped by genuinely afflicted and specially tailored to your every need. Visit the swamp city of Venore if you fancy gaining this outfit." })
keywordHandler:addKeyword({ "warmaster" }, StdModule.say, { npcHandler = npcHandler, text = "Styled after the exotic armors of the Lizardmen in the lands of faraway Zao. I heard you might get your hands on one if you help the dwarves establishing a mining base there." })
keywordHandler:addKeyword({ "insectoid" }, StdModule.say, { npcHandler = npcHandler, text = "Quite a buzz around this one, but you don't need a wasp waist to wear it! Comes with a mandible epaulette addon - Word is they wear this at the grey beach area, where they are fighting the insectoid hive." })
keywordHandler:addKeyword({ "nightmare" }, StdModule.say, { npcHandler = npcHandler, text = "This noble order vanished a long time ago. They were once located at the Plains of Havoc. Maybe you can find some hints about their remains if you go there. But be careful, it is a very dangerous area!" })
keywordHandler:addKeyword({ "makeshift" }, StdModule.say, { npcHandler = npcHandler, text = "Necessity is the mother of invention! For most of us this is just trash, but combined in the right way it will become a more than veritable equipment. Look at the corym! They show us how it works!" })
keywordHandler:addKeyword({ "rascoohan" }, StdModule.say, { npcHandler = npcHandler, text = "There is an island named Rascacoon, and there you might find this outfit. Of course, you have to receive the Rascoohans' permission to wear it. Try to honour them with special gifts." })
keywordHandler:addKeyword({ "nobleman" }, StdModule.say, { npcHandler = npcHandler, text = "One of our finest pieces. If you have the money and wish to show how wealthy and noble you are, this is the outfit for you. We also create addons especially for you, right here." })
keywordHandler:addKeyword({ "summoner" }, StdModule.say, { npcHandler = npcHandler, text = "Great for young mages and ladies who love witchcraft. If you are looking to earn addons, gentlemen should take a stroll in Port Hope, whereas ladies should explore the Dark Cathedral." })
keywordHandler:addKeyword({ "oriental" }, StdModule.say, { npcHandler = npcHandler, text = "This comfortable, yet fashionable outfit will create the romantic mood of Thousand and One Nights. A good place to look around for addons are naturally Darama and Ankrahmun." })
keywordHandler:addKeyword({ "assassin" }, StdModule.say, { npcHandler = npcHandler, text = "Mysterious and lethal, assassins are hard to find and almost impossible to befriend. I know of one assassin hiding away on the Daramian Plague Spire. If you are lucky, he won't kill you." })
keywordHandler:addKeyword({ "deepling" }, StdModule.say, { npcHandler = npcHandler, text = "I have never laid eyes on one of those before. Notice the strage set of scale armor, crafted by long lost creatures of the deep. But beware, it is said that it has a life of its own - treat it carefully." })
keywordHandler:addKeyword({ "norseman" }, StdModule.say, { npcHandler = npcHandler, text = "This cosy outfit will keep you warm in the deepest winters. The inhabitants of Svargrond use it to travel around their frozen islands." })
keywordHandler:addKeyword({ "decaying" }, StdModule.say, { npcHandler = npcHandler, text = "The dark power of rot and decay may have been harvested by mighty beings throughout time and space but only true mastery will grant you the right to wear an outfit like that." })
keywordHandler:addKeyword({ "falconer" }, StdModule.say, { npcHandler = npcHandler, text = "Don't let your Hunting Task Points go to waste, collect them and trade them in for an outfit worthy only for the most elite hunters." })
keywordHandler:addKeyword({ "revenant" }, StdModule.say, { npcHandler = npcHandler, text = "If you defeat the manifestation of Goshnar's evil traits by fighting your way through beasts you didn't even want to imagine ... then you might also look the part." })
keywordHandler:addKeyword({ "citizen" }, StdModule.say, { npcHandler = npcHandler, text = "Your basic starter outfit - simple, but practical. If you are looking to earn addons for this outfit, you should walk around Thais and look for citizens wearing a hat or a backpack." })
keywordHandler:addKeyword({ "warrior" }, StdModule.say, { npcHandler = npcHandler, text = "The lighter version of the knight outfit is great if you want to save stamina and maintain agility. Addons are usually awarded by knight guilds." })
keywordHandler:addKeyword({ "festive" }, StdModule.say, { npcHandler = npcHandler, text = "If you want to wear those clothes, you have to meet the legendary First Dragon - and survive. That would be a reason to celebrate for sure." })
keywordHandler:addKeyword({ "outfit" }, StdModule.say, { npcHandler = npcHandler, text = "Ah, I can tell you all about the newest range of patterns! There are, all in all, four free outfits, seven premium outfits, and nine quest outfits." })
keywordHandler:addKeyword({ "addons" }, StdModule.say, { npcHandler = npcHandler, text = "Addons are usually accessories. Each outfit has two addons which can be worn only together with this outfit. All addons have to be earned through quests." })
keywordHandler:addKeyword({ "irmana" }, StdModule.say, { npcHandler = npcHandler, text = "Such a beautiful and charming lady." })
keywordHandler:addKeyword({ "knight" }, StdModule.say, { npcHandler = npcHandler, text = "If you spend your time fighting monsters and need that little extra protection, this well-armored outfit is great for you. Addons are usually awarded by knight guilds." })
keywordHandler:addKeyword({ "hunter" }, StdModule.say, { npcHandler = npcHandler, text = "A light and comfortable ranger outfit which every paladin simply loves to wear. If you are looking to earn addons for this outfit, a good place to start would be the paladin guild in Thais." })
keywordHandler:addKeyword({ "wizard" }, StdModule.say, { npcHandler = npcHandler, text = "Are you feeling evil today? This outfit is fitting for mages pursuing the dark side of sorcery. Shunned by the magic academy of Edron, you might find wizards hiding near Thais." })
keywordHandler:addKeyword({ "pirate" }, StdModule.say, { npcHandler = npcHandler, text = "Yo ho ho and a bottle of rum! If you love the pirate way of life and sneer at landlubbers, this might be the right outfit for you. Pirates are said to roam the Shattered Isles..." })
keywordHandler:addKeyword({ "beggar" }, StdModule.say, { npcHandler = npcHandler, text = "Ah, Hugo is working on designing this look. He might need some inspiration, so if you have some time to spare, don't hesitate to contribute some ideas to him." })
keywordHandler:addKeyword({ "shaman" }, StdModule.say, { npcHandler = npcHandler, text = "If you have seen everything and worn every look, this outfit will put the icing on your cake. Maybe you can earn it by becoming the apprentice of a shaman... or voodoo priest." })
keywordHandler:addKeyword({ "jester" }, StdModule.say, { npcHandler = npcHandler, text = "You really want to look like a jester?? Well, then you should go visit Bozo. Maybe you are foolish enough to join his newly founded fools guild. Normally, you find him at the castle in Thais." })
keywordHandler:addKeyword({ "percht" }, StdModule.say, { npcHandler = npcHandler, text = "Walking through the cold, icy darkness of winter as a denizen of frost... is this your thing? ... Then find and confront the percht during the twilight around the time the year is nearing its end." })
keywordHandler:addKeyword({ "quest" }, StdModule.say, { npcHandler = npcHandler, text = "Many addon quests require that a number of ingredients are collected." })
keywordHandler:addKeyword({ "druid" }, StdModule.say, { npcHandler = npcHandler, text = "Nature-loving and peaceful druids might like this outfit, especially the beastlike addons. I heard there is a druid living near Ab'Dendriel, who might be able to provide fitting addons." })
keywordHandler:addKeyword({ "demon" }, StdModule.say, { npcHandler = npcHandler, text = "This garment is granted only after many a toil and if you defeated some nasty demons, I believe... you should talk to someone called Avar Tar about the details. You'll find him in Edron." })
keywordHandler:addKeyword({ "aucar" }, StdModule.say, { npcHandler = npcHandler, text = "Fighting like a proud ancient warrior of a lost culture like that surely requires a fitting attire. ... The only way must be to challenge such a warrior in the flesh, but that sounds impossible to me." })
keywordHandler:addKeyword({ "hugo" }, StdModule.say, { npcHandler = npcHandler, text = "I hope that one day I will have grand visions, too." })
keywordHandler:addKeyword({ "mage" }, StdModule.say, { npcHandler = npcHandler, text = "Great for wise old male mages as well as for pretty enchantresses. If you are looking to earn addons, ladies should take a stroll in Port Hope, whereas elders should explore the Dark Cathedral." })
keywordHandler:addKeyword({ "fire" }, StdModule.say, { npcHandler = npcHandler, text = "If you want to become a hero by fighting raging flames you need to be dressed appropriately. ... This special outfit is rumored to be achieved by assisting the challenger expedition in Gnomprona - wherever that might be." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
