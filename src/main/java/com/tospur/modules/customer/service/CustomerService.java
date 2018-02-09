package com.tospur.modules.customer.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.modules.customer.dao.CustomerDao;
import com.tospur.modules.customer.entity.Customer;
import com.tospur.modules.houses.dao.HousesDao;
import com.tospur.modules.houses.entity.Houses;
import com.tospur.modules.record.dao.RecordDao;
import com.tospur.modules.record.entity.Record;

/**
 * 客户信息Service
 * @author kiss
 * @version 2017-02-14
 */
@Service
@Transactional(readOnly = true)
public class CustomerService extends CrudService<CustomerDao, Customer> {

    @Autowired
    private RecordDao recordDao;
    
    @Autowired
    private HousesDao housesDao;
    
	public Customer get(String id, String op) {
		return super.get(id);
	}
	
	public List<Customer> findList(Customer customer) {
		return super.findList(customer);
	}
	
	
	public List<Customer> findAllList(){
	    return dao.findAllList();
	}
	
	public Page<Customer> findPage(Page<Customer> page, Customer customer) {
		return super.findPage(page, customer);
	}
	
	@Transactional(readOnly = false)
	public void save(Customer customer) {
		if(customer.getStatus().equals("已成交客户")&&customer.getDelFlag().equals("0")){
		    Houses houses = recordDao.getHousesByCasesAndHouses(customer.getHouses(),customer.getTarget());
		    Record temp = new Record();
		    temp.setCases(customer.getHouses());
		    temp.setHouses(customer.getTarget());
		    temp.setSaleMan(customer.getCreateBy().getName());
		    temp.setPrice(houses.getPrice());
		    temp.setCustomer(customer.getName());
		    
		    customer.setDelFlag("1");//标识添加过交易记录
		    
		    houses.setSpare(houses.getSpare()-1);
		    housesDao.update(houses);
		    recordDao.saveRecord(temp);
		}else{
		    customer.setDelFlag("0");
		}
		super.save(customer);
	}
	
	@Transactional(readOnly = false)
	public void delete(Customer customer) {
		super.delete(customer);
	}
	
}