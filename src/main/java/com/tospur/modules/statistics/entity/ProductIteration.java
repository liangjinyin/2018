package com.tospur.modules.statistics.entity;

import java.io.Serializable;
import java.util.List;

import com.tospur.common.persistence.DataEntity;
import com.tospur.modules.product.entity.Iterater;

/**
 * 产品迭代统计Entity
 * @author xieguofu
 *
 */
public class ProductIteration extends DataEntity<ProductIteration> implements Serializable
{
    private static final long serialVersionUID = 1L;
    private String product; // 产品名称
    private String proManager; // 产品负责人
    private List<Iterater> iteraters; // 迭代列表
    public String getProduct()
    {
        return product;
    }
    public void setProduct(String product)
    {
        this.product = product;
    }
    public String getProManager()
    {
        return proManager;
    }
    public void setProManager(String proManager)
    {
        this.proManager = proManager;
    }
    public List<Iterater> getIteraters()
    {
        return iteraters;
    }
    public void setIteraters(List<Iterater> iteraters)
    {
        this.iteraters = iteraters;
    }
}
