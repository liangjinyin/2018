/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.task.dao;

import java.util.List;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.task.entity.TaskInfo;

/**
 * 任务信息DAO接口
 * @author xieguofu
 * @version 2017-08-30
 */
@MyBatisDao
public interface TaskInfoDao extends CrudDao<TaskInfo> {

	public List<TaskInfo> findByIterationAndStatus(Integer iteration, String status);

    public List<TaskInfo> getTimeByIid(String id);
    
    public void recoverByLogic(TaskInfo taskInfo);
}