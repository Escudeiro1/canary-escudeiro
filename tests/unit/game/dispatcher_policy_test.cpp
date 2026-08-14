/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (c) 2019-present OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#include "game/scheduling/dispatcher_policy.hpp"

TEST(DispatcherPolicyTest, ReturnsAcceptedBooleanFromFallbackLane) {
	std::vector<DispatcherLane> attempts;
	const bool accepted = DispatcherPolicy::scheduleWithFallbackLane(
		[&attempts](DispatcherLane lane) {
			attempts.push_back(lane);
			return lane == DispatcherLane::WorldCommit;
		},
		DispatcherLane::ProtocolInput,
		DispatcherLane::WorldCommit
	);

	EXPECT_TRUE(accepted);
	EXPECT_EQ(attempts, (std::vector { DispatcherLane::ProtocolInput, DispatcherLane::WorldCommit }));
}

TEST(DispatcherPolicyTest, StopsRetryAfterPermanentShutdownRejection) {
	EXPECT_EQ(DispatcherPolicy::classifyAdmission(true, true), DispatcherAdmissionResult::Accepted);
	EXPECT_EQ(DispatcherPolicy::classifyAdmission(false, false), DispatcherAdmissionResult::Saturated);
	EXPECT_EQ(DispatcherPolicy::classifyAdmission(false, true), DispatcherAdmissionResult::ShuttingDown);
}
