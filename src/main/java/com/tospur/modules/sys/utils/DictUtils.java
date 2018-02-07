/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.sys.utils;

import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.tospur.common.utils.CacheUtils;
import com.tospur.common.utils.SpringContextHolder;
import com.tospur.modules.basetest.dao.BaseTestDao;
import com.tospur.modules.customer.entity.Customer;
import com.tospur.modules.customer.service.CustomerService;
import com.tospur.modules.product.dao.ProductDao;
import com.tospur.modules.product.entity.Edition;
import com.tospur.modules.product.entity.Iterater;
import com.tospur.modules.product.entity.Product;
import com.tospur.modules.product.service.EditionService;
import com.tospur.modules.product.service.IteraterService;
import com.tospur.modules.product.service.ProductService;
import com.tospur.modules.project.entity.Project;
import com.tospur.modules.project.service.ProjectService;
import com.tospur.modules.require.entity.Requirements;
import com.tospur.modules.require.service.RequirementsService;
import com.tospur.modules.sales.entity.SalesMan;
import com.tospur.modules.sales.service.SalesManService;
import com.tospur.modules.statistics.dao.StatisticsDao;
import com.tospur.modules.sys.dao.DictDao;
import com.tospur.modules.sys.entity.Dict;
import com.tospur.modules.sys.entity.User;
import com.tospur.modules.sys.service.SystemService;
import com.tospur.modules.task.entity.TaskInfo;
import com.tospur.modules.task.service.TaskInfoService;


/**
 * 字典工具类
 * @author jeeplus
 * @version 2013-5-29
 */
public class DictUtils {
	
	private static DictDao dictDao = SpringContextHolder.getBean(DictDao.class);
	private static SystemService systemService = SpringContextHolder.getBean(SystemService.class);

	public static final String CACHE_DICT_MAP = "dictMap";
	
	//**访问客户信息dao
	private static CustomerService customerDao = SpringContextHolder.getBean(CustomerService.class);
	
	//**项目信息dao
    private static ProjectService projectDao = SpringContextHolder.getBean(ProjectService.class);
	
    //**访问需求信息dao
    private static RequirementsService requireDao = SpringContextHolder.getBean(RequirementsService.class);

    //**访问需求信息dao
    private static SalesManService salesManDao = SpringContextHolder.getBean(SalesManService.class);
   
    //**访问迭代信息dao
    private static IteraterService iteraterDao = SpringContextHolder.getBean(IteraterService.class);

    //**访问产品信息dao
    private static ProductDao productDao = SpringContextHolder.getBean(ProductDao.class);
    private static ProductService productService = SpringContextHolder.getBean(ProductService.class);

    //**访问版本信息dao
    private static EditionService editionDao = SpringContextHolder.getBean(EditionService.class);
    //**访问任务信息dao
    private static TaskInfoService taskInfoDao = SpringContextHolder.getBean(TaskInfoService.class);
    //**访问统计dao
    private static StatisticsDao statisticsDao = SpringContextHolder.getBean(StatisticsDao.class);
    //**访问基线测试dao
    private static BaseTestDao baseTestDao = SpringContextHolder.getBean(BaseTestDao.class);
 
   


   

     /**
     *获取基线测试最大id
     */
    public static String getBaseTestId() {
        String id =baseTestDao.getBaseTestId();
        if(id==null){
            return "0";
        }else{
            return id;
        }
    }


    /**
     *获取迭代最大id
     */
    public static String getIteraterNum() {
        String id =iteraterDao.getIteraterNum();
        if(id==null){
            return "0";
        }else{
            
            return id;
        }
    }
    
    /**
     *根据产品名称获取迭代信息
     */
    public static List<Iterater>  getIteraterListByName(String name) {
        List<Iterater> list=iteraterDao.getIteraterListByName(name);
        return list;
    }
    /**
     *获取迭代信息 
     */
    public static List<Iterater> getIteraterList() {
        return iteraterDao.findList(new Iterater());
    }
     /**
     *获取任务信息 
     */
    public static List<TaskInfo> getTaskInfoList() {
        return taskInfoDao.findList(new TaskInfo());
    }
    
    /**
     *获取迭代时间 
     */
    public static List<TaskInfo> getTimeByIid(String id) {
        return   taskInfoDao.getTimeByIid(id);
               
    }
    
   
    
    /**
     *获取版本信息 
     */
    public static List<Edition> getEditionList() {
        return editionDao.findList(new Edition());
    }
    
    /**
     *根据产品ID获取版本信息 
     */
    public static List<Edition> getEditionListById(String id) {
        
                List<Edition> list =  editionDao.getEditionListById(id);
                return list;
    }
    /**
     *获取产品最大id
     */
    public static String getProductId() {
       String id =  productDao.getProductId();
        if(id==null){
            return "0";
        }else{
            return id;
        }
    }
    
    /**
     *获取产品信息 
     */
    public static List<Product> getProductList() {
        return productService.findList(new Product());
    }
    
    /**
     * 获取销售人员信息
     * @return
     */
    public static List<SalesMan> fundSalesMans(){
        return salesManDao.findList(new SalesMan());
    }
    
    /**
     * 获取用户信息
     * @return
     */
    public static List<User> fundUsers(){
        return systemService.findUserList(new User());
    }
    
    public static JSONObject indexData(){
        JSONObject data=new JSONObject();
        List<String> products=Lists.newArrayList();
        List<Map<String,Object>> coredata=Lists.newArrayList();
        List<Map<String,Object>> otherdata=Lists.newArrayList();
        List<Map<String,Object>> saleData=requireDao.indexData();
        for (Map<String,Object> map : saleData)
        {
            if(map.get("name")!=null&&(
                    map.get("name").toString().contains("X-Data")||
                    map.get("name").toString().contains("数据中心产品")||
                    map.get("name").toString().contains("平台定制化、可视定制化")
                )){  if(map.get("name").toString().contains("X-Data")){
                        map.put("selected",true);
                    }
                coredata.add(map);
            }else{
                otherdata.add(map);
            }
            products.add(map.get("name").toString());
        }
        data.put("products", products);
        data.put("otherData", otherdata);
        data.put("coreData", coredata);
        
        //查询销售人员的业绩看板
        List<Map<String,Object>> saleManData=requireDao.indexSaleData();
        
     
       
        data.put("saleManData", saleManData);
        return data;
    }
    
    
    /**
     * 获取员工信息
     * @return
     */
    public static List<Map<String, String>> fundEmployee(){
        return projectDao.fundPms();
    }
    /**
	 * 获取客户列表
	 * @return
	 */
    public static List<Customer> getCustomerList(){
        return customerDao.findAllList();
    }
    /**
     * 获取需求列表
     * @return
     */
	public static List<Requirements> getRequireList(){
        return requireDao.findAllList();
    }
	/**
	 * 获取项目信息列表
	 * @return
	 */
	public static List<Project> getProjectList(){
	    return projectDao.findAllList();
	}
	/**
	 * 根据id获取项目名称
	 * @param id
	 * @return
	 */
	public static String getProjectNameById(String id){
	    return projectDao.findUniqueByProperty("id", id).getName();
	}
	public static String getDictLabel(String value, String type, String defaultValue){
		if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(value)){
			for (Dict dict : getDictList(type)){
				if (type.equals(dict.getType()) && value.equals(dict.getValue())){
					return dict.getLabel();
				}
			}
		}
		return defaultValue;
	}
	
	public static String getDictLabels(String values, String type, String defaultValue){
		if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(values)){
			List<String> valueList = Lists.newArrayList();
			for (String value : StringUtils.split(values, ",")){
				valueList.add(getDictLabel(value, type, defaultValue));
			}
			return StringUtils.join(valueList, ",");
		}
		return defaultValue;
	}

	public static String getDictValue(String label, String type, String defaultLabel){
		if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(label)){
			for (Dict dict : getDictList(type)){
				if (type.equals(dict.getType()) && label.equals(dict.getLabel())){
					return dict.getValue();
				}
			}
		}
		return defaultLabel;
	}
	
	public static List<Dict> getDictList(String type){
		@SuppressWarnings("unchecked")
		Map<String, List<Dict>> dictMap = (Map<String, List<Dict>>)CacheUtils.get(CACHE_DICT_MAP);
		if (dictMap==null){
			dictMap = Maps.newHashMap();
			for (Dict dict : dictDao.findAllList(new Dict())){
				List<Dict> dictList = dictMap.get(dict.getType());
				if (dictList != null){
					dictList.add(dict);
				}else{
					dictMap.put(dict.getType(), Lists.newArrayList(dict));
				}
			}
			CacheUtils.put(CACHE_DICT_MAP, dictMap);
		}
		List<Dict> dictList = dictMap.get(type);
		if (dictList == null){
			dictList = Lists.newArrayList();
		}
		return dictList;
	}

	/*
	 * 反射根据对象和属性名获取属性值
	 */
	public static Object getValue(Object obj, String filed) {
		try {
			Class<? extends Object> clazz = obj.getClass();
			PropertyDescriptor pd = new PropertyDescriptor(filed, clazz);
			Method getMethod = pd.getReadMethod();//获得get方法

			if (pd != null) {

				Object o = getMethod.invoke(obj);//执行get方法返回一个Object
				return o;

			}
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (IntrospectionException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	//根据迭代名称计算总预计工时
	public static String sumEstimateByIterater(String iterater){
	    return statisticsDao.sumEstimateByIterater(iterater);
	}
	
	//根据迭代名称计算总剩余工时
	public static String sumConsumedByIterater(String iterater){
	    return statisticsDao.sumConsumedByIterater(iterater);
	}
}
