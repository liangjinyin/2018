package com.tospur.modules.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.ChanDao;
import com.tospur.modules.project.entity.Bug;
import com.tospur.modules.project.entity.Project;
import com.tospur.modules.project.entity.Task;
import com.tospur.modules.project.entity.TaskReport;

/**
 * 项目信息DAO接口
 * @author kiss
 * @version 2017-02-14
 */
@ChanDao
public interface TaskManageDao extends CrudDao<Project>
{
    
    
    /**
     * 
     * @param project
     * @return
     */
    public List<Map<String, Object>> findProjects(Project project);
    public Map<String, Object>findProjectById(@Param("id")String id,@Param("name")String name);
    public List<Map<String, Object>> findPersonProcess(@Param("account")String account,@Param("workdate")String workdate);
    
    /**
     * 
     * @param task
     * @return
     */
    public List<Task> findJobs(Task task);
    
    /**
     * 
     * @param bug
     * @return
     */
    public List<Bug> findBugs(Bug bug);
    
    /**
     * 
     * @return
     */
    public List<String> findEmployee();
    /**
     * 
     * @return
     */
    public List<String> findPms();
    
    
    
    
    /**
     * 查询项目进度
     * @param name
     * @return
     */
    public List<Map<String, Object>> findProjectProcess(Project project);
    
    /**
     * 任务日报
     * @param task
     * @return
     */
    public List<Map<String, Object>> findDayTaskReport(Task task);
    
    /**
     * 任务周报
     * @param task
     *  #=================================周报：
        #--------39 个任务，已完成 1，未开始 31，进行中 4，总预计187.5工时，已消耗14.1工时，剩余180.4工时。
     * @return
     */
    public List<Map<String, Object>> findWeekTaskReport(Task task);
    
    /**
     * 项目汇总周报
     * @param task
     * @return
     */
    public List<Map<String, Object>> findWeekPorjectSumReport(Task task);
    public List<Project> findProjectsByWeek();
    
    public List<Map<String,String>> findUsersByProject(@Param("id")String id);
    public List<TaskReport> findTaskReport(TaskReport task);
    public int createDayReport(HashMap<String,Object> param);
    
}