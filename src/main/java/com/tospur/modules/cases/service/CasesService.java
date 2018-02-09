/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.cases.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.common.utils.TimeUtils;
import com.tospur.modules.cases.dao.CasesDao;
import com.tospur.modules.cases.dao.LookDao;
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
    
    @Autowired
    private LookDao lookDao;
    
   
    
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

    public List<Map<String,Object>> getLookList(String name, String date)
    {
        List<Map<String,Object>> list1 = lookDao.getLookList(name,date);
        Date temp = new Date();
        Calendar calendar = Calendar.getInstance();    
        calendar.setTime(temp);    
        calendar.add(Calendar.MONTH, -1);//当前时间前去一个月，即一个月前的时间    
        Date time = calendar.getTime();//获取一年前的时间，或者一个月前的时间  
        String formatDate = TimeUtils.formatDate(time, "yyyy-MM");
        List<Map<String,Object>> list2 = lookDao.getLookList(name,formatDate);
        if (list2 != null)
        {
            for (int i = 0; i < list1.size(); i++)
            {
                Object a1 = list1.get(i).get("price");
                if(list2.size()-1>=i){
                    Object a2 = list2.get(i).get("price");
                    
                    Integer x = Integer.parseInt(a1.toString());
                    Integer y = Integer.parseInt(a2.toString());
                    
                    if (x >= y)
                    {
                        list1.get(i).put("level", "up");
                    }
                    else
                    {
                        list1.get(i).put("level", "down");
                    }
                }else{
                    list1.get(i).put("level", "up");
                }
            }
        }else{
            for (int i = 0; i < list1.size(); i++)
            {
                list1.get(i).put("level", "up");
            }
        }
        return list1;
    }

    public List<String> getTeamByName(String name)
    {
       String temp =  casesDao.getTeamByName(name);
       String[] t1 = temp.split(",");
       List<String> list = new ArrayList<String>();
       for (String string : t1)
       {
          list.add(string);
       }
       return list;
    }

    public List<Map<String, Object>> getSalelist(String name, String formatDate)
    {
       
        return  lookDao.getSalelist(name,formatDate);
    }
}