/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.project.dao;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.project.entity.ProjectEmail;

/**
 * 任务邮件DAO接口
 * @author xieguofu
 * @version 2017-09-13
 */
@MyBatisDao
public interface ProjectEmailDao extends CrudDao<ProjectEmail> {

	
}