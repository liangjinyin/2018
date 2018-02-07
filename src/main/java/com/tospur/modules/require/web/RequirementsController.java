package com.tospur.modules.require.web;


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

import com.google.common.collect.Lists;
import com.tospur.common.config.Global;
import com.tospur.common.persistence.Page;
import com.tospur.common.utils.DateUtils;
import com.tospur.common.utils.MyBeanUtils;
import com.tospur.common.utils.StringUtils;
import com.tospur.common.utils.excel.ExportExcel;
import com.tospur.common.utils.excel.ImportExcel;
import com.tospur.common.web.BaseController;
import com.tospur.modules.customer.entity.Customer;
import com.tospur.modules.customer.service.CustomerService;
import com.tospur.modules.project.entity.Project;
import com.tospur.modules.project.service.ProjectService;
import com.tospur.modules.require.entity.Requirements;
import com.tospur.modules.require.service.RequirementsService;

/**
 * 需求信息Controller
 * @author kiss
 * @version 2017-02-14
 */
@Controller
@RequestMapping(value = "${adminPath}/require/requirements")
public class RequirementsController extends BaseController {

	@Autowired
	private RequirementsService requirementsService;
	@Autowired
    private ProjectService projectService;
	@Autowired
	private CustomerService customerService;
    
	@ModelAttribute
	public Requirements get(@RequestParam(required=false) String id) {
		Requirements entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = requirementsService.get(id);
		}
		if (entity == null){
			entity = new Requirements();
		}
		return entity;
	}
	
	/**
	 * 需求列表页面
	 */
	@RequiresPermissions("require:requirements:list")
	@RequestMapping(value = {"list", ""})
	public String list(Requirements requirements, HttpServletRequest request, HttpServletResponse response, Model model) {
	   
		Page<Requirements> page = requirementsService.findPage(new Page<Requirements>(request, response), requirements); 
		model.addAttribute("page", page);
		return "modules/require/requirementsList";
	}

	/**
	 * 查看，增加，编辑需求表单页面
	 */
	@RequiresPermissions(value={"require:requirements:view","require:requirements:add","require:requirements:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(Requirements requirements, Model model) {
	    
	    if(requirements!=null&&"1".equals(requirements.getOp())){//查看
	        Project pro=new Project();
	        pro.setRequirements(requirements.getId());
	        Project project= projectService.get(pro);
            model.addAttribute("project", project);
        }


	    model.addAttribute("requirements", requirements);
		
		return "modules/require/requirementsForm";
	}
	/*
	 * 得到客户信息并回显
	 */
     @ResponseBody
	 @RequestMapping(value = "getCustomer")
	public Customer getCustomer(String id){
	   
	   Customer data =   customerService.get(id, null);
	  
	  return data;
	  
	}
	
	/*
	 * 得到需求信息并回显
	 */
    /* @ResponseBody
	 @RequestMapping(value = "getEvaluation")
	public Requirements getEvaluation(String id){
	   
	   Requirements data =  requirementsService.get(id);
 
	  return data;
	   
	}*/
	
	
	
	
	/**
	 * 保存需求
	 */
	@RequiresPermissions(value={"require:requirements:add","require:requirements:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(Requirements requirements, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, requirements)){
			return form(requirements, model);
		}
		if(!requirements.getIsNewRecord()){//编辑表单保存
		    //更新同步project信息
		    Project pro=new Project();
	        pro.setRequirements(requirements.getId());
	        Project project= projectService.get(pro);
	        if(project!=null){
	            project.setType(requirements.getProduct());
	            project.setSaleManager(requirements.getSaleManager());
	            project.setPreSaleManager(requirements.getPreSaleManager());
	            project.setDepartment(requirements.getDepartment());
	            projectService.save(project);//保存
	        }
		    
			Requirements t = requirementsService.get(requirements.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(requirements, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			
			
                requirementsService.save(t);//保存
           
		}else{//新增表单保存
		   
           
			requirementsService.save(requirements);//保存
		}
		addMessage(redirectAttributes, "保存需求成功");
		return "redirect:"+Global.getAdminPath()+"/require/requirements/?repage";
	}
	
	/**
	 * 删除需求
	 */
	@RequiresPermissions("require:requirements:del")
	@RequestMapping(value = "delete")
	public String delete(Requirements requirements, RedirectAttributes redirectAttributes) {
		requirementsService.delete(requirements);
		addMessage(redirectAttributes, "删除需求成功");
		return "redirect:"+Global.getAdminPath()+"/require/requirements/?repage";
	}
	
	/**
	 * 批量删除需求
	 */
	@RequiresPermissions("require:requirements:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			requirementsService.delete(requirementsService.get(id));
		}
		addMessage(redirectAttributes, "删除需求成功");
		return "redirect:"+Global.getAdminPath()+"/require/requirements/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("require:requirements:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(Requirements requirements, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "需求"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<Requirements> page = requirementsService.findPage(new Page<Requirements>(request, response, -1), requirements);
    		new ExportExcel("需求", Requirements.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出需求记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/require/requirements/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("require:requirements:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<Requirements> list = ei.getDataList(Requirements.class);
			for (Requirements requirements : list){
				try{
					requirementsService.save(requirements);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条需求记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条需求记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入需求失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/require/requirements/?repage";
    }
	
	/**
	 * 下载导入需求数据模板
	 */
	@RequiresPermissions("require:requirements:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "需求数据导入模板.xlsx";
    		List<Requirements> list = Lists.newArrayList(); 
    		new ExportExcel("需求数据", Requirements.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/require/requirements/?repage";
    }

}