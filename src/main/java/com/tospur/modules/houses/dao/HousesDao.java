/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.houses.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.houses.entity.Houses;

/**
 * 房型DAO接口
 * @author jinyin
 * @version 2018-02-01
 */
@MyBatisDao
public interface HousesDao extends CrudDao<Houses> {

    List<Houses> getListByCasesName(@Param("casesName")String name);

	
}