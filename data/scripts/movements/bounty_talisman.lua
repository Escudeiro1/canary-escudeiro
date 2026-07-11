local BTALISMAN = {
	DAMAGE_HUNDREDTHS      = 290001, -- talisman[0]: Damage Against Creatures
	LIFE_LEECH_HUNDREDTHS  = 290002, -- talisman[1]: Life Leech
	LOOT_HUNDREDTHS        = 290003, -- talisman[2]: More Loot
	DOUBLE_KILL_HUNDREDTHS = 290004, -- talisman[3]: Chance for Double Beast Scroll Progress
}

local BONUS_KEYS = {
	BTALISMAN.DAMAGE_HUNDREDTHS,
	BTALISMAN.LIFE_LEECH_HUNDREDTHS,
	BTALISMAN.LOOT_HUNDREDTHS,
	BTALISMAN.DOUBLE_KILL_HUNDREDTHS,
}

local function applyBonus(player)
	local vals = {}
	for i, key in ipairs(BONUS_KEYS) do
		local v = player:getBountyTalismanBonus(i - 1)
		player:setStorageValue(key, v)
		vals[i] = v
	end
	logger.info("[debug-task] Bounty talisman EQUIPPED by {}, bonuses dmg={}h leech={}h loot={}h dkill={}h",
		player:getName(), vals[1], vals[2], vals[3], vals[4])
end

local function removeBonus(player)
	for _, key in ipairs(BONUS_KEYS) do
		player:setStorageValue(key, -1)
	end
	logger.info("[debug-task] Bounty talisman UNEQUIPPED by {}", player:getName())
end

local equip = MoveEvent()
function equip.onEquip(player, item, slot, isCheck)
	if not isCheck then
		applyBonus(player)
	end
	return true
end
equip:slot("necklace")
equip:id(51748)
equip:register()

local deequip = MoveEvent()
function deequip.onDeEquip(player, item, slot, isCheck)
	if not isCheck then
		removeBonus(player)
	end
	return true
end
deequip:slot("necklace")
deequip:id(51748)
deequip:register()
