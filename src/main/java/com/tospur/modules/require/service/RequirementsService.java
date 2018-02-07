package com.tospur.modules.require.service;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.modules.require.dao.RequirementsDao;
import com.tospur.modules.require.entity.Requirements;

/**
 * 需求信息Service
 * @author kiss
 * @version 2017-02-14
 */
@Service
@Transactional(readOnly = true)
public class RequirementsService extends CrudService<RequirementsDao, Requirements> {

	public Requirements get(String id) {
		return super.get(id);
	}
	
	public List<Requirements> findList(Requirements requirements) {
		return super.findList(requirements);
	}
	
	@SuppressWarnings("deprecation")
	public List<Requirements> findAllList(){
	    return dao.findAllList();
	}
	
	public Page<Requirements> findPage(Page<Requirements> page, Requirements requirements) {
		return super.findPage(page, requirements);
	}
	
	@Transactional(readOnly = false)
	public void save(Requirements requirements) {
		super.save(requirements);
	}
	
	@Transactional(readOnly = false)
	public void delete(Requirements requirements) {
		super.delete(requirements);
	}
	
	public List<Map<String,Object>> indexData(){
	    return dao.indexData();
	}
	
    public List<Map<String,Object>> indexSaleData(){
        return dao.indexSaleData();
    }
	
}