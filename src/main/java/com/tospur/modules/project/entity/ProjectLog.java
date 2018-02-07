package com.tospur.modules.project.entity;


import java.util.Date;

import com.tospur.common.persistence.DataEntity;
import com.tospur.common.utils.excel.annotation.ExcelField;

/**
 * 项目动态Entity
 * @author kiss
 * @version 2017-02-14
 */
public class ProjectLog extends DataEntity<ProjectLog> {
	
	private static final long serialVersionUID = 1L;
	private String project;		// 项目id
	private String projectStatus;		// 项目动态
	private String theme;//会议主题
	private String summary;//会议纪要
	private Date followDate;//跟进时间
	
	public String getSummary()
    {
        return summary;
    }

    public void setSummary(String summary)
    {
        this.summary = summary;
    }

    public String getTheme()
    {
        return theme;
    }

    public void setTheme(String theme)
    {
        this.theme = theme;
    }

    public ProjectLog() {
		super();
	}

	public ProjectLog(String id){
		super(id);
	}

	//(min=1, max=64, message="项目id长度必须介于 1 和 64 之间")
	@ExcelField(title="项目id", align=2, sort=1)
	public String getProject() {
		return project;
	}

	public void setProject(String project) {
		this.project = project;
	}
	
	//(min=1, max=500, message="项目动态长度必须介于 1 和 500 之间")
	@ExcelField(title="项目动态", align=2, sort=2)
	public String getProjectStatus() {
		return projectStatus;
	}

	public void setProjectStatus(String projectStatus) {
		this.projectStatus = projectStatus;
	}

    public Date getFollowDate()
    {
        return followDate;
    }

    public void setFollowDate(Date followDate)
    {
        this.followDate = followDate;
    }

    @Override
    public String toString()
    {
        return "ProjectLog [project=" + project + ", projectStatus="
                + projectStatus + ", theme=" + theme + ", summary=" + summary
                + ", followDate=" + followDate + "]";
    }
	
	
}