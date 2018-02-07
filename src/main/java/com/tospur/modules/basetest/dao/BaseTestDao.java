/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.basetest.dao;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.basetest.entity.BaseTest;

/**
 * 基线测试DAO接口
 * @author jinyin
 * @version 2017-09-18
 */
@MyBatisDao
public interface BaseTestDao extends CrudDao<BaseTest> {

    public String getBaseTestId();

	
}