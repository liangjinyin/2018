/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.task.dao;


import java.util.List;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.task.entity.TaskLog;

/**
 * 任务日志DAO接口
 * @author xieguofu
 * @version 2017-09-01
 */
@MyBatisDao
public interface TaskLogDao extends CrudDao<TaskLog> {

    public List<TaskLog> findByTask(Integer task);
	
}