local BTALISMAN_DAMAGE     = 290001
local BTALISMAN_LIFE_LEECH = 290002

local ec = EventCallback("BountyTalismanDamage")

function ec.playerOnCombat(player, target, item, damage)
	local damageBonus = player:getStorageValue(BTALISMAN_DAMAGE)
	if damageBonus <= 0 then
		return true
	end
	if not target or not target:isMonster() then
		return true
	end
	local mType = target:getType()
	local activeRaceId = player:getBountyActiveRaceId()
	if not mType or mType:raceId() ~= activeRaceId then
		logger.info("[debug-task] {} hit {} -- talisman damage bonus: No (raceId={} vs active={})",
			player:getName(), target:getName(), mType and mType:raceId() or 0, activeRaceId)
		return true
	end

	-- Damage boost
	local origPrimary = damage.primary.value
	if damage.primary.value < 0 then
		damage.primary.value = math.floor(damage.primary.value * (1 + damageBonus / 10000))
	end
	if damage.secondary.value < 0 then
		damage.secondary.value = math.floor(damage.secondary.value * (1 + damageBonus / 10000))
	end
	logger.info("[debug-task] {} hit {} -- talisman damage bonus: Yes (+{}h, primary {} -> {})",
		player:getName(), target:getName(), damageBonus, origPrimary, damage.primary.value)

	-- Life leech (talisman[1])
	local leechBonus = player:getStorageValue(BTALISMAN_LIFE_LEECH)
	if leechBonus > 0 then
		local totalDmg = 0
		if damage.primary.value < 0 then totalDmg = totalDmg + math.abs(damage.primary.value) end
		if damage.secondary.value < 0 then totalDmg = totalDmg + math.abs(damage.secondary.value) end
		local healAmount = math.max(1, math.floor(totalDmg * leechBonus / 10000))
		player:addHealth(healAmount)
		logger.info("[debug-task] {} leeched {} HP from {} ({}h bonus)",
			player:getName(), healAmount, target:getName(), leechBonus)
	end

	return true
end

ec:register()
