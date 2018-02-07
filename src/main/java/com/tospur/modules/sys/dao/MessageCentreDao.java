/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.sys.dao;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.sys.entity.MessageCentre;

/**
 * 邮件DAO接口
 * @author zhangfeng
 * @version 2016-07-05
 */
@MyBatisDao
public interface MessageCentreDao extends CrudDao<MessageCentre> {

    /**
     * 更改消息状态
     * @param status
     * @return
     */
    public int updateStatus(int messageId);
	
}