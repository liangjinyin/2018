package com.tospur.modules.partner.entity;


import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.tospur.common.persistence.DataEntity;
import com.tospur.common.utils.excel.annotation.ExcelField;

/**
 * 合作伙伴信息Entity
 * @author kiss
 * @version 2017-02-24
 */
public class Partner extends DataEntity<Partner> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 合作伙伴名称
	private String company;		// 公司简介
	private Date signingTime;		// 签约时间
	private String project;		// 合作项目
	private String contacts;		// 联系人
	private String phone;		// 联系人电话
	
	public Partner() {
		super();
	}

	public Partner(String id){
		super(id);
	}

	//(min=1, max=64, message="合作伙伴名称长度必须介于 1 和 64 之间")
	@ExcelField(title="合作伙伴名称", align=2, sort=1)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	//(min=1, max=5000, message="公司简介长度必须介于 1 和 5000 之间")
	@ExcelField(title="公司简介", align=2, sort=2)
	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="签约时间", align=2, sort=3)
	public Date getSigningTime() {
		return signingTime;
	}

	public void setSigningTime(Date signingTime) {
		this.signingTime = signingTime;
	}
	
	//(min=1, max=500, message="合作项目长度必须介于 1 和 500 之间")
	@ExcelField(title="合作项目", align=2, sort=4)
	public String getProject() {
		return project;
	}

	public void setProject(String project) {
		this.project = project;
	}
	
	//(min=0, max=64, message="联系人长度必须介于 0 和 64 之间")
	@ExcelField(title="联系人", align=2, sort=5)
	public String getContacts() {
		return contacts;
	}

	public void setContacts(String contacts) {
		this.contacts = contacts;
	}
	
	//(min=0, max=11, message="联系人电话长度必须介于 0 和 11 之间")
	@ExcelField(title="联系人电话", align=2, sort=6)
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

    @Override
    public String toString()
    {
        return "Partner [name=" + name + ", company=" + company
                + ", signingTime=" + signingTime + ", project=" + project
                + ", contacts=" + contacts + ", phone=" + phone + "]";
    }
	
	
}