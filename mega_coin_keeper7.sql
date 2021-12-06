-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'users'
-- 
-- ---

DROP TABLE IF EXISTS `users`;
		
CREATE TABLE `users` (
  `subs_id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `msdsin` INTEGER NULL DEFAULT NULL,
  `first_name` INTEGER NULL DEFAULT NULL,
  `last_name` INTEGER NULL DEFAULT NULL,
  `joined_date` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`subs_id`)
);

-- ---
-- Table 'expenses_category'
-- 
-- ---

DROP TABLE IF EXISTS `expenses_category`;
		
CREATE TABLE `expenses_category` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `owner_user_id` INTEGER NULL DEFAULT NULL,
  `name` INTEGER NULL DEFAULT NULL,
  `created_date` INTEGER NULL DEFAULT NULL,
  `icon` INTEGER NULL DEFAULT NULL,
  `comment` INTEGER NULL DEFAULT NULL,
  `limit` INTEGER NULL DEFAULT NULL,
  `color` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'wallet_users'
-- 
-- ---

DROP TABLE IF EXISTS `wallet_users`;
		
CREATE TABLE `wallet_users` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `subs_id_users` INTEGER NULL DEFAULT NULL,
  `joined_date` INTEGER NULL DEFAULT NULL,
  `color_code` INTEGER NULL DEFAULT NULL,
  `id_group_wallet` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'expensesCategory_userExpenses'
-- 
-- ---

DROP TABLE IF EXISTS `expensesCategory_userExpenses`;
		
CREATE TABLE `expensesCategory_userExpenses` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `id_expenses_category` INTEGER NULL DEFAULT NULL,
  `id_expenses` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'app_style'
-- 
-- ---

DROP TABLE IF EXISTS `app_style`;
		
CREATE TABLE `app_style` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `navbar_color` INTEGER NULL DEFAULT NULL,
  `bar+color` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'wallet_category'
-- 
-- ---

DROP TABLE IF EXISTS `wallet_category`;
		
CREATE TABLE `wallet_category` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `amount` INTEGER NULL DEFAULT NULL,
  `is_group` INTEGER NULL DEFAULT NULL,
  `color` INTEGER NULL DEFAULT NULL,
  `currency` INTEGER NULL DEFAULT NULL,
  `add_to_total` INTEGER NULL DEFAULT NULL,
  `admin` INTEGER NULL DEFAULT NULL,
  `name` INTEGER NULL DEFAULT NULL,
  `is_copilka` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'operation_expenses'
-- 
-- ---

DROP TABLE IF EXISTS `operation_expenses`;
		
CREATE TABLE `operation_expenses` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `id_group_wallet` INTEGER NULL DEFAULT NULL,
  `subs_id_users` INTEGER NULL DEFAULT NULL,
  `sum` INTEGER NULL DEFAULT NULL,
  `id_expenses_category` INTEGER NULL DEFAULT NULL,
  `operation_date` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'full_wallet'
-- 
-- ---

DROP TABLE IF EXISTS `full_wallet`;
		
CREATE TABLE `full_wallet` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `subs_id_users` INTEGER NULL DEFAULT NULL,
  `id_group_wallet` INTEGER NULL DEFAULT NULL,
  `summ` INTEGER NULL DEFAULT NULL,
  `description` INTEGER NULL DEFAULT NULL,
  `id_source` INTEGER NULL DEFAULT NULL,
  `operation_date` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'type_'
-- 
-- ---

DROP TABLE IF EXISTS `type_`;
		
CREATE TABLE `type_` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `name` INTEGER NULL DEFAULT NULL,
  `amount` INTEGER NULL DEFAULT NULL,
  `subs_id_users` INTEGER NULL DEFAULT NULL,
  `eMoney` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'media'
-- 
-- ---

DROP TABLE IF EXISTS `media`;
		
CREATE TABLE `media` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `icon` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'source'
-- 
-- ---

DROP TABLE IF EXISTS `source`;
		
CREATE TABLE `source` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `amount` INTEGER NULL DEFAULT NULL,
  `start_date` INTEGER NULL DEFAULT NULL,
  `end_date` INTEGER NULL DEFAULT NULL,
  `subs_id_users` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'add_to_type'
-- 
-- ---

DROP TABLE IF EXISTS `add_to_type`;
		
CREATE TABLE `add_to_type` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `id_source` INTEGER NULL DEFAULT NULL,
  `summ` INTEGER NULL DEFAULT NULL,
  `subs_id_users` INTEGER NULL DEFAULT NULL,
  `id_type_` INTEGER NULL DEFAULT NULL,
  `operation_date` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `expenses_category` ADD FOREIGN KEY (owner_user_id) REFERENCES `users` (`subs_id`);
ALTER TABLE `expenses_category` ADD FOREIGN KEY (icon) REFERENCES `media` (`id`);
ALTER TABLE `wallet_users` ADD FOREIGN KEY (subs_id_users) REFERENCES `users` (`subs_id`);
ALTER TABLE `wallet_users` ADD FOREIGN KEY (id_group_wallet) REFERENCES `wallet_category` (`id`);
ALTER TABLE `wallet_category` ADD FOREIGN KEY (admin) REFERENCES `users` (`subs_id`);
ALTER TABLE `operation_expenses` ADD FOREIGN KEY (id_group_wallet) REFERENCES `wallet_category` (`id`);
ALTER TABLE `operation_expenses` ADD FOREIGN KEY (subs_id_users) REFERENCES `users` (`subs_id`);
ALTER TABLE `operation_expenses` ADD FOREIGN KEY (id_expenses_category) REFERENCES `expenses_category` (`id`);
ALTER TABLE `full_wallet` ADD FOREIGN KEY (subs_id_users) REFERENCES `users` (`subs_id`);
ALTER TABLE `full_wallet` ADD FOREIGN KEY (id_group_wallet) REFERENCES `wallet_category` (`id`);
ALTER TABLE `full_wallet` ADD FOREIGN KEY (id_source) REFERENCES `type_` (`id`);
ALTER TABLE `type_` ADD FOREIGN KEY (subs_id_users) REFERENCES `users` (`subs_id`);
ALTER TABLE `source` ADD FOREIGN KEY (subs_id_users) REFERENCES `users` (`subs_id`);
ALTER TABLE `add_to_type` ADD FOREIGN KEY (id_source) REFERENCES `source` (`id`);
ALTER TABLE `add_to_type` ADD FOREIGN KEY (subs_id_users) REFERENCES `users` (`subs_id`);
ALTER TABLE `add_to_type` ADD FOREIGN KEY (id_type_) REFERENCES `type_` (`id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `users` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `expenses_category` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `wallet_users` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `expensesCategory_userExpenses` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `app_style` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `wallet_category` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `operation_expenses` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `full_wallet` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `type_` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `media` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `source` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `add_to_type` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `users` (`subs_id`,`msdsin`,`first_name`,`last_name`,`joined_date`) VALUES
-- ('','','','','');
-- INSERT INTO `expenses_category` (`id`,`owner_user_id`,`name`,`created_date`,`icon`,`comment`,`limit`,`color`) VALUES
-- ('','','','','','','','');
-- INSERT INTO `wallet_users` (`id`,`subs_id_users`,`joined_date`,`color_code`,`id_group_wallet`) VALUES
-- ('','','','','');
-- INSERT INTO `expensesCategory_userExpenses` (`id`,`id_expenses_category`,`id_expenses`) VALUES
-- ('','','');
-- INSERT INTO `app_style` (`id`,`navbar_color`,`bar+color`) VALUES
-- ('','','');
-- INSERT INTO `wallet_category` (`id`,`amount`,`is_group`,`color`,`currency`,`add_to_total`,`admin`,`name`,`is_copilka`) VALUES
-- ('','','','','','','','','');
-- INSERT INTO `operation_expenses` (`id`,`id_group_wallet`,`subs_id_users`,`sum`,`id_expenses_category`,`operation_date`) VALUES
-- ('','','','','','');
-- INSERT INTO `full_wallet` (`id`,`subs_id_users`,`id_group_wallet`,`summ`,`description`,`id_source`,`operation_date`) VALUES
-- ('','','','','','','');
-- INSERT INTO `type_` (`id`,`name`,`amount`,`subs_id_users`,`eMoney`) VALUES
-- ('','','','','');
-- INSERT INTO `media` (`id`,`icon`) VALUES
-- ('','');
-- INSERT INTO `source` (`id`,`amount`,`start_date`,`end_date`,`subs_id_users`) VALUES
-- ('','','','','');
-- INSERT INTO `add_to_type` (`id`,`id_source`,`summ`,`subs_id_users`,`id_type_`,`operation_date`) VALUES
-- ('','','','','','');