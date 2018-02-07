/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.houses.service;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.modules.houses.dao.HousesDao;
import com.tospur.modules.houses.entity.Houses;

/**
 * 房型Service
 * @author jinyin
 * @version 2018-02-01
 */
@Service
@Transactional(readOnly = true)
public class HousesService extends CrudService<HousesDao, Houses> {

    @Autowired
    private HousesDao housesDao;
    
	public Houses get(String id) {
		return super.get(id);
	}
	
	public List<Houses> findList(Houses houses) {
		return super.findList(houses);
	}
	
	public Page<Houses> findPage(Page<Houses> page, Houses houses) {
		return super.findPage(page, houses);
	}
	
	@Transactional(readOnly = false)
	public void save(Houses houses) {
	    if(!StringUtils.isNotEmpty(houses.getId())){
	        houses.setSpare(houses.getNum());
	    }
		super.save(houses);
	}
	
	@Transactional(readOnly = false)
	public void delete(Houses houses) {
		super.delete(houses);
	}

    public List<Houses> getListByCasesName(String name){
      
       return housesDao.getListByCasesName(name);
    }
	
	
	
	
}