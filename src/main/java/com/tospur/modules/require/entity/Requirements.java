package com.tospur.modules.require.entity;


import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.tospur.common.persistence.DataEntity;
import com.tospur.common.utils.excel.annotation.ExcelField;

/**
 * 需求信息Entity
 * @author kiss
 * @version 2017-02-14
 */
public class Requirements extends DataEntity<Requirements> {
	
	private static final long serialVersionUID = 1L;
	private String customer;		// 所属客户
	private Date getDate;		// 需求获取时间
	private Date startDate;		// 项目开始时间
	private String name;		// 需求名称
	private String type;		// 需求类型
	private String product;		// 对应产品
	private String situation;		// 现状
	private String bottleneck;		// 瓶颈
	private String core;		// 核心需求
	private String solution;		// 解决方案
	private String project;		// 所属项目
	private String saleManager;        // 销售负责人
    private String preSaleManager;      // 售前负责人
    private String department;      // 需求部门
	
	public Requirements() {
		super();
	}

	public Requirements(String id){
		super(id);
	}

	@ExcelField(title="所属客户", align=2, sort=1)
	public String getCustomer() {
		return customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}
	
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    //@ExcelField(title="需求获取时间", align=2, sort=2)
	public Date getGetDate() {
		return getDate;
	}

	public void setGetDate(Date getDate) {
		this.getDate = getDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	//@ExcelField(title="项目开始时间", align=2, sort=3)
	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	
	@ExcelField(title="需求名称", align=2, sort=4)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	//@ExcelField(title="需求类型", align=2, sort=5)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@ExcelField(title="产品/服务", align=2, sort=6)
	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}
	
	@ExcelField(title="现状/瓶颈", align=2, sort=7)
	public String getSituation() {
		return situation;
	}

	public void setSituation(String situation) {
		this.situation = situation;
	}

	//@ExcelField(title="瓶颈", align=2, sort=10)
	public String getBottleneck() {
		return bottleneck;
	}

	public void setBottleneck(String bottleneck) {
		this.bottleneck = bottleneck;
	}
	
	@ExcelField(title="核心需求", align=2, sort=11)
	public String getCore() {
		return core;
	}

	public void setCore(String core) {
		this.core = core;
	}
	
	@ExcelField(title="解决方案", align=2, sort=12)
	public String getSolution() {
		return solution;
	}

	public void setSolution(String solution) {
		this.solution = solution;
	}
	
	//@ExcelField(title="所属项目", align=2, sort=13)
	public String getProject() {
		return project;
	}

	public void setProject(String project) {
		this.project = project;
	}
	
    @ExcelField(title="销售负责人", align=2, sort=15)
    public String getSaleManager()
    {
        return saleManager;
    }

    public void setSaleManager(String saleManager)
    {
        this.saleManager = saleManager;
    }
    @ExcelField(title="售前负责人", align=2, sort=16)
    public String getPreSaleManager()
    {
        return preSaleManager;
    }

    public void setPreSaleManager(String preSaleManager)
    {
        this.preSaleManager = preSaleManager;
    }
    @ExcelField(title="需求部门", align=2, sort=17)
    public String getDepartment()
    {
        return department;
    }

    public void setDepartment(String department)
    {
        this.department = department;
    }

    @Override
    public String toString()
    {
        return "Requirements [customer=" + customer + ", getDate=" + getDate
                + ", startDate=" + startDate + ", name=" + name + ", type="
                + type + ", product=" + product + ", situation=" + situation
                + ", bottleneck=" + bottleneck + ", core=" + core
                + ", solution=" + solution + ", project=" + project
                + ", saleManager=" + saleManager + ", preSaleManager="
                + preSaleManager + ", department=" + department + "]";
    }
    
    
}