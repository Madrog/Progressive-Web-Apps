-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'MarketCombinations'
-- Описание таблицы
-- ---

DROP TABLE IF EXISTS `MarketCombinations`;
		
CREATE TABLE `MarketCombinations` (
  `Id` INTEGER NULL DEFAULT NULL,
  `EventTypeId` INTEGER NOT NULL AUTO_INCREMENT DEFAULT NULL COMMENT 'Порядковый номер',
  `MarketType` INTEGER NOT NULL DEFAULT NULL,
  `MinValue` INTEGER NULL DEFAULT NULL,
  `MaxValue` INTEGER NULL DEFAULT NULL,
  `Combinations` INTEGER NULL DEFAULT NULL,
  `PersistedVersion` INTEGER NULL DEFAULT NULL,
  `CreatedUtc` INTEGER NULL DEFAULT NULL,
  `Created` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`EventTypeId`)
) COMMENT 'Описание таблицы';

-- ---
-- Table 'Markets'
-- 
-- ---

DROP TABLE IF EXISTS `Markets`;
		
CREATE TABLE `Markets` (
  `Id` INTEGER NOT NULL DEFAULT NULL,
  `GlobalMarketId` INTEGER NULL DEFAULT NULL,
  `EventId` INTEGER NULL DEFAULT NULL,
  `Name` INTEGER NULL DEFAULT NULL,
  `Active` INTEGER NULL DEFAULT NULL,
  `Parameter` INTEGER NULL DEFAULT NULL,
  `UseForecast` INTEGER NULL DEFAULT NULL,
  `UseForecaster` INTEGER NULL DEFAULT NULL,
  `IsFull` INTEGER NULL DEFAULT NULL,
  `MarketType` INTEGER NOT NULL AUTO_INCREMENT DEFAULT NULL,
  `PersistedVersion` INTEGER NULL DEFAULT NULL,
  `CreatedUtc` INTEGER NULL DEFAULT NULL,
  `Created` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`MarketType`)
);

-- ---
-- Table '[BaltBetM].[dbo].[Events]'
-- 
-- ---

DROP TABLE IF EXISTS `[BaltBetM].[dbo].[Events]`;
		
CREATE TABLE `[BaltBetM].[dbo].[Events]` (
  `LineID` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `EventTypeId` INTEGER NOT NULL DEFAULT NULL COMMENT 'Порядковый номер',
  PRIMARY KEY (`LineID`)
);

-- ---
-- Table 'Events'
-- 
-- ---

DROP TABLE IF EXISTS `Events`;
		
CREATE TABLE `Events` (
  `Id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `Name` INTEGER NULL DEFAULT NULL,
  `Description` INTEGER NULL DEFAULT NULL,
  `Active` INTEGER NULL DEFAULT NULL,
  `StartTime` INTEGER NULL DEFAULT NULL,
  `SportTypeId` INTEGER NULL DEFAULT NULL,
  `EventTypeId` INTEGER NOT NULL DEFAULT NULL COMMENT 'Порядковый номер',
  `WebLink` INTEGER NULL DEFAULT NULL,
  `PersistedVersion` INTEGER NULL DEFAULT NULL,
  `CreatedUtc` INTEGER NULL DEFAULT NULL,
  `Created` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`Id`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `MarketCombinations` ADD FOREIGN KEY (MarketType) REFERENCES `Markets` (`MarketType`);
ALTER TABLE `[BaltBetM].[dbo].[Events]` ADD FOREIGN KEY (EventTypeId) REFERENCES `MarketCombinations` (`EventTypeId`);
ALTER TABLE `Events` ADD FOREIGN KEY (EventTypeId) REFERENCES `MarketCombinations` (`EventTypeId`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `MarketCombinations` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Markets` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `[BaltBetM].[dbo].[Events]` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Events` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `MarketCombinations` (`Id`,`EventTypeId`,`MarketType`,`MinValue`,`MaxValue`,`Combinations`,`PersistedVersion`,`CreatedUtc`,`Created`) VALUES
-- ('','','','','','','','','');
-- INSERT INTO `Markets` (`Id`,`GlobalMarketId`,`EventId`,`Name`,`Active`,`Parameter`,`UseForecast`,`UseForecaster`,`IsFull`,`MarketType`,`PersistedVersion`,`CreatedUtc`,`Created`) VALUES
-- ('','','','','','','','','','','','','');
-- INSERT INTO `[BaltBetM].[dbo].[Events]` (`LineID`,`EventTypeId`) VALUES
-- ('','');
-- INSERT INTO `Events` (`Id`,`Name`,`Description`,`Active`,`StartTime`,`SportTypeId`,`EventTypeId`,`WebLink`,`PersistedVersion`,`CreatedUtc`,`Created`) VALUES
-- ('','','','','','','','','','','');