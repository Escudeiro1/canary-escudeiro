local internalNpcName = "Thorwulf"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 143,
	lookHead = 3,
	lookBody = 58,
	lookLegs = 97,
	lookFeet = 116,
	lookAddons = 1,
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

local node1 = keywordHandler:addKeyword({ "summon knight familiar" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {summon knight familiar} magic spell for 50000 gold?" })
node1:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = true, spellName = "summon knight familiar", vocation = { 4, 8 }, price = 50000, level = 200 })

local node2 = keywordHandler:addKeyword({ "chivalrous challenge" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {chivalrous challenge} magic spell for 250000 gold?" })
node2:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = true, spellName = "chivalrous challenge", vocation = { 4, 8 }, price = 250000, level = 150 })

local node3 = keywordHandler:addKeyword({ "fair wound cleansing" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {fair wound cleansing} magic spell for 500000 gold?" })
node3:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = true, spellName = "fair wound cleansing", vocation = { 4, 8 }, price = 500000, level = 300 })

local node4 = keywordHandler:addKeyword({ "fierce berserk" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {fierce berserk} magic spell for 7500 gold?" })
node4:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = true, spellName = "fierce berserk", vocation = { 4, 8 }, price = 7500, level = 90 })

local node5 = keywordHandler:addKeyword({ "intense recovery" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {intense recovery} magic spell for 10000 gold?" })
node5:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = true, spellName = "intense recovery", vocation = { 3, 4, 7, 8 }, price = 10000, level = 100 })

local node6 = keywordHandler:addKeyword({ "intense wound cleansing" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {intense wound cleansing} magic spell for 6000 gold?" })
node6:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = true, spellName = "intense wound cleansing", vocation = { 4, 8 }, price = 6000, level = 80 })

local node7 = keywordHandler:addKeyword({ "front sweep" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {front sweep} magic spell for 4000 gold?" })
node7:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = true, spellName = "front sweep", vocation = { 4, 8 }, price = 4000, level = 70 })

local node8 = keywordHandler:addKeyword({ "groundshaker" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {groundshaker} magic spell for 1500 gold?" })
node8:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = true, spellName = "groundshaker", vocation = { 4, 8 }, price = 1500, level = 33 })

local node9 = keywordHandler:addKeyword({ "inflict wound" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {inflict wound} magic spell for 2500 gold?" })
node9:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = true, spellName = "inflict wound", vocation = { 4, 8, 9, 10 }, price = 2500, level = 40 })

local node10 = keywordHandler:addKeyword({ "whirlwind throw" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {whirlwind throw} magic spell for 1500 gold?" })
node10:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = true, spellName = "whirlwind throw", vocation = { 4, 8 }, price = 1500, level = 28 })

local node11 = keywordHandler:addKeyword({ "annihilation" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {annihilation} magic spell for 20000 gold?" })
node11:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = true, spellName = "annihilation", vocation = { 4, 8 }, price = 20000, level = 110 })

local node12 = keywordHandler:addKeyword({ "berserk" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {berserk} magic spell for 2500 gold?" })
node12:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = true, spellName = "berserk", vocation = { 4, 8 }, price = 2500, level = 35 })

local node13 = keywordHandler:addKeyword({ "brutal strike" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {brutal strike} magic spell for 1000 gold?" })
node13:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "brutal strike", vocation = { 4, 8 }, price = 1000, level = 16 })

local node14 = keywordHandler:addKeyword({ "charge" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {charge} magic spell for 1300 gold?" })
node14:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = true, spellName = "charge", vocation = { 4, 8 }, price = 1300, level = 25 })

local node15 = keywordHandler:addKeyword({ "cure bleeding" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {cure bleeding} magic spell for 2500 gold?" })
node15:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = true, spellName = "cure bleeding", vocation = { 2, 4, 6, 8 }, price = 2500, level = 45 })

local node16 = keywordHandler:addKeyword({ "cure poison" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {cure poison} magic spell for 150 gold?" })
node16:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "cure poison", vocation = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, price = 150, level = 10 })

local node17 = keywordHandler:addKeyword({ "find fiend" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {find fiend} magic spell for 1000 gold?" })
node17:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "find fiend", vocation = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, price = 1000, level = 25 })

local node18 = keywordHandler:addKeyword({ "find person" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {find person} magic spell for 80 gold?" })
node18:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "find person", vocation = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, price = 80, level = 8 })

local node19 = keywordHandler:addKeyword({ "great light" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {great light} magic spell for 500 gold?" })
node19:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "great light", vocation = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, price = 500, level = 13 })

local node20 = keywordHandler:addKeyword({ "haste" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {haste} magic spell for 600 gold?" })
node20:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "haste", vocation = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, price = 600, level = 14 })

local node21 = keywordHandler:addKeyword({ "lesser front sweep" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {lesser front sweep} magic spell for free?" })
node21:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "lesser front sweep", vocation = { 4, 8 }, price = 0, level = 1 })

local node22 = keywordHandler:addKeyword({ "levitate" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {levitate} magic spell for 500 gold?" })
node22:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "levitate", vocation = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, price = 500, level = 12 })

local node23 = keywordHandler:addKeyword({ "light" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {light} magic spell for free?" })
node23:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "light", vocation = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, price = 0, level = 8 })

local node24 = keywordHandler:addKeyword({ "magic rope" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {magic rope} magic spell for 200 gold?" })
node24:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "magic rope", vocation = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, price = 200, level = 9 })

local node25 = keywordHandler:addKeyword({ "recovery" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {recovery} magic spell for 4000 gold?" })
node25:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = true, spellName = "recovery", vocation = { 3, 4, 7, 8 }, price = 4000, level = 50 })

local node26 = keywordHandler:addKeyword({ "wound cleansing" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {wound cleansing} magic spell for free?" })
node26:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "wound cleansing", vocation = { 4, 8 }, price = 0, level = 8 })

local node27 = keywordHandler:addKeyword({ "bruise bane" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "Would you like to learn {bruise bane} magic spell for free?" })
node27:addChildKeyword({ "yes" }, StdModule.learnSpell, { npcHandler = npcHandler, premium = false, spellName = "bruise bane", vocation = { 4, 8 }, price = 0, level = 1 })

keywordHandler:addKeyword({ "gods" }, StdModule.say, { npcHandler = npcHandler, text = "I couldn't care less for gods. Every true warrior creates his own fortune." })
keywordHandler:addKeyword({ "monsters" }, StdModule.say, { npcHandler = npcHandler, text = "Monsters are a challenge for the heart and the body of a fighter. Those who are worthy will grow on it, the unworthy will perish." })
keywordHandler:addKeyword({ "news" }, StdModule.say, { npcHandler = npcHandler, text = "There are no news ... yet. But I can smell blood and steel in the air. I can feel it, there is going to be a battle soon." })
keywordHandler:addKeyword({ "excalibug" }, StdModule.say, { npcHandler = npcHandler, text = "A true warrior will kill his opponents with a rusty knife. There is no need for a mighty weapon. Where is the honour if the weapon is more powerful than its wielder?" })
keywordHandler:addKeyword({ "ferumbras" }, StdModule.say, { npcHandler = npcHandler, text = "Bah, to know that he is a sorcerer means to know that he is a coward." })
keywordHandler:addKeyword({ "carlin" }, StdModule.say, { npcHandler = npcHandler, text = "I care little for the people from Carlin. All of them are so weak and timid. I could not care less for their concerns. If they want something to be done, they will have to do it on their own." })
keywordHandler:addKeyword({ "thais" }, StdModule.say, { npcHandler = npcHandler, text = "Thais is not better than Carlin." })
keywordHandler:addKeyword({ "king" }, StdModule.say, { npcHandler = npcHandler, text = "How can someone who never proved himself as a warrior lead people into a battle?" })
keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "I am Thorwulf, slayer of dragons, giants and yetis." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "I am an expert fighter and I can teach a true warrior in the arts of war." })
keywordHandler:addKeyword({ "healing", "spells" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "In this category I have '{Bruise Bane}', '{Cure Bleeding}', '{Wound Cleansing}', \z
		'{Cure Poison}', '{Intense Wound Cleansing}', '{Recovery}' and '{Intense Recovery}'.",
})
keywordHandler:addKeyword({ "attack", "spells" }, StdModule.say, {
	npcHandler = npcHandler,
	text = { "In this category I have '{Whirlwind Throw}', '{Groundshaker}', '{Berserk}' and '{Fierce Berserk}' \z
		as well as ...", "'{Brutal Strike}', '{Front Sweep}', '{Inflict Wound}' and '{Annihilation}'" },
})
keywordHandler:addKeyword({ "support", "spells" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "In this category I have '{Light}', '{Find Person}', '{Magic Rope}', '{Levitate}', '{Haste}', \z
		'{Charge}' and '{Great Light}'.",
})
keywordHandler:addKeyword({ "spells" }, StdModule.say, {
	npcHandler = npcHandler,
	text = "I can teach you {attack} spells, {healing} spells and {support} spells. What kind of spell do you wish to learn? I can also tell you which spells are available at your {level}.",
})

keywordHandler:addKeyword({ "attack" }, StdModule.say, {
	npcHandler = npcHandler,
	onlyFocus = true,
	text = "My attack spells are: {Annihilation}, {Berserk}, {Brutal Strike}, {Chivalrous Challenge}, {Fierce Berserk}, {Front Sweep}, {Groundshaker}, {Inflict Wound}, {Lesser Front Sweep} and {Whirlwind Throw}.",
})

keywordHandler:addKeyword({ "healing" }, StdModule.say, {
	npcHandler = npcHandler,
	onlyFocus = true,
	text = "My healing spells are: {Bruise Bane}, {Cure Bleeding}, {Cure Poison}, {Fair Wound Cleansing}, {Intense Recovery}, {Intense Wound Cleansing}, {Recovery} and {Wound Cleansing}.",
})

keywordHandler:addKeyword({ "support" }, StdModule.say, {
	npcHandler = npcHandler,
	onlyFocus = true,
	text = "My support spells are: {Charge}, {Find Fiend}, {Find Person}, {Great Light}, {Haste}, {Levitate}, {Light}, {Magic Rope} and {Summon Knight Familiar}.",
})

local nodeLevels = keywordHandler:addKeyword({ "level" }, StdModule.say, {
	npcHandler = npcHandler,
	onlyFocus = true,
	text = "I have spells for level {1}, {8}, {9}, {10}, {12}, {13}, {14}, {16}, {25}, {28}, {33}, {35}, {40}, {45}, {50}, {70}, {80}, {90}, {100}, {110}, {150}, {200} and {300}.",
})

nodeLevels:addChildKeyword({ "300" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 300 I have {Fair Wound Cleansing} for 500000 gold." })
nodeLevels:addChildKeyword({ "200" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 200 I have {Summon Knight Familiar} for 50000 gold." })
nodeLevels:addChildKeyword({ "150" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 150 I have {Chivalrous Challenge} for 250000 gold." })
nodeLevels:addChildKeyword({ "110" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 110 I have {Annihilation} for 20000 gold." })
nodeLevels:addChildKeyword({ "100" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 100 I have {Intense Recovery} for 10000 gold." })
nodeLevels:addChildKeyword({ "90" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 90 I have {Fierce Berserk} for 7500 gold." })
nodeLevels:addChildKeyword({ "80" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 80 I have {Intense Wound Cleansing} for 6000 gold." })
nodeLevels:addChildKeyword({ "70" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 70 I have {Front Sweep} for 4000 gold." })
nodeLevels:addChildKeyword({ "50" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 50 I have {Recovery} for 4000 gold." })
nodeLevels:addChildKeyword({ "45" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 45 I have {Cure Bleeding} for 2500 gold." })
nodeLevels:addChildKeyword({ "40" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 40 I have {Inflict Wound} for 2500 gold." })
nodeLevels:addChildKeyword({ "35" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 35 I have {Berserk} for 2500 gold." })
nodeLevels:addChildKeyword({ "33" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 33 I have {Groundshaker} for 1500 gold." })
nodeLevels:addChildKeyword({ "28" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 28 I have {Whirlwind Throw} for 1500 gold." })
nodeLevels:addChildKeyword({ "25" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 25 I have {Charge} for 1300 gold and {Find Fiend} for 1000 gold." })
nodeLevels:addChildKeyword({ "16" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 16 I have {Brutal Strike} for 1000 gold." })
nodeLevels:addChildKeyword({ "14" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 14 I have {Haste} for 600 gold." })
nodeLevels:addChildKeyword({ "13" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 13 I have {Great Light} for 500 gold." })
nodeLevels:addChildKeyword({ "12" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 12 I have {Levitate} for 500 gold." })
nodeLevels:addChildKeyword({ "10" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 10 I have {Cure Poison} for 150 gold." })
nodeLevels:addChildKeyword({ "9" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 9 I have {Magic Rope} for 200 gold." })
nodeLevels:addChildKeyword({ "8" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 8 I have {Find Person} for 80 gold, {Light} for free and {Wound Cleansing} for free." })
nodeLevels:addChildKeyword({ "1" }, StdModule.say, { npcHandler = npcHandler, onlyFocus = true, text = "For level 1 I have {Bruise Bane} for free and {Lesser Front Sweep} for free." })
keywordHandler:addKeyword({ "years of serpents" }, StdModule.say, { npcHandler = npcHandler, text = "Men are not supposed to travel the seas. So I don't care if these giant serpents ever existed or if they had only been an excuse for cowards." })
keywordHandler:addKeyword({ "join" }, StdModule.say, { npcHandler = npcHandler, text = "Even if someone passes the barbarian test, there is still much left to prove. I don't accept foreigners that easily." })
keywordHandler:addAliasKeyword({ "barbarian test" })
keywordHandler:addKeyword({ "how are you" }, StdModule.say, { npcHandler = npcHandler, text = "As long as I am not fighting, I am bored." })
keywordHandler:addKeyword({ "edron" }, StdModule.say, { npcHandler = npcHandler, text = "Some far away place the people of Carlin talk about now and then." })
keywordHandler:addAliasKeyword({ "port hope" })
keywordHandler:addKeyword({ "svargrond" }, StdModule.say, { npcHandler = npcHandler, text = "I hate it to wait here for our enemies to arrive. I'd rather go out and wage war in their camps and lairs." })
keywordHandler:addKeyword({ "barbarian" }, StdModule.say, { npcHandler = npcHandler, text = "Most people have forgotten that being a true barbarian means to be a fearless fighter." })
keywordHandler:addKeyword({ "zathroth" }, StdModule.say, { npcHandler = npcHandler, text = "Some dark god whose name some people only dare to whisper. One day those people will start running from their own shadow." })
keywordHandler:addKeyword({ "bonelord" }, StdModule.say, { npcHandler = npcHandler, text = "I heard about such creatures. We have none of them here but I doubt they'd be much of a challenge. Who would be afraid of some floating eye after all?" })
keywordHandler:addKeyword({ "mission" }, StdModule.say, { npcHandler = npcHandler, text = "I don't have anything to do for you." })
keywordHandler:addAliasKeyword({ "task" })
keywordHandler:addAliasKeyword({ "quest" })
keywordHandler:addKeyword({ "shamans" }, StdModule.say, { npcHandler = npcHandler, text = "All they are doing is talking to the spirits the whole day. My enemies, however, are of flesh and blood and I can handle them on my own." })
keywordHandler:addKeyword({ "rumours" }, StdModule.say, { npcHandler = npcHandler, text = "A few years ago there was an arena fighter named Alrik. He managed to win the Warlord title three times in a row. He was Svargrond's greatest hero and all of a sudden he was gone and never seen again. ... Even his sculpture disappeared. The people say Chyll took him directly to Everspring where he could live a king's life as a reward." })
keywordHandler:addKeyword({ "enemies" }, StdModule.say, { npcHandler = npcHandler, text = "There are many challenges in our lands that are awaiting brave warriors. There are fearsome dragons, the ferocious chakoyas, the honourless raiders and the giants that are ... oh well, quite big." })
keywordHandler:addKeyword({ "chakoya" }, StdModule.say, { npcHandler = npcHandler, text = "The chakoyas are small but their teeth can shred a man's arm into pieces. Their strength lies in their number as well as in ambushes on unwary or sleeping persons." })
keywordHandler:addKeyword({ "raiders" }, StdModule.say, { npcHandler = npcHandler, text = "Their cowardly tactics are a shame for every true barbarian, so is their obedience to a witch. They are not even worthy opponents." })
keywordHandler:addKeyword({ "nibelor" }, StdModule.say, { npcHandler = npcHandler, text = "A boring piece of ice and rock on which only shamans live." })
keywordHandler:addKeyword({ "druids" }, StdModule.say, { npcHandler = npcHandler, text = "As far as I understood it, druids are like our shamans. I know enough magic to defeat my opponents on my own. So I have only little use for such spell casters." })
keywordHandler:addKeyword({ "venore" }, StdModule.say, { npcHandler = npcHandler, text = "For all I know, they are schemers and liars. That means they are even worse than the other southerners." })
keywordHandler:addKeyword({ "dragon" }, StdModule.say, { npcHandler = npcHandler, text = "The dragons of these lands are fierce as a blizzard and lethal as the silent cold and the howling snow storm alike." })
keywordHandler:addKeyword({ "leader" }, StdModule.say, { npcHandler = npcHandler, text = "Our city is lead by our jarl Sven the Younger. A jarl is a person that is respected by the people, not like those kings or queens of far away lands." })
keywordHandler:addKeyword({ "coward" }, StdModule.say, { npcHandler = npcHandler, text = "You talked to Robert, did you? I think I scared him pretty well! Hehehe!" })
keywordHandler:addKeyword({ "queen" }, StdModule.say, { npcHandler = npcHandler, text = "The people from Carlin seem to respect their queen. Though, I can't understand why. She is hardly a warrior." })
keywordHandler:addKeyword({ "banor" }, StdModule.say, { npcHandler = npcHandler, text = "Some strange warrior god from the south. Seeing what kind of warriors those people are that god is not doing an impressive job if you ask me." })
keywordHandler:addKeyword({ "dwarf" }, StdModule.say, { npcHandler = npcHandler, text = "I haven't seen many of them around here." })
keywordHandler:addKeyword({ "camps" }, StdModule.say, { npcHandler = npcHandler, text = "The raiders have some camps in the South. If I want some fun, I go there and challenge some of those cowards." })
keywordHandler:addKeyword({ "mines" }, StdModule.say, { npcHandler = npcHandler, text = "Those Carliners seem to care about those mines, but they don't have the guts to recapture them. Pathetic." })
keywordHandler:addKeyword({ "chyll" }, StdModule.say, { npcHandler = npcHandler, text = "The wind that has seen all battles and that puts an icy blanket over the battlefields." })
keywordHandler:addKeyword({ "yeti" }, StdModule.say, { npcHandler = npcHandler, text = "The yetis are powerful and cunning foes. It takes the right bait to lure them out of their hiding places." })
keywordHandler:addKeyword({ "bait" }, StdModule.say, { npcHandler = npcHandler, text = "I won't tell. Never ever. Find out on your own." })
keywordHandler:addKeyword({ "cult" }, StdModule.say, { npcHandler = npcHandler, text = "I don't care about cults." })
keywordHandler:addKeyword({ "jarl" }, StdModule.say, { npcHandler = npcHandler, text = "Our jarl has grown old. I honour him for his deeds in the past but I wonder if a younger leader wouldn't be better now. He could lead us into glorious battles with the raiders." })

npcHandler:setMessage(MESSAGE_GREET, "Hi |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Bye |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Bye.")

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
