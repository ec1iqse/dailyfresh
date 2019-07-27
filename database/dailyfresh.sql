/*
 Navicat Premium Data Transfer

 Source Server         : MairaDB
 Source Server Type    : MariaDB
 Source Server Version : 100315
 Source Host           : localhost:3306
 Source Schema         : dailyfresh

 Target Server Type    : MariaDB
 Target Server Version : 100315
 File Encoding         : 65001

 Date: 28/07/2019 01:51:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add 用户', 6, 'add_user');
INSERT INTO `auth_permission` VALUES (22, 'Can change 用户', 6, 'change_user');
INSERT INTO `auth_permission` VALUES (23, 'Can delete 用户', 6, 'delete_user');
INSERT INTO `auth_permission` VALUES (24, 'Can view 用户', 6, 'view_user');
INSERT INTO `auth_permission` VALUES (25, 'Can add 地址', 7, 'add_address');
INSERT INTO `auth_permission` VALUES (26, 'Can change 地址', 7, 'change_address');
INSERT INTO `auth_permission` VALUES (27, 'Can delete 地址', 7, 'delete_address');
INSERT INTO `auth_permission` VALUES (28, 'Can view 地址', 7, 'view_address');
INSERT INTO `auth_permission` VALUES (29, 'Can add 商品SPU', 8, 'add_goods');
INSERT INTO `auth_permission` VALUES (30, 'Can change 商品SPU', 8, 'change_goods');
INSERT INTO `auth_permission` VALUES (31, 'Can delete 商品SPU', 8, 'delete_goods');
INSERT INTO `auth_permission` VALUES (32, 'Can view 商品SPU', 8, 'view_goods');
INSERT INTO `auth_permission` VALUES (33, 'Can add 商品', 9, 'add_goodssku');
INSERT INTO `auth_permission` VALUES (34, 'Can change 商品', 9, 'change_goodssku');
INSERT INTO `auth_permission` VALUES (35, 'Can delete 商品', 9, 'delete_goodssku');
INSERT INTO `auth_permission` VALUES (36, 'Can view 商品', 9, 'view_goodssku');
INSERT INTO `auth_permission` VALUES (37, 'Can add 商品种类', 10, 'add_goodstype');
INSERT INTO `auth_permission` VALUES (38, 'Can change 商品种类', 10, 'change_goodstype');
INSERT INTO `auth_permission` VALUES (39, 'Can delete 商品种类', 10, 'delete_goodstype');
INSERT INTO `auth_permission` VALUES (40, 'Can view 商品种类', 10, 'view_goodstype');
INSERT INTO `auth_permission` VALUES (41, 'Can add 主页促销活动', 11, 'add_indexpromotionbanner');
INSERT INTO `auth_permission` VALUES (42, 'Can change 主页促销活动', 11, 'change_indexpromotionbanner');
INSERT INTO `auth_permission` VALUES (43, 'Can delete 主页促销活动', 11, 'delete_indexpromotionbanner');
INSERT INTO `auth_permission` VALUES (44, 'Can view 主页促销活动', 11, 'view_indexpromotionbanner');
INSERT INTO `auth_permission` VALUES (45, 'Can add 主页分类展示商品', 12, 'add_indextypegoodsbanner');
INSERT INTO `auth_permission` VALUES (46, 'Can change 主页分类展示商品', 12, 'change_indextypegoodsbanner');
INSERT INTO `auth_permission` VALUES (47, 'Can delete 主页分类展示商品', 12, 'delete_indextypegoodsbanner');
INSERT INTO `auth_permission` VALUES (48, 'Can view 主页分类展示商品', 12, 'view_indextypegoodsbanner');
INSERT INTO `auth_permission` VALUES (49, 'Can add 首页轮播商品', 13, 'add_indexgoodsbanner');
INSERT INTO `auth_permission` VALUES (50, 'Can change 首页轮播商品', 13, 'change_indexgoodsbanner');
INSERT INTO `auth_permission` VALUES (51, 'Can delete 首页轮播商品', 13, 'delete_indexgoodsbanner');
INSERT INTO `auth_permission` VALUES (52, 'Can view 首页轮播商品', 13, 'view_indexgoodsbanner');
INSERT INTO `auth_permission` VALUES (53, 'Can add 商品图片', 14, 'add_goodsimage');
INSERT INTO `auth_permission` VALUES (54, 'Can change 商品图片', 14, 'change_goodsimage');
INSERT INTO `auth_permission` VALUES (55, 'Can delete 商品图片', 14, 'delete_goodsimage');
INSERT INTO `auth_permission` VALUES (56, 'Can view 商品图片', 14, 'view_goodsimage');
INSERT INTO `auth_permission` VALUES (57, 'Can add 订单商品', 15, 'add_ordergoods');
INSERT INTO `auth_permission` VALUES (58, 'Can change 订单商品', 15, 'change_ordergoods');
INSERT INTO `auth_permission` VALUES (59, 'Can delete 订单商品', 15, 'delete_ordergoods');
INSERT INTO `auth_permission` VALUES (60, 'Can view 订单商品', 15, 'view_ordergoods');
INSERT INTO `auth_permission` VALUES (61, 'Can add 订单', 16, 'add_orderinfo');
INSERT INTO `auth_permission` VALUES (62, 'Can change 订单', 16, 'change_orderinfo');
INSERT INTO `auth_permission` VALUES (63, 'Can delete 订单', 16, 'delete_orderinfo');
INSERT INTO `auth_permission` VALUES (64, 'Can view 订单', 16, 'view_orderinfo');

-- ----------------------------
-- Table structure for df_address
-- ----------------------------
DROP TABLE IF EXISTS `df_address`;
CREATE TABLE `df_address`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `receiver` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `addr` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `zip_code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `df_address_user_id_5e6a5c8a_fk_df_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `df_address_user_id_5e6a5c8a_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_address
-- ----------------------------
INSERT INTO `df_address` VALUES (3, '2019-06-16 04:11:52.225322', '2019-06-16 04:11:52.225322', 0, '张三', '北京市昌平区', '100000', '13333333333', 1, 24);
INSERT INTO `df_address` VALUES (4, '2019-06-16 04:14:36.583992', '2019-06-16 04:14:36.584994', 0, '李四', '北京市西三旗', '100000', '13888888888', 0, 24);

-- ----------------------------
-- Table structure for df_good_type
-- ----------------------------
DROP TABLE IF EXISTS `df_good_type`;
CREATE TABLE `df_good_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `logo` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_good_type
-- ----------------------------
INSERT INTO `df_good_type` VALUES (4, '2019-07-26 16:19:11.060852', '2019-07-26 16:19:11.060852', 0, '猪牛羊肉', 'meet', 'group1/M00/00/00/wKjziF07J_-ADAPSAAAy1TlGVKQ9233614');

-- ----------------------------
-- Table structure for df_goods
-- ----------------------------
DROP TABLE IF EXISTS `df_goods`;
CREATE TABLE `df_goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for df_goods_image
-- ----------------------------
DROP TABLE IF EXISTS `df_goods_image`;
CREATE TABLE `df_goods_image`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `df_goods_image_sku_id_f8dc96ea_fk_df_goods_sku_id`(`sku_id`) USING BTREE,
  CONSTRAINT `df_goods_image_sku_id_f8dc96ea_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for df_goods_sku
-- ----------------------------
DROP TABLE IF EXISTS `df_goods_sku`;
CREATE TABLE `df_goods_sku`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `desc` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `unite` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `stock` int(11) NOT NULL,
  `sales` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `df_goods_sku_goods_id_31622280_fk_df_goods_id`(`goods_id`) USING BTREE,
  INDEX `df_goods_sku_type_id_576de3b4_fk_df_good_type_id`(`type_id`) USING BTREE,
  CONSTRAINT `df_goods_sku_goods_id_31622280_fk_df_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `df_goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `df_goods_sku_type_id_576de3b4_fk_df_good_type_id` FOREIGN KEY (`type_id`) REFERENCES `df_good_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for df_index_banner
-- ----------------------------
DROP TABLE IF EXISTS `df_index_banner`;
CREATE TABLE `df_index_banner`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `index` smallint(6) NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `df_index_banner_sku_id_57f2798e_fk_df_goods_sku_id`(`sku_id`) USING BTREE,
  CONSTRAINT `df_index_banner_sku_id_57f2798e_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for df_index_promotion
-- ----------------------------
DROP TABLE IF EXISTS `df_index_promotion`;
CREATE TABLE `df_index_promotion`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `index` smallint(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for df_index_type_goods
-- ----------------------------
DROP TABLE IF EXISTS `df_index_type_goods`;
CREATE TABLE `df_index_type_goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `display_type` smallint(6) NOT NULL,
  `index` smallint(6) NOT NULL,
  `sku_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `df_index_type_goods_sku_id_0a8a17db_fk_df_goods_sku_id`(`sku_id`) USING BTREE,
  INDEX `df_index_type_goods_type_id_35192ffd_fk_df_good_type_id`(`type_id`) USING BTREE,
  CONSTRAINT `df_index_type_goods_sku_id_0a8a17db_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `df_index_type_goods_type_id_35192ffd_fk_df_good_type_id` FOREIGN KEY (`type_id`) REFERENCES `df_good_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for df_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `df_order_goods`;
CREATE TABLE `df_order_goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `count` int(11) NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `comment` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `df_order_goods_order_id_6958ee23_fk_df_order_info_order_id`(`order_id`) USING BTREE,
  INDEX `df_order_goods_sku_id_b7d6e04e_fk_df_goods_sku_id`(`sku_id`) USING BTREE,
  CONSTRAINT `df_order_goods_order_id_6958ee23_fk_df_order_info_order_id` FOREIGN KEY (`order_id`) REFERENCES `df_order_info` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `df_order_goods_sku_id_b7d6e04e_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for df_order_info
-- ----------------------------
DROP TABLE IF EXISTS `df_order_info`;
CREATE TABLE `df_order_info`  (
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `order_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pay_method` smallint(6) NOT NULL,
  `total_count` int(11) NOT NULL,
  `total_price` decimal(10, 2) NOT NULL,
  `transit_price` decimal(10, 2) NOT NULL,
  `order_status` smallint(6) NOT NULL,
  `trade_no` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `addr_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `df_order_info_addr_id_70c3726e_fk_df_address_id`(`addr_id`) USING BTREE,
  INDEX `df_order_info_user_id_ac1e5bf5_fk_df_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `df_order_info_addr_id_70c3726e_fk_df_address_id` FOREIGN KEY (`addr_id`) REFERENCES `df_address` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `df_order_info_user_id_ac1e5bf5_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for df_user
-- ----------------------------
DROP TABLE IF EXISTS `df_user`;
CREATE TABLE `df_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of df_user
-- ----------------------------
INSERT INTO `df_user` VALUES (24, 'pbkdf2_sha256$150000$mZ6cngGAebRh$VR1nZkxljuYhSI+eq6t0L47HP9x9rYWX1OQLhD468bo=', '2019-06-17 10:57:09.323444', 0, 'adminadmin', '', '', '2226584247@qq.com', 0, 1, '2019-06-03 12:15:12.163990', '2019-06-03 12:15:12.283921', '2019-06-03 12:15:12.283921', 0);
INSERT INTO `df_user` VALUES (25, 'pbkdf2_sha256$150000$rQmGWrWAxuSh$jFCsaELrJieP2NAbsCC5hfFmOfxVp7z7GdodNPusJA0=', '2019-07-27 14:21:42.066892', 0, 'rootroot', '', '', '1152469064@qq.com', 0, 1, '2019-06-05 13:33:36.881953', '2019-06-05 13:33:37.019875', '2019-06-05 13:33:37.019875', 0);
INSERT INTO `df_user` VALUES (26, 'pbkdf2_sha256$150000$iUqeX8oJWd5R$6Ak/68jcqa1hrZDm4JZJcVRk5EJ+KfN/6OjBkS4U4eE=', '2019-06-05 13:48:30.007196', 0, '123456789', '', '', '1152469064@qq.com', 0, 1, '2019-06-05 13:48:06.729452', '2019-06-05 13:48:06.849397', '2019-06-05 13:48:06.849397', 0);
INSERT INTO `df_user` VALUES (27, 'pbkdf2_sha256$150000$Mz3xArwQZjAc$P6y0NjtA2BHbhhWHO9ZVWFvbXHs2cjkWlvL8E5UwC5s=', NULL, 1, 'admin', '', '', '', 1, 1, '2019-07-19 15:57:49.645285', '2019-07-19 15:57:49.771188', '2019-07-19 15:57:49.771188', 0);
INSERT INTO `df_user` VALUES (28, 'pbkdf2_sha256$150000$hYqY9SStIrIG$lT6Df+iQ1z3mf4AgPy7gaYLy5+57xCJAVY5/znHNEIU=', '2019-07-24 17:44:59.289382', 1, 'root', '', '', 'root@root.com', 1, 1, '2019-07-19 16:03:31.067720', '2019-07-19 16:03:31.198661', '2019-07-19 16:03:31.198661', 0);

-- ----------------------------
-- Table structure for df_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `df_user_groups`;
CREATE TABLE `df_user_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `df_user_groups_user_id_group_id_80e5ab91_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `df_user_groups_group_id_36f24e94_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `df_user_groups_group_id_36f24e94_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `df_user_groups_user_id_a816b098_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for df_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `df_user_user_permissions`;
CREATE TABLE `df_user_user_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `df_user_user_permissions_user_id_permission_id_b22997de_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `df_user_user_permiss_permission_id_40a6cb2d_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `df_user_user_permiss_permission_id_40a6cb2d_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `df_user_user_permissions_user_id_b5f6551b_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_df_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2019-07-26 12:34:04.930261', '1', '猪牛羊肉', 1, '[{\"added\": {}}]', 10, 28);
INSERT INTO `django_admin_log` VALUES (2, '2019-07-26 12:34:57.392688', '1', '猪牛羊肉', 2, '[]', 10, 28);
INSERT INTO `django_admin_log` VALUES (3, '2019-07-26 12:35:13.772276', '2', '猪牛羊肉', 1, '[{\"added\": {}}]', 10, 28);
INSERT INTO `django_admin_log` VALUES (4, '2019-07-26 16:13:27.430427', '3', '猪牛羊肉', 1, '[{\"added\": {}}]', 10, 28);
INSERT INTO `django_admin_log` VALUES (5, '2019-07-26 16:18:52.931093', '3', '猪牛羊肉', 3, '', 10, 28);
INSERT INTO `django_admin_log` VALUES (6, '2019-07-26 16:18:52.934094', '2', '猪牛羊肉', 3, '', 10, 28);
INSERT INTO `django_admin_log` VALUES (7, '2019-07-26 16:18:58.288051', '1', '猪牛羊肉', 3, '', 10, 28);
INSERT INTO `django_admin_log` VALUES (8, '2019-07-26 16:19:11.093831', '4', '猪牛羊肉', 1, '[{\"added\": {}}]', 10, 28);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (8, 'goods', 'goods');
INSERT INTO `django_content_type` VALUES (14, 'goods', 'goodsimage');
INSERT INTO `django_content_type` VALUES (9, 'goods', 'goodssku');
INSERT INTO `django_content_type` VALUES (10, 'goods', 'goodstype');
INSERT INTO `django_content_type` VALUES (13, 'goods', 'indexgoodsbanner');
INSERT INTO `django_content_type` VALUES (11, 'goods', 'indexpromotionbanner');
INSERT INTO `django_content_type` VALUES (12, 'goods', 'indextypegoodsbanner');
INSERT INTO `django_content_type` VALUES (15, 'order', 'ordergoods');
INSERT INTO `django_content_type` VALUES (16, 'order', 'orderinfo');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (7, 'user', 'address');
INSERT INTO `django_content_type` VALUES (6, 'user', 'user');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2019-05-23 03:59:31.229535');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2019-05-23 03:59:31.410042');
INSERT INTO `django_migrations` VALUES (3, 'auth', '0001_initial', '2019-05-23 03:59:31.520378');
INSERT INTO `django_migrations` VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2019-05-23 03:59:31.959396');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0003_alter_user_email_max_length', '2019-05-23 03:59:31.968382');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0004_alter_user_username_opts', '2019-05-23 03:59:31.977377');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0005_alter_user_last_login_null', '2019-05-23 03:59:31.987364');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0006_require_contenttypes_0002', '2019-05-23 03:59:31.993683');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2019-05-23 03:59:32.002679');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0008_alter_user_username_max_length', '2019-05-23 03:59:32.010672');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2019-05-23 03:59:32.020682');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0010_alter_group_name_max_length', '2019-05-23 03:59:32.041658');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0011_update_proxy_permissions', '2019-05-23 03:59:32.052648');
INSERT INTO `django_migrations` VALUES (14, 'user', '0001_initial', '2019-05-23 03:59:32.199136');
INSERT INTO `django_migrations` VALUES (15, 'admin', '0001_initial', '2019-05-23 03:59:32.727850');
INSERT INTO `django_migrations` VALUES (16, 'admin', '0002_logentry_remove_auto_add', '2019-05-23 03:59:32.908775');
INSERT INTO `django_migrations` VALUES (17, 'admin', '0003_logentry_add_action_flag_choices', '2019-05-23 03:59:32.918769');
INSERT INTO `django_migrations` VALUES (18, 'goods', '0001_initial', '2019-05-23 03:59:33.210820');
INSERT INTO `django_migrations` VALUES (19, 'order', '0001_initial', '2019-05-23 03:59:33.803461');
INSERT INTO `django_migrations` VALUES (20, 'order', '0002_auto_20190523_1158', '2019-05-23 03:59:33.897907');
INSERT INTO `django_migrations` VALUES (21, 'sessions', '0001_initial', '2019-05-23 03:59:34.262131');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('6va5ezje9b55wmsbe2gmql5aomftxkgi', 'ZmE2YzEyZDlhMzdjOTcyYzI2NTVmZDYzYzU2MWYxYzRkMDdkNWE1Nzp7Il9hdXRoX3VzZXJfaWQiOiIyNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYTllMmMxNTk5YzhjZGMwZDA1NTE2ZWU1MjYwMmEzYzNjYzhjZTY1MiJ9', '2019-06-17 12:16:15.806196');
INSERT INTO `django_session` VALUES ('yb8jvx0whpqbvou4rd1nuuswm9i1pn0z', 'ZmE2YzEyZDlhMzdjOTcyYzI2NTVmZDYzYzU2MWYxYzRkMDdkNWE1Nzp7Il9hdXRoX3VzZXJfaWQiOiIyNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYTllMmMxNTk5YzhjZGMwZDA1NTE2ZWU1MjYwMmEzYzNjYzhjZTY1MiJ9', '2019-06-17 12:15:32.336060');

SET FOREIGN_KEY_CHECKS = 1;
