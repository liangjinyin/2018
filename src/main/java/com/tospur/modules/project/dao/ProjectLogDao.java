package com.tospur.modules.project.dao;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.project.entity.ProjectLog;

/**
 * 项目动态DAO接口
 * @author kiss
 * @version 2017-02-14
 */
@MyBatisDao
public interface ProjectLogDao extends CrudDao<ProjectLog> {

	public void deleteByProject(String project);
}