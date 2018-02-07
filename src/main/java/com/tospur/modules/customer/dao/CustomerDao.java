package com.tospur.modules.customer.dao;


import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.customer.entity.Customer;

/**
 * 客户信息DAO接口
 * @author kiss
 * @version 2017-02-14
 */
@MyBatisDao
public interface CustomerDao extends CrudDao<Customer> {

	
}