/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.sales.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.modules.sales.dao.SalesManDao;
import com.tospur.modules.sales.entity.SalesMan;

/**
 * salesService
 * @author kiss
 * @version 2017-07-05
 */
@Service
@Transactional(readOnly = true)
public class SalesManService extends CrudService<SalesManDao, SalesMan> {

	public SalesMan get(String id) {
		return super.get(id);
	}
	
	public List<SalesMan> findList(SalesMan salesMan) {
		return super.findList(salesMan);
	}
	
	public Page<SalesMan> findPage(Page<SalesMan> page, SalesMan salesMan) {
		return super.findPage(page, salesMan);
	}
	
	@Transactional(readOnly = false)
	public void save(SalesMan salesMan) {
		super.save(salesMan);
	}
	
	@Transactional(readOnly = false)
	public void delete(SalesMan salesMan) {
		super.delete(salesMan);
	}
	
}