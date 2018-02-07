/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.sales.web;

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
import com.tospur.modules.sales.entity.SalesMan;
import com.tospur.modules.sales.service.SalesManService;

/**
 * salesController
 * @author kiss
 * @version 2017-07-05
 */
@Controller
@RequestMapping(value = "${adminPath}/sales/salesMan")
public class SalesManController extends BaseController {

	@Autowired
	private SalesManService salesManService;
	
	@ModelAttribute
	public SalesMan get(@RequestParam(required=false) String id) {
		SalesMan entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = salesManService.get(id);
		}
		if (entity == null){
			entity = new SalesMan();
		}
		return entity;
	}
	
	/**
	 * 销售人员列表页面
	 */
	@RequiresPermissions("sales:salesMan:list")
	@RequestMapping(value = {"list", ""})
	public String list(SalesMan salesMan, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SalesMan> page = salesManService.findPage(new Page<SalesMan>(request, response), salesMan); 
		model.addAttribute("page", page);
		return "modules/sales/salesManList";
	}

	/**
	 * 查看，增加，编辑销售人员表单页面
	 */
	@RequiresPermissions(value={"sales:salesMan:view","sales:salesMan:add","sales:salesMan:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(SalesMan salesMan, Model model) {
		model.addAttribute("salesMan", salesMan);
		return "modules/sales/salesManForm";
	}

	/**
	 * 保存销售人员
	 */
	@RequiresPermissions(value={"sales:salesMan:add","sales:salesMan:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(SalesMan salesMan, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, salesMan)){
			return form(salesMan, model);
		}
		if(!salesMan.getIsNewRecord()){//编辑表单保存
			SalesMan t = salesManService.get(salesMan.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(salesMan, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			salesManService.save(t);//保存
		}else{//新增表单保存
			salesManService.save(salesMan);//保存
		}
		addMessage(redirectAttributes, "保存销售人员成功");
		return "redirect:"+Global.getAdminPath()+"/sales/salesMan/?repage";
	}
	
	/**
	 * 删除销售人员
	 */
	@RequiresPermissions("sales:salesMan:del")
	@RequestMapping(value = "delete")
	public String delete(SalesMan salesMan, RedirectAttributes redirectAttributes) {
		salesManService.delete(salesMan);
		addMessage(redirectAttributes, "删除销售人员成功");
		return "redirect:"+Global.getAdminPath()+"/sales/salesMan/?repage";
	}
	
	/**
	 * 批量删除销售人员
	 */
	@RequiresPermissions("sales:salesMan:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			salesManService.delete(salesManService.get(id));
		}
		addMessage(redirectAttributes, "删除销售人员成功");
		return "redirect:"+Global.getAdminPath()+"/sales/salesMan/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("sales:salesMan:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(SalesMan salesMan, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "销售人员"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<SalesMan> page = salesManService.findPage(new Page<SalesMan>(request, response, -1), salesMan);
    		new ExportExcel("销售人员", SalesMan.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出销售人员记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/sales/salesMan/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("sales:salesMan:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<SalesMan> list = ei.getDataList(SalesMan.class);
			for (SalesMan salesMan : list){
				try{
					salesManService.save(salesMan);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条销售人员记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条销售人员记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入销售人员失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/sales/salesMan/?repage";
    }
	
	/**
	 * 下载导入销售人员数据模板
	 */
	@RequiresPermissions("sales:salesMan:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "销售人员数据导入模板.xlsx";
    		List<SalesMan> list = Lists.newArrayList(); 
    		new ExportExcel("销售人员数据", SalesMan.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/sales/salesMan/?repage";
    }
	
	
	

}