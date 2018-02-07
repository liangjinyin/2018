package com.tospur.modules.niche.entity;


import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.tospur.common.persistence.DataEntity;
import com.tospur.common.utils.excel.annotation.ExcelField;

/**
 * 招标信息Entity
 * @author canyu
 * @version 2016-08-12
 */
public class InvestmentInfo extends DataEntity<InvestmentInfo> {
	
	private static final long serialVersionUID = 1L;
	private String projectType;		//项目类型
	private String url;		// 地址
	private Date time;		// 发布时间
    private Date time1;      // 发布时间
	private String content;		// 正文内容
	private String companyBelong;		// 所属公司
	private String programName;  //主键项目名称
	private int trade; //所属行业
	
	public static long getSerialversionuid()
    {
        return serialVersionUID;
    }

    private int status; //发送
	
	public InvestmentInfo() {
		super();
	}

	public InvestmentInfo(String id){
		super(id);
	}

	@ExcelField(title="项目类型", align=2, sort=1)
	public String getProjectType()
    {
        return projectType;
    }

    public String getUrl()
    {
        return url;
    }

    public void setProjectType(String projectType)
    {
        this.projectType = projectType;
    }

    public Date getTime1()
    {
        return time1;
    }

    public void setTime1(Date time1)
    {
        this.time1 = time1;
    }

    public String getCompanyBelong()
    {
        return companyBelong;
    }

    public void setCompanyBelong(String companyBelong)
    {
        this.companyBelong = companyBelong;
    }

    public String getProgramName()
    {
        return programName;
    }

    public void setProgramName(String programName)
    {
        this.programName = programName;
    }

    public int getTrade()
    {
        return trade;
    }

    public void setTrade(int trade)
    {
        this.trade = trade;
    }

    public void setUrl(String url) {
		this.url = url;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="发布时间", align=2, sort=3)
	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}
	
	@ExcelField(title="正文内容", align=2, sort=4)
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

    public int getStatus()
    {
        return status;
    }

    public void setStatus(int status)
    {
        this.status = status;
    }

    @Override
    public String toString()
    {
        return "InvestmentInfo [projectType=" + projectType + ", url=" + url
                + ", time=" + time + ", time1=" + time1 + ", content=" + content
                + ", companyBelong=" + companyBelong + ", programName="
                + programName + ", trade=" + trade + ", status=" + status + "]";
    }

    
}