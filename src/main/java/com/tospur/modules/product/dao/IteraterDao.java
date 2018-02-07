/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.product.dao;

import java.util.List;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.product.entity.Iterater;

/**
 * 迭代信息DAO接口
 * @author jinyin
 * @version 2017-08-30
 */
@MyBatisDao
public interface IteraterDao extends CrudDao<Iterater> {

    
   public String getIteraterNum();

   public List<Iterater> getIteraterListByName(String name);

   
   public String getNew(Iterater itera);

	
}