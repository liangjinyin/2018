package com.tospur.modules.sys.interceptor;

import java.util.List;

import org.aspectj.lang.ProceedingJoinPoint;

import com.tospur.common.utils.CacheUtils;
import com.tospur.modules.sys.utils.UserUtils;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheException;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.ObjectExistsException;  
import org.apache.log4j.Logger;
public class CacheHander
{

    private CacheManager cacheManager;  
    //缓存变量  
    private Cache cache;  
      
    private static CacheHander cacheHander=new CacheHander();  
    //缓存名称  
    private final String cacheName="userCache"; 
    
    private static final Logger log = Logger.getLogger(CacheHander.class);
    
    
    /** 
     * 私有构造方法 
     */  
    private CacheHander()  
    {  
        try {  
              
            CacheManager cacheManager = CacheUtils.getCacheManager();  
            this.cacheManager=cacheManager;  
            cache=cacheManager.getCache(cacheName);  
              
            if(cache==null){  
                cache=new Cache("DATA_METHOD_CACHE", 10000, true, false, 600000, 300000);  
                cacheManager.addCache(cache);  
            }  
            
        } catch (CacheException e) {  
            e.printStackTrace();  
        }  
    }  
    
    /** 
     * 获取缓存类 
     * @returns 
     */  
    public static CacheHander getCacheHander()  
    {  
        if (cacheHander==null) {  
            cacheHander=new CacheHander();  
        }  
        return cacheHander;  
    }  
      
    public Cache addCache(String cacheName) throws IllegalStateException, ObjectExistsException, CacheException  
    {  
        Cache cache=cacheManager.getCache(cacheName);  
        if (cache==null) {  
            cache=new Cache(cacheName,10000, true, false, 1000,100);  
            cacheManager.addCache(cache);  
        }  
        return cache;  
    }  
      
    public Object putResultToCache(ProceedingJoinPoint pjp) throws Throwable  
    {  
        //原实体类名（包括包名）  
        String className=pjp.getTarget().getClass().getName();  
        //原方法名  
        String methodName=pjp.getSignature().getName();  
        //原方法实参列表  
        Object[] arguments=pjp.getArgs();  
          
        if (methodName.startsWith("index") || methodName.startsWith("find") || methodName.startsWith("get"))   
        {  
            String cacheKey=getCacheKey(className,methodName,arguments);  

            Object element = CacheUtils.get(cacheName, cacheKey);
            if (element==null) {  
                // 执行目标方法，并保存目标方法执行后的返回值  
                Object resuObject=pjp.proceed();   
                CacheUtils.put(cacheName, cacheKey, resuObject);
                log.info("将查询结果放到缓存里面key="+cacheKey);
            }else {  
                log.info("已经存在从缓存中取出来----------------");
            }  
            return CacheUtils.get(cacheName, cacheKey);
        }else if(methodName.startsWith("save") || methodName.startsWith("delete")){
            pjp.proceed();
            List keys = cache.getKeys();
            for (Object object : keys)
            {
                String key = String.valueOf(object);  
                if(key.startsWith(className)){  
                    CacheUtils.remove(cacheName, key); 
                    log.info("移除缓存=" + key);
                }
            }
            return null;
        }
        return  pjp.proceed();  
    }  
  
    private String getCacheKey(String targetName, String methodName, Object[] arguments) {  
        StringBuffer sb = new StringBuffer();  
        
        sb.append(targetName).append(".").append(methodName); 
        
        if ((arguments != null) && (arguments.length != 0)) {  
        
            for (int i = 0; i < arguments.length; i++) {  
                
                if(arguments[i] != null){
                   
                    if(arguments[i] instanceof String[]){  
                        String[] strArray = (String[])arguments[i];  
                        sb.append(".");  
                        for(String str : strArray){  
                            sb.append(str);  
                        }  
                    }else{
                        sb.append(".").append(arguments[i]);  
                    }
                    
                }
                
            } 
            
        }
        
        sb.append(".userId=").append(UserUtils.getPrincipal().getId());
        return sb.toString();  
    }  
    
    
}
