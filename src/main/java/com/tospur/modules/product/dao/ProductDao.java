/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.product.dao;

import java.util.List;
import java.util.Map;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.product.entity.Product;

/**
 * 产品信息DAO接口
 * @author jinyin
 * @version 2017-08-29
 */
@MyBatisDao
public interface ProductDao extends CrudDao<Product> {

    public String getProductId();
    public Product getByName(String product);
    public List<Map<String, Object>> getProductName();	
}