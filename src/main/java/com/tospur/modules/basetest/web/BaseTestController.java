/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.basetest.web;

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
import com.tospur.modules.basetest.entity.BaseTest;
import com.tospur.modules.basetest.service.BaseTestService;

/**
 * 基线测试Controller
 * @author jinyin
 * @version 2017-09-18
 */
@Controller
@RequestMapping(value = "${adminPath}/basetest/baseTest")
public class BaseTestController extends BaseController {

	@Autowired
	private BaseTestService baseTestService;
	
	@ModelAttribute
	public BaseTest get(@RequestParam(required=false) String id) {
		BaseTest entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = baseTestService.get(id);
		}
		if (entity == null){
			entity = new BaseTest();
		}
		return entity;
	}
	
	/**
	 * 基线测试列表页面
	 */
	@RequiresPermissions("basetest:baseTest:list")
	@RequestMapping(value = {"list", ""})
	public String list(BaseTest baseTest, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BaseTest> page = baseTestService.findPage(new Page<BaseTest>(request, response), baseTest); 
		model.addAttribute("page", page);
		return "modules/basetest/baseTestList";
	}

	/**
	 * 查看，增加，编辑基线测试表单页面
	 */
	@RequiresPermissions(value={"basetest:baseTest:view","basetest:baseTest:add","basetest:baseTest:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(BaseTest baseTest, Model model) {
		model.addAttribute("baseTest", baseTest);
		return "modules/basetest/baseTestForm";
	}

	/**
	 * 保存基线测试
	 */
	@RequiresPermissions(value={"basetest:baseTest:add","basetest:baseTest:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(BaseTest baseTest, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, baseTest)){
			return form(baseTest, model);
		}
		if(!baseTest.getIsNewRecord()){//编辑表单保存
			BaseTest t = baseTestService.get(baseTest.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(baseTest, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			baseTestService.save(t);//保存
		}else{//新增表单保存
			baseTestService.save(baseTest);//保存
		}
		addMessage(redirectAttributes, "保存基线测试成功");
		return "redirect:"+Global.getAdminPath()+"/basetest/baseTest/?repage";
	}
	
	/**
	 * 删除基线测试
	 */
	@RequiresPermissions("basetest:baseTest:del")
	@RequestMapping(value = "delete")
	public String delete(BaseTest baseTest, RedirectAttributes redirectAttributes) {
		baseTestService.delete(baseTest);
		addMessage(redirectAttributes, "删除基线测试成功");
		return "redirect:"+Global.getAdminPath()+"/basetest/baseTest/?repage";
	}
	
	/**
	 * 批量删除基线测试
	 */
	@RequiresPermissions("basetest:baseTest:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			baseTestService.delete(baseTestService.get(id));
		}
		addMessage(redirectAttributes, "删除基线测试成功");
		return "redirect:"+Global.getAdminPath()+"/basetest/baseTest/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("basetest:baseTest:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(BaseTest baseTest, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "基线测试"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<BaseTest> page = baseTestService.findPage(new Page<BaseTest>(request, response, -1), baseTest);
    		new ExportExcel("基线测试", BaseTest.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出基线测试记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/basetest/baseTest/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("basetest:baseTest:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<BaseTest> list = ei.getDataList(BaseTest.class);
			for (BaseTest baseTest : list){
				try{
					baseTestService.save(baseTest);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条基线测试记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条基线测试记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入基线测试失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/basetest/baseTest/?repage";
    }
	
	/**
	 * 下载导入基线测试数据模板
	 */
	@RequiresPermissions("basetest:baseTest:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "基线测试数据导入模板.xlsx";
    		List<BaseTest> list = Lists.newArrayList(); 
    		new ExportExcel("基线测试数据", BaseTest.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/basetest/baseTest/?repage";
    }
	
	
	

}