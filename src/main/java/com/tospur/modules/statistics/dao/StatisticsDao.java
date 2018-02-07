/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.statistics.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.tospur.common.persistence.annotation.MyBatisDao;
import com.tospur.modules.statistics.entity.EmployeeLoad;
import com.tospur.modules.statistics.entity.ProductIteration;
import com.tospur.modules.statistics.entity.TaskCollect;

/**
 * 统计DAO接口
 * @author xieguofu
 * 
 */
@MyBatisDao
public interface StatisticsDao{

    public List<ProductIteration> findAllList(@Param(value="product") String product, @Param(value="beginTime") Date beginTime,@Param(value="endTime") Date endTime);
    
    public String sumEstimateByIterater(String iterater);
    
    public String sumConsumedByIterater(String iterater);
    
    public List<TaskCollect> findTaskCollectList(@Param(value="finishedDate") Date finishedDate);
    
    public List<EmployeeLoad> findEmployeeLoadList(@Param(value="name") String name, @Param(value="beginTime") Date beginTime, @Param(value="endTime") Date endTime);
}