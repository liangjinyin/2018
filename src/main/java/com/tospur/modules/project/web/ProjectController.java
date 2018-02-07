package com.tospur.modules.project.web;


import java.util.Date;
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
import com.tospur.modules.iim.entity.Mail;
import com.tospur.modules.iim.entity.MailBox;
import com.tospur.modules.iim.entity.MailCompose;
import com.tospur.modules.iim.service.MailBoxService;
import com.tospur.modules.iim.service.MailComposeService;
import com.tospur.modules.iim.service.MailService;
import com.tospur.modules.niche.service.InvestmentInfoService;
import com.tospur.modules.project.entity.Project;
import com.tospur.modules.project.entity.ProjectEmail;
import com.tospur.modules.project.entity.ProjectLog;
import com.tospur.modules.project.service.ProjectEmailService;
import com.tospur.modules.project.service.ProjectLogService;
import com.tospur.modules.project.service.ProjectService;
import com.tospur.modules.require.entity.Requirements;
import com.tospur.modules.require.service.RequirementsService;
import com.tospur.modules.sys.entity.User;
import com.tospur.modules.sys.utils.DictUtils;
import com.tospur.modules.sys.utils.UserUtils;

/**
 * 项目信息Controller
 * @author kiss
 * @version 2017-02-14
 */
@Controller
@RequestMapping(value = "${adminPath}/project/project")
public class ProjectController extends BaseController {

	@Autowired
	private ProjectService projectService;
	@Autowired
	private RequirementsService requirementsService;
	@Autowired
    private ProjectLogService projectLogService;
	@Autowired
    private InvestmentInfoService investmentInfoService;
	@Autowired
	private CustomerService customerService;
	@Autowired
	private ProjectEmailService projectEmailService;
	
	@ModelAttribute
	public Project get(@RequestParam(required=false) String id, @RequestParam(required=false) String op) {
		Project entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = projectService.get(id, op);
		}
		if (entity == null){
			entity = new Project();
		}
		return entity;
	}
	/**
     * 项目列表页面
     */
   
    @RequestMapping(value = "day")// /project/project/day
    @ResponseBody
    public String testSend() {
        projectService.sendMailByDay();
        investmentInfoService.sendMail();
        return "发送成功!";
    }
    
    /**
     * 项目列表页面
     */
    @RequestMapping(value = "week")// /project/project/week
    @ResponseBody
    public String weekSend() {
        //projectService.sendMailByDay();
        projectService.sendMailByWeek();
        return "发送成功!";
    }
	/**
	 * 项目列表页面
	 */
	@RequiresPermissions("project:project:list")
	@RequestMapping(value = {"list", ""})
	public String list(Project project, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Project> page = projectService.findPage(new Page<Project>(request, response), project); 
		//projectService.sendMail();
		model.addAttribute("page", page);
		return "modules/project/projectList";
	}

	/**
	 * 查看，增加，编辑项目表单页面
	 */
	@RequiresPermissions(value={"project:project:view","project:project:add","project:project:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(Project project, Model model) {
	  
		 if(project!=null&&"1".equals(project.getOp())){
		    ProjectLog projectLog=new ProjectLog();
		    projectLog.setProject(project.getId());
		    List<ProjectLog> logs=projectLogService.findList(projectLog);
		    model.addAttribute("logs", logs);
		   
		     String requirement =project.getRequirements();
	         Requirements requirements =  requirementsService.get(requirement);
	         model.addAttribute("requirements",requirements);
	         
	         Customer customer = customerService.get(requirements.getCustomer(), null);
	         model.addAttribute("customer", customer);
	          
		}
         
	    model.addAttribute("project", project);
		return "modules/project/projectForm";
	}
	
	/**
     * 查看，增加，编辑项目表单页面
     */
    @RequiresPermissions(value={"project:project:view","project:project:add","project:project:edit"},logical=Logical.OR)
    @RequestMapping(value = "logform")
    public String logform(Project project, Model model) {
            project.setRemark("");
            project.setStage("");
            //ProjectLog projectLog=new ProjectLog();
            //projectLog.setProject(project.getId());
            //List<ProjectLog> logs=projectLogService.findList(projectLog);
            //model.addAttribute("logs", logs);
            ProjectLog log = new ProjectLog();
            log.setProject(project.getId());
            model.addAttribute("log", log);
            model.addAttribute("project", project);
           return "modules/project/projectTrack";
    }
	

	/**
	 * 保存项目
	 */
	@RequiresPermissions(value={"project:project:add","project:project:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(Project project, Model model, RedirectAttributes redirectAttributes) throws Exception{
	    String content = "";
	    Mail mail = null;
	    ProjectEmail projectEmail = new ProjectEmail();
	    List<ProjectEmail> projectEmails = projectEmailService.findAllList();
	    if(projectEmails.size() != 0){
	        projectEmail = projectEmails.get(0);
	    }
	    Requirements requirements = requirementsService.get(project.getRequirements());
	    Customer customer = customerService.get(requirements.getCustomer(), null);
		if (!beanValidator(model, project)){
			return form(project, model);
		}
		if(!project.getIsNewRecord()){//编辑表单保存
			Project t = projectService.get(project.getId());//从数据库取出记录的值
			
			if(project.getName().equals(t.getName())){
			    content += "项目名称：&nbsp;"+project.getName()+"<br/>";
			}else{
			    content += "项目名称：&nbsp;"+project.getName()+"(新值)，"+t.getName()+"(旧值)"+"<br/>";
			}
			if(project.getRequirements().equals(t.getRequirements())){
			    content += "需求名称：&nbsp;"+requirements.getName()+"<br/>"+
	                    "需求联系人：&nbsp;"+customer.getContacts()+"<br/>"+
	                    "需求部门：&nbsp;"+requirements.getDepartment()+"<br/>"+
	                    "所属行业：&nbsp;"+customer.getIndustry()+"<br/>"+
	                    "产品/服务：&nbsp;"+requirements.getProduct()+"<br/>"+
	                    "项目所属区域：&nbsp;"+customer.getProjectBelong()+"<br/>"+
	                    "销售负责人：&nbsp;"+requirements.getSaleManager()+"<br/>"+
	                    "售前负责人：&nbsp;"+requirements.getPreSaleManager()+"<br/>";
			}else{
			    Requirements r = requirementsService.get(t.getRequirements());
			    Customer c = customerService.get(r.getCustomer(), null);
			    content += "需求名称：&nbsp;"+requirements.getName()+"(新值)，"+r.getName()+"(旧值)"+"<br/>"+
	                    "需求联系人：&nbsp;"+customer.getContacts()+"(新值)，"+c.getContacts()+"(旧值)"+"<br/>"+
	                    "需求部门：&nbsp;"+requirements.getDepartment()+"(新值)，"+r.getDepartment()+"(旧值)"+"<br/>"+
	                    "所属行业：&nbsp;"+customer.getIndustry()+"(新值)，"+c.getIndustry()+"(旧值)"+"<br/>"+
	                    "产品/服务：&nbsp;"+requirements.getProduct()+"(新值)，"+r.getProduct()+"(旧值)"+"<br/>"+
	                    "项目所属区域：&nbsp;"+customer.getProjectBelong()+"(新值)，"+c.getProjectBelong()+"(旧值)"+"<br/>"+
	                    "销售负责人：&nbsp;"+requirements.getSaleManager()+"(新值)，"+r.getSaleManager()+"(旧值)"+"<br/>"+
	                    "售前负责人：&nbsp;"+requirements.getPreSaleManager()+"(新值)，"+r.getPreSaleManager()+"(旧值)"+"<br/>";
			}
			if(project.getDecisionProcess().equals(t.getDecisionProcess())){
			    content += "决策流程：&nbsp;"+project.getDecisionProcess()+"<br/>";
			}else{
			    content += "决策流程：&nbsp;"+project.getDecisionProcess()+"(新值)，"+t.getDecisionProcess()+"(旧值)"+"<br/>";
			}
			if(project.getDecisionManager().equals(t.getDecisionManager())){
			    content += "决策人(电话)：&nbsp;"+project.getDecisionManager()+"<br/>";
			}else{
			    content += "决策人(电话)：&nbsp;"+project.getDecisionManager()+"(新值)，"+t.getDecisionManager()+"(旧值)"+"<br/>";
			}
			if(project.getCoreManager().equals(t.getCoreManager())){
			    content += "关键人(电话)：&nbsp;"+project.getCoreManager()+"<br/>";
			}else{
			    content += "关键人(电话)：&nbsp;"+project.getCoreManager()+"(新值)，"+t.getCoreManager()+"(旧值)"+"<br/>";
			}
			if(project.getCompetitor().equals(t.getCompetitor())){
			    content += "竞争对手及动态：&nbsp;"+project.getCompetitor()+"<br/>";
			}else{
			    content += "竞争对手及动态：&nbsp;"+project.getCompetitor()+"(新值)，"+t.getCompetitor()+"(旧值)"+"<br/>";
			}
			if(project.getRelationship().equals(t.getRelationship())){
			    content += "是否有内线：&nbsp;"+project.getRelationship()+"<br/>";
			}else{
			    content += "是否有内线：&nbsp;"+project.getRelationship()+"(新值)，"+t.getRelationship()+"(旧值)"+"<br/>";
			}
			if(project.getBudget().equals(t.getBudget())){
			    content += "客户预算金额：&nbsp;"+project.getBudget()+" 万<br/>";
			}else{
			    content += "客户预算金额：&nbsp;"+project.getBudget()+" 万(新值)，"+t.getBudget()+" 万(旧值)"+"<br/>";
			}
			if(project.getQuotation().equals(t.getQuotation())){
			    content += "我方对外报价金额：&nbsp;"+project.getQuotation()+" 万<br/>";
			}else{
			    content += "我方对外报价金额：&nbsp;"+project.getQuotation()+" 万(新值)，"+t.getQuotation()+" 万(旧值)"+"<br/>";
			}
			if(project.getCost().equals(t.getCost())){
			    content += "我方成本金额：&nbsp;"+project.getCost()+" 万<br/>";
			}else{
			    content += "我方成本金额：&nbsp;"+project.getCost()+" 万(新值)，"+t.getCost()+" 万(旧值)"+"<br/>";
			}
			if(project.getOrderRate() == null){
			    content += "预计下单几率：&nbsp;"+project.getOrderRate()+"<br/>";
			}else if(project.getOrderRate().equals(t.getOrderRate())){
			    content += "预计下单几率：&nbsp;"+project.getOrderRate()+" %<br/>";
			}else{
			    content += "预计下单几率：&nbsp;"+project.getOrderRate()+" %(新值)，"+t.getOrderRate()+" %(旧值)"+"<br/>";
			}
			if(project.getOrderDate() == null){
			    content += "预计下单时间：&nbsp;"+project.getOrderDate()+"<br/>";
			}else if(project.getOrderDate().equals(t.getOrderDate())){
			    content += "预计下单时间：&nbsp;"+DateUtils.formatDateTime(project.getOrderDate())+"<br/>";
			}else{
			    content += "预计下单时间：&nbsp;"+DateUtils.formatDateTime(project.getOrderDate())+"(新值)，"+DateUtils.formatDateTime(t.getOrderDate())+"(旧值)"+"<br/>";
			}
			if(project.getAdvanceService().equals(t.getAdvanceService())){
			    content +=  "是否提前投入：&nbsp;"+project.getAdvanceService()+"<br/>";
			}else{
			    content +=  "是否提前投入：&nbsp;"+project.getAdvanceService()+"(新值)，"+t.getAdvanceService()+"(旧值)"+"<br/>";
			}
			if(project.getStage().equals(t.getStage())){
			    content += "项目所处阶段：&nbsp;"+project.getStage()+"<br/>";
			}else{
			    content += "项目所处阶段：&nbsp;"+project.getStage()+"(新值)，"+t.getStage()+"(旧值)"+"<br/>";
			}
			if(project.getBid().equals(t.getBid())){
			    content += "是否投标：&nbsp;"+project.getBid()+"<br/>";
			}else{
			    content += "是否投标：&nbsp;"+project.getBid()+"(新值)，"+t.getBid()+"(旧值)"+"<br/>";
			}
			if(project.getCoreDate() == null){
			    content +=  "项目关键时间点：&nbsp;"+project.getCoreDate()+"<br/>";
			}else if(project.getCoreDate().equals(t.getCoreDate())){
			    content +=  "项目关键时间点：&nbsp;"+DateUtils.formatDateTime(project.getCoreDate())+"<br/>";
			}else{
			    content +=  "项目关键时间点：&nbsp;"+DateUtils.formatDateTime(project.getCoreDate())+"(新值)，"+DateUtils.formatDateTime(t.getCoreDate())+"(旧值)"+"<br/>";
			}
			if(project.getProjectRisk().equals(t.getProjectRisk())){
			    content +=  "项目风险：&nbsp;"+project.getProjectRisk()+"<br/>";
			}else{
			    content +=  "项目风险：&nbsp;"+project.getProjectRisk()+"(新值)，"+t.getProjectRisk()+"(旧值)"+"<br/>";
			}
			if(project.getCopingStrategies().equals(t.getCopingStrategies())){
			    content += "应对策略：&nbsp;"+project.getCopingStrategies()+"<br/>";
			}else{
			    content += "应对策略：&nbsp;"+project.getCopingStrategies()+"(新值)，"+t.getCopingStrategies()+"(旧值)"+"<br/>";
			}
			if(project.getSigningTime() == null){
			    content += "签约时间：&nbsp;"+project.getSigningTime()+"<br/>";
			}else if(project.getSigningTime().equals(t.getSigningTime())){
			    content += "签约时间：&nbsp;"+DateUtils.formatDateTime(project.getSigningTime())+"<br/>";
			}else{
			    content +="签约时间：&nbsp;"+DateUtils.formatDateTime(project.getSigningTime())+"(新值)，"+DateUtils.formatDateTime(t.getSigningTime())+"(旧值)"+"<br/>";
			}
			if(project.getContractAmount().equals(t.getContractAmount())){
			    content += "合同金额：&nbsp;"+project.getContractAmount()+" 万<br/>";
			}else{
			    content += "合同金额：&nbsp;"+project.getContractAmount()+" 万(新值)，"+t.getContractAmount()+" 万(旧值)"+"<br/>";
			}
			if(project.getMajorManager() == null || project.getMajorManager().equals(t.getMajorManager())){
			    content +=  "项目干系人：&nbsp;"+project.getMajorManager()+"<br/>";
			}else{
			    content +=  "项目干系人：&nbsp;"+project.getMajorManager()+"(新值)，"+t.getMajorManager()+"(旧值)"+"<br/>";
			}
			if(project.getProjectManager() == null || project.getProjectManager().equals(t.getProjectManager())){
			    content += "项目经理：&nbsp;"+project.getProjectManager()+"<br/>";
			}else{
			    content += "项目经理：&nbsp;"+project.getProjectManager()+"(新值)，"+t.getProjectManager()+"(旧值)"+"<br/>";
			}
			if(project.getRemark().equals(t.getRemark())){
			    content += "备注：&nbsp;"+project.getRemark()+"<br/><br/>";
			}else{
			    content += "备注：&nbsp;"+project.getRemark()+"(新值)，"+t.getRemark()+"(旧值)"+"<br/><br/>";
			}
			mail=new Mail("项目"+project.getName()+"已更新", "项目"+project.getName()+"已更新", content);
			MyBeanUtils.copyBeanNotNull2Bean(project, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			projectService.save(t);//保存
		}else{//新增表单保存
		    content = "项目名称：&nbsp;"+project.getName()+"<br/>"+
		            "需求名称：&nbsp;"+requirements.getName()+"<br/>"+
		            "需求联系人：&nbsp;"+customer.getContacts()+"<br/>"+
		            "需求部门：&nbsp;"+requirements.getDepartment()+"<br/>"+
		            "所属行业：&nbsp;"+customer.getIndustry()+"<br/>"+
		            "产品/服务：&nbsp;"+requirements.getProduct()+"<br/>"+
		            "项目所属区域：&nbsp;"+customer.getProjectBelong()+"<br/>"+
		            "销售负责人：&nbsp;"+requirements.getSaleManager()+"<br/>"+
		            "售前负责人：&nbsp;"+requirements.getPreSaleManager()+"<br/>"+
		            "决策流程：&nbsp;"+project.getDecisionProcess()+"<br/>"+
		            "决策人(电话)：&nbsp;"+project.getDecisionManager()+"<br/>"+
		            "关键人(电话)：&nbsp;"+project.getCoreManager()+"<br/>"+
		            "竞争对手及动态：&nbsp;"+project.getCompetitor()+"<br/>"+
		            "是否有内线：&nbsp;"+project.getRelationship()+"<br/>"+
		            "客户预算金额：&nbsp;"+project.getBudget()+" 万<br/>"+
		            "我方对外报价金额：&nbsp;"+project.getQuotation()+" 万<br/>"+
		            "我方成本金额：&nbsp;"+project.getCost()+" 万<br/>"+
		            "预计下单几率：&nbsp;"+project.getOrderRate()+" %<br/>";
		            if(project.getOrderDate() != null){
		                content +=  "预计下单时间：&nbsp;"+DateUtils.formatDateTime(project.getOrderRate())+"<br/>";
		            }else{
		                content += "预计下单时间：&nbsp;"+project.getOrderRate()+"<br/>";
		            }
		            content += "是否提前投入：&nbsp;"+project.getAdvanceService()+"<br/>"+
		            "项目所处阶段：&nbsp;"+project.getStage()+"<br/>"+
		            "是否投标：&nbsp;"+project.getBid()+"<br/>"+
		            "项目关键时间点：&nbsp;"+DateUtils.formatDateTime(project.getCoreDate())+"<br/>"+
		            "项目风险：&nbsp;"+project.getProjectRisk()+"<br/>"+
		            "应对策略：&nbsp;"+project.getCopingStrategies()+"<br/>";
		            if(project.getOrderDate() != null){
                        content +=  "签约时间：&nbsp;"+DateUtils.formatDateTime(project.getSigningTime())+"<br/>";
                    }else{
                        content += "签约时间：&nbsp;"+project.getSigningTime()+"<br/>";
                    }
		            content += "合同金额：&nbsp;"+project.getContractAmount()+" 万<br/>"+
		            "项目干系人：&nbsp;"+project.getMajorManager()+"<br/>"+
		            "项目经理：&nbsp;"+project.getProjectManager()+"<br/>"+
		            "备注：&nbsp;"+project.getRemark()+"<br/><br/>";
		    mail=new Mail("项目"+project.getName()+"已立项", "项目"+project.getName()+"已立项", content);
			projectService.save(project);//保存
		}
		if(projectEmail != null && !StringUtils.isEmpty(projectEmail.getReceiver())){
		   /*String content="项目销售负责人： &nbsp;"+project.getSaleManager()+"<br/>"+
		            "项目售前负责人： &nbsp;"+project.getPreSaleManager()+"<br/>"+
		            "项目类型： &nbsp;"+project.getPreSaleManager()+"<br/><br/>";
		    if("2".equals(project.getOp())){//标示项目跟踪处理
		        content+="项目变动记录：<br/>";
		        for (ProjectLog log :  project.getLogs())
                {
		            content+="主题： &nbsp;"+log.getTheme()+" &nbsp;&nbsp;日期：&nbsp;"+log.getCreateDateString()+"<br/>纪要：&nbsp;"+log.getSummary()+"<br/><br/>";
                }
		    }*/
		    sendMassage(mail, projectEmail.getReceiver());
		}
		addMessage(redirectAttributes, "保存项目成功");
		return "redirect:"+Global.getAdminPath()+"/project/project/?repage";
	}
	
	@Autowired
    private MailComposeService mailComposeService;
    @Autowired
    private MailBoxService mailBoxService;
    @Autowired
    private MailService mailService;
   
	private void sendMassage(Mail mail,String receiverNames){
	    
	    List<User> receiverList=Lists.newArrayList();
	    for (User user : DictUtils.fundUsers())
        {
            if(receiverNames!=null&&receiverNames.contains(user.getName())){
                receiverList.add(user);
            }
        }
	    MailCompose mailCompose=new MailCompose();
	    mailCompose.setStatus("1");
	    mailCompose.setReceiverList(receiverList);
	    mailService.saveOnlyMain(mail);
	    mailCompose.setMail(mail);
        Date date = new Date(System.currentTimeMillis());
        mailCompose.setSender(UserUtils.getUser());
        mailCompose.setSendtime(date);
        for(User receiver : receiverList){
            mailCompose.setReceiver(receiver);
            mailCompose.setId(null);//标记为新纪录，每次往发件箱插入一条记录
            mailCompose.setIsNewRecord(true);
            mailComposeService.save(mailCompose);//0 显示在草稿箱，1 显示在已发送需同时保存到收信人的收件箱。
            if(mailCompose.getStatus().equals("1"))//已发送，同时保存到收信人的收件箱
            {
                MailBox mailBox = new MailBox();
                mailBox.setReadstatus("0");
                mailBox.setReceiver(receiver);
                mailBox.setSender(UserUtils.getUser());
                mailBox.setMail(mailCompose.getMail());
                mailBox.setSendtime(date);
                mailBoxService.save(mailBox);
            }
        }
        
	}
	
	/**
	 * 删除项目
	 */
	@RequiresPermissions("project:project:del")
	@RequestMapping(value = "delete")
	public String delete(Project project, RedirectAttributes redirectAttributes) {
	    projectEmailService.delete(projectEmailService.findUniqueByProperty("project", project.getId()));
	    projectLogService.deleteByProject(project.getId());
		projectService.delete(project);
		addMessage(redirectAttributes, "删除项目成功");
		return "redirect:"+Global.getAdminPath()+"/project/project/?repage";
	}
	
	/**
	 * 批量删除项目
	 */
	@RequiresPermissions("project:project:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){ 
		    projectEmailService.delete(projectEmailService.findUniqueByProperty("project", id));
		    projectLogService.deleteByProject(id);
			projectService.delete(projectService.get(id));
		}
		addMessage(redirectAttributes, "删除项目成功");
		return "redirect:"+Global.getAdminPath()+"/project/project/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("project:project:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(Project project, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "项目"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<Project> page = projectService.findPage(new Page<Project>(request, response, -1), project);
    		new ExportExcel("项目", Project.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出项目记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/project/project/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("project:project:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<Project> list = ei.getDataList(Project.class);
			for (Project project : list){
				try{
					projectService.save(project);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条项目记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条项目记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入项目失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/project/project/?repage";
    }
	
	/**
	 * 下载导入项目数据模板
	 */
	@RequiresPermissions("project:project:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "项目数据导入模板.xlsx";
    		List<Project> list = Lists.newArrayList(); 
    		new ExportExcel("项目数据", Project.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/project/project/?repage";
    }
	
	/**
     * 根据project中的requirements查询requirements对象
     */
    @RequestMapping(value="requirements") //  /project/project/requirements
    @ResponseBody
    public Requirements findRequirements(String id) {
        return requirementsService.get(id);
    }
    
	/**
	 * 根据requirements中的customer查询customer对象
	 */
	@RequestMapping(value="customer") //  /project/project/customer
	@ResponseBody
	public Customer findCustomer(String id) {
	    return customerService.get(id, null);
	}
	
	/**
	 * 保存项目跟进信息
	 */
	@RequestMapping(value = "saveLog")
    public String saveLog(ProjectLog projectLog, Model model, RedirectAttributes redirectAttributes) throws Exception{
//        if (!beanValidator(model, projectLog)){
//            return form(projectLog, model);
//        }
        if(!projectLog.getIsNewRecord()){//编辑表单保存
            ProjectLog t = projectLogService.get(projectLog.getId());//从数据库取出记录的值
            MyBeanUtils.copyBeanNotNull2Bean(projectLog, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
            projectLogService.save(t);//保存
        }else{//新增表单保存
            projectLogService.save(projectLog);//保存
        }
        addMessage(redirectAttributes, "保存项目日志成功");
        return "redirect:"+Global.getAdminPath()+"/project/project/?repage";
    }

}