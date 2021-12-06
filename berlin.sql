-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'adresses'
-- 
-- ---

DROP TABLE IF EXISTS `adresses`;
		
CREATE TABLE `adresses` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `street` INTEGER NULL DEFAULT NULL,
  `house` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'prod_companies'
-- 
-- ---

DROP TABLE IF EXISTS `prod_companies`;
		
CREATE TABLE `prod_companies` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `id_adresses` INTEGER NULL DEFAULT NULL,
  `id_adresses` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'managers'
-- 
-- ---

DROP TABLE IF EXISTS `managers`;
		
CREATE TABLE `managers` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `name` INTEGER NULL DEFAULT NULL,
  `last_name` INTEGER NULL DEFAULT NULL,
  `middle_name` INTEGER NULL DEFAULT NULL,
  `start_date` INTEGER NULL DEFAULT NULL,
  `end_date` INTEGER NULL DEFAULT NULL,
  `company_id` INTEGER NULL DEFAULT NULL,
  `id_prod_companies` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'accounts'
-- 
-- ---

DROP TABLE IF EXISTS `accounts`;
		
CREATE TABLE `accounts` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `acc_num` INTEGER NULL DEFAULT NULL,
  `id_companies` INTEGER NULL DEFAULT NULL,
  `id_prod_companies` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'sales'
-- 
-- ---

DROP TABLE IF EXISTS `sales`;
		
CREATE TABLE `sales` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `sale_date` INTEGER NULL DEFAULT NULL,
  `id_companies` INTEGER NULL DEFAULT NULL,
  `id_prod_companies` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'products'
-- 
-- ---

DROP TABLE IF EXISTS `products`;
		
CREATE TABLE `products` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `name` INTEGER NULL DEFAULT NULL,
  `id_companies` INTEGER NULL DEFAULT NULL,
  `id_categories` INTEGER NULL DEFAULT NULL,
  `id_units` INTEGER NULL DEFAULT NULL,
  `id_prod_companies` INTEGER NULL DEFAULT NULL,
  `id_units` INTEGER NULL DEFAULT NULL,
  `id_categories` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'units'
-- 
-- ---

DROP TABLE IF EXISTS `units`;
		
CREATE TABLE `units` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `unit` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'prices'
-- 
-- ---

DROP TABLE IF EXISTS `prices`;
		
CREATE TABLE `prices` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `price` INTEGER NULL DEFAULT NULL,
  `start_date` INTEGER NULL DEFAULT NULL,
  `end_date` INTEGER NULL DEFAULT NULL,
  `product_id` INTEGER NULL DEFAULT NULL,
  `id_products` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'categories'
-- 
-- ---

DROP TABLE IF EXISTS `categories`;
		
CREATE TABLE `categories` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `name` INTEGER NULL DEFAULT NULL,
  `is_active` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'prod_sales'
-- 
-- ---

DROP TABLE IF EXISTS `prod_sales`;
		
CREATE TABLE `prod_sales` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `id_sales` INTEGER NULL DEFAULT NULL,
  `id_products` INTEGER NULL DEFAULT NULL,
  `amount` INTEGER NULL DEFAULT NULL,
  `id_sales` INTEGER NULL DEFAULT NULL,
  `id_products` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `prod_companies` ADD FOREIGN KEY (id_adresses) REFERENCES `adresses` (`id`);
ALTER TABLE `managers` ADD FOREIGN KEY (id_prod_companies) REFERENCES `prod_companies` (`id`);
ALTER TABLE `accounts` ADD FOREIGN KEY (id_prod_companies) REFERENCES `prod_companies` (`id`);
ALTER TABLE `sales` ADD FOREIGN KEY (id_prod_companies) REFERENCES `prod_companies` (`id`);
ALTER TABLE `products` ADD FOREIGN KEY (id_categories) REFERENCES `categories` (`id`);
ALTER TABLE `products` ADD FOREIGN KEY (id_units) REFERENCES `units` (`id`);
ALTER TABLE `products` ADD FOREIGN KEY (id_prod_companies) REFERENCES `prod_companies` (`id`);
ALTER TABLE `prices` ADD FOREIGN KEY (id_products) REFERENCES `products` (`id`);
ALTER TABLE `prod_sales` ADD FOREIGN KEY (id_sales) REFERENCES `sales` (`id`);
ALTER TABLE `prod_sales` ADD FOREIGN KEY (id_products) REFERENCES `products` (`id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `adresses` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `prod_companies` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `managers` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `accounts` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `sales` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `products` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `units` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `prices` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `categories` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `prod_sales` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `adresses` (`id`,`street`,`house`) VALUES
-- ('','','');
-- INSERT INTO `prod_companies` (`id`,`id_adresses`,`id_adresses`) VALUES
-- ('','','');
-- INSERT INTO `managers` (`id`,`name`,`last_name`,`middle_name`,`start_date`,`end_date`,`company_id`,`id_prod_companies`) VALUES
-- ('','','','','','','','');
-- INSERT INTO `accounts` (`id`,`acc_num`,`id_companies`,`id_prod_companies`) VALUES
-- ('','','','');
-- INSERT INTO `sales` (`id`,`sale_date`,`id_companies`,`id_prod_companies`) VALUES
-- ('','','','');
-- INSERT INTO `products` (`id`,`name`,`id_companies`,`id_categories`,`id_units`,`id_prod_companies`,`id_units`,`id_categories`) VALUES
-- ('','','','','','','','');
-- INSERT INTO `units` (`id`,`unit`) VALUES
-- ('','');
-- INSERT INTO `prices` (`id`,`price`,`start_date`,`end_date`,`product_id`,`id_products`) VALUES
-- ('','','','','','');
-- INSERT INTO `categories` (`id`,`name`,`is_active`) VALUES
-- ('','','');
-- INSERT INTO `prod_sales` (`id`,`id_sales`,`id_products`,`amount`,`id_sales`,`id_products`) VALUES
-- ('','','','','','');