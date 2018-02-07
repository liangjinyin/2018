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
import com.tospur.modules.task.dao.TaskInfoDao;
import com.tospur.modules.task.entity.TaskInfo;

/**
 * 任务信息Service
 * @author xieguofu
 * @version 2017-08-30
 */
@Service
@Transactional(readOnly = true)
public class TaskInfoService extends CrudService<TaskInfoDao, TaskInfo> {

    @Autowired
    private TaskInfoDao taskInfoDao;
    
	public TaskInfo get(String id) {
		return super.get(id);
	}
	
	public List<TaskInfo> findList(TaskInfo taskInfo) {
		return super.findList(taskInfo);
	}
	
	public Page<TaskInfo> findPage(Page<TaskInfo> page, TaskInfo taskInfo) {
		return super.findPage(page, taskInfo);
	}
	
	@Transactional(readOnly = false)
	public void save(TaskInfo taskInfo) {
		super.save(taskInfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(TaskInfo taskInfo) {
		super.delete(taskInfo);
	}
	
	@Transactional(readOnly = false)
	public void deleteByLogic(TaskInfo taskInfo){
	    taskInfoDao.deleteByLogic(taskInfo);
	}
	
	@Transactional(readOnly = false)
	public List<TaskInfo> findByIterationAndStatus(Integer iteration, String status){
	    return taskInfoDao.findByIterationAndStatus(iteration, status);
	}
	
	@Transactional(readOnly = false)
	public void recoverByLogic(TaskInfo taskInfo){
	    taskInfoDao.recoverByLogic(taskInfo);
	}
	
	public List<TaskInfo> getTimeByIid(String id){
	    return dao.getTimeByIid(id);
	}
}