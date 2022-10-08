CREATE TABLE IF NOT EXISTS `employees`(
  `id` INT UNSIGNED AUTO_INCREMENT,
   `name` VARCHAR(255) NOT NULL,
    `work` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
    )ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `employees` VALUES (1, 'drunkbaby', 'eat');
INSERT INTO `employees` VALUES (2, 'dll', 'love');

CREATE TABLE IF NOT EXISTS `person`(
     `id` INT UNSIGNED AUTO_INCREMENT,
      `name` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
    )ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `employees` VALUES (1, 'drunkbaby');
INSERT INTO `employees` VALUES (2, 'dll');
INSERT INTO `employees` VALUES (2, 'yayu');