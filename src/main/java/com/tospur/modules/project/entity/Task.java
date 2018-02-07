package com.tospur.modules.project.entity;


import java.util.Date;

import com.tospur.common.persistence.DataEntity;

/**
 * 项目信息Entity
 * @author kiss
 * @version 2017-02-15
 */
public class Task extends DataEntity<Task> {
	
	private static final long serialVersionUID = 1L;
	private String projectName;
    private String taskName;
    private String assignedTo;
    private String finishedBy;
    private String canceledBy;
    private String closedBy;
    private String status;
    private String desc;
    private Date assignedDate;
    private Date estStarted;
    private Date realStarted;
    private Date finishedDate;
    private Date canceledDate;
    private Date closedDate;
    private Date lastEditedDate;
    private String projectManager;
    private String date;//用来传参数
    private String taskType;
    
    public String getTaskType()
    {
        return taskType;
    }
    public void setTaskType(String taskType)
    {
        this.taskType = taskType;
    }
    public String getProjectManager()
    {
        return projectManager;
    }
    public void setProjectManager(String projectManager)
    {
        this.projectManager = projectManager;
    }
    public String getProjectName()
    {
        return projectName;
    }
    public void setProjectName(String projectName)
    {
        this.projectName = projectName;
    }
    public String getTaskName()
    {
        return taskName;
    }
    public void setTaskName(String taskName)
    {
        this.taskName = taskName;
    }
    public String getAssignedTo()
    {
        return assignedTo;
    }
    public void setAssignedTo(String assignedTo)
    {
        this.assignedTo = assignedTo;
    }
    public String getFinishedBy()
    {
        return finishedBy;
    }
    public void setFinishedBy(String finishedBy)
    {
        this.finishedBy = finishedBy;
    }
    public String getCanceledBy()
    {
        return canceledBy;
    }
    public void setCanceledBy(String canceledBy)
    {
        this.canceledBy = canceledBy;
    }
    public String getClosedBy()
    {
        return closedBy;
    }
    public void setClosedBy(String closedBy)
    {
        this.closedBy = closedBy;
    }
    public String getStatus()
    {
        return status;
    }
    public void setStatus(String status)
    {
        this.status = status;
    }
    public String getDesc()
    {
        return desc;
    }
    public void setDesc(String desc)
    {
        this.desc = desc;
    }
    public Date getAssignedDate()
    {
        return assignedDate;
    }
    public void setAssignedDate(Date assignedDate)
    {
        this.assignedDate = assignedDate;
    }
    public Date getEstStarted()
    {
        return estStarted;
    }
    public void setEstStarted(Date estStarted)
    {
        this.estStarted = estStarted;
    }
    public Date getRealStarted()
    {
        return realStarted;
    }
    public void setRealStarted(Date realStarted)
    {
        this.realStarted = realStarted;
    }
    public Date getFinishedDate()
    {
        return finishedDate;
    }
    public void setFinishedDate(Date finishedDate)
    {
        this.finishedDate = finishedDate;
    }
    public Date getCanceledDate()
    {
        return canceledDate;
    }
    public void setCanceledDate(Date canceledDate)
    {
        this.canceledDate = canceledDate;
    }
    public Date getClosedDate()
    {
        return closedDate;
    }
    public void setClosedDate(Date closedDate)
    {
        this.closedDate = closedDate;
    }
    public Date getLastEditedDate()
    {
        return lastEditedDate;
    }
    public void setLastEditedDate(Date lastEditedDate)
    {
        this.lastEditedDate = lastEditedDate;
    }
    public String getDate()
    {
        return date;
    }
    public void setDate(String date)
    {
        this.date = date;
    }
   
}