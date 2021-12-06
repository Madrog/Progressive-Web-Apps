-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'Clientes'
-- Personas físicas o jurídicas a las que se facturan los servicios. Tienen un NIF, dirección de facturación y formas de pago de las facturas. 
-- ---

DROP TABLE IF EXISTS `Clientes`;
		
CREATE TABLE `Clientes` (
  `Id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  PRIMARY KEY (`Id`)
) COMMENT 'Personas físicas o jurídicas a las que se facturan los servi';

-- ---
-- Table 'Pacientes'
-- Personas siempre que reciben un tratamiento. tienen que tener una historia clínica
-- ---

DROP TABLE IF EXISTS `Pacientes`;
		
CREATE TABLE `Pacientes` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `Id_Clientes` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'Personas siempre que reciben un tratamiento. tienen que tene';

-- ---
-- Table 'Servicio'
-- Es una agrupación de prestaciones en la misma factura. Esta tabla permite que un cliente pueda elegir que sus prestaciones se facturen en una única factura o en varias.
-- ---

DROP TABLE IF EXISTS `Servicio`;
		
CREATE TABLE `Servicio` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `Id_Clientes` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'Es una agrupación de prestaciones en la misma factura. Esta ';

-- ---
-- Table 'Prestaciones'
-- Una prestación es el servicio que le presta un profesional a un paciente. Tiene información de lugar, duración, frecuencia (para generar automáticamente las sesiones), coste, precio, forma de contar las sesiones (cuota mensual o por sesión), información de copago. La prestación se convertirá en una línea de factura en la facturación con el número de sesiones realizadas como cantidad.
-- ---

DROP TABLE IF EXISTS `Prestaciones`;
		
CREATE TABLE `Prestaciones` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `id_Servicio` INTEGER NULL DEFAULT NULL,
  `id_Pacientes` INTEGER NULL DEFAULT NULL,
  `id_Profesional` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'Una prestación es el servicio que le presta un profesional a';

-- ---
-- Table 'Profesional'
-- El profesional, externo o interno que presta un servicio
-- ---

DROP TABLE IF EXISTS `Profesional`;
		
CREATE TABLE `Profesional` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'El profesional, externo o interno que presta un servicio';

-- ---
-- Table 'Sesiones'
-- REalizadas por un profesional a un paciente, según los datos definidos en prestación. Tienen un resultado de impartida, cancelada (por el paciente por el profesional ocn tiempo sin tiempo o null
-- ---

DROP TABLE IF EXISTS `Sesiones`;
		
CREATE TABLE `Sesiones` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `id_Prestaciones` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'REalizadas por un profesional a un paciente, según los datos';

-- ---
-- Table 'FActuras'
-- 
-- ---

DROP TABLE IF EXISTS `FActuras`;
		
CREATE TABLE `FActuras` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `Id_Clientes` INTEGER NULL DEFAULT NULL,
  `id_Trabajo Realizado` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'DEtalle de facturas'
-- 
-- ---

DROP TABLE IF EXISTS `DEtalle de facturas`;
		
CREATE TABLE `DEtalle de facturas` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `id_FActuras` INTEGER NULL DEFAULT NULL,
  `id_Trabajo Realizado` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'Trabajo Realizado'
-- Es una tabla virtual, una especie de consulta para actualuizar datos. Sirve para contar el número de sesiones realizadas por prestación y periodo facturable. La prestación pasa a ser una línea de factura. La cantidad de la línea viene determinada por el número de sesiones contadas. El concepto es un campo de prestaciónes que se actualiza con el periodo facturable. El precio y la forma de contar es un campo de prestación. Lo que prestación es a la tabla detalle de factura, servicio lo es a la tabla factura. 
-- ---

DROP TABLE IF EXISTS `Trabajo Realizado`;
		
CREATE TABLE `Trabajo Realizado` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  `id_Prestaciones` INTEGER NULL DEFAULT NULL,
  `id_Sesiones` INTEGER NULL DEFAULT NULL,
  `id_Servicio` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) COMMENT 'Es una tabla virtual, una especie de consulta para actualuiz';

-- ---
-- Table 'Contabilidad'
-- 
-- ---

DROP TABLE IF EXISTS `Contabilidad`;
		
CREATE TABLE `Contabilidad` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'Control de Pagos'
-- 
-- ---

DROP TABLE IF EXISTS `Control de Pagos`;
		
CREATE TABLE `Control de Pagos` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'Pagos a profesional'
-- 
-- ---

DROP TABLE IF EXISTS `Pagos a profesional`;
		
CREATE TABLE `Pagos a profesional` (
  `id` INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `Pacientes` ADD FOREIGN KEY (Id_Clientes) REFERENCES `Clientes` (`Id`);
ALTER TABLE `Servicio` ADD FOREIGN KEY (Id_Clientes) REFERENCES `Clientes` (`Id`);
ALTER TABLE `Prestaciones` ADD FOREIGN KEY (id_Servicio) REFERENCES `Servicio` (`id`);
ALTER TABLE `Prestaciones` ADD FOREIGN KEY (id_Pacientes) REFERENCES `Pacientes` (`id`);
ALTER TABLE `Prestaciones` ADD FOREIGN KEY (id_Profesional) REFERENCES `Profesional` (`id`);
ALTER TABLE `Sesiones` ADD FOREIGN KEY (id_Prestaciones) REFERENCES `Prestaciones` (`id`);
ALTER TABLE `FActuras` ADD FOREIGN KEY (Id_Clientes) REFERENCES `Clientes` (`Id`);
ALTER TABLE `FActuras` ADD FOREIGN KEY (id_Trabajo Realizado) REFERENCES `Trabajo Realizado` (`id`);
ALTER TABLE `DEtalle de facturas` ADD FOREIGN KEY (id_FActuras) REFERENCES `FActuras` (`id`);
ALTER TABLE `DEtalle de facturas` ADD FOREIGN KEY (id_Trabajo Realizado) REFERENCES `Trabajo Realizado` (`id`);
ALTER TABLE `Trabajo Realizado` ADD FOREIGN KEY (id_Prestaciones) REFERENCES `Prestaciones` (`id`);
ALTER TABLE `Trabajo Realizado` ADD FOREIGN KEY (id_Sesiones) REFERENCES `Sesiones` (`id`);
ALTER TABLE `Trabajo Realizado` ADD FOREIGN KEY (id_Servicio) REFERENCES `Servicio` (`id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `Clientes` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Pacientes` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Servicio` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Prestaciones` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Profesional` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Sesiones` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `FActuras` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `DEtalle de facturas` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Trabajo Realizado` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Contabilidad` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Control de Pagos` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Pagos a profesional` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `Clientes` (`Id`) VALUES
-- ('');
-- INSERT INTO `Pacientes` (`id`,`Id_Clientes`) VALUES
-- ('','');
-- INSERT INTO `Servicio` (`id`,`Id_Clientes`) VALUES
-- ('','');
-- INSERT INTO `Prestaciones` (`id`,`id_Servicio`,`id_Pacientes`,`id_Profesional`) VALUES
-- ('','','','');
-- INSERT INTO `Profesional` (`id`) VALUES
-- ('');
-- INSERT INTO `Sesiones` (`id`,`id_Prestaciones`) VALUES
-- ('','');
-- INSERT INTO `FActuras` (`id`,`Id_Clientes`,`id_Trabajo Realizado`) VALUES
-- ('','','');
-- INSERT INTO `DEtalle de facturas` (`id`,`id_FActuras`,`id_Trabajo Realizado`) VALUES
-- ('','','');
-- INSERT INTO `Trabajo Realizado` (`id`,`id_Prestaciones`,`id_Sesiones`,`id_Servicio`) VALUES
-- ('','','','');
-- INSERT INTO `Contabilidad` (`id`) VALUES
-- ('');
-- INSERT INTO `Control de Pagos` (`id`) VALUES
-- ('');
-- INSERT INTO `Pagos a profesional` (`id`) VALUES
-- ('');