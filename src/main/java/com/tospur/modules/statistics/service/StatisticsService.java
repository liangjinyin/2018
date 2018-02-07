package com.tospur.modules.statistics.service;


import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Maps;
import com.tospur.common.service.CrudService;
import com.tospur.modules.project.dao.ProjectDao;
import com.tospur.modules.project.entity.Project;
import com.tospur.modules.statistics.dao.StatisticsDao;
import com.tospur.modules.statistics.entity.EmployeeLoad;
import com.tospur.modules.statistics.entity.ProductIteration;
import com.tospur.modules.statistics.entity.TaskCollect;
import com.tospur.modules.sys.entity.User;
import com.tospur.modules.sys.utils.UserUtils;

/**
 * 统计Service
 * @author 
 *
 */
@Service
@Transactional(readOnly = true)
public class StatisticsService extends CrudService<ProjectDao, Project> {
    
    @Autowired
    private StatisticsDao statisticsDao;
    
    public List<ProductIteration> findAllList(String product, Date beginTime, Date endTime){
       //User user = UserUtils.getUser();
       //user.getSqlMap().put("dsf", super.dataScopeFilter(user, "oy", "uy"));
       
       
        return statisticsDao.findAllList(product, beginTime, endTime);
    }
    
    public List<TaskCollect> findTaskCollectList(Date finishedDate){
        return statisticsDao.findTaskCollectList(finishedDate);
    }
    
    public List<EmployeeLoad> findEmployeeLoadList(String name, Date beginTime, Date endTime){
        List<EmployeeLoad> employeeLoads = statisticsDao.findEmployeeLoadList(name, beginTime, endTime);
        return employeeLoads;
    }
   
}