/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
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
import com.tospur.modules.project.entity.ProjectEmail;
import com.tospur.modules.project.service.ProjectEmailService;

/**
 * 任务邮件Controller
 * @author xieguofu
 * @version 2017-09-13
 */
@Controller
@RequestMapping(value = "${adminPath}/project/projectEmail")
public class ProjectEmailController extends BaseController {

	@Autowired
	private ProjectEmailService projectEmailService;
	
	@ModelAttribute
	public ProjectEmail get(@RequestParam(required=false) String id) {
		ProjectEmail entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = projectEmailService.get(id);
		}
		if (entity == null){
			entity = new ProjectEmail();
		}
		return entity;
	}
	
	/**
	 * 任务邮件信息列表页面
	 */
	@RequiresPermissions("project:projectEmail:list")
	@RequestMapping(value = {"list", ""})
	public String list(ProjectEmail projectEmail, HttpServletRequest request, HttpServletResponse response, Model model) {
//		Page<ProjectEmail> page = projectEmailService.findPage(new Page<ProjectEmail>(request, response), projectEmail); 
		List<ProjectEmail> pes  = projectEmailService.findAllList();
		ProjectEmail p = new ProjectEmail();
		if(pes.size() != 0){
		    p = pes.get(0);
		}
//		model.addAttribute("page", page);
		model.addAttribute("projectEmail",p);
		return "modules/project/projectEmailList";
	}

	/**
	 * 查看，增加，编辑任务邮件信息表单页面
	 */
	@RequiresPermissions(value={"project:projectEmail:view","project:projectEmail:add","project:projectEmail:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(ProjectEmail projectEmail, Model model) {
		model.addAttribute("projectEmail", projectEmail);
		return "modules/project/projectEmailForm";
	}

	/**
	 * 保存任务邮件信息
	 */
	@RequiresPermissions(value={"project:projectEmail:add","project:projectEmail:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(ProjectEmail projectEmail, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, projectEmail)){
			return form(projectEmail, model);
		}
		if(!projectEmail.getIsNewRecord()){//编辑表单保存
			ProjectEmail t = projectEmailService.get(projectEmail.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(projectEmail, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			projectEmailService.save(t);//保存
		}else{//新增表单保存
		        projectEmailService.save(projectEmail);//保存
		}
		addMessage(redirectAttributes, "项目更新通知人员保存成功");
		return "redirect:"+Global.getAdminPath()+"/project/projectEmail/list";
	}
	
	/**
	 * 删除任务邮件信息
	 */
	@RequiresPermissions("project:projectEmail:del")
	@RequestMapping(value = "delete")
	public String delete(ProjectEmail projectEmail, RedirectAttributes redirectAttributes) {
		projectEmailService.delete(projectEmail);
		addMessage(redirectAttributes, "删除任务邮件信息成功");
		return "redirect:"+Global.getAdminPath()+"/project/projectEmail/?repage";
	}
	
	/**
	 * 批量删除任务邮件信息
	 */
	@RequiresPermissions("project:projectEmail:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			projectEmailService.delete(projectEmailService.get(id));
		}
		addMessage(redirectAttributes, "删除任务邮件信息成功");
		return "redirect:"+Global.getAdminPath()+"/project/projectEmail/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("project:projectEmail:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(ProjectEmail projectEmail, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "任务邮件信息"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<ProjectEmail> page = projectEmailService.findPage(new Page<ProjectEmail>(request, response, -1), projectEmail);
    		new ExportExcel("任务邮件信息", ProjectEmail.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出任务邮件信息记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/project/projectEmail/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("project:projectEmail:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<ProjectEmail> list = ei.getDataList(ProjectEmail.class);
			for (ProjectEmail projectEmail : list){
				try{
					projectEmailService.save(projectEmail);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条任务邮件信息记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条任务邮件信息记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入任务邮件信息失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/project/projectEmail/?repage";
    }
	
	/**
	 * 下载导入任务邮件信息数据模板
	 */
	@RequiresPermissions("project:projectEmail:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "任务邮件信息数据导入模板.xlsx";
    		List<ProjectEmail> list = Lists.newArrayList(); 
    		new ExportExcel("任务邮件信息数据", ProjectEmail.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/project/projectEmail/?repage";
    }
	
	
	

}