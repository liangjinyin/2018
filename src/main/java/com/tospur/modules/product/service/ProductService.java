/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.product.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.modules.product.dao.ProductDao;
import com.tospur.modules.product.entity.Product;


/**
 * 产品信息Service
 * @author jinyin
 * @version 2017-08-29
 */
@Service
@Transactional(readOnly = true)
public class ProductService extends CrudService<ProductDao, Product> {

    @Autowired
    private ProductDao productDao;
    
	public Product get(String id) {
		return super.get(id);
	}
	
	public List<Product> findList(Product product) {
		return super.findList(product);
	}
	
	public Page<Product> findPage(Page<Product> page, Product product) {
		return super.findPage(page, product);
	}
	
	@Transactional(readOnly = false)
	public void save(Product product) {
		super.save(product);
	}
	
	@Transactional(readOnly = false)
	public void delete(Product product) {
		super.delete(product);
	}

    public Product getByName(String product){
       
        return productDao.getByName(product);
    }

    public List<Map<String, Object>> getProductName()
    {
       
        return productDao.getProductName();
    }
	
	
	
	
}