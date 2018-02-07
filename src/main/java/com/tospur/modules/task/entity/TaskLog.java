/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.task.entity;

import java.util.Date;

import com.tospur.common.persistence.DataEntity;
import com.tospur.common.utils.excel.annotation.ExcelField;

/**
 * 任务日志Entity
 * @author xieguofu
 * @version 2017-09-01
 */
public class TaskLog extends DataEntity<TaskLog> {
	
	private static final long serialVersionUID = 1L;
	private Integer task;		// 所属任务
	private Integer consumed;   //消耗时间
	private Integer surplus;    //剩余时间
	private String content;		// 工作内容
	private Date date;          //日期
	private String status;  //状态（旧值）
	private String lastStatus; //当前状态
	private String assignedTo; //指派给谁（旧值）
	private Date assignedDate; // 指派时间（旧值）
	private String lastAssignedTo;
	private Date lastAssignedDate;
	
	public TaskLog() {
		super();
	}

	public TaskLog(String id){
		super(id);
	}

	@ExcelField(title="所属任务", align=2, sort=1)
	public Integer getTask() {
		return task;
	}
	
	@ExcelField(title="消耗时间", sort=2)
	public Integer getConsumed()
    {
        return consumed;
    }

    public void setConsumed(Integer consumed)
    {
        this.consumed = consumed;
    }

    @ExcelField(title="剩余时间", sort=3)
    public Integer getSurplus()
    {
        return surplus;
    }

    public void setSurplus(Integer surplus)
    {
        this.surplus = surplus;
    }

    public void setTask(Integer task) {
		this.task = task;
	}
	
	@ExcelField(title="工作内容", align=2, sort=4)
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@ExcelField(title="日期", align=2, sort=5)
    public Date getDate()
    {
        return date;
    }

    public void setDate(Date date)
    {
        this.date = date;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getLastStatus()
    {
        return lastStatus;
    }

    public void setLastStatus(String lastStatus)
    {
        this.lastStatus = lastStatus;
    }

    public String getAssignedTo()
    {
        return assignedTo;
    }

    public void setAssignedTo(String assignedTo)
    {
        this.assignedTo = assignedTo;
    }

    public Date getAssignedDate()
    {
        return assignedDate;
    }

    public void setAssignedDate(Date assignedDate)
    {
        this.assignedDate = assignedDate;
    }

    public String getLastAssignedTo()
    {
        return lastAssignedTo;
    }

    public void setLastAssignedTo(String lastAssignedTo)
    {
        this.lastAssignedTo = lastAssignedTo;
    }

    public Date getLastAssignedDate()
    {
        return lastAssignedDate;
    }

    public void setLastAssignedDate(Date lastAssignedDate)
    {
        this.lastAssignedDate = lastAssignedDate;
    }

    @Override
    public String toString()
    {
        return "TaskLog [task=" + task + ", consumed=" + consumed + ", surplus="
                + surplus + ", content=" + content + ", date=" + date
                + ", status=" + status + ", lastStatus=" + lastStatus
                + ", assignedTo=" + assignedTo + ", assignedDate="
                + assignedDate + ", lastAssignedTo=" + lastAssignedTo
                + ", lastAssignedDate=" + lastAssignedDate + "]";
    }
	
    
}