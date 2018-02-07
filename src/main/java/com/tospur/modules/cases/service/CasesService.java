/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.cases.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.modules.cases.dao.CasesDao;
import com.tospur.modules.cases.entity.Cases;

/**
 * 案场Service
 * @author jinyin
 * @version 2018-01-29
 */
@Service
@Transactional(readOnly = true)
public class CasesService extends CrudService<CasesDao, Cases> {

    @Autowired
    private CasesDao casesDao;
    
	public Cases get(String id) {
		return super.get(id);
	}
	
	public List<Cases> findList(Cases cases) {
		return super.findList(cases);
	}
	
	public Page<Cases> findPage(Page<Cases> page, Cases cases) {
		return super.findPage(page, cases);
	}
	
	@Transactional(readOnly = false)
	public void save(Cases cases) {
		super.save(cases);
	}
	
	@Transactional(readOnly = false)
	public void delete(Cases cases) {
		super.delete(cases);
	}

    public List<Cases> getAllCasesList()
    {
        return casesDao.findAllList();
    }
	
	
	
	
}