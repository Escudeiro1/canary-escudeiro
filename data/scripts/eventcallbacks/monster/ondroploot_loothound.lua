local callback = EventCallback("MonsterOnDropLootHound")

local LOOT_HOUND_NAME = "Loot Hound"
local petLootQueue = {}   -- [playerId] = { corpse, ... }
local petLoopRunning = {} -- [playerId] = true

local function getLootHound(player)
	for _, summon in pairs(player:getSummons()) do
		if summon:getName() == LOOT_HOUND_NAME then
			return summon
		end
	end
	return nil
end

local function processPetLootQueue(playerId)
	local player = Player(playerId)
	if not player then
		petLootQueue[playerId] = nil
		petLoopRunning[playerId] = nil
		return
	end

	local queue = petLootQueue[playerId]
	if not queue or #queue == 0 then
		petLootQueue[playerId] = nil
		petLoopRunning[playerId] = nil
		return
	end

	local corpse = table.remove(queue, 1)
	local pet = getLootHound(player)

	if pet and corpse then
		pet:teleportTo(corpse:getPosition(), false)
		player:quickLootCorpse(corpse)
	end

	addEvent(processPetLootQueue, 1500, playerId)
end

function callback.monsterOnDropLoot(monster, corpse)
	if not corpse then
		return
	end

	local ownerId = corpse:getCorpseOwner()
	if not ownerId or ownerId == 0 then
		return
	end

	local player = Player(ownerId)
	if not player or not getLootHound(player) then
		return
	end

	local playerId = player:getId()
	if not petLootQueue[playerId] then
		petLootQueue[playerId] = {}
	end
	table.insert(petLootQueue[playerId], corpse)

	if not petLoopRunning[playerId] then
		petLoopRunning[playerId] = true
		addEvent(processPetLootQueue, 1000, playerId)
	end
end

callback:register()
