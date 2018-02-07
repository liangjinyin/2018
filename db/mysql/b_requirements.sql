/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50519
Source Host           : localhost:3306
Source Database       : shangji

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2017-08-24 16:14:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `b_requirements`
-- ----------------------------
DROP TABLE IF EXISTS `b_requirements`;
CREATE TABLE `b_requirements` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `customer` int(11) NOT NULL COMMENT '所属客户',
  `get_date` datetime DEFAULT NULL COMMENT '需求获取时间',
  `start_date` datetime DEFAULT NULL COMMENT '项目开始时间',
  `name` varchar(64) DEFAULT NULL COMMENT '需求名称',
  `type` varchar(64) DEFAULT NULL COMMENT '需求类型',
  `product` varchar(64) DEFAULT NULL COMMENT '对应产品',
  `situation` varchar(64) DEFAULT NULL COMMENT '现状',
  `contacts` varchar(64) DEFAULT NULL COMMENT '需求联系人',
  `phone` varchar(11) DEFAULT NULL COMMENT '需求联系人电话',
  `bottleneck` varchar(500) DEFAULT NULL COMMENT '瓶颈',
  `core` varchar(500) DEFAULT NULL COMMENT '核心需求',
  `solution` varchar(500) DEFAULT NULL COMMENT '解决方案',
  `project` int(11) DEFAULT NULL COMMENT '所属项目',
  `create_by` varchar(64) NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  `evaluation` varchar(255) DEFAULT NULL COMMENT '项目评价',
  `sale_manager` varchar(64) DEFAULT NULL COMMENT '销售负责人',
  `pre_sale_manager` varchar(64) DEFAULT NULL COMMENT '售前负责人',
  `department` varchar(64) DEFAULT NULL COMMENT '需求部门',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='需求信息表';

-- ----------------------------
-- Records of b_requirements
-- ----------------------------
INSERT INTO `b_requirements` VALUES ('4', '30', '2017-05-01 00:00:00', '2017-05-01 00:00:00', '中信信用卡中心客户智慧分析平台项目', '定制化应用', '平台定制化、可视定制化', '', '刘冠军', '15626518258', '', '项目一期主要做客群画像的可视化展示，数据挖掘平台框架搭建。\r\n\r\n项目二期做数据挖掘平台建设', '大数据挖掘平台方案\r\n可视化方案\r\n可视化效果展示', null, '潘迪华', '2017-06-15 16:09:51', '潘迪华', '2017-07-05 16:07:38', '0', '', '', '', '');
INSERT INTO `b_requirements` VALUES ('6', '103', '2017-04-03 00:00:00', '2017-04-03 00:00:00', '同方威视可视化自助分析', '应用产品', '平台定制化、可视定制化', '', '金瑾', '13699250518', '', '采购可视化自助分析工具', '', null, '潘迪华', '2017-07-04 11:16:18', '潘迪华', '2017-07-05 16:07:23', '0', null, null, null, null);
INSERT INTO `b_requirements` VALUES ('7', '104', '2017-05-04 00:00:00', '2017-05-04 00:00:00', '世联行个性化推荐系统建设项目', '应用产品', '平台定制化、可视定制化', '', '叶君丹', '', '', '基于已有数据，世联行准备梳理客户便签和楼盘标签，在2C电商网站中给人房匹配和个性化推荐。', '个性化推荐系统', null, '潘迪华', '2017-07-05 15:45:57', '潘迪华', '2017-07-05 16:07:33', '0', null, null, null, null);
INSERT INTO `b_requirements` VALUES ('8', '106', '2017-03-02 00:00:00', '2017-03-02 00:00:00', '中国电力科学研究院大数据项目四期', '应用产品', '平台定制化、可视定制化', '', '金瑾', '13699250518', '', '电科院三期项目延续', '大数据平台定制', null, '潘迪华', '2017-07-05 15:49:37', '潘迪华', '2017-07-05 16:07:16', '0', null, null, null, null);
INSERT INTO `b_requirements` VALUES ('9', '7', '2017-03-01 00:00:00', '2017-03-01 00:00:00', '卓越集团案场营销项目', '数据服务', '企业数据SaaS服务、人群洞察产品、精确营销产品', '1、惠州卓越蔚蓝海岸项目销售状况不佳，需要做营销活动\r\n2、项目以前做过朋友圈广告、百度广告，但是效果不佳\r\n3、对线上广告谨慎', '郑群', '13927480475', '1、需要腾讯广点通的社交链挖掘服务', '1、精准招客\r\n2、有效触达\r\n3、提升转化率', '1、针对&ldquo;指定特征投放&rdquo;场景，采用智汇推平台推广\r\n2、针对&ldquo;中介好友投放&rdquo;场景，采用爬虫＋社交广告推广', null, '潘迪华', '2017-07-05 16:03:24', '潘迪华', '2017-07-05 16:03:24', '0', null, null, null, null);
INSERT INTO `b_requirements` VALUES ('10', '105', '2017-07-06 00:00:00', '2017-07-06 00:00:00', '新疆交通厅数据中心架构升级项目', '平台工具', '数据中心产品', '现有数据中心无法承载业务需要', '蔡玲', '', '', '混合架构大数据平台建设', '大数据平台', null, '潘迪华', '2017-07-07 14:09:10', '潘迪华', '2017-07-07 14:09:10', '0', null, null, null, null);
INSERT INTO `b_requirements` VALUES ('11', '107', '2017-07-04 00:00:00', '2017-07-04 00:00:00', '东莞国土局爬虫平台', '应用产品', '数据中心产品', '', '董其峰', '', '', '爬取地块信息，包含地理位置，周边配套等标签', '', null, '潘迪华', '2017-07-10 16:05:56', 'admin', '2017-07-14 14:18:33', '0', null, null, null, null);
