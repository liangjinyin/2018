/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.basetest.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.modules.basetest.dao.BaseTestDao;
import com.tospur.modules.basetest.entity.BaseTest;


/**
 * 基线测试Service
 * @author jinyin
 * @version 2017-09-18
 */
@Service
@Transactional(readOnly = true)
public class BaseTestService extends CrudService<BaseTestDao, BaseTest> {

	public BaseTest get(String id) {
		return super.get(id);
	}
	
	public List<BaseTest> findList(BaseTest baseTest) {
		return super.findList(baseTest);
	}
	
	public Page<BaseTest> findPage(Page<BaseTest> page, BaseTest baseTest) {
		return super.findPage(page, baseTest);
	}
	
	@Transactional(readOnly = false)
	public void save(BaseTest baseTest) {
		super.save(baseTest);
	}
	
	@Transactional(readOnly = false)
	public void delete(BaseTest baseTest) {
		super.delete(baseTest);
	}
	
	
	
	
}