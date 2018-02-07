/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.cases.web;

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
import com.tospur.modules.cases.entity.Cases;
import com.tospur.modules.cases.service.CasesService;

/**
 * 案场Controller
 * @author jinyin
 * @version 2018-01-29
 */
@Controller
@RequestMapping(value = "${adminPath}/cases/cases")
public class CasesController extends BaseController {

	@Autowired
	private CasesService casesService;
	
	
	@ModelAttribute
	public Cases get(@RequestParam(required=false) String id) {
		Cases entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = casesService.get(id);
		}
		if (entity == null){
			entity = new Cases();
		}
		return entity;
	}
	
	/**
	 * 案场列表页面
	 */
	@RequiresPermissions("cases:cases:list")
	@RequestMapping(value = {"list", ""})
	public String list(Cases cases, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Cases> page = casesService.findPage(new Page<Cases>(request, response), cases); 
		model.addAttribute("page", page);
		return "modules/cases/casesList";
	}

	/**
	 * 查看，增加，编辑案场表单页面
	 */
	@RequiresPermissions(value={"cases:cases:view","cases:cases:add","cases:cases:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(Cases cases, Model model) {
	    
		model.addAttribute("cases", cases);
		return "modules/cases/casesForm";
	}

	/**
	 * 保存案场
	 */
	@RequiresPermissions(value={"cases:cases:add","cases:cases:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(Cases cases, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, cases)){
			return form(cases, model);
		}
		if(!cases.getIsNewRecord()){//编辑表单保存
			Cases t = casesService.get(cases.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(cases, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			casesService.save(t);//保存
		}else{//新增表单保存
			casesService.save(cases);//保存
		}
		addMessage(redirectAttributes, "保存案场成功");
		return "redirect:"+Global.getAdminPath()+"/cases/cases/?repage";
	}
	
	/**
	 * 删除案场
	 */
	@RequiresPermissions("cases:cases:del")
	@RequestMapping(value = "delete")
	public String delete(Cases cases, RedirectAttributes redirectAttributes) {
		casesService.delete(cases);
		addMessage(redirectAttributes, "删除案场成功");
		return "redirect:"+Global.getAdminPath()+"/cases/cases/?repage";
	}
	
	/**
	 * 批量删除案场
	 */
	@RequiresPermissions("cases:cases:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			casesService.delete(casesService.get(id));
		}
		addMessage(redirectAttributes, "删除案场成功");
		return "redirect:"+Global.getAdminPath()+"/cases/cases/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("cases:cases:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(Cases cases, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "案场"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<Cases> page = casesService.findPage(new Page<Cases>(request, response, -1), cases);
    		new ExportExcel("案场", Cases.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出案场记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/cases/cases/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("cases:cases:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<Cases> list = ei.getDataList(Cases.class);
			for (Cases cases : list){
				try{
					casesService.save(cases);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条案场记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条案场记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入案场失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/cases/cases/?repage";
    }
	
	/**
	 * 下载导入案场数据模板
	 */
	@RequiresPermissions("cases:cases:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "案场数据导入模板.xlsx";
    		List<Cases> list = Lists.newArrayList(); 
    		new ExportExcel("案场数据", Cases.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/cases/cases/?repage";
    }
	
	
	

}