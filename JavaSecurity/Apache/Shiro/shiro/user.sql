CREATE DATABASE IF NOT EXISTS `mybatis`;

use mybatis;

CREATE TABLE user (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  pwd VARCHAR(255),
  perms VARCHAR(255)
);
INSERT INTO `user` (`id`, `name`, `pwd`, `perms`) VALUES (1, 'drunkbaby', '123456', 'user:add');
INSERT INTO `user` (`id`, `name`, `pwd`, `perms`) VALUES (2, 'root', '123456', 'user:update');
INSERT INTO `user` (`id`, `name`, `pwd`, `perms`) VALUES (3, 'test', 'test', 'user:add');
