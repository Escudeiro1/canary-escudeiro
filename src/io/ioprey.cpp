/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019–present OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#include "io/ioprey.hpp"

#include "config/configmanager.hpp"
#include "creatures/monsters/monsters.hpp"
#include "creatures/players/player.hpp"
#include "game/game.hpp"
#include "items/item.hpp"
#include "lib/di/container.hpp"
#include "lib/metrics/metrics.hpp"
#include "server/network/message/networkmessage.hpp"

// Prey class
PreySlot::PreySlot(PreySlot_t id) :
	id(id) {
	eraseBonus();
	reloadBonusValue();
	reloadBonusType();
	freeRerollTimeStamp = OTSYS_TIME() + g_configManager().getNumber(PREY_FREE_REROLL_TIME) * 1000;
}

void PreySlot::reloadBonusType() {
	if (bonusRarity == 10) {
		PreyBonus_t bonus_tmp = bonus;
		while (bonus_tmp == bonus) {
			bonus = static_cast<PreyBonus_t>(uniform_random(PreyBonus_First, PreyBonus_Last));
		}
		return;
	}

	bonus = static_cast<PreyBonus_t>(uniform_random(PreyBonus_First, PreyBonus_Last));
}

void PreySlot::reloadBonusValue() {
	if (bonusRarity >= 9) {
		bonusRarity = 10;
	} else {
		// Every time you roll it will increase the rarity (star)
		bonusRarity = static_cast<uint8_t>(uniform_random(bonusRarity + 1, 10));
	}
	if (bonus == PreyBonus_Damage) {
		bonusPercentage = 2 * bonusRarity + 5;
	} else if (bonus == PreyBonus_Defense) {
		bonusPercentage = 2 * bonusRarity + 10;
	} else {
		bonusPercentage = 3 * bonusRarity + 10;
	}
}

void PreySlot::reloadMonsterGrid(std::vector<uint16_t> blackList, uint32_t level) {
	raceIdList.clear();

	if (!g_configManager().getBoolean(PREY_ENABLED)) {
		return;
	}

	// Disabling prey system if the server have less then 36 registered monsters on bestiary because:
	// - Impossible to generate random lists without duplications on slots.
	// - Stress the server with unnecessary loops.
	const std::map<uint16_t, std::string> &bestiary = g_game().getBestiaryList();
	if (bestiary.size() < 36) {
		g_logger().error("[PreySlot::reloadMonsterGrid] - Bestiary size is less than 36, disabling prey system.");
		return;
	}

	uint8_t stageOne;
	uint8_t stageTwo;
	uint8_t stageThree;
	uint8_t stageFour;
	if (auto levelStage = static_cast<uint32_t>(std::floor(level / 100));
	    levelStage == 0) { // From level 0 to 99
		stageOne = 3;
		stageTwo = 3;
		stageThree = 2;
		stageFour = 1;
	} else if (levelStage <= 2) { // From level 100 to 299
		stageOne = 1;
		stageTwo = 3;
		stageThree = 3;
		stageFour = 2;
	} else if (levelStage <= 4) { // From level 300 to 499
		stageOne = 1;
		stageTwo = 2;
		stageThree = 3;
		stageFour = 3;
	} else { // From level 500 to ...
		stageOne = 1;
		stageTwo = 1;
		stageThree = 3;
		stageFour = 4;
	}

	uint8_t tries = 0;
	auto maxIndex = static_cast<int32_t>(bestiary.size() - 1);
	while (raceIdList.size() < 9) {
		uint16_t raceId = (*(std::next(bestiary.begin(), uniform_random(0, maxIndex)))).first;
		tries++;

		if (std::count(blackList.begin(), blackList.end(), raceId) != 0) {
			continue;
		}

		blackList.push_back(raceId);
		const auto mtype = g_monsters().getMonsterTypeByRaceId(raceId);
		if (!mtype || mtype->info.experience == 0 || !mtype->info.isPreyable || mtype->info.isPreyExclusive) {
			continue;
		} else if (stageOne != 0 && mtype->info.bestiaryStars <= 1) {
			raceIdList.push_back(raceId);
			--stageOne;
		} else if (stageTwo != 0 && mtype->info.bestiaryStars == 2) {
			raceIdList.push_back(raceId);
			--stageTwo;
		} else if (stageThree != 0 && mtype->info.bestiaryStars == 3) {
			raceIdList.push_back(raceId);
			--stageThree;
		} else if (stageFour != 0 && mtype->info.bestiaryStars >= 4) {
			raceIdList.push_back(raceId);
			--stageFour;
		} else if (tries >= 10) {
			raceIdList.push_back(raceId);
			tries = 0;
		}
	}
}

// Task hunting class
TaskHuntingSlot::TaskHuntingSlot(PreySlot_t id) :
	id(id) {
	freeRerollTimeStamp = OTSYS_TIME() + g_configManager().getNumber(TASK_HUNTING_FREE_REROLL_TIME) * 1000;
}

void TaskHuntingSlot::reloadMonsterGrid(std::vector<uint16_t> blackList, uint32_t level) {
	raceIdList.clear();

	if (!g_configManager().getBoolean(TASK_HUNTING_ENABLED)) {
		return;
	}

	// Disabling task hunting system if the server have less then 36 registered monsters on bestiary because:
	// - Impossible to generate random lists without duplications on slots.
	// - Stress the server with unnecessary loops.
	const std::map<uint16_t, std::string> &bestiary = g_game().getBestiaryList();
	if (bestiary.size() < 36) {
		return;
	}

	uint8_t stageOne;
	uint8_t stageTwo;
	uint8_t stageThree;
	uint8_t stageFour;
	if (auto levelStage = static_cast<uint32_t>(std::floor(level / 100));
	    levelStage == 0) { // From level 0 to 99
		stageOne = 3;
		stageTwo = 3;
		stageThree = 2;
		stageFour = 1;
	} else if (levelStage <= 2) { // From level 100 to 299
		stageOne = 1;
		stageTwo = 3;
		stageThree = 3;
		stageFour = 2;
	} else if (levelStage <= 4) { // From level 300 to 499
		stageOne = 1;
		stageTwo = 2;
		stageThree = 3;
		stageFour = 3;
	} else { // From level 500 to ...
		stageOne = 1;
		stageTwo = 1;
		stageThree = 3;
		stageFour = 4;
	}

	uint8_t tries = 0;
	auto maxIndex = static_cast<int32_t>(bestiary.size() - 1);
	while (raceIdList.size() < 9) {
		uint16_t raceId = (*(std::next(bestiary.begin(), uniform_random(0, maxIndex)))).first;
		tries++;

		if (std::count(blackList.begin(), blackList.end(), raceId) != 0) {
			continue;
		}

		blackList.push_back(raceId);
		const auto mtype = g_monsters().getMonsterTypeByRaceId(raceId);
		if (!mtype || mtype->info.experience == 0 || !mtype->info.isPreyable || mtype->info.isPreyExclusive) {
			continue;
		} else if (stageOne != 0 && mtype->info.bestiaryStars <= 1) {
			raceIdList.push_back(raceId);
			--stageOne;
		} else if (stageTwo != 0 && mtype->info.bestiaryStars == 2) {
			raceIdList.push_back(raceId);
			--stageTwo;
		} else if (stageThree != 0 && mtype->info.bestiaryStars == 3) {
			raceIdList.push_back(raceId);
			--stageThree;
		} else if (stageFour != 0 && mtype->info.bestiaryStars >= 4) {
			raceIdList.push_back(raceId);
			--stageFour;
		} else if (tries >= 10) {
			raceIdList.push_back(raceId);
			tries = 0;
		}
	}
}

void TaskHuntingSlot::reloadReward() {
	if (!g_configManager().getBoolean(TASK_HUNTING_ENABLED)) {
		return;
	}

	if (rarity >= 4) {
		rarity = 5;
		return;
	}

	int32_t chance;
	if (rarity == 0) {
		chance = uniform_random(0, 100);
	} else if (rarity == 1) {
		chance = uniform_random(0, 70);
	} else if (rarity == 2) {
		chance = uniform_random(0, 45);
	} else if (rarity == 3) {
		chance = uniform_random(0, 20);
	} else {
		return;
	}

	if (chance <= 5) {
		rarity = 5;
	} else if (chance <= 20) {
		rarity = 4;
	} else if (chance <= 45) {
		rarity = 3;
	} else if (chance <= 70) {
		rarity = 2;
	} else {
		rarity = 1;
	}
}

IOPrey &IOPrey::getInstance() {
	return inject<IOPrey>();
}

// Prey/Task hunting global class
void IOPrey::checkPlayerPreys(const std::shared_ptr<Player> &player, uint8_t amount) const {
	if (!player) {
		return;
	}

	for (uint8_t slotId = PreySlot_First; slotId <= PreySlot_Last; slotId++) {
		if (const auto &slot = player->getPreySlotById(static_cast<PreySlot_t>(slotId));
		    slot && slot->isOccupied()) {
			if (slot->bonusTimeLeft <= amount) {
				if (slot->option == PreyOption_AutomaticReroll) {
					if (player->usePreyCards(static_cast<uint16_t>(g_configManager().getNumber(PREY_BONUS_REROLL_PRICE)))) {
						slot->reloadBonusType();
						slot->reloadBonusValue();
						slot->bonusTimeLeft = static_cast<uint16_t>(g_configManager().getNumber(PREY_BONUS_TIME));
						player->sendTextMessage(MESSAGE_STATUS, "Your prey bonus type and time has been succesfully reseted.");
						player->reloadPreySlot(static_cast<PreySlot_t>(slotId));
						continue;
					}

					player->sendTextMessage(MESSAGE_STATUS, "You don't have enought prey cards to enable automatic reroll when your slot expire.");
				} else if (slot->option == PreyOption_Locked) {
					if (player->usePreyCards(static_cast<uint16_t>(g_configManager().getNumber(PREY_SELECTION_LIST_PRICE)))) {
						slot->bonusTimeLeft = static_cast<uint16_t>(g_configManager().getNumber(PREY_BONUS_TIME));
						player->sendTextMessage(MESSAGE_STATUS, "Your prey bonus time has been succesfully reseted.");
						player->reloadPreySlot(static_cast<PreySlot_t>(slotId));
						continue;
					}

					player->sendTextMessage(MESSAGE_STATUS, "You don't have enought prey cards to lock monster and bonus when the slot expire.");
				} else {
					slot->reloadMonsterGrid(player->getPreyBlackList(), player->getLevel());
					player->sendTextMessage(MESSAGE_STATUS, "Your prey bonus has expired.");
				}

				slot->eraseBonus();
				player->reloadPreySlot(static_cast<PreySlot_t>(slotId));
			} else {
				slot->bonusTimeLeft -= amount;
				player->sendPreyTimeLeft(slot);
			}
		}
	}
}

void IOPrey::parsePreyAction(const std::shared_ptr<Player> &player, PreySlot_t slotId, PreyAction_t action, PreyOption_t option, int8_t index, uint16_t raceId) const {
	const auto &slot = player->getPreySlotById(slotId);
	if (!slot || slot->state == PreyDataState_Locked) {
		player->sendMessageDialog("To unlock this prey slot first you must buy it on store.");
		return;
	}

	if (action == PreyAction_ListReroll) {
		if (slot->freeRerollTimeStamp > OTSYS_TIME() && !g_game().removeMoney(player, player->getPreyRerollPrice(), 0, true)) {
			player->sendMessageDialog("You don't have enought money to reroll the prey slot.");
			return;
		} else if (slot->freeRerollTimeStamp <= OTSYS_TIME()) {
			slot->freeRerollTimeStamp = OTSYS_TIME() + g_configManager().getNumber(PREY_FREE_REROLL_TIME) * 1000;
		} else {
			g_metrics().addCounter("balance_decrease", player->getPreyRerollPrice(), { { "player", player->getName() }, { "context", "prey_reroll" } });
		}

		slot->eraseBonus(true);
		if (slot->bonus != PreyBonus_None) {
			slot->state = PreyDataState_SelectionChangeMonster;
		}
		slot->reloadMonsterGrid(player->getPreyBlackList(), player->getLevel());
	} else if (action == PreyAction_ListAll_Cards) {
		if (!player->usePreyCards(static_cast<uint16_t>(g_configManager().getNumber(PREY_SELECTION_LIST_PRICE)))) {
			player->sendMessageDialog("You don't have enought prey cards to choose a monsters on the list.");
			return;
		}

		slot->bonusTimeLeft = 0;
		slot->selectedRaceId = 0;
		slot->state = PreyDataState_ListSelection;
	} else if (action == PreyAction_ListAll_Selection) {
		const auto mtype = g_monsters().getMonsterTypeByRaceId(raceId);
		if (slot->isOccupied()) {
			player->sendMessageDialog("You already have an active monster on this prey slot.");
			return;
		} else if (!slot->canSelect() || slot->state != PreyDataState_ListSelection) {
			player->sendMessageDialog("There was an error while processing your action. Please try reopening the prey window.");
			return;
		} else if (player->getPreyWithMonster(raceId)) {
			player->sendMessageDialog("This creature is already selected on another slot.");
			return;
		} else if (mtype && !mtype->info.isPreyable) {
			player->sendMessageDialog("This creature can't be select on prey. Please choose another one.");
			return;
		}

		if (slot->bonus == PreyBonus_None) {
			slot->reloadBonusType();
			slot->reloadBonusValue();
		}

		slot->state = PreyDataState_Active;
		slot->selectedRaceId = raceId;
		slot->removeMonsterType(raceId);
		slot->bonusTimeLeft = static_cast<uint16_t>(g_configManager().getNumber(PREY_BONUS_TIME));
	} else if (action == PreyAction_BonusReroll) {
		if (!slot->isOccupied()) {
			player->sendMessageDialog("You don't have any active monster on this prey slot.");
			return;
		} else if (!player->usePreyCards(static_cast<uint16_t>(g_configManager().getNumber(PREY_BONUS_REROLL_PRICE)))) {
			player->sendMessageDialog("You don't have enought prey cards to reroll this prey slot bonus type.");
			return;
		}

		slot->reloadBonusType();
		slot->reloadBonusValue();
		slot->bonusTimeLeft = static_cast<uint16_t>(g_configManager().getNumber(PREY_BONUS_TIME));
	} else if (action == PreyAction_MonsterSelection) {
		if (slot->isOccupied()) {
			player->sendMessageDialog("You already have an active monster on this prey slot.");
			return;
		} else if (!slot->canSelect() || index == -1 || (index + 1) > slot->raceIdList.size()) {
			player->sendMessageDialog("There was an error while processing your action. Please try reopening the prey window.");
			return;
		} else if (player->getPreyWithMonster(slot->raceIdList[index])) {
			player->sendMessageDialog("This creature is already selected on another slot.");
			return;
		}

		if (slot->bonus == PreyBonus_None) {
			slot->reloadBonusType();
			slot->reloadBonusValue();
		}
		slot->state = PreyDataState_Active;
		slot->selectedRaceId = slot->raceIdList[index];
		slot->removeMonsterType(slot->selectedRaceId);
		slot->bonusTimeLeft = static_cast<uint16_t>(g_configManager().getNumber(PREY_BONUS_TIME));
	} else if (action == PreyAction_Option) {
		if (option == PreyOption_AutomaticReroll && player->getPreyCards() < static_cast<uint64_t>(g_configManager().getNumber(PREY_BONUS_REROLL_PRICE))) {
			player->sendMessageDialog("You don't have enought prey cards to enable automatic reroll when your slot expire.");
			return;
		} else if (option == PreyOption_Locked && player->getPreyCards() < static_cast<uint64_t>(g_configManager().getNumber(PREY_SELECTION_LIST_PRICE))) {
			player->sendMessageDialog("You don't have enought prey cards to lock monster and bonus when the slot expire.");
			return;
		}

		slot->option = option;
	} else {
		g_logger().warn("[IOPrey::parsePreyAction] - Unknown prey action: {}", fmt::underlying(action));
		return;
	}

	player->reloadPreySlot(slotId);
}

void IOPrey::parseTaskHuntingAction(const std::shared_ptr<Player> &player, PreySlot_t slotId, PreyTaskAction_t action, bool upgrade, uint16_t raceId) const {
	const auto &slot = player->getTaskHuntingSlotById(slotId);
	if (!slot || slot->state == PreyTaskDataState_Locked) {
		player->sendMessageDialog("To unlock this task hunting slot first you must buy it on store.");
		return;
	}

	if (action == PreyTaskAction_ListReroll) {
		if (slot->disabledUntilTimeStamp >= OTSYS_TIME()) {
			std::ostringstream ss;
			ss << "You need to wait " << ((slot->disabledUntilTimeStamp - OTSYS_TIME()) / 60000) << " minutes to select a new creature on task.";
			player->sendMessageDialog(ss.str());
			return;
		} else if (slot->freeRerollTimeStamp > OTSYS_TIME() && !g_game().removeMoney(player, player->getTaskHuntingRerollPrice(), 0, true)) {
			player->sendMessageDialog("You don't have enought money to reroll the task hunting slot.");
			return;
		} else if (slot->freeRerollTimeStamp <= OTSYS_TIME()) {
			slot->freeRerollTimeStamp = OTSYS_TIME() + g_configManager().getNumber(TASK_HUNTING_FREE_REROLL_TIME) * 1000;
		} else {
			g_metrics().addCounter("balance_decrease", player->getTaskHuntingRerollPrice(), { { "player", player->getName() }, { "context", "hunting_task_reroll" } });
		}

		slot->eraseTask();
		slot->reloadReward();
		slot->state = PreyTaskDataState_Selection;
		slot->reloadMonsterGrid(player->getTaskHuntingBlackList(), player->getLevel());
	} else if (action == PreyTaskAction_RewardsReroll) {
		if (!player->usePreyCards(static_cast<uint16_t>(g_configManager().getNumber(TASK_HUNTING_BONUS_REROLL_PRICE)))) {
			player->sendMessageDialog("You don't have enought prey cards to reroll you task reward rarity.");
			return;
		}

		slot->reloadReward();
	} else if (action == PreyTaskAction_ListAll_Cards) {
		if (slot->disabledUntilTimeStamp >= OTSYS_TIME()) {
			std::ostringstream ss;
			ss << "You need to wait " << ((slot->disabledUntilTimeStamp - OTSYS_TIME()) / 60000) << " minutes to select a new creature on task.";
			player->sendMessageDialog(ss.str());
			return;
		} else if (!player->usePreyCards(static_cast<uint16_t>(g_configManager().getNumber(TASK_HUNTING_SELECTION_LIST_PRICE)))) {
			player->sendMessageDialog("You don't have enought prey cards to choose a creature on list for you task hunting slot.");
			return;
		}

		slot->selectedRaceId = 0;
		slot->state = PreyTaskDataState_ListSelection;
	} else if (action == PreyTaskAction_MonsterSelection) {
		if (slot->disabledUntilTimeStamp >= OTSYS_TIME()) {
			std::ostringstream ss;
			ss << "You need to wait " << ((slot->disabledUntilTimeStamp - OTSYS_TIME()) / 60000) << " minutes to select a new creature on task.";
			player->sendMessageDialog(ss.str());
			return;
		} else if (!slot->canSelect()) {
			player->sendMessageDialog("There was an error while processing your action. Please try reopening the task window.");
			return;
		} else if (slot->isOccupied()) {
			player->sendMessageDialog("You already have an active monster on this task hunting slot.");
			return;
		} else if (slot->state == PreyTaskDataState_Selection && !slot->isCreatureOnList(raceId)) {
			player->sendMessageDialog("There was an error while processing your action. Please try reopening the task window.");
			return;
		} else if (player->getTaskHuntingWithCreature(raceId)) {
			player->sendMessageDialog("This creature is already selected on another slot.");
			return;
		}

		if (const auto mtype = g_monsters().getMonsterTypeByRaceId(raceId)) {
			slot->currentKills = 0;
			slot->selectedRaceId = raceId;
			slot->removeMonsterType(raceId);
			slot->state = PreyTaskDataState_Active;
			slot->upgrade = upgrade && player->isCreatureUnlockedOnTaskHunting(mtype);
		}
	} else if (action == PreyTaskAction_Cancel) {
		if (!g_game().removeMoney(player, player->getTaskHuntingRerollPrice(), 0, true)) {
			player->sendMessageDialog("You don't have enought money to cancel your current task hunting.");
			return;
		}

		g_metrics().addCounter("balance_decrease", player->getTaskHuntingRerollPrice(), { { "player", player->getName() }, { "context", "hunting_task_cancel" } });
		slot->eraseTask();
		slot->reloadReward();
		slot->state = PreyTaskDataState_Selection;
		slot->reloadMonsterGrid(player->getTaskHuntingBlackList(), player->getLevel());
	} else if (action == PreyTaskAction_Claim) {
		if (!slot->isOccupied()) {
			player->sendMessageDialog("You cannot claim your task reward with an empty task hunting slot.");
			return;
		}

		if (const auto &option = getTaskRewardOption(slot)) {
			uint64_t reward;
			int32_t boostChange = uniform_random(0, 100);
			if (slot->rarity >= 4 && boostChange <= 5) {
				boostChange = 20;
			} else if (slot->rarity >= 4 && boostChange <= 10) {
				boostChange = 15;
			} else {
				boostChange = 10;
			}

			if (slot->upgrade && slot->currentKills >= option->secondKills) {
				reward = option->secondReward;
			} else if (!slot->upgrade && slot->currentKills >= option->firstKills) {
				reward = option->firstReward;
			} else {
				player->sendMessageDialog("There was an error while processing you task hunting reward. Please try reopening the window.");
				return;
			}

			std::ostringstream ss;
			reward = static_cast<uint64_t>(std::ceil((reward * boostChange) / 10));
			ss << "Congratulations! You have earned " << reward;
			if (boostChange == 20) {
				ss << " Hunting Task points including a 100% bonus.";
			} else if (boostChange == 15) {
				ss << " Hunting Task points including a 50% bonus.";
			} else {
				ss << " Hunting Task points.";
			}

			slot->eraseTask();
			slot->reloadReward();
			slot->state = PreyTaskDataState_Inactive;
			player->addTaskHuntingPoints(reward);
			player->sendMessageDialog(ss.str());
			slot->reloadMonsterGrid(player->getTaskHuntingBlackList(), player->getLevel());
			slot->disabledUntilTimeStamp = OTSYS_TIME() + g_configManager().getNumber(TASK_HUNTING_LIMIT_EXHAUST) * 1000;
		}
	} else {
		g_logger().warn("[IOPrey::parseTaskHuntingAction] - Unknown task action: {}", fmt::underlying(action));
		return;
	}
	player->reloadTaskSlot(slotId);
}

void IOPrey::initializeTaskHuntOptions() {
	if (!g_configManager().getBoolean(TASK_HUNTING_ENABLED)) {
		return;
	}

	// Move it to config.lua

	// Kill stage is the multiplier for kills and rewards on task hunting
	uint8_t killStage = 25;

	// This is hardcoded on client but i'm saving it in case that they change it in the future
	uint8_t limitOfStars = 5;
	uint16_t kills = killStage;
	NetworkMessage msg;
	for (uint8_t difficulty = PreyTaskDifficult_First; difficulty <= PreyTaskDifficult_Last; ++difficulty) { // Difficulties of creatures on bestiary.
		auto reward = static_cast<uint16_t>(std::round((10 * kills) / killStage));
		// Amount of task stars on task hunting
		for (uint8_t star = 1; star <= limitOfStars; ++star) {
			const auto &option = taskOption.emplace_back(std::make_unique<TaskHuntingOption>());

			option->difficult = static_cast<PreyTaskDifficult_t>(difficulty);
			option->rarity = star;

			option->firstKills = kills;
			option->firstReward = reward;

			option->secondKills = kills * 2;
			option->secondReward = reward * 2;

			reward = static_cast<uint16_t>(std::round((reward * (115 + (difficulty * limitOfStars))) / 100));
		}

		kills *= 4;
	}

	msg.addByte(0xBA);
	const std::map<uint16_t, std::string> &bestiaryList = g_game().getBestiaryList();
	msg.add<uint16_t>(static_cast<uint16_t>(bestiaryList.size()));
	std::for_each(bestiaryList.begin(), bestiaryList.end(), [&msg](auto mType) {
		const auto mtype = g_monsters().getMonsterType(mType.second);
		if (!mtype) {
			return;
		}

		msg.add<uint16_t>(mtype->info.raceid);
		if (mtype->info.bestiaryStars <= 1) {
			msg.addByte(0x01);
		} else if (mtype->info.bestiaryStars <= 3) {
			msg.addByte(0x02);
		} else {
			msg.addByte(0x03);
		}
	});

	msg.addByte(static_cast<uint8_t>(taskOption.size()));
	std::for_each(taskOption.begin(), taskOption.end(), [&msg](const std::unique_ptr<TaskHuntingOption> &option) {
		msg.addByte(static_cast<uint8_t>(option->difficult));
		msg.addByte(option->rarity);
		msg.add<uint16_t>(option->firstKills);
		msg.add<uint16_t>(option->firstReward);
		msg.add<uint16_t>(option->secondKills);
		msg.add<uint16_t>(option->secondReward);
	});
	m_baseDataMessage = msg;

	initBountyPools();
	initShopOffers();
}

NetworkMessage IOPrey::getTaskHuntingBaseDate() const {
	return m_baseDataMessage;
}

const std::unique_ptr<TaskHuntingOption> &IOPrey::getTaskRewardOption(const std::unique_ptr<TaskHuntingSlot> &slot) const {
	if (!slot) {
		return TaskHuntingOptionNull;
	}

	const auto mtype = g_monsters().getMonsterTypeByRaceId(slot->selectedRaceId);
	if (!mtype) {
		return TaskHuntingOptionNull;
	}

	PreyTaskDifficult_t difficult;
	if (mtype->info.bestiaryStars <= 1) {
		difficult = PreyTaskDifficult_Easy;
	} else if (mtype->info.bestiaryStars <= 3) {
		difficult = PreyTaskDifficult_Medium;
	} else {
		difficult = PreyTaskDifficult_Hard;
	}

	auto it = std::find_if(taskOption.begin(), taskOption.end(), [difficult, &slot](const std::unique_ptr<TaskHuntingOption> &optionIt) {
		return optionIt->difficult == difficult && optionIt->rarity == slot->rarity;
	});

	if (it != taskOption.end()) {
		return *it;
	}

	return TaskHuntingOptionNull;
}

// ── Bounty Task system ────────────────────────────────────────────────────────

static const std::vector<std::string_view> s_beginnerCreatures = {
	"Abyssal Calamary", "Adventurer", "Amazon", "Assassin", "Azure Frog",
	"Bandit", "Barbarian Brutetamer", "Barbarian Headsplitter", "Barbarian Skullhunter",
	"Bear", "Blood Crab", "Boar", "Bonelord", "Calamary", "Carrion Worm", "Centipede",
	"Chakoya Toolshaper", "Chakoya Tribewarden", "Chakoya Windcaller", "Cobra",
	"Coral Frog", "Corym Charlatan", "Crab", "Crazed Beggar", "Crimson Frog", "Crocodile",
	"Crypt Shambler", "Cyclops", "Damaged Crystal Golem", "Damaged Worker Golem",
	"Dark Apprentice", "Dark Magician", "Dark Monk", "Deepling Worker", "Deepsea Blood Crab",
	"Dwarf", "Dwarf Guard", "Dwarf Soldier", "Dworc Fleshhunter", "Dworc Venomsniper",
	"Dworc Voodoomaster", "Elephant", "Elf", "Elf Arcanist", "Elf Scout",
	"Emerald Damselfly", "Filth Toad", "Fire Devil", "Frost Giant", "Frost Giantess",
	"Furious Troll", "Gang Member", "Gargoyle", "Gazer", "Ghost", "Ghoul", "Gladiator",
	"Gloom Wolf", "Gnarlhound", "Goblin Assassin", "Goblin Scavenger", "Gozzler",
	"Hunter", "Hyaena", "Infernoid Blob", "Infernoid Hound", "Infernoid Soul",
	"Infernoid Spiritual", "Insect Swarm", "Jellyfish", "Killer Rabbit", "Kongra",
	"Larva", "Leaf Golem", "Lion", "Little Corym Charlatan", "Lizard Executioner",
	"Lizard Henchman", "Lizard Magician", "Lizard Sentinel", "Lizard Swordmaster",
	"Lizard Templar", "Mad Scientist", "Mammoth", "Marsh Stalker", "Mercury Blob",
	"Merlkin", "Minotaur", "Minotaur Archer", "Minotaur Guard", "Minotaur Mage",
	"Mole", "Mummy", "Nomad", "Novice of the Cult", "Orc", "Orc Rider",
	"Orc Shaman", "Orc Spearman", "Orc Warrior", "Orchid Frog", "Panda",
	"Pirate Cook", "Pirate Ghost", "Pirate Gunner", "Pirate Marauder", "Pirate Navigator",
	"Pirate Quartermaster", "Pirate Skeleton", "Poacher", "Polar Bear",
	"Quara Mantassin Scout", "Rabid Wolf", "Ragged Rabid Wolf", "Rorc", "Rotworm",
	"Salamander", "Scarab", "Scorpion", "Sibang", "Skeleton", "Skeleton Warrior",
	"Slime", "Slug", "Smuggler", "Spit Nettle", "Stalker", "Stone Golem",
	"Swamp Troll", "Swampling", "Tarantula", "Terror Bird", "Thornback Tortoise",
	"Tiger", "Toad", "Tortoise", "Troll Champion", "Undead Mine Worker",
	"Undead Prospector", "Valkyrie", "War Wolf", "White Tiger", "Wild Warrior", "Witch"
};

static const std::vector<std::string_view> s_adeptCreatures = {
	"Acid Blob", "Acolyte of the Cult", "Adept of the Cult", "Amazon", "Ancient Scarab",
	"Animated Snowman", "Arctic Faun", "Assassin", "Askarak Demon", "Askarak Lord",
	"Askarak Prince", "Azure Frog", "Baleful Bunny", "Bandit", "Banshee",
	"Barbarian Bloodwalker", "Barbarian Brutetamer", "Barbarian Headsplitter",
	"Barbarian Skullhunter", "Barkless Devotee", "Barkless Fanatic", "Bear", "Behemoth",
	"Bellicose Orger", "Berserker Chicken", "Betrayed Wraith", "Blood Beast", "Blood Crab",
	"Blood Hand", "Blood Priest", "Blue Djinn", "Bog Raider", "Bonebeast", "Bonelord",
	"Boogy", "Braindeath", "Brimstone Bug", "Broken Shaper", "Carniphila",
	"Carrion Worm", "Centipede", "Chakoya Toolshaper", "Chakoya Tribewarden",
	"Chakoya Windcaller", "Clay Guardian", "Clomp", "Cobra", "Coral Frog",
	"Corym Charlatan", "Corym Skirmisher", "Corym Vanguard", "Crab", "Crawler",
	"Crazed Beggar", "Crimson Frog", "Crocodile", "Crypt Defiler", "Crypt Shambler",
	"Crystal Spider", "Crystalcrusher", "Cult Believer", "Cult Enforcer", "Cult Scholar",
	"Cursed Ape", "Cyclops", "Cyclops Drone", "Cyclops Smith", "Damaged Crystal Golem",
	"Damaged Worker Golem", "Dark Apprentice", "Dark Faun", "Dark Magician", "Dark Monk",
	"Death Blob", "Death Priest", "Deepling Brawler", "Deepling Elite", "Deepling Guard",
	"Deepling Master Librarian", "Deepling Scout", "Deepling Spellsinger",
	"Deepling Warrior", "Deepling Worker", "Deepsea Blood Crab", "Demon Parrot",
	"Demon Skeleton", "Destroyer", "Devourer", "Diabolic Imp", "Diamond Servant Replica",
	"Dragon", "Dragon Hatchling", "Dragon Lord", "Dragon Lord Hatchling", "Dragonling",
	"Draken Warmaster", "Drillworm", "Dwarf", "Dwarf Geomancer", "Dwarf Guard",
	"Dwarf Henchman", "Dwarf Soldier", "Dworc Fleshhunter", "Dworc Venomsniper",
	"Dworc Voodoomaster", "Earth Elemental", "Efreet", "Elder Bonelord", "Elder Forest Fury",
	"Elder Mummy", "Elephant", "Elf", "Elf Arcanist", "Elf Scout", "Emerald Damselfly",
	"Energy Elemental", "Enfeebled Silencer", "Enlightened of the Cult",
	"Enraged Crystal Golem", "Enslaved Dwarf", "Eternal Guardian", "Evil Sheep",
	"Evil Sheep Lord", "Execowtioner", "Exotic Bat", "Exotic Cave Spider",
	"Filth Toad", "Fire Devil", "Fire Elemental", "Foam Stalker", "Forest Fury",
	"Frazzlemaw", "Frost Giant", "Frost Giantess", "Gargoyle", "Ghost", "Ghoul",
	"Giant Spider", "Gladiator", "Gloom Wolf", "Glooth Anemone", "Glooth Bandit",
	"Glooth Blob", "Glooth Brigand", "Glooth Golem", "Goblin Assassin", "Goblin Scavenger",
	"Gozzler", "Gravedigger", "Green Djinn", "Grim Reaper", "Grimeleech",
	"Hand of Cursed Fate", "Hellfire Fighter", "Hellhound", "Hellspawn", "Hero",
	"High Voltage Elemental", "Hive Overseer", "Hunter", "Hydra", "Ice Golem",
	"Ice Witch", "Infernalist", "Iron Servant Replica", "Killer Rabbit", "Kongra",
	"Lancer Beetle", "Lava Golem", "Lich", "Lion", "Lizard Chosen",
	"Lizard Dragon Priest", "Lizard High Guard", "Lizard Legionnaire", "Lizard Magistratus",
	"Lizard Noble", "Lizard Sentinel", "Lizard Swordmaster", "Lizard Templar",
	"Magma Crawler", "Mammoth", "Marid", "Metal Gargoyle", "Minotaur",
	"Minotaur Amazon", "Minotaur Archer", "Minotaur Guard", "Minotaur Mage",
	"Mole", "Mummy", "Mutated Bat", "Mutated Human", "Mutated Rat", "Mutated Tiger",
	"Necromancer", "Nightmare", "Nightmare Scion", "Nightstalker", "Nomad",
	"Novice of the Cult", "Nymph", "Orc", "Orc Berserker", "Orc Leader",
	"Orc Marauder", "Orc Rider", "Orc Shaman", "Orc Warlord", "Orger",
	"Pirate Buccaneer", "Pirate Cook", "Pirate Corsair", "Pirate Cutthroat", "Pirate Ghost",
	"Plaguesmith", "Quara Constrictor", "Quara Constrictor Scout", "Quara Hydromancer",
	"Quara Hydromancer Scout", "Quara Mantassin", "Quara Mantassin Scout",
	"Quara Pincher", "Quara Pincher Scout", "Quara Predator", "Quara Predator Scout",
	"Rotworm", "Scarab", "Sea Serpent", "Serpent Spawn", "Shark",
	"Silencer", "Skeleton Elite Warrior", "Slime", "Son of Verminor", "Spectre",
	"Stone Golem", "Swamp Troll", "Tarantula", "Terror Bird", "Tiger",
	"Troll Legionnaire", "Undead Dragon", "Undead Elite Gladiator", "Undead Gladiator",
	"Vampire", "Vampire Bride", "Vexclaw", "Walker", "War Golem", "Warlock",
	"Water Elemental", "Werewolf", "Worker Golem", "Wyrm", "Wyvern"
};

static const std::vector<std::string_view> s_expertCreatures = {
	"Acid Blob", "Acolyte of the Cult", "Adept of the Cult", "Adult Goanna",
	"Afflicted Strider", "Ancient Scarab", "Animated Feather", "Animated Snowman",
	"Arachnophobica", "Arctic Faun", "Armadile", "Askarak Demon", "Askarak Lord",
	"Askarak Prince", "Baleful Bunny", "Banshee", "Barbarian Bloodwalker",
	"Barkless Devotee", "Barkless Fanatic", "Bashmu", "Behemoth", "Bellicose Orger",
	"Berserker Chicken", "Betrayed Wraith", "Biting Book", "Black Sphinx Acolyte",
	"Blemished Spawn", "Blightwalker", "Blood Beast", "Blood Hand", "Blood Priest",
	"Blue Djinn", "Bog Raider", "Bonebeast", "Boogy", "Brain Squid", "Braindeath",
	"Bramble Wyrmling", "Breach Brood", "Brimstone Bug", "Brinebrute Inferniarch",
	"Broken Shaper", "Broodrider Inferniarch", "Bulltaur Alchemist", "Bulltaur Brute",
	"Bulltaur Forgepriest", "Burning Book", "Burning Gladiator", "Burster Spectre",
	"Candy Floss Elemental", "Candy Horror", "Carniphila", "Carnivostrich",
	"Cave Chimera", "Cave Devourer", "Chasm Spawn", "Choking Fear", "Cinder Wyrmling",
	"Cliff Strider", "Cobra Assassin", "Cobra Scout", "Cobra Vizier",
	"Corym Skirmisher", "Corym Vanguard", "Crape Man", "Crawler",
	"Crazed Summer Rearguard", "Crazed Summer Vanguard", "Crazed Winter Rearguard",
	"Crazed Winter Vanguard", "Crusader", "Crypt Mage", "Crypt Warden", "Crypt Warrior",
	"Crystal Spider", "Crystalcrusher", "Cult Believer", "Cult Enforcer", "Cult Scholar",
	"Cunning Werepanther", "Cursed Ape", "Cursed Book", "Cursed Prospector",
	"Cyclops Drone", "Cyclops Smith", "Cyclursus", "Dark Carnisylvan", "Dark Faun",
	"Dark Torturer", "Dawnfire Asura", "Death Blob", "Death Priest",
	"Deathling Scout", "Deathling Spellsinger", "Deepling Brawler", "Deepling Elite",
	"Deepling Guard", "Deepling Master Librarian", "Deepling Scout", "Deepling Spellsinger",
	"Deepling Tyrant", "Deepling Warrior", "Deepworm", "Defiler", "Demon",
	"Demon Outcast", "Demon Parrot", "Demon Skeleton", "Destroyer", "Devourer",
	"Diabolic Imp", "Diamond Servant Replica", "Diremaw", "Dragon", "Dragon Hatchling",
	"Dragon Lord", "Dragon Lord Hatchling", "Dragonling", "Draken Abomination",
	"Draken Elite", "Draken Spellweaver", "Draken Warmaster", "Dread Intruder",
	"Drillworm", "Dwarf Geomancer", "Dwarf Henchman", "Dworc Shadowstalker",
	"Earth Elemental", "Efreet", "Elder Bonelord", "Elder Forest Fury", "Elder Mummy",
	"Elder Wyrm", "Energetic Book", "Energuardian of Tales", "Energy Elemental",
	"Enfeebled Silencer", "Enlightened of the Cult", "Enraged Crystal Golem",
	"Enslaved Dwarf", "Eternal Guardian", "Evil Prospector", "Evil Sheep", "Evil Sheep Lord",
	"Execowtioner", "Exotic Bat", "Exotic Cave Spider", "Eyeless Devourer",
	"Falcon Knight", "Falcon Paladin", "Faun", "Feral Sphinx", "Feral Werecrocodile",
	"Feversleep", "Fire Elemental", "Flimsy Lost Soul", "Floating Savant",
	"Flying Book", "Foam Stalker", "Forest Fury", "Frazzlemaw", "Freakish Lost Soul",
	"Frost Dragon", "Frost Dragon Hatchling", "Frost Flower Asura",
	"Furious Fire Elemental", "Fury", "Gazer Spectre", "Ghastly Dragon",
	"Ghoulish Hyaena", "Giant Spider", "Girtablilu Warrior", "Gloom Maw",
	"Glooth Anemone", "Glooth Bandit", "Glooth Blob", "Glooth Brigand", "Glooth Golem",
	"Golden Servant Replica", "Goldhanded Cultist", "Gorger Inferniarch",
	"Grave Guard", "Gravedigger", "Green Djinn", "Grim Reaper", "Grimeleech",
	"Gryphon", "Guardian of Tales", "Guzzlemaw", "Hand of Cursed Fate", "Harpy",
	"Haunted Dragon", "Headwalker", "Hellfire Fighter", "Hellflayer", "Hellhound",
	"Hellhunter Inferniarch", "Hellspawn", "Hero", "Hibernal Moth", "Hideous Fungus",
	"Hive Overseer", "Honey Elemental", "Hulking Carnisylvan", "Humongous Fungus",
	"Hydra", "Ice Dragon", "Ice Golem", "Ice Witch", "Icecold Book",
	"Infected Weeper", "Infernal Frog", "Infernalist", "Ink Blob",
	"Insane Siren", "Instable Breach Brood", "Ironblight", "Juggernaut",
	"Juvenile Bashmu", "Killer Caiman", "Knowledge Elemental", "Kollos",
	"Lancer Beetle", "Lamassu", "Lava Golem", "Lava Lurker", "Lavafungus",
	"Lavaworm", "Lich", "Liodile", "Lion Hydra", "Lizard Chosen",
	"Lizard Dragon Priest", "Lizard High Guard", "Lizard Noble", "Lost Basher",
	"Lost Berserker", "Lost Exile", "Lost Husher", "Lost Soul", "Lost Thrower",
	"Magma Crawler", "Makara", "Manticore", "Marid",
	"Massive Earth Elemental", "Massive Energy Elemental", "Massive Fire Elemental",
	"Massive Water Elemental", "Medusa", "Mega Dragon", "Metal Gargoyle",
	"Midnight Asura", "Minotaur Amazon", "Minotaur Cult Follower",
	"Minotaur Cult Prophet", "Minotaur Cult Zealot", "Minotaur Hunter",
	"Minotaur Invader", "Mutated Bat", "Mutated Human", "Naga Archer", "Naga Warrior",
	"Necromancer", "Nibblemaw", "Night Harpy", "Nightmare", "Nightmare Scion",
	"Nightstalker", "Noble Lion", "Ogre Brute", "Ogre Rowdy", "Ogre Ruffian",
	"Ogre Sage", "Ogre Savage", "Ogre Shaman", "Orc Berserker", "Orc Leader",
	"Orc Marauder", "Orc Warlord", "Orclops Bloodbreaker", "Orclops Doomhauler",
	"Orclops Ravager", "Orger", "Phantasm", "Pirate Buccaneer", "Pirate Corsair",
	"Pirate Cutthroat", "Plaguesmith", "Priestess", "Priestess of the Wild Sun",
	"Putrid Mummy", "Quara Constrictor", "Quara Constrictor Scout",
	"Quara Hydromancer", "Quara Hydromancer Scout", "Quara Looter", "Quara Mantassin",
	"Quara Pincher", "Quara Pincher Scout", "Quara Plunderer", "Quara Predator",
	"Quara Predator Scout", "Quara Raider", "Rage Squid",
	"Raubritter Chastener", "Raubritter Marksman", "Raubritter Skirmisher",
	"Ravenous Lava Lurker", "Reality Reaver", "Renegade Knight",
	"Renegade Quara Constrictor", "Renegade Quara Hydromancer",
	"Renegade Quara Mantassin", "Renegade Quara Pincher", "Renegade Quara Predator",
	"Retching Horror", "Rhindeer", "Ripper Spectre", "Rot Elemental", "Rustheap Golem",
	"Sacred Spider", "Sandstone Scorpion", "Sea Serpent", "Seacrest Serpent",
	"Serpent Spawn", "Shaburak Demon", "Shaburak Lord", "Shaburak Prince",
	"Shark", "Shock Head", "Sight of Surrender", "Silencer",
	"Sineater Inferniarch", "Skeleton Elite Warrior", "Son of Verminor",
	"Souleater", "Sparkion", "Spectre", "Spellreaper Inferniarch", "Sphinx",
	"Spidris", "Spidris Elite", "Spitter", "Squid Warden",
	"Stampor", "Stone Devourer", "Stone Rhino", "Streaked Devourer", "Swan Maiden",
	"Swarmer", "Terrorsleep", "Thanatursus", "Tomb Servant", "Tremendous Tyrant",
	"Troll Legionnaire", "True Dawnfire Asura", "True Frost Flower Asura",
	"True Midnight Asura", "Tunnel Tyrant", "Undead Dragon", "Undead Elite Gladiator",
	"Undead Gladiator", "Usurper Archer", "Usurper Knight", "Usurper Warlock",
	"Vampire", "Vampire Bride", "Vampire Pig", "Vampire Viscount", "Varg",
	"Varnished Diremaw", "Venerable Girtablilu", "Vexclaw", "Vile Grandmaster",
	"Vulcongra", "Walker", "War Golem", "Wardragon", "Warlock", "Water Elemental",
	"Weakened Frazzlemaw", "Weeper", "Werebadger", "Werebear", "Wereboar",
	"Werecrocodile", "Werefox", "Werehyaena", "Werehyaena Shaman", "Werelion",
	"Werelioness", "Werepanther", "Weretiger", "Werewolf", "White Lion",
	"White Weretiger", "Worm Priestess", "Wyrm", "Wyvern", "Zombie"
};

static const std::vector<std::string_view> s_masterCreatures = {
	"Adult Goanna", "Afflicted Strider", "Animated Feather", "Arachnophobica",
	"Armadile", "Bashmu", "Biting Book", "Black Sphinx Acolyte", "Blemished Spawn",
	"Blightwalker", "Bluebeak", "Brain Squid", "Bramble Wyrmling", "Breach Brood",
	"Brinebrute Inferniarch", "Broodrider Inferniarch", "Bulltaur Alchemist",
	"Bulltaur Brute", "Bulltaur Forgepriest", "Burning Book", "Burning Gladiator",
	"Burster Spectre", "Candy Floss Elemental", "Candy Horror", "Carnivostrich",
	"Cave Chimera", "Cave Devourer", "Chasm Spawn", "Choking Fear", "Cinder Wyrmling",
	"Cliff Strider", "Cobra Assassin", "Cobra Scout", "Cobra Vizier", "Crape Man",
	"Crazed Summer Rearguard", "Crazed Summer Vanguard", "Crazed Winter Rearguard",
	"Crazed Winter Vanguard", "Crusader", "Crypt Mage", "Crypt Warden", "Crypt Warrior",
	"Cunning Werepanther", "Cursed Book", "Cursed Prospector", "Cyclursus",
	"Dark Carnisylvan", "Dark Torturer", "Dawnfire Asura", "Deathling Scout",
	"Deathling Spellsinger", "Deepling Tyrant", "Deepworm", "Defiler", "Demon",
	"Demon Outcast", "Diremaw", "Dragolisk", "Draken Abomination", "Draken Elite",
	"Draken Spellweaver", "Dread Intruder", "Dworc Shadowstalker", "Elder Wyrm",
	"Energetic Book", "Energuardian of Tales", "Evil Prospector", "Eyeless Devourer",
	"Falcon Knight", "Falcon Paladin", "Feral Sphinx", "Feral Werecrocodile",
	"Flimsy Lost Soul", "Floating Savant", "Foam Stalker", "Frazzlemaw",
	"Freakish Lost Soul", "Fury", "Gazer Spectre", "Ghastly Dragon",
	"Girtablilu Warrior", "Gloom Maw", "Grim Reaper", "Grimeleech",
	"Guardian of Tales", "Guzzlemaw", "Hand of Cursed Fate", "Harpy",
	"Haunted Dragon", "Headwalker", "Hellfire Fighter", "Hellflayer", "Hellhound",
	"Hellhunter Inferniarch", "Hideous Fungus", "Hive Overseer", "Hulking Carnisylvan",
	"Humongous Fungus", "Icecold Book", "Infected Weeper", "Infernal Demon",
	"Infernal Phantom", "Infernalist", "Ink Blob", "Insane Siren", "Ironblight",
	"Juggernaut", "Juvenile Bashmu", "Knowledge Elemental", "Lamassu", "Lava Golem",
	"Lava Lurker", "Lavafungus", "Lavaworm", "Liodile", "Lion Hydra", "Lizard Noble",
	"Lost Berserker", "Magma Crawler", "Makara", "Manticore", "Medusa", "Mega Dragon",
	"Minotaur Amazon", "Mitmah Scout", "Mitmah Seer", "Naga Archer", "Naga Warrior",
	"Nibblemaw", "Night Harpy", "Norcferatu Heartless", "Norcferatu Nightweaver",
	"Ogre Rowdy", "Ogre Ruffian", "Ogre Sage", "Orclops Bloodbreaker", "Orewalker",
	"Phantasm", "Poisonous Carnisylvan", "Priestess of the Wild Sun",
	"Quara Looter", "Quara Plunderer", "Quara Raider", "Rage Squid",
	"Raubritter Chastener", "Raubritter Marksman", "Raubritter Skirmisher",
	"Reality Reaver", "Retching Horror", "Rhindeer", "Ripper Spectre",
	"Rootthing Amber Shaper", "Rootthing Bug Tracker", "Rootthing Nutshell",
	"Seacrest Serpent", "Shock Head", "Sight of Surrender",
	"Sineater Inferniarch", "Skeleton Elite Warrior", "Son of Verminor",
	"Sparkion", "Spellreaper Inferniarch", "Sphinx", "Spiky Carnivor",
	"Squid Warden", "Stone Devourer", "Streaked Devourer", "Terrorsleep",
	"Thanatursus", "Tremendous Tyrant", "True Dawnfire Asura", "True Frost Flower Asura",
	"True Midnight Asura", "Tunnel Tyrant", "Undead Dragon", "Undead Elite Gladiator",
	"Usurper Archer", "Usurper Knight", "Usurper Warlock", "Varg",
	"Varnished Diremaw", "Venerable Girtablilu", "Vexclaw", "Vulcongra",
	"Wardragon", "Weeper", "Werecrocodile", "Werelion", "Werelioness",
	"Werepanther", "Weretiger", "White Lion", "White Weretiger", "Young Goanna"
};

void IOPrey::initBountyPools() {
	const std::array<const std::vector<std::string_view> *, 4> nameLists = {
		&s_beginnerCreatures, &s_adeptCreatures, &s_expertCreatures, &s_masterCreatures
	};

	// Build a reverse lookup: display name → raceId
	std::map<std::string, uint16_t> nameToRaceId;
	for (const auto &[raceId, name] : g_game().getBestiaryList()) {
		nameToRaceId[name] = raceId;
	}

	static constexpr std::array<std::string_view, 4> tierNames = {"Beginner", "Adept", "Expert", "Master"};
	for (uint8_t tier = 0; tier < 4; ++tier) {
		m_bountyPools[tier].clear();
		for (const auto &sv : *nameLists[tier]) {
			auto it = nameToRaceId.find(std::string(sv));
			if (it != nameToRaceId.end()) {
				m_bountyPools[tier].push_back(it->second);
			}
		}
		if (m_bountyPools[tier].empty()) {
			g_logger().warn("[IOPrey::initBountyPools] Bounty pool for tier {} ({}) is empty.", tier, tierNames[tier]);
		} else {
			g_logger().info("[IOPrey::initBountyPools] {} pool: {}/{} creatures matched.", tierNames[tier], m_bountyPools[tier].size(), nameLists[tier]->size());
		}
	}
}

const std::vector<uint16_t> &IOPrey::getBountyPool(BountyDifficulty_t difficulty) const {
	return m_bountyPools[static_cast<uint8_t>(difficulty)];
}

std::array<uint16_t, BOUNTY_OPTION_COUNT> IOPrey::generateBountyOptions(BountyDifficulty_t difficulty, const std::vector<uint16_t> &blackList) const {
	const auto &pool = getBountyPool(difficulty);
	std::array<uint16_t, BOUNTY_OPTION_COUNT> result = {};
	if (pool.empty()) {
		return result;
	}

	std::vector<uint16_t> available;
	available.reserve(pool.size());
	for (uint16_t raceId : pool) {
		if (std::find(blackList.begin(), blackList.end(), raceId) == blackList.end()) {
			available.push_back(raceId);
		}
	}
	if (available.empty()) {
		// Fallback: ignore blacklist
		available = pool;
	}

	for (uint8_t i = 0; i < BOUNTY_OPTION_COUNT; ++i) {
		if (available.empty()) break;
		uint32_t idx = uniform_random(0, static_cast<int32_t>(available.size()) - 1);
		result[i] = available[idx];
		available.erase(available.begin() + idx);
	}
	return result;
}

uint16_t IOPrey::getBountyKillTarget(BountyDifficulty_t difficulty) const {
	// Beginner 50-100, Adept 100-200, Expert 200-400, Master 300-600
	static constexpr std::array<uint16_t, 4> minKills = {50, 100, 200, 300};
	static constexpr std::array<uint16_t, 4> maxKills = {100, 200, 400, 600};
	const uint8_t d = static_cast<uint8_t>(difficulty);
	return static_cast<uint16_t>(uniform_random(minKills[d], maxKills[d]));
}

uint32_t IOPrey::getBountyExpReward(BountyDifficulty_t difficulty, uint32_t level, uint8_t rarity) const {
	// Level-scaled exp, multiplied by difficulty and rarity
	static constexpr std::array<uint32_t, 4> diffMult = {1, 2, 4, 8};
	uint32_t base;
	if (level <= 82) {
		base = 25 * level * level - 75 * level + 100;
	} else if (level < 1000) {
		base = static_cast<uint32_t>(std::round(1994.008 * level));
	} else {
		base = 2 * level * level - 6 * level + 8;
	}
	// Scale down for bounty (it's not a weekly task, more frequent)
	base = base / 8;
	base *= diffMult[static_cast<uint8_t>(difficulty)];
	if (rarity == 1) base *= 2; // silver
	if (rarity == 2) base *= 4; // gold
	return base;
}

uint8_t IOPrey::getBountyPointReward(BountyDifficulty_t difficulty, uint8_t rarity) const {
	static constexpr std::array<uint8_t, 4> basePoints = {3, 7, 16, 27};
	uint8_t pts = basePoints[static_cast<uint8_t>(difficulty)];
	if (rarity == 1) pts = static_cast<uint8_t>(pts * 2);
	if (rarity == 2) pts = static_cast<uint8_t>(pts * 4);
	return pts;
}

uint16_t IOPrey::getTalismanUpgradeCost(uint16_t currentLevel) const {
	return static_cast<uint16_t>(5 + currentLevel);
}

uint16_t IOPrey::getTalismanBonusHundredths(uint16_t level) const {
	if (level == 0) return 250;                         // 2.5% base
	if (level <= 15) return 250 + level * 50;           // 3.0%–10.0% in 0.5% steps
	if (level <= 55) return 1000 + (level - 15) * 25;  // 10.25%–20.0% in 0.25% steps
	if (level <= BOUNTY_TALISMAN_MAX_LEVEL)
		return 2000 + (level - 55) * 10;               // 20.1%–50.0% in 0.1% steps
	return 5000;                                        // hard cap 50%
}

void IOPrey::parseBountyAction(const std::shared_ptr<Player> &player, uint8_t option, uint16_t value) const {
	if (!player) return;

	BountySlot &slot = player->getBountySlot();

	switch (option) {
		case 0: // OPEN_BOUNTY — generate options if needed and send data
		{
			if (!slot.hasOptions() && slot.state == 0) {
				slot.options = generateBountyOptions(slot.difficulty, {});
				for (uint8_t i = 0; i < BOUNTY_OPTION_COUNT; ++i) {
					int32_t r = uniform_random(0, 99);
					slot.optionRarities[i] = (r < 5) ? 2 : (r < 30) ? 1 : 0;
					slot.optionKillTargets[i] = getBountyKillTarget(slot.difficulty);
				}
			}
			player->sendBountyData();
			break;
		}
		case 2: // CHANGE_DIFFICULTY
		{
			if (value > 3) break;
			slot.difficulty = static_cast<BountyDifficulty_t>(value);
			// Preference stored silently — display only updates on REROLL
			break;
		}
		case 3: // REROLL
		{
			// If task is active/claimable, cancel it first (client already confirmed with the player)
			if (slot.state == 1 || slot.state == 2) {
				slot.state = 0;
				slot.activeRaceId = 0;
				slot.currentKills = 0;
				slot.totalKills = 0;
				slot.rewardXp = 0;
				slot.rewardPoints = 0;
				slot.rarity = 0;
			}
			if (slot.rerollTokens > 0) {
				--slot.rerollTokens;
			} else {
				// Gold cost: level × 200 (same as old task hunting reroll price)
				const uint64_t cost = static_cast<uint64_t>(player->getLevel()) * 200;
				if (!g_game().removeMoney(player, cost, 0, true)) {
					player->sendTextMessage(MESSAGE_EVENT_ADVANCE, "You do not have enough gold coins.");
					break;
				}
			}
			slot.options = generateBountyOptions(slot.difficulty, {});
			for (uint8_t i = 0; i < BOUNTY_OPTION_COUNT; ++i) {
				int32_t r = uniform_random(0, 99);
				slot.optionRarities[i] = (r < 5) ? 2 : (r < 30) ? 1 : 0;
				slot.optionKillTargets[i] = getBountyKillTarget(slot.difficulty);
			}
			g_logger().debug("[IOPrey::parseBountyAction] Reroll: player '{}' new options [{}, {}, {}] tokens_left={}", player->getName(), slot.options[0], slot.options[1], slot.options[2], slot.rerollTokens);
			player->sendBountyData();
			break;
		}
		case 4: // CLAIM_DAILY_REROLL
		{
			const int64_t now = OTSYS_TIME(true);
			if (now - slot.dailyRerollTimestamp >= BOUNTY_DAILY_REROLL_COOLDOWN) {
				if (slot.rerollTokens < BOUNTY_MAX_REROLL_TOKENS) {
					++slot.rerollTokens;
					slot.dailyRerollTimestamp = now;
				}
			}
			player->sendBountyData();
			break;
		}
		case 5: // SELECT_TASK — value is index 0-2
		{
			if (slot.state != 0) break;
			if (value >= BOUNTY_OPTION_COUNT) break;
			uint16_t raceId = slot.options[value];
			if (raceId == 0) break;

			// Use the rarity pre-rolled at option-generation time (already shown on the selection screen)
			slot.rarity = slot.optionRarities[value];

			slot.activeRaceId = raceId;
			slot.totalKills = getBountyKillTarget(slot.difficulty);
			slot.currentKills = 0;
			slot.rewardXp = getBountyExpReward(slot.difficulty, player->getLevel(), slot.rarity);
			slot.rewardPoints = getBountyPointReward(slot.difficulty, slot.rarity);
			slot.state = 1; // active
			player->sendBountyData();
			break;
		}
		case 6: // CLAIM_REWARD
		{
			g_logger().debug("[IOPrey::parseBountyAction] ClaimReward: player '{}' slot.state={}", player->getName(), slot.state);
			if (slot.state != 2) {
				player->sendBountyData();
				break;
			}

			const uint32_t xp = slot.rewardXp;
			const uint8_t pts = slot.rewardPoints;

			// Grant rewards
			player->addBountyExpReward(xp);
			player->addBountyPoints(pts);
			if (slot.rerollTokens < BOUNTY_MAX_REROLL_TOKENS) {
				++slot.rerollTokens;
			}

			// Reset slot and generate new options
			slot.activeRaceId = 0;
			slot.currentKills = 0;
			slot.totalKills = 0;
			slot.rewardXp = 0;
			slot.rewardPoints = 0;
			slot.rarity = 0;
			slot.state = 0;
			slot.options = generateBountyOptions(slot.difficulty, {});
			for (uint8_t i = 0; i < BOUNTY_OPTION_COUNT; ++i) {
				int32_t r = uniform_random(0, 99);
				slot.optionRarities[i] = (r < 5) ? 2 : (r < 30) ? 1 : 0;
				slot.optionKillTargets[i] = getBountyKillTarget(slot.difficulty);
			}
			player->sendBountyData();
			break;
		}
		case 7: { // TALISMAN_UPGRADE
			const auto pathIndex = static_cast<uint8_t>(value);
			if (pathIndex >= BOUNTY_TALISMAN_COUNT) break;
			auto &tal = slot.talismans[pathIndex];
			if (tal.level >= BOUNTY_TALISMAN_MAX_LEVEL) break;
			const uint64_t cost = getTalismanUpgradeCost(tal.level);
			if (!player->removeBountyPoints(cost)) break;
			++tal.level;
			player->sendBountyData();
			break;
		}
		case 12: // PREFERRED_UNLOCK
		case 13: // PREFERRED_CLEAR
		case 14: // UNWANTED_CLEAR
		case 15: // PREFERRED_ASSIGN
		case 16: // UNWANTED_ASSIGN
			player->sendBountyData(); // echo back current state
			break;
		default:
			break;
	}
}

// ── Weekly Task system ────────────────────────────────────────────────────────

uint32_t IOPrey::computeNextMondayTimestamp() {
	// Compute next Monday 00:00:00 UTC without <ctime>
	// Unix epoch (Jan 1 1970) was a Thursday = weekday 4 (0=Sun)
	const int64_t nowSec = OTSYS_TIME(true) / 1000;
	const int64_t dayIndex = nowSec / 86400;        // days since epoch
	const int wday = static_cast<int>((dayIndex + 4) % 7); // 0=Sun,1=Mon,...,6=Sat
	int daysUntilMonday = (wday == 1) ? 7 : ((8 - wday) % 7);
	if (daysUntilMonday == 0) daysUntilMonday = 7;
	const int64_t nextMondayDay = dayIndex + daysUntilMonday;
	return static_cast<uint32_t>(nextMondayDay * 86400);
}

uint16_t IOPrey::getWeeklyKillTarget(BountyDifficulty_t difficulty) const {
	static constexpr std::array<uint16_t, 4> minK = {100, 250, 500, 800};
	static constexpr std::array<uint16_t, 4> maxK = {250, 500, 1000, 1500};
	const uint8_t d = static_cast<uint8_t>(difficulty);
	return static_cast<uint16_t>(uniform_random(minK[d], maxK[d]));
}

uint16_t IOPrey::getWeeklyAnyCreatureTarget(BountyDifficulty_t difficulty) const {
	static constexpr std::array<uint16_t, 4> targets = {500, 1000, 2000, 3500};
	return targets[static_cast<uint8_t>(difficulty)];
}

uint32_t IOPrey::getWeeklyExpReward(BountyDifficulty_t difficulty, uint32_t level) const {
	uint64_t base;
	if (level <= 82) {
		base = 25ull * level * level - 75ull * level + 100;
	} else if (level < 1000) {
		base = static_cast<uint64_t>(std::round(1994.008 * level));
	} else {
		base = 2ull * level * level - 6ull * level + 8;
	}

	static constexpr std::array<uint64_t, 4> caps = {200000, 800000, 3000000, UINT64_MAX};
	if (base > caps[static_cast<uint8_t>(difficulty)]) {
		base = caps[static_cast<uint8_t>(difficulty)];
	}
	return static_cast<uint32_t>(base);
}

uint32_t IOPrey::getWeeklyPointsReward(BountyDifficulty_t difficulty) const {
	static constexpr std::array<uint32_t, 4> points = {50, 150, 400, 1000};
	return points[static_cast<uint8_t>(difficulty)];
}

void IOPrey::generateWeeklyTasks(WeeklySlot &slot, uint32_t playerLevel) const {
	slot.reset();
	slot.weeklyResetTimestamp = computeNextMondayTimestamp();

	// Pick WEEKLY_KILL_TASK_COUNT specific creatures from the appropriate pool
	const auto &pool = getBountyPool(slot.difficulty);
	std::vector<uint16_t> available = pool;

	slot.killTasks.clear();
	slot.killTasks.reserve(WEEKLY_KILL_TASK_COUNT);

	for (uint8_t i = 0; i < WEEKLY_KILL_TASK_COUNT && !available.empty(); ++i) {
		const uint32_t idx = static_cast<uint32_t>(uniform_random(0, static_cast<int32_t>(available.size()) - 1));
		WeeklyKillTask task;
		task.raceId = available[idx];
		task.totalKills = getWeeklyKillTarget(slot.difficulty);
		task.currentKills = 0;
		slot.killTasks.push_back(task);
		available.erase(available.begin() + idx);
	}

	slot.anyCreatureTotalKills = getWeeklyAnyCreatureTarget(slot.difficulty);
	slot.anyCreatureCurrentKills = 0;
	(void)playerLevel;

	generateWeeklyDeliveryTasks(slot);
}

// ── Delivery item pool ────────────────────────────────────────────────────────
namespace {
struct DeliveryItemEntry { uint16_t itemId; uint32_t minAmount; uint32_t maxAmount; };
static const DeliveryItemEntry s_deliveryItems[] = {
	// Armor
	{17829,10,20},{8050,10,20},{8043,10,20},{22085,10,20},{824,10,20},{21164,10,20},
	{8045,10,20},{825,10,20},{826,25,50},{8061,10,20},{10438,10,20},{811,10,20},
	{10384,10,20},{10439,10,20},
	// Boots
	{22086,10,20},{819,25,50},{820,10,20},{818,25,50},{21169,10,20},{813,100,200},{10386,10,20},
	// Helmets
	{829,50,100},{828,25,50},{827,10,20},{21165,10,20},{3373,10,20},{830,100,200},{3575,10,20},
	// Legs
	{21168,10,20},{3364,5,10},{3371,25,50},{3557,100,200},{22087,10,20},
	// Special
	{37110,5,10},{37109,50,100},
	// Shields / Spellbooks
	{3413,25,50},{3429,10,20},{3421,25,50},{3415,50,100},{21175,100,200},{8074,10,20},{25699,10,20},
	// Weapons
	{7436,10,20},{3337,25,50},{7428,10,20},{3301,10,20},{7427,10,20},{3292,10,20},
	{16163,10,20},{3333,10,20},{7449,25,50},{16160,10,20},{7387,50,100},{3275,25,50},
	{3322,10,20},{7402,10,20},{3320,10,20},{21180,10,20},{21179,10,20},{21178,10,20},
	{7454,25,50},{3306,50,100},{3269,50,100},{3330,10,20},{12683,10,20},{3291,50,100},
	{3318,25,50},{7381,10,20},{7386,10,20},{21171,10,20},{21174,10,20},{3316,25,50},
	{14247,10,20},{17812,25,50},{7383,10,20},{17824,25,50},{17859,10,20},{3346,10,20},
	{5858,25,50},{7425,10,20},{7413,25,50},{7388,10,20},{3342,10,20},
	// Creature products
	{36789,10,20},{36790,25,50},{48508,25,50},{24384,50,100},{9632,100,200},
	{33933,25,50},{11511,10,20},{36820,10,20},{36823,25,50},{36821,25,50},
	{36778,25,50},{36779,50,100},{36780,10,20},{11449,10,20},{18928,25,50},
	{48509,10,20},{27594,50,100},{27592,25,50},{27593,100,200},{27595,100,200},
	{27596,100,200},{27597,50,100},{27598,50,100},{27599,100,200},{27600,100,200},
	{27601,100,200},{27602,250,500},{27603,50,100},{27604,250,500},{27606,100,200},
	{36787,10,20},{36788,10,20},{36785,25,50},{36786,100,200},{36771,10,20},
	{36770,25,50},{36769,50,100},{36772,50,100},{36773,100,200},{36774,25,50},
	{36775,50,100},{36776,25,50},{36777,10,20},{36782,25,50},{36783,10,20},
	{36807,10,20},{36971,10,20},{36972,25,50},{36822,10,20},
	{9054,50,100},{9055,50,100},{21182,50,100},{9631,50,100},{9632,100,200},
	{9637,100,200},{9643,100,200},{9649,50,100},{9652,50,100},{9656,10,20},
	{9659,25,50},{9662,25,50},{9667,50,50},{9668,25,50},{9688,100,200},
	{10276,50,100},{10277,25,50},{10278,50,100},{10282,25,50},{10291,100,200},
	{10293,100,200},{10301,25,50},{10303,25,50},{10305,250,500},{10306,268,402},
	{10308,50,100},{10310,50,100},{10312,25,50},{10313,10,20},{10315,50,100},
	{10316,266,408},{10317,50,100},{10320,50,100},{10321,50,100},
	{10397,50,100},{10404,50,100},{10407,50,100},{10408,25,50},{10410,25,50},
	{10411,50,100},{10413,25,50},{10414,50,100},{10415,25,50},{10416,50,100},
	{10418,50,100},{10444,25,50},{10449,25,50},{10454,50,100},{10455,50,100},
	{10456,10,20},{11443,25,50},{11450,10,20},{11454,10,20},{11456,25,50},
	{11457,50,100},{11465,304,471},{11471,100,200},{11477,50,100},{11482,10,20},
	{11487,100,200},{11488,100,200},{11490,100,200},{11491,25,50},
	{11510,25,50},{11512,25,50},{11514,10,20},{11659,50,100},{11660,50,100},
	{11661,100,200},{11671,50,100},{11672,25,50},{11673,25,50},
	{12313,25,50},{12730,100,200},{14008,50,100},{14009,25,50},{14010,25,50},
	{14011,50,100},{14013,100,200},{14017,25,50},{14041,100,200},{14044,25,50},
	{14076,50,100},{14078,50,100},{14080,25,50},{14083,50,100},
	{14753,50,100},{16130,100,200},{16132,25,50},{16133,50,100},{16135,250,500},
	{16138,100,200},{16139,25,50},{16140,25,50},
	{17809,50,100},{17817,50,100},{17818,50,100},{17819,50,100},{17826,25,50},
	{17830,25,50},{17831,50,100},{17847,50,100},{17850,100,200},{17851,25,50},
	{17853,25,50},{17854,50,100},{17855,50,100},{17856,50,100},{17857,50,100},
	{18924,10,20},{18925,25,50},{18926,25,50},{18927,25,50},{18995,50,100},
	{19110,50,100},{19111,50,100},{20198,100,100},{20201,50,100},{20202,50,100},
	{20203,100,200},{20204,50,100},{20206,50,100},{20207,50,100},
	{21103,100,200},{21193,50,100},{21195,100,200},{21196,100,200},{21197,100,200},
	{21199,25,50},{21201,25,50},{21204,50,100},{21974,50,100},
	{22051,100,200},{22054,100,200},{22055,100,200},{22056,100,200},{22057,100,200},
	{22184,25,50},{22186,100,200},{22188,100,200},{22191,50,100},{22729,50,100},
	{23502,50,100},{23503,50,100},{23504,50,100},{23505,50,100},{23506,50,100},
	{23510,50,100},{23511,50,100},{23514,50,100},{23515,50,100},{23516,50,100},
	{23518,50,100},{23519,50,100},{23520,50,100},{23521,25,50},{23523,50,100},
	{24380,50,100},{24385,50,100},{24938,50,100},
	{25691,50,100},{25693,100,200},{25695,50,100},{25696,50,100},{25697,25,50},
	{25701,50,100},{25742,25,50},{27369,250,500},{27462,100,200},{27463,100,200},
	{28566,250,500},{28568,250,500},{28569,250,500},{28570,250,500},
	{28822,10,20},{28823,10,20},{30005,50,100},{30058,250,500},
	{31331,10,20},{31438,25,50},{31439,50,100},{31440,25,50},{31441,100,200},
	{31442,50,100},{31443,25,50},{31558,50,100},{31559,25,50},{31560,100,200},
	{31561,10,20},{31678,50,100},{32698,25,50},{33929,25,50},{33934,10,20},
	{33936,25,50},{33938,25,50},{33943,50,100},{33944,10,20},{33945,50,100},
	{33982,10,20},{34014,10,20},{34138,25,50},{34139,25,50},{34141,10,20},
	{34142,25,50},{34143,10,20},{34144,10,20},{34145,25,50},{34146,25,50},
	{34160,25,50},{34162,50,100},{35571,10,20},{35572,250,500},{35573,50,100},
	{35574,50,100},{35588,50,100},{35596,50,100},
	{39337,50,100},{39375,100,200},{39376,250,500},{39377,50,100},{39378,50,100},
	{39379,50,100},{39380,100,200},{39381,250,500},{39382,25,50},{39383,50,100},
	{39384,100,200},{39386,25,50},{39387,25,50},{39388,50,100},{39389,25,50},
	{39391,25,50},{39392,25,50},{39393,25,50},{39394,25,50},{39395,50,100},
	{39401,25,50},{39402,25,50},{39406,25,50},{39407,50,100},{39408,10,20},
	{39409,25,50},{39410,100,200},{39411,25,50},{39412,50,100},{39413,250,500},
	{39414,250,500},{40527,10,20},{40528,25,50},{40582,50,100},{40583,25,50},
	{40584,25,50},{40585,25,50},{40586,25,50},{40587,25,50},
	{43729,100,200},{43730,100,200},{43731,50,100},{43732,10,20},{43734,10,20},
	{43846,10,20},{43847,5,10},{43848,10,20},{43849,25,50},{43850,25,50},
	{43851,10,20},{43852,25,50},{43853,25,50},{44438,50,100},{44439,100,200},
	{44440,50,100},{44743,50,100},{44744,25,50},{44745,10,20},{44746,50,100},
	{44747,50,100},{44748,50,100},{44749,50,100},{48252,10,20},{48255,10,20},
	{48510,10,20},{48511,10,20},{50056,100,200},{50057,10,20},{50058,10,20},
	{50059,10,20},{5479,10,20},{3234,10,20},{6558,250,500},{5888,10,20},{5889,10,20},
};
static constexpr size_t s_deliveryItemCount = std::size(s_deliveryItems);
} // namespace

uint32_t IOPrey::getWeeklyDeliveryExpReward(BountyDifficulty_t difficulty, uint32_t level) const {
	// Delivery tasks grant half the exp that kill tasks grant
	return getWeeklyExpReward(difficulty, level) / 2;
}

void IOPrey::generateWeeklyDeliveryTasks(WeeklySlot &slot) const {
	slot.deliveryTasks.clear();
	if (s_deliveryItemCount == 0) return;

	std::unordered_set<uint16_t> used;
	uint32_t attempts = 0;
	while (slot.deliveryTasks.size() < WEEKLY_DELIVERY_TASK_COUNT && attempts < 200) {
		++attempts;
		const size_t idx = static_cast<size_t>(uniform_random(0, static_cast<int32_t>(s_deliveryItemCount) - 1));
		const auto &entry = s_deliveryItems[idx];
		if (used.count(entry.itemId)) continue;
		used.insert(entry.itemId);

		WeeklyDeliveryTask task;
		task.itemId = entry.itemId;
		task.totalAmount = (entry.minAmount == entry.maxAmount)
			? entry.minAmount
			: static_cast<uint32_t>(uniform_random(static_cast<int32_t>(entry.minAmount), static_cast<int32_t>(entry.maxAmount)));
		slot.deliveryTasks.push_back(task);
	}
}

void IOPrey::parseWeeklyAction(const std::shared_ptr<Player> &player, uint8_t option, uint8_t value) const {
	if (!player) return;

	WeeklySlot &slot = player->getWeeklySlot();

	// Always check for weekly reset first
	if (slot.needsReset()) {
		slot.reset();
	}

	switch (option) {
		case 1: // OPEN_WEEKLY — send current state
			player->sendWeeklyData();
			break;

		case 9: // SELECT_DIFFICULTY — pick difficulty and generate tasks
		{
			if (slot.isGenerated()) {
				// Tasks already running — can't change difficulty mid-week
				player->sendWeeklyData();
				break;
			}
			if (value > 3) {
				player->sendWeeklyData();
				break;
			}
			const auto newDiff = static_cast<BountyDifficulty_t>(value);
			if (static_cast<uint8_t>(newDiff) > static_cast<uint8_t>(slot.unlockedDifficulty)) {
				// Difficulty not unlocked — send current state so modal reappears
				player->sendWeeklyData();
				break;
			}
			slot.difficulty = newDiff;
			generateWeeklyTasks(slot, player->getLevel());
			const uint8_t taskCount = static_cast<uint8_t>(slot.killTasks.size());
			g_logger().debug("[IOPrey::parseWeeklyAction] Generated {} kill tasks and {} delivery tasks for player '{}' (difficulty {})", taskCount, slot.deliveryTasks.size(), player->getName(), static_cast<uint8_t>(newDiff));
			player->sendWeeklyData();
			break;
		}

		case 8: // WEEKLY_DELIVER — value = delivery task slot index
		{
			const uint8_t slotIdx = value;
			if (slotIdx >= slot.deliveryTasks.size()) break;
			WeeklyDeliveryTask &dtask = slot.deliveryTasks[slotIdx];
			if (dtask.claimed) {
				player->sendWeeklyData();
				break;
			}
			// Check and remove items
			const uint32_t have = player->getItemTypeCountForDelivery(dtask.itemId);
			if (have < dtask.totalAmount) {
				player->sendTextMessage(MESSAGE_EVENT_ADVANCE, "You do not have enough items to complete this delivery.");
				break;
			}
			if (!player->removeItemOfType(dtask.itemId, dtask.totalAmount, -1)) {
				player->sendTextMessage(MESSAGE_EVENT_ADVANCE, "Failed to remove items. Please try again.");
				break;
			}
			dtask.currentAmount = dtask.totalAmount;
			dtask.claimed = 1;
			// Grant delivery exp
			const uint32_t deliveryExp = g_ioprey().getWeeklyDeliveryExpReward(slot.difficulty, static_cast<uint32_t>(player->getLevel()))
				/ std::max<uint8_t>(1, static_cast<uint8_t>(slot.deliveryTasks.size()));
			player->addBountyExpReward(deliveryExp);
			// If all tasks now complete, grant HTP + mark finished
			if (slot.allTasksComplete() && !slot.weeklyProgressFinished) {
				const uint32_t points = g_ioprey().getWeeklyPointsReward(slot.difficulty);
				player->addTaskHuntingPoints(points);
				slot.weeklyProgressFinished = 1;
			}
			player->sendWeeklyData();
			break;
		}

		default:
			break;
	}
}

// ── Hunting Task Shop ─────────────────────────────────────────────────────────

void IOPrey::initShopOffers() {
	m_shopOffers.clear();

	// Each offer: type, title, description, itemId, addons, price (HTP), itemCount
	// Prices are in Hunting Task Points (HTP / taskHuntingPoints)

	// Platinum bundle — 10 platinum coins for 25 HTP
	m_shopOffers.push_back({
		ShopOffer_Item,
		"Platinum Bundle",
		"Receive 10 Platinum Coins.",
		238, 0, 25, 10
	});

	// Crystal Coin — 1 crystal coin for 50 HTP
	m_shopOffers.push_back({
		ShopOffer_Item,
		"Crystal Coin",
		"Receive 1 Crystal Coin.",
		2160, 0, 50, 1
	});

	// Weekly Task Expansion — 3 extra weekly task slots, costs 500 HTP (one-time)
	m_shopOffers.push_back({
		ShopOffer_WeeklyExpansion,
		"Weekly Task Expansion",
		"Permanently unlock 3 extra Weekly Task slots (9 total).",
		2160, 0, 500, 0
	});
}

void IOPrey::parseShopAction(const std::shared_ptr<Player> &player, uint8_t offerIndex) const {
	if (!player) return;
	if (offerIndex >= m_shopOffers.size()) return;

	const ShopOffer &offer = m_shopOffers[offerIndex];

	// Validate: weekly expansion already bought?
	if (offer.type == ShopOffer_WeeklyExpansion && player->getWeeklySlot().weeklyExpansion) {
		player->sendShopData();
		return;
	}

	// Deduct HTP
	if (!player->useTaskHuntingPoints(offer.price)) {
		player->sendTextMessage(MESSAGE_EVENT_ADVANCE, "You do not have enough Hunting Task Points.");
		return;
	}

	// Grant reward
	if (offer.type == ShopOffer_WeeklyExpansion) {
		player->getWeeklySlot().weeklyExpansion = 1;
		player->sendWeeklyData(); // update weekly tab to show 9 slots
	} else if (offer.type == ShopOffer_Item && offer.itemId > 0 && offer.itemCount > 0) {
		const auto &item = Item::CreateItem(static_cast<uint16_t>(offer.itemId), offer.itemCount);
		if (item) {
			if (g_game().internalAddItem(player, item) != RETURNVALUE_NOERROR) {
				g_game().internalAddItem(player->getTile(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);
			}
		}
	}

	// Refresh shop display
	player->sendShopData();
}
