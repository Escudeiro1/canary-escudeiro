local internalNpcName = "A Goblin Exile"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 61,
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

keywordHandler:addKeyword({ "name" }, StdModule.say, { npcHandler = npcHandler, text = "Used to have one, when still in city. Left it behind. Now, old hermit waiting for goblin redemption I am. Nemmo Tokrok Argkaz Ar-Vanda Ho'Memot." })
keywordHandler:addKeyword({ "job" }, StdModule.say, { npcHandler = npcHandler, text = "Used to be philosopher priest shaman for East Waterwhirl clans! Keeper of sacredness! Truth teller! But this no say anything to you, hu-man. ... These days, me exile hermit waiting for new time. Keep things safe and hallow lost artefacts of goblins, for Frog God to look kindly on our last hope! ... Frog God leads me to places where find useful stuff needed for salvation of goblinkind. I pray, his golden eyes lead. I find. I hide." })
keywordHandler:addKeyword({ "golozo taku narkat kash bartak har-alhad" }, StdModule.say, { npcHandler = npcHandler, text = "You seen Golozo Taku Narkat Kash Bartak Har-Alhad! If him still alive, there still hope. Great leader, almost golden fire of Sugatrap in him. Him never give up." })
keywordHandler:addAliasKeyword({ "nibble" })
keywordHandler:addKeyword({ "nemmo tokrok argkaz ar-vanda ho'memot" }, StdModule.say, { npcHandler = npcHandler, text = "Not name, more description of what is. Roughly means, The One Who Is No-One, Whose Name Is Buried in Memories of Days Lost Behind Closed Eyes." })
keywordHandler:addKeyword({ "garamor avolok tor-mazak" }, StdModule.say, { npcHandler = npcHandler, text = "Ah, me know him. Young goblin scholar, heart of philosopher. Best pupil he was! ... Him rally other goblins in time of need and bear their soul load. Sign of golden eyes looking on him, great deed and burden, oh yes." })
keywordHandler:addKeyword({ "third time of peace" }, StdModule.say, { npcHandler = npcHandler, text = "Hopefully, time near when goblinkind free again. Me await sign every day." })
keywordHandler:addKeyword({ "night snake" }, StdModule.say, { npcHandler = npcHandler, text = "No story to tell in dark times, not here. Might come when called! Suffice it to say that it chases Frog God and hates cool earth and water, no friend of goblins." })
keywordHandler:addKeyword({ "hopgoblin" }, StdModule.say, { npcHandler = npcHandler, text = "Wisest goblin of past times, founded three school of rival philosophies! Very selfless goblin, died for goblinkind! ... His riddle stopped ogre killing long enough for goblins to flee back home, collapsing secret tunnels! But Hopgoblin stay behind and angry ogre kill him and break his staff. ... His broken staff in my family for hundred generations! Proud heirloom! One day will be made whole when goblins free again!" })
keywordHandler:addKeyword({ "swordfish" }, StdModule.say, { npcHandler = npcHandler, text = "Him best friend of Sugatrap. Bravest goblin scout, master of disguise and fleet-footed! Found city founding stone! Protector of city! ... Dressed up as ogre girl to distract hungry ogres from holy food finders! ... Sang snarky songs to lure ogres away from wounded Sugatrap, then ran back and carried him to nearest hidden tunnel entrance! ... Lots more stories but no time to tell, hu-man!" })
keywordHandler:addKeyword({ "frog god" }, StdModule.say, { npcHandler = npcHandler, text = "Holy, holy, holy. Poor goblin pray to Frog God for new time of peace for goblins!" })
keywordHandler:addKeyword({ "sugatrap" }, StdModule.say, { npcHandler = npcHandler, text = "No! You lie! That not true. Golden eyes averted from you!" })
keywordHandler:addKeyword({ "goblins" }, StdModule.say, { npcHandler = npcHandler, text = "For long time, goblins safe in mountains. Lived and prospered! Sang songs of golden times, passed on knowledge from old to new goblins! Then ogres came." })
keywordHandler:addKeyword({ "grubokk" }, StdModule.say, { npcHandler = npcHandler, text = "That name of mine jailer now? I remember other ogre jailer. Bit him into shin before me went into exile. Heheh." })
keywordHandler:addKeyword({ "peace" }, StdModule.say, { npcHandler = npcHandler, text = "Goblins wait for Third Time of Peace. Will be end of world as we know it. Frog God will return to be tadpole, Night Snake will devour skies and die, and earth will be one with water again." })
keywordHandler:addKeyword({ "ogres" }, StdModule.say, { npcHandler = npcHandler, text = "Always hungry, always, take, kill, eat, destroy! Must have been spawn spewn out by Night Snake to prey on poor Frog God children." })
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- npcType registering the npcConfig table
npcType:register(npcConfig)
