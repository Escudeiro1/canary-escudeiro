/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019–present OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#pragma once

// TODO: Remove circular includes (maybe shared_ptr?)
#include "server/network/message/networkmessage.hpp"
#include "utils/tools.hpp"

class PreySlot;
class TaskHuntingSlot;
class TaskHuntingOption;
class NetworkMessage;
class Player;

enum PreySlot_t : uint8_t {
	PreySlot_One = 0,
	PreySlot_Two = 1,
	PreySlot_Three = 2,

	PreySlot_First = PreySlot_One,
	PreySlot_Last = PreySlot_Three
};

enum PreyDataState_t : uint8_t {
	PreyDataState_Locked = 0,
	PreyDataState_Inactive = 1,
	PreyDataState_Active = 2,
	PreyDataState_Selection = 3,
	PreyDataState_SelectionChangeMonster = 4,
	PreyDataState_ListSelection = 5,
	PreyDataState_WildcardSelection = 6
};

enum PreyBonus_t : uint8_t {
	PreyBonus_Damage = 0,
	PreyBonus_Defense = 1,
	PreyBonus_Experience = 2,
	PreyBonus_Loot = 3,
	PreyBonus_None = 4, // Do not send this to client

	PreyBonus_First = PreyBonus_Damage,
	PreyBonus_Last = PreyBonus_Loot
};

enum PreyOption_t : uint8_t {
	PreyOption_None = 0,
	PreyOption_AutomaticReroll = 1,
	PreyOption_Locked = 2
};

enum PreyAction_t : uint8_t {
	PreyAction_ListReroll = 0,
	PreyAction_BonusReroll = 1,
	PreyAction_MonsterSelection = 2,
	PreyAction_ListAll_Cards = 3,
	PreyAction_ListAll_Selection = 4,
	PreyAction_Option = 5
};

enum PreyTaskDataState_t : uint8_t {
	PreyTaskDataState_Locked = 0,
	PreyTaskDataState_Inactive = 1,
	PreyTaskDataState_Selection = 2,
	PreyTaskDataState_ListSelection = 3,
	PreyTaskDataState_Active = 4,
	PreyTaskDataState_Completed = 5
};

enum PreyTaskAction_t : uint8_t {
	PreyTaskAction_ListReroll = 0,
	PreyTaskAction_RewardsReroll = 1,
	PreyTaskAction_ListAll_Cards = 2,
	PreyTaskAction_MonsterSelection = 3,
	PreyTaskAction_Cancel = 4,
	PreyTaskAction_Claim = 5
};

enum PreyTaskDifficult_t : uint8_t {
	PreyTaskDifficult_None = 0,
	PreyTaskDifficult_Easy = 1,
	PreyTaskDifficult_Medium = 2,
	PreyTaskDifficult_Hard = 3,

	PreyTaskDifficult_First = PreyTaskDifficult_Easy,
	PreyTaskDifficult_Last = PreyTaskDifficult_Hard
};

class NetworkMessage;

class PreySlot {
public:
	PreySlot() = default;
	explicit PreySlot(PreySlot_t id);
	virtual ~PreySlot() = default;

	bool isOccupied() const {
		return selectedRaceId != 0 && bonusTimeLeft > 0;
	}

	bool canSelect() const {
		return (state == PreyDataState_Selection || state == PreyDataState_SelectionChangeMonster || state == PreyDataState_ListSelection || state == PreyDataState_Inactive);
	}

	void eraseBonus(bool maintainBonus = false) {
		if (!maintainBonus) {
			bonus = PreyBonus_None;
			bonusPercentage = 5;
			bonusRarity = 1;
		}
		state = PreyDataState_Selection;
		option = PreyOption_None;
		selectedRaceId = 0;
		bonusTimeLeft = 0;
	}

	void removeMonsterType(uint16_t raceId) {
		raceIdList.erase(std::remove(raceIdList.begin(), raceIdList.end(), raceId), raceIdList.end());
	}

	void reloadBonusType();
	void reloadBonusValue();
	void reloadMonsterGrid(std::vector<uint16_t> blackList, uint32_t level);

	PreySlot_t id = PreySlot_First;
	PreyBonus_t bonus = PreyBonus_None;
	PreyDataState_t state = PreyDataState_Locked;
	PreyOption_t option = PreyOption_None;

	std::vector<uint16_t> raceIdList;

	uint8_t bonusRarity = 1;

	uint16_t selectedRaceId = 0;
	uint16_t bonusPercentage = 0;
	uint16_t bonusTimeLeft = 0;

	int64_t freeRerollTimeStamp = 0;
};

class TaskHuntingSlot {
public:
	TaskHuntingSlot() = default;
	explicit TaskHuntingSlot(PreySlot_t id);
	virtual ~TaskHuntingSlot() = default;

	bool isOccupied() const {
		return selectedRaceId != 0;
	}

	bool canSelect() const {
		return (state == PreyTaskDataState_Selection || state == PreyTaskDataState_ListSelection);
	}

	void eraseTask() {
		upgrade = false;
		state = PreyTaskDataState_Selection;
		selectedRaceId = 0;
		currentKills = 0;
		rarity = 1;
	}

	void removeMonsterType(uint16_t raceId) {
		raceIdList.erase(std::remove(raceIdList.begin(), raceIdList.end(), raceId), raceIdList.end());
	}

	bool isCreatureOnList(uint16_t raceId) const {
		auto it = std::find_if(raceIdList.begin(), raceIdList.end(), [raceId](uint16_t it) {
			return it == raceId;
		});

		return it != raceIdList.end();
	}

	void reloadReward();
	void reloadMonsterGrid(std::vector<uint16_t> blackList, uint32_t level);

	PreySlot_t id = PreySlot_First;
	PreyTaskDataState_t state = PreyTaskDataState_Inactive;

	bool upgrade = false;

	uint8_t rarity = 1;

	uint16_t selectedRaceId = 0;
	uint16_t currentKills = 0;

	int64_t disabledUntilTimeStamp = 0;
	int64_t freeRerollTimeStamp = 0;

	std::vector<uint16_t> raceIdList;
};

class TaskHuntingOption {
public:
	TaskHuntingOption() = default;
	virtual ~TaskHuntingOption() = default;

	PreyTaskDifficult_t difficult = PreyTaskDifficult_None;
	uint8_t rarity = 1;

	uint16_t firstKills = 0;
	uint16_t secondKills = 0;

	uint16_t firstReward = 0;
	uint16_t secondReward = 0;
};

static const std::unique_ptr<PreySlot> &PreySlotNull {};
static const std::unique_ptr<TaskHuntingSlot> &TaskHuntingSlotNull {};
static const std::unique_ptr<TaskHuntingOption> &TaskHuntingOptionNull {};

// ── Bounty Task system (Task Board, Winter 2025) ─────────────────────────────
constexpr uint8_t BOUNTY_TALISMAN_COUNT = 4;
constexpr uint8_t BOUNTY_PREFERRED_SLOT_COUNT = 5;
constexpr uint8_t BOUNTY_OPTION_COUNT = 3;
constexpr uint8_t BOUNTY_MAX_REROLL_TOKENS = 10;
constexpr int64_t BOUNTY_DAILY_REROLL_COOLDOWN = 86400000LL; // 24 hours in milliseconds (matches OTSYS_TIME)

enum BountyDifficulty_t : uint8_t {
	BountyDifficulty_Beginner = 0,
	BountyDifficulty_Adept = 1,
	BountyDifficulty_Expert = 2,
	BountyDifficulty_Master = 3
};

enum BountyRerollMode_t : uint8_t {
	BountyRerollMode_DailyClaimable = 0,
	BountyRerollMode_TimerRunning = 1,
	BountyRerollMode_LimitReached = 2
};

struct BountyTalisman {
	uint8_t level = 0;
};

struct BountyPreferredSlot {
	bool unlocked = false;
	uint16_t preferredRaceId = 0;
	uint16_t unwantedRaceId = 0;
};

struct BountySlot {
	BountyDifficulty_t difficulty = BountyDifficulty_Beginner;
	uint8_t state = 0; // 0=selection, 1=active, 2=claimable
	uint8_t rarity = 0; // 0=normal, 1=silver, 2=gold
	uint8_t rerollTokens = 1;
	int64_t dailyRerollTimestamp = 0;

	uint16_t activeRaceId = 0;
	uint16_t currentKills = 0;
	uint16_t totalKills = 0;
	uint32_t rewardXp = 0;
	uint8_t rewardPoints = 0;

	std::array<uint16_t, BOUNTY_OPTION_COUNT> options = {};
	std::array<uint8_t, BOUNTY_OPTION_COUNT> optionRarities = {}; // pre-rolled per option; 0=normal,1=silver,2=gold
	std::array<BountyTalisman, BOUNTY_TALISMAN_COUNT> talismans;
	std::array<BountyPreferredSlot, BOUNTY_PREFERRED_SLOT_COUNT> preferredSlots;

	BountySlot() {
		options.fill(0);
		optionRarities.fill(0);
		preferredSlots[0].unlocked = true;
	}

	bool hasOptions() const {
		return options[0] != 0 || options[1] != 0 || options[2] != 0;
	}
};
// ─────────────────────────────────────────────────────────────────────────────

// ── Weekly Task system ────────────────────────────────────────────────────────
constexpr uint8_t WEEKLY_KILL_TASK_COUNT = 5;
constexpr uint8_t WEEKLY_DELIVERY_TASK_COUNT = 2;

struct WeeklyKillTask {
	uint16_t raceId = 0;
	uint16_t totalKills = 0;
	uint16_t currentKills = 0;
	bool isComplete() const { return totalKills > 0 && currentKills >= totalKills; }
};

struct WeeklyDeliveryTask {
	uint16_t itemId = 0;
	uint32_t totalAmount = 0;
	uint32_t currentAmount = 0;
	uint8_t claimed = 0;
	bool isComplete() const { return claimed != 0 || (totalAmount > 0 && currentAmount >= totalAmount); }
};

struct WeeklySlot {
	BountyDifficulty_t difficulty = BountyDifficulty_Beginner;
	BountyDifficulty_t unlockedDifficulty = BountyDifficulty_Master; // unlock all difficulties by default

	uint16_t anyCreatureTotalKills = 0;
	uint16_t anyCreatureCurrentKills = 0;

	std::vector<WeeklyKillTask> killTasks;
	std::vector<WeeklyDeliveryTask> deliveryTasks;

	uint8_t weeklyProgressFinished = 0;
	uint8_t weeklyExpansion = 0; // 0 = 6 slots, 1 = 9 slots (purchased from shop)
	uint32_t pointsEarned = 0;
	uint32_t soulsealsEarned = 0;
	uint32_t weeklyResetTimestamp = 0; // Unix seconds of next Monday 00:00 UTC

	bool isGenerated() const { return weeklyResetTimestamp > 0 && !killTasks.empty(); }

	bool needsReset() const {
		if (weeklyResetTimestamp == 0) return false;
		const int64_t nowSec = static_cast<int64_t>(OTSYS_TIME(true) / 1000);
		return nowSec >= static_cast<int64_t>(weeklyResetTimestamp);
	}

	uint8_t countCompletedKillTasks() const {
		uint8_t n = (anyCreatureTotalKills > 0 && anyCreatureCurrentKills >= anyCreatureTotalKills) ? 1 : 0;
		for (const auto &t : killTasks) {
			if (t.isComplete()) n++;
		}
		return n;
	}

	uint8_t countCompletedDeliveryTasks() const {
		uint8_t n = 0;
		for (const auto &t : deliveryTasks) {
			if (t.isComplete()) n++;
		}
		return n;
	}

	bool allKillTasksComplete() const {
		if (!isGenerated()) return false;
		if (anyCreatureTotalKills > 0 && anyCreatureCurrentKills < anyCreatureTotalKills) return false;
		for (const auto &t : killTasks) {
			if (!t.isComplete()) return false;
		}
		return true;
	}

	bool allDeliveryTasksComplete() const {
		for (const auto &t : deliveryTasks) {
			if (!t.isComplete()) return false;
		}
		return true;
	}

	bool allTasksComplete() const {
		return allKillTasksComplete() && allDeliveryTasksComplete();
	}

	void reset() {
		killTasks.clear();
		deliveryTasks.clear();
		anyCreatureTotalKills = 0;
		anyCreatureCurrentKills = 0;
		weeklyProgressFinished = 0;
		pointsEarned = 0;
		soulsealsEarned = 0;
		weeklyResetTimestamp = 0;
	}
};
// ─────────────────────────────────────────────────────────────────────────────

// ── Hunting Task Shop ─────────────────────────────────────────────────────────
enum ShopOfferType_t : uint8_t {
	ShopOffer_Item = 0,
	ShopOffer_Mount = 1,
	ShopOffer_Outfit = 2,
	ShopOffer_ItemDouble = 3,
	ShopOffer_BonusPromotion = 4,
	ShopOffer_WeeklyExpansion = 5
};

struct ShopOffer {
	ShopOfferType_t type = ShopOffer_Item;
	std::string title;
	std::string description;
	uint32_t itemId = 0;   // display item (or lookType for mount/outfit)
	uint8_t addons = 0;    // outfit addons only
	uint32_t price = 0;    // cost in Hunting Task Points
	uint16_t itemCount = 1; // how many items to grant
};
// ─────────────────────────────────────────────────────────────────────────────

class IOPrey {
public:
	IOPrey() = default;

	// non-copyable
	IOPrey(const IOPrey &) = delete;
	void operator=(const IOPrey &) = delete;

	static IOPrey &getInstance();

	void checkPlayerPreys(const std::shared_ptr<Player> &player, uint8_t amount) const;
	void parsePreyAction(const std::shared_ptr<Player> &player, PreySlot_t slotId, PreyAction_t action, PreyOption_t option, int8_t index, uint16_t raceId) const;

	void parseTaskHuntingAction(const std::shared_ptr<Player> &player, PreySlot_t slotId, PreyTaskAction_t action, bool upgrade, uint16_t raceId) const;

	void initializeTaskHuntOptions();
	const std::unique_ptr<TaskHuntingOption> &getTaskRewardOption(const std::unique_ptr<TaskHuntingSlot> &slot) const;

	NetworkMessage getTaskHuntingBaseDate() const;

	// Bounty Task system
	void initBountyPools();
	void parseBountyAction(const std::shared_ptr<Player> &player, uint8_t option, uint16_t value) const;
	std::array<uint16_t, BOUNTY_OPTION_COUNT> generateBountyOptions(BountyDifficulty_t difficulty, const std::vector<uint16_t> &blackList) const;
	uint16_t getBountyKillTarget(BountyDifficulty_t difficulty) const;
	uint32_t getBountyExpReward(BountyDifficulty_t difficulty, uint32_t level, uint8_t rarity) const;
	uint8_t getBountyPointReward(BountyDifficulty_t difficulty, uint8_t rarity) const;
	uint16_t getTalismanUpgradeCost(uint8_t currentLevel) const;
	const std::vector<uint16_t> &getBountyPool(BountyDifficulty_t difficulty) const;

	// Weekly Task system
	void parseWeeklyAction(const std::shared_ptr<Player> &player, uint8_t option, uint8_t value) const;
	void generateWeeklyTasks(WeeklySlot &slot, uint32_t playerLevel) const;
	void generateWeeklyDeliveryTasks(WeeklySlot &slot) const;
	uint32_t getWeeklyExpReward(BountyDifficulty_t difficulty, uint32_t level) const;
	uint32_t getWeeklyDeliveryExpReward(BountyDifficulty_t difficulty, uint32_t level) const;
	uint32_t getWeeklyPointsReward(BountyDifficulty_t difficulty) const;
	uint16_t getWeeklyKillTarget(BountyDifficulty_t difficulty) const;
	uint16_t getWeeklyAnyCreatureTarget(BountyDifficulty_t difficulty) const;
	static uint32_t computeNextMondayTimestamp();

	// Hunting Task Shop
	void initShopOffers();
	void parseShopAction(const std::shared_ptr<Player> &player, uint8_t offerIndex) const;
	const std::vector<ShopOffer> &getShopOffers() const { return m_shopOffers; }

	NetworkMessage m_baseDataMessage;
	std::vector<std::unique_ptr<TaskHuntingOption>> taskOption;
	std::array<std::vector<uint16_t>, 4> m_bountyPools;
	std::vector<ShopOffer> m_shopOffers;
};

constexpr auto g_ioprey = IOPrey::getInstance;
