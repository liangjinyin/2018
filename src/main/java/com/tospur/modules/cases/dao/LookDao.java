/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.cases.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.cases.entity.Look;

/**
 * 案场DAO接口
 * @author jinyin
 * @version 2018-01-29
 */
@MyBatisDao
public interface LookDao extends CrudDao<Look> {

    List<Map<String,Object>> getLookList(@Param("casesName")String name, @Param("date")String date);

    List<Map<String, Object>> getSalelist(@Param("username")String name, @Param("date")String date);

	
}