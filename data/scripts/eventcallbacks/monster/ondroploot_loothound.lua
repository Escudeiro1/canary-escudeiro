local callback = EventCallback("MonsterOnDropLootHound")

local LOOT_HOUND_NAME = "Loot Hound"
local COLLECT_WINDOW = 1000  -- ms to wait after first kill, collecting the whole pack
local STEP_MS = 250           -- ms between each walk step
local CORPSE_MS = 400         -- ms to pause at corpse before moving to next

local petLootQueue = {}   -- [playerId] = { corpse, ... }
local petLoopRunning = {} -- [playerId] = true
local petWalkState = {}   -- [playerId] = { path = {...}, index = N, corpse = item }

local walkStep  -- forward declaration; defined after processPetLootQueue

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

	if not pet or not corpse then
		addEvent(processPetLootQueue, CORPSE_MS, playerId)
		return
	end

	local path = pet:getPathTo(corpse:getPosition(), 0, 1, true, true, 30)
	if not path or type(path) ~= "table" or #path == 0 then
		-- no path found — teleport as fallback so loot is never skipped
		pet:teleportTo(corpse:getPosition(), false)
		player:quickLootCorpse(corpse)
		addEvent(processPetLootQueue, CORPSE_MS, playerId)
		return
	end

	-- path[#path] = first step from pet, path[1] = last step near corpse
	petWalkState[playerId] = { path = path, index = #path, corpse = corpse }
	addEvent(walkStep, STEP_MS, playerId)
end

walkStep = function(playerId)
	local state = petWalkState[playerId]
	if not state then
		return
	end

	local player = Player(playerId)
	if not player then
		petWalkState[playerId] = nil
		petLootQueue[playerId] = nil
		petLoopRunning[playerId] = nil
		return
	end

	local pet = getLootHound(player)
	if not pet then
		petWalkState[playerId] = nil
		petLoopRunning[playerId] = nil
		return
	end

	if state.index < 1 then
		-- arrived at corpse
		petWalkState[playerId] = nil
		player:quickLootCorpse(state.corpse)
		pet:setFollowCreature(player)  -- restore normal follow
		addEvent(processPetLootQueue, CORPSE_MS, playerId)
		return
	end

	-- Before each step: suppress the C++ follow-master walk scheduler.
	-- setFollowCreature(player) clears listWalkDir (any queued master-path steps).
	-- setFollowCreature(nil) cancels the async path recalculation that was just dispatched.
	-- This works because our 250ms step interval is shorter than the walk event delay (~640ms),
	-- so the scheduler can never consume a step between our walkStep calls.
	pet:setFollowCreature(player)
	pet:setFollowCreature(nil)

	pet:move(state.path[state.index])
	state.index = state.index - 1
	addEvent(walkStep, STEP_MS, playerId)
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

	-- Only schedule the loop on the first corpse of a new wave.
	-- Subsequent kills within COLLECT_WINDOW append to the queue and get picked up automatically.
	if not petLoopRunning[playerId] then
		petLoopRunning[playerId] = true
		addEvent(processPetLootQueue, COLLECT_WINDOW, playerId)
	end
end

callback:register()
