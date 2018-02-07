package com.tospur.modules.task.entity;

import java.io.Serializable;
import java.util.List;

public class MoreTaskLog implements Serializable
{
    private static final long serialVersionUID = 1L;
    private List<TaskLog> taskLogs;

    public List<TaskLog> getTaskLogs()
    {
        return taskLogs;
    }

    public void setTaskLogs(List<TaskLog> taskLogs)
    {
        this.taskLogs = taskLogs;
    }
    
    
}
