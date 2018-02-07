package com.tospur.modules.statistics.entity;

import java.io.Serializable;
import java.util.List;

import com.tospur.modules.task.entity.TaskInfo;

/**
 * 任务汇总entity
 * @author xieguofu
 *
 */
public class TaskCollect implements Serializable
{
    private static final long serialVersionUID = 1L;
    private String finishedBy; // 任务结束者
    private List<TaskInfo> taskInfos; // 任务列表
    public String getFinishedBy()
    {
        return finishedBy;
    }
    public void setFinishedBy(String finishedBy)
    {
        this.finishedBy = finishedBy;
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
