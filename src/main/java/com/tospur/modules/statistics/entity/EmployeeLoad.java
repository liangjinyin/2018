package com.tospur.modules.statistics.entity;

import java.io.Serializable;
import java.util.List;

public class EmployeeLoad implements Serializable
{
    private static final long serialVersionUID = 1L;
    private String employee; // 员工
    private Integer taskTotal; //总任务数
    private Double timeTotal; //总剩余数时间
    private List<IterationTask> iterationTasks; 
    public String getEmployee()
    {
        return employee;
    }
    public void setEmployee(String employee)
    {
        this.employee = employee;
    }
    public Integer getTaskTotal()
    {
        return taskTotal;
    }
    public void setTaskTotal(Integer taskTotal)
    {
        this.taskTotal = taskTotal;
    }
    public Double getTimeTotal()
    {
        return timeTotal;
    }
    public void setTimeTotal(Double timeTotal)
    {
        this.timeTotal = timeTotal;
    }
    public List<IterationTask> getIterationTasks()
    {
        return iterationTasks;
    }
    public void setIterationTasks(List<IterationTask> iterationTasks)
    {
        this.iterationTasks = iterationTasks;
    }
    
    
    
}
