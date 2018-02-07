/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.product.dao;

import java.util.List;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.product.entity.Edition;

/**
 * 版本信息DAO接口
 * @author jinyin
 * @version 2017-08-31
 */
@MyBatisDao
public interface EditionDao extends CrudDao<Edition> {

	 public List<Edition> getEditionListById(String id);
     
   
}