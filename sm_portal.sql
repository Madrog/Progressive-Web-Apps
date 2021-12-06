-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'items'
-- 
-- ---

DROP TABLE IF EXISTS `items`;
		
CREATE TABLE `items` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `name` VARCHAR NULL DEFAULT NULL,
  `type` INT NULL DEFAULT NULL COMMENT '0 - part, 1 - product, 2 - service, 3 - drop shipped',
  `parents[]` bit NULL DEFAULT NULL,
  `archived` BOOL NULL DEFAULT NULL,
  `supplier_cost` VARCHAR NULL DEFAULT NULL,
  `stock_cost` INT NULL DEFAULT NULL,
  `costing_from` link NULL DEFAULT NULL,
  `value` INT NULL DEFAULT NULL COMMENT 'rrp',
  `costLastUpdated` DATE NULL DEFAULT NULL,
  `qtyAvailable` INT NULL DEFAULT NULL,
  `qtyOnHand` INT NULL DEFAULT NULL,
  `qtyAllocated` INT NULL DEFAULT NULL,
  `qtyOnOrder` INT NULL DEFAULT NULL,
  `qtyOnOrderAvailable` INT NULL DEFAULT NULL,
  `moq` INT NULL DEFAULT NULL,
  `stockAlert` INT NULL DEFAULT NULL,
  `size{}` bit({width,height,depth}) NULL DEFAULT NULL,
  `suppliers[]` link NULL DEFAULT NULL,
  `tags[]` bit NULL DEFAULT NULL,
  `sku` VARCHAR NULL DEFAULT NULL,
  `cost_account` VARCHAR NULL DEFAULT NULL,
  `sale_account` VARCHAR NULL DEFAULT NULL,
  `stock_account` VARCHAR NULL DEFAULT NULL,
  `notes` VARCHAR NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'assemblies'
-- 
-- ---

DROP TABLE IF EXISTS `assemblies`;
		
CREATE TABLE `assemblies` (
  `id` INTEGER NULL DEFAULT NULL,
  `name` VARCHAR NULL DEFAULT NULL,
  `items[]` bit NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'templates'
-- 
-- ---

DROP TABLE IF EXISTS `templates`;
		
CREATE TABLE `templates` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `name` VARCHAR NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'suppliers'
-- 
-- ---

DROP TABLE IF EXISTS `suppliers`;
		
CREATE TABLE `suppliers` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `new field` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'costings'
-- 
-- ---

DROP TABLE IF EXISTS `costings`;
		
CREATE TABLE `costings` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `name` VARCHAR NULL DEFAULT NULL,
  `notes` VARCHAR NULL DEFAULT NULL,
  `items[]` bit NULL DEFAULT NULL,
  `groups[]` bit NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'Bays'
-- stock holding areas
-- ---

DROP TABLE IF EXISTS `Bays`;
		
CREATE TABLE `Bays` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `location` INTEGER NULL DEFAULT NULL,
  `bay id` VARCHAR NULL DEFAULT NULL,
  `items[]` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'stock holding areas';

-- ---
-- Table 'lines[]'
-- 
-- ---

DROP TABLE IF EXISTS `lines[]`;
		
CREATE TABLE `lines[]` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `item` link NULL DEFAULT NULL,
  `qty` INTEGER NULL DEFAULT NULL,
  `note` VARCHAR NULL DEFAULT NULL,
  `user` VARCHAR NULL DEFAULT NULL,
  `date` TIMESTAMP NULL DEFAULT NULL,
  `batch` INTEGER NULL DEFAULT NULL,
  `bay` link NULL DEFAULT NULL,
  `bayFrom` link NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'locations'
-- 
-- ---

DROP TABLE IF EXISTS `locations`;
		
CREATE TABLE `locations` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `name` VARCHAR NULL DEFAULT NULL,
  `prefix` VARCHAR NULL DEFAULT NULL,
  `layout[]` VARCHAR NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'Snapshot'
-- 
-- ---

DROP TABLE IF EXISTS `Snapshot`;
		
CREATE TABLE `Snapshot` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `date` DATE NULL DEFAULT NULL,
  `part` INTEGER NULL DEFAULT NULL,
  `qty` INTEGER NULL DEFAULT NULL,
  `new field` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'movements'
-- 
-- ---

DROP TABLE IF EXISTS `movements`;
		
CREATE TABLE `movements` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `type` INT NULL DEFAULT NULL COMMENT 'sale, order, stocktake',
  `lines[]` bit NULL DEFAULT NULL,
  `notes` VARCHAR NULL DEFAULT NULL,
  `location` link NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'orders'
-- 
-- ---

DROP TABLE IF EXISTS `orders`;
		
CREATE TABLE `orders` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'contacts'
-- customers & suppliers - synced with xero
-- ---

DROP TABLE IF EXISTS `contacts`;
		
CREATE TABLE `contacts` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `name` VARCHAR NULL DEFAULT NULL,
  `Firstname` VARCHAR NULL DEFAULT NULL,
  `Lastname` VARCHAR NULL DEFAULT NULL,
  `Email` VARCHAR NULL DEFAULT NULL,
  `Addresses[]` bit NULL DEFAULT NULL,
  `Phones[]` bit NULL DEFAULT NULL,
  `Updated` INT NULL DEFAULT NULL,
  `isSupplier` INT NULL DEFAULT NULL,
  `isCustomer` INT NULL DEFAULT NULL,
  `password` VARCHAR NULL DEFAULT NULL,
  `tid` VARCHAR NULL DEFAULT NULL,
  `joined` INT NULL DEFAULT NULL,
  `lastOnline` INT NULL DEFAULT NULL,
  `preferences{}` bit NULL DEFAULT NULL,
  `referrer` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'customers & suppliers - synced with xero';

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `items` ADD FOREIGN KEY (parents[]) REFERENCES `items` (`id`);
ALTER TABLE `items` ADD FOREIGN KEY (costing_from) REFERENCES `costings` (`id`);
ALTER TABLE `items` ADD FOREIGN KEY (suppliers[]) REFERENCES `suppliers` (`id`);
ALTER TABLE `Bays` ADD FOREIGN KEY (location) REFERENCES `locations` (`id`);
ALTER TABLE `lines[]` ADD FOREIGN KEY (item) REFERENCES `items` (`id`);
ALTER TABLE `lines[]` ADD FOREIGN KEY (bay) REFERENCES `Bays` (`id`);
ALTER TABLE `lines[]` ADD FOREIGN KEY (bayFrom) REFERENCES `Bays` (`id`);
ALTER TABLE `movements` ADD FOREIGN KEY (lines[]) REFERENCES `lines[]` (`id`);
ALTER TABLE `movements` ADD FOREIGN KEY (location) REFERENCES `locations` (`id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `items` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `assemblies` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `templates` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `suppliers` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `costings` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Bays` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `lines[]` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `locations` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Snapshot` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `movements` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `orders` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `contacts` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `items` (`id`,`name`,`type`,`parents[]`,`archived`,`supplier_cost`,`stock_cost`,`costing_from`,`value`,`costLastUpdated`,`qtyAvailable`,`qtyOnHand`,`qtyAllocated`,`qtyOnOrder`,`qtyOnOrderAvailable`,`moq`,`stockAlert`,`size{}`,`suppliers[]`,`tags[]`,`sku`,`cost_account`,`sale_account`,`stock_account`,`notes`) VALUES
-- ('','','','','','','','','','','','','','','','','','','','','','','','','');
-- INSERT INTO `assemblies` (`id`,`name`,`items[]`) VALUES
-- ('','','');
-- INSERT INTO `templates` (`id`,`name`) VALUES
-- ('','');
-- INSERT INTO `suppliers` (`id`,`new field`) VALUES
-- ('','');
-- INSERT INTO `costings` (`id`,`name`,`notes`,`items[]`,`groups[]`) VALUES
-- ('','','','','');
-- INSERT INTO `Bays` (`id`,`location`,`bay id`,`items[]`) VALUES
-- ('','','','');
-- INSERT INTO `lines[]` (`id`,`item`,`qty`,`note`,`user`,`date`,`batch`,`bay`,`bayFrom`) VALUES
-- ('','','','','','','','','');
-- INSERT INTO `locations` (`id`,`name`,`prefix`,`layout[]`) VALUES
-- ('','','','');
-- INSERT INTO `Snapshot` (`id`,`date`,`part`,`qty`,`new field`) VALUES
-- ('','','','','');
-- INSERT INTO `movements` (`id`,`type`,`lines[]`,`notes`,`location`) VALUES
-- ('','','','','');
-- INSERT INTO `orders` (`id`) VALUES
-- ('');
-- INSERT INTO `contacts` (`id`,`name`,`Firstname`,`Lastname`,`Email`,`Addresses[]`,`Phones[]`,`Updated`,`isSupplier`,`isCustomer`,`password`,`tid`,`joined`,`lastOnline`,`preferences{}`,`referrer`) VALUES
-- ('','','','','','','','','','','','','','','','');