package com.tospur.modules.project.dao;

import java.util.List;
import java.util.Map;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.project.entity.Project;

/**
 * 项目信息DAO接口
 * @author kiss
 * @version 2017-02-14
 */
@MyBatisDao
public interface ProjectDao extends CrudDao<Project>
{
    
    public List<Map<String, Object>> findIndex();
   
    public Project getOne(Project project);
    
    public int updateStage(Project entity);

}