/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.project.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.modules.project.dao.ProjectEmailDao;
import com.tospur.modules.project.entity.ProjectEmail;

/**
 * 任务邮件Service
 * @author xieguofu
 * @version 2017-09-13
 */
@Service
@Transactional(readOnly = true)
public class ProjectEmailService extends CrudService<ProjectEmailDao, ProjectEmail> {

	public ProjectEmail get(String id) {
		return super.get(id);
	}
	
	public List<ProjectEmail> findList(ProjectEmail projectEmail) {
		return super.findList(projectEmail);
	}
	
	public Page<ProjectEmail> findPage(Page<ProjectEmail> page, ProjectEmail projectEmail) {
		return super.findPage(page, projectEmail);
	}
	
	@Transactional(readOnly = false)
	public void save(ProjectEmail projectEmail) {
		super.save(projectEmail);
	}
	
	@Transactional(readOnly = false)
	public void delete(ProjectEmail projectEmail) {
		super.delete(projectEmail);
	}
	
	@SuppressWarnings("deprecation")
    @Transactional(readOnly = false)
	public List<ProjectEmail> findAllList(){
	    return dao.findAllList();
	}
	
}