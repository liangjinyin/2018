package com.tospur.modules.email.dao;


import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.email.entity.EmailMessage;

/**
 * emailDAO接口
 * @author kiss
 * @version 2017-05-19
 */
@MyBatisDao
public interface EmailMessageDao extends CrudDao<EmailMessage> {

	
}