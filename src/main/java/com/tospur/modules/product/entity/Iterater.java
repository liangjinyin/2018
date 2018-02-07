/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.product.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.tospur.common.persistence.DataEntity;
import com.tospur.common.utils.excel.annotation.ExcelField;


/**
 * 迭代信息Entity
 * @author jinyin
 * @version 2017-08-30
 */
public class Iterater extends DataEntity<Iterater> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 迭代名称
	private Date beginTime;		// 起始日期
	private Date endTime;		// 起始日期
	private String times;		// 可用时间
	private String type;		// 迭代类型
	private String product;		// 关联产品
	private String describe;		// 迭代描述
	private String teamMan;		// 团队成员
	
	public Iterater() {
		super();
	}

	public Iterater(String id){
		super(id);
	}

	@Length(min=0, max=64, message="迭代名称长度必须介于 0 和 64 之间")
	@ExcelField(title="迭代名称", align=2, sort=1)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="起始日期", align=2, sort=2)
	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="起始日期", align=2, sort=3)
	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
	@Length(min=0, max=64, message="可用时间长度必须介于 0 和 64 之间")
	@ExcelField(title="可用时间", align=2, sort=4)
	public String getTimes() {
		return times;
	}

	public void setTimes(String times) {
		this.times = times;
	}
	
	@Length(min=0, max=64, message="迭代类型长度必须介于 0 和 64 之间")
	@ExcelField(title="迭代类型", dictType="iter_type", align=2, sort=5)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=0, max=64, message="关联产品长度必须介于 0 和 64 之间")
	@ExcelField(title="关联产品", align=2, sort=6)
	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}
	
	@Length(min=0, max=1024, message="迭代描述长度必须介于 0 和 1024 之间")
	@ExcelField(title="迭代描述", align=2, sort=7)
	public String getDescribe() {
		return describe;
	}

	public void setDescribe(String describe) {
		this.describe = describe;
	}
	
	@Length(min=0, max=64, message="团队成员长度必须介于 0 和 64 之间")
	@ExcelField(title="团队成员", dictType="", align=2, sort=8)
	public String getTeamMan() {
		return teamMan;
	}

	public void setTeamMan(String teamMan) {
		this.teamMan = teamMan;
	}

    @Override
    public String toString()
    {
        return "Iterater [name=" + name + ", beginTime=" + beginTime
                + ", endTime=" + endTime + ", times=" + times + ", type=" + type
                + ", product=" + product + ", describe=" + describe
                + ", teamMan=" + teamMan + "]";
    }
	
	
}