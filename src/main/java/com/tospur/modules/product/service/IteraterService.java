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
import com.tospur.modules.product.dao.IteraterDao;
import com.tospur.modules.product.entity.Iterater;


/**
 * 迭代信息Service
 * @author jinyin
 * @version 2017-08-30
 */
@Service
@Transactional(readOnly = true)
public class IteraterService extends CrudService<IteraterDao, Iterater> {

    @Autowired
    private IteraterDao iteraterDao;
	public Iterater get(String id) {
		return super.get(id);
	}
	
	public List<Iterater> findList(Iterater iterater) {
	    String dsf = super.dataScopeFilter(iterater.getCurrentUser(), "oy", "uy");
	    dsf = dsf.replace(")"," OR a.team_man  LIKE concat('%','"+iterater.getCurrentUser().getName()+"','%') )");
	    iterater.getSqlMap().put("dsf", dsf);
		return super.findList(iterater);
	}
	
	public Page<Iterater> findPage(Page<Iterater> page, Iterater iterater) {
		return super.findPage(page, iterater);
	}
	
	@Transactional(readOnly = false)
	public void save(Iterater iterater) {
		super.save(iterater);
	}
	
	@Transactional(readOnly = false)
	public void delete(Iterater iterater) {
		super.delete(iterater);
	}
	
	/**
	 * 返回迭代信息最新id
	 * @return
	 */
	 public String getIteraterNum(){
	     
	    return iteraterDao.getIteraterNum();
	 }
	 /**
	  * 根据产品名称获取迭代信息 
	  * @param name 产品名称
	  * @return
	  */
	 public List<Iterater> getIteraterListByName(String name){
	     return dao.getIteraterListByName(name);
	 }
	 /**
	  * 得到每个用户 的最新迭代id
	  * @param itera
	  * @return
	  */
	 
    public String getNew(Iterater itera)
    {
        String dsf = super.dataScopeFilter(itera.getCurrentUser(), "oy", "uy");
        
      
       dsf = dsf.replace(")"," OR a.team_man  LIKE concat('%','"+itera.getCurrentUser().getName()+"','%') )");
      
        itera.getSqlMap().put("dsf", dsf);
        String s = iteraterDao.getNew(itera);
        if(s==null){
            return "0";
        }
        return s;
    }
	
}