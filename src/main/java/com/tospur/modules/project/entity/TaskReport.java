package com.tospur.modules.project.entity;


import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.tospur.common.persistence.DataEntity;
import com.tospur.common.utils.DateUtils;
import com.tospur.common.utils.excel.annotation.ExcelField;


/**
 * 任务日报Entity
 * @author kiss
 * @version 2017-05-19
 */
public class TaskReport extends DataEntity<TaskReport> {
	
	private static final long serialVersionUID = 1L;
	private String assignedto;		// 负责人
	private String projectname;		// 项目名称
	private String project;		// 项目id
	private String taskname;		// 任务名称
	private String desc;		// 描述
	private String tasktype;		// 任务类型
	private String status;		// 状态
	private String procesed;		// 进度
	private Date eststarted;		// 开始时间
	private Date deadline;		// 截止时间
	private String openedby;		// 创建者
	private Double estimate;		// 估计时间（小时）
	private Double consumed;		// 耗费时间（小时）
	private Double left;		// 剩余时间（小时）
	private Date realstarted;		// 开始键建
	private Date finisheddate;		// 完成时间
	private String finishedby;		// 完成人
	private String tableName;
	
	public String getTableName()
    {
	    String date=DateUtils.getDate("yyyyMMdd",finisheddate);
	    tableName="task_report_"+date;
        return tableName;
    }
    public void setTableName(String tableName)
    {
        String date=DateUtils.getDate("yyyyMMdd",finisheddate);
        tableName="task_report_"+date;
        this.tableName = tableName;
    }

    public TaskReport() {
		super();
	}

	public TaskReport(String id){
		super(id);
	}

	@Length(min=0, max=30, message="负责人长度必须介于 0 和 30 之间")
	@ExcelField(title="负责人", dictType="", align=2, sort=0)
	public String getAssignedto() {
		return assignedto;
	}

	public void setAssignedto(String assignedto) {
		this.assignedto = assignedto;
	}
	
	@Length(min=0, max=90, message="项目名称长度必须介于 0 和 90 之间")
	@ExcelField(title="项目名称", align=2, sort=1)
	public String getProjectname() {
		return projectname;
	}

	public void setProjectname(String projectname) {
		this.projectname = projectname;
	}
	
	@Length(min=0, max=8, message="项目id长度必须介于 0 和 8 之间")
	@ExcelField(title="项目id", align=2, sort=3)
	public String getProject() {
		return project;
	}

	public void setProject(String project) {
		this.project = project;
	}
	
	@Length(min=0, max=255, message="任务名称长度必须介于 0 和 255 之间")
	@ExcelField(title="任务名称", align=2, sort=4)
	public String getTaskname() {
		return taskname;
	}

	public void setTaskname(String taskname) {
		this.taskname = taskname;
	}
	
	@ExcelField(title="描述", align=2, sort=5)
	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}
	
	@Length(min=0, max=3, message="任务类型长度必须介于 0 和 3 之间")
	@ExcelField(title="任务类型", align=2, sort=6)
	public String getTasktype() {
		return tasktype;
	}

	public void setTasktype(String tasktype) {
		this.tasktype = tasktype;
	}
	
	@Length(min=0, max=4, message="状态长度必须介于 0 和 4 之间")
	@ExcelField(title="状态", align=2, sort=7)
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Length(min=0, max=20, message="进度长度必须介于 0 和 20 之间")
	@ExcelField(title="进度", align=2, sort=8)
	public String getProcesed() {
		return procesed;
	}

	public void setProcesed(String procesed) {
		this.procesed = procesed;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="开始时间", align=2, sort=9)
	public Date getEststarted() {
		return eststarted;
	}

	public void setEststarted(Date eststarted) {
		this.eststarted = eststarted;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="截止时间", align=2, sort=10)
	public Date getDeadline() {
		return deadline;
	}

	public void setDeadline(Date deadline) {
		this.deadline = deadline;
	}
	
	@Length(min=0, max=30, message="创建者长度必须介于 0 和 30 之间")
	@ExcelField(title="创建者", align=2, sort=11)
	public String getOpenedby() {
		return openedby;
	}

	public void setOpenedby(String openedby) {
		this.openedby = openedby;
	}
	
	@ExcelField(title="估计时间（小时）", align=2, sort=12)
	public Double getEstimate() {
		return estimate;
	}

	public void setEstimate(Double estimate) {
		this.estimate = estimate;
	}
	
	@ExcelField(title="耗费时间（小时）", align=2, sort=13)
	public Double getConsumed() {
		return consumed;
	}

	public void setConsumed(Double consumed) {
		this.consumed = consumed;
	}
	
	@ExcelField(title="剩余时间（小时）", align=2, sort=14)
	public Double getLeft() {
		return left;
	}

	public void setLeft(Double left) {
		this.left = left;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="开始键建", align=2, sort=15)
	public Date getRealstarted() {
		return realstarted;
	}

	public void setRealstarted(Date realstarted) {
		this.realstarted = realstarted;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="完成时间", align=2, sort=16)
	public Date getFinisheddate() {
		return finisheddate;
	}

	public void setFinisheddate(Date finisheddate) {
		this.finisheddate = finisheddate;
	}
	
	@Length(min=0, max=30, message="完成人长度必须介于 0 和 30 之间")
	@ExcelField(title="完成人", align=2, sort=17)
	public String getFinishedby() {
		return finishedby;
	}

	public void setFinishedby(String finishedby) {
		this.finishedby = finishedby;
	}
	
}