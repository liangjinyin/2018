/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.meeting.entity;

import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.tospur.common.persistence.DataEntity;

import com.tospur.common.utils.excel.annotation.ExcelField;



/**
 * 会议纪要Entity
 * @author jinyin
 * @version 2017-08-08
 */
public class Meeting extends DataEntity<Meeting> {
	
	private static final long serialVersionUID = 1L;
	private String theme;		// 会议主题
	private String caller;		// 召集人
	private String address;		// 会议地址
	private String recorder;		// 记录人
	private String purpose;		// 会议目的
	private String attender;		// 出席者
	private String absentee;		// 缺席者
	private String content;		// 会议内容
	private Date beginTime;		// 会议开始时间
	private String mainEmail;   //主送人
	private String addEmail;	//抄送人
	private Integer status;
	private String meetingTime;
	
	public Meeting() {
		super();
	}

	public Meeting(String id){
		super(id);
	}

	
	
	public String getMeetingTime()
    {
        return meetingTime;
    }

    public void setMeetingTime(String meetingTime)
    {
        this.meetingTime = meetingTime ;
    }

    public String getMainEmail() {
		return mainEmail;
	}

	public void setMainEmail(String mainEmail) {
		this.mainEmail = mainEmail;
	}

	public String getAddEmail() {
		return addEmail;
	}

	public void setAddEmail(String addEmail) {
		this.addEmail = addEmail;
	}
	
	

	public Integer getStatus()
    {
        return status;
    }

    public void setStatus(Integer status)
    {
        this.status = status;
    }

    @Length(min=1, max=64, message="会议主题长度必须介于 1 和 64 之间")
	@ExcelField(title="会议主题", align=2, sort=7)
	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}
	@Length(min=1, max=64, message="召集人长度必须介于 1 和 64 之间")
	@ExcelField(title="召集人", align=2, sort=8)
	public String getCaller() {
		return caller;
	}

	public void setCaller(String caller) {
		this.caller = caller;
	}
	
	@Length(min=1, max=64, message="会议地址长度必须介于 1 和 64 之间")
	@ExcelField(title="会议地址", align=2, sort=9)
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	@NotNull(message="记录人不能为空")
	@Length(min=1, max=64, message="记录人长度必须介于 1 和 64 之间")
	@ExcelField(title="记录人", align=2, sort=10)
	public String getRecorder() {
		return recorder;
	}

	public void setRecorder(String recorder) {
		this.recorder = recorder;
	}
	@NotNull(message="会议目的不能为空")
	@Length(min=1, max=255, message="会议目的长度必须介于 1 和 255 之间")
	@ExcelField(title="会议目的", align=2, sort=11)
	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	
	@Length(min=1, max=64, message="出席者长度必须介于 1 和 64 之间")
	@ExcelField(title="出席者", align=2, sort=12)
	public String getAttender() {
		return attender;
	}

	public void setAttender(String attender) {
		this.attender = attender;
	}
	
	@Length(min=0, max=64, message="缺席者长度必须介于 0 和 64 之间")
	@ExcelField(title="缺席者", align=2, sort=13)
	public String getAbsentee() {
		return absentee;
	}

	public void setAbsentee(String absentee) {
		this.absentee = absentee;
	}
	
	@Length(min=1, max=255, message="会议内容长度必须介于 1 和 255 之间")
	@ExcelField(title="会议内容", align=2, sort=14)
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="会议开始时间不能为空")
	@ExcelField(title="会议开始时间", align=2, sort=15)
	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

    @Override
    public String toString()
    {
        return "Meeting [theme=" + theme + ", caller=" + caller + ", address="
                + address + ", recorder=" + recorder + ", purpose=" + purpose
                + ", attender=" + attender + ", absentee=" + absentee
                + ", content=" + content + ", beginTime=" + beginTime
                + ", mainEmail=" + mainEmail + ", addEmail=" + addEmail
                + ", status=" + status + ", meetingTime=" + meetingTime + "]";
    }
	
}