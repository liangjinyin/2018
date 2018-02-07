ALTER TABLE b_project ADD COLUMN state VARCHAR(64) NOT NULL COMMENT '项目状态';
ALTER TABLE b_project ADD COLUMN quotation VARCHAR(64) DEFAULT NULL COMMENT '我方对外报价金额';
ALTER TABLE b_project ADD COLUMN cost VARCHAR(64) DEFAULT NULL COMMENT '我方成本金额';


ALTER TABLE `b_project`
MODIFY COLUMN `sale_manager`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '销售负责人' AFTER `requirements`,
MODIFY COLUMN `pre_sale_manager`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '售前负责人' AFTER `sale_manager`;

ALTER TABLE b_project_log ADD COLUMN follow_date datetime DEFAULT NULL COMMENT '跟进时间';

INSERT INTO `sys_dict` (`id`, `value`, `label`, `type`, `description`, `sort`, `create_by`, `create_date`, `update_by`, `update_date`) VALUES ('1001', '意向客户', '意向客户', 'state', '项目状态', '1', '1', '2017-08-23 11:40:47', '1', '2017-08-23 11:40:47')
INSERT INTO `sys_dict` (`id`, `value`, `label`, `type`, `description`, `sort`, `create_by`, `create_date`, `update_by`, `update_date`) VALUES ('1002', '初步沟通', '初步沟通', 'state', '项目状态', '2', '1', '2017-08-23 11:40:47', '1', '2017-08-23 11:40:47')
INSERT INTO `sys_dict` (`id`, `value`, `label`, `type`, `description`, `sort`, `create_by`, `create_date`, `update_by`, `update_date`) VALUES ('1003', '深度沟通', '深度沟通', 'state', '项目状态', '3', '1', '2017-08-23 11:40:47', '1', '2017-08-23 11:40:47')
INSERT INTO `sys_dict` (`id`, `value`, `label`, `type`, `description`, `sort`, `create_by`, `create_date`, `update_by`, `update_date`) VALUES ('1004', '签订合同', '签订合同', 'state', '项目状态', '4', '1', '2017-08-23 11:40:47', '1', '2017-08-23 11:40:47')


UPDATE `sys_dict` SET `value`='closed', `label`='closed', `description`='closed' WHERE (`id`='60baaab972ad4947959949181032a9fe')
DELETE FROM sys_dict WHERE id IN ('11d85603dfe342d299620759a0806bf9','7a29dcb87cfb4303bbbd7706eba1c229','884b10d9d052442899df645d1f2f189e','b1a56d50847945f182b5c2e63d6f71d3','ebeb6da3355e4f8dbeb3e9a0c33e9d09','fb93917f2bb448539182b24df212b536');

ALTER TABLE `b_salesman`
MODIFY COLUMN `sales_target`  double NOT NULL COMMENT '销售指标' AFTER `name`;

ALTER TABLE `b_project`
ADD COLUMN `project_manager`  varchar(64) NULL COMMENT '项目经理' AFTER `cost`;

ALTER TABLE `b_project`
MODIFY COLUMN `state`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '项目状态' AFTER `del_flag`;

