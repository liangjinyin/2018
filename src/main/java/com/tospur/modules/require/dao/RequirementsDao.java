package com.tospur.modules.require.dao;


import java.util.List;
import java.util.Map;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.require.entity.Requirements;

/**
 * 需求信息DAO接口
 * @author kiss
 * @version 2017-02-14
 */
@MyBatisDao
public interface RequirementsDao extends CrudDao<Requirements> {
    public List<Map<String,Object>> indexData();
    public List<Map<String,Object>> indexSaleData();
    
}