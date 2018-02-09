/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.houses.entity;

import com.tospur.common.persistence.DataEntity;

/**
 * 房型Entity
 * @author jinyin
 * @version 2018-02-01
 */
public class Houses extends DataEntity<Houses> {
	
	private static final long serialVersionUID = 1L;
	private Integer price;		// 房价
	private String type;		// 房子类型
	private String area;		// 面积
	private Integer num;		// 总数量
	private String cases;       // 所属案场
	private Integer spare;      //剩余数量
	
	public Houses() {
		super();
	}

	public Houses(String id){
		super(id);
	}

    public Integer getPrice()
    {
        return price;
    }

    public void setPrice(Integer price)
    {
        this.price = price;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public String getArea()
    {
        return area;
    }

    public void setArea(String area)
    {
        this.area = area;
    }

    public Integer getNum()
    {
        return num;
    }

    public void setNum(Integer num)
    {
        this.num = num;
    }

    public String getCases()
    {
        return cases;
    }

    public void setCases(String cases)
    {
        this.cases = cases;
    }

    public Integer getSpare()
    {
        return spare;
    }

    public void setSpare(Integer spare)
    {
        this.spare = spare;
    }

	
}