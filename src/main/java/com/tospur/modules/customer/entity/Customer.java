package com.tospur.modules.customer.entity;

import com.tospur.common.persistence.DataEntity;
import com.tospur.common.utils.excel.annotation.ExcelField;

/**
 * 客户信息Entity
 * @author kiss
 * @version 2017-02-14
 */
public class Customer extends DataEntity<Customer> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 客户名称
	private String way;		// 来源方式
	private String address;		// 客户地址
	private String industry;		// 所属行业
	private String contacts;		// 联系人
	private String phone;		// 联系人电话
	private String url;		// 公司网址/个人网站
	private String status; //客户状态 1:潜在客户, 2:正在跟进客户, 3:已成交客户
	private String projectBelong;//项目所属楼盘；
	private String target;//目标户型
	private String houses;//所属楼盘
	
	public Customer() {
		super();
	}

	public Customer(String id){
		super(id);
	}

	
	
	
	@ExcelField(title="客户所属区域", align=2, sort=9)
	public String getProjectBelong()
    {
        return projectBelong;
    }

    public void setProjectBelong(String projectBelong)
    {
        this.projectBelong = projectBelong;
    }

    @ExcelField(title="客户状态", align=2, sort=8)
	public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    //(min=0, max=64, message="客户名称长度必须介于 0 和 64 之间")
	@ExcelField(title="客户名称", align=2, sort=1)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	//(min=0, max=64, message="来源方式长度必须介于 0 和 64 之间")
	@ExcelField(title="来源方式", dictType="way", align=2, sort=2)
	public String getWay() {
		return way;
	}

	public void setWay(String way) {
		this.way = way;
	}
	
	//(min=0, max=64, message="客户地址长度必须介于 0 和 64 之间")
	@ExcelField(title="客户地址", align=2, sort=3)
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	//(min=0, max=64, message="所属行业长度必须介于 0 和 64 之间")
	@ExcelField(title="所属行业", align=2, sort=4)
	public String getIndustry() {
		return industry;
	}

	public void setIndustry(String industry) {
		this.industry = industry;
	}
	
	//(min=0, max=64, message="联系人长度必须介于 0 和 11 之间")
	@ExcelField(title="联系人", align=2, sort=5)
	public String getContacts() {
		return contacts;
	}

	public void setContacts(String contacts) {
		this.contacts = contacts;
	}
	
	//(min=0, max=64, message="联系人电话长度必须介于 0 和 11 之间")
	@ExcelField(title="联系人电话", align=2, sort=6)
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	//(min=0, max=500, message="公司网址/个人网站长度必须介于 0 和 500 之间")
	@ExcelField(title="公司网址/个人网站", align=2, sort=7)
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

    @Override
    public String toString()
    {
        return "Customer [name=" + name + ", way=" + way + ", address="
                + address + ", industry=" + industry + ", contacts=" + contacts
                + ", phone=" + phone + ", url=" + url + ", status=" + status
                + ", projectBelong=" + projectBelong + "]";
    }

    public String getTarget()
    {
        return target;
    }

    public void setTarget(String target)
    {
        this.target = target;
    }

    public String getHouses()
    {
        return houses;
    }

    public void setHouses(String houses)
    {
        this.houses = houses;
    }

    
    
}