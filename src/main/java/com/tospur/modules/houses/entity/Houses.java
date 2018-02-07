/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.houses.entity;

import org.hibernate.validator.constraints.Length;

import com.tospur.common.persistence.DataEntity;
import com.tospur.common.utils.excel.annotation.ExcelField;

/**
 * 房型Entity
 * @author jinyin
 * @version 2018-02-01
 */
public class Houses extends DataEntity<Houses> {
	
	private static final long serialVersionUID = 1L;
	private String price;		// 房价
	private String type;		// 房子类型
	private String area;		// 面积
	private String num;		// 总数量
	private String cases;       // 所属案场
	private String spare;      //剩余数量
	
	public Houses() {
		super();
	}

	public Houses(String id){
		super(id);
	}

	@Length(min=0, max=64, message="房价长度必须介于 0 和 64 之间")
	@ExcelField(title="房价", align=2, sort=7)
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}
	
	@Length(min=0, max=64, message="房子类型长度必须介于 0 和 64 之间")
	@ExcelField(title="房子类型", align=2, sort=8)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	@Length(min=0, max=64, message="面积长度必须介于 0 和 64 之间")
	@ExcelField(title="面积", align=2, sort=9)
	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}
	
	public void setNum(String num){
		this.num = num;
	}

	public String getNum(){
		return num;
	}
	
	public void setCases(String cases){
		this.cases = cases;
	}

	public String getCases(){
		return cases;
	}

    public String getSpare()
    {
        return spare;
    }

    public void setSpare(String spare)
    {
        this.spare = spare;
    }
	
	
}