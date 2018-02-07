package com.tospur.modules.record.entity;

import com.tospur.common.persistence.DataEntity;

public class Record extends DataEntity<Record>
{
    
    /**
     * 销售记录
     */
    private static final long serialVersionUID = 1L;
    
    private String customer;
    private String price;
    private String cases;
    private String houses;
    private String saleMan;
    
    public String getPrice()
    {
        return price;
    }
    
    public void setPrice(String price)
    {
        this.price = price;
    }

    public String getCases()
    {
        return cases;
    }

    public void setCases(String cases)
    {
        this.cases = cases;
    }

    public String getHouses()
    {
        return houses;
    }

    public void setHouses(String houses)
    {
        this.houses = houses;
    }

    public String getSaleMan()
    {
        return saleMan;
    }

    public void setSaleMan(String saleMan)
    {
        this.saleMan = saleMan;
    }

    public String getCustomer()
    {
        return customer;
    }

    public void setCustomer(String customer)
    {
        this.customer = customer;
    }
    
    
}
