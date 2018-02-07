/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.task.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.tospur.common.persistence.DataEntity;
import com.tospur.common.utils.excel.annotation.ExcelField;



/**
 * 任务信息Entity
 * @author xieguofu
 * @version 2017-08-30
 */
public class TaskInfo extends DataEntity<TaskInfo> {
	
	private static final long serialVersionUID = 1L;
	private Integer iteration;		// 所属迭代
	private String module;		// 所属模块
	private String requirement;		// 相关需求
	private String name;		// 任务名称
	private String description;		// 任务描述
	private String type;		// 任务类型
	private Integer pri;		// 优先级
	private String status;		// 状态
	private Double estimate;		// 预计时长
	private Double consumed;		// 消耗时长
	private Double surplus;		// 剩余时长
	private Date deadline;		// 截止日期
	private String openedBy;		// 开始者
	private Date openedDate;		// 开始时间
	private String assignedTo;		// 指派给
	private Date assignedDate;		// 指派时间
	private Date estStarted;		// 预期开始时间
	private Date realStarted;		// 实际开始时间
	private String finishedBy;		// 结束者
	private Date finishedDate;		// 结束日期
	private String canceledBy;		// 取消者
	private Date canceledDate;		// 取消日期
	private String closedBy;		// 关闭者
	private Date closedDate;		// 关闭日期
	private String closedReason;		// 关闭原因
	private String remarks;          //备注
	
	public TaskInfo() {
		super();
	}

	public TaskInfo(String id){
		super(id);
	}

	@ExcelField(title="所属迭代", dictType="", sort=1)
	public Integer getIteration() {
		return iteration;
	}

	public void setIteration(Integer iteration) {
		this.iteration = iteration;
	}
	
	@Length(min=0, max=64, message="所属模块长度必须介于 0 和 64 之间")
	@ExcelField(title="所属模块", align=2, sort=2)
	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}
	
	@Length(min=0, max=64, message="相关需求长度必须介于 0 和 64 之间")
	@ExcelField(title="相关需求", align=2, sort=3)
	public String getRequirement() {
		return requirement;
	}

	public void setRequirement(String requirement) {
		this.requirement = requirement;
	}
	
	@Length(min=1, max=255, message="任务名称长度必须介于 1 和 255 之间")
	@ExcelField(title="任务名称", align=2, sort=4)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@ExcelField(title="任务描述", align=2, sort=5)
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Length(min=0, max=64, message="任务类型长度必须介于 0 和 64 之间")
	@ExcelField(title="任务类型", align=2, sort=6)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@ExcelField(title="优先级", sort=7)
	public Integer getPri() {
		return pri;
	}

	public void setPri(Integer pri) {
		this.pri = pri;
	}
	
	@Length(min=0, max=64, message="状态长度必须介于 0 和 64 之间")
	@ExcelField(title="状态", align=2, sort=8)
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@ExcelField(title="预计时长", sort=9)
	public Double getEstimate() {
		return estimate;
	}

	public void setEstimate(Double estimate) {
		this.estimate = estimate;
	}
	
	@ExcelField(title="消耗时长", sort=10)
	public Double getConsumed() {
		return consumed;
	}

	public void setConsumed(Double consumed) {
		this.consumed = consumed;
	}
	
	@ExcelField(title="剩余时长", sort=11)
	public Double getSurplus() {
		return surplus;
	}

	public void setSurplus(Double surplus) {
		this.surplus = surplus;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="截止日期", align=2, sort=12)
	public Date getDeadline() {
		return deadline;
	}

	public void setDeadline(Date deadline) {
		this.deadline = deadline;
	}
	
	@Length(min=0, max=64, message="开始者长度必须介于 0 和 64 之间")
	@ExcelField(title="开始者", align=2, sort=13)
	public String getOpenedBy() {
		return openedBy;
	}

	public void setOpenedBy(String openedBy) {
		this.openedBy = openedBy;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="开始时间", align=2, sort=14)
	public Date getOpenedDate() {
		return openedDate;
	}

	public void setOpenedDate(Date openedDate) {
		this.openedDate = openedDate;
	}
	
	@Length(min=0, max=64, message="指派给长度必须介于 0 和 64 之间")
	@ExcelField(title="指派给", align=2, sort=15)
	public String getAssignedTo() {
		return assignedTo;
	}

	public void setAssignedTo(String assignedTo) {
		this.assignedTo = assignedTo;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="指派时间", align=2, sort=16)
	public Date getAssignedDate() {
		return assignedDate;
	}

	public void setAssignedDate(Date assignedDate) {
		this.assignedDate = assignedDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="预期开始时间", align=2, sort=17)
	public Date getEstStarted() {
		return estStarted;
	}

	public void setEstStarted(Date estStarted) {
		this.estStarted = estStarted;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="实际开始时间", align=2, sort=18)
	public Date getRealStarted() {
		return realStarted;
	}

	public void setRealStarted(Date realStarted) {
		this.realStarted = realStarted;
	}
	
	@Length(min=0, max=64, message="结束者长度必须介于 0 和 64 之间")
	@ExcelField(title="结束者", align=2, sort=19)
	public String getFinishedBy() {
		return finishedBy;
	}

	public void setFinishedBy(String finishedBy) {
		this.finishedBy = finishedBy;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="结束日期", align=2, sort=20)
	public Date getFinishedDate() {
		return finishedDate;
	}

	public void setFinishedDate(Date finishedDate) {
		this.finishedDate = finishedDate;
	}
	
	@Length(min=0, max=64, message="取消者长度必须介于 0 和 64 之间")
	@ExcelField(title="取消者", align=2, sort=21)
	public String getCanceledBy() {
		return canceledBy;
	}

	public void setCanceledBy(String canceledBy) {
		this.canceledBy = canceledBy;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="取消日期", align=2, sort=22)
	public Date getCanceledDate() {
		return canceledDate;
	}

	public void setCanceledDate(Date canceledDate) {
		this.canceledDate = canceledDate;
	}
	
	@Length(min=0, max=64, message="关闭者长度必须介于 0 和 64 之间")
	@ExcelField(title="关闭者", align=2, sort=23)
	public String getClosedBy() {
		return closedBy;
	}

	public void setClosedBy(String closedBy) {
		this.closedBy = closedBy;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="关闭日期", align=2, sort=24)
	public Date getClosedDate() {
		return closedDate;
	}

	public void setClosedDate(Date closedDate) {
		this.closedDate = closedDate;
	}
	
	@ExcelField(title="关闭原因", align=2, sort=25)
	public String getClosedReason() {
		return closedReason;
	}

	public void setClosedReason(String closedReason) {
		this.closedReason = closedReason;
	}

	@ExcelField(title="备注", align=2, sort=26)
    public String getRemarks()
    {
        return remarks;
    }

    public void setRemarks(String remarks)
    {
        this.remarks = remarks;
    }

    @Override
    public String toString()
    {
        return "TaskInfo [iteration=" + iteration + ", module=" + module
                + ", requirement=" + requirement + ", name=" + name
                + ", description=" + description + ", type=" + type + ", pri="
                + pri + ", status=" + status + ", estimate=" + estimate
                + ", consumed=" + consumed + ", surplus=" + surplus
                + ", deadline=" + deadline + ", openedBy=" + openedBy
                + ", openedDate=" + openedDate + ", assignedTo=" + assignedTo
                + ", assignedDate=" + assignedDate + ", estStarted="
                + estStarted + ", realStarted=" + realStarted + ", finishedBy="
                + finishedBy + ", finishedDate=" + finishedDate
                + ", canceledBy=" + canceledBy + ", canceledDate="
                + canceledDate + ", closedBy=" + closedBy + ", closedDate="
                + closedDate + ", closedReason=" + closedReason + ", remarks="
                + remarks + "]";
    }
	
	
}