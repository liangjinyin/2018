package com.tospur.modules.iim.dao;


import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.iim.entity.MailBox;

/**
 * 发件箱DAO接口
 * @author jeeplus
 * @version 2015-11-15
 */
@MyBatisDao
public interface MailBoxDao extends CrudDao<MailBox> {
	
	public int getCount(MailBox entity);
	
}