/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.modules.product.dao.EditionDao;
import com.tospur.modules.product.entity.Edition;


/**
 * 版本信息Service
 * @author jinyin
 * @version 2017-08-31
 */
@Service
@Transactional(readOnly = true)
public class EditionService extends CrudService<EditionDao, Edition> {

    @Autowired
    private EditionDao editionDao;
    
	public Edition get(String id) {
		return super.get(id);
	}
	
	public List<Edition> findList(Edition edition) {
		return super.findList(edition);
	}
	
	public Page<Edition> findPage(Page<Edition> page, Edition edition) {
		return super.findPage(page, edition);
	}
	
	@Transactional(readOnly = false)
	public void save(Edition edition) {
		super.save(edition);
	}
	
	@Transactional(readOnly = false)
	public void delete(Edition edition) {
		super.delete(edition);
	}

    public List<Edition> getEdition(String pid)
    {
        return editionDao.getEditionListById(pid);
    }
	
    public List<Edition> getEditionListById(String id){
        return dao.getEditionListById(id);
    }
	
	
}