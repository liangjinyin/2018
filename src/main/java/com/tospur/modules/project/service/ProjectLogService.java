package com.tospur.modules.project.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.modules.project.dao.ProjectLogDao;
import com.tospur.modules.project.entity.ProjectLog;

/**
 * 项目动态Service
 * @author kiss
 * @version 2017-02-14
 */
@Service
@Transactional(readOnly = true)
public class ProjectLogService extends CrudService<ProjectLogDao, ProjectLog> {

    @Autowired
    ProjectLogDao projectLogDao;
    
	public ProjectLog get(String id) {
		return super.get(id);
	}
	
	public List<ProjectLog> findList(ProjectLog projectLog) {
		return super.findList(projectLog);
	}
	
	public Page<ProjectLog> findPage(Page<ProjectLog> page, ProjectLog projectLog) {
		return super.findPage(page, projectLog);
	}
	
	@Transactional(readOnly = false)
	public void save(ProjectLog projectLog) {
		super.save(projectLog);
	}
	
	@Transactional(readOnly = false)
	public void delete(ProjectLog projectLog) {
		super.delete(projectLog);
	}
	
	//根据project删除log
	@Transactional(readOnly = false)
	public void deleteByProject(String project) {
	    projectLogDao.deleteByProject(project);
	}
	
	
	
}