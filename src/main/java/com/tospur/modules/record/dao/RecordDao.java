package com.tospur.modules.record.dao;

import org.apache.ibatis.annotations.Param;

import com.tospur.common.persistence.CrudDao;
import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.houses.entity.Houses;
import com.tospur.modules.record.entity.Record;

/**
 * 项目信息DAO接口
 * @author kiss
 * @version 2017-02-14
 */
@MyBatisDao
public interface RecordDao extends CrudDao<Record>{

   
    public Houses getHousesByCasesAndHouses(@Param("cases")String cases, @Param("houses")String houses);
    /**
     * 保存成交记录
     * @param temp
     */
    public void saveRecord(Record temp);
    
  
    
}