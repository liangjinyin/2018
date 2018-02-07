/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.sales.dao;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.sales.entity.SalesMan;

/**
 * salesDAO接口
 * @author kiss
 * @version 2017-07-05
 */
@MyBatisDao
public interface SalesManDao extends CrudDao<SalesMan> {

	
}