package com.tospur.modules.task.entity;

import java.io.Serializable;
import java.util.List;

public class MoreTaskInfo implements Serializable
{
    private static final long serialVersionUID = 1L;
    private List<TaskInfo> taskInfos;

    public List<TaskInfo> getTaskInfos()
    {
        return taskInfos;
    }

    public void setTaskInfos(List<TaskInfo> taskInfos)
    {
        this.taskInfos = taskInfos;
    }
    
    
}
