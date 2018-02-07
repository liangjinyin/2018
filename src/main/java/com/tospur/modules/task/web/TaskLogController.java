/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.task.web;

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
import com.tospur.modules.sys.utils.UserUtils;
import com.tospur.modules.task.entity.MoreTaskLog;
import com.tospur.modules.task.entity.TaskInfo;
import com.tospur.modules.task.entity.TaskLog;
import com.tospur.modules.task.service.TaskInfoService;
import com.tospur.modules.task.service.TaskLogService;

/**
 * 任务日志Controller
 * @author xieguofu
 * @version 2017-09-01
 */
@Controller
@RequestMapping(value = "${adminPath}/task/taskLog")
public class TaskLogController extends BaseController {

	@Autowired
	private TaskLogService taskLogService;
	
	@Autowired
	private TaskInfoService taskInfoService;
	
	@ModelAttribute
	public TaskLog get(@RequestParam(required=false) String id) {
		TaskLog entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = taskLogService.get(id);
		}
		if (entity == null){
			entity = new TaskLog();
		}
		return entity;
	}
	
	/**
	 * 任务日志列表页面
	 */
	@RequiresPermissions("task:taskLog:list")
	@RequestMapping(value = {"list", ""})
	public String list(TaskLog taskLog, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TaskLog> page = taskLogService.findPage(new Page<TaskLog>(request, response), taskLog); 
		model.addAttribute("page", page);
		return "modules/task/taskLogList";
	}

	/**
	 * 查看，增加，编辑任务日志表单页面
	 */
	@RequiresPermissions(value={"task:taskLog:view","task:taskLog:add","task:taskLog:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(TaskLog taskLog, Model model) {
		model.addAttribute("taskLog", taskLog);
		return "modules/task/taskLogForm";
	}

	/**
	 * 保存任务日志
	 */
	@RequiresPermissions(value={"task:taskLog:add","task:taskLog:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	@ResponseBody
	public String save(TaskLog taskLog, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, taskLog)){
			return form(taskLog, model);
		}
		TaskInfo taskInfo;
		 //当日志的剩余时间为0时，触发任务的完成
        if(taskLog.getSurplus() == 0){
            taskInfo = taskInfoService.get(taskLog.getTask().toString());
            taskInfo.setStatus("已完成");
            taskInfo.setFinishedBy(UserUtils.getUser().getName());
            taskInfo.setFinishedDate(new Date());
            taskInfoService.save(taskInfo);
        }
        
		if(!taskLog.getIsNewRecord()){//编辑表单保存
			TaskLog t = taskLogService.get(taskLog.getId());//从数据库取出记录的值
			taskInfo = taskInfoService.get(taskLog.getTask().toString());
			taskInfo.setConsumed(taskInfo.getConsumed()-t.getConsumed()+taskLog.getConsumed());
			taskInfo.setSurplus(Double.parseDouble(taskLog.getSurplus().toString()));
			MyBeanUtils.copyBeanNotNull2Bean(taskLog, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			taskLogService.save(t);//保存
			taskInfoService.save(taskInfo);
		}else{//新增表单保存
			taskLogService.save(taskLog);//保存
		}
		addMessage(redirectAttributes, "保存任务日志成功");
//		return "redirect:"+Global.getAdminPath()+"/task/taskLog/logs?id="+taskLog.getTask();
		return taskLog.getTask().toString();
	}
	
	/**
	 * 删除任务日志
	 */
	@RequiresPermissions("task:taskLog:del")
	@RequestMapping(value = "delete")
	public String delete(TaskLog taskLog, RedirectAttributes redirectAttributes) {
	    Integer id = taskLog.getTask();
	    TaskInfo taskInfo = taskInfoService.get(id.toString());
	    taskInfo.setConsumed(taskInfo.getConsumed()-taskLog.getConsumed());
	    taskInfoService.save(taskInfo);
		taskLogService.delete(taskLog);
		addMessage(redirectAttributes, "关闭任务日志成功");
		return "redirect:"+Global.getAdminPath()+"/task/taskLog/logs?id="+id;
	}
	
	/**
	 * 批量删除任务日志
	 */
	@RequiresPermissions("task:taskLog:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			taskLogService.delete(taskLogService.get(id));
		}
		addMessage(redirectAttributes, "删除任务日志成功");
		return "redirect:"+Global.getAdminPath()+"/task/taskLog/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("task:taskLog:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(TaskLog taskLog, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "任务日志"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<TaskLog> page = taskLogService.findPage(new Page<TaskLog>(request, response, -1), taskLog);
    		new ExportExcel("任务日志", TaskLog.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出任务日志记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/task/taskLog/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("task:taskLog:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<TaskLog> list = ei.getDataList(TaskLog.class);
			for (TaskLog taskLog : list){
				try{
					taskLogService.save(taskLog);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条任务日志记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条任务日志记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入任务日志失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/task/taskLog/?repage";
    }
	
	/**
	 * 下载导入任务日志数据模板
	 */
	@RequiresPermissions("task:taskLog:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "任务日志数据导入模板.xlsx";
    		List<TaskLog> list = Lists.newArrayList(); 
    		new ExportExcel("任务日志数据", TaskLog.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/task/taskLog/?repage";
    }
	
	/**
	 * 显示日志及编辑日志
	 */
	@RequiresPermissions("task:taskLog:logs")
	@RequestMapping(value="logs")
	public String logs(TaskLog taskLog, HttpServletRequest request, HttpServletResponse response, Model model,Integer id){
	    List<TaskLog> page = taskLogService.findByTask(id);
        model.addAttribute("page", page);
        model.addAttribute("taskLog", taskLog);
        model.addAttribute("task",id);
        return "modules/task/taskLogForm";
	}
	
	/**
     * 批量保存任务日志信息
     */
    @RequiresPermissions("task:taskLog:logs")
    @RequestMapping(value="saveAll")
    @Transactional
    public String saveAll(MoreTaskLog moreTaskLog, Model model, RedirectAttributes redirectAttributes) throws Exception{
        List<TaskLog> taskLogs = moreTaskLog.getTaskLogs();
        Integer task = taskLogs.get(1).getTask(); //获取任务id
        TaskInfo taskInfo;
        Integer cTotal = 0;  //消耗总数
        Integer sLater = -1;  //最后的剩余时长
        for (TaskLog taskLog : taskLogs)
        {
            //当日志的信息全部填充时，才保存
            if(taskLog.getSurplus() != null && taskLog.getConsumed() != null && !taskLog.getContent().equals("") && taskLog.getDate() != null) {
                //填写任务日志触发任务状态的改变
                taskInfo = taskInfoService.get(task.toString());
                if(taskLogService.findByTask(task).size() == 0 && taskInfo.getStatus().equals("未开始")){
                    taskInfo.setStatus("进行中");
                    taskInfo.setOpenedBy(UserUtils.getUser().getName());
                    taskInfo.setOpenedDate(new Date());
                    taskInfo.setRealStarted(new Date());
                    taskInfoService.save(taskInfo);
                }
                
                //当日志的剩余时间为0时，触发任务的完成
                if(taskLog.getSurplus() == 0){
//                    taskInfo = taskInfoService.get(task.toString());
                    taskLog.setStatus(taskInfo.getStatus());
                    taskLog.setLastStatus("已完成");
                    taskInfo.setStatus("已完成");
                    taskInfo.setFinishedBy(UserUtils.getUser().getName());
                    taskInfo.setFinishedDate(new Date());
                    taskInfoService.save(taskInfo);
                }
                taskLogService.save(taskLog);
                cTotal += taskLog.getConsumed();
                sLater = taskLog.getSurplus();
            }else {
                continue;
            }
        }
        //每保存一条日志消耗的时间都会叠加，剩余时间都会减少
        if(sLater != -1){
            taskInfo = taskInfoService.get(task.toString());
            taskInfo.setConsumed(taskInfo.getConsumed()+cTotal);
            taskInfo.setSurplus(Double.parseDouble(sLater.toString()));
            taskInfoService.save(taskInfo);
        }
        addMessage(redirectAttributes, "保存任务信息成功");
        return "redirect:"+Global.getAdminPath()+"/task/taskLog/logs?id="+task;
    }
}