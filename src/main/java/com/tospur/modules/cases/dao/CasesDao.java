/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.cases.dao;

import org.apache.ibatis.annotations.Param;

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

    Cases getCasesByName(@Param("casesName")String cases);

    String getTeamByName(@Param("casesName")String name);

  


	
}