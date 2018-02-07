/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.task.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.modules.task.dao.TaskLogDao;
import com.tospur.modules.task.entity.TaskLog;

/**
 * 任务日志Service
 * @author xieguofu
 * @version 2017-09-01
 */
@Service
@Transactional(readOnly = true)
public class TaskLogService extends CrudService<TaskLogDao, TaskLog> {

    @Autowired
    private TaskLogDao taskLogDao;
    
	public TaskLog get(String id) {
		return super.get(id);
	}
	
	public List<TaskLog> findList(TaskLog taskLog) {
		return super.findList(taskLog);
	}
	
	public Page<TaskLog> findPage(Page<TaskLog> page, TaskLog taskLog) {
		return super.findPage(page, taskLog);
	}
	
	@Transactional(readOnly = false)
	public void save(TaskLog taskLog) {
		super.save(taskLog);
	}
	
	@Transactional(readOnly = false)
	public void delete(TaskLog taskLog) {
		super.delete(taskLog);
	}
	
	public List<TaskLog> findByTask(Integer task) {
	    return taskLogDao.findByTask(task);
	}
	
	
	
}