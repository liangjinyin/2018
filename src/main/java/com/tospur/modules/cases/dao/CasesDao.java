/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.cases.dao;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.cases.entity.Cases;

/**
 * 案场DAO接口
 * @author jinyin
 * @version 2018-01-29
 */
@MyBatisDao
public interface CasesDao extends CrudDao<Cases> {

	
}