/*
 Navicat Premium Data Transfer

 Source Server         : ketnoimysql
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : dkmh

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 10/11/2021 14:39:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for dkmh
-- ----------------------------
DROP TABLE IF EXISTS `dkmh`;
CREATE TABLE `dkmh`  (
  `users_id` int NOT NULL,
  `subject_id` int NOT NULL,
  PRIMARY KEY (`users_id`, `subject_id`) USING BTREE,
  INDEX `FKlwefj8rpoiedof7k5oh3393ao`(`subject_id`) USING BTREE,
  CONSTRAINT `FK9ufm9ox1x9ojcsopq3b2uw1fh` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKlwefj8rpoiedof7k5oh3393ao` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dkmh
-- ----------------------------
INSERT INTO `dkmh` VALUES (2, 1);
INSERT INTO `dkmh` VALUES (2, 3);
INSERT INTO `dkmh` VALUES (2, 4);
INSERT INTO `dkmh` VALUES (2, 6);
INSERT INTO `dkmh` VALUES (2, 7);

-- ----------------------------
-- Table structure for persistent_logins
-- ----------------------------
DROP TABLE IF EXISTS `persistent_logins`;
CREATE TABLE `persistent_logins`  (
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `series` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `last_used` timestamp NOT NULL,
  PRIMARY KEY (`series`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of persistent_logins
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_ofx66keruapi6vyqpv6f2or37`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'abc', 'ROLE_ADMIN');
INSERT INTO `roles` VALUES (2, 'abc', 'ROLE_USER');

-- ----------------------------
-- Table structure for subjects
-- ----------------------------
DROP TABLE IF EXISTS `subjects`;
CREATE TABLE `subjects`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_subject` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name_subject` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `total_credits` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of subjects
-- ----------------------------
INSERT INTO `subjects` VALUES (1, 'Đại cương', 'Vật lí 1', 3);
INSERT INTO `subjects` VALUES (2, 'Đại cương', 'Toán 1', 3);
INSERT INTO `subjects` VALUES (3, 'Đại cương ', 'Toán 2', 3);
INSERT INTO `subjects` VALUES (4, 'Đại cương', 'Toán 3', 3);
INSERT INTO `subjects` VALUES (5, 'Chuyên ngành', 'Nhập môn lập trình ', 3);
INSERT INTO `subjects` VALUES (6, 'Chuyên ngành', 'Kỹ thuật lập trình', 3);
INSERT INTO `subjects` VALUES (7, 'Chuyên ngành ', 'Nhập môn ngành CNTT', 3);
INSERT INTO `subjects` VALUES (8, 'Chuyên ngành', 'Cơ sở dữ liệu ', 3);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `class` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `username` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `enabled` bit(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'abc', 'Baodeptrai', '$2a$10$PrI5Gk9L.tSZiW9FXhTS8O8Mz9E97k2FZbFvGFFaSsiTUIl.TCrFu', 'dbadmin1', b'1');
INSERT INTO `users` VALUES (2, 'abcd', 'Baodeptrai1', '$2a$10$PrI5Gk9L.tSZiW9FXhTS8O8Mz9E97k2FZbFvGFFaSsiTUIl.TCrFu', 'dbuser1', b'1');

-- ----------------------------
-- Table structure for users_roles
-- ----------------------------
DROP TABLE IF EXISTS `users_roles`;
CREATE TABLE `users_roles`  (
  `users_id` int NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`users_id`, `role_id`) USING BTREE,
  INDEX `FKj6m8fwv7oqv74fcehir1a9ffy`(`role_id`) USING BTREE,
  CONSTRAINT `FKj6m8fwv7oqv74fcehir1a9ffy` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKml90kef4w2jy7oxyqv742tsfc` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_roles
-- ----------------------------
INSERT INTO `users_roles` VALUES (1, 1);
INSERT INTO `users_roles` VALUES (1, 2);
INSERT INTO `users_roles` VALUES (2, 2);

SET FOREIGN_KEY_CHECKS = 1;
