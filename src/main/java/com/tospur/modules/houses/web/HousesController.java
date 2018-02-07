/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.houses.web;

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
import com.tospur.modules.houses.entity.Houses;
import com.tospur.modules.houses.service.HousesService;

/**
 * 房型Controller
 * @author jinyin
 * @version 2018-02-01
 */
@Controller
@RequestMapping(value = "${adminPath}/houses/houses")
public class HousesController extends BaseController {

	@Autowired
	private HousesService housesService;
	@Autowired
	private CasesService casesService;
	
	@ModelAttribute
	public Houses get(@RequestParam(required=false) String id) {
		Houses entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = housesService.get(id);
		}
		if (entity == null){
			entity = new Houses();
		}
		return entity;
	}
	
	/**
	 * 房型列表页面
	 */
	@RequiresPermissions("houses:houses:list")
	@RequestMapping(value = {"list", ""})
	public String list(Houses houses, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Houses> page = housesService.findPage(new Page<Houses>(request, response), houses); 
		model.addAttribute("page", page);
		return "modules/houses/housesList";
	}

	/**
	 * 查看，增加，编辑房型表单页面
	 */
	@RequiresPermissions(value={"houses:houses:view","houses:houses:add","houses:houses:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(Houses houses, Model model) {
		List<Cases> casesList = casesService.getAllCasesList();
		model.addAttribute("casesList", casesList);
		model.addAttribute("houses", houses);
		return "modules/houses/housesForm";
	}

	/**
	 * 保存房型
	 */
	@RequiresPermissions(value={"houses:houses:add","houses:houses:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(Houses houses, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, houses)){
			return form(houses, model);
		}
		if(!houses.getIsNewRecord()){//编辑表单保存
			Houses t = housesService.get(houses.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(houses, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			housesService.save(t);//保存
		}else{//新增表单保存
			housesService.save(houses);//保存
		}
		addMessage(redirectAttributes, "保存房型成功");
		return "redirect:"+Global.getAdminPath()+"/houses/houses/?repage";
	}
	
	/**
	 * 删除房型
	 */
	@RequiresPermissions("houses:houses:del")
	@RequestMapping(value = "delete")
	public String delete(Houses houses, RedirectAttributes redirectAttributes) {
		housesService.delete(houses);
		addMessage(redirectAttributes, "删除房型成功");
		return "redirect:"+Global.getAdminPath()+"/houses/houses/?repage";
	}
	
	/**
	 * 批量删除房型
	 */
	@RequiresPermissions("houses:houses:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			housesService.delete(housesService.get(id));
		}
		addMessage(redirectAttributes, "删除房型成功");
		return "redirect:"+Global.getAdminPath()+"/houses/houses/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("houses:houses:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(Houses houses, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "房型"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<Houses> page = housesService.findPage(new Page<Houses>(request, response, -1), houses);
    		new ExportExcel("房型", Houses.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出房型记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/houses/houses/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("houses:houses:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<Houses> list = ei.getDataList(Houses.class);
			for (Houses houses : list){
				try{
					housesService.save(houses);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条房型记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条房型记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入房型失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/houses/houses/?repage";
    }
	
	/**
	 * 下载导入房型数据模板
	 */
	@RequiresPermissions("houses:houses:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "房型数据导入模板.xlsx";
    		List<Houses> list = Lists.newArrayList(); 
    		new ExportExcel("房型数据", Houses.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/houses/houses/?repage";
    }
	
	
	

}