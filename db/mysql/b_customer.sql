/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50519
Source Host           : localhost:3306
Source Database       : shangji

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2017-08-24 16:13:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `b_customer`
-- ----------------------------
DROP TABLE IF EXISTS `b_customer`;
CREATE TABLE `b_customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(64) DEFAULT NULL COMMENT '客户名称',
  `way` varchar(64) DEFAULT NULL COMMENT '来源方式',
  `address` varchar(500) DEFAULT NULL COMMENT '客户地址',
  `industry` varchar(500) DEFAULT NULL COMMENT '所属行业',
  `contacts` varchar(500) DEFAULT NULL COMMENT '联系人',
  `phone` varchar(64) DEFAULT NULL COMMENT '联系人电话',
  `url` varchar(500) DEFAULT NULL COMMENT '公司网址/个人网站',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  `status` varchar(64) DEFAULT NULL COMMENT '客户的状态',
  `projectBelong` varchar(255) DEFAULT NULL COMMENT '项目所属区域',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8 COMMENT='客户信息表';

-- ----------------------------
-- Records of b_customer
-- ----------------------------
INSERT INTO `b_customer` VALUES ('7', '卓越集团', '第三方介绍', '深圳市福田中心三路8号卓越时代广场二期四楼', '房地产', '郑群', '13927480475', 'http://www.excegroup.com/', 'admin', '2017-02-16 14:51:43', '潘迪华', '2017-07-05 15:56:27', '0', '', null);
INSERT INTO `b_customer` VALUES ('13', '时代地产', 'CallIn', '中国广东省广州市东风中路410号时代地产中心36-38楼', '房地产', '官方电话', '020-8348666', 'http://www.timesgroup.cn/', 'admin', '2017-02-16 15:21:31', 'admin', '2017-06-15 15:13:15', '0', '', null);
INSERT INTO `b_customer` VALUES ('30', '中信信用卡中心', '第三方介绍', '中信银行广场（园岭C出口）', '银行', '刘冠军', '15626518258', 'http://ecitic.zibolan.com/', '潘迪华', '2017-06-15 15:17:05', '潘迪华', '2017-06-15 15:17:05', '0', null, null);
INSERT INTO `b_customer` VALUES ('103', '同方威视', '第三方介绍', '北京市海淀区双清路同方大厦A座2层', '制造业', '', '', 'http://www.nuctech.com/', '潘迪华', '2017-07-04 10:32:27', '潘迪华', '2017-07-04 10:32:27', '0', null, null);
INSERT INTO `b_customer` VALUES ('104', '世联行', '第三方介绍', '深圳南山大冲商务中心D栋', '房地产', '叶君丹', '', '广东深圳罗湖商务中心12楼', '潘迪华', '2017-07-04 10:52:23', '潘迪华', '2017-07-04 10:52:23', '0', null, null);
INSERT INTO `b_customer` VALUES ('105', '新疆交通厅', '自主寻找', '新疆', '政府', '蔡玲', '', '', '潘迪华', '2017-07-04 11:05:30', 'admin', '2017-07-04 19:06:43', '0', null, null);
INSERT INTO `b_customer` VALUES ('106', '中国电力科学研究院', '自主寻找', '北京', '能源', '金瑾', '13699250518', '', '潘迪华', '2017-07-04 11:07:09', '潘迪华', '2017-07-04 11:07:09', '0', null, null);
INSERT INTO `b_customer` VALUES ('107', '东莞国土局', '第三方介绍', '东莞', '政府', '董其峰', '', '', '潘迪华', '2017-07-10 16:04:03', 'admin', '2017-07-14 14:18:49', '0', null, null);
