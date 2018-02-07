package com.tospur.modules.niche;

import java.io.DataOutputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.net.UnknownHostException;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import javax.annotation.PostConstruct;

import com.tospur.common.config.Global;
import com.tospur.common.web.BaseController;

public class SendEMailTask extends BaseController  
{
    /*@Autowired
    private InvestmentInfoService investmentInfoService;
    
    @Autowired
    public ProjectService projectService;*/
    
    @PostConstruct//注解  初始化bean的时候调用此方法   懒人加载模式 为false 生效 lazy-init="false"
    public void sendEmail()
    {
        String ip=getLocalHost();
        String httpUrl=Global.getConfig("send.email.url");
        httpUrl=httpUrl.replace("ip", ip);
        final String url=httpUrl;
        logger.info("url:"+url);
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.HOUR_OF_DAY,21); // 控制时
        calendar.set(Calendar.MINUTE, 0); // 控制分
        calendar.set(Calendar.SECOND, 0); // 控制秒
        Date time = calendar.getTime(); // 得出执行任务的时间,此处为今天的21：00：00
        logger.info("每天 21：00：00，发送项目进度");
        Timer timer = new Timer();
        timer.scheduleAtFixedRate(new TimerTask()
        {
            public void run()
            {
                logger.info("每天 10：00：00，发送项目进度");
                post(url+"day", "");
            }
        }, time, 1000 * 60 * 60 * 24);// 这里设定将延时每天固定执行
        
        int weekday=calendar.get(Calendar.DAY_OF_WEEK);//判断是否是星期天
        if(weekday==7){
            System.out.println(time);
            logger.info("每周日 21：00：00，发送项目进度");
            Timer timerWeak = new Timer();
            timerWeak.scheduleAtFixedRate(new TimerTask()
            {
                public void run()
                {
                    //发送项目进度
                    post(url+"week", "");
                }
            }, time, 1000 * 60 * 60 * 24 * 7);// 这里设定将延时每天固定执行
        }
    }
    
    public  boolean post(String urlString, String param) {
        HttpURLConnection urlConn = null;
        DataOutputStream os = null;
        try {
            String method = "POST";
            URL url = new URL(urlString);
            urlConn = (HttpURLConnection) url.openConnection();
            urlConn.setRequestMethod(method);
            urlConn.setDoOutput(true);
            urlConn.setDoInput(true);
            urlConn.setUseCaches(false);
            urlConn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            urlConn.connect();
            os = new DataOutputStream(urlConn.getOutputStream());
            os.writeBytes(param);
            boolean success = (urlConn.getResponseCode() == 200);
            return success;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(os!=null){
                try {
                    os.flush();
                    os.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            urlConn.disconnect();
            urlConn.disconnect();
            urlConn = null;
        }
        return false;
    }
   
    public String getLocalHost() {
        String  ip="127.0.0.1";
        try {
             InetAddress address = InetAddress.getLocalHost();//获取的是本地的IP地址
             ip=address.getHostAddress();
            
         } catch (UnknownHostException e) {
             e.printStackTrace();
         }
        return ip;
    }  
    
}
