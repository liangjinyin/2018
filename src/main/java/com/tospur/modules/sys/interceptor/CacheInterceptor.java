package com.tospur.modules.sys.interceptor;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component; 
import org.apache.log4j.Logger;
@Component
@Aspect  
public class CacheInterceptor {  
    private static final Logger log = Logger.getLogger(CacheInterceptor.class);
  
    @Pointcut("execution(* com.tospur.modules.*.service.*.*(..)) "
            + "&& !execution(* com.tospur.modules.statistics.service.*.*(..))"
            + "&& !execution(* com.tospur.modules.sys.service.*.*(..))")  
    public void pointcut(){};  
      
   /* @Around("pointcut()")  
    public Object aroundHandle(ProceedingJoinPoint  pjp) throws Throwable{  
        
        log.info("---------开始执行拦截器----------");  
        CacheHander cacheHander=CacheHander.getCacheHander();  
        return cacheHander.putResultToCache(pjp);  
      
    }  */
    
}  
