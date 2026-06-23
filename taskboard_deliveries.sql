-- Task Board: weekly delivery task persistence
-- Run once against your existing database.

CREATE TABLE IF NOT EXISTS `player_weekly_deliveries` (
  `player_id`      int(11) NOT NULL,
  `task_index`     TINYINT UNSIGNED NOT NULL,
  `item_id`        SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `total_amount`   INT UNSIGNED NOT NULL DEFAULT 0,
  `current_amount` INT UNSIGNED NOT NULL DEFAULT 0,
  `claimed`        TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`player_id`, `task_index`),
  FOREIGN KEY (`player_id`) REFERENCES `players`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
