package com.tospur.modules.statistics.entity;

import java.io.Serializable;
import java.util.List;

import com.tospur.modules.task.entity.TaskInfo;

public class IterationTask implements Serializable
{
    private static final long serialVersionUID = 1L;
    private String iterater; //迭代名称
    private Integer taskNum; //任务数
    private Double timeNum; //剩余时间
    private List<TaskInfo> taskInfos; //迭代中的任务
    public String getIterater()
    {
        return iterater;
    }
    public void setIterater(String iterater)
    {
        this.iterater = iterater;
    }
    public Integer getTaskNum()
    {
        return taskNum;
    }
    public void setTaskNum(Integer taskNum)
    {
        this.taskNum = taskNum;
    }
    public Double getTimeNum()
    {
        return timeNum;
    }
    public void setTimeNum(Double timeNum)
    {
        this.timeNum = timeNum;
    }
    public List<TaskInfo> getTaskInfos()
    {
        return taskInfos;
    }
    public void setTaskInfos(List<TaskInfo> taskInfos)
    {
        this.taskInfos = taskInfos;
    }
    
    
    
}
