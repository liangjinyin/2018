package com.tospur.modules.project.entity;


import java.util.Date;

import com.tospur.common.persistence.DataEntity;

/**
 * 项目信息Entity
 * @author kiss
 * @version 2017-02-15
 */
public class Bug extends DataEntity<Bug> {
	
	private static final long serialVersionUID = 1L;
	private String title;
    private String status;
    private String openedBy;
    private String assignedTo;
    private String resolvedBy;
    private Date assignedDate;
    private Date resolvedDate;
    private Date closedDate;
    public String getTitle()
    {
        return title;
    }
    public void setTitle(String title)
    {
        this.title = title;
    }
    public String getStatus()
    {
        return status;
    }
    public void setStatus(String status)
    {
        this.status = status;
    }
    public String getOpenedBy()
    {
        return openedBy;
    }
    public void setOpenedBy(String openedBy)
    {
        this.openedBy = openedBy;
    }
    public String getAssignedTo()
    {
        return assignedTo;
    }
    public void setAssignedTo(String assignedTo)
    {
        this.assignedTo = assignedTo;
    }
    public String getResolvedBy()
    {
        return resolvedBy;
    }
    public void setResolvedBy(String resolvedBy)
    {
        this.resolvedBy = resolvedBy;
    }
    public Date getAssignedDate()
    {
        return assignedDate;
    }
    public void setAssignedDate(Date assignedDate)
    {
        this.assignedDate = assignedDate;
    }
    public Date getResolvedDate()
    {
        return resolvedDate;
    }
    public void setResolvedDate(Date resolvedDate)
    {
        this.resolvedDate = resolvedDate;
    }
    public Date getClosedDate()
    {
        return closedDate;
    }
    public void setClosedDate(Date closedDate)
    {
        this.closedDate = closedDate;
    }
    
    
}