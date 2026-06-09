local spell = Spell("instant")

local LOOT_HOUND_NAME = "Loot Hound"

function spell.onCastSpell(player, variant)
	-- Remove existing pet if already summoned
	for _, summon in pairs(player:getSummons()) do
		if summon:getName() == LOOT_HOUND_NAME then
			summon:remove()
			player:sendTextMessage(MESSAGE_LOOT, "Your loot hound vanishes.")
			return true
		end
	end

	local position = player:getPosition()
	local pet = Game.createMonster(LOOT_HOUND_NAME, position, true, false, player)
	if not pet then
		player:sendCancelMessage(RETURNVALUE_NOTENOUGHROOM)
		position:sendMagicEffect(CONST_ME_POFF)
		return false
	end

	position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	player:sendTextMessage(MESSAGE_LOOT, "Your loot hound appears and is ready to serve.")
	return true
end

spell:group("support")
spell:id(298)
spell:name("Loot Hound")
spell:words("utevo piglia")
spell:level(8)
spell:mana(200)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:isAggressive(false)
spell:register()
