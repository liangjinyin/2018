/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.project.entity;

import org.hibernate.validator.constraints.Length;

import com.tospur.common.persistence.DataEntity;
import com.tospur.common.utils.excel.annotation.ExcelField;

/**
 * 任务邮件Entity
 * @author xieguofu
 * @version 2017-09-13
 */
public class ProjectEmail extends DataEntity<ProjectEmail> {
	
	private static final long serialVersionUID = 1L;
	private String project;		// 归属项目
	private String receiver;		// 接收者
	private String remarks;  //备注
	
	public ProjectEmail() {
		super();
	}

	public ProjectEmail(String id){
		super(id);
	}

	@Length(min=0, max=64, message="归属项目长度必须介于 0 和 64 之间")
	@ExcelField(title="归属项目", align=2, sort=1)
	public String getProject() {
		return project;
	}

	public void setProject(String project) {
		this.project = project;
	}
	
	@Length(min=0, max=64, message="接收者长度必须介于 0 和 64 之间")
	@ExcelField(title="接收者", dictType="", align=2, sort=2)
	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	@ExcelField(title="备注", dictType="", align=2, sort=2)
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
        return "ProjectEmail [project=" + project + ", receiver=" + receiver
                + ", remarks=" + remarks + "]";
    }
	
	
	
}