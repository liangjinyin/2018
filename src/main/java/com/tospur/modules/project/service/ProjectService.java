package com.tospur.modules.project.service;


import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.tospur.common.persistence.Page;
import com.tospur.common.service.CrudService;
import com.tospur.common.utils.ChineseToEnglish;
import com.tospur.common.utils.DateUtils;
import com.tospur.common.utils.StringUtils;
import com.tospur.modules.email.dao.EmailMessageDao;
import com.tospur.modules.niche.SendEmail;
import com.tospur.modules.project.dao.ProjectDao;
import com.tospur.modules.project.dao.ProjectLogDao;
import com.tospur.modules.project.dao.TaskManageDao;
import com.tospur.modules.project.entity.Bug;
import com.tospur.modules.project.entity.Project;
import com.tospur.modules.project.entity.ProjectLog;
import com.tospur.modules.project.entity.Task;
import com.tospur.modules.project.entity.TaskReport;
import com.tospur.modules.sys.entity.User;
import com.tospur.modules.sys.utils.UserUtils;

import gui.ava.html.image.generator.HtmlImageGenerator;

/**
 * 项目信息Service
 * @author kiss
 * @version 2017-02-14
 */
@Service
@Transactional(readOnly = true)
public class ProjectService extends CrudService<ProjectDao, Project> {
    
    @Autowired
    private ProjectLogDao projectLogDao;
    @Autowired
    private EmailMessageDao emailMessageDao;
    @Autowired
    private TaskManageDao taskManageDao;
    
	public Project get(String id, String op) {
		return super.get(id);
	}
    
	public Project get(Project project) {
        return dao.getOne(project);
    }
    
    
	public List<Project> findList(Project project) {
		return super.findList(project);
	}
	
	public Page<Project> findPage(Page<Project> page, Project project) {
		return super.findPage(page, project);
	}
	
	@SuppressWarnings("deprecation")
	public List<Project> findAllList(){
	    return dao.findAllList();
	}
	
	@Transactional(readOnly = false)
	public void save(Project entity) {
	    if (entity.getIsNewRecord()){
            entity.preInsert();
            entity.setIsNewRecord(true);
            dao.insert(entity);
        }else{
              if("2".equals(entity.getOp())){
                for (ProjectLog log : entity.getLogs())
                {
                    log.setProject(entity.getId());
                    log.setProjectStatus(entity.getSaleStage());
                    if(StringUtils.isEmpty(log.getId())){
                        log.preInsert();
                        projectLogDao.insert(log);
                    }else if(log.getDelFlag().equals(ProjectLog.DEL_FLAG_DELETE)){
                        projectLogDao.delete(log);
                    } else{
                        log.preUpdate();
                        projectLogDao.update(log);
                    }
                }
                entity.preUpdate();
                dao.updateStage(entity);
            }else{
                entity.preUpdate();
                dao.update(entity);
            }
            
        }
	   
	}
	
	@Transactional(readOnly = false)
	public void delete(Project project) {
		super.delete(project);
	}
	
	
	/**
     * 
     * @param project
     * @return
     */
    public List<Map<String,Object>> findProjectProcess(Project name) {
        return taskManageDao.findProjectProcess(name);
    }
    
    /**
     * 
     * @param project
     * @return
     */
    public List<Map<String,Object>> findPersonProcess(String account, String workdate) {
        return taskManageDao.findPersonProcess(account, workdate);
    }
    /**
     * 
     * @param project
     * @return
     */
    public List<Map<String, String>> fundPms() {
        String ids = "";
        List<Map<String, String>> userlist=Lists.newArrayList();
        for (Map<String, Object> task : taskManageDao.findProjects(new Project()))
        {
            if(task.get("id")!=null){
                String id=task.get("id").toString();
                ids=ids+id+",";
            }
        }
        ids=ids.contains(",")?ids.substring(0, ids.lastIndexOf(",")):ids;
        //获取任务项目相关人员
        if(!StringUtils.isEmpty(ids)){
            userlist= taskManageDao.findUsersByProject(ids);
        }
        return userlist;
    }
	/**
	 * 
	 * @param project
	 * @return
	 */
	public List<Map<String,Object>> findProjects( Project project) {
	    if(project.getCreateBy()==null||project.getCreateBy().getName()==null){
	        project.preInsert();
	    }
        return taskManageDao.findProjects(project);
    }
	
	/**
     * 
     * @param project
     * @return
     */
    public  Page<Task>  findJobs(Page<Task> page,Task task) {
        if(task.getCreateBy()==null||task.getCreateBy().getName()==null){
            task.preInsert();
         }
        task.setPage(page);
        page.setList(taskManageDao.findJobs(task));
        return page;
    }
    /**
     * 
     * @param project
     * @return
     */
    public  Map<String, Object>  findProjectById(String id,String name) {
        Map<String, Object> p=taskManageDao.findProjectById(id,name);
        return p;
    }
    /**
     * 
     * @param project
     * @return
     */
    public Page<Bug> findBugs(Page<Bug> page,Bug bug) {
        if(bug.getCreateBy()==null||bug.getCreateBy().getName()==null){
            bug.preInsert();
        }
        bug.setPage(page);
        page.setList(taskManageDao.findBugs(bug));
        return page;
    }
    /**
     * 
     * @param toEmail  收件人的邮箱
     * @param copyEmail 抄送人的邮箱
     */
    @Transactional(readOnly = false)
    public void sendMailByDay(){
        String date=DateUtils.getDate("yyyy-MM-dd");
        //发送所有任务进度信息
        /* User admin=UserUtils.getEmails("admin");
        List<Map<String,Object>>tasktotal=taskManageDao.findDayTaskReport(new Task());
        new SendEmail(admin.getEmail(), admin.getCopyEmails(), date+"的所有任务日报信息",taskHtmlContent2(tasktotal)).start();*/
        //按项目负责人发送项目进度信息
        String tableName="task_report_"+DateUtils.getDate("yyyyMMdd");
        HashMap<String,Object> table=new HashMap<String,Object>();
        table.put("tableName", tableName);
        table.put("day", DateUtils.getDate("yyyyMMdd"));
        taskManageDao.createDayReport(table);
        
        
        //按任务负责人发送任务进度信息
        Task param=new Task();
        param.setDate(date);
        for (String userName :  taskManageDao.findEmployee())
        {
            User user=UserUtils.getEmails(userName);
            if(user!=null){
                String tasktheme=user.getName()+"的任务日报("+date+")";
                param.setFinishedBy(userName);
                List<Map<String,Object>>taskProcess=taskManageDao.findDayTaskReport(param);
                List< Map<String, String>> userlist= Lists.newArrayList();
                for (Map<String, Object> task : taskProcess)
                {
                    if(task.get("openedBy")!=null){
                        String openedBy=task.get("openedBy").toString();
                        if(!userlist.contains(new String(openedBy))){
                            Map<String, String> temp=new HashMap<String, String>();
                            temp.put("userName", openedBy);
                            userlist.add(temp);
                        }
                    }
                }
                String toEmails=user.getEmail();
                //获取任务项目相关人员
                user=UserUtils.getEmails(userlist);
                if(taskProcess!=null && taskProcess.size()>0 && user!=null){
                    String taskHtml=taskHtmlContent2(taskProcess);
                    taskHtml="<div>"+tasktheme+"</div><br/>"+taskHtml;
                    String copyEmail=user.getCopyEmails();
                    if(!StringUtils.isEmpty(toEmails)){
                        //按任务负责人发送任务进度信息
                        logger.info(tasktheme);
                        String url=getUrl(tasktheme, date+"任务日报");
                        taskHtml=taskHtml+"<div> 访问地址：<a href='"+url+"'>"+url+"</a></div>";
                        htmlToImage(taskHtml, tasktheme,date+"任务日报");
                        
                        new SendEmail(toEmails, copyEmail, tasktheme, taskHtml,emailMessageDao).start();
                    }else{
                        logger.warn(user.getName()+"的邮件信息不完整！");
                    }
                }else{
                    logger.warn(userName+"用户在没有"+date+"的任务！");  
                }
            } else{
                logger.warn(userName+"用户在系统中未找到！");  
            }
        }
    }
    
   
    
   /**
    * 发周报数据
    */
    public void sendMailByWeek(){
        String date=DateUtils.getDate("yyyy-MM-dd");
        //发送个人周报
        Task param=new Task();
        param.setDate(date);
 
        for (String userName :  taskManageDao.findEmployee())
        {
            User user=UserUtils.getEmails(userName);
            if(user!=null){
                String tasktheme=user.getName()+"的任务周报("+date+")";
                param.setFinishedBy(userName);
                List<Map<String,Object>>taskProcess=taskManageDao.findWeekTaskReport(param);
                String ids = "";
                for (Map<String, Object> task : taskProcess)
                {
                    if(task.get("id")!=null){
                        String id=task.get("id").toString();
                        ids=ids+id+",";
                    }
                }
                ids=ids.contains(",")?ids.substring(0, ids.lastIndexOf(",")):ids;
                if(StringUtils.isEmpty(ids)){
                    continue;
                }
                String toEmails=user.getEmail();
                //获取任务项目相关人员
                List<Map<String, String>> userlist= taskManageDao.findUsersByProject(ids);
                user=UserUtils.getEmails(userlist);
                
                if(taskProcess!=null && taskProcess.size()>0 && user!=null){
                    String copyEmail=user.getCopyEmails();
                    List<Map<String,Object>>taskhead=taskManageDao.findWeekPorjectSumReport(param);
                    String taskHtml=taskWeekHeadHtml(taskhead);
                    taskHtml=taskHtml+taskHtmlContent2(taskProcess);
                    
                    taskHtml="<div>"+tasktheme+"</div><br/>"+taskHtml;
                    if(!StringUtils.isEmpty(toEmails)){
                        //按任务负责人发送任务周报信息
                        String url=getUrl(tasktheme, date+"任务周报");
                        taskHtml=taskHtml+"<div> 访问地址：<a href='"+url+"'>"+url+"</a></div>";
                        htmlToImage(taskHtml, tasktheme,date+"任务周报");
                        new SendEmail(toEmails, copyEmail, tasktheme, taskHtml,emailMessageDao).start();
                    }else{
                        logger.warn(user.getName()+"的邮件信息不完整！");
                    }
                }else{
                    logger.warn(userName+"用户在没有"+date+"任务周报！");  
                }
            } else{
                logger.warn(userName+"用户在系统中未找到！");  
            }
        }
        //发送整体周报
        for (Project project :  taskManageDao.findProjectsByWeek())
        {
            String projectName=project.getName();
            String id=project.getId();
            List<Map<String, String>> userlist= taskManageDao.findUsersByProject(id);
            User user=UserUtils.getEmails(userlist);
            if(user!=null){
                String tasktheme=projectName+"的项目周报("+date+")";
                param=new Task();
                param.setId(id);
                List<Map<String,Object>>taskProcess=taskManageDao.findWeekTaskReport(param);
                if(taskProcess!=null && taskProcess.size()>0){
                    List<Map<String,Object>>taskhead=taskManageDao.findWeekPorjectSumReport(param);
                    String taskHtml=taskWeekHeadHtml(taskhead);
                    taskHtml=taskHtml+taskHtmlContent3(taskProcess);
                    taskHtml="<div>"+tasktheme+"</div><br/>"+taskHtml;
                    String toEmails=user.getEmail();
                    String copyEmail=user.getCopyEmails();
                    if(!StringUtils.isEmpty(toEmails)){
                        //按任务负责人发送任务周报信息
                        String url=getUrl(tasktheme, date+"项目周报");
                        taskHtml=taskHtml+"<div> 访问地址：<a href='"+url+"'>"+url+"</a></div>";
                        htmlToImage(taskHtml, tasktheme,date+"项目周报");
                        new SendEmail(toEmails, copyEmail, tasktheme, taskHtml,emailMessageDao).start();
                    }else{
                        logger.warn(user.getName()+"的邮件信息不完整！");
                    }
                }else{
                    logger.warn(projectName+"没有"+date+"没有周报！");  
                }
            } else{
                logger.warn("项目"+projectName+"在系统中未有成员！");  
            }
        }
        
    }
    
    
    public String projectProcessHtml( String pm){
        String headCss="style='height: 30px; border: 1px solid #dddfe2;background-color: #ebebeb;font-family: 'Microsoft YaHei','open sans', 'Helvetica Neue', Helvetica, Arial, sans-serif;'";
        String tdcss="style=' border: 1px solid #dddfe2;text-align: center;'";
        Project param=new Project();
        param.setName(pm);
        List<Map<String,Object>>contents=taskManageDao.findProjectProcess(param);
        String content="<table "
                + "style='font-size:14px;"
                + "color:#000;font-weight:normal;border:2pxsolid#dddfe2;width:80%;"
                + "max-width:100%;margin-bottom:20px;border-spacing:0;'"
                + "><thead><tr>"
                + "<th "+headCss+">项目名称 </th>"
                + "<th "+headCss+">项目负责人 </th>"
                + "<th "+headCss+">状态</th>"
                + "<th "+headCss+">完成进度 </th>"
                + "<th "+headCss+">项目整体进度</th>"
                + "<th "+headCss+">实际天数</th>"
                + "</tr></thead><tbody>";
        for (Map<String, Object> map : contents)
        {
            try
            {
                content+="<tr>"
                        + "<td "+tdcss+">"
                        + map.get("projectName")
                        +"</td><td "+tdcss+">"
                        + (map.get("projectManager")==null?"":map.get("projectManager"))
                        +"</td><td "+tdcss+">"
                        + map.get("status")
                        +"</td><td "+tdcss+">"
                        + map.get("doneProcess")
                        +"%</td><td "+tdcss+">"
                        + map.get("projectProcess")
                        +"%</td><td "+tdcss+">"
                        + map.get("realdays")
                        + "</td></tr>";
            }
            catch (Exception e)
            {
                logger.info(map.get("projectName")+"信息不完整!"); 
            }
        }
        content=content+"</tbody></table>";
        logger.info("项目日报内容：\n"+content);
        return content;
    }
    private String taskHtmlContent3 (List<Map<String,Object>> taskProcess){
        String headCss="style='height: 30px; border: 1px solid #dddfe2;background-color: #ebebeb;font-family: 'Microsoft YaHei','open sans', 'Helvetica Neue', Helvetica, Arial, sans-serif;'";
        String tdcss="style=' border: 1px solid #dddfe2;text-align: center;'";
        String tdRate=" <colgroup> "
                + "<col style='width:2%'> "
                + "<col style='width:2%'> "
                + "<col style='width:16%'> "
                + "<col style='width:4%'> "
                + "<col style='width:8%'> "
                + "<col style='width:6%'> "
                + "<col style='width:2%'> "
                + "<col style='width:8%'> "
                + "<col style='width:6%'> "
                + "<col style='width:8%'> "
                + "<col style='width:10%'> "
                + "<col style='width:10%'> "
                + "<col style='width:8%'> "
                + "<col style='width:8%'> "
                + "<col style='width:2%'>  "
                + "</colgroup> ";
        String content="<table "
                + "style='font-size:14px;"
                + "color:#000;font-weight:normal;border:2pxsolid#dddfe2;width:80%;"
                + "max-width:100%;margin-bottom:20px;border-spacing:0;'"
                + ">"
                +tdRate
                + "<thead><tr>"
                + "<th "+headCss+">项目名称 </th>"
                + "<th "+headCss+">任务负责人 </th>"
                + "<th "+headCss+">任务名称</th>"
                + "<th "+headCss+">类型</th>"
                + "<th "+headCss+">描述</th>"
                + "<th "+headCss+">状态</th>"
                + "<th "+headCss+">进度</th>"
                + "<th "+headCss+">预计开始时间 </th>"
                + "<th "+headCss+">估计的工作量(小时)</th>"
                + "<th "+headCss+">预计完成时间</th>"
                + "<th "+headCss+">消耗时间(小时)</th>"
                + "<th "+headCss+">剩余时间(小时)</th>"
                + "<th "+headCss+">实际开始时间</th>"
                + "<th "+headCss+">实际完成时间</th>"
                + "<th "+headCss+">实际完成人</th>"
                + "</tr></thead><tbody>";
        for (Map<String, Object> map : taskProcess)
        {
            try
            {
                content= content+ "<tr>"
                        + "<td "+tdcss+">"
                        + (map.get("projectName")==null?"":map.get("projectName"))
                        +"</td><td "+tdcss+">"
                        +  (map.get("assignedTo")==null?"":map.get("assignedTo"))
                        +"</td><td "+tdcss+">"
                        +   (map.get("taskName")==null?"":map.get("taskName"))
                        +"</td><td "+tdcss+">"
                        +  (map.get("taskType")==null?"":map.get("taskType"))
                        +"</td><td "+tdcss+">"
                        +   (map.get("desc")==null?"":map.get("desc"))
                        +"</td><td "+tdcss+">"
                        +   (map.get("status")==null?"":map.get("status"))
                        +"</td><td "+tdcss+">"
                        +   (map.get("procesed")==null?"":map.get("procesed"))
                        +"</td><td "+tdcss+">"
                        +   (map.get("estStarted")==null?"":map.get("estStarted"))
                        +"</td><td "+tdcss+">"
                        +  (map.get("estimate")==null?"":map.get("estimate"))
                        +"</td><td "+tdcss+">"
                        +  (map.get("deadline")==null?"":map.get("deadline"))
                        +"</td><td "+tdcss+">"
                        + (map.get("consumed")==null?"":map.get("consumed"))
                        +"</td><td "+tdcss+">"
                        +  (map.get("left")==null?"":map.get("left"))
                        +"</td><td "+tdcss+">"
                        + (map.get("realStarted")==null?"":map.get("realStarted"))
                        +"</td><td "+tdcss+">"
                        + (map.get("finishedDate")==null?"":map.get("finishedDate"))
                        +"</td><td "+tdcss+">"
                        + (map.get("finishedBy")==null?"":map.get("finishedBy"))
                        + "</td></tr>";
            }
            catch (Exception e)
            {
                logger.info(map.get("taskName")+"任务信息不完整!"); 
            }
        }
        content=content+"</tbody></table>";
        logger.info("个人日报内容：\n"+content);
        return content;
    }
    
    private String taskHtmlContent2 (List<Map<String,Object>> taskProcess){
        String headCss="style='height: 30px; border: 1px solid #dddfe2;background-color: #ebebeb;font-family: 'Microsoft YaHei','open sans', 'Helvetica Neue', Helvetica, Arial, sans-serif;'";
        String tdcss="style=' border: 1px solid #dddfe2;text-align: center;'";
        String tdRate=" <colgroup> "
                + "<col style='width:2%'> "
                + "<col style='width:2%'> "
                + "<col style='width:16%'> "
                + "<col style='width:4%'> "
                + "<col style='width:8%'> "
                + "<col style='width:6%'> "
                + "<col style='width:2%'> "
                + "<col style='width:8%'> "
                + "<col style='width:6%'> "
                + "<col style='width:8%'> "
                + "<col style='width:10%'> "
                + "<col style='width:10%'> "
                + "<col style='width:8%'> "
                + "<col style='width:8%'> "
                + "<col style='width:2%'>  "
                + "</colgroup> ";
        String content="<table "
                + "style='font-size:14px;"
                + "color:#000;font-weight:normal;border:2pxsolid#dddfe2;width:80%;"
                + "max-width:100%;margin-bottom:20px;border-spacing:0;'"
                + ">"
                +tdRate
                + "<thead><tr>"
                + "<th "+headCss+">负责人 </th>"
                + "<th "+headCss+">项目名称 </th>"
                + "<th "+headCss+">任务名称</th>"
                + "<th "+headCss+">类型</th>"
                + "<th "+headCss+">描述</th>"
                + "<th "+headCss+">状态</th>"
                + "<th "+headCss+">进度</th>"
                + "<th "+headCss+">预计开始时间 </th>"
                + "<th "+headCss+">估计的工作量(小时)</th>"
                + "<th "+headCss+">预计完成时间</th>"
                + "<th "+headCss+">消耗时间(小时)</th>"
                + "<th "+headCss+">剩余时间(小时)</th>"
                + "<th "+headCss+">实际开始时间</th>"
                + "<th "+headCss+">实际完成时间</th>"
                + "<th "+headCss+">实际人</th>"
                + "</tr></thead><tbody>";
        for (Map<String, Object> map : taskProcess)
        {
            try
            {
                content= content+ "<tr>"
                        + "<td "+tdcss+">"
                        +  (map.get("assignedTo")==null?"":map.get("assignedTo"))
                        +"</td><td "+tdcss+">"
                        + (map.get("projectName")==null?"":map.get("projectName"))
                        +"</td><td "+tdcss+">"
                        +   (map.get("taskName")==null?"":map.get("taskName"))
                        +"</td><td "+tdcss+">"
                        +  (map.get("taskType")==null?"":map.get("taskType"))
                        +"</td><td "+tdcss+">"
                        +   (map.get("desc")==null?"":map.get("desc"))
                        +"</td><td "+tdcss+">"
                        +   (map.get("status")==null?"":map.get("status"))
                        +"</td><td "+tdcss+">"
                        +   (map.get("procesed")==null?"":map.get("procesed"))
                        +"</td><td "+tdcss+">"
                        +   (map.get("estStarted")==null?"":map.get("estStarted"))
                        +"</td><td "+tdcss+">"
                        +  (map.get("estimate")==null?"":map.get("estimate"))
                        +"</td><td "+tdcss+">"
                        +  (map.get("deadline")==null?"":map.get("deadline"))
                        +"</td><td "+tdcss+">"
                        + (map.get("consumed")==null?"":map.get("consumed"))
                        +"</td><td "+tdcss+">"
                        +  (map.get("left")==null?"":map.get("left"))
                        +"</td><td "+tdcss+">"
                        + (map.get("realStarted")==null?"":map.get("realStarted"))
                        +"</td><td "+tdcss+">"
                        + (map.get("finishedDate")==null?"":map.get("finishedDate"))
                        +"</td><td "+tdcss+">"
                        + (map.get("finishedBy")==null?"":map.get("finishedBy"))
                        + "</td></tr>";
            }
            catch (Exception e)
            {
                logger.info(map.get("taskName")+"任务信息不完整!"); 
            }
        }
        content=content+"</tbody></table>";
        logger.info("个人日报内容：\n"+content);
        return content;
    }
    private String taskWeekHeadHtml(List<Map<String,Object>> taskhead){
        String tdcss="style=' border: 0px solid #dddfe2;text-align: center;'";
        String content="<table "
                + "style='font-size:14px;"
                + "color:#000;font-weight:normal;border:2pxsolid#dddfe2;width:80%;"
                + "max-width:100%;margin-bottom:20px;border-spacing:0;'"
                + ">";
        for (Map<String, Object> map : taskhead)
        {
            //39 个任务，已完成 1，未开始 31，进行中 4，总预计187.5工时，已消耗14.1工时，剩余180.4工时。
            try
            {
                content= content+ "<tr>"
                        + "<td "+tdcss+">项目名称："
                        +"</td><td "+tdcss+">"
                        +  (map.get("projectName")==null?"":map.get("projectName"))
                        +"</td><td "+tdcss+">任务数："
                        +  (map.get("taskNum")==null?"":map.get("taskNum"))
                        +"</td><td "+tdcss+">未开始 :"
                        +"</td><td "+tdcss+">"
                        +   (map.get("wait")==null?"":map.get("wait"))
                        +"</td><td "+tdcss+">进行中:"
                        +"</td><td "+tdcss+">"
                        +  (map.get("doing")==null?"":map.get("doing"))
                        +"</td><td "+tdcss+">已完成:"
                        +"</td><td "+tdcss+">"
                        +   (map.get("done")==null?"":map.get("done"))
                        +"</td><td "+tdcss+">已关闭："
                        +"</td><td "+tdcss+">"
                        +  (map.get("closed")==null?"":map.get("closed"))
                        +"</td><td "+tdcss+">总计工时："
                        +"</td><td "+tdcss+">"
                         + (map.get("estimate")==null?"":map.get("estimate"))
                        +"</td><td "+tdcss+">已消耗工时："
                        +"</td><td "+tdcss+">"
                         + (map.get("consumed")==null?"":map.get("consumed"))
                        +"</td><td "+tdcss+">剩余工时："
                        +"</td><td "+tdcss+">"
                        + (map.get("remainder")==null?"":map.get("remainder"))
                        + "</td></tr>";
            }
            catch (Exception e)
            {
                logger.info(map.get("projectName")+"项目信息不完整!"); 
            }
        }
        content=content+"</table>";
        logger.info("任务周报内容：\n"+content);
        return content;
    }
    
    @Deprecated 
   public String taskHtmlContent(List<Task>taskProcess){
        String headCss="style='height: 30px; border: 1px solid #dddfe2;background-color: #ebebeb;font-family: 'Microsoft YaHei','open sans', 'Helvetica Neue', Helvetica, Arial, sans-serif;'";
        String tdcss="style=' border: 1px solid #dddfe2;text-align: center;'";
        String content="<table "
                + "style='font-size:14px;"
                + "color:#000;font-weight:normal;border:2pxsolid#dddfe2;width:80%;"
                + "max-width:100%;margin-bottom:20px;border-spacing:0;'"
                + "><thead><tr>"
                + "<th "+headCss+">项目名称 </th>"
                + "<th "+headCss+">任务名称 </th>"
                + "<th "+headCss+">状态</th>"
                + "<th "+headCss+">开始时间 </th>"
                + "<th "+headCss+">完成时间</th>"
                + "<th "+headCss+">耗时(天)</th>"
                + "</tr></thead><tbody>";
        for (Task map : taskProcess)
        {
            
            try
            {
                content+="<tr>"
                        + "<td "+tdcss+">"
                        + map.getProjectName()
                        +"</td><td "+tdcss+">"
                        + map.getTaskName()
                        +"</td><td "+tdcss+">"
                        + map.getStatus()
                        +"</td><td "+tdcss+">"
                        + DateUtils.formatDateTime(map.getRealStarted())
                        +"</td><td "+tdcss+">"
                        + DateUtils.formatDateTime(map.getFinishedDate())
                        +"</td><td "+tdcss+">"
                        + DateUtils.getDistanceOfTwoDate(map.getRealStarted(), map.getFinishedDate())
                        + "天</td></tr>";
            }
            catch (Exception e)
            {
                logger.info(map.getTaskName()+"任务信息不完整!"); 
            }
        }
        content=content+"</tbody></table>";
        //logger.info("个人日报内容：\n"+content);
        return content;
    }
    
    public  void htmlToImage(String htmlstr,String fileName, String date)
    {
        HtmlImageGenerator imageGenerator = new HtmlImageGenerator();
        imageGenerator.loadHtml(htmlstr);
        
        imageGenerator.getBufferedImage();
        date=ChineseToEnglish.getPinYin(date);
        String path=ProjectService.class.getResource("/").getPath()+"../../"+date+"/";
        logger.info(path);
        if(createDir(path)){
            fileName=ChineseToEnglish.getPinYin(fileName);
            imageGenerator.saveAsImage(path+fileName+".png");
            imageGenerator.saveAsHtmlWithMap(path+fileName+".html",fileName+".png");
        }
    }
 // 创建目录
    public  boolean createDir(String destDirName) {
        File dir = new File(destDirName);
        
        if (dir.exists()) {// 判断目录是否存在
            logger.info("目标目录已存在！");
            return true;
        }
        if (!destDirName.endsWith(File.separator)) {// 结尾是否以"/"结束
            destDirName = destDirName + File.separator;
        }
        if (dir.mkdirs()) {// 创建目标目录
            logger.info("创建目录成功！" + destDirName);
            return true;
        } else {
            logger.info("创建目录失败！");
            return false;
        }
    }
    @Autowired
    private HttpServletRequest request;
    
    
    public String getUrl(String fileName,String date){
        fileName=ChineseToEnglish.getPinYin(fileName);
        date=ChineseToEnglish.getPinYin(date);
        String url = "";
        try
        {
            url = request.getScheme() +"://" + request.getServerName()  
                            + ":" +request.getServerPort() 
                            + request.getContextPath()+"/"
                            +date+"/"
                            +fileName+".html";
            logger.info(url);
        }
        catch (Exception e)
        {
            logger.info("url 错误:"+e.getMessage());
        }
        return url;
    }
    public Page<TaskReport> taskReport(Page<TaskReport> page, TaskReport task)
    {
        task.setPage(page);
        List<TaskReport> list=Lists.newArrayList();
        try
        {
            list = taskManageDao.findTaskReport(task);
        }
        catch (Exception e)
        {
            logger.info(e.getMessage());
        }
        page.setList(list);
        return page;
    }
   
}