/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.product.web;

import java.util.List;
import java.util.Map;

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
import com.tospur.modules.product.entity.Iterater;
import com.tospur.modules.product.entity.Product;
import com.tospur.modules.product.service.ProductService;


/**
 * 产品信息Controller
 * @author jinyin
 * @version 2017-08-29
 */
@Controller
@RequestMapping(value = "${adminPath}/product/product")
public class ProductController extends BaseController {

	@Autowired
	private ProductService productService;
	/*@Autowired
    private IteraterService iteraterService;*/
	
	@ModelAttribute
	public Product get(@RequestParam(required=false) String id) {
		Product entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = productService.get(id);
		}
		if (entity == null){
			entity = new Product();
		}
		return entity;
	}
	
	/**
	 * 产品列表页面
	 */
	@RequiresPermissions("product:product:list")
	@RequestMapping(value = {"list", ""})
	public String list(Product product, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Product> page = productService.findPage(new Page<Product>(request, response), product); 
		model.addAttribute("page", page);
		return "modules/product/productList";
	}

	/**
	 * 编辑产品表单页面
	 */
	@RequiresPermissions(value={"product:product:view","product:product:add","product:product:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(Product product, Model model) {
	
	    model.addAttribute("product", product);
		return "modules/product/productUpdate";
	}
	/**
	 * 查看产品表单页面
	 */
	@RequiresPermissions(value={"product:product:view","product:product:add","product:product:edit"},logical=Logical.OR)
	@RequestMapping(value = "look")
	public String look(Product product, Model model) {
	    
	   
	    model.addAttribute("ntime", System.currentTimeMillis());
	    model.addAttribute("product", product);
	    return "modules/product/product";
	}
	/**
	 * 添加产品表单页面
	 */
	@RequiresPermissions(value={"product:product:view","product:product:add","product:product:edit"},logical=Logical.OR)
	@RequestMapping(value = "add")
	public String add(Product product, Model model) {
	    
	    model.addAttribute("product", product);
	    return "modules/product/productForm";
	}
	/**
	 * 查看，增加，编辑迭代表单页面
	 */
	@RequiresPermissions(value={"product:product:view","product:product:add","product:product:edit"},logical=Logical.OR)
	@RequestMapping(value = "iterForm")
	public String iterForm(Product product ,Model model) {
	    
	    Iterater iterater = new Iterater();
	    iterater.setProduct(product.getName());
        model.addAttribute("iterater", iterater);
	    model.addAttribute("product", product);
	    return "modules/product/iteraterForm";
	}


	/*
	 * 得到产品信息并回显
	 */
     @ResponseBody
	 @RequestMapping(value = "getProduct")
	public Product getProduct(String id){
	   
	   Product data =   productService.get(id);
	  
	  return data;
	   // return null;
	}
     /*
      * 得到产品名称进行校验
      */
     @ResponseBody
     @RequestMapping(value = "getProductName")
     public JSONObject getProductName(){
         JSONObject data=new JSONObject();
         List<Map<String,Object>> productName=   productService.getProductName();
       
         data.put("productName", productName);
         return data;
         // return null;
     }

	




	/**
	 * 保存产品
	 */
	@RequiresPermissions(value={"product:product:add","product:product:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(Product product, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, product)){
			return form(product, model);
		}
		if(!product.getIsNewRecord()){//编辑表单保存
			Product t = productService.get(product.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(product, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			productService.save(t);//保存
		}else{//新增表单保存
		   /* String iterater = product.getIterater();
		    if(iterater==null){
		        product.setIterater("0");
		    }*/
		    product.setIterNum(0);
			productService.save(product);//保存
		}
		addMessage(redirectAttributes, "保存产品成功");
		return "redirect:"+Global.getAdminPath()+"/product/product/?repage";
	}
	
	/**
	 * 删除产品
	 */
	@RequiresPermissions("product:product:del")
	@RequestMapping(value = "delete")
	public String delete(Product product, RedirectAttributes redirectAttributes) {
		productService.delete(product);
		addMessage(redirectAttributes, "删除产品成功");
		return "redirect:"+Global.getAdminPath()+"/product/product/?repage";
	}
	
	/**
	 * 批量删除产品
	 */
	@RequiresPermissions("product:product:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			productService.delete(productService.get(id));
		}
		addMessage(redirectAttributes, "删除产品成功");
		return "redirect:"+Global.getAdminPath()+"/product/product/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("product:product:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(Product product, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "产品"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<Product> page = productService.findPage(new Page<Product>(request, response, -1), product);
    		new ExportExcel("产品", Product.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出产品记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/product/product/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("product:product:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<Product> list = ei.getDataList(Product.class);
			for (Product product : list){
				try{
					productService.save(product);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条产品记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条产品记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入产品失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/product/product/?repage";
    }
	
	/**
	 * 下载导入产品数据模板
	 */
	@RequiresPermissions("product:product:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "产品数据导入模板.xlsx";
    		List<Product> list = Lists.newArrayList(); 
    		new ExportExcel("产品数据", Product.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/product/product/?repage";
    }
	
	
	

}