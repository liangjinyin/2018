/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.partner.dao;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.partner.entity.PartnerServiceLog;

/**
 * 接入方管理DAO接口
 * @author liminfang
 * @version 2016-07-06
 */
@MyBatisDao
public interface PartnerServiceLogDao extends CrudDao<PartnerServiceLog> {

	
}