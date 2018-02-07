/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.sales.entity;

import javax.validation.constraints.NotNull;

import com.tospur.common.persistence.DataEntity;
import com.tospur.common.utils.excel.annotation.ExcelField;

/**
 * salesEntity
 * @author kiss
 * @version 2017-07-05
 */
public class SalesMan extends DataEntity<SalesMan> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 销售人名
	private Double salesTarget;		// 销售指标
	private String area;		// 所属区域
	private String phone;		// 联系人电话
	
	public SalesMan() {
		super();
	}

	public SalesMan(String id){
		super(id);
	}

	////@Length(min=1, max=64, message="销售人名长度必须介于 1 和 64 之间")
	@ExcelField(title="销售人名", align=2, sort=1)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@NotNull(message="销售指标不能为空")
	@ExcelField(title="销售指标", align=2, sort=2)
	public Double getSalesTarget() {
		return salesTarget;
	}

	public void setSalesTarget(Double salesTarget) {
		this.salesTarget = salesTarget;
	}
	
	//@Length(min=0, max=500, message="所属区域长度必须介于 0 和 500 之间")
	@ExcelField(title="所属区域", align=2, sort=3)
	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}
	
	//@Length(min=0, max=64, message="联系人电话长度必须介于 0 和 64 之间")
	@ExcelField(title="联系人电话", align=2, sort=4)
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

    @Override
    public String toString()
    {
        return "SalesMan [name=" + name + ", salesTarget=" + salesTarget
                + ", area=" + area + ", phone=" + phone + "]";
    }
	
	
}