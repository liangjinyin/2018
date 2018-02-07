/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.product.web;

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
import com.tospur.modules.product.entity.Iterater;
import com.tospur.modules.product.entity.Product;
import com.tospur.modules.product.service.IteraterService;
import com.tospur.modules.product.service.ProductService;


/**
 * 迭代信息Controller
 * @author jinyin
 * @version 2017-08-30
 */
@Controller
@RequestMapping(value = "${adminPath}/iterater/iterater")
public class IteraterController extends BaseController {

	@Autowired
	private IteraterService iteraterService;
	@Autowired
    private ProductService productService;
	
	@ModelAttribute
	public Iterater get(@RequestParam(required=false) String id) {
		Iterater entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = iteraterService.get(id);
		}
		if (entity == null){
			entity = new Iterater();
		}
		return entity;
	}
	
	

	/**
	 * 编辑迭代表单页面
	 */
	@RequiresPermissions(value={"iterater:iterater:view","iterater:iterater:add","iterater:iterater:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(Iterater iterater, Model model) {
	   
	    System.out.println("########"+iterater.getProduct());
		model.addAttribute("iterater", iterater);
		return "modules/product/iteraterForm";
	}

	/**
	 * 保存迭代
	 */
	@RequiresPermissions(value={"iterater:iterater:add","iterater:iterater:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(Iterater iterater, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, iterater)){
			return form(iterater, model);
		}
		if(!iterater.getIsNewRecord()){//编辑表单保存
			Iterater t = iteraterService.get(iterater.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(iterater, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			iteraterService.save(t);//保存
		}else{//新增表单保存
			iteraterService.save(iterater);//保存
			Product product =	productService.getByName(iterater.getProduct());
			
			Product temp = productService.get(product.getId());
			if(temp.getIterNum()==null){
			    temp.setIterNum(1);
			}else{
			    temp.setIterNum(temp.getIterNum()+1);
			}
			if(temp.getIterater()!=null){
			    
			    temp.setIterater(iterater.getName()+","+temp.getIterater());
			}else{
			    temp.setIterater(iterater.getName());
			}
			productService.save(temp);
		}
		addMessage(redirectAttributes, "保存迭代成功");
		return "redirect:"+Global.getAdminPath()+"/product/product/?repage";
	}
	
	/**
	 * 删除迭代
	 */
	@RequiresPermissions("iterater:iterater:del")
	@RequestMapping(value = "delete")
	public String delete(Iterater iterater, RedirectAttributes redirectAttributes) {
		iteraterService.delete(iterater);
		addMessage(redirectAttributes, "删除迭代成功");
		return "redirect:"+Global.getAdminPath()+"/iterater/iterater/?repage";
	}
	
	/**
	 * 批量删除迭代
	 */
	@RequiresPermissions("iterater:iterater:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			iteraterService.delete(iteraterService.get(id));
		}
		addMessage(redirectAttributes, "删除迭代成功");
		return "redirect:"+Global.getAdminPath()+"/iterater/iterater/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("iterater:iterater:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(Iterater iterater, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "迭代"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<Iterater> page = iteraterService.findPage(new Page<Iterater>(request, response, -1), iterater);
    		new ExportExcel("迭代", Iterater.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出迭代记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/iterater/iterater/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("iterater:iterater:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<Iterater> list = ei.getDataList(Iterater.class);
			for (Iterater iterater : list){
				try{
					iteraterService.save(iterater);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条迭代记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条迭代记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入迭代失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/iterater/iterater/?repage";
    }
	
	/**
	 * 下载导入迭代数据模板
	 */
	@RequiresPermissions("iterater:iterater:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "迭代数据导入模板.xlsx";
    		List<Iterater> list = Lists.newArrayList(); 
    		new ExportExcel("迭代数据", Iterater.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/iterater/iterater/?repage";
    }
	
	
	

}