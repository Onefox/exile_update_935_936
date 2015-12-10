/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

ALTER TABLE `account`
  DROP FOREIGN KEY account_ibfk_1,
  DROP INDEX clan_id;
ALTER TABLE `account`
ADD CONSTRAINT account_ibfk_1 FOREIGN KEY(clan_id) REFERENCES `clan`(id),
  ADD INDEX clan_id (clan_id),
  CHANGE COLUMN last_connect_at last_connect_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CHANGE COLUMN first_connect_at first_connect_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP;


ALTER TABLE `clan`
  DROP FOREIGN KEY clan_ibfk_1;

ALTER TABLE `clan`
ADD CONSTRAINT clan_ibfk_1 FOREIGN KEY(leader_uid) REFERENCES `account`(uid) ON DELETE CASCADE,
  CHANGE COLUMN created_at created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP;

delete c.* FROM `construction` c LEFT JOIN `account` a on a.uid = c.account_uid WHERE a.uid IS NULL;

ALTER TABLE `construction`
  DROP COLUMN maintained_at;

ALTER TABLE `construction`
ADD CONSTRAINT construction_ibfk_1 FOREIGN KEY(account_uid) REFERENCES `account`(uid) ON DELETE CASCADE,
ADD CONSTRAINT construction_ibfk_2 FOREIGN KEY(territory_id) REFERENCES `territory`(id) ON DELETE CASCADE,
  ADD INDEX account_uid (account_uid),
  ADD INDEX territory_id (territory_id),
  ADD COLUMN territory_id int(11) unsigned NULL AFTER pin_code,
  ADD COLUMN last_updated_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  CHANGE COLUMN direction_z direction_z double NOT NULL DEFAULT '0' AFTER direction_y,
  CHANGE COLUMN direction_y direction_y double NOT NULL DEFAULT '0' AFTER direction_x,
  CHANGE COLUMN direction_x direction_x double NOT NULL DEFAULT '0' AFTER position_z,
  CHANGE COLUMN up_x up_x double NOT NULL DEFAULT '0' AFTER direction_z,
  CHANGE COLUMN up_y up_y double NOT NULL DEFAULT '0' AFTER up_x,
  CHANGE COLUMN is_locked is_locked tinyint(1) NOT NULL DEFAULT '0' AFTER up_z,
  CHANGE COLUMN position_z position_z double NOT NULL DEFAULT '0' AFTER position_y,
  CHANGE COLUMN position_x position_x double NOT NULL DEFAULT '0',
  CHANGE COLUMN position_y position_y double NOT NULL DEFAULT '0' AFTER position_x,
  CHANGE COLUMN spawned_at spawned_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CHANGE COLUMN up_z up_z double NOT NULL DEFAULT '0' AFTER up_y,
  CHANGE COLUMN pin_code pin_code varchar(6) NOT NULL DEFAULT '000000' AFTER is_locked;


DELETE c.* FROM  `container` c LEFT JOIN  `account` a ON a.uid = c.account_uid WHERE a.uid IS NULL;

ALTER TABLE `container`
  DROP COLUMN last_accessed;
ALTER TABLE `container`
ADD CONSTRAINT container_ibfk_1 FOREIGN KEY(account_uid) REFERENCES `account`(uid) ON DELETE CASCADE,
ADD CONSTRAINT container_ibfk_2 FOREIGN KEY(territory_id) REFERENCES `territory`(id) ON DELETE CASCADE,
  ADD INDEX account_uid (account_uid),
  ADD INDEX territory_id (territory_id),
  ADD COLUMN territory_id int(11) unsigned NULL AFTER pin_code,
  ADD COLUMN last_updated_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP AFTER cargo_container,
  CHANGE COLUMN direction_z direction_z double NOT NULL DEFAULT '0' AFTER direction_y,
  CHANGE COLUMN is_locked is_locked tinyint(1) NOT NULL DEFAULT '0',
  CHANGE COLUMN direction_x direction_x double NOT NULL DEFAULT '0' AFTER position_z,
  CHANGE COLUMN up_x up_x double NOT NULL DEFAULT '0' AFTER direction_z,
  CHANGE COLUMN up_y up_y double NOT NULL DEFAULT '0' AFTER up_x,
  CHANGE COLUMN cargo_magazines cargo_magazines text NOT NULL AFTER cargo_items,
  CHANGE COLUMN direction_y direction_y double NOT NULL DEFAULT '0' AFTER direction_x,
  CHANGE COLUMN cargo_weapons cargo_weapons text NOT NULL AFTER cargo_magazines,
  CHANGE COLUMN position_z position_z double NOT NULL DEFAULT '0' AFTER position_y,
  CHANGE COLUMN position_x position_x double NOT NULL DEFAULT '0' AFTER is_locked,
  CHANGE COLUMN position_y position_y double NOT NULL DEFAULT '0' AFTER position_x,
  CHANGE COLUMN spawned_at spawned_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CHANGE COLUMN cargo_items cargo_items text NOT NULL AFTER up_z,
  CHANGE COLUMN cargo_container cargo_container text NOT NULL AFTER cargo_weapons,
  CHANGE COLUMN up_z up_z double NOT NULL DEFAULT '1' AFTER up_y;


DELETE p.* FROM `player` p LEFT JOIN `account` a on a.uid = p.account_uid WHERE a.uid IS NULL;

ALTER TABLE `player`
  DROP COLUMN hitpoint_head,
  DROP COLUMN died_at,
  DROP COLUMN hitpoint_body,
  DROP COLUMN hitpoint_legs,
  DROP COLUMN hitpoint_hands,
  DROP COLUMN fatigue,
  DROP COLUMN is_alive;
ALTER TABLE `player`
ADD CONSTRAINT player_ibfk_1 FOREIGN KEY(account_uid) REFERENCES `account`(uid) ON DELETE CASCADE,
  ADD COLUMN hitpoints varchar(255) NOT NULL DEFAULT '[]' AFTER bleeding_remaining,
  ADD COLUMN last_updated_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP AFTER vest_weapons,
  CHANGE COLUMN secondary_weapon_items secondary_weapon_items varchar(255) NOT NULL AFTER secondary_weapon,
  CHANGE COLUMN loaded_magazines loaded_magazines varchar(255) NOT NULL AFTER binocular,
  CHANGE COLUMN hunger hunger double unsigned NOT NULL DEFAULT '100',
  CHANGE COLUMN backpack_weapons backpack_weapons text NOT NULL AFTER backpack_magazines,
  CHANGE COLUMN vest_magazines vest_magazines text NOT NULL AFTER vest_items,
  CHANGE COLUMN vest vest varchar(64) NOT NULL AFTER uniform_weapons,
  CHANGE COLUMN handgun_weapon handgun_weapon varchar(64) NOT NULL AFTER handgun_items,
  CHANGE COLUMN goggles goggles varchar(64) NOT NULL AFTER current_weapon,
  CHANGE COLUMN current_weapon current_weapon varchar(64) NOT NULL AFTER backpack_weapons,
  CHANGE COLUMN position_x position_x double NOT NULL DEFAULT '0' AFTER direction,
  CHANGE COLUMN position_y position_y double NOT NULL DEFAULT '0' AFTER position_x,
  CHANGE COLUMN alcohol alcohol double unsigned NOT NULL DEFAULT '0' AFTER thirst,
  CHANGE COLUMN backpack backpack varchar(64) NOT NULL AFTER assigned_items,
  CHANGE COLUMN assigned_items assigned_items text NOT NULL,
  CHANGE COLUMN damage damage double unsigned NOT NULL DEFAULT '0',
  CHANGE COLUMN thirst thirst double unsigned NOT NULL DEFAULT '100' AFTER hunger,
  CHANGE COLUMN uniform uniform varchar(64) NOT NULL AFTER secondary_weapon_items,
  CHANGE COLUMN oxygen_remaining oxygen_remaining double unsigned NOT NULL DEFAULT '1' AFTER alcohol,
  CHANGE COLUMN secondary_weapon secondary_weapon varchar(64) NOT NULL AFTER primary_weapon_items,
  CHANGE COLUMN direction direction double NOT NULL DEFAULT '0',
  CHANGE COLUMN spawned_at spawned_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER position_z,
  CHANGE COLUMN vest_items vest_items text NOT NULL AFTER vest,
  CHANGE COLUMN primary_weapon primary_weapon varchar(64) NOT NULL AFTER loaded_magazines,
  CHANGE COLUMN uniform_magazines uniform_magazines text NOT NULL AFTER uniform_items,
  CHANGE COLUMN bleeding_remaining bleeding_remaining double unsigned NOT NULL DEFAULT '0' AFTER oxygen_remaining,
  CHANGE COLUMN headgear headgear varchar(64) NOT NULL AFTER handgun_weapon,
  CHANGE COLUMN uniform_items uniform_items text NOT NULL AFTER uniform,
  CHANGE COLUMN primary_weapon_items primary_weapon_items varchar(255) NOT NULL AFTER primary_weapon,
  CHANGE COLUMN binocular binocular varchar(64) NOT NULL AFTER headgear,
  CHANGE COLUMN backpack_items backpack_items text NOT NULL AFTER backpack,
  CHANGE COLUMN vest_weapons vest_weapons text NOT NULL AFTER vest_magazines,
  CHANGE COLUMN handgun_items handgun_items varchar(255) NOT NULL AFTER goggles,
  CHANGE COLUMN position_z position_z double NOT NULL DEFAULT '0' AFTER position_y,
  CHANGE COLUMN uniform_weapons uniform_weapons text NOT NULL AFTER uniform_magazines,
  CHANGE COLUMN backpack_magazines backpack_magazines text NOT NULL AFTER backpack_items;



ALTER TABLE `territory`
  DROP COLUMN last_payed_at;
ALTER TABLE `territory`
ADD CONSTRAINT territory_ibfk_2 FOREIGN KEY(flag_stolen_by_uid) REFERENCES `account`(uid) ON DELETE SET NULL,
ADD CONSTRAINT territory_ibfk_1 FOREIGN KEY(owner_uid) REFERENCES `account`(uid) ON DELETE CASCADE,
  ADD INDEX owner_uid (owner_uid),
  ADD INDEX flag_stolen_by_uid (flag_stolen_by_uid),
  ADD COLUMN last_paid_at datetime NULL DEFAULT CURRENT_TIMESTAMP AFTER created_at,
  CHANGE COLUMN created_at created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP;


DELETE v.* FROM  `vehicle` v LEFT JOIN  `account` a ON a.uid = v.account_uid WHERE a.uid IS NULL;

ALTER TABLE `vehicle`
ADD CONSTRAINT vehicle_ibfk_1 FOREIGN KEY(account_uid) REFERENCES `account`(uid) ON DELETE CASCADE,
  ADD INDEX account_uid (account_uid),
  ADD COLUMN last_updated_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP AFTER cargo_container,
  CHANGE COLUMN spawned_at spawned_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CHANGE COLUMN pin_code pin_code varchar(6) NOT NULL DEFAULT '000000';


CREATE TABLE `player_history` (
  `id` int(11) UNSIGNED NOT NULL,
  `account_uid` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `died_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `position_x` double NOT NULL,
  `position_y` double NOT NULL,
  `position_z` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

UPDATE
    `construction` c
INNER JOIN  `territory` t ON ABS( t.position_x - c.position_x ) < t.radius
AND ABS( t.position_y - c.position_y ) < t.radius
SET
    c.territory_id = t.id;


UPDATE
    `container` c
INNER JOIN  `territory` t ON ABS( t.position_x - c.position_x ) < t.radius
AND ABS( t.position_y - c.position_y ) < t.radius
SET
    c.territory_id = t.id;

UPDATE territory SET flag_texture = REPLACE (flag_texture, 'exile_client', 'exile_assets') WHERE flag_texture LIKE '%exile_client%';


/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
	/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

ALTER TABLE `account`
  DROP FOREIGN KEY account_ibfk_1,
  DROP INDEX clan_id;
ALTER TABLE `account`
ADD CONSTRAINT account_ibfk_1 FOREIGN KEY(clan_id) REFERENCES `clan`(id),
  ADD INDEX clan_id (clan_id),
  CHANGE COLUMN last_connect_at last_connect_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CHANGE COLUMN first_connect_at first_connect_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP;


ALTER TABLE `clan`
  DROP FOREIGN KEY clan_ibfk_1;

ALTER TABLE `clan`
ADD CONSTRAINT clan_ibfk_1 FOREIGN KEY(leader_uid) REFERENCES `account`(uid) ON DELETE CASCADE,
  CHANGE COLUMN created_at created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP;

delete c.* FROM `construction` c LEFT JOIN `account` a on a.uid = c.account_uid WHERE a.uid IS NULL;

ALTER TABLE `construction`
  DROP COLUMN maintained_at;

ALTER TABLE `construction`
ADD CONSTRAINT construction_ibfk_1 FOREIGN KEY(account_uid) REFERENCES `account`(uid) ON DELETE CASCADE,
ADD CONSTRAINT construction_ibfk_2 FOREIGN KEY(territory_id) REFERENCES `territory`(id) ON DELETE CASCADE,
  ADD INDEX account_uid (account_uid),
  ADD INDEX territory_id (territory_id),
  ADD COLUMN territory_id int(11) unsigned NULL AFTER pin_code,
  ADD COLUMN last_updated_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  CHANGE COLUMN direction_z direction_z double NOT NULL DEFAULT '0' AFTER direction_y,
  CHANGE COLUMN direction_y direction_y double NOT NULL DEFAULT '0' AFTER direction_x,
  CHANGE COLUMN direction_x direction_x double NOT NULL DEFAULT '0' AFTER position_z,
  CHANGE COLUMN up_x up_x double NOT NULL DEFAULT '0' AFTER direction_z,
  CHANGE COLUMN up_y up_y double NOT NULL DEFAULT '0' AFTER up_x,
  CHANGE COLUMN is_locked is_locked tinyint(1) NOT NULL DEFAULT '0' AFTER up_z,
  CHANGE COLUMN position_z position_z double NOT NULL DEFAULT '0' AFTER position_y,
  CHANGE COLUMN position_x position_x double NOT NULL DEFAULT '0',
  CHANGE COLUMN position_y position_y double NOT NULL DEFAULT '0' AFTER position_x,
  CHANGE COLUMN spawned_at spawned_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CHANGE COLUMN up_z up_z double NOT NULL DEFAULT '0' AFTER up_y,
  CHANGE COLUMN pin_code pin_code varchar(6) NOT NULL DEFAULT '000000' AFTER is_locked;


DELETE c.* FROM  `container` c LEFT JOIN  `account` a ON a.uid = c.account_uid WHERE a.uid IS NULL;

ALTER TABLE `container`
  DROP COLUMN last_accessed;
ALTER TABLE `container`
ADD CONSTRAINT container_ibfk_1 FOREIGN KEY(account_uid) REFERENCES `account`(uid) ON DELETE CASCADE,
ADD CONSTRAINT container_ibfk_2 FOREIGN KEY(territory_id) REFERENCES `territory`(id) ON DELETE CASCADE,
  ADD INDEX account_uid (account_uid),
  ADD INDEX territory_id (territory_id),
  ADD COLUMN territory_id int(11) unsigned NULL AFTER pin_code,
  ADD COLUMN last_updated_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP AFTER cargo_container,
  CHANGE COLUMN direction_z direction_z double NOT NULL DEFAULT '0' AFTER direction_y,
  CHANGE COLUMN is_locked is_locked tinyint(1) NOT NULL DEFAULT '0',
  CHANGE COLUMN direction_x direction_x double NOT NULL DEFAULT '0' AFTER position_z,
  CHANGE COLUMN up_x up_x double NOT NULL DEFAULT '0' AFTER direction_z,
  CHANGE COLUMN up_y up_y double NOT NULL DEFAULT '0' AFTER up_x,
  CHANGE COLUMN cargo_magazines cargo_magazines text NOT NULL AFTER cargo_items,
  CHANGE COLUMN direction_y direction_y double NOT NULL DEFAULT '0' AFTER direction_x,
  CHANGE COLUMN cargo_weapons cargo_weapons text NOT NULL AFTER cargo_magazines,
  CHANGE COLUMN position_z position_z double NOT NULL DEFAULT '0' AFTER position_y,
  CHANGE COLUMN position_x position_x double NOT NULL DEFAULT '0' AFTER is_locked,
  CHANGE COLUMN position_y position_y double NOT NULL DEFAULT '0' AFTER position_x,
  CHANGE COLUMN spawned_at spawned_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CHANGE COLUMN cargo_items cargo_items text NOT NULL AFTER up_z,
  CHANGE COLUMN cargo_container cargo_container text NOT NULL AFTER cargo_weapons,
  CHANGE COLUMN up_z up_z double NOT NULL DEFAULT '1' AFTER up_y;


DELETE p.* FROM `player` p LEFT JOIN `account` a on a.uid = p.account_uid WHERE a.uid IS NULL;

ALTER TABLE `player`
  DROP COLUMN hitpoint_head,
  DROP COLUMN died_at,
  DROP COLUMN hitpoint_body,
  DROP COLUMN hitpoint_legs,
  DROP COLUMN hitpoint_hands,
  DROP COLUMN fatigue,
  DROP COLUMN is_alive;
ALTER TABLE `player`
ADD CONSTRAINT player_ibfk_1 FOREIGN KEY(account_uid) REFERENCES `account`(uid) ON DELETE CASCADE,
  ADD COLUMN hitpoints varchar(255) NOT NULL DEFAULT '[]' AFTER bleeding_remaining,
  ADD COLUMN last_updated_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP AFTER vest_weapons,
  CHANGE COLUMN secondary_weapon_items secondary_weapon_items varchar(255) NOT NULL AFTER secondary_weapon,
  CHANGE COLUMN loaded_magazines loaded_magazines varchar(255) NOT NULL AFTER binocular,
  CHANGE COLUMN hunger hunger double unsigned NOT NULL DEFAULT '100',
  CHANGE COLUMN backpack_weapons backpack_weapons text NOT NULL AFTER backpack_magazines,
  CHANGE COLUMN vest_magazines vest_magazines text NOT NULL AFTER vest_items,
  CHANGE COLUMN vest vest varchar(64) NOT NULL AFTER uniform_weapons,
  CHANGE COLUMN handgun_weapon handgun_weapon varchar(64) NOT NULL AFTER handgun_items,
  CHANGE COLUMN goggles goggles varchar(64) NOT NULL AFTER current_weapon,
  CHANGE COLUMN current_weapon current_weapon varchar(64) NOT NULL AFTER backpack_weapons,
  CHANGE COLUMN position_x position_x double NOT NULL DEFAULT '0' AFTER direction,
  CHANGE COLUMN position_y position_y double NOT NULL DEFAULT '0' AFTER position_x,
  CHANGE COLUMN alcohol alcohol double unsigned NOT NULL DEFAULT '0' AFTER thirst,
  CHANGE COLUMN backpack backpack varchar(64) NOT NULL AFTER assigned_items,
  CHANGE COLUMN assigned_items assigned_items text NOT NULL,
  CHANGE COLUMN damage damage double unsigned NOT NULL DEFAULT '0',
  CHANGE COLUMN thirst thirst double unsigned NOT NULL DEFAULT '100' AFTER hunger,
  CHANGE COLUMN uniform uniform varchar(64) NOT NULL AFTER secondary_weapon_items,
  CHANGE COLUMN oxygen_remaining oxygen_remaining double unsigned NOT NULL DEFAULT '1' AFTER alcohol,
  CHANGE COLUMN secondary_weapon secondary_weapon varchar(64) NOT NULL AFTER primary_weapon_items,
  CHANGE COLUMN direction direction double NOT NULL DEFAULT '0',
  CHANGE COLUMN spawned_at spawned_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER position_z,
  CHANGE COLUMN vest_items vest_items text NOT NULL AFTER vest,
  CHANGE COLUMN primary_weapon primary_weapon varchar(64) NOT NULL AFTER loaded_magazines,
  CHANGE COLUMN uniform_magazines uniform_magazines text NOT NULL AFTER uniform_items,
  CHANGE COLUMN bleeding_remaining bleeding_remaining double unsigned NOT NULL DEFAULT '0' AFTER oxygen_remaining,
  CHANGE COLUMN headgear headgear varchar(64) NOT NULL AFTER handgun_weapon,
  CHANGE COLUMN uniform_items uniform_items text NOT NULL AFTER uniform,
  CHANGE COLUMN primary_weapon_items primary_weapon_items varchar(255) NOT NULL AFTER primary_weapon,
  CHANGE COLUMN binocular binocular varchar(64) NOT NULL AFTER headgear,
  CHANGE COLUMN backpack_items backpack_items text NOT NULL AFTER backpack,
  CHANGE COLUMN vest_weapons vest_weapons text NOT NULL AFTER vest_magazines,
  CHANGE COLUMN handgun_items handgun_items varchar(255) NOT NULL AFTER goggles,
  CHANGE COLUMN position_z position_z double NOT NULL DEFAULT '0' AFTER position_y,
  CHANGE COLUMN uniform_weapons uniform_weapons text NOT NULL AFTER uniform_magazines,
  CHANGE COLUMN backpack_magazines backpack_magazines text NOT NULL AFTER backpack_items;



ALTER TABLE `territory`
  DROP COLUMN last_payed_at;
ALTER TABLE `territory`
ADD CONSTRAINT territory_ibfk_2 FOREIGN KEY(flag_stolen_by_uid) REFERENCES `account`(uid) ON DELETE SET NULL,
ADD CONSTRAINT territory_ibfk_1 FOREIGN KEY(owner_uid) REFERENCES `account`(uid) ON DELETE CASCADE,
  ADD INDEX owner_uid (owner_uid),
  ADD INDEX flag_stolen_by_uid (flag_stolen_by_uid),
  ADD COLUMN last_paid_at datetime NULL DEFAULT CURRENT_TIMESTAMP AFTER created_at,
  CHANGE COLUMN created_at created_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP;


DELETE v.* FROM  `vehicle` v LEFT JOIN  `account` a ON a.uid = v.account_uid WHERE a.uid IS NULL;

ALTER TABLE `vehicle`
ADD CONSTRAINT vehicle_ibfk_1 FOREIGN KEY(account_uid) REFERENCES `account`(uid) ON DELETE CASCADE,
  ADD INDEX account_uid (account_uid),
  ADD COLUMN last_updated_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP AFTER cargo_container,
  CHANGE COLUMN spawned_at spawned_at datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CHANGE COLUMN pin_code pin_code varchar(6) NOT NULL DEFAULT '000000';


CREATE TABLE `player_history` (
  `id` int(11) UNSIGNED NOT NULL,
  `account_uid` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `died_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `position_x` double NOT NULL,
  `position_y` double NOT NULL,
  `position_z` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

UPDATE
    `construction` c
INNER JOIN  `territory` t ON ABS( t.position_x - c.position_x ) < t.radius
AND ABS( t.position_y - c.position_y ) < t.radius
SET
    c.territory_id = t.id;


UPDATE
    `container` c
INNER JOIN  `territory` t ON ABS( t.position_x - c.position_x ) < t.radius
AND ABS( t.position_y - c.position_y ) < t.radius
SET
    c.territory_id = t.id;

UPDATE territory SET flag_texture = REPLACE (flag_texture, 'exile_client', 'exile_assets') WHERE flag_texture LIKE '%exile_client%';


/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
