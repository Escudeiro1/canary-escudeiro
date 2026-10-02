/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019–present OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#include "items/weapons/weapons.hpp"

TEST(WeaponsDamageFormulaTest, LevelFlatDamageMatchesVerifiedValues) {
	EXPECT_EQ(1, Weapons::getLevelFlatDamage(8));
	EXPECT_EQ(2, Weapons::getLevelFlatDamage(10));
	EXPECT_EQ(20, Weapons::getLevelFlatDamage(100));
	EXPECT_EQ(100, Weapons::getLevelFlatDamage(500));
	EXPECT_EQ(183, Weapons::getLevelFlatDamage(1000));
	EXPECT_EQ(325, Weapons::getLevelFlatDamage(2000));
	EXPECT_EQ(444, Weapons::getLevelFlatDamage(3000));
}

TEST(WeaponsDamageFormulaTest, MinMaxDamageLevel3000) {
	EXPECT_EQ(666, Weapons::getMinWeaponDamage(3000, 100, 100));
	EXPECT_EQ(1112, Weapons::getMaxWeaponDamage(3000, 100, 100));
}

TEST(WeaponsDamageFormulaTest, MonkAttackIncreaseAppliesOnlyToSkillWeaponTerm) {
	// Same inputs as MinMaxDamageLevel3000, but with the monk base multiplier (1.5)
	// applied only to the skill/weapon ("AV") term — the level-derived "flat" term
	// (444 at level 3000) is untouched, which is why the gap vs. a non-monk shrinks
	// at high level instead of staying a flat 50%.
	EXPECT_EQ(778, Weapons::getMinWeaponDamage(3000, 100, 100, 1.5));
	EXPECT_EQ(1446, Weapons::getMaxWeaponDamage(3000, 100, 100, 1.5));
}

TEST(WeaponsDamageFormulaTest, ZeroAttackValueYieldsZeroDamage) {
	EXPECT_EQ(0, Weapons::getMinWeaponDamage(100, 50, 0));
	EXPECT_EQ(0, Weapons::getMaxWeaponDamage(100, 50, 0));
}
