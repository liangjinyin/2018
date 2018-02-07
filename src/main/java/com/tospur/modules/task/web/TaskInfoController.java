/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.task.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.tospur.common.config.Global;
import com.tospur.common.persistence.Page;
import com.tospur.common.utils.DateUtils;
import com.tospur.common.utils.MyBeanUtils;
import com.tospur.common.utils.StringUtils;
import com.tospur.common.utils.excel.ExportExcel;
import com.tospur.common.utils.excel.ImportExcel;
import com.tospur.common.web.BaseController;
import com.tospur.modules.product.entity.Iterater;
import com.tospur.modules.product.service.IteraterService;
import com.tospur.modules.sys.utils.UserUtils;
import com.tospur.modules.task.entity.MoreTaskInfo;
import com.tospur.modules.task.entity.TaskInfo;
import com.tospur.modules.task.entity.TaskLog;
import com.tospur.modules.task.service.TaskInfoService;
import com.tospur.modules.task.service.TaskLogService;

/**
 * 任务信息Controller
 * @author xieguofu
 * @version 2017-08-30
 */
@Controller
@RequestMapping(value = "${adminPath}/task/taskInfo")
public class TaskInfoController extends BaseController {

	@Autowired
	private TaskInfoService taskInfoService;
	
	@Autowired
	private IteraterService iteraterService;
	
	@Autowired
	private TaskLogService taskLogService;
	
	@ModelAttribute
	public TaskInfo get(@RequestParam(required=false) String id) {
		TaskInfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = taskInfoService.get(id);
		}
		if (entity == null){
			entity = new TaskInfo();
		}
		return entity;
	}
	
	/**
	 * 任务信息列表页面
	 */
	@RequiresPermissions("task:taskInfo:list")
	@RequestMapping(value = {"list", ""})
	public String list(TaskInfo taskInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
	    //根据过滤条件设置相应的参数
	    if(taskInfo.getIteration() == null){
	        taskInfo.setIteration(Integer.parseInt(iteraterService.getIteraterNum()));
	        taskInfo.setStatus("所有");
	    }else{
	        if(taskInfo.getStatus().equals("指派给我")){
	            taskInfo.setAssignedTo(UserUtils.getUser().getName());
	        }else if(taskInfo.getStatus().equals("我完成")){
	            taskInfo.setAssignedTo(UserUtils.getUser().getName());
	            taskInfo.setFinishedBy(UserUtils.getUser().getName());
	        }
	    }
		Page<TaskInfo> page = taskInfoService.findPage(new Page<TaskInfo>(request, response), taskInfo); 
		model.addAttribute("page", page);
		return "modules/task/taskInfoList";
	}

	/**
	 * 查看，增加，编辑任务信息表单页面
	 */
	@RequiresPermissions(value={"task:taskInfo:view","task:taskInfo:add","task:taskInfo:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(TaskInfo taskInfo, Model model) {
		model.addAttribute("taskInfo", taskInfo);
		return "modules/task/taskInfoForm";
	}
	
	/**
     * 编辑任务信息表单页面
     */
    @RequiresPermissions(value={"task:taskInfo:edit"})
    @RequestMapping(value = "edit")
    public String edit(TaskInfo taskInfo, Model model) {
        List<TaskLog> taskLogs = taskLogService.findByTask(Integer.parseInt(taskInfo.getId()));
        model.addAttribute("taskInfo", taskInfo);
        model.addAttribute("taskLogs",taskLogs);
        return "modules/task/taskInfoEdit";
    }
	
	/**
	 * 批量添加任务表单页面
	 */
	@RequiresPermissions("task:taskInfo:addMore")
	@RequestMapping(value = "addMore")
	public String moreForm(TaskInfo taskInfo, Model model) {
	    List<TaskInfo> taskInfos = new ArrayList<TaskInfo>();
	    for(int i=0; i<10; i++) {
	        taskInfos.add(new TaskInfo());
	    }
	    model.addAttribute("taskInfo", taskInfo);
	    model.addAttribute("taskInfos", taskInfos);
	    return "modules/task/taskInfoAdd";
	}

	/**
	 * 保存任务信息
	 */
	@RequiresPermissions(value={"task:taskInfo:add","task:taskInfo:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(TaskInfo taskInfo, Model model, RedirectAttributes redirectAttributes) throws Exception{
	    String msg = "保存任务信息成功";
		if (!beanValidator(model, taskInfo)){
			return form(taskInfo, model);
		}
		if(!taskInfo.getIsNewRecord()){//编辑表单保存
		    TaskLog taskLog = new TaskLog();
		    taskLog.setTask(Integer.parseInt(taskInfo.getId()));
			TaskInfo t = taskInfoService.get(taskInfo.getId());//从数据库取出记录的值
			TaskInfo task = taskInfoService.get(taskInfo.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(taskInfo, task);//将编辑表单中的非NULL值覆盖数据库记录中的值
			switch (taskInfo.getOp())
            {
                case "1":
                  //更改指派人员时更新指派时间并触发任务的开始
                    if(!taskInfo.getAssignedTo().equals(t.getAssignedTo())){
                        taskLog.setAssignedTo(t.getAssignedTo());
                        taskLog.setLastAssignedTo(taskInfo.getAssignedTo());
                        taskLog.setAssignedDate(t.getAssignedDate());
                        taskLog.setLastAssignedDate(new Date());
                        taskLog.setSurplus((int)(taskInfo.getSurplus()-0));
                        taskLog.setConsumed((int)(t.getConsumed()-0));
                        task.setAssignedDate(new Date());
                        if(t.getOpenedBy() == null){
//                            taskLog.setStatus(t.getStatus());
//                            taskLog.setLastStatus("进行中");
                            task.setStatus("进行中");
                            task.setOpenedBy(UserUtils.getUser().getName());
                            task.setOpenedDate(new Date());
                            task.setRealStarted(new Date());
                        }
                    }
                    break;
                case "2":
                    //开始任务
                    taskLog.setStatus(t.getStatus());
                    taskLog.setLastStatus("进行中");
                    task.setStatus("进行中");
                    task.setOpenedBy(UserUtils.getUser().getName());
                    task.setOpenedDate(new Date());
                    task.setRealStarted(new Date());
                    break;
                case "3":
                    //完成任务
                    if(taskInfo.getConsumed() < t.getConsumed()){
                        msg = "总消耗值应不小于"+ t.getConsumed();
                    }else{
                        taskLog.setStatus(t.getStatus());
                        taskLog.setLastStatus("已完成");
                        if(t.getStatus().equals("未开始")){
                            task.setOpenedBy(UserUtils.getUser().getName());
                            task.setOpenedDate(new Date());
                            task.setRealStarted(new Date());
                        }
                        task.setStatus("已完成");
                        task.setSurplus(0.0);
                        taskLog.setConsumed((int)(taskInfo.getConsumed()-t.getConsumed()));
                        taskLog.setSurplus(0);
                        task.setFinishedBy(UserUtils.getUser().getName());
                        if(!taskInfo.getAssignedTo().equals(t.getAssignedTo())){
                            taskLog.setAssignedTo(t.getAssignedTo());
                            taskLog.setAssignedDate(t.getAssignedDate());
                            taskLog.setLastAssignedTo(taskInfo.getAssignedTo());
                            taskLog.setLastAssignedDate(new Date());
                            task.setAssignedDate(new Date());
                        }
                    }
                    break;
                case "4":
                    //任务取消
                    taskLog.setStatus(t.getStatus());
                    taskLog.setLastStatus("已取消");
                    if(t.getStatus().equals("未开始")){
                        task.setOpenedBy(UserUtils.getUser().getName());
                        task.setOpenedDate(new Date());
                        task.setRealStarted(new Date());
                    }
                    task.setStatus("已取消");
                    task.setCanceledBy(UserUtils.getUser().getName());
                    task.setCanceledDate(new Date());
                    break;
                case "5":
                    //任务激活
                    taskLog.setStatus(t.getStatus());
                    taskLog.setLastStatus("进行中");
                    taskLog.setAssignedTo(t.getAssignedTo());
                    taskLog.setAssignedDate(t.getAssignedDate());
                    taskLog.setLastAssignedTo(taskInfo.getAssignedTo());
                    taskLog.setLastAssignedDate(new Date());
                    taskLog.setSurplus((int)(taskInfo.getSurplus()-0));
                    taskInfoService.recoverByLogic(task);
                    task.setStatus("进行中");
                    task.setAssignedDate(new Date());
                    if(t.getFinishedBy() != null || t.getFinishedDate() != null){
                        task.setFinishedBy(null);
                        task.setFinishedDate(null);
                    }
                    if(t.getCanceledBy() != null || t.getCanceledDate() != null){
                        task.setCanceledBy(null);
                        task.setCanceledDate(null);
                    }
                    if(t.getClosedBy() != null || t.getClosedDate() != null){
                        task.setClosedBy(null);
                        task.setClosedDate(null);
                    }
                    break;
                case "6":
                    //任务关闭
                    taskLog.setStatus(t.getStatus());
                    taskLog.setLastStatus("已关闭");
                    if(t.getStatus().equals("已取消")){
                        task.setSurplus(0.0);
                        taskLog.setSurplus(0);
                    }
                    taskInfoService.deleteByLogic(task);
                    task.setStatus("已关闭");
                    task.setClosedBy(UserUtils.getUser().getName());
                    task.setClosedDate(new Date());
                    task.setDelFlag("1");
                    break;
                default:
                    if(!taskInfo.getAssignedTo().equals(t.getAssignedTo())){
                        taskLog.setAssignedTo(t.getAssignedTo());
                        taskLog.setAssignedDate(t.getAssignedDate());
                        taskLog.setLastAssignedTo(taskInfo.getAssignedTo());
                        taskLog.setLastAssignedDate(new Date());
                        task.setAssignedDate(new Date());
                    }
                  //修改任务是根据任务的状态设置相应的信息
                    if(taskInfo.getStatus() != null && !taskInfo.getStatus().equals(t.getStatus())){
                        taskLog.setStatus(t.getStatus());
                        taskLog.setLastStatus(taskInfo.getStatus());
                        switch (taskInfo.getStatus())
                        {
                            case "未开始":
                                break;
                            case "进行中":
                                if(taskInfo.getOpenedBy() == null){
                                    task.setOpenedBy(UserUtils.getUser().getName());
                                }
                                if(taskInfo.getOpenedDate() == null){
                                    task.setOpenedDate(new Date());
                                }
                                if(taskInfo.getRealStarted() == null){
                                    task.setRealStarted(new Date());
                                }
                                break;
                            case "已完成":
                                if(taskInfo.getFinishedBy().equals("")){
                                    task.setFinishedBy(UserUtils.getUser().getName());
                                }
                                if(taskInfo.getFinishedDate() == null){
                                    task.setFinishedDate(new Date());
                                }
                                break;
                            case "已暂停":
                                break;
                            case "已取消":
                                if(taskInfo.getCanceledBy().equals("")){
                                    task.setCanceledBy(UserUtils.getUser().getName());
                                }
                                if(taskInfo.getCanceledDate() == null){
                                    task.setCanceledDate(new Date());
                                }
                                break;
                            case "已关闭":
                                if(t.getStatus() == "未开始" || t.getStatus() == "进行中"){
                                    task.setStatus(t.getStatus());
                                }
                                else{
                                    if(taskInfo.getClosedBy().equals("")){
                                        task.setClosedBy(UserUtils.getUser().getName());
                                    }
                                    if(taskInfo.getClosedDate() == null){
                                        task.setClosedDate(new Date());
                                    }
                                }
                                break;
                        }
                    }
                    break;
            }
			taskLogService.save(taskLog);
			taskInfoService.save(task);//保存
		}else{//新增表单保存
		    taskInfo.setStatus("未开始");
            taskInfo.setConsumed(0.0);
            taskInfo.setSurplus(0.0);
            taskInfo.setAssignedDate(new Date());
			taskInfoService.save(taskInfo);//保存
		}
		addMessage(redirectAttributes, msg);
		return "redirect:"+Global.getAdminPath()+"/task/taskInfo/?repage";
	}
	
	/**
	 * 批量保存任务信息
	 */
	@RequiresPermissions("task:taskInfo:addMore")
	@RequestMapping(value="saveAll")
	@Transactional
	public String saveAll(MoreTaskInfo moreTaskInfo, Model model, RedirectAttributes redirectAttributes) throws Exception{
	    
	    List<TaskInfo> taskInfos = moreTaskInfo.getTaskInfos();
	    for (TaskInfo taskInfo : taskInfos)
        {
            if(taskInfo.getIteration() != null && taskInfo.getName() != null && taskInfo.getAssignedTo() != null
                    && taskInfo.getEstimate() != null && taskInfo.getEstStarted() != null && taskInfo.getDeadline() != null
                    && taskInfo.getDescription() != null) {
                taskInfo.setStatus("未开始");
                taskInfo.setConsumed(0.0);
                taskInfo.setSurplus(0.0);
                taskInfo.setAssignedDate(new Date());
                taskInfoService.save(taskInfo);
            }else {
                continue;
            }
        }
	    addMessage(redirectAttributes, "批量保存任务信息成功");
        return "redirect:"+Global.getAdminPath()+"/task/taskInfo/?repage";
	}
	
	/**
	 * 删除任务信息
	 */
	@RequiresPermissions("task:taskInfo:del")
	@RequestMapping(value = "delete")
	public String delete(TaskInfo taskInfo, RedirectAttributes redirectAttributes) {
		taskInfoService.delete(taskInfo);
		addMessage(redirectAttributes, "删除任务信息成功");
		return "redirect:"+Global.getAdminPath()+"/task/taskInfo/?repage";
	}
	
	/**
	 * 逻辑删除任务（关闭任务）
	 */
	@RequiresPermissions("task:taskInfo:closed")
	@RequestMapping(value = "closed")
	public String closed(TaskInfo taskInfo, RedirectAttributes redirectAttributes) {
	    TaskLog taskLog = new TaskLog();
	    TaskInfo ti = taskInfoService.get(taskInfo);
	    taskInfoService.deleteByLogic(taskInfo);
	    taskLog.setTask(Integer.parseInt(ti.getId()));
	    taskLog.setStatus(ti.getStatus());
	    taskLog.setLastStatus("已关闭");
        if(ti.getStatus().equals("已取消")){
            ti.setSurplus(0.0);
            taskLog.setSurplus(0);
        }
	    ti.setStatus("已关闭");
	    ti.setClosedBy(UserUtils.getUser().getName());
	    ti.setClosedDate(new Date());
	    taskInfoService.save(ti);
	    taskLogService.save(taskLog);
	    addMessage(redirectAttributes, "关闭任务信息成功");
	    return "redirect:"+Global.getAdminPath()+"/task/taskInfo/?repage";
	}
	
	/**
	 * 批量删除任务信息
	 */
	@RequiresPermissions("task:taskInfo:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			taskInfoService.delete(taskInfoService.get(id));
		}
		addMessage(redirectAttributes, "删除任务信息成功");
		return "redirect:"+Global.getAdminPath()+"/task/taskInfo/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("task:taskInfo:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(TaskInfo taskInfo, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "任务信息"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<TaskInfo> page = taskInfoService.findPage(new Page<TaskInfo>(request, response, -1), taskInfo);
    		new ExportExcel("任务信息", TaskInfo.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出任务信息记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/task/taskInfo/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("task:taskInfo:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<TaskInfo> list = ei.getDataList(TaskInfo.class);
			for (TaskInfo taskInfo : list){
				try{
					taskInfoService.save(taskInfo);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条任务信息记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条任务信息记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入任务信息失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/task/taskInfo/?repage";
    }
	
	/**
	 * 下载导入任务信息数据模板
	 */
	@RequiresPermissions("task:taskInfo:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "任务信息数据导入模板.xlsx";
    		List<TaskInfo> list = Lists.newArrayList(); 
    		new ExportExcel("任务信息数据", TaskInfo.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/task/taskInfo/?repage";
    }
	
	/**
	 * 根据taskInfo id 查找迭代成员
	 */
	@RequestMapping(value="teamMan")
	@ResponseBody
	public String teamMan(String id) {
	    if(!id.equals("")) {
	        TaskInfo taskInfo = taskInfoService.get(id);
	        Iterater iterater = iteraterService.get(taskInfo.getIteration().toString());
	        return iterater.getTeamMan();
	    }else{
	        return null;
	    }
	}
	
	/**
	 * 按照状态查找任务信息（看板功能）
	 *//*
	@RequiresPermissions("task:taskInfo:lookBoard")
	@RequestMapping(value="lookBoard")
	public String lookBoard(TaskInfo taskInfo, Model model){
	    Integer iteration = taskInfoService.get(taskInfo).getIteration();
	    List<TaskInfo> wait = taskInfoService.findByIterationAndStatus(iteration, "未开始");
	    List<TaskInfo> doing = taskInfoService.findByIterationAndStatus(iteration, "进行中");
	    List<TaskInfo> done = taskInfoService.findByIterationAndStatus(iteration, "已完成");
	    List<TaskInfo> cancel = taskInfoService.findByIterationAndStatus(iteration, "已取消");
	    List<TaskInfo> closed = taskInfoService.findByIterationAndStatus(iteration, "已关闭");
	    model.addAttribute("wait",wait);
	    model.addAttribute("doing", doing);
	    model.addAttribute("done", done);
	    model.addAttribute("cancel", cancel);
	    model.addAttribute("closed", closed);
	    return "modules/task/lookBoard";
	}*/
	@RequiresPermissions("task:taskInfo:lookBoard")
	@RequestMapping(value="lookBoard")
	public String lookBoard( Model model,Integer iteration,Iterater itera ){
	   // TaskInfo taskInfo = taskInfoService.get(id);
	       
	     
	     Integer iter = 0;
	     Iterater iterater = null; 
	     //String iteraterName =null;
	     if(iteration!=null){
	            List<TaskInfo> wait = taskInfoService.findByIterationAndStatus(iteration, "未开始");
	            List<TaskInfo> doing = taskInfoService.findByIterationAndStatus(iteration, "进行中");
	            List<TaskInfo> done = taskInfoService.findByIterationAndStatus(iteration, "已完成");
	            List<TaskInfo> cancel = taskInfoService.findByIterationAndStatus(iteration, "已取消");
	            List<TaskInfo> closed = taskInfoService.findByIterationAndStatus(iteration, "已关闭");
	            
	            iterater =  iteraterService.get(iteration.toString());
	            
	            model.addAttribute("wait",wait);
	            model.addAttribute("doing", doing);
	            model.addAttribute("done", done);
	            model.addAttribute("cancel", cancel);
	            model.addAttribute("closed", closed); 
	            model.addAttribute("iterater", iterater); 
	     }else{
	         if(UserUtils.getUser().getName().equals("admin")){
	             
	             iter =   Integer.parseInt(iteraterService.getIteraterNum());  
	         }else{
	             
	             iter = Integer.parseInt(iteraterService.getNew(itera));
	         }
	         if(iter!=0){
	             List<TaskInfo> wait = taskInfoService.findByIterationAndStatus(iter, "未开始");
	             List<TaskInfo> doing = taskInfoService.findByIterationAndStatus(iter, "进行中");
	             List<TaskInfo> done = taskInfoService.findByIterationAndStatus(iter, "已完成");
	             List<TaskInfo> cancel = taskInfoService.findByIterationAndStatus(iter, "已取消");
	             List<TaskInfo> closed = taskInfoService.findByIterationAndStatus(iter, "已关闭");
	             
	             if(UserUtils.getUser().getName().equals("admin")){
	                 
	                 iterater  =  iteraterService.get(iteraterService.getIteraterNum());
	                 //iteraterName = iterater.getName();
	             }else{
	                 iterater =  iteraterService.get(iteraterService.getNew(itera));
	                 // iteraterName = iterater.getName();
	             }
	            
	             
	             model.addAttribute("wait",wait);
	             model.addAttribute("doing", doing);
	             model.addAttribute("done", done);
	             model.addAttribute("cancel", cancel);
	             model.addAttribute("closed", closed); 
	             model.addAttribute("iterater", iterater); 
	             //model.addAttribute("iteraterName", iteraterName); 
	         }
	        
	     }
	       
	   
	    return "modules/task/lookBoard";
	}
}