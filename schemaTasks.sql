-- Task Board persistence tables
-- Run once against your canary database to enable bounty/weekly save+load

CREATE TABLE IF NOT EXISTS `player_bounty` (
  `player_id`        INT UNSIGNED    NOT NULL,
  `difficulty`       TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `state`            TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `rarity`           TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `reroll_tokens`    TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `daily_reroll_ts`  BIGINT           NOT NULL DEFAULT 0,
  `active_race_id`   SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `current_kills`    SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `total_kills`      SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `reward_xp`        INT UNSIGNED    NOT NULL DEFAULT 0,
  `reward_points`    TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `option_1`         SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `option_2`         SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `option_3`         SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `option_kill_1`    SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `option_kill_2`    SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `option_kill_3`    SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `option_rarity_1`  TINYINT UNSIGNED  NOT NULL DEFAULT 0,
  `option_rarity_2`  TINYINT UNSIGNED  NOT NULL DEFAULT 0,
  `option_rarity_3`  TINYINT UNSIGNED  NOT NULL DEFAULT 0,
  `talisman_1`       SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `talisman_2`       SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `talisman_3`       SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `talisman_4`       SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `pref1_unlocked`   TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `pref1_preferred`  SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `pref1_unwanted`   SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `pref2_unlocked`   TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `pref2_preferred`  SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `pref2_unwanted`   SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `pref3_unlocked`   TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `pref3_preferred`  SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `pref3_unwanted`   SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `pref4_unlocked`   TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `pref4_preferred`  SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `pref4_unwanted`   SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `pref5_unlocked`   TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `pref5_preferred`  SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `pref5_unwanted`   SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `bounty_points`    BIGINT UNSIGNED  NOT NULL DEFAULT 0,
  PRIMARY KEY (`player_id`),
  FOREIGN KEY (`player_id`) REFERENCES `players`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `player_weekly` (
  `player_id`             INT UNSIGNED    NOT NULL,
  `difficulty`            TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `unlocked_difficulty`   TINYINT UNSIGNED NOT NULL DEFAULT 3,
  `any_creature_total`    SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `any_creature_current`  SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `progress_finished`     TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `weekly_expansion`      TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `points_earned`         INT UNSIGNED    NOT NULL DEFAULT 0,
  `soulseals_earned`      INT UNSIGNED    NOT NULL DEFAULT 0,
  `reset_timestamp`       INT UNSIGNED    NOT NULL DEFAULT 0,
  PRIMARY KEY (`player_id`),
  FOREIGN KEY (`player_id`) REFERENCES `players`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `player_weekly_kills` (
  `player_id`    INT UNSIGNED    NOT NULL,
  `task_index`   TINYINT UNSIGNED NOT NULL,
  `race_id`      SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `total_kills`  SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `current_kills` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`player_id`, `task_index`),
  FOREIGN KEY (`player_id`) REFERENCES `players`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `player_weekly_deliveries` (
  `player_id`      INT UNSIGNED    NOT NULL,
  `task_index`     TINYINT UNSIGNED NOT NULL,
  `item_id`        SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `total_amount`   INT UNSIGNED    NOT NULL DEFAULT 0,
  `current_amount` INT UNSIGNED    NOT NULL DEFAULT 0,
  `claimed`        TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`player_id`, `task_index`),
  FOREIGN KEY (`player_id`) REFERENCES `players`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
