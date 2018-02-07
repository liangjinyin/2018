package com.tospur.modules.project.web;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.tospur.common.config.Global;
import com.tospur.common.persistence.Page;
import com.tospur.common.utils.DateUtils;
import com.tospur.common.utils.MyBeanUtils;
import com.tospur.common.utils.StringUtils;
import com.tospur.common.utils.excel.ExportExcel;
import com.tospur.common.utils.excel.ImportExcel;
import com.tospur.common.web.BaseController;
import com.tospur.modules.project.entity.ProjectLog;
import com.tospur.modules.project.service.ProjectLogService;

/**
 * 项目动态Controller
 * @author kiss
 * @version 2017-02-14
 */
@Controller
@RequestMapping(value = "${adminPath}/project/projectLog")
public class ProjectLogController extends BaseController {

	@Autowired
	private ProjectLogService projectLogService;
	
	@ModelAttribute
	public ProjectLog get(@RequestParam(required=false) String id) {
		ProjectLog entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = projectLogService.get(id);
		}
		if (entity == null){
			entity = new ProjectLog();
		}
		return entity;
	}
	
	/**
	 * 项目日志列表页面
	 */
	@RequiresPermissions("project:projectLog:list")
	@RequestMapping(value = {"list", ""})
	public String list(ProjectLog projectLog, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ProjectLog> page = projectLogService.findPage(new Page<ProjectLog>(request, response), projectLog); 
		model.addAttribute("page", page);
		return "modules/project/projectLogList";
	}

	/**
	 * 查看，增加，编辑项目日志表单页面
	 */
	@RequiresPermissions(value={"project:projectLog:view","project:projectLog:add","project:projectLog:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(ProjectLog projectLog, Model model) {
		model.addAttribute("projectLog", projectLog);
		return "modules/project/projectLogForm";
	}

	/**
	 * 保存项目日志
	 */
	@RequiresPermissions(value={"project:projectLog:add","project:projectLog:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(ProjectLog projectLog, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, projectLog)){
			return form(projectLog, model);
		}
		if(!projectLog.getIsNewRecord()){//编辑表单保存
			ProjectLog t = projectLogService.get(projectLog.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(projectLog, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			projectLogService.save(t);//保存
		}else{//新增表单保存
			projectLogService.save(projectLog);//保存
		}
		addMessage(redirectAttributes, "保存项目日志成功");
		return "redirect:"+Global.getAdminPath()+"/project/projectLog/?repage";
	}
	
	/**
	 * 删除项目日志
	 */
	/*@RequiresPermissions("project:projectLog:del")*/
	@RequestMapping(value = "delete")
	public String delete(ProjectLog projectLog, RedirectAttributes redirectAttributes) {
		projectLogService.delete(projectLog);
		addMessage(redirectAttributes, "删除项目日志成功");
		return "redirect:"+Global.getAdminPath()+"/project/projectLog/?repage";
	}
	
	/**
	 * 批量删除项目日志
	 */
	/*@RequiresPermissions("project:projectLog:del")*/
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			projectLogService.delete(projectLogService.get(id));
		}
		addMessage(redirectAttributes, "删除项目日志成功");
		return "redirect:"+Global.getAdminPath()+"/project/projectLog/?repage";
	}
	@RequestMapping(value = "del")
	@ResponseBody
    public JSONObject deleteJson(String ids, RedirectAttributes redirectAttributes) {
        String idArray[] =ids.split(",");
        JSONObject data=new JSONObject();
        for(String id : idArray){
            projectLogService.delete(projectLogService.get(id));
        }
        data.put("msg", "删除成功");
        data.put("success", true);
        return data;
    }
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("project:projectLog:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(ProjectLog projectLog, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "项目日志"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<ProjectLog> page = projectLogService.findPage(new Page<ProjectLog>(request, response, -1), projectLog);
    		new ExportExcel("项目日志", ProjectLog.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出项目日志记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/project/projectLog/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("project:projectLog:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<ProjectLog> list = ei.getDataList(ProjectLog.class);
			for (ProjectLog projectLog : list){
				try{
					projectLogService.save(projectLog);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条项目日志记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条项目日志记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入项目日志失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/project/projectLog/?repage";
    }
	
	/**
	 * 下载导入项目日志数据模板
	 */
	@RequiresPermissions("project:projectLog:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "项目日志数据导入模板.xlsx";
    		List<ProjectLog> list = Lists.newArrayList(); 
    		new ExportExcel("项目日志数据", ProjectLog.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/project/projectLog/?repage";
    }
	
	
	

}