package com.tospur.modules.cases.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.tospur.common.persistence.DataEntity;
import com.tospur.common.utils.excel.annotation.ExcelField;

/**
 * 案场Entity
 * @author jinyin
 * @version 2018-01-29
 */
public class Cases extends DataEntity<Cases> {
	
	private static final long serialVersionUID = 1L;
	
	private String name;		// 案场名称
	private String address;		// 案场位置
	private String company;		// 所属集团
	private String charge;     //案场负责人
	private String phone;      //负责人电话
	private Date beginTime;    // 开盘日期
    private Date endTime;      // 结束日期
    private String team;       //案场销售团队
    private Integer num;       //总数
    private Integer sale;      //指定月销售额
	
	public Cases() {
		super();
	}

	public Cases(String id){
		super(id);
	}

	@Length(min=0, max=64, message="案场名称长度必须介于 0 和 64 之间")
	@ExcelField(title="案场名称", align=2, sort=7)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=64, message="案场位置长度必须介于 0 和 64 之间")
	@ExcelField(title="案场位置", align=2, sort=8)
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	@Length(min=0, max=64, message="所属集团长度必须介于 0 和 64 之间")
	@ExcelField(title="所属集团", align=2, sort=9)
	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

    public String getCharge()
    {
        return charge;
    }

    public void setCharge(String charge)
    {
        this.charge = charge;
    }

    public String getPhone()
    {
        return phone;
    }

    public void setPhone(String phone)
    {
        this.phone = phone;
    }

    public Date getBeginTime()
    {
        return beginTime;
    }

    public void setBeginTime(Date beginTime)
    {
        this.beginTime = beginTime;
    }

    public Date getEndTime()
    {
        return endTime;
    }

    public void setEndTime(Date endTime)
    {
        this.endTime = endTime;
    }
	
	public void setTeam(String team){
        this.team = team;
    }

    public String getTeam(){
        return team;
    }

    public Integer getNum()
    {
        return num;
    }

    public void setNum(Integer num)
    {
        this.num = num;
    }

    public Integer getSale()
    {
        return sale;
    }

    public void setSale(Integer sale)
    {
        this.sale = sale;
    }
    
    
}