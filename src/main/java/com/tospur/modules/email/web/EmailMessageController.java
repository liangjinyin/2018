package com.tospur.modules.email.web;

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
import com.tospur.common.mail.MailSendUtils;
import com.tospur.common.persistence.Page;
import com.tospur.common.utils.DateUtils;
import com.tospur.common.utils.MyBeanUtils;
import com.tospur.common.utils.StringUtils;
import com.tospur.common.utils.excel.ExportExcel;
import com.tospur.common.utils.excel.ImportExcel;
import com.tospur.common.web.BaseController;
import com.tospur.modules.email.entity.EmailMessage;
import com.tospur.modules.email.service.EmailMessageService;

/**
 * emailController
 * @author kiss
 * @version 2017-05-19
 */
@Controller
@RequestMapping(value = "${adminPath}/email/emailMessage")
public class EmailMessageController extends BaseController {

	@Autowired
	private EmailMessageService emailMessageService;
	
	@ModelAttribute
	public EmailMessage get(@RequestParam(required=false) String id) {
		EmailMessage entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = emailMessageService.get(id);
		}
		if (entity == null){
			entity = new EmailMessage();
		}
		return entity;
	}
	
	/**
	 * email列表页面
	 */
	@RequiresPermissions("email:emailMessage:list")
	@RequestMapping(value = {"list", ""})
	public String list(EmailMessage emailMessage, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<EmailMessage> page = emailMessageService.findPage(new Page<EmailMessage>(request, response), emailMessage); 
		model.addAttribute("page", page);
		return "modules/email/emailMessageList";
	}

	/**
     * email列表页面
     */
    @RequiresPermissions("email:emailMessage:list")
    @RequestMapping(value =  "send")
    public String send(String id , RedirectAttributes redirectAttributes) {
        EmailMessage  entity = emailMessageService.get(id);
        if(entity!=null){
            boolean flag=MailSendUtils.sentEmail(entity.getReceiveNum(),
                    entity.getCopytoNum(),
                    entity.getMessageTitle(),
                    entity.getMessageContent());
            if(flag){
                addMessage(redirectAttributes, "发送email成功！");
            }else{
                addMessage(redirectAttributes, "发送email失败！");
            }
        }else{
            addMessage(redirectAttributes, "邮件记录未找到！");
        }
        return "redirect:"+Global.getAdminPath()+"/email/emailMessage/?repage";
    }
	/**
	 * 查看，增加，编辑email表单页面
	 */
	@RequiresPermissions(value={"email:emailMessage:view","email:emailMessage:add","email:emailMessage:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String form(EmailMessage emailMessage, Model model) {
		model.addAttribute("emailMessage", emailMessage);
		return "modules/email/emailMessageForm";
	}

	/**
	 * 保存email
	 */
	@RequiresPermissions(value={"email:emailMessage:add","email:emailMessage:edit"},logical=Logical.OR)
	@RequestMapping(value = "save")
	public String save(EmailMessage emailMessage, Model model, RedirectAttributes redirectAttributes) throws Exception{
		if (!beanValidator(model, emailMessage)){
			return form(emailMessage, model);
		}
		if(!emailMessage.getIsNewRecord()){//编辑表单保存
			EmailMessage t = emailMessageService.get(emailMessage.getId());//从数据库取出记录的值
			MyBeanUtils.copyBeanNotNull2Bean(emailMessage, t);//将编辑表单中的非NULL值覆盖数据库记录中的值
			emailMessageService.save(t);//保存
		}else{//新增表单保存
			emailMessageService.save(emailMessage);//保存
		}
		addMessage(redirectAttributes, "保存email成功");
		return "redirect:"+Global.getAdminPath()+"/email/emailMessage/?repage";
	}
	
	/**
	 * 删除email
	 */
	@RequiresPermissions("email:emailMessage:del")
	@RequestMapping(value = "delete")
	public String delete(EmailMessage emailMessage, RedirectAttributes redirectAttributes) {
		emailMessageService.delete(emailMessage);
		addMessage(redirectAttributes, "删除email成功");
		return "redirect:"+Global.getAdminPath()+"/email/emailMessage/?repage";
	}
	
	/**
	 * 批量删除email
	 */
	@RequiresPermissions("email:emailMessage:del")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(String ids, RedirectAttributes redirectAttributes) {
		String idArray[] =ids.split(",");
		for(String id : idArray){
			emailMessageService.delete(emailMessageService.get(id));
		}
		addMessage(redirectAttributes, "删除email成功");
		return "redirect:"+Global.getAdminPath()+"/email/emailMessage/?repage";
	}
	
	/**
	 * 导出excel文件
	 */
	@RequiresPermissions("email:emailMessage:export")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(EmailMessage emailMessage, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "email"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<EmailMessage> page = emailMessageService.findPage(new Page<EmailMessage>(request, response, -1), emailMessage);
    		new ExportExcel("email", EmailMessage.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出email记录失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/email/emailMessage/?repage";
    }

	/**
	 * 导入Excel数据

	 */
	@RequiresPermissions("email:emailMessage:import")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<EmailMessage> list = ei.getDataList(EmailMessage.class);
			for (EmailMessage emailMessage : list){
				try{
					emailMessageService.save(emailMessage);
					successNum++;
				}catch(ConstraintViolationException ex){
					failureNum++;
				}catch (Exception ex) {
					failureNum++;
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条email记录。");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条email记录"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入email失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/email/emailMessage/?repage";
    }
	
	/**
	 * 下载导入email数据模板
	 */
	@RequiresPermissions("email:emailMessage:import")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "email数据导入模板.xlsx";
    		List<EmailMessage> list = Lists.newArrayList(); 
    		new ExportExcel("email数据", EmailMessage.class, 1).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/email/emailMessage/?repage";
    }
	
	
	

}