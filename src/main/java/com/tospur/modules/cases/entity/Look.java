package com.tospur.modules.cases.entity;

import java.io.Serializable;

public class Look implements Serializable
{

    /**
     * 案场看板
     */
    private static final long serialVersionUID = 1L;
    
    private String casesName;
    private String sold;
    private String spare;
    private String price;
    private String coun;
    
    public String getCasesName()
    {
        return casesName;
    }
    public void setCasesName(String casesName)
    {
        this.casesName = casesName;
    }
    public String getSold()
    {
        return sold;
    }
    public void setSold(String sold)
    {
        this.sold = sold;
    }
    public String getSpare()
    {
        return spare;
    }
    public void setSpare(String spare)
    {
        this.spare = spare;
    }
    
    public String getPrice()
    {
        return price;
    }
    public void setPrice(String price)
    {
        this.price = price;
    }
    public String getCoun()
    {
        return coun;
    }
    public void setCoun(String coun)
    {
        this.coun = coun;
    }
    
    
    
}
